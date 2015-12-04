<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Repair_Follow_Add.aspx.cs" Inherits="Repair.Repair_Follow_Add" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
            loadForm(getparastr("fid"));
            remind();
            $("#remind").click(function () {
                remind();
            });
        })
        function remind() {
            if ($("#remind").attr("checked") == true || $(this).attr("checked") == "checked") {
                $("#tr1").show();
                $("#tr2").show();
                $("#tr3").show();
                $("#tr4").show();

                $("#StartTime").rules("add", { required: true });
                $("#EndTime").rules("add", { required: true });
                $("#Content").rules("add", { required: true });
            }
            else {
                $("#tr1").hide();
                $("#tr2").hide();
                $("#tr3").hide();
                $("#tr4").hide();

                $("#StartTime").rules("add", { required: false });
                $("#EndTime").rules("add", { required: false });
                $("#Content").rules("add", { required: false });
            }
        }
        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&cmd=save&fid=" + getparastr("fid") + "&rid=" + getparastr("rid");
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }
        function loadForm(fid) {
            $.ajax({
                type: "GET",
                url: "Repair_Follow_Add.aspx?cmd=form&fid=" + fid + "&rnd=" + Math.random(),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    $("#FollowContent").val(obj.FollowContent);
                    $("#FollowType").ligerComboBox({ width: 352, initValue: obj.FollowTypeID, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=4&rnd=" + Math.random() });
                },
                error: function (ex) {
                    top.$.ligerDialog.error('操作失败，错误信息：' + ex.responseText);
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">
        <table class="bodytable1" style="width: 500px; margin: 2px;">
            <tr>
                <td class="table_title1" colspan="2">跟进</td>
            </tr>
            <tr>
                <td style="width: 85px">
                    <div style="width: 80px; text-align: right; float: right">跟进方式：</div>
                </td>
                <td>
                    <input type="text" id="FollowType" name="FollowType" validate="{required:true}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">跟进内容：</div>
                </td>
                <td>
                    <textarea id="FollowContent" name="FollowContent" cols="100" rows="6" class="l-textarea" style="width: 350px;" validate="{required:true}"></textarea>
                </td>
            </tr>
            <tr>
                <td class="table_title1" colspan="2" id="remindtr">
                    <div style="width:40px;float:left">提醒</div>
                    <div style="width:40px;float:left">
                        <input type="checkbox" id="remind"/>
                    </div>
                </td>
            </tr>
            <tr id="tr1">
                <td style="width: 85px">
                    <div style="width: 80px; text-align: right; float: right">注：</div>
                </td>
                <td>提醒内容将出现在日程里面</td>
            </tr>
            <tr id="tr2">
                <td style="width: 85px">
                    <div style="width: 80px; text-align: right; float: right">全天提醒：</div>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <input type="radio" value="True" name="allday" />
                            </td>
                            <td>是 </td>
                            <td>
                                <input type="radio" value="False" name="allday" checked="checked" />
                            </td>
                            <td>否 </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="tr3">
                <td style="width: 85px">
                    <div style="width: 80px; text-align: right; float: right">提醒时间：</div>
                </td>
                <td>
                    <div style="float: left; width: 175px;">
                        <input type="text" id="StartTime" name="StartTime" ltype="date" ligerui="{width:172,showTime:true}" />
                    </div>
                    <div style="float: left; width: 175px;">
                        <input type="text" id="EndTime" name="EndTime" ltype="date" ligerui="{width:176,showTime:true}" />
                    </div>
                </td>
            </tr>
            <tr id="tr4">
                <td>
                    <div style="width: 80px; text-align: right; float: right">提醒内容：</div>
                </td>
                <td>
                    <textarea id="Content" name="Content" cols="100" rows="3" class="l-textarea" style="width: 350px;"></textarea>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
