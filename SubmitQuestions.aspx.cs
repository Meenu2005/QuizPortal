using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuizPortal
{
    public partial class SubmitQuestions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Initialization logic if required
        }

        protected void btnSubmitQuestion_Click(object sender, EventArgs e)
        {
            string query = "INSERT INTO Questions (QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) VALUES (@question, @optionA, @optionB, @optionC, @optionD, @correctAnswer)";

            SqlConnection conn = null;
            try
            {
                conn = new SqlConnection(ConfigurationManager.ConnectionStrings["QuizDBConnection"].ConnectionString);
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@question", txtQuestion.Text);
                    cmd.Parameters.AddWithValue("@optionA", txtOptionA.Text);
                    cmd.Parameters.AddWithValue("@optionB", txtOptionB.Text);
                    cmd.Parameters.AddWithValue("@optionC", txtOptionC.Text);
                    cmd.Parameters.AddWithValue("@optionD", txtOptionD.Text);
                    cmd.Parameters.AddWithValue("@correctAnswer", ddlCorrectAnswer.SelectedValue);

                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Question submitted successfully!');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
            finally
            {
                if (conn != null) conn.Close();
            }
        }

    }
}
