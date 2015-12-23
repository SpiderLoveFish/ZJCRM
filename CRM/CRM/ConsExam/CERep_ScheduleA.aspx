<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CERep_ScheduleA.aspx.cs" Inherits="XHD.CRM.CRM.ConsExam.CERep_ScheduleA" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <title>报表</title>

    <style>
        .HeaderStyle { FONT-WEIGHT: bold; FONT-SIZE: 12px; COLOR: #000000; LINE-HEIGHT: 20px; POSITION: relative; TOP: expression(this.offsetParent.scrollTop); TEXT-OVERFLOW: ellipsis; BACKGROUND-COLOR: #FFD7¡
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="MAX-HEIGHT: 400px;OVERFLOW-X: auto; OVERFLOW-Y: auto; ">
    
        <asp:GridView ID="GridView1" runat="server"
            OnRowDataBound="GridView1_RowDataBound">
            

        </asp:GridView>
    
    </div>
    </form>
</body>
</html>
