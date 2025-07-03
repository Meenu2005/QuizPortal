using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace QuizPortal
{
    public partial class Teachers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Email"] == null)
            {
                Response.Redirect("Default.aspx"); // user not logged in
                return;
            }

            if (!IsPostBack)
            {
                LoadTeacherDetails();
                LoadPreviousQuizzes();
                LoadStudentResults();
            }
        }

        private void LoadTeacherDetails()
        {
            string email = Session["Email"].ToString();
            string cs = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT Name, Password, Role, Class, Section FROM Users WHERE Email = @E", con);
                cmd.Parameters.AddWithValue("@E", email);

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    txtName.Text = rdr["Name"].ToString();
                    txtPassword.Text = rdr["Password"].ToString();
                    txtRole.Text = rdr["Role"].ToString();

                    string classVal = rdr["Class"].ToString();
                    switch (classVal)
                    {
                        case "1": txtclass.Text = "1st"; break;
                        case "2": txtclass.Text = "2nd"; break;
                        case "3": txtclass.Text = "3rd"; break;
                        case "4": txtclass.Text = "4th"; break;
                        case "5": txtclass.Text = "5th"; break;
                        case "6": txtclass.Text = "6th"; break;
                        case "7": txtclass.Text = "7th"; break;
                        case "8": txtclass.Text = "8th"; break;
                        default: txtclass.Text = classVal; break;
                    }

                    section.Text = rdr["Section"].ToString();
                    txName.Text = rdr["Name"].ToString(); // for corner display
                }

            }
        }


    

    protected void btnEdit_Click(object sender, EventArgs e)
        {
            txtName.ReadOnly = false;
            txtPassword.ReadOnly = false;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string email = Session["Email"].ToString();
            string cs = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Users SET Name=@N, Password=@P WHERE Email=@E", con);
                cmd.Parameters.AddWithValue("@N", txtName.Text);
                cmd.Parameters.AddWithValue("@P", txtPassword.Text);
                cmd.Parameters.AddWithValue("@E", email);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            txtName.ReadOnly = true;
            txtPassword.ReadOnly = true;
        }

        protected void btnAddQuestion_Click(object sender, EventArgs e)
        {
           
            questionPanel.Visible = true;
        }

        protected void btnSaveQuestion_Click(object sender, EventArgs e)
        {
            DataTable dt = Session["QuizDraft"] as DataTable ?? CreateQuizDraftTable();
            DataRow row = dt.NewRow();
            row["QuestionText"] = txtQuestion.Text;
            row["OptionA"] = txtOption1.Text;
            row["OptionB"] = txtOption2.Text;
            row["OptionC"] = txtOption3.Text;
            row["OptionD"] = txtOption4.Text;
            row["CorrectOption"] = ddlCorrectOption.SelectedValue;
            row["QuizName"] = "Quiz " + DateTime.Now.ToString("yyyyMMddHHmmss"); // You can replace this with a textbox if needed
            dt.Rows.Add(row);
            Session["QuizDraft"] = dt;

            txtQuestion.Text = txtOption1.Text = txtOption2.Text = txtOption3.Text = txtOption4.Text = "";
        }

        protected void btnDoneQuiz_Click(object sender, EventArgs e)
        {
            DataTable dt = Session["QuizDraft"] as DataTable;
            if (dt == null || dt.Rows.Count == 0) return;

            string quizName = txtQuizName.Text.Trim(); // ✅ store quiz name
            if (string.IsNullOrEmpty(quizName)) return;

            string cs = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                foreach (DataRow row in dt.Rows)
                {
                    SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Questions 
                (QuizName, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption, CreatedBy, QuizDate)
                VALUES 
                (@QuizName, @Q, @A, @B, @C, @D, @Correct, 
                (SELECT UserID FROM Users WHERE Email = @Email), GETDATE())", con);

                    cmd.Parameters.AddWithValue("@QuizName", quizName);
                    cmd.Parameters.AddWithValue("@Q", row["QuestionText"]);
                    cmd.Parameters.AddWithValue("@A", row["OptionA"]);
                    cmd.Parameters.AddWithValue("@B", row["OptionB"]);
                    cmd.Parameters.AddWithValue("@C", row["OptionC"]);
                    cmd.Parameters.AddWithValue("@D", row["OptionD"]);
                    cmd.Parameters.AddWithValue("@Correct", row["CorrectOption"]);
                    cmd.Parameters.AddWithValue("@Email", Session["Email"]);
                    cmd.ExecuteNonQuery();
                }
            }

            Session.Remove("QuizDraft");
            questionPanel.Visible = false;
            txtQuizName.Text = "";
            LoadPreviousQuizzes();
        }


        protected void btnNewQuiz_Click(object sender, EventArgs e)
        {
            Session.Remove("QuizDraft");
            txtQuizName.Text = "";
            txtQuestion.Text = txtOption1.Text = txtOption2.Text = txtOption3.Text = txtOption4.Text = "";
        }


        private DataTable CreateQuizDraftTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuizName");
            dt.Columns.Add("QuestionText");
            dt.Columns.Add("OptionA");
            dt.Columns.Add("OptionB");
            dt.Columns.Add("OptionC");
            dt.Columns.Add("OptionD");
          
            dt.Columns.Add("CorrectOption");
            return dt;
        }
        protected void btnNextQuestion_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtQuizName.Text))
            {
                // Optional: alert for missing quiz name
                return;
            }

            DataTable dt = Session["QuizDraft"] as DataTable ?? CreateQuizDraftTable();

            DataRow row = dt.NewRow();
            row["QuizName"] = txtQuizName.Text.Trim();
            row["QuestionText"] = txtQuestion.Text.Trim();
            row["OptionA"] = txtOption1.Text.Trim();
            row["OptionB"] = txtOption2.Text.Trim();
            row["OptionC"] = txtOption3.Text.Trim();
            row["OptionD"] = txtOption4.Text.Trim();
           
            row["CorrectOption"] = ddlCorrectOption.SelectedValue;

            dt.Rows.Add(row);
            Session["QuizDraft"] = dt;

            // Clear fields for next question
            txtQuestion.Text = txtOption1.Text = txtOption2.Text = txtOption3.Text = txtOption4.Text = "";
            ddlCorrectOption.Text = "correct option";
        }

        private void LoadPreviousQuizzes()
        {
            string cs = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT QuizName, COUNT(*) AS QuestionCount, MAX(QuizDate) AS CreatedDate
                    FROM Questions
                    WHERE CreatedBy = (SELECT UserID FROM Users WHERE Email = @Email)
                    GROUP BY QuizName", con);

                cmd.Parameters.AddWithValue("@Email", Session["Email"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvQuizzes.DataSource = dt;
                gvQuizzes.DataBind();
            }
        }
        private void LoadStudentResults()
        {
            string cs = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(@"
            SELECT 
                U.Name AS StudentName,
                CASE WHEN S.Score IS NULL THEN 'Not Attempted' ELSE 'Attempted' END AS Attempted,
                S.QuizName,
                ISNULL(S.Score, 0) AS Score,
                TQ.TotalQuestions,
                CAST(ROUND((CAST(ISNULL(S.Score, 0) AS FLOAT) / NULLIF(TQ.TotalQuestions, 0)) * 100, 0) AS INT) AS Percentage
            FROM Users U
            LEFT JOIN Scores S ON U.UserID = S.UserID
            LEFT JOIN (
                SELECT QuizName, COUNT(*) AS TotalQuestions 
                FROM Questions 
                GROUP BY QuizName
            ) TQ ON TQ.QuizName = S.QuizName
            WHERE U.Role = 'Student' 
              AND U.Class = (SELECT Class FROM Users WHERE Email=@E)
              AND U.Section = (SELECT Section FROM Users WHERE Email=@E)", con);

                cmd.Parameters.AddWithValue("@E", Session["Email"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                foreach (DataColumn col in dt.Columns)
                {
                    System.Diagnostics.Debug.WriteLine(col.ColumnName);
                }


                gvResults.DataSource = dt;
                gvResults.DataBind();
            }
        }


    }
}
