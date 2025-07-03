<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="QuizPortal.Students" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="styles.css" />
    <style>
        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
            font-family:'Courier New','Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        }
        .textbox{
            margin:2px;
            padding:2px;
        }
        .card h3 {
            margin-top: 0;
            cursor: pointer;
        }
        .quiz-line {
            border-bottom: 1px solid #ddd;
            padding: 8px 0;
        }
        .corner {
            float: right;
            color: white;
            margin-right: 15px;
            font-size: 16px;
        }
        .wrapper {
  position: absolute;
  top: 10%;
  left: 40%;
  width: 300px;
  height: 500px;
  perspective: 1200px;
}

.container {
  position: absolute;
  top: 0%;
  width: 100%;
  height: 105%;
  transition: .5s all ease;
  transform: rotateX(60deg) scale(0.7);
  perspective: 1800px;
  box-shadow: 0px 20px 50px #555;
  animation: entry 1s linear 1;
}

#c0 {
  position: absolute;
  top: 0%;
  width: 100%;
  height: 100%;
  background: linear-gradient(to bottom, #eba65b 30%,#632600 100%);
  z-index: 300;
  box-shadow: 0px 20px 100px #555;
}
        div#panelQuizzes {
            line-height: 1;
        }

#c1 {
  background: linear-gradient(to bottom, #44a99e 30%, #7bd190 100%);
  box-shadow: 0px 20px 100px #555;
  left: 100%;
  z-index: 0;
}

#c2 {
  left: -100%;
  z-index: 0;
  background: linear-gradient(to bottom, #59476f 30%, #7b88d1 100%);
  box-shadow: 0px 20px 100px #555;
}

.container:hover {
  cursor: pointer;
  transform: rotate(0deg) scale(1) translateY(35px);
  transition: .5s all ease;
  z-index: 500;
}
        .footer-img {
            width: 100%;
            height: 170px;
            position: fixed;
            bottom: 0px;
            left: 0px;
            padding: 0;
            margin-bottom: 0px;
        }

    ItemTemplate{
        margin:3px;
        line-height:10px;
              }
    lblStatus{
        padding:3px;
    }
/*.image {
  position: absolute;
  top: 0%;
  left: 0%;
  width: 100%;
  height: 45%;
  background: linear-gradient(to top, #eba65b 30%, #d99267 100%);
}*/
    </style>
    <script>
        function toggle(id) {
            var el = document.getElementById(id);
            el.style.display = el.style.display === "none" ? "block" : "none";
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            Student Portal
            <span class="corner" runat="server" id="studentName">[Student Name]</span>
        </div>

        <div class="wrapper">
            <!-- Section 1: Available Quizzes -->
             <div class="container" id="c0">
            <div class="card">
                <h3 onclick="toggle('panelQuizzes')">Available Quizzes</h3>
                <div id="panelQuizzes">
         <asp:Repeater ID="rptQuizzes" runat="server" OnItemCommand="rptQuizzes_ItemCommand">
    <ItemTemplate>
        <div class="quiz-entry">
            <strong><%# Eval("QuizName") %></strong>
            <%# Eval("Status").ToString() == "Attempted" ? " (Score: " + Eval("Score") + ")" : "" %>
            <asp:Button ID="btnAttempt" runat="server" 
                Text='<%# Eval("Status").ToString() == "Attempted" ? "Already Attempted" : "Attempt" %>' 
                CommandName="Attempt" 
                CommandArgument='<%# Eval("QuizName").ToString() %>' 
                Enabled='<%# Eval("Status").ToString() != "Attempted" %>' 
                CssClass="button-primary" />
        </div>
    </ItemTemplate>
</asp:Repeater>






                </div>
            </div>
                 </div>
            <!-- Section 2: Total Score -->
             <div class="container" id="c1">
            <div class="card">
                <h3 onclick="toggle('panelScore')">Total Score</h3>
                <div id="panelScore">
                    <asp:Label ID="lblTotalScore" runat="server" Font-Size="Large" />
                </div>
            </div>
                 </div>

            <!-- Section 3: Edit Account -->
             <div class="container" id="c2">
            <div class="card">
                <h3 onclick="toggle('panelAccount')">Your Account</h3>
                <div id="panelAccount">
                    <asp:TextBox ID="txtName" runat="server" CssClass="textbox" placeholder="Name" /><br />
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="textbox" TextMode="Password" placeholder="Password" /><br />
                    <asp:TextBox ID="txtRole" runat="server" CssClass="textbox" ReadOnly="true" placeholder="Role" /><br />
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" CssClass="button-primary" />
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="button-primary" />
                </div>
            </div>
        </div>
            </div>


        <img src="—Pngtree—abstract purple wave vector_14869341.png" class="footer-img" />
    </form>
</body>
</html>
