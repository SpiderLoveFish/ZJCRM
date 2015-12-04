<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Repair_Add.aspx.cs" Inherits="Repair.Repair_Add" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
            $("form").ligerForm();
            loadForm(getparastr("cid"));
            if (getparastr("tel") != "") {
                $('#Khdh').val(getparastr("tel"));
                searchCustomer();
            } else $('#Khdh').val("");
                $('#Khdh').bind('input propertychange', function () { searchCustomer(); });
        })
        function loadForm(cid) {
            $.ajax({
                type: "GET",
                url: "Repair_Add.aspx?cmd=form&cid=" + cid + "&rnd=" + Math.random(),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    $("#Wxlb").ligerComboBox({ width: 150, initValue: obj.WxlbID, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=12&rnd=" + Math.random() });
                    if (obj.RepairID) {
                        $("#Khdh").val(obj.Khdh);
                        $("#Khbh").val(obj.Khbh);
                        $("#Khmc").val(obj.Khmc);
                        $("#Khxb").val(obj.Khxb);
                        $("#Khxq").val(obj.Khxq);
                        $("#Khdz").val(obj.Khdz);
                        $("#Khyx").val(obj.Khyx);
                        $("#Sfkh").val(obj.Sfkh);
                        $("#Wxrq").val(obj.Wxrq);
                        $("#Wxsj").val(obj.Wxsj);
                        $("#Wxyy").val(obj.Wxyy);
                    }
                    else {
                        $("#Sfkh").val("否");
                    }
                },
                error: function (ex) {
                    top.$.ligerDialog.error('操作失败，错误信息：' + ex.responseText);
                }
            });
        }
        function searchCustomer() {
            $.ajax({
                type: "GET",
                url: "Repair_Add.aspx?cmd=search&tel=" + $('#Khdh').val() + "&rnd=" + Math.random(),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    if (obj.Customer) {
                        $("#Khbh").val(obj.id);
                        $("#Khmc").val(obj.Customer);
                        $("#Khxb").val(obj.Gender);
                        $("#Khxq").val(obj.Towns + obj.Community + obj.BNo + '栋' + obj.RNo + '室');
                        $("#Khdz").val(obj.address);
                        $("#Sfkh").val("是");
                    }
                    else {
                        //$("#Khbh").val("");
                        //$("#Khmc").val("");
                        //$("#Khxb").val("");
                        //$("#Khxq").val("");
                        //$("#Khdz").val("");
                        $("#Sfkh").val("否");
                    }
                },
                error: function (ex) {
                    top.$.ligerDialog.error('操作失败，错误信息：' + ex.responseText);
                }
            });
        }
        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&cmd=save&cid=" + getparastr("cid");
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false;">
        <table style="width: 550px; margin: 5px;" class='bodytable1'>
            <tr>
                <td colspan="4" class="table_title1">客户信息</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">客户电话：</div>
                </td>
                <td>
                    <input type="text" id="Khdh" name="Khdh" ltype="text" ligerui="{width:150}" validate="{required:true}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">客户姓名：</div>
                </td>
                <td>
                    <div style="width: 200px; text-align: left; float: left">
                        <input type="text" id="Khmc" name="Khmc" ltype="text" ligerui="{width:150}" validate="{required:true}" />
                        <input id="Khbh" name="Khbh" type="hidden" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">客户姓别：</div
                </td>
                <td>
                    <input type="text" id="Khxb" name="Khxb" ltype="select" ligerui="{width:150,data:[{id:'男',text:'男'},{id:'女',text:'女'}]}" validate="{required:true}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">电子邮箱：</div>
                </td>
                <td>
                    <input type="text" id="Khyx" name="Khyx" ltype="text" ligerui="{width:150}" validate="{required:false}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">所在小区：</div>
                </td>
                <td colspan="3">
                    <input type="text" id="Khxq" name="Khxq" ltype="text" ligerui="{width:415}" validate="{required:true}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">综合地址：</div>
                </td>
                <td colspan="3">
                    <input type="text" id="Khdz" name="Khdz" ltype="text" ligerui="{width:415}" validate="{required:false}" />
                </td>
            </tr>
             <tr>
                <td colspan="4" class="table_title1">报修信息</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">希望维修日期：</div>
                </td>
                <td>
                    <input type="text" id="Wxrq" name="Wxrq" ltype="date" ligerui="{width:150}" validate="{required:true}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">希望维修时间：</div>
                </td>
                <td>
                    <input type="text" id="Wxsj" name="Wxsj" ltype="select" ligerui="{width:150,data:[{id:'08:00-10:00',text:'08:00-10:00'},{id:'10:00-12:00',text:'10:00-12:00'},{id:'14:00-16:00',text:'14:00-16:00'},{id:'16:00-18:00',text:'16:00-18:00'}]}" validate="{required:true}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">维修类别：</div>
                </td>
                <td>
                    <input type="text" id="Wxlb" name="Wxlb" validate="{required:true}"/>
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">是否客户：</div>
                </td>
                <td>
                    <input type="text" id="Sfkh" name="Sfkh" ltype="select" ligerui="{width:150,data:[{id:'是',text:'是'},{id:'否',text:'否'}]}" validate="{required:true}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">维修原因：</div>
                </td>
                <td colspan="3">
                    <textarea id="Wxyy" name="Wxyy" cols="100" rows="4" class="l-textarea" style="width:410px"></textarea>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
