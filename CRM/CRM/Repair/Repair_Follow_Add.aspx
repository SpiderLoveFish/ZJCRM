<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Repair_Follow_Add.aspx.cs" Inherits="Repair.Repair_Follow_Add" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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


                $("#PicUrl").rules("add", { required: true });

            }
            else {
                $("#tr1").hide();


                $("#PicUrl").rules("add", { required: false });

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
                    if (obj.PicUrl) {
                        $("#PicUrl").val(obj.PicUrl);
                        $("#userheadimg").attr("src", "../../images/upload/repair/" + obj.PicUrl);
                    }
                },

                error: function (ex) {
                    top.$.ligerDialog.error('操作失败，错误信息：' + ex.responseText);
                }
            });
        }


        function uploadimg() {
            top.$.ligerDialog.open({
                zindex: 9004,
                width: 800, height: 500,
                title: '上传图片',
                url: 'CRM/Repair/UploadImg.aspx',
                buttons: [
                {
                    text: '保存', onclick: function (item, dialog) {
                        saveheadimg(item, dialog);
                    }
                },
                {
                    text: '关闭', onclick: function (item, dialog) {
                        dialog.close();
                    }
                }
                ],
                isResize: true
            });
        }


        function saveheadimg(item, dialog) {
            var upfile = dialog.frame.f_save();
            if (upfile) {
                dialog.close();
                $.ligerDialog.waitting('数据保存中,请稍候...');

                $.ajax({
                    url: "../../data/upload.ashx", type: "POST",
                    data: upfile,
                    success: function (responseText) {
                        $("#PicUrl").val(responseText);
                        $("#userheadimg").attr("src", "../../images/upload/Repair/" + responseText);
                        $.ligerDialog.closeWaitting();
                    },
                    error: function () {
                        $.ligerDialog.closeWaitting();
                        $.ligerDialog.error('操作失败！');
                    }
                });
            }
        }
    </script>
    <style type="text/css">
        .auto-style1 {
            font-family: Verdana;
            color: #FF0000;
        }
    </style>
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
                    <div style="width:170px;float:left">点击<span class="auto-style1">上传/显示</span>跟进照片</div> 
                    <div style="width:40px;float:left">
                        <input type="checkbox" id="remind"/>
                    </div>
 
                </td>
            </tr>
            <tr id="tr1">
                <td colspan="2" align="center" valign="middle" style="width: 85px"><input type="hidden" id="PicUrl" name="PicUrl" /><img id="userheadimg" ondblclick="uploadimg()" alt="双击上传问题图片" title="双击上传问题图片" style="border-radius: 4px; box-shadow: 1px 1px 3px #111; width: 225px; height: 300px; margin-left: 5px; background: #d2d2f2; border: 3px solid #fff; behavior: url(../css/pie.htc);" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
