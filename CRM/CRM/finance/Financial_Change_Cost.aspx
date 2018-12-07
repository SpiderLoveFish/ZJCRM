<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />

      <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
        <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
   
    <script type="text/javascript">
        $(function () {

            $("#maingrid4").ligerGrid({
                columns: [
                    //{ display: 'ID', name: 'id', type: 'int', width: 50 },
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                    { display: '���', name: 'F_Num', align: 'left', width: 120},
                    { display: '����', name: 'F_StyleName', width: 70 },
                    { display: '��������', name: 'cwny', width: 70 },
                    { display: '�ܽ��', name: 'Amount', width: 70 },
                    { display: '������Ա', name: 'RelevantPerson', width: 70 },
                    { display: '������', name: 'CreatePerson', width: 70 },
                    { display: '��ע', name: 'Remarks', width: 200 },
                    {
                        display: '��������', name: 'CreateTime', width: 90, render: function (item) {
                            return formatTimebytype(item.CreateTime, 'yyyy-MM-dd');
                        }
                    },
                    { display: '״̬', name: 'IsStatus', width: 70 },
                     { display: '��Դ', name: 'FromWhere', width: 70 }
                ],
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                onSelectRow: function (row, index, data) {
                    //alert('onSelectRow:' + index + " | " + data.ProductName); 
                },
                url: "../../data/Financial_Change_Cost.ashx?Action=grid&IsApr=" + getparastr("IsApr"),
                width: '100%',
                height: '100%',
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });
           
            toolbar();
            
        });

        function f_select() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            return rows;
        }

        function toolbar() {
            
            var url = "../../data/toolbar.ashx?Action=GetSys&mid=225&rnd=" + Math.random();
            if (getparastr("IsApr") == "Y") 
                url = "../../data/toolbar.ashx?Action=GetSys&mid=242&rnd=" + Math.random();
            else if (getparastr("IsApr") == "V")
                url = "../../data/toolbar.ashx?Action=GetSys&mid=244&rnd=" + Math.random();
             $.getJSON(url, function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }

                items.push({
                    type: 'textbox',
                    id: 'keyword1',
                    name: 'keyword1',
                    text: ''
                });
                items.push({
                    type: 'button',
                    text: '����',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        doserch()
                    }
                });


                $("#toolbar").ligerToolBar({
                    items: items
                });
               menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
               $("#maingrid4").ligerGetGridManager().onResize();

               $("#keyword1").ligerTextBox({ width: 200, nullText: "����ؼ�������" })

            });
        }
        function doserch() {
            var sendtxt = "Action=grid&rnd=" + Math.random();
           
            var stxt = $("#form1 :input").fieldSerialize();
            var serchtxt = sendtxt + "&IsApr=" + getparastr("IsApr") + "&" + stxt;
   
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Financial_Change_Cost.ashx?" + serchtxt);

                       
        }
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        };
        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '����', onclick: function (item, dialog) {
                                f_save(item, dialog);
                            }
                    },
                        {
                            text: '�ύ', onclick: function (item, dialog) {
                                f_save_tj(item, dialog);
                            }
                        } 
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        var activeDialog = null;
        function f_openWindow_sync(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: 'ͬ��', onclick: function (item, dialog) {
                            f_save_sync(item, dialog);
                        }
                    } 
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        var activeDialog = null;
        function f_openWindow_view(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: '�ر�', onclick: function (item, dialog) {
                            dialog.close();
                        }
                    }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        var activeDialog = null;
        function f_openWindow_sh(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: '���', onclick: function (item, dialog) {
                            f_save_sh(item, dialog);
                        }
                    },
                    {
                        text: '�˻�', onclick: function (item, dialog) {
                            f_save_th(item, dialog);
                        }
                    }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        function view() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow_view('CRM/finance/Financial_Change_Cost_add.aspx?fid=' + row.F_Num, "�鿴�˹�����", 690, 500);
            } else {
                $.ligerDialog.warn("��ѡ����");
            }
        }
        function add() {
            f_openWindow('CRM/finance/Financial_Change_Cost_add.aspx', "�½��䶯����", 690, 300);
        }

        function sync() {
            f_openWindow_sync('CRM/finance/SyncWX_Change_Cost.aspx', "ͬ��΢�ű䶯����", 500, 300);
       
        }
        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('CRM/finance/Financial_Change_Cost_add.aspx?fid=' + row.F_Num, "�޸ı䶯����", 690, 300);
            } else {
                $.ligerDialog.warn("��ѡ����");
            }
        }
        function tj() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow_sh('CRM/finance/Financial_Change_Cost_add.aspx?fid=' + row.F_Num, "��˱䶯����", 690, 500);
            } else {
                $.ligerDialog.warn("��ѡ����");
            }
        }
        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm(" ɾ�����ָܻ���\n��ȷ��Ҫ�Ƴ���", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/Financial_Change_Cost.ashx", type: "POST",
                            data: { Action: "del", fid: row.F_Num, rnd: Math.random() },
                            success: function (responseText) {
                                top.$.ligerDialog.closeWaitting();
                                if (responseText == "true") {
                                    f_reload();
                                }
                                 
                                else {
                                    top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                                }

                            },
                            error: function () {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                            }
                        });
                    }
                })
            } else {
                $.ligerDialog.warn("��ѡ���У�");
            }
        }
          ///ͬ��
        function f_save_sync(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                $.ajax({
                    url: "../../data/Financial_Change_Cost.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        f_reload();
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    }
                });

            }
        }
        //�˻�
        function f_save_th(item, dialog) {
            var issave = dialog.frame.f_save_th();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                $.ajax({
                    url: "../../data/Financial_Change_Cost.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        f_reload();
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    }
                });

            }
        }

        //���
        function f_save_sh(item, dialog) {
            var issave = dialog.frame.f_save_sh();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                $.ajax({
                    url: "../../data/Financial_Change_Cost.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        f_reload();
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    }
                });

            }
        }
        ///�ύ
        function f_save_tj(item, dialog) {
            var issave = dialog.frame.f_save_tj();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                $.ajax({
                    url: "../../data/Financial_Change_Cost.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        f_reload();
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    }
                });

            }
        }
        //����
        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                $.ajax({
                    url: "../../data/Financial_Change_Cost.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        f_reload();
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    }
                });

            }
        }
    </script>

</head>
<body>

    <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar"></div>
            
           <div id="grid">
            <div id="maingrid4" style="margin: -1px;  "></div>
            <div id="toolbar1"></div>
             
        </div>
        </div>
    </form>


</body>
</html>