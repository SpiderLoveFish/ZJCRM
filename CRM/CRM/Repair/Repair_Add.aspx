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

    
    <script type="text/javascript" charset="utf-8" src="../../ueditor1_2_5_1-utf8-net/editor_config.js"></script>
    <script src="../../ueditor1_2_5_1-utf8-net/editor_all.js" type="text/javascript"></script>
    <script src="../../ueditor1_2_5_1-utf8-net/lang/zh-cn/zh-cn.js" type="text/javascript"></script>
    <link href="../../ueditor1_2_5_1-utf8-net/themes/default/css/ueditor.css" rel="stylesheet" />

    <script type="text/javascript">
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
            $("form").ligerForm();
            UE.getEditor('editor', {
                initialFrameWidth: 520, initialFrameHeight: 200, toolbars: [
               ['source', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', 'forecolor', 'insertimage']
                ],
                autoHeightEnabled: false
            });
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
                        UE.getEditor('editor').setContent(myHTMLDeCode(obj.t_content));
                        if (obj.PicUrl) {
                            $("#PicUrl").val(obj.PicUrl);
                            $("#userheadimg").attr("src", "../../images/upload/repair/" + obj.PicUrl);
                        }
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
                        $("#Khdz").val(obj.Provinces + '省' + obj.City + '市');
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
        function f_save() {
            if ($(form1).valid()) {
                var arr = [];
                arr.push(UE.getEditor('editor').getContent());
                var sendtxt = "&cmd=save&cid=" + getparastr("cid") + "&T_content=" + escape(arr);;
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }

    </script>
    <style type="text/css">
        .auto-style1 {
            width: 67px;
        }
    </style>
</head>
<body>
    <form id="form1" onsubmit="return false;">
        <table style="width: 550px; margin: 5px;" class='bodytable1'>
            <tr>
                <td colspan="6" class="table_title1">客户信息</td>
            </tr>
            <tr>
                <td>
                    <div style=" width: 100px; text-align: right; float: right">客户电话：</div>
                </td>
                <td>
                    <input type="text" id="Khdh" name="Khdh" ltype="text" ligerui="{width:150}" validate="{required:true}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">客户姓名：</div>
                </td>
                <td class="auto-style1">
                    <div style="text-align: left; float: left">
                        <input type="text" id="Khmc" name="Khmc" ltype="text" ligerui="{width:150}" validate="{required:true}" />
                        <input id="Khbh" name="Khbh" type="hidden" />
                    </div>
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">客户姓别：</div
                ></td>
                <td>
                    <input type="text" id="Khxb" name="Khxb" ltype="select" ligerui="{width:150,data:[{id:'男',text:'男'},{id:'女',text:'女'}]}" validate="{required:true}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style=" text-align: right; float: right">客户地址：</div>
                </td>
                <td colspan="3">
                    <input type="text" id="Khxq" name="Khxq" ltype="text" ligerui="{width:415}" validate="{required:true}" />
                </td>
                <td><span style="width: 100px; text-align: right; float: right">所在省市：</span>
              </td>
                <td><input type="text" id="Khdz" name="Khdz" ltype="text" ligerui="{width:150}" validate="{required:false}" />
                    </td>
            </tr>
            <tr>
               <td colspan="6" class="table_title1">报修信息</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">希望维修日期：</div>
                </td>
                <td>
                    <input type="text" id="Wxrq" name="Wxrq" ltype="date" ligerui="{width:150}" validate="{required:true}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">维修时间：</div>
                </td>
                <td class="auto-style1">
                    <input type="text" id="Wxsj" name="Wxsj" ltype="select" ligerui="{width:150,data:[{id:'08:00-10:00',text:'08:00-10:00'},{id:'10:00-12:00',text:'10:00-12:00'},{id:'14:00-16:00',text:'14:00-16:00'},{id:'16:00-18:00',text:'16:00-18:00'}]}" validate="{required:true}" />
                </td>
                <td><div style="width: 100px; text-align: right; float: right">维修类别：</div></td>
                <td><input type="text" id="Wxlb" name="Wxlb" validate="{required:true}"/></td>
            </tr>
            <tr>
              <td><div style="width: 100px; text-align: right; float: right">是否客户：</div></td>
              <td class="auto-style1"><input type="text" id="Sfkh" name="Sfkh" ltype="select" ligerui="{width:150,data:[{id:'是',text:'是'},{id:'否',text:'否'}]}" validate="{required:true}" /></td>
                <td>  <div style=" width: 100px; text-align: right; float: right">电子邮箱：</div>
                </td><td>
                  <span class="auto-style1">
                  <input type="text" id="Khyx" name="Khyx" ltype="text" ligerui="{width:150}" validate="{required:false}" />
                  </span></td>
                <td class="auto-style1">&nbsp;</td>
                <td>&nbsp;
                </td>
          
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">维修原因：</div>
                </td>
                <td colspan="5">
                    <textarea id="Wxyy" name="Wxyy" rows="4" class="l-textarea"  validate="{required:true}" style="width:670px" ></textarea >
                </td>
            </tr>
             <tr>
                <td colspan="2">
                      &nbsp;<input type="hidden" id="PicUrl" name="PicUrl" /><img id="userheadimg" ondblclick="uploadimg()" alt="双击上传问题图片" title="双击上传问题图片" style="border-radius: 4px; box-shadow: 1px 1px 3px #111; width: 225px; height: 300px; margin-left: 5px; background: #d2d2f2; border: 3px solid #fff; behavior: url(../css/pie.htc);" /></td>
                <td colspan="4">可在此补充图文描述：</br><textarea name="editor" id="editor" style="width: 300px;" cols="20" rows="1"></textarea></td>
                    </tr>
        </table>
    </form>
</body>
</html>
