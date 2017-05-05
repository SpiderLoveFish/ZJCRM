<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>

    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>

    <script type="text/javascript" charset="utf-8" src="../../ueditor1_2_5_1-utf8-net/editor_config.js"></script>
    <script src="../../ueditor1_2_5_1-utf8-net/editor_all.js" type="text/javascript"></script>
    <script src="../../ueditor1_2_5_1-utf8-net/lang/zh-cn/zh-cn.js" type="text/javascript"></script>
    <link href="../../ueditor1_2_5_1-utf8-net/themes/default/css/ueditor.css" rel="stylesheet" />

    <script type="text/javascript">
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

           
            if (getparastr("IsJP") == "Y")//金牌管理
            {
                $("#tr4").css("display", "none")
            }
            else {
                $("#tr1").css("display", "none")
                $("#tr2").css("display", "none")
                $("#tr3").css("display", "none")
            }


            //$("#T_Contract_name").focus();
            $("form").ligerForm();

            UE.getEditor('editor', {
                initialFrameWidth: 738, toolbars: [
               ['source', '|', 'undo', 'redo', '|',
                'bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
                'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
                'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
                'directionalityltr', 'directionalityrtl', 'indent', '|',
                'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
                'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
                'insertimage', 'emotion', 'template', 'background', '|',
                'horizontal', 'date', 'time', 'spechars', '|',
                'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', '|',
                'preview', 'searchreplace']
                ],
                autoHeightEnabled: false
            });
            var gCommunity = $('#T_qxmb').ligerComboBox({
                width: 120,
                onBeforeOpen: f_selectComm

            });
            $.ajax({
                type: "GET",
                url: "../../data/CE_Para.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'com_CRM_CE_CONFIG',strwhere:'LX001', rnd: Math.random() }, /* 注意参数的格式和名称 */
                //url: "../../data/SGJD_LIST.ashx?Action=formgrid&cid=" + getparastr("cid") + "&rdm=" + Math.random(),

                success: function (result) {
                    var obj = eval(result);
                    $("#T_p1").ligerComboBox({
                        width: 120,
                        data: obj
                    });
                    $("#T_p2").ligerComboBox({
                        width: 120,
                        data: obj
                    });
                    $("#T_p3").ligerComboBox({
                        width: 120,
                        data: obj
                    });
                    $("#T_p4").ligerComboBox({
                        width: 120,
                        data: obj
                    });
                    $("#T_p5").ligerComboBox({
                        width: 120,
                        data: obj
                    });
                    $("#T_p6").ligerComboBox({
                        width: 120,
                        data: obj
                    });

                },
                error: function (e) {
                    alert("Init2");
                }
            });
            

            if (getparastr("xmid")) {
                //$("#T_xmmc").val(getparastr("xmid"));
                loadForm(getparastr("xmid"));

            }
            
         
            
        });
        function f_selectComm() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择模板', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/ConsExam/SelectQxfw.aspx", buttons: [
                    { text: '确定', onclick: f_selectCommOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectCommOK(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('选择模板!');
                return;
            }
            $("#T_qxmb_val").val(data.id);
            $("#T_qxmb").val(data.title);
            dialog.close();
        }
        function f_selectContactCancel(item, dialog) {
            dialog.close();
            //fload();
        }
        function f_save() {
            if ($(form1).valid()) {
                var arr = [];
                arr.push(UE.getEditor('editor').getContent());
                var sendtxt = "&Action=save&xmid=" + getparastr("xmid") + "&xmmc=" + $("#T_xmmc").val() + "&xmpx=" + $("#T_xmpx").val() + "&T_content=" + escape(arr);
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }
 
        function loadForm(oaid) {
            $.ajax({
                type: "get",
                url: "../../data/XM_LIST.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', xmid: oaid , rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                   // alert (obj.params_id); //String 构造函数
                    $("#T_xmmc").val(obj.XMMC);
                    $("#T_xmpx").val(obj.XMPX);
                    $("#T_p1_val").val(obj.p1.split(";")[0]); $("#T_p1").val(obj.p1.split(";")[1]);
                    $("#T_p2_val").val(obj.p2.split(";")[0]); $("#T_p2").val(obj.p2.split(";")[1]);
                    $("#T_p3_val").val(obj.p3.split(";")[0]); $("#T_p3").val(obj.p3.split(";")[1]);
                    $("#T_p4_val").val(obj.p4.split(";")[0]); $("#T_p4").val(obj.p4.split(";")[1]);
                    $("#T_p5_val").val(obj.p5.split(";")[0]); $("#T_p5").val(obj.p5.split(";")[1]);
                    $("#T_p6_val").val(obj.p6.split(";")[0]); $("#T_p6").val(obj.p6.split(";")[1]);
                    $("#T_qxmb_val").val(obj.params_id.split(";")[0]); $("#T_qxmb").val(obj.params_id.split(";")[1]);
                   // $("#T_CEStage_detail_id").val(obj.StageDetailID);
                    UE.getEditor('editor').setContent(myHTMLDeCode(obj.REMARK));
                   
                   
                }
            });
        }

         


    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">     
        <table align="left" border="0" cellpadding="3" cellspacing="1">
           

            <tr>
                <td>
                    <div align="left" style="width: 60px">项目名称：</div>
                </td>
                <td colspan="2">
                    <input type="text" id="T_xmmc" name="T_xmmc" validate="{required:true}" ltype='text' ligerui="{width:180}" /></td>
                   <input type="hidden" id="T_xmid" name="T_xmid" />
                <td>
                    <div align="left" style="width: 90px">项目排序：</div>
                </td>
                <td colspan="2">
                    <input type='text' id="T_xmpx" name="T_xmpx" ltype='text' ligerui="{width:140}" /></td>
            </tr>
     <tr id="tr1">
                <td height="26">

                    <div align="left" style="width: 60px">@P1：</div>
                </td>
                <td width="178" height="26">
                    <input type="text" id="T_p1" name="T_p1"      />
                </td>
                <td width="113"><div align="left" style="width: 60px">@P2：</div></td>
                <td width="96"><input type="text" id="T_p2" name="T_p2"        /></td>
                <td width="97"><div align="left" style="width: 60px">@P3：</div></td>
                <td width="194"><input type="text" id="T_p3" name="T_p3"      /></td>
            </tr>
               <tr id="tr2">
                <td height="25"><div align="left" style="width: 60px">@P4：</div></td>
                <td height="25"><input type="text" id="T_p4" name="T_p4"       /></td>
                <td height="25"><div align="left" style="width: 60px">@P5：</div></td>
                <td height="25"><input type="text" id="T_p5" name="T_p5"      /></td>
                <td height="25"><div align="left" style="width: 60px">@P6：</div></td>
                <td height="25"><input type="text" id="T_p6" name="T_p6"       /></td>
            </tr>
            <tr id="tr3">
                 <td height="25"><div align="left" style="width: 60px">选择七星模板：</div></td>
                   <td height="25" colspan="5"><input type="text" id="T_qxmb" name="T_qxmb"       /></td>
            </tr>
            <tr id="tr4">
                <td colspan="6">
                    <textarea id="editor" style="width: 637px;"></textarea>
                </td>
            </tr>

        </table>
    </form>
</body>
</html>
