using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace QuizPortal
{
    public partial class TakeQuiz : System.Web.UI.Page
    {
        DataTable QuizTable
        {
            get { return Session["QuizTable"] as DataTable; }
            set { Session["QuizTable"] = value; }
        }

        int CurrentIndex
        {
            get { return (int)(Session["CurrentIndex"] ?? 0); }
            set { Session["CurrentIndex"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Email"] == null || string.IsNullOrEmpty(Request.QueryString["quiz"]))
                {
                    Response.Redirect("Students.aspx");
                    return;
                }

                LoadQuiz();
                ShowQuestion();
            }
        }

        private void LoadQuiz()
        {
            string quizName = Request.QueryString["quiz"];
            string cs = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Questions WHERE QuizName = @quiz", con);
                cmd.Parameters.AddWithValue("@quiz", quizName);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // ✅ Add column for selected option
                dt.Columns.Add("SelectedOption", typeof(string));
                QuizTable = dt;
                CurrentIndex = 0;
            }
        }

        private void ShowQuestion()
        {
            DataRow row = QuizTable.Rows[CurrentIndex];

            lblQuestion.Text = row["QuestionText"].ToString();

            rblOptions.Items.Clear(); // remove old options if reloading

            rblOptions.Items.Add(new ListItem(row["OptionA"].ToString(), "A"));
            rblOptions.Items.Add(new ListItem(row["OptionB"].ToString(), "B"));
            rblOptions.Items.Add(new ListItem(row["OptionC"].ToString(), "C"));
            rblOptions.Items.Add(new ListItem(row["OptionD"].ToString(), "D"));

            rblOptions.ClearSelection(); // 🟡 ADD HERE to clear previous selection

            string selected = row["SelectedOption"]?.ToString();
            if (!string.IsNullOrEmpty(selected) && rblOptions.Items.FindByValue(selected) != null)
            {
                rblOptions.SelectedValue = selected;
            }
        



        btnNext.Visible = CurrentIndex < QuizTable.Rows.Count - 1;
            btnSubmit.Visible = CurrentIndex == QuizTable.Rows.Count - 1;
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            SaveAnswer();
            CurrentIndex++;
            ShowQuestion();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SaveAnswer(); // Save final answer before submitting

            int score = 0;
            string email = Session["Email"].ToString();
            string quizName = Request.QueryString["quiz"];
            string cs = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // Get Student (UserID)
                SqlCommand getUser = new SqlCommand("SELECT UserID FROM Users WHERE Email = @E", con);
                getUser.Parameters.AddWithValue("@E", email);
                int userId = (int)getUser.ExecuteScalar();

                // Loop through each question and check + store answer
                foreach (DataRow row in QuizTable.Rows)
                {
                    string correct = row["CorrectOption"].ToString();
                    string selected = row["SelectedOption"]?.ToString();
                    int questionId = Convert.ToInt32(row["QuestionID"]);

                    if (correct == selected)
                        score++;

                    // ✅ Check if this answer is already saved
                    SqlCommand checkExist = new SqlCommand(@"
                SELECT COUNT(*) FROM StudentAnswers 
                WHERE StudentID = @StudentID AND QuestionID = @QuestionID", con);
                    checkExist.Parameters.AddWithValue("@StudentID", userId);
                    checkExist.Parameters.AddWithValue("@QuestionID", questionId);
                    int exists = (int)checkExist.ExecuteScalar();

                    if (exists == 0)
                    {
                        SqlCommand saveAns = new SqlCommand(@"
                    INSERT INTO StudentAnswers (StudentID, QuestionID, SelectedAnswer)
                    VALUES (@StudentID, @QuestionID, @SelectedAnswer)", con);
                        saveAns.Parameters.AddWithValue("@StudentID", userId);
                        saveAns.Parameters.AddWithValue("@QuestionID", questionId);
                        saveAns.Parameters.AddWithValue("@SelectedAnswer", selected ?? (object)DBNull.Value);
                        saveAns.ExecuteNonQuery();
                    }
                }

                // ✅ Get QuizID for Scores table
                SqlCommand getQuizId = new SqlCommand("SELECT TOP 1 QuestionID FROM Questions WHERE QuizName = @QN", con);
                getQuizId.Parameters.AddWithValue("@QN", quizName);
                int quizId = (int)getQuizId.ExecuteScalar();

                // ✅ Check if score already saved
                SqlCommand checkScore = new SqlCommand(@"
            SELECT COUNT(*) FROM Scores 
            WHERE UserID = @UserID AND QuizID = @QuizID", con);
                checkScore.Parameters.AddWithValue("@UserID", userId);
                checkScore.Parameters.AddWithValue("@QuizID", quizId);
                int scoreExists = (int)checkScore.ExecuteScalar();

                if (scoreExists == 0)
                {
                    SqlCommand saveScore = new SqlCommand(@"
                INSERT INTO Scores (UserID, QuizID, Score, QuizDate, QuizName)
                VALUES (@UserID, @QuizID, @Score, GETDATE(), @QuizName)", con);

                    saveScore.Parameters.AddWithValue("@UserID", userId);
                    saveScore.Parameters.AddWithValue("@QuizID", quizId);
                    saveScore.Parameters.AddWithValue("@Score", score);
                    saveScore.Parameters.AddWithValue("@QuizName", quizName);
                    saveScore.ExecuteNonQuery();
                }
            }

            // Cleanup and redirect
            Session.Remove("QuizTable");
            Session.Remove("CurrentIndex");
            Response.Redirect("Students.aspx");
        }


        private void SaveAnswer()
        {
            if (QuizTable != null && CurrentIndex < QuizTable.Rows.Count)
            {
                QuizTable.Rows[CurrentIndex]["SelectedOption"] = rblOptions.SelectedValue;
            }
        }
    }
}
