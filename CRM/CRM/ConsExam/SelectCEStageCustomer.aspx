<%@ Page Language="C#" AutoEventWireup="true"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
     <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>

    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>

    <script src="../../lib/jquery.form.js" type="text/javascript"></script>      
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    
    <script type="text/javascript">

        $(function () {
            $("#maingrid4").ligerGrid({
                columns: [
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowid + 1; } },
                      { display: '客户编号', name: 'CustomerID', width: 50, align: 'left' },
                      { display: '客户姓名', name: 'CustomerName', width: 250, align: 'left' },
                         { display: '客户地址', name: 'address', width: 250, align: 'left' },
                     { display: '客户电话', name: 'tel', width: 120, align: 'left' },
                      { display: '施工监理', name: 'sgjl', width: 120, align: 'left' },
                        { display: '业务员', name: 'ywy', width: 120, align: 'left' },
                    { display: '设计师', name: 'sjs', width: 120, align: 'left' },
                { display: '施工监理ID', name: 'sgjlid', width: 0, align: 'left' },
                { display: '业务员ID', name: 'ywyid', width: 0, align: 'left' },
                { display: '设计师ID', name: 'sjsid', width: 0, align: 'left' }
                ],
                checkbox: false,
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/Crm_CEStage.ashx?Action=getcustomer",
                width: '100%',
                height: '100%',
                //title: "员工列表",
                heightDiff: 0
            });
            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            toolbar();
           
        });
        function toolbar() {
            var items = [];
            items.push({ type: 'textbox', id: 'company', text: '姓名：' });
            items.push({ type: 'button', text: '搜索', icon: '../images/search.gif', disable: true, click: function () { doserch() } });

            $("#serchbar1").ligerToolBar({
                items: items

            });
            $("#company").ligerTextBox({ width: 200, nullText: "输入关键词智能搜索客户" });
            $("#maingrid4").ligerGetGridManager().onResize();


        }
        function f_select() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            //alert(rows);
            return rows;
        }
 
     
        //查询
        function doserch() {
            var sendtxt = "&Action=getcustomer&rnd=" + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;
            //  alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Crm_CEStage.ashx?" + serchtxt);
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
            <div id="serchbar1"></div>
              
        <div id="maingrid4" style="margin:-1px; "></div>   
                     
        </div>
    </div>
     
  </form>
   
 
</body>
</html>
