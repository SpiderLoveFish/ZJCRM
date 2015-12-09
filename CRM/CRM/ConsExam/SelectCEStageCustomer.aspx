<%@ Page Language="C#" AutoEventWireup="true"  %>

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
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/json2.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
   
    <script src="../JS/XHD.js" type="text/javascript"></script>

    <script type="text/javascript">

        $(function () {
            $("#maingrid4").ligerGrid({
                columns: [
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowid + 1; } },
                      { display: '�ͻ����', name: 'CustomerID', width: 50, align: 'left' },
                      { display: '�ͻ�����', name: 'CustomerName', width: 250, align: 'left' },
                       { display: '�ͻ��绰', name: 'tel', width: 120, align: 'left' },
                      { display: 'ʩ������', name: 'sgjl', width: 120, align: 'left' },
                        { display: 'ҵ��Ա', name: 'ywy', width: 120, align: 'left' },
                    { display: '���ʦ', name: 'sjs', width: 120, align: 'left' },
                { display: 'ʩ������ID', name: 'sgjlid', width: 0, align: 'left' },
                { display: 'ҵ��ԱID', name: 'ywyid', width: 0, align: 'left' },
                { display: '���ʦID', name: 'sjsid', width: 0, align: 'left' }
                ],
                checkbox: false,
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/Crm_CEStage.ashx?Action=getcustomer",
                width: '100%',
                height: '100%',
                //title: "Ա���б�",
                heightDiff: 0
            });
           
        });

        function f_select() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            //alert(rows);
            return rows;
        }
 

 
         
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        };
    </script>
   
</head>
<body> 

  <form id="form1" onsubmit="return false"> 
    <div>
         
        <div id="maingrid4" style="margin:-1px; "></div>   
    </div>     
  </form>

 
</body>
</html>
