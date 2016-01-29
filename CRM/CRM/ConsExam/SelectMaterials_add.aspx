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
                    // { display: '�ͻ����', name: 'CustomerID', width: 50, align: 'left' },
                      { display: '��Ʒ����', name: 'product_name', width: 80, align: 'left' },
                    
                        { display: '����', name: 'specifications', width: 250, align: 'left' },
                        { display: '��λ', name: 'unit', width: 80, align: 'left' },
                        {
                            display: '����', name: 'AmountSum', width: 80, align: 'left'
                            , type: 'int', editor: { type: 'int' } 
                             
                        }
                        //, { display: '�۸�', name: 'Price', width: 80, align: 'left' }
              

                ],
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/PurchaseList.ashx?Action=tempgrid&cid="+getparastr("cid"),
                width: '100%',
                height: '100%',
                enabledEdit: true,
                onBeforeEdit: f_onBeforeEdit,
                onBeforeSubmitEdit: f_onBeforeSubmitEdit,
                onAfterEdit: f_onAfterEdit,
                heightDiff: -1,
               
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }

            });

            initLayout();
            $(window).resize(function () {
                initLayout();
            });

            toolbar();
        });


        //ֻ�����༭ǰ3��
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
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=149&rnd=" + Math.random(), function (data, textStatus) {
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
    

       
        //������ҳ��
        function add() {
            f_openWindow("../../CRM/ConsExam/getemp.aspx?style=ALL", "ѡ���Ʒ", 650, 400);


        }
        function edit() {
            f_openWindow("../../CRM/ConsExam/getemp.aspx?style=ALL&customid=" + getparastr("cid"), "ѡ���Ʒ", 650, 400);


        }
        //��ȡ������Ա
        function f_getry(item, dialog) {
            var rows = null;
            if (!dialog.frame.f_select()) {
                alert('��ѡ����!');
                return;
            }
            else {
                  rows = dialog.frame.f_select();
                  var prouductid = "";
                
                for (var i = 0; i < rows.length; i++) {
                    prouductid += "," + rows[i].product_id;
                }
         
                $.ajax({
                    type: 'post',
                    url: "../../data/PurchaseList.ashx?Action=savelist&cid=" + getparastr("cid") + "&pid=" + prouductid + '&rdm=' + Math.random(),
                    success: function (data) {
                        //alert(data);
                        //setTimeout(function () {
                        //    f_success();
                        //}, 10);
                        dialog.frame.f_sucess();

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        dialog.frame.f_error(); 
                    }
                });
               // f_success();
                f_load();
               // dialog.close();
                
            }

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
        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                zindex: 9002,
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '�ύ', onclick: function (item, dialog) {
                                f_getry(item, dialog);
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
 
      

    </script>
    
</head>
<body style="padding: 0px; overflow: hidden;">
   
      <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar"></div>
              <div id="grid">
            <div id="maingrid4" style="margin: -1px;"></div>
                  </div>
        </div>
    </form>
</body>
</html>