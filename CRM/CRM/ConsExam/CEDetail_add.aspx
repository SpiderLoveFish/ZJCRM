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
     <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
   
    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    
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

            
            $("#T_projectid").val(getparastr("pid"));
            $("#T_Stage1").val(getparastr("sid"));
            $("#T_Stage").val(getparastr("sid") + "-" + getparastr("sname"));
            getmaxverid(getparastr("sid"), getparastr("pid"), getparastr("style"))
            if (getparastr("pid") && getparastr("sid"))
                loadForm(getparastr("sid"), getparastr("pid"), $("#T_versions").val(), getparastr("style"));
            
            initLayout();
            $(window).resize(function () {
                initLayout();
            });

            toolbar();
        });

        function f_save() {
            if ($(form1).valid()) {
                var arr = [];
                arr.push(UE.getEditor('editor').getContent());
                var sendtxt = "&Action=save&sid=" + getparastr("sid") + "&style=" + getparastr("style") + "&pid=" + getparastr("pid") + "&T_content=" + escape(arr);
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }
        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=39&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }

                $("#toolbar").ligerToolBar({
                    items: items

                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
               
            });
        }


        function getmaxverid(stageid,projectid,sty)
        {
            //top.$.ligerDialog.error("11");
            $.ajax({
            type: "get",
            url: "../../data/Crm_CEDetail.ashx", /* ע���������ֶ�ӦCS�ķ������� */
            data: { Action: 'getmaxverid', sid: stageid, pid: projectid,style:sty, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                var obj = eval(result);
                for (var n in obj) {
                    if (obj[n] == "null" || obj[n] == null)
                        obj[n] = "";
                }
               // top.$.ligerDialog.error(obj.verid); //String ���캯��
                $("#T_versions").val(obj.verid);

            }
        });
        }

        function loadForm(oaid, id,verid, sty) {
           
          
            $.ajax({
                type: "get",
                url: "../../data/Crm_CEDetail.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'getdetailgrid', sid: oaid, pid: id, vid: verid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(obj.constructor); //String ���캯��
                     
                  
                    $("#T_Stage").val(obj.StageID);
                     
                    $("#T_AssTime").val(obj.AssTime);
                    $("#T_checked").ligerGetComboBoxManager().selectValue(obj.isChecked);
                    $("#T_isclose").ligerGetComboBoxManager().selectValue(obj.IsClose);

                    UE.getEditor('editor').setContent(myHTMLDeCode(obj.StageContent));
                   
                   
                }
            });
        }

        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '����', onclick: function (item, dialog) {
                                f_save(item, dialog);
                            }
                        },
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function edit() {
            
            var sid = getparastr("sid");
            var pid = getparastr("pid");
            var verid = $("#T_versions").val();
            f_openWindow('crm/ConsExam/CEDetail_add.aspx?&sid=' + sid + '&pid=' + pid + '&sname=' + verid, "�޸�����", 790, 600);
            
        }

        function add() {
            var sid = getparastr("sid");
            var pid = getparastr("pid");
            var verid = $("#T_versions").val();
            f_openWindow('crm/ConsExam/CEDetail_add.aspx?&sid=' + sid + '&pid=' + pid + '&sname=' + verid, "��������", 790, 600);
             
        }


    </script>
</head>
<body>
    <form id="form1" onsubmit="return false"> 
        <div id="layout1" style="margin: -1px">
             
        <div position="center">
                <div id="toolbar"></div>
                <div id="maingrid4" style="margin: -1px;">
           
        <table align="left" border="0" cellpadding="3" cellspacing="1">
           

            <tr>
                <td>
                    <div align="left" style="width: 60px">��Ŀ��ţ�</div>
                </td>
                <td>
                    <input type="text" id="T_projectid" name="T_projectid" validate="{required:true}" ltype='text' ligerui="{width:280,disabled:true}" /></td>
                <td>
                    <div align="left" style="width: 90px">�汾�ţ�V����</div>
                </td>
                <td>
                    <input type='text' id="T_versions" name="T_versions" ltype='text' ligerui="{width:240,disabled:true}" /></td>
            </tr>
  <tr>
                     <td>
                    <div align="left" style="width: 60px">�������</div>
                
                     </td>
                <td>
                    <input type="text" id="T_Stage" name="T_Stage" validate="{required:true}" ltype='text' ligerui="{width:280,disabled:true}" /></td>
                  <input id="T_Stage1" name="T_Stage1" type="hidden" />
                  <td>
                    <div align="left" style="width: 90px">�������֣�</div>
                </td>
                <td>
                    <input type='text' id="T_AssTime" name="T_AssTime" ltype='text' ligerui="{width:240,disabled:true}" /></td>
              </tr>
              <tr>
                     <td>
                    <div align="left" style="width: 60px">�������汾��</div>
                
                     </td>
                <td>
                   <input id="T_checked" name="T_checked" type="text" ltype="select" 
                        ligerui="{width:196,data:[{id:'1',text:'����'},{id:'0',text:'δ����'}]}" validate="{required:false}" /></td>
              <td>
                    <div align="left" style="width: 90px">���������</div>
                </td>
                <td>
                <input id="T_isclose" name="T_isclose" type="text" ltype="select" 
                        ligerui="{width:196,data:[{id:'1',text:'�᰸'},{id:'0',text:'δ�᰸'}]}" validate="{required:false}" /></td>
               </tr>

            <tr>
                <td colspan="4">
                    <textarea id="editor" style="width: 637px;"></textarea>
                </td>
            </tr>

        </table>
                     </div>
        </div></div>
    </form>
</body>
</html>