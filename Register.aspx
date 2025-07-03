<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="QuizPortal.Register" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Quiz Portal</title>
    <link rel="stylesheet" href="styles.css" />
    <script runat="server">
        protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtEnrollment.Visible = ddlRole.SelectedValue == "Student";
            lblEnrollment.Visible = ddlRole.SelectedValue == "Student";
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
              <header class="header">
<h1>Quiz </h1>
</header>
        <div class="container">
            <h2>Register</h2>

            <div class="textbox">
                <asp:TextBox ID="txtName" runat="server" placeholder="Full Name" />
                <asp:RequiredFieldValidator ControlToValidate="txtName" runat="server" CssClass="error" ErrorMessage="* Required" />
            </div>
            <div class="textbox">
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" />
                <asp:RequiredFieldValidator ControlToValidate="txtEmail" runat="server" CssClass="error" ErrorMessage="* Required" />
            </div>
            <div class="textbox">
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" />
                <asp:RequiredFieldValidator ControlToValidate="txtPassword" runat="server" CssClass="error" ErrorMessage="* Required" />
            </div>
            <div class="textbox">
                <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" placeholder="Confirm Password" />
                <asp:CompareValidator ControlToValidate="txtConfirm" ControlToCompare="txtPassword" runat="server" CssClass="error" ErrorMessage="Passwords do not match." />
            </div>
            <div class="textbox">
                 <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="false">
                        <asp:ListItem Value="1st" />
                        <asp:ListItem Value="2nd" />
                       <asp:ListItem Value="3rd" />
                       <asp:ListItem Value="4th" />
                       <asp:ListItem Value="5th" />
                       <asp:ListItem Value="6th" />
                       <asp:ListItem Value="7th" />
                       <asp:ListItem Value="8th" />
                    
 </asp:DropDownList>
                 <asp:RequiredFieldValidator ControlToValidate="ddlClass" runat="server" CssClass="error" ErrorMessage="* Required" />
                
            </div>
            <div class="textbox">
                 <asp:DropDownList ID="ddlSection" runat="server" AutoPostBack="false">
                      <asp:ListItem Value="A" />
                      <asp:ListItem Value="B" />
                      <asp:ListItem Value="C" />
                      <asp:ListItem Value="D" />
                      <asp:ListItem Value="E" />
                      <asp:ListItem Value="F" />
 </asp:DropDownList>
             
            </div>
            <div class="textbox">
                <asp:DropDownList ID="ddlRole" runat="server" AutoPostBack="false" OnSelectedIndexChanged="ddlRole_SelectedIndexChanged">
                    <asp:ListItem Value="Student" />
                    <asp:ListItem Value="Teacher" />
                </asp:DropDownList>
            </div>
            <div class="textbox">
                <asp:Label ID="lblEnrollment" runat="server" Text="Enrollment ID" Visible="false" />
                <asp:TextBox ID="txtEnrollment" runat="server" Visible="false" placeholder="Enrollment ID" />
            </div>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label><br />

           <asp:Button ID="btnRegister" runat="server" Text="Register"
    CssClass="button-primary"
    OnClick="btnRegister_Click"
    CausesValidation="true" />

<div class="separator"></div>

<asp:Button ID="btnBackLogin" runat="server" Text="Login"
    PostBackUrl="Default.aspx"
    CssClass="button-primary"
     CausesValidation="False" 
    />

        </div>
        <img src="—Pngtree—abstract purple wave vector_14869341.png" class="footer-img" />
    </form>
</body>
</html>
