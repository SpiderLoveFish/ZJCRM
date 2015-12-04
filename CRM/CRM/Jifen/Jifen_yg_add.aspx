<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Jifen_yg_add.aspx.cs" Inherits="Jifen.Jifen_yg_add" %>

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
            loadForm();
        })
        function loadForm() {
            $("#Zjf").val(getparastr("zjf"));
            $.ajax({
                type: "GET",
                url: "Jifen_yg_add.aspx?cmd=search&cid=" + getparastr("cid") + "&rnd=" + Math.random(),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    if (obj.name) {
                        $("#Name").val(obj.name);
                        $("#Tel").val(obj.tel);
                        $("#Email").val(obj.email);
                        $("#Sex").val(obj.sex);
                    }
                },
                error: function (ex) {
                    top.$.ligerDialog.error('操作失败，错误信息：' + ex.responseText);
                }
            });
            $.ajax({
                type: "GET",
                url: "Jifen_yg_add.aspx?cmd=form&jid=" + getparastr("jid") + "&rnd=" + Math.random(),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    if (obj.JfID) {
                        $("#Jf").val(obj.Jf);
                        $("#Jflx").val(obj.Jflx);
                        $("#Content").val(obj.Content);
                    }
                    else {
                        $("#Jf").val("1");
                        var manager = $("#Jflx").ligerComboBox({});
                        manager.selectValue(getparastr("jlx"));
                    }
                },
                error: function (ex) {
                    top.$.ligerDialog.error('操作失败，错误信息：' + ex.responseText);
                }
            });
        }
        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&cmd=save&cid=" + getparastr("cid") + "&jid=" + getparastr("jid") + "&jlx=" + getparastr("jlx");
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false;">
        <table style="width: 500px; margin: 5px;" class='bodytable1'>
            <tr>
                <td colspan="4" class="table_title1">员工信息</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">员工姓名：</div>
                </td>
                <td>
                    <div style="text-align: left; float: left">
                        <input type="text" id="Name" name="Name" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:false}" />
                    </div>
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">员工电话：</div>
                </td>
                <td>
                    <input type="text" id="Tel" name="Tel" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:false}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">员工姓别：</div
                </td>
                <td>
                    <input type="text" id="Sex" name="Sex" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:false}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">电子邮箱：</div>
                </td>
                <td>
                    <input type="text" id="Email" name="Email" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:false}" />
                </td>
            </tr>
            <tr>
                <td colspan="4" class="table_title1">积分信息</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">分值：</div>
                </td>
                <td>
                    <input type="text" id="Jf" name="Jf" ltype="spinner" ligerui="{width:150,type:'int',isNegative:false}" validate="{required:true}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">现有积分：</div>
                </td>
                <td>
                    <input type="text" id="Zjf" name="Zjf" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:false}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">积分描述：</div>
                </td>
                <td colspan="3">
                    <textarea id="Content" name="Content" cols="100" rows="4" class="l-textarea" style="width:415px"></textarea>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
