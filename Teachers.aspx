<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teachers.aspx.cs" Inherits="QuizPortal.Teachers" %>

<!DOCTYPE html>
<html>
     
<head>
     <link rel="stylesheet" href="styles.css" />
    <title>Teacher Dashboard</title>
   
    
    <style>
        body{
            margin:0 0 0 0;
            padding:0 0 0 0;
            text-align:center;
            justify-content:center;
        }
        .textbox{
            margin:2px;
            width:20vw;
            height:30px;
        }
      
        .form{
            margin:0 0 0 0;
  padding:0 0 0 0;  
  background-color:aquamarine;
        }

        @media (max-width: 768px) {
  .card {
    flex: 0 0 100%;
  }
}

        .bck{
/*            display:inline;*/
            margin-left:60px;
        }
       #btnBack{
/*           display :block;*/
            width: 100%;
 padding: 10px;
 background-color: #6A42C2;
 color: white;
 border: none;
 border-radius: 6px;
 cursor: pointer;
 transition: 0.3s;
 font-size: 16px;
 margin:10px;
       }

        .card.inactive {
            opacity: 0.4;
            pointer-events: none;
        }

        .card.active {
            opacity: 1;
            pointer-events: auto;
        }

        .panel {
            display: none;
            background-color:whitesmoke;
        }

        .panel.visible {
            display: block;
            width:50vw;
            height:40vh;
        }

        #btnBack {
            display: none;
            margin: 20px 0;
        }

       
.header {
/*    height:50%;*/
    color:white;
/*    padding: 0px 0;*/
    text-align: center;
    font-size: 28px;
    background: linear-gradient(132deg, #000000,lightgray, #430A5D,#563A9C,#8B5DFF,#ffffff);
    background-size: 400% 400%;
    animation: BackgroundGradient 15s ease infinite;
    margin-block-start:0;
    margin-block-end:4px;
}


        .corner {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 16px;
            
        }


        .footer-img {
            width: 100%;
            height: 40px;
            position: fixed;
/*            bottom: 0;*/
            left: 0;
        }
        /*new*/
            section {
                /*max-width:100vw;
            min-height: 100vh;
            background-color: rgb(2, 6, 23);
            text-align: center;*/
/*            padding: 5rem 2rem;*/
/*            display: flex;*/
            /*flex-direction: column;
            justify-content: center;*/
/*            position: relative;*/
/*            overflow: hidden;*/
            /*margin-top:0;*/
        }
        .grid {
            display: flex;
            grid-template-columns: repeat(2, 1fr);  
/*            gap: 4px;
            margin:5px;*/
            padding: 30px;
            justify-content:center;
            align-items:center;
            width:100%;
/*            height:500px;*/
/*            height:150vh;*/
            flex-wrap:wrap;
            background-color:floralwhite;
            line-height:0px;

        }

        @media (min-width: 640px) {
            .grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (min-width: 1024px) {
            .grid {
                grid-template-columns: repeat(2, 1fr);
            }
            section {
/*                padding: 5rem 0 0 0;*/
            }
        }

        .card {
            background-color: rgba(15, 23, 42, 0.5);
            backdrop-filter: blur(8px);
/*            padding: 10px 10px 10px 10px;*/
             transition: 0.3s ease;
            margin:0.5vw;
            position: relative;
            transform: translateY(30px);
            opacity: 0;
            animation: fadeInUp 0.6s ease forwards;
            width:40vw;
            height:230px;
/*             flex: 0 0 48%;*/
        }

        .card:nth-child(1) { animation-delay: 0.1s; }
        .card:nth-child(2) { animation-delay: 0.2s; }
        .card:nth-child(3) { animation-delay: 0.3s; }
        .card:nth-child(4) { animation-delay: 0.4s; }
        .card:nth-child(5) { animation-delay: 0.5s; }
        .card:nth-child(6) { animation-delay: 0.6s; }

        @keyframes fadeInUp {
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .card {
            transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        }

        .card:hover {
            transform: scale(1.02) translateY(-5px);
            box-shadow: 0 20px 40px -15px rgba(184, 216, 216, 0.3);
        }

        .card::before {
            content: '';
            position: absolute;
            inset: 0;
            transition: 0.8s cubic-bezier(0.34, 1.56, 0.64, 1);
            z-index: 0;
            background: linear-gradient(135deg, #8b5dff 0%, #543f88 100% 100%, #2c253b 70%);
            opacity: 0.9;
        }

        .card:nth-child(1)::before {
            bottom: 0;
            right: 0;
            clip-path: circle(calc(6.25rem + 7.5vw) at 100% 100%);
        }

        .card:nth-child(2)::before {
            bottom: 0;
            left: 0;
            clip-path: circle(calc(6.25rem + 7.5vw) at 0% 100%);
        }

        .card:nth-child(3)::before {
            top: 0;
            right: 0;
            clip-path: circle(calc(6.25rem + 7.5vw) at 100% 0%);
        }

        .card:nth-child(4)::before {
            top: 0;
            left: 0;
            clip-path: circle(calc(6.25rem + 7.5vw) at 0% 0%);
        }

        .card:nth-child(5)::before {
            bottom: 0;
            right: 0;
            clip-path: circle(calc(6.25rem + 7.5vw) at 100% 100%);
        }

        .card:nth-child(6)::before {
            bottom: 0;
            left: 0;
            clip-path: circle(calc(6.25rem + 7.5vw) at 0% 100%);
        }

        .card:hover::before {
            clip-path: circle(150% at 100% 100%);
        }

        .card-content {
            position: relative;
        }

        @media (min-width: 1024px) {
            .card-content {
                /*                padding-right: 3rem;
            }*/
            }
            .card:nth-child(even) .card-content
        {
            padding-right: 0;
            padding-left: 3rem;
        }
        }
        


        .card:hover p {
            color: white;
        }

        .btn {
            background-color: #b8d8d8;
            color: rgb(30, 41, 59);
            padding: 0.5rem 1.5rem;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 1rem;
/*            position: relative;*/
            z-index: 10;
        }

        .btn:hover {
            background-color: #a6c4c4;
        }

        .btn-glow {
            position: relative;
        }

        .btn-glow::after {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(135deg, #c4e3e3 0%, #a6c4c4 100%);
            border-radius: 0.5rem;
            z-index: -1;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .btn-glow:hover::after {
            opacity: 0.5;
            animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
        }

        @keyframes pulse {
            0%, 100% {
                opacity: 0.5;
            }

            50% {
                opacity: 0.2;
            }
        }
        h1{
            margin:0px 0px 0px 0px;
            margin-block-start:0px;
            margin-block-end:0px;
            height:2.5vw;
            margin-left:50%;
            margin-top:5%;
        }
    
    </style>

    <script>
        function togglePanel(panelId, cardId) {
            const allPanels = document.querySelectorAll(".panel");
            const allCards = document.querySelectorAll(".card");

            allPanels.forEach(panel => panel.classList.remove("visible"));
            allCards.forEach(card => {
                card.classList.add("inactive");
                card.classList.remove("active");
            });

            document.getElementById(panelId).classList.add("visible");
            document.getElementById(cardId).classList.remove("inactive");
            document.getElementById(cardId).classList.add("active");

            document.getElementById("btnBack").style.display = "block";
        }

        function resetPanels() {
            const allPanels = document.querySelectorAll(".panel");
            const allCards = document.querySelectorAll(".card");

            allPanels.forEach(panel => panel.classList.remove("visible"));
            allCards.forEach(card => {
                card.classList.remove("inactive");
                card.classList.remove("active");
            });

            document.getElementById("btnBack").style.display = "none";
        }
    </script>
</head>
<body>
    <section>
    <form id="form1" runat="server">
        <div class="header">
           <h1> Teacher Dashboard </h1>
            <asp:Label ID="txName" runat="server" CssClass="corner" Text="Label"></asp:Label>
        </div>

        <div class="container grid">

            <!-- Section 1 -->
            <div class="card" id="cardAccount">
                <div class="card-content">
                <h3 onclick="togglePanel('panelAccount', 'cardAccount')">Your Account</h3>
                <div id="panelAccount" class="panel">
                    <asp:TextBox ID="txtName" runat="server" CssClass="textbox" placeholder="Name" /><br />
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="textbox" TextMode="Password" placeholder="Password" /><br />
                         <asp:TextBox ID="txtclass" runat="server" CssClass="textbox" TextMode="SingleLine" placeholder="class" /><br />
                      
                         <asp:TextBox ID="section" runat="server" CssClass="textbox" TextMode="SingleLine" placeholder="section" /><br />
                    <asp:TextBox ID="txtRole" runat="server" CssClass="textbox" ReadOnly="true" placeholder="Role" /><br />
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" CssClass="button-primary" /><br />
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="button-primary" /><br />
                </div>
            </div>
                </div>

            <!-- Section 2 -->
            <div class="card" id="cardQuiz">
                <div class="card-content">
                <h3 onclick="togglePanel('panelQuiz', 'cardQuiz')"  AutoPostBack="false">Add a New Quiz</h3>
                <div id="panelQuiz" class="panel">
                    <asp:Button ID="btnAddQuestion" runat="server" Text="Add Question" OnClick="btnAddQuestion_Click" CssClass="button-primary" />
                   <asp:Panel ID="questionPanel" runat="server" Visible="false">
    <asp:TextBox ID="txtQuizName" runat="server" CssClass="textbox" placeholder="Enter Quiz Name" /><br />
    
    <asp:TextBox ID="txtQuestion" runat="server" CssClass="textbox" placeholder="Enter Question" /><br />
    <asp:TextBox ID="txtOption1" runat="server" CssClass="textbox" placeholder="Option 1" /><br />
    <asp:TextBox ID="txtOption2" runat="server" CssClass="textbox" placeholder="Option 2" /><br />
    <asp:TextBox ID="txtOption3" runat="server" CssClass="textbox" placeholder="Option 3" /><br />
    <asp:TextBox ID="txtOption4" runat="server" CssClass="textbox" placeholder="Option 4" /><br />
    
    <asp:DropDownList ID="ddlCorrectOption" runat="server" CssClass="textbox">
        <asp:ListItem Value="A" Text="A" />
        <asp:ListItem Value="B" Text="B" />
        <asp:ListItem Value="C" Text="C" />
        <asp:ListItem Value="D" Text="D" />
    </asp:DropDownList><br />

    <asp:Button ID="btnNextQuestion" runat="server" Text="Next Question" OnClick="btnNextQuestion_Click" CssClass="button-primary" />
    <asp:Button ID="btnDoneQuiz" runat="server" Text="Done" OnClick="btnDoneQuiz_Click" CssClass="button-primary" />
    <asp:Button ID="btnNewQuiz" runat="server" Text="Start New Quiz" OnClick="btnNewQuiz_Click" CssClass="button-primary" />
</asp:Panel>

                </div>
            </div>
                </div>
            <!-- Section 3 -->
            <div class="card" id="cardPrevious">
                <div class="card-content">
                <h3 onclick="togglePanel('panelPrevious', 'cardPrevious')">Previous Quizzes</h3>
                <div id="panelPrevious" class="panel">
                    <asp:GridView ID="gvQuizzes" runat="server" AutoGenerateColumns="False" CssClass="gridth" GridLines="Both" HeaderStyle-Font-Bold="true" Width="100%">
    <Columns>
        <asp:BoundField DataField="QuizName" HeaderText="Quiz Name" />
        <asp:BoundField DataField="QuestionCount" HeaderText="Questions" />
        <asp:BoundField DataField="CreatedDate" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" />
    </Columns>
</asp:GridView>

                </div>
            </div>
                </div>

            <!-- Section 4 -->
            <div class="card" id="cardResults">
                 <div class="card-content">
                <h3 onclick="togglePanel('panelResults', 'cardResults')">Student Results</h3>
                <div id="panelResults" class="panel">
                 <asp:GridView ID="gvResults" runat="server" AutoGenerateColumns="False"  CssClass="gridth"  GridLines="Both" HeaderStyle-Font-Bold="true" Width="100%">
    <Columns>
        <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
        <asp:BoundField DataField="Attempted" HeaderText="Attempted" />
        <asp:BoundField DataField="QuizName" HeaderText="Quiz Name" />
        <asp:BoundField DataField="Score" HeaderText="Score" />
        <asp:BoundField DataField="TotalQuestions" HeaderText="Total Questions" />
        <asp:BoundField DataField="Percentage" HeaderText="Percentage (%)" />
    </Columns>
</asp:GridView>


                </div>
            </div>
         </div>
        </div>

            <!-- BACK BUTTON -->
           <asp:Button ID="btnBack" runat="server" Text="Back" OnClientClick="resetPanels(); return false;" CssClass="button-primary bck" /></div> 
       

        <!-- Footer image -->
       <img src="—Pngtree—abstract purple wave vector_14869341.png" class="footer-img" />
       
    </form>
</section>
</body>
</html>
