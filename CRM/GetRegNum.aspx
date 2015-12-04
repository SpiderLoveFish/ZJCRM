<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetRegNum.aspx.cs" Inherits="XHD.CRM.GetRegNum" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:TextBox ID="txtMNum" runat="server" Width="300px"></asp:TextBox>
        <asp:Button ID="btnReg" runat="server" Text="注册信息" OnClick="btnReg_Click" /><br />
        <asp:Label ID="lbRNum" runat="server"></asp:Label>
    </div>
    </form>
</body>
</html>
