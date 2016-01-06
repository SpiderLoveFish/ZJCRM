<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
        <link href="../../CSS/styles.css" rel="stylesheet" />
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/ligerui.all.js"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerCheckBoxList.js"></script>
   <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerRadioList.js"></script>
   <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerListBox.js"></script>
 
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
      <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
   
     <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>

    
    
    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>

    <script type="text/javascript">
        var manager, g;
        $(function () {
            
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
           
            $("form").ligerForm();

           

            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            if (getparastr("cid") != null) {
                loadForm(getparastr("cid"));

            }
            
            divchecksgxmInit();
            divsgryInit();
            T_privateInit();
            
            
           
           
        });

        function divsgryInit()
        {
             

        }


        function T_privateInit()
        {
            var columns = [
                 { header: 'ID', name: 'id', width: 30 },
                 { header: '����', name: 'text', width: 80 },
                      {
                          header: '�ɫ', name: 'jdys', width: 60,
                          render: function (value) {
                              var html = [];
                              html = "<div style='background:#" + value + "'> "
                              html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                              html += "</div>"
                              return html;
                          }
                      }
            ];
            $('#T_private').ligerComboBox({
                width: 150,
                columns: columns,
                //emptyText: '���գ�',
                url: "../../data/CE_Para.ashx?Action=combojd&rnd=" + Math.random()
            });
        }

        function divchecksgxmInit()
        {
            $.ajax({
                type: 'post',
                url: "../../data/XM_LIST.ashx?Action=formgrid&rdm=" + Math.random(),
                success: function (result) {
                    var datar = eval(result);
                    $("#divchecksgxm").ligerCheckBoxList({
                        rowSize: 11,
                        data: datar,
                        valueField: 'XMID',
                        textField: 'XMMC',
                        //valueFieldCssClass: 'yellow',
                        //css: 'yellow',
                    });
                    $.ajax({
                        type: "GET",
                        url: "../../data/SGJD_LIST.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                        data: { Action: 'formgrid', cid: getparastr("cid"), rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                        //url: "../../data/SGJD_LIST.ashx?Action=formgrid&cid=" + getparastr("cid") + "&rdm=" + Math.random(),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            var obj = eval(result);
                            // top.$.ligerDialog.error(obj.A[0].ids);
                            liger.get("divchecksgxm").setValue(obj.A[0].ids);
                            for (var n = 0; n < obj.B.length; n++) {
                                addcss(obj.B[n].id, "#" + obj.B[n].color);
                            }
                            removecheck();

                        },
                        error: function (e) {
                            alert("Init");
                        }
                    });

                    //ȫ������
                    // $("input:checkbox", this.radioList).attr("disabled", true);

                },

                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    top.$.ligerDialog.error("ʧ�ܣ�����");
                }
            });
        }


        function removecheck() {
            $('input:checkbox[name^=divchecksgxm]:checked').each(function () {
                $("input:checkbox", this.radioList).attr("checked", false);
            });
        }
        function addcss(id,color)
        {
            $('input:checkbox[name^=divchecksgxm]:checked').each(function () {
                //�ӗl��
                if (this.value == id)
                    $(this).next("label").css("backgroundColor", color);
            });
        }
        
        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/CRM_Customer.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'form', cid: oaid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(obj.constructor); //String ���캯��
                    $("#T_khbh").val(obj.id);
                    $("#T_khmc").val(obj.Customer);
                    $("#T_tel").val(obj.tel);

                    $("#T_khxq").val(obj.Community);
                    $("#T_khlh").val(obj.BNo + '��' + obj.RNo + '��');
                    $("#T_yzxm").val(obj.Customer);
                    

                }
            });
        }
 

        function f_save() {
            
            if ($("#T_private").val() == "")
            {
                f_error("����ѡ��һ����Чʩ�����ȣ�");
                return;
            }
           // var manager = $("#divchecksgxm").ligerGetCheckBoxManager();
            var sgxmvalue = liger.get("divchecksgxm").getValue();
            //f_error("����ѡ��һ����Ч��ʩ���Ŀ�ɣ�" + sgxmvalue);
            //return;
            if (sgxmvalue == null || sgxmvalue == "")
            {
                f_error("����ѡ��һ����Ч��ʩ���Ŀ�ɣ�" + sgxmvalue);
                return;
            }
            //var sgryvalue = liger.get("divsgry").getValue();
            if ($(form1).valid()) {
                var sendtxt = "&Action=save&id=" + getparastr("cid")  
                    + "&sgxm=" + sgxmvalue
                + "&sgry=" + sgryvalue
                ;
                return $("form :input").fieldSerialize() + sendtxt;
            }

            return;
                 
          
        

        }
       
        
  
        function f_error(message) {
            $(document).ready(function () {
                $.ligerDialog.error(message);
            });
        }
        function f_saving() {
            $.ligerDialog.waitting("���ڱ�����...");
        }

        function deleteRow() {
            
        }
       
        function addNewRow() {
            f_openWindow("system/getemp.aspx", "ѡ����Ա", 650, 400);
            
            
        }
        function f_getpost(item, dialog) {
            var rows = null;
            if (!dialog.frame.f_select()) {
                alert('��ѡ����!');
                return;
            }
            else {
                var rid = "";
               
                rows = dialog.frame.f_select();
                for (var i = 0; i < rows.length; i++) {
                    rid += rows[i].ID + ",";
                    var btn = $("<input type='button' class='btn1' id='" + rows[i].ID + "' value='" + rows[i].name + "||" + rows[i].zhiwu + "'>");
                    $("#divsgry").append(btn);
                    addBtnEvent(rows[i].ID);
                    //alert(rows[i].ID);
                    // manager.addRow(rows[i]);
                }
                
                dialog.close();
            }
             
        }
        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                zindex: 9002,
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '����', onclick: function (item, dialog) {
                                f_getpost(item, dialog);
                            }
                        },
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }


        function addBtnEvent(id) {
            $("#" + id).bind("click", function () {
                alert(id);
            });
        }
        
    </script>
    <style type="text/css">
        .checkboxlist label 
{ 
margin-right: 20px; 
} 
    </style>
    <style type="text/css">
  .btn1 {
    font-size: 9pt;
    color: #003399;
    border: 1px #003399 solid;
    color: #006699;
    border-bottom: #93bee2 1px solid;
    border-left: #93bee2 1px solid;
    border-right: #93bee2 1px solid;
    border-top: #93bee2 1px solid;
    background-image: url(../images/bluebuttonbg.gif);
    background-color: #e8f4ff;
    font-style: normal;
    margin-left: 10px;
    height: 22px;
}
    </style>
</head>
<body style="padding: 0px; overflow: hidden;">
   
      <div id="div1" style="margin: -1px;"></div>
    <form id="form1" onsubmit="return false">
          <table align="left" border="0" cellpadding="3" cellspacing="1" class='bodytable1'>

            <tr>
                <td colspan="4" class="table_title1">��������</td>
            </tr>
            <tr>
                <td>
                    <div align="left" style="width: 60px">�ͻ���ţ�</div>
                </td>
                <td>
                    <input type="text" id="T_khbh" name="T_khbh" validate="{required:true}" ltype='text' ligerui="{width:180,disabled:true}" /></td>

                <td>
                    <div align="left" style="width: 90px">�ͻ����ƣ�</div>
                </td>
                <td>
                    <input type='text' id="T_khmc" name="T_khmc" ltype='text' ligerui="{width:140,disabled:true}" /></td>
            </tr>
            <tr>
                <td>
                    <div align="left" style="width: 60px">�ͻ�С����</div>
                </td>
                <td>
                    <input type="text" id="T_khxq" name="T_khxq" validate="{required:true}" ltype='text' ligerui="{width:180,disabled:true}" /></td>

                <td>
                    <div align="left" style="width: 90px">�ͻ�¥�ţ�</div>
                </td>
                <td>
                    <input type='text' id="T_khlh" name="T_khlh" ltype='text' ligerui="{width:140,disabled:true}" /></td>
            </tr>
            <tr>
                <td>
                    <div align="left" style="width: 60px">ҵ��������</div>
                </td>
                <td>
                    <input type="text" id="T_yzxm" name="T_yzxm" validate="{required:true}" ltype='text' ligerui="{width:180,disabled:true}" /></td>

                <td>
                    <div align="left" style="width: 90px">��ϵ�绰��</div>
                </td>
                <td>
                    <input type='text' id="T_tel" name="T_tel" ltype='text' ligerui="{width:140,disabled:true}" /></td>
            </tr>
            <tr>
                <td>
                    <div align="left" style="width: 60px">ʩ����Ŀ��</div>
                </td>
                <td>
                    <div align="left" style="width: 160px">����������Ҫ����Ŀǰ��</div>
                </td>
                <td>
                    <div align="left" style="width: 90px">ʩ�����ȣ�</div>
                </td>
                <td>
                     <input type='text' id='T_private' name='T_private' />
                                  <input type="hidden" id="T_pid" name="T_pid" />
                 <%--   <input id="T_private" name="T_private" type="text" ltype="select"
                        ligerui="{width:180,data:[{id:'��δ����',text:'��δ����'},
                {id:'����ʩ��',text:'����ʩ��'},
                {id:'���谲��',text:'���谲��'},
                {id:'���ڽ���',text:'���ڽ���'},
                {id:'ʩ�����',text:'ʩ�����'}]}"
                        validate="{required:false}" />--%>

                </td>
            </tr>
            <tr>
                <td>
                    <div align="left" style="width: 60px">˵����</div>
                </td>
                <td colspan="3">
                    <input type="text" id="T_Remark" name="T_Remark" validate="{required:true}" ltype='text' ligerui="{width:637}" /></td>

            </tr>
            <tr>
                <td colspan="4" class="table_title1">ʩ����Ŀ</td>
            </tr>
            <tr>

                <td colspan="4">
                    <div id="divchecksgxm" style="margin: -1px; height:160px;  overflow:auto; "></div>
                    
                </td>
            </tr>
            <tr>
                <td colspan="2" class="table_title1">ʩ����Ա</td>
                <td   class="table_title1">
                    <a class="l-button" style="width:80px;" onclick="addNewRow()">����ˆT</a>
                  </td>
                <td   class="table_title1">
                      <a class="l-button" style="width:80px;" onclick="deleteRow()">ɾ���ˆT</a>
                </td>
            </tr>
            <tr>

                <td colspan="4">
                    <div id="divsgry" style="margin: -1px;height:100px;   overflow:auto; " ></div>
                </td>
            </tr>
            <%--<tr>
                <td colspan="4">
                    <textarea id="editor" style="width: 637px;"></textarea>
                </td>
            </tr>--%>
        </table>
    </form>
</body>
</html>
