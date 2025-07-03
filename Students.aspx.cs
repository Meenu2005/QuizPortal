using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System;

namespace QuizPortal
{
    public partial class Students: System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Email"] == null)
            {
                Response.Redirect("Default.aspx");
            }

            if (!IsPostBack)
            {
                LoadStudentName();
                LoadAvailableQuizzes();
                LoadTotalScore();
                LoadStudentAccount();
                string quizName = Request.QueryString["quiz"];
            }
        }


        private void LoadStudentName()
        {
            string email = Session["Email"].ToString();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT Name FROM Users WHERE Email=@Email", con);
                cmd.Parameters.AddWithValue("@Email", email);
                con.Open();
                object name = cmd.ExecuteScalar();
                studentName.InnerText = name?.ToString();
            }
        }

        private void LoadAvailableQuizzes()
        {
            string email = Session["Email"].ToString();
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(@"
            SELECT 
                Q.QuizName,
                ISNULL(S.Score, 0) AS Score,
                CASE WHEN S.Score IS NOT NULL THEN 'Attempted' ELSE 'Not Attempted' END AS Status,
                (SELECT COUNT(*) FROM Questions WHERE QuizName = Q.QuizName) AS Total
            FROM Questions Q
            JOIN Users T ON Q.CreatedBy = T.UserID
            JOIN Users U ON U.Email = @Email
            LEFT JOIN Scores S ON S.QuizName = Q.QuizName AND S.UserID = U.UserID
            WHERE T.Class = U.Class AND T.Section = U.Section
            GROUP BY Q.QuizName, S.Score", con);

                cmd.Parameters.AddWithValue("@Email", email);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                rptQuizzes.DataSource = dt;
                rptQuizzes.DataBind();
            }
        }


        protected void rptQuizzes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Attempt")
            {
                string quizName = e.CommandArgument.ToString();
                Session["CurrentQuizName"] = quizName;

                // Optional: redirect with query string too
                Response.Redirect("TakeQuiz.aspx?quiz=" + Server.UrlEncode(quizName));
            }
        }




        //protected void btnAttempt_Click(object sender, EventArgs e)
        //{
        //    Button btn = (Button)sender;
        //    int quizID = int.Parse(btn.CommandArgument);

        //    Session["CurrentQuizID"] = quizID;
        //    Response.Redirect("TakeQuiz.aspx");
        //}

        private void LoadTotalScore()
        {
            string email = Session["Email"].ToString();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT SUM(Score) FROM Scores WHERE UserID = (SELECT UserID FROM Users WHERE Email = @Email)", con);

                cmd.Parameters.AddWithValue("@Email", email);
                con.Open();
                object total = cmd.ExecuteScalar();
                lblTotalScore.Text = "Total Score: " + (total != DBNull.Value ? total.ToString() : "0");
            }
        }

        private void LoadStudentAccount()
        {
            string email = Session["Email"].ToString();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT Name, Password, Role FROM Users WHERE Email = @Email", con);
                cmd.Parameters.AddWithValue("@Email", email);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    txtName.Text = rdr["Name"].ToString();
                    txtPassword.Text = rdr["Password"].ToString();
                    txtRole.Text = rdr["Role"].ToString();
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
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Users SET Name = @N, Password = @P WHERE Email = @E", con);
                cmd.Parameters.AddWithValue("@N", txtName.Text);
                cmd.Parameters.AddWithValue("@P", txtPassword.Text);
                cmd.Parameters.AddWithValue("@E", email);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            txtName.ReadOnly = true;
            txtPassword.ReadOnly = true;
        }
    }
}
