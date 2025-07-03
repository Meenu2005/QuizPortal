<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="QuizPortal.Default" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Quiz Portal</title>
    <link rel="stylesheet" href="styles.css" />
    <link rel="icon" type="image/-ico" href="image(5).png"/>
</head>
<body>
    <form id="form1" runat="server">
        <header class="header">
<h1>Quiz Portal</h1>
</header>
        <div class="container">
            <h2>Login</h2>
            <div class="textbox">
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Email or Username"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="* Required" CssClass="error" Display="Dynamic" />
            </div>
            <div class="textbox">
                <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                    ErrorMessage="* Required" CssClass="error" Display="Dynamic" />
            </div>
            <asp:Label ID="lblMessage" runat="server" CssClass="error" /><br />
            <asp:Label ID="lblLoginError" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label><br />

          <asp:Button ID="btnLogin" runat="server" Text="Login"
    CssClass="button-primary"
    OnClick="btnLogin_Click"
    CausesValidation="true" />

<div class="separator"></div>

<asp:Button ID="btnRegister" runat="server" Text="Register"
    CssClass="button-primary" PostBackUrl="Register.aspx" CausesValidation="False" />


        </div>
        <img src="—Pngtree—abstract purple wave vector_14869341.png" class="footer-img" />
    </form>
</body>
</html>
