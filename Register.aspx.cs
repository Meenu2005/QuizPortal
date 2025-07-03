using System;
using System.Data.SqlClient;
using System.Configuration;

namespace QuizPortal
{
    public partial class Register : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string cs = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email = @Email", con);
                    checkCmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                    con.Open();
                    int exists = (int)checkCmd.ExecuteScalar();

                    if (exists > 0)
                    {
                        lblMessage.Text = "⚠️ You are already registered!";
                        return;
                    }

                    SqlCommand cmd = new SqlCommand(@"INSERT INTO Users (Name, Email, Password, Role, Class, Section, Enrollment)
                                              VALUES (@Name, @Email, @Password, @Role, @Class, @Section, @Enrollment)", con);
                    cmd.Parameters.AddWithValue("@Name", txtName.Text);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                    cmd.Parameters.AddWithValue("@Role", ddlRole.SelectedValue);
                    cmd.Parameters.AddWithValue("@Class", ddlClass.SelectedValue);
                    cmd.Parameters.AddWithValue("@Section", ddlSection.SelectedValue);
                    cmd.Parameters.AddWithValue("@Enrollment", txtEnrollment.Text);

                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "✅ Registration successful!";
                    Response.Redirect("Default.aspx");
                }
            }
        }

    }
}
