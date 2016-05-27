<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
      <link href="../../CSS/styles.css" rel="stylesheet" />
     <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
   
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
  
     <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
     <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
   
      <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
      <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
   
    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">

        var manager = ""; 
        $(function () {
            var urlstr = "";
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
          
            $("form").ligerForm();
            if (getparastr("cid") != null) {
                loadForm(getparastr("cid"));
             toolbar();
            }
         


            initLayout();
            $(window).resize(function () {
                initLayout();
            });



            loadGrid();
 
        })

 

        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=177&rnd=" + Math.random(), function (data, textStatus) {
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

                $("#maingrid4").ligerGetGridManager().onResize();
            });
        }
        var activeDialogs = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                zindex: 9002,
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '����', onclick: function (item, dialog) {
                                f_save(item, dialog);
                            }
                        },
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                f_close(item, dialog);
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialogs = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        //�ر�ˢ��
        function f_close(item, dialog) {
            fload();
            dialog.close();
        }
       
        function loadGrid() {

            g = $("#maingrid4").ligerGrid({
                columns: [
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },

                    { display: '�ͻ�', name: 'Customer', width: 120 },
 
                   { display: '��̬ͼ����', name: 'DyGraphicsName', width: 80 },

                      {
                          display: '��̬ͼ', width: 50, render: function (item) {
                              var html;
                              if (item.jgqjt !== "") {
                                  html = "<a href='" + item.DyUrl + "' target='_blank'>";
                                  html += "�鿴";
                                  html += "</a>";
                              }
                              else html = "����";
                              return html;
                          }
                      },
                        {
                            display: '��ע', name: 'Remarks', align: 'left', width: 200, type: 'text'
                            , editor: { type: 'text' }
                        }



                ],
                dataAction: 'server',
                url: "../../data/crm_customer.ashx?Action=griddy&cid=" + getparastr("cid") + "&rnd=" + Math.random(),
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                width: '100%',
                height: '100%',
                heightDiff: -1,
                enabledEdit: true,
                allowHideColumn: true,
                  onContextmenu: function (parm, e) {
                    actionproduct_id = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });

        }
        
        function loadForm(oaid) {
            $("#T_customerid").val(oaid);
            $("#T_customer").val(decodeURI(getparastr("name")));
            $("#T_tel").val(decodeURI(getparastr("tel")));
            $("#T_sjs").val(decodeURI(getparastr("sjs")));
        }


        function add() {
            f_openWindow("CRM/Customer/Customer_DynamicGraphics_add.aspx?cid=" + getparastr("cid"), "������ͼ", 660, 300);

        }

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('CRM/Customer/Customer_DynamicGraphics_add.aspx?id=' + row.id+'&cid='+getparastr("cid"), "�޸Ķ�ͼ", 660, 300);
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }

        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("ȷ��ɾ����", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/CRM_Customer.ashx", type: "POST",
                            data: { Action: "deldy", id: row.id,cid:getparastr("cid"), rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    fload();
                                 
                                }
                                
                                else {
                                    top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                                }

                            },
                            error: function () {
                                top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                            }
                        });
                    }
                });
            }
            else {
                $.ligerDialog.warn("��ѡ��ͻ�");
            }
        }
        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();

                $.ajax({
                    url: "../../data/CRM_Customer.ashx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                    },
                    success: function (responseText) {

                        fload();
                      },
                    error: function () {
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    },
                    complete: function () {
                        top.$.ligerDialog.closeWaitting();
                    }
                });

            }
        }

        function doserch() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/crm_customer.ashx?Action=griddy&cid=" + $("#T_customerid").val());
        }
        function fload() {

            doserch();

            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);

        }
    </script>
  
</head>
<body style="padding: 0px;overflow:hidden;">
    <form id="form1" onsubmit="return false">
    
        <div>
            <div id="toolbar"></div>
             <input type="hidden" id="h_address" value="" />
        <table style="width: 550px; margin: 5px;" class='bodytable1'>
            <tr>
                <td colspan="8" class="table_title1">������Ϣ
                     
                </td>
              
                  </tr>
            <tr>
                <td>
                    <div style="width: 70px; text-align: right; float: right">�ͻ���</div>
                </td>
                <td  >
                         <input type="text" id="T_customer" name="T_customer"  ltype="text" ligerui="{width:150,disabled:true}" validate="{required:true}" />
                     <input id="T_customerid" name="T_customerid" type="hidden" />
               
                    
                </td>
             
                 
                <td>  <div style="width: 70px; text-align: right; float: right">�绰��</div></td>
                <td><input type="text"  id="T_tel" name="T_tel"  ltype="text" ligerui="{width:100,disabled:true}"   /></td>
              <td> <div style="width: 70px; text-align: right; float: right">���ʦ��</div></td>
              <td><input type="text"  id="T_sjs" name="T_sjs"  ltype="text" ligerui="{width:100,disabled:true}"   /></td>
              
               
                 </tr>
        
        </table>
        </div>
   
            <div id="divcenter" position="center">
           
                <div id="maingrid4" style="margin: -1px;"></div>
            </div>
        
  </form>
   
</body>
</html>