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
        var customer_id = getparastr("cid");

        $(function () {
            $("#maingrid4").ligerGrid({
                columns: [
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowid + 1; } },
                     { display: '预算编号', name: 'id', width: 150, align: 'left' },
                          { display: '预算名称', name: 'BudgetName', width: 150, align: 'left' },
                      { display: '客户姓名', name: 'CustomerName', width: 80, align: 'left' },
                       { display: '客户电话', name: 'tel', width: 100, align: 'left' },
                        { display: '客户地址', name: 'address', width: 200, align: 'left' },
                   { display: '预算金额', name: 'BudgetAmount', width: 80, align: 'left' },
             { display: '设计师', name: 'sjs', width: 80, align: 'left' },
                { display: '备注', name: 'Remarks', width: 200, align: 'left' }
                ],
                checkbox: false,
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/Budge.ashx?Action=grid&str_condition=3&cid=" + customer_id ,//增加选择条件 0 编辑 1 审核
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
            items.push({ type: 'textbox', id: 's_khstext', text: '客户：' });
            items.push({ type: 'button', text: '搜索', icon: '../images/search.gif', disable: true, click: function () { doserch() } });

            $("#serchbar1").ligerToolBar({
                items: items

            });
            $("#s_khstext").ligerTextBox({ width: 200});
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
            var sendtxt = "&Action=grid&str_condition=3&cid" + getparastr("cid") + "&rnd=" + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;
            //  alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Budge.ashx?" + serchtxt);
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
