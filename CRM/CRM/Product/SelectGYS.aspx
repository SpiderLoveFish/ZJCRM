<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GysGl.aspx.cs" Inherits="GysGl.GysGl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=7" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />

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
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>


    <script type="text/javascript">
        var manager;
        var manager1;
        $(function () {
            // //debugger;
            initLayout();
            $(window).resize(function () {
                initLayout();
            });

            $("#maingrid4").ligerGrid({
                columns: [
                    {
                        display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) {
                            //debugger;
                            return (page - 1) * pagesize + rowindex + 1;
                        }
                    },
                    { display: '��Ӧ������', name: 'Name', width: 150, align: 'left' },
                    { display: '��Ӧ�̵�ַ', name: 'Address', width: 200, align: 'left' },
                    { display: '��Ӧ�̵绰', name: 'Gsdh', width: 100, align: 'left' },
                    { display: '��ϵ��', name: 'Lxr', width: 60 },
                    { display: '��ϵ�绰', name: 'Lxrdh', width: 150 },
                    { display: '��Ӫҵ��', name: 'Zyyw', width: 200, align: 'left' },
                   // { display: '�Ǽ���', name: 'InEmpID', width: 80 },
                    { display: '�Ǽ�����', name: 'InDate', width: 150 }
                    //{ display: '��¥�绰', name: 'Sldh', width: 80 },
                    //{ display: '������', name: 'Kfs', width: 100, align: 'left' },
                    //{ display: '��ͨ״��', name: 'Jtzk', width: 200, align: 'left' },
                    //{ display: '����', name: 'Jj', width: 100 },
                    //{ display: 'ʡ��', name: 'Provinces', width: 80, align: 'left' },
                    //{ display: '����', name: 'City', width: 80, align: 'left' },
                    //{ display: '����', name: 'Towns', width: 80, align: 'left' },
                 //   { display: '��ע', name: 'Remark', width: 200, align: 'left' }
                ],
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/Crm_product.ashx?Action=gridgys&rnd=" + Math.random(),
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

            $("#grid").height(document.documentElement.clientHeight - $(".toolbar").height());
            $('form').ligerForm();
            toolbar();
        });
        function f_select() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            //alert(rows);
            return rows;
        }
        //��ѯ
        function doserch() {
            var sendtxt = "&Action=gridgys&rnd=" + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;
            //  alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Crm_product.ashx?" + serchtxt);
        }


        function toolbar() {
            var items = [];
            items.push({ type: 'textbox', id: 'stext', text: '���ơ���ַ��' });
            items.push({ type: 'button', text: '����', icon: '../images/search.gif', disable: true, click: function () { doserch() } });

            $("#toolbar").ligerToolBar({
                items: items

            });
            //, nullText: "����ؼ������������ͻ�"
            $("#stext").ligerTextBox({ width: 200 });
            $("#maingrid4").ligerGetGridManager().onResize();

              
        }
          function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        }
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false;">
        <div id="toolbar"></div>
        <div id="grid">
            <div id="maingrid4" style="margin: -1px; min-width: 800px;"></div>
            <div id="toolbar1"></div>
        </div>
    </form>
</body>
</html>
