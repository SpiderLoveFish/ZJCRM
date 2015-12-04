<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Repair_Print.aspx.cs" Inherits="XHD.CRM.CRM.Repair.Repair_Print" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <style>
        @media print {
            .noprint{
                display: none;
            }
        }
        .title {
            vertical-align:middle;
            text-align:center;
            font-size: xx-large;
            height:50px;
        }
        table {
            border: solid 2px black;
            border-collapse:collapse;
            table-layout:fixed;
        }
        tr td {
            border: solid 1px black;
            border-collapse:collapse;
            text-align:center;
            height:40px;
        }
        .lite {
            font:12px;
        }
        .footer {
            width:100%;
            text-align:center;
            font-size:12px;
            font-weight:bold;
        }
    </style>
    <title></title>
</head>
<body>
    <input type="button" value=" 打  印 " class="noprint" onclick="javascript: window.print();" />
    <div style="width:720px;">
        <table style="border-collapse:collapse;width:100%;height:100%">
            <tr style="display:none;">
                <td style="width:80px;"></td>
                <td style="width:80px;"></td>
                <td style="width:80px;"></td>
                <td style="width:80px;"></td>
                <td style="width:80px;"></td>
                <td style="width:80px;"></td>
                <td style="width:80px;"></td>
                <td style="width:80px;"></td>
                <td style="width:80px;"></td>
            </tr>
            <tr>
                <td class="title" colspan="9"><asp:Label ID="lbTitle" runat="server" /></td>
            </tr>
            <tr>
                <td>维修单号</td>
                <td><asp:Label ID="lbRepairID" runat="server" /></td>
                <td>施工日期</td>
                <td colspan="2"><asp:Label ID="lbWxrq" runat="server" /></td>
                <td>施工人员</td>
                <td colspan="3" style="text-align:left;"><asp:Label ID="lbWxry" runat="server" />&nbsp;转</td>
            </tr>
            <tr>
                <td>业主称呼</td>
                <td><asp:Label ID="lbKhmc" runat="server" /></td>
                <td>联系电话</td>
                <td colspan="2"><asp:Label ID="lbKhdh" runat="server" /></td>
                <td>所在小区</td>
                <td colspan="3" style="text-align:left;"><asp:Label ID="lbKhxq" runat="server" /></td>
            </tr>
            <tr>
                <td style="height:300px;">维修项目</td>
                <td colspan="8" style="text-align:left;vertical-align:top;">
                    <div>维修原因:</div>
                    <div><asp:Label CssClass="lite" ID="lbWxyy" runat="server" /></div>
                    <div>跟进明细:</div>
                    <div><asp:Label CssClass="lite" ID="lbGjxx" runat="server" /></div>
                </td>
            </tr>
            <tr>
                <td colspan="2">上门时间</td>
                <td colspan="2">处理结果</td>
                <td colspan="3">添加材料</td>
                <td colspan="2">结束时间</td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <td colspan="2"></td>
                <td colspan="3"></td>
                <td colspan="2"></td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <td colspan="2"></td>
                <td colspan="3"></td>
                <td colspan="2"></td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <td colspan="2"></td>
                <td colspan="3"></td>
                <td colspan="2"></td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <td colspan="2"></td>
                <td colspan="3"></td>
                <td colspan="2"></td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <td colspan="2"></td>
                <td colspan="3"></td>
                <td colspan="2"></td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <td colspan="2"></td>
                <td colspan="3"></td>
                <td colspan="2"></td>
            </tr>
            <tr>
                <td colspan="5">请您对我们本次的服务评价，谢谢</td>
                <td colspan="4">本次服务收费：_______元</td>
            </tr>
            <tr>
                <td colspan="2">对我们公司评价</td>
                <td colspan="7">
                    □差&nbsp;&nbsp;
                    □较差&nbsp;&nbsp;
                    □一般&nbsp;&nbsp;
                    □好&nbsp;&nbsp;
                    □非常好
                </td>
            </tr>
            <tr>
                <td colspan="2">对我们公司意见</td>
                <td colspan="7"></td>
            </tr>
            <tr>
                <td colspan="2">公司回访核实</td>
                <td colspan="3">
                    □属实&nbsp;&nbsp;
                    □不属实&nbsp;&nbsp;
                </td>
                <td colspan="2">回访人</td>
                <td colspan="2"></td>
            </tr>
            <tr>
                <td colspan="5" rowspan="2">*任务完成后最后请施工人员必须将此单交回公司</td>
                <td colspan="4" style="text-align:left;">日期：</td>
            </tr>
            <tr>
                <td colspan="4" style="text-align:left;"><asp:Label ID="lbCpy" runat="server" /></td>
            </tr>
        </table>
        <!--<div class="footer">&nbsp;选择心诚&nbsp;心想事成&nbsp;&nbsp;&nbsp;&nbsp;地址:新城域商业街7-5号&nbsp;&nbsp;公司网址:www.xczs.com&nbsp;&nbsp;服务电话:4001152088</div>-->
    </div>
</body>
</html>
