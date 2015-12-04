<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Repair_Process.aspx.cs" Inherits="Repair.Repair_Process" %>

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
            $('#Wxry').ligerComboBox({ width: 150, onBeforeOpen: f_selectWxry });
            $('#Gdry').ligerComboBox({ width: 150, onBeforeOpen: f_selectGdry });
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
                    $("#RepairID").val(obj.RepairID);
                    $("#Khdh").val(obj.Khdh);
                    $("#Khmc").val(obj.Khmc);
                    $("#Khxb").val(obj.Khxb);
                    $("#Khxq").val(obj.Khxq);
                    $("#Khdz").val(obj.Khdz);
                    $("#Khyx").val(obj.Khyx);
                    $("#Sfkh").val(obj.Sfkh);
                    $("#Wxrq").val(obj.Wxrq);
                    $("#Wxlb").val(obj.Wxlb);
                    $("#Wxsj").val(obj.Wxsj);
                    $("#Wxyy").val(obj.Wxyy);
                    $("#Clrq").val(obj.Clrq);
                    $("#Wcrq").val(obj.Wcrq);
                    if(obj.Fzxs)
                        $("#Fzxs").val(obj.Fzxs);
                    else
                        $("#Fzxs").val("0");
                    $("#Wczt").val(obj.Wczt);
                    $("#WxEmpID").val(obj.WxEmpID);
                    $("#Wxry").val(obj.WxEmpName);
                    $("#GdEmpID").val(obj.GdEmpID);
                    $("#Gdry").val(obj.GdEmpName);
                    $("#Hfxx").val(obj.Hfxx);
                    $("#Pjxx").val(obj.Pjxx);
                },
                error: function (ex) {
                    top.$.ligerDialog.error('操作失败，错误信息：' + ex.responseText);
                }
            });
        }
        function f_selectWxry() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择员工', width: 850, height: 400, url: "hr/Getemp_Auth.aspx?auth=1", buttons: [
                    { text: '确定', onclick: f_selectWxryOK },
                    { text: '取消', onclick: function (item, dialog) { dialog.close(); } }
                ]
            });
            return false;
        }
        function f_selectGdry() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择员工', width: 850, height: 400, url: "hr/Getemp_Auth.aspx?auth=1", buttons: [
                    { text: '确定', onclick: f_selectGdryOK },
                    { text: '取消', onclick: function (item, dialog) { dialog.close(); } }
                ]
            });
            return false;
        }
        function f_selectWxryOK(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('请选择员工!');
                return;
            }
            $("#Wxry").val(data.name);
            $("#WxEmpID").val(data.ID);
            dialog.close();
        }
        function f_selectGdryOK(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('请选择员工!');
                return;
            }
            $("#Gdry").val(data.name);
            $("#GdEmpID").val(data.ID);
            dialog.close();
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
                    <input type="text" id="Khdh" name="Khdh" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:true}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">客户姓名：</div>
                </td>
                <td>
                    <div style="width: 200px; text-align: left; float: left">
                        <input type="text" id="Khmc" name="Khmc" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:true}" />
                        <input id="RepairID" name="RepairID" type="hidden" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">客户姓别：</div
                </td>
                <td>
                    <input type="text" id="Khxb" name="Khxb" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:true}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">电子邮箱：</div>
                </td>
                <td>
                    <input type="text" id="Khyx" name="Khyx" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:false}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">所在小区：</div>
                </td>
                <td colspan="3">
                    <input type="text" id="Khxq" name="Khxq" ltype="text" ligerui="{width:415,disabled:true}" validate="{required:true}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">综合地址：</div>
                </td>
                <td colspan="3">
                    <input type="text" id="Khdz" name="Khdz" ltype="text" ligerui="{width:415,disabled:true}" validate="{required:false}" />
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
                    <input type="text" id="Wxrq" name="Wxrq" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:true}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">希望维修时间：</div>
                </td>
                <td>
                    <input type="text" id="Wxsj" name="Wxsj" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:true}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">维修类别：</div>
                </td>
                <td>
                    <input type="text" id="Wxlb" name="Wxlb" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:true}"/>
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">是否客户：</div>
                </td>
                <td>
                    <input type="text" id="Sfkh" name="Sfkh" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:true}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">维修原因：</div>
                </td>
                <td colspan="3">
                    <textarea id="Wxyy" name="Wxyy" cols="100" rows="4" class="l-textarea l-text-disabled" style="width:410px" ligerui="{width:410}" readonly></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="4" class="table_title1">维修信息</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">上门日期：</div>
                </td>
                <td>
                    <input type="text" id="Clrq" name="Clrq" ltype="date" ligerui="{width:150}" validate="{required:true}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">完成日期：</div>
                </td>
                <td>
                    <input type="text" id="Wcrq" name="Wcrq" ltype="date" ligerui="{width:150}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">复杂系数：</div>
                </td>
                <td>
                    <input type="text" id="Fzxs" name="Fzxs" ltype="text" ligerui="{width:150,number:true}" validate="{required:true}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">完成状态：</div>
                </td>
                <td>
                    <input type="text" id="Wczt" name="Wczt" ltype="select" ligerui="{width:150,data:[{id:'完成',text:'完成'},{id:'未完成',text:'未完成'}]}" validate="{required:true}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">维修人员：</div>
                </td>
                <td>
                    <input type="text" id="Wxry" name="Wxry" validate="{required:true}" />
                    <input id="WxEmpID" name="WxEmpID" type="hidden" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">跟单人员：</div>
                </td>
                <td>
                    <input type="text" id="Gdry" name="Gdry" validate="{required:true}" />
                    <input id="GdEmpID" name="GdEmpID" type="hidden" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">回访信息：</div>
                </td>
                <td colspan="3">
                    <textarea id="Hfxx" name="Hfxx" cols="100" rows="4" class="l-textarea" style="width:410px"></textarea>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">评价信息：</div>
                </td>
                <td colspan="3">
                    <textarea id="Pjxx" name="Pjxx" cols="100" rows="4" class="l-textarea" style="width:410px"></textarea>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
