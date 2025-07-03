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
    public partial class AddQuestionss : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Page initialization
                Page_Load(sender, e);
            }
        }

        protected void btnAddQuestion_Click(object sender, EventArgs e)
        {
            string query = "INSERT INTO Questions (QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer, TeacherID) VALUES (@qtext, @a, @b, @c, @d, @correct, @teacher)";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["QuizDBConnection"].ConnectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@qtext", txtQuestion.Text);
                    cmd.Parameters.AddWithValue("@a", txtOptionA.Text);
                    cmd.Parameters.AddWithValue("@b", txtOptionB.Text);
                    cmd.Parameters.AddWithValue("@c", txtOptionC.Text);
                    cmd.Parameters.AddWithValue("@d", txtOptionD.Text);
                    cmd.Parameters.AddWithValue("@correct", ddlCorrectAnswer.SelectedValue);
                    cmd.Parameters.AddWithValue("@teacher", Session["TeacherID"]);

                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}