<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddQuestionss.aspx.cs" Inherits="QuizPortal.AddQuestionss" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Add Question</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <form runat="server">
        <h1>Add Quiz Question</h1>
        <asp:Button runat="server" Text="Button"></asp:Button>
        <asp:TextBox ID="txtQuestion" runat="server" placeholder="Enter Question" />
        <asp:TextBox ID="txtOptionA" runat="server" placeholder="Option A" AccessKey=" txtOptionA"></asp:TextBox> 
        <asp:TextBox ID="txtOptionB" runat="server" placeholder="Option B" />
        <asp:TextBox ID="txtOptionC" runat="server" placeholder="Option C" />
        <asp:TextBox ID="txtOptionD" runat="server" placeholder="Option D" />
        <asp:DropDownList ID="ddlCorrectAnswer" runat="server">
            <asp:ListItem Text="A" Value="A" />
            <asp:ListItem Text="B" Value="B" />
            <asp:ListItem Text="C" Value="C" />
            <asp:ListItem Text="D" Value="D" />
        </asp:DropDownList>
        <asp:Button ID="btnAddQuestion" runat="server" Text="Add Question" OnClick="btnAddQuestion_Click" />
    </form>
</body>
</html>
