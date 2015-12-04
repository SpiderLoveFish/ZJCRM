<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Product_QrCode_Print_Style2.aspx.cs" Inherits="XHD.CRM.CRM.Product.Product_QrCode_Print_Style2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <style>
        @media print {
     
            .noprint{
                display: none;
            }
            .nextpage {
                page-break-after: always;
            }
        }
        table{border:0;margin:0;border-collapse:collapse;border-spacing:0;}
        table td{border:0;padding:2px;}
        .dd{text-align:left;  
         vertical-align: top;
          word-break:break-all;

        }
    </style>
    <title> 打印二维码</title>
</head>
<body>
    <input type="button" value=" 打  印 " class="noprint" onclick="javascript: window.print();" />
    <!--打印区域-->
    <asp:DataList ID="DLMain" runat="server" ShowFooter="false" ShowHeader="false" onitemdatabound="DLMain_ItemDataBound">
        <ItemTemplate>
            <table>
                
                <tr>
                    <td >
                        <table  border="0" style="border:1px solid #000000; width:450px;height:120px" cellpadding="0"cellspacing="1">
  <tr style="height:40px">
    <td width="116" rowspan="3" align="center" valign="middle"><font size="5px">
                              <asp:Label ID="lbcompy"   runat="server">
                              </asp:Label></font>
        <br></br><font size="5px"> <asp:Label ID="lbcp"   runat="server">
                              </asp:Label></font></td>
    <td width="144" rowspan="3" align="center" valign="middle">
        <asp:Image ID="Image1" runat="server" Width="100" Height="100"/></td>
    <td width="184" align="left" valign="middle">
        <asp:Label ID="lbproduct"   runat="server"></asp:Label></td>
  </tr>
  <tr>
    <td><asp:Label ID="lbbrand"   runat="server"></asp:Label></td>
  </tr>
  <tr  style="height:40px">
    <td align="left" valign="middle"><asp:Label ID="lbspec"   runat="server"></asp:Label></td>
  </tr>

                        </table>
              
                </tr>
                <tr><td style="height:30px;"></td></tr>
            </table>
            <!--循环打印换页-->
            <asp:Label ID="lbPager" runat="server"></asp:Label>
        </ItemTemplate>
    </asp:DataList>

 
</body>
</html>
