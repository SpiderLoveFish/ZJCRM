<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sms.aspx.cs" Inherits="sms" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Button ID="Button2" runat="server" Text="查询余额" onclick="Button2_Click" />
    <asp:Button ID="Button3" runat="server" Text="发送短信" onclick="Button3_Click" />
    <asp:CheckBox ID="CheckBox1" runat="server" Text="定时发送：" />
    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
    <asp:Label ID="Label4" runat="server" 
        Text="定时发送格式2010-10-24 09:08:10" ForeColor="Blue"></asp:Label>
    <br />
    <asp:Label ID="Label1" runat="server" Text="手机号码："></asp:Label>
    <asp:TextBox ID="TextBox1" runat="server" Width="647px">在这里输入手机号码，多个号码用逗号(,)间隔。</asp:TextBox>
    <br />
    <asp:Label ID="Label2" runat="server" Text="短信内容："></asp:Label>
    <asp:TextBox ID="TextBox2" runat="server" Height="70px" TextMode="MultiLine" 
        Width="648px">这里输入短信内容</asp:TextBox>
    <br />
    <asp:Label ID="Label3" runat="server" Text="返回结果："></asp:Label>
    <asp:TextBox ID="TextBox3" runat="server" Width="648px"></asp:TextBox>
    </form>
    
</body>
</html>
