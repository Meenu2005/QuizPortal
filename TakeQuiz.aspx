<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TakeQuiz.aspx.cs" Inherits="QuizPortal.TakeQuiz" %>

<!DOCTYPE html>
<html>
<head>
      <link rel="stylesheet" href="styles.css" />
    <title>Take Quiz</title>
    <style>
        .quiz-container {
            max-width: 600px;
            margin: 60px auto;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0px 0px 10px #aaa;
            font-family: sans-serif;
        }

        .button-primary {
            padding: 10px 25px;
            margin-top: 20px;
            background-color: #6A42C2;
            color: white;
            border: none;
            border-radius: 5px;
        }

        .button-primary:hover {
            background-color: #430A5D;
        }

        .question {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="quiz-container">
            <asp:Label ID="lblQuestion" runat="server" CssClass="question" />
            <br />
            <asp:RadioButtonList ID="rblOptions" runat="server" RepeatDirection="Vertical" />
            <br />
            <asp:Button ID="btnNext" runat="server" Text="Next Question" CssClass="button-primary" OnClick="btnNext_Click" />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit Quiz" CssClass="button-primary" OnClick="btnSubmit_Click" Visible="false" />
        </div>
    </form>
</body>
</html>
