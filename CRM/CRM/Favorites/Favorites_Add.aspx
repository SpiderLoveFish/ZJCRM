<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Favorites_Add.aspx.cs" Inherits="Favorites.Favorites_Add" %>

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
        })
        function loadForm(cid) {
            $.ajax({
                type: "GET",
                url: "Favorites_Add.aspx?cmd=form&cid=" + cid + "&rnd=" + Math.random(),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    $("#Category").ligerComboBox({ width: 150, initValue: obj.CategoryID, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=13&rnd=" + Math.random() });
                    if (obj.ID) {
                        $("#Name").val(obj.Name);
                        $("#Url").val(obj.Url);
                        $("#OrderID").val(obj.OrderID);
                        $("#Content").val(obj.Content);
                        $("#IsShowPic").val(obj.IsShowPicName);
                        if (obj.PicUrl) {
                            $("#PicUrl").val(obj.PicUrl);
                            $("#userheadimg").attr("src", "../../images/upload/favimg/" + obj.PicUrl);
                        }
                    }
                    else
                        $("#IsShowPic").val("否");
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
                url: 'CRM/Favorites/UploadImg.aspx',
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
                        $("#userheadimg").attr("src", "../../images/upload/favimg/" + responseText);
                        $.ligerDialog.closeWaitting();
                    },
                    error: function () {
                        $.ligerDialog.closeWaitting();
                        $.ligerDialog.error('操作失败！');
                    }
                });
            }
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
        <table style="width: 510px; margin: 5px;">
            <tr>
                <td>
                    <div style="width: 50px; text-align: right; float: right">名称：</div>
                </td>
                <td>
                    <input type="text" id="Name" name="Name" ltype="text" ligerui="{width:150}" validate="{required:true}" />
                </td>
                <td>
                    <div style="width: 50px; text-align: right; float: right">网址：</div>
                </td>
                <td>
                    <div style="width: 200px; text-align: left; float: left">
                        <input type="text" id="Url" name="Url" ltype="text" ligerui="{width:150}" validate="{required:true}" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 50px; text-align: right; float: right">类别：</div>
                </td>
                <td>
                    <input type="text" id="Category" name="Category" validate="{required:true}" />
                </td>
                <td>
                    <div style="width: 50px; text-align: right; float: right">排序：</div>
                </td>
                <td>
                    <div style="width: 200px; text-align: left; float: left">
                        <input type="text" id="OrderID" name="OrderID" value="10" ltype="spinner" ligerui="{type:'int',width:150}" validate="{required:true}" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 50px; text-align: right; float: right">描述：</div>
                </td>
                <td colspan="3">
                    <input type="text" id="Content" name="Content" ltype="text" ligerui="{width:380}" validate="{required:false}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 50px; text-align: right; float: right">是否显示图片：</div>
                </td>
                <td>
                    <input type="text" id="IsShowPic" name="IsShowPic" ltype="select" ligerui="{width:150,data:[{id:'是',text:'是'},{id:'否',text:'否'}]}" validate="{required:false}" />
                </td>
                <td>
                    <div style="width: 50px; text-align: right; float: right">图片：</div>
                </td>
                <td>
                    <img id="userheadimg" ondblclick="uploadimg()" alt="双击上传图片" title="双击上传图片" style="border-radius: 4px; box-shadow: 1px 1px 3px #111; width: 150px; height: 75px; margin-left: 5px; background: #d2d2f2; border: 3px solid #fff; behavior: url(../css/pie.htc);" />
                    <input type="hidden" id="PicUrl" name="PicUrl" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
