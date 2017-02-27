<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
     <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
   <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
     <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/json2.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
   

    <script type="text/javascript">
        var manager, g;
        var pushry = [];
        $(function () {

            $("#maingrid4").ligerGrid({
                columns: [
                   {
                       display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                       { return (page - 1) * pagesize + rowindex + 1; }
                   },
                     { display: '���ϱ��', name: 'C_code', width: 80, align: 'left' },
                      { display: '��������', name: 'product_name', width: 100, align: 'left' },
                     { display: '�����ͺ�', name: 'ProModel', width: 100, align: 'left' },
                        { display: '���Ϲ��', name: 'specifications', width: 100, align: 'left' },
                         { display: '����Ʒ��', name: 'Brand', width: 100, align: 'left' },
                          { display: '���', name: 'category_name', width: 80, align: 'left' },
                        { display: '��λ', name: 'unit', width: 40, align: 'left' },
                        {
                            display: '��������', name: 'sqsl', width: 60, align: 'left'
                            , type: 'float'
                             
                        },
                        {
                            display: '�ɹ�����', name: 'cgsl', width: 60, align: 'left'
                            , type: 'float' 

                        },
                        {
                            display: '��������', name: 'llsl', width: 60, align: 'left'
                            , type: 'float' 

                        },
                    //{
                    //    display: '�ύ�ɹ�', width: 60, render: function (item) {
                    //        var html;
                    //        if (item.IsStatus == 0) {
                    //            html = "<a href='javascript:void(0)' onclick=Submit(" + item.id + ")>�ύ</a>"
 
                    //        }
                    //        else html = "<a href='javascript:void(0)' onclick=Revoke(" + item.id + ") ><font color='CC0000'>����</font></a>";
                           

                    //        return html;
                    //    }

                    //},
                    {
                        display: '״̬', width: 80, render: function (item) {
                            var html;
                            switch(item.IsStatus)
                            { 
                                
                                case '1':
                                    html = "<font color='AA0000'>�ɹ�δ��</font>";
                                    break;
                                case '2':
                                    html = "<font color='BB0000'>����δ��</font>";
                                    break;
                                case '3':
                                    html = "<font color='CC0000'>δ����</font>";
                                    break;
                                case '4':
                                    html = "<font color='DD0000'>�ɹ�����</font>";
                                    break;
                                case '5':
                                    html = "<font color='EE0000'>��������</font>";
                                    break;
                                case '7':
                                    html = "<font color='FF0000'>�ѽ᰸</font>";
                                    break;
                                default:
                                    html = "δ֪" + item.IsStatus;
                                    break;
                            }
                         
                            return html;
                        }

                    },
                        { display: '�����', name: 'name', width: 60, align: 'left' },
                        {
                            display: '���ʱ��', name: 'DoTime', width: 90, render: function (item) {
                                var DoTime = formatTimebytype(item.DoTime, 'yyyy-MM-dd');
                                return DoTime;
                            }
                        },
                            { display: '�ͻ���ַ', name: 'address', width: 120, align: 'left' },
                         {
                             display: 'ͼ��', width: 40, render: function (item) {
                                 var html = "<a href='javascript:void(0)' onclick=view(" + item.product_id + ")>�鿴</a>"
                                 return html;
                             }
                         }
              

                ],
               
                dataAction: 'server',
                pageSize: 100,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/PurchaseList.ashx?Action=RefMaterialsListgrid",
                width: '100%',
                height: '100%',
                enabledEdit: true,
                onBeforeEdit: f_onBeforeEdit,
                onBeforeSubmitEdit: f_onBeforeSubmitEdit,
                onAfterEdit: f_onAfterEdit,
                heightDiff: -1,
                checkbox: true, name: "ischecked", checkboxAll: false, isChecked: f_isChecked, onCheckRow: f_onCheckRow, onCheckAllRow: f_onCheckAllRow,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }

            });
            $("#maingrid4 .l-grid-hd-cell-btn-checkbox").hide();
            initLayout();
            $(window).resize(function () {
                initLayout();
            });

            toolbar();
        });


        //ֻ����༭ǰ3��
        function f_onBeforeEdit(e) {
            //if (e.rowindex <= 2) return true;
            //return false;
            return true;
        }
        //����
        function f_onBeforeSubmitEdit(e) {
            if (e.column.name == "AmountSum") {
                if (e.value < 0) {
                    alert("��������Ϊ������");
                    return false;
                }
            }
            return true;
        }
        //�༭���¼� 
        function f_onAfterEdit(e) {
            if (e.column.name == "AmountSum") {
                var manager = $("#maingrid4").ligerGetGridManager();
                var row = manager.getSelectedRow();
               
                if (row) {
                    $.ajax({
                        url: "../../data/PurchaseList.ashx", type: "POST",
                        data: { Action: "save", cid: getparastr("cid"), id: row.id, editsum: e.value, rnd: Math.random() },
                        success: function (responseText) {
                            if (responseText == "true") {
                                top.$.ligerDialog.closeWaitting();
                                f_load();
                            }

                        },
                        error: function () {
                            top.$.ligerDialog.closeWaitting();
                            top.$.ligerDialog.error('�޸�ʧ�ܣ�', "", null, 9003);
                        }
                    });
                }
                else {
                    $.ligerDialog.warn("��ѡ��һ��Ч�У�");
                }
            }
        }

        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=199&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                items.push({ type: 'textbox', id: 'stext', text: '�������ݣ�' });
                items.push({ type: 'textbox', id: 'bgtxt', text: '��ʼʱ�䣺' });
                items.push({ type: 'textbox', id: 'endtxt', text: '����ʱ�䣺' });
                items.push({ type: 'textbox', id: 'sectype', text: 'ɸѡ״̬��' });
                items.push({ type: 'button', text: '����', icon: '../../images/search.gif', disable: true, click: function () { doserch() } });
                $("#toolbar").ligerToolBar({
                    items: items

                });
            
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
                $('#sectype').ligerComboBox({
                    width: 120,
                    //isMultiSelect: true,
                    selectBoxWidth: 120,
                    selectBoxHeight: 120,
                    valueField: 'id',
                    textField: 'text',
                    treeLeafOnly: true,
                    tree: {
                        data: [
                   { id: 99, text: 'ȫ��' },
                   { id: 1, text: '�ɹ�δ��' },
                   { id: 2, text: '����δ��' },
                   { id: 3, text: 'δ����' },
                   { id: 4, text: '�ɹ�����' },
                   { id: 5, text: '��������' },
                    { id: 7, text: '�ѽ᰸' }

                        ],
                        checkbox: false
                    }
                });
                $("#stext").ligerTextBox({ width: 200 });
                $("#bgtxt").ligerTextBox({ width: 100,ltype:'date',  nullText: "" })
                $("#endtxt").ligerTextBox({ width: 100,ltype:'date', nullText: "" })
                $("#maingrid4").ligerGetGridManager().onResize();
            });
        }
       
            function doserch() {
            
                var sendtxt = "&Action=RefMaterialsListgrid&rnd=" + Math.random();
                var stxt = $("#form1 :input").fieldSerialize();
                var serchtxt = $("#serchform :input").fieldSerialize() + "&" + stxt + sendtxt;
                var manager = $("#maingrid4").ligerGetGridManager();
                manager.GetDataByURL("../../data/PurchaseList.ashx?" + serchtxt);
            }
        
        //�ύ
        function Submit(id)
        {
          
            $.ajax({
                type: 'post',
                url: "../../data/PurchaseList.ashx?Action=updatestatus&id=" + id + "&isstatus=1&rdm=" + Math.random(),
                success: function (data) {
                    if (data == "false")
                        f_error("����ʧ�ܣ�");

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    f_error("����ʧ�ܣ�");
                }
            });
            // f_success();
            f_load();
        }
        //����
        function Revoke(id)
        {
            $.ajax({
                type: 'post',
                url: "../../data/PurchaseList.ashx?Action=updatestatus&id=" + id + "&isstatus=0&rdm=" + Math.random(),
                success: function (data) {
                    if (data == "false")
                    f_error("����ʧ�ܣ�");

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    f_error("����ʧ�ܣ�");
                }
            });
            // f_success();
            f_load();
        }

        function del()
        {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("ɾ�����ָܻ���ȷ��ɾ����", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/PurchaseList.ashx", type: "POST",
                            data: { Action: "del", id: row.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    f_load();
                                }

                                else if (responseText == "false:order") {
                                    top.$.ligerDialog.closeWaitting();
                                    top.$.ligerDialog.error('״̬�Ѿ��ı䣬�޷�ɾ����');
                                }
                            },
                            error: function () {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('ɾ��ʧ�ܣ�', "", null, 9003);
                            }
                        });
                    }
                })
            } else {
                $.ligerDialog.warn("��ѡ�����");
            }
        }

        function f_error(message) {
            $(document).ready(function () {
                $.ligerDialog.error(message);
            });
        }
        function f_saving() {
            $.ligerDialog.waitting("���ڱ�����...");
        }
        //���ɲɹ���
        function addcgd()
        { var rowid = checkedID.join(',');
        if (rowid.length > 0)
         //  alert(rowid);
            f_openWindow('crm/purchase/SavePickList.aspx?rowid=' + rowid, "���ɲɹ���", 600, 350);
            }
        //�᰸
        function close() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row.length == 1) {
                $.ajax({
                    type: 'post',
                    url: "../../data/PurchaseList.ashx?Action=updatestatus&id=" + row.id + "&isstatus=7&rdm=" + Math.random(),
                    success: function (data) {
                        if (data == "false")
                            f_error("����ʧ�ܣ�");

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        f_error("����ʧ�ܣ�");
                    }
                });
                // f_success();
                f_load();
            } else
                $.ligerDialog.warn('��ѡ���Ʒ��');
        } 
         
       
        function f_load() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
  
        }
        function f_success() {
            //setTimeout(function () {
            //    $.ligerDialog.confirm("�Ƿ�����༭", "����ɹ�", function (ok) {
            //        if (!ok) {
            //            parent.$.ligerDialog.close();
            //        }
            //    });
            //}, 200);
        }
        //�ر�ˢ��
        function f_close(item, dialog)
        {
            f_load();
            dialog.close();
        }
        //������Ϣ
        function f_save(item, dialog)
        {
            var issave = dialog.frame.f_save();
            //alert(issave);
            if (issave) {
                $.ajax({
                    type: 'post',
                    url: "../../data/Purchase.ashx?Action=savetemp&" + issave,
                    success: function (data) {
                        if (data == 'false') {
                            dialog.frame.getmaxid();
                            $.ligerDialog.error("������󣡣������±��棡");
                        }
                        else {

                            savedetail(dialog, issave);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        top.$.ligerDialog.error("������󣡣���");
                    }
                });
               
                 
            }
        }

        function savedetail(dialog, issave) {

            //var pidlist = "," + pidlist;
            var url = '../../data/Purchase.ashx?Action=savedetail&'+issave;
            $.ajax({
                type: 'post',
                url: url,
                success: function (data) {
                    dialog.close();
                    dialog.closeWaitting('���ݱ�����,���Ժ�...');
                   // top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    top.$.ligerDialog.error("������󣡣���");
                }
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


        function view(id) {
            var dialogOptions = {
                width: 770, height: 510, title: "���ϵ���ͼ�Ľ���", url: '../view/product_view.aspx?pid=' + id + '&rnd=' + Math.random(), buttons: [
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        /*
        ����ҳ��ѡ
        ������onCheckRow��ѡ�е��м���������������isChecked�������������г�ʼ��ѡ��
        */
        var checkedID = [];
        function f_onCheckAllRow(checked) {
            for (var rowid in this.records) {
                if (checked)
                    addcheckedID(this.records[rowid]['product_id']);
                else
                    removecheckedID(this.records[rowid]['product_id']);
            }
        }
        function findcheckedID(product_id) {
            for (var i = 0; i < checkedID.length; i++) {
                if (checkedID[i] == product_id) return i;
            }
            return -1;
        }
        function addcheckedID(product_id) {
            if (findcheckedID(product_id) == -1)
                checkedID.push(product_id);
        }
        function removecheckedID(product_id) {
            var i = findcheckedID(product_id);
            if (i == -1) return;
            checkedID.splice(i, 1);
        }
        function f_isChecked(rowdata) {
            if (findcheckedID(rowdata.product_id) == -1)
                return false;
            return true;
        }
        function f_onCheckRow(checked, data) {
            if (checked) addcheckedID(data.product_id);
            else removecheckedID(data.product_id);
        }
    </script>
    
</head>
<body style="padding: 0px; overflow: hidden;">
   
      <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar"> 
               
            </div>
              <div id="grid">
            <div id="maingrid4" style="margin: -1px;"></div>
                  </div>
        </div>
    </form>
</body>
</html>
