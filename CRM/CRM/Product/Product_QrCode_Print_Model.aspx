<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Product_QrCode_Print_Model.aspx.cs" Inherits="XHD.CRM.CRM.Product.Product_QrCode_Print_Model" %>

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
                        <table  border="0" style="border:1px solid #000000; width:300px;height:450px" cellpadding="0"cellspacing="1">
                            <tr style="height:60px"><td colspan="2" align=center><font size="20px"><asp:Label ID="lbcompy1"   runat="server"></asp:Label></font></td></tr>
                            <tr style="height:40px"><td colspan="2" align=center><font size="6px"><asp:Label ID="lbtc1"   runat="server"></asp:Label></font></td></tr>
                             <tr style="height:30px"><td colspan="2"> <asp:Label ID="lbproduct1"   runat="server"></asp:Label></td></tr>
                            
                            <tr style="height:30px">
                                <td><asp:Label ID="lbcategory1"   runat="server"></asp:Label></td>
                                <td rowspan="4" align=center><asp:Image ID="Image1" runat="server" Width="100" Height="100"/>
                                    <br />扫一扫(<asp:Label runat="server" ID="lbsys1">)</asp:Label></td>
                            </tr>
                             <tr style="height:30px">
                                <td><asp:Label ID="lbxh1"   runat="server"></asp:Label></td>
                            </tr>
                            <tr style="height:30px">
                                <td><asp:Label ID="lbxl1"   runat="server"></asp:Label></td>
                            </tr >
                               <tr style="height:30px">
                                <td ><asp:Label ID="lbspec1" Width="100%"   runat="server"></asp:Label></td>
                            </tr>
                             <tr style="height:30px"><td colspan="2"><asp:Label ID="lbprice1"   runat="server"></asp:Label></td></tr>
                             <tr ><td colspan="2" style=" vertical-align:top"><asp:Label ID="lbremarks1"    CssClass="dd"  runat="server"></asp:Label></td></tr>
                        </table>
                         
                    </td>
                     <td style="width:40px;"></td>
                    <td>
                         <table  border="0" style="border:1px solid #000000; width:300px;height:450px" cellpadding="0"cellspacing="1">
                            <tr style="height:60px"><td colspan="2" align=center><font size="20px"><asp:Label ID="lbcompy2"   runat="server"></asp:Label></font></td></tr>
                            <tr style="height:40px"><td colspan="2" align=center><font size="6px"><asp:Label ID="lbtc2"   runat="server"></asp:Label></font></td></tr>
                             <tr style="height:30px"><td colspan="2"> <asp:Label ID="lbproduct2"   runat="server"></asp:Label></td></tr>
                            
                            <tr style="height:30px">
                                <td><asp:Label ID="lbcategory2"   runat="server"></asp:Label></td>
                                <td rowspan="4" align=center><asp:Image ID="Image2" runat="server" Width="100" Height="100"/>
                                    <br />扫一扫(<asp:Label runat="server" ID="lbsys2">)</asp:Label></td>
                            </tr>
                             <tr style="height:30px">
                                <td><asp:Label ID="lbxh2"   runat="server"></asp:Label></td>
                            </tr>
                            <tr style="height:30px">
                                <td><asp:Label ID="lbxl2"   runat="server"></asp:Label></td>
                            </tr >
                               <tr style="height:30px">
                                <td ><asp:Label ID="lbspec2" Width="100%"   runat="server"></asp:Label></td>
                            </tr>
                             <tr style="height:30px"><td colspan="2"><asp:Label ID="lbprice2"   runat="server"></asp:Label></td></tr>
                             <tr ><td colspan="2" style=" vertical-align:top"><asp:Label ID="lbremarks2"    CssClass="dd"  runat="server"></asp:Label></td></tr>
                        </table>

                    </td>
                  <%--  <td style="width:40px;"></td>
                    <td>
                         <table>
                         <tr><td><asp:Label ID="lbcategory2"   runat="server"></asp:Label></td></tr>
                              <tr><td><asp:Label ID="lbproduct2"   runat="server"></asp:Label></td></tr>
                              <tr><td><asp:Label ID="lbspec2"   runat="server"></asp:Label></td></tr>
                          <tr><td><asp:Image ID="Image2" runat="server" Width="170" Height="170"/></td></tr>
                            </table>
                    </td>
                    <td style="width:40px;"></td>
                    <td>
                         <table>
                        <tr><td><asp:Label ID="lbcategory3"   runat="server"></asp:Label></td></tr>
                              <tr><td><asp:Label ID="lbproduct3"  runat="server"></asp:Label></td></tr>
                              <tr><td><asp:Label ID="lbspec3" runat="server"></asp:Label></td></tr>
                            <tr><td><asp:Image ID="Image3" runat="server" Width="170" Height="170"/></td></tr>
                            </table>
                    </td>--%>
                </tr>
                <tr><td style="height:5px;"></td></tr>
            </table>
            <!--循环打印换页-->
            <asp:Label ID="lbPager" runat="server"></asp:Label>
        </ItemTemplate>
    </asp:DataList>

 
</body>
</html>
