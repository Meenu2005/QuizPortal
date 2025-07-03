using System.Configuration;
using System.Data.SqlClient;
using System;



namespace QuizPortal
{
    public partial class Default : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string cs = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT Role FROM Users WHERE LTRIM(RTRIM(Email)) = @Email", con);
                cmd.Parameters.AddWithValue("@Email", email);

                con.Open();
                object role = cmd.ExecuteScalar();

                if (role != null)
                {
                    Session["Email"] = email;
                    if (role.ToString() == "Teacher")
                        Response.Redirect("Teachers.aspx");
                    else
                        Response.Redirect("Students.aspx");
                }
                else
                {
                    lblLoginError.Text = "❌ Email not found. Please register first.";
                }
            }
        }


        //protected void btnRegister_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("Register.aspx");
        //}

    }
}
