<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubmitQuestions.aspx.cs" Inherits="QuizPortal.SubmitQuestions" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Question</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <form runat="server">
        <header>
            <h1>Submit a New Quiz Question</h1>
        </header>
        <main>
            <label for="txtQuestion">Question:</label>
            <asp:TextBox ID="txtQuestion" runat="server" placeholder="Enter Question" CssClass="input-box" />

            <label for="txtOptionA">Option A:</label>
            <asp:TextBox ID="txtOptionA" runat="server" placeholder="Option A" CssClass="input-box" />
            
            <label for="txtOptionB">Option B:</label>
            <asp:TextBox ID="txtOptionB" runat="server" placeholder="Option B" CssClass="input-box" />

            <label for="txtOptionC">Option C:</label>
            <asp:TextBox ID="txtOptionC" runat="server" placeholder="Option C" CssClass="input-box" />

            <label for="txtOptionD">Option D:</label>
            <asp:TextBox ID="txtOptionD" runat="server" placeholder="Option D" CssClass="input-box" />

            <label for="ddlCorrectAnswer">Correct Answer:</label>
            <asp:DropDownList ID="ddlCorrectAnswer" runat="server" CssClass="dropdown">
                <asp:ListItem Text="A" Value="A" />
                <asp:ListItem Text="B" Value="B" />
                <asp:ListItem Text="C" Value="C" />
                <asp:ListItem Text="D" Value="D" />
            </asp:DropDownList>

            <asp:Button ID="btnSubmitQuestion" runat="server" Text="Submit Question" CssClass="btn-primary" OnClick="btnSubmitQuestion_Click" />
        </main>
    </form>
</body>
</html>
