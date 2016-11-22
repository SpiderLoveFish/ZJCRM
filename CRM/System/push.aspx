<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="push.aspx.cs" Inherits="push" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Button ID="Button2" runat="server" Text="推送" onclick="Button2_Click" /> 
    <asp:CheckBox ID="ckall" runat="server" Text="全部" />
        <asp:CheckBox ID="ckpad" runat="server" Text="PAD" />
          <asp:CheckBox ID="ckphone" runat="server" Text="电话" />
    
    
      <br />
          <asp:Label ID="Label1" runat="server" Text="推送标题："></asp:Label>
    <asp:TextBox ID="txttitle" runat="server" 
        Width="648px">这里输入推送标题</asp:TextBox>
    <br />
    <asp:Label ID="Label2" runat="server" Text="推送内容："></asp:Label>
    <asp:TextBox ID="txtcontent" runat="server" Height="70px" TextMode="MultiLine" 
        Width="648px">这里输入推送内容</asp:TextBox>
    <br />
    <asp:Label ID="Label3" runat="server" Text="返回结果："></asp:Label>
    <asp:TextBox ID="txtresult" runat="server" Enabled="false" Width="648px" Height="70px" TextMode="MultiLine" ></asp:TextBox>
    </form>
    
</body>
</html>
