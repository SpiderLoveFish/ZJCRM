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

            //$("#T_CEStage_category").ligerComboBox({
            //    width: 280,
            //    selectBoxWidth: 280,
            //    selectBoxHeight: 280,
            //    valueField: 'id',
            //    textField: 'text',
            //    initValue: getparastr("categoryid"),
            //    treeLeafOnly: false,
            //    tree: {
            //        url: '../../data/crm_CEStage_category.ashx?Action=tree&rnd=' + Math.random(),
            //        //onSelect: onSelect,
            //        idFieldName: 'id',
            //        valueField: 'text',
            //        usericon: 'd_icon',
            //        checkbox: false,
            //        itemopen: false
            //    }
            //});

            $("#T_CEStage_id").val(getparastr("categoryid") +"-"+ getparastr("catname"));
            if (getparastr("categoryid") && getparastr("catdetailid") == null)
            {
                getmaxdetailid(getparastr("categoryid"));
            }
            else
                $("#T_CEStage_detail_id").val(getparastr("catdetailid"));


            if (getparastr("categoryid") && getparastr("catdetailid")) {
            loadForm(getparastr("categoryid"), getparastr("catdetailid"));
            }
        });

        function f_save() {
            if ($(form1).valid()) {
                var arr = [];
                arr.push(UE.getEditor('editor').getContent());
                var sendtxt = "&Action=save&pid=" + getparastr("categoryid") + "&pdetailid=" + getparastr("catdetailid") + "&T_content=" + escape(arr);
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }
        function getmaxdetailid(oaid)
        { $.ajax({
            type: "get",
            url: "../../data/Crm_CEStageDetail.ashx", /* 注意后面的名字对应CS的方法名称 */
            data: { Action: 'getmaxdetailid', pid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                var obj = eval(result);
                for (var n in obj) {
                    if (obj[n] == "null" || obj[n] == null)
                        obj[n] = "";
                }
                //alert(obj.constructor); //String 构造函数
                $("#T_CEStage_detail_id").val(obj.detailid);

            }
        });
        }

        function loadForm(oaid,detailid) {
            $.ajax({
                type: "get",
                url: "../../data/Crm_CEStageDetail.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', StageID: oaid, StageDetailID: detailid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(obj.constructor); //String 构造函数
                    $("#T_CEStage_name").val(obj.Description);
                    $("#T_CEStage_id").val(obj.StageID + '-' + obj.CEStage_category);
                    $("#T_CEStage_detail_id").val(obj.StageDetailID);
                    UE.getEditor('editor').setContent(myHTMLDeCode(obj.StageContent));
                   
                   
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
                    <div align="left" style="width: 60px">考核等级：</div>
                </td>
                <td>
                    <input type="text" id="T_CEStage_id" name="T_CEStage_id" validate="{required:true}" ltype='text' ligerui="{width:280,disabled:true}" /></td>
                <td>
                    <div align="left" style="width: 90px">考核明细ID：</div>
                </td>
                <td>
                    <input type='text' id="T_CEStage_detail_id" name="T_CEStage_detail_id" ltype='text' ligerui="{width:240,disabled:true}" /></td>
            </tr>
  <tr>
                <td>
                    <div align="left" style="width:60px">明细标题：</div>
                </td>
                <td colspan="3">
                    <input type='text' id="T_CEStage_name" name="T_CEStage_name" ltype="text" ligerui="{width:637}" validate="{required:true}" /></td>
            </tr>
            <tr>
                <td colspan="4">
                    <textarea id="editor" style="width: 637px;"></textarea>
                </td>
            </tr>

        </table>
    </form>
</body>
</html>
