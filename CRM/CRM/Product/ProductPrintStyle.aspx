<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductPrintStyle.aspx.cs" Inherits="XHD.CRM.CRM.Product.ProductPrintStyle" %>
<meta name="ProductPrintStyle" content="initial-scale=1, user-scalable=0, minimal-ui"> 
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>
     <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
   <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
      <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />


          <style type="text/css"> 
/* button 
---------------------------------------------- */ 
.button { 
display: inline-block; 
zoom: 1; /* zoom and *display = ie7 hack for display:inline-block */ 
*display: inline; 
vertical-align: baseline; 
margin: 0 2px; 
outline: none; 
cursor: pointer; 
text-align: center; 
text-decoration: none; 
font: 14px/100% Arial, Helvetica, sans-serif; 
padding: .5em 2em .55em; 
text-shadow: 0 1px 1px rgba(0,0,0,.3); 
-webkit-border-radius: .5em; 
-moz-border-radius: .5em; 
border-radius: .5em; 
-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2); 
-moz-box-shadow: 0 1px 2px rgba(0,0,0,.2); 
box-shadow: 0 1px 2px rgba(0,0,0,.2); 
} 
.button:hover { 
text-decoration: none; 
} 
.button:active { 
position: relative; 
top: 1px; 
} 
.bigrounded { 
-webkit-border-radius: 2em; 
-moz-border-radius: 2em; 
border-radius: 2em; 
} 
.medium { 
font-size: 12px; 
padding: .4em 1.5em .42em; 
} 
.small { 
font-size: 11px; 
padding: .2em 1em .275em; 
} 
/* color styles 
---------------------------------------------- */ 
/* blue */ 
.blue { 
color: #d9eef7; 
border: solid 1px #0076a3; 
background: #0095cd; 
background: -webkit-gradient(linear, left top, left bottom, from(#00adee), to(#0078a5)); 
background: -moz-linear-gradient(top, #00adee, #0078a5); 
filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#00adee', endColorstr='#0078a5'); 
} 
.blue:hover { 
background: #007ead; 
background: -webkit-gradient(linear, left top, left bottom, from(#0095cc), to(#00678e)); 
background: -moz-linear-gradient(top, #0095cc, #00678e); 
filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#0095cc', endColorstr='#00678e'); 
} 
.blue:active { 
color: #80bed6; 
background: -webkit-gradient(linear, left top, left bottom, from(#0078a5), to(#00adee)); 
background: -moz-linear-gradient(top, #0078a5, #00adee); 
filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#0078a5', endColorstr='#00adee'); 
} 
</style> 
    
    
    <script>
        
        function OpenStyle1()
        {
             
            window.open("Product_QrCode_Print.aspx?id=" + getparastr("id"), "_blank", 'top=0, left=0, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=n o, status=no');

        }
        function OpenStyle2() {
            window.open("Product_QrCode_Print_Style2.aspx?id=" + getparastr("id"), "_blank", 'top=0, left=0, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=n o, status=no');

        }
       
    </script>
</head>
<body>
    <form id="form1" runat="server"  >
    <div>
        <table width="100%">
            <tr><td colspan="2">
                <asp:Label ID="lbid" runat="server"></asp:Label>
                </td>

            </tr>
            <tr>
                <td> <asp:Button class="button blue"   runat="server" ID="btnS1" Text="大标签"   OnClientClick="OpenStyle1()"/>
              <img src="1.png" width="100" height="100"></td>
                <td> <asp:Button class="button blue" runat="server" ID="btnS2" Text="长标签"  OnClientClick="OpenStyle2()"/>
              <img src="2.png" width="100" height="100"></td>
            </tr>
            <%-- 描述 --%>
            <tr>
                <td align="center"></td>
                <td align="center"></td>
            </tr>

        </table>
    
    </div>
    </form>
</body>
</html>
