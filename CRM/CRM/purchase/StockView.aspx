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
         <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
  <script type="text/javascript">
        $(function () {
            $("#maingrid4").ligerGrid({
                columns: [
                    {
                        display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                        { return (page - 1) * pagesize + rowindex + 1; }
                    },
                    { display: '��������', name: 'Financial_Y_M', width: 80, align: 'left' },
                     { display: '��Ʒ', name: 'product_name', width: 150, align: 'left' },
                      { display: '�ֿ�', name: 'Name', width: 100, align: 'left' },
                       { display: '�ڳ�����', name: 'BeginStock', width:100, align: 'left' },
                { display: '��ĩ����', name: 'EndStock', width: 100, align: 'left' },
        {
            display: '�������', name: 'InStock', width: 100, align: 'left', render: function (item) {
                var html = "<a href='javascript:void(0)' onclick=viewIn()>" + item.InStock + "</a>"
                return html;
            }
        },
         {
             display: '��������', name: 'OutStock', width: 100, align: 'left', render: function (item) {
                 var html = "<a href='javascript:void(0)' onclick=viewOut()>" + item.OutStock + "</a>"
                 return html;
             }
         },
          { display: '��ע', name: 'Remarks', width: 250, align: 'left' }
                     
                ],
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/StockView.ashx?Action=grid",
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

            

            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            toolbar();
        });
        function toolbar() {
            var items = [];
            items.push({ type: 'textbox', id: 'stext', text: '�������£�' });
            items.push({ type: 'button', text: '����', icon: '../../images/search.gif', disable: true, click: function () { doserch() } });

            items.push({ type: 'button', text: '�½�', icon: '../../images/edit.gif', disable: true, click: function () { doexec() } });
            $("#toolbar").ligerToolBar({
                items: items

            });
            $("#stext").ligerTextBox({ width: 200 });
            $("#maingrid4").ligerGetGridManager().onResize();
        }
        //��ѯ
        function doserch() {
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;

            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/StockView.ashx?" + serchtxt);
        }

        function doexec()
        {
            $.ajax({
                url: "../../data/StockView.ashx", type: "POST",
                data: { Action: "doexec",  rnd: Math.random() },
                success: function (responseText) {
                    if (responseText == "true") {
                        top.$.ligerDialog.closeWaitting();
                        f_reload();
                    }

                    else {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('û�����ݣ�����ʧ�ܣ�');
                    }
                },
                error: function () {
                    top.$.ligerDialog.closeWaitting();
                    top.$.ligerDialog.error('�ϸ��������»���δ��˵����ϵ���', "", null, 9003);
                }
            });
        }
        //�鿴ѡ��
        function viewIn() {
            var dialogOptions = {
                width: 770, height: 510, title: "���Ԥ��", url: 'crm/purchase/StockView_In.aspx?rnd=' + Math.random(), buttons: [
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        function viewOut() {
            var dialogOptions = {
                width: 770, height: 510, title: "����Ԥ��", url: 'crm/purchase/StockView_out.aspx?rnd=' + Math.random(), buttons: [
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
            top.flushiframegrid("tabid39");
        };
    </script>
    <style type="text/css">
        .l-leaving { background: #eee; color: #999; }
    </style>

</head>
<body>

    <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar"></div>
            
            <div id="maingrid4" style="margin: -1px;"></div>
        </div>
    </form>


</body>
</html>
