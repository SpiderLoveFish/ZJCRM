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
        var activeDialog = null;
        function f_openWindow_view(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [

                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                f_close(item, dialog);
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = top.jQuery.ligerDialog.open(dialogOptions);
        }
        function loadGrid() {

            g = $("#maingrid4").ligerGrid({
                columns: [
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },

                 //   { display: '�ͻ�', name: 'Customer', width: 120 },
 
                   { display: '����', name: 'DyGraphicsName', width: 160 },

                      {
                          display: 'Ч��ͼ', width: 50, render: function (item) {

                                   
                               var html;
                              if (item.DyUrl !== "") {
                                  var html = "<a href='javascript:void(0)' onclick=view(" + item.DyUrl + ")>�鿴</a>";
                                  html += "</a>";
                              }
                              else html = "����";
                              return html;
                          }
                      },
                         {
                             display: '����ͼ', name: 'fpId', width: 80, render: function (item) {
                                 var html;
                                 if (item.fpId != "") html = "��";
                                 else html = "��";
                                 return html;
                             }
                         },
                           {
                               display: '3Dͼ', name: 'desid', width: 80, render: function (item) {
                                   var html;
                                   if (item.desid != "") html = "��";
                                   else html = "��";
                                   return html;
                               }
                           },
                           {
                               display: 'Ԥ��ͼ', name: 'img', width: 80, render: function (item) {
                                   var html;
                                   if (item.simg !== "") {
                                       var html = "<a href='javascript:void(0)' onclick=view('" + item.img + "')>�鿴</a>";
                                       html += "</a>"
                                   }
                                   else html = "����";
                                   return html;
                               }
                           },
                           {
                               display: 'ȫ��ͼ', name: 'pano', width: 80, render: function (item) {
                                   var html;
                                   if (item.pano !== "") {
                                       var html = "<a href='javascript:void(0)' onclick=view('" + item.pano + "')>�鿴</a>";
                                       html += "</a>"
                                   }
                                   else html = "����";
                                   return html;
                               }
                           },
                        {
                            display: '��ע', name: 'Remarks', align: 'left', width: 350, type: 'text'
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
            f_openWindow("CRM/Customer/Customer_DynamicGraphics_add.aspx?cid=" + getparastr("cid"), "����Ч��ͼ", 500, 200);

        }
        function kjl() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                     f_openWindow_view("CRM/ConsExam/kjl_edit.aspx?cid=" + getparastr("cid") + "&style=insert" + "&dest=0", "����Ч��ͼ", 1200, 710);
             }
            else {
                f_openWindow_view("CRM/ConsExam/kjl_edit.aspx?cid=" + getparastr("cid") + "&style=insert" + "&dest=0", "����Ч��ͼ", 1200, 710);

            }
        }
        //�޸�3Dͼ
        function kjl3d() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
              
                if (row.desid == null || row.desid == "")
                    $.ligerDialog.warn('û�ж�Ӧ��3Dͼ�������ڶ�Ӧ����ͼ��������');
                else
                    f_openWindow_view("CRM/ConsExam/kjl_edit.aspx?cid=" + getparastr("cid") + "&style=Edit" + "&dest=1" + "&desid=" + row.desid, "�޸�3Dͼ", 1200, 710);
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }
        //�޸Ļ���ͼ
        function kjlhx() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                //alert(row.fpId);
                if( row.fpId==null||row.fpId=="")
                    $.ligerDialog.warn('û�ж�Ӧ�Ļ���ͼ������������');
                else  
                    f_openWindow_view("CRM/ConsExam/kjl_edit.aspx?cid=" + getparastr("cid") + "&style=Edit" + "&dest=2" + "&fid=" + row.fpId, "�޸Ļ���ͼ", 1200, 650);
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }
        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('CRM/Customer/Customer_DynamicGraphics_add.aspx?id=' + row.id + '&cid=' + getparastr("cid"), "�޸�Ч��ͼ", 500, 200);
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }

        function view(url) {
            f_openWindow_view('CRM/ConsExam/kjl_view.aspx?strurl=' +url, "�鿴ͼ", 1120, 620);

        }

        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("ȷ��ɾ����", function (yes) {
                    if (yes) {
                        if (row.fpId != "") {
                            if (row.desid != "") {
                                $.ajax({
                                    url: "../../data/SingleSignOn.ashx", type: "POST",
                                    data: { Action: "delete", fid: row.fpId, desid: row.desid, cid: getparastr("cid"), rnd: Math.random() },
                                    success: function (responseText) {
                                        if (responseText == "success") {
                                            $.ajax({
                                                url: "../../data/SingleSignOn.ashx", type: "POST",
                                                data: { Action: "deleteAPI", fid: row.fpId, desid: row.desid, cid: getparastr("cid"), rnd: Math.random() },
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

                                        else {
                                            top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                                        }

                                    },
                                    error: function () {
                                        top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                                    }
                                });
                            }//end row.desid != ""
                            else {
                                $.ajax({
                                    url: "../../data/SingleSignOn.ashx", type: "POST",
                                    data: { Action: "deleteHXT", fid: row.fpId, desid: row.desid, cid: getparastr("cid"), rnd: Math.random() },
                                    success: function (responseText) {
                                        if (responseText == "success") {
                                            $.ajax({
                                                url: "../../data/SingleSignOn.ashx", type: "POST",
                                                data: { Action: "deleteAPI", fid: row.fpId, desid: row.desid, cid: getparastr("cid"), rnd: Math.random() },
                                                success: function (responseText) {
                                                    if (responseText == "true") {
                                                        fload();

                                                    }

                                                    else {
                                                        top.$.ligerDialog.error('ɾ��ʧ�ܣ�' + responseText);
                                                    }

                                                },
                                                error: function () {
                                                    top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                                                }
                                            });

                                        }

                                        else {
                                            top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                                        }

                                    },
                                    error: function () {
                                        top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                                    }
                                });
                            }//END ELSE
                        }//END if (row.fpId != "")
                        else {//ccid����Ϊ���
                            $.ajax({
                                url: "../../data/CRM_Customer.ashx", type: "POST",
                                data: { Action: "deldy", id: row.ccid, cid: getparastr("cid"), rnd: Math.random() },
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
                        }//end else
                    }//end yes
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
                <td colspan="8" class="table_title1">�ͻ���Ϣ
                     
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
