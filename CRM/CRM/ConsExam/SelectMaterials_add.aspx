  <%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<html xmlns="http://www.w3.org/1999/xhtml">
       <title>可编辑表格 - 追加行</title>     
    <meta name="keywords" content="免费控件,免费UI控件,免费开源UI,免费开源UI控件,免费开源UI框架,可编辑表格,datagrid,editgrid">  
    <link href="../../jlui3.2/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css">
    <link href="../../jlui3.2/lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet">
    <script src="../../jlui3.2/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/json2.js" type="text/javascript"></script> 
    <script src="../../jlui3.2/lib/ligerUI/js/ligerui.all.js"></script>
 
    
    <script type="text/javascript">

        var DepartmentList = DepartmentData.Rows;
        var sexData = [{ Sex: 1, text: '男' }, { Sex: 2, text: '女' }];
        $(f_initGrid);

        var g = null;
        function f_initGrid() {
            g = $("#maingrid").ligerGrid({
                columns: [
                { display: '主键', name: 'ID', width: 50, type: 'int' },
                {
                    display: '名字', name: 'RealName',
                    editor: { type: 'text' }
                },
                {
                    display: '性别', width: 50, name: 'Sex',
                    editor: { type: 'select', data: sexData, valueField: 'Sex' },
                    render: function (item) {
                        if (parseInt(item.Sex) == 1) return '男';
                        return '女';
                    }
                },
                { display: '年龄', name: 'Age', width: 50, type: 'int', editor: { type: 'int' } },
                {
                    display: '部门', name: 'DepartmentID', width: 120, isSort: false, textField: 'DepartmentName',
                    editor: { type: 'select', data: DepartmentList, valueField: 'DepartmentID', textField: 'DepartmentName' }
                },
                {
                    display: '地址', name: 'Address',
                    editor: { type: 'text' }, align: 'left', width: 300
                }
                ], data: { Rows: [] },
                enabledEdit: true, isScroll: false,
                width: '100%'
            });
        }

        function deleteRow() {
            var manager = $("#maingrid").ligerGetGridManager();
            manager.deleteSelectedRow();
        }
        function f_import() {
            var fn = $.ligerui.getPopupFn({
                top: 80,
                onSelect: function (e) {
                    g.addRows(e.data);
                },
                grid: {
                    columns: [
                    { display: '主键', name: 'ID', width: 50, type: 'int' },
                    { display: '名字', name: 'RealName', width: 50 },
                    {
                        display: '性别', width: 50, name: 'Sex', isSort: false,
                        render: function (item) {
                            if (parseInt(item.Sex) == 1) return '男';
                            return '女';
                        }
                    },
                    { display: '年龄', name: 'Age', width: 50, type: 'int' },
                    { display: '入职日期', name: 'IncomeDay', type: 'date', width: 100 }
                    ], isScroll: false, checkbox: true,
                    data: EmployeeData,
                    width: '95%'
                }
            });

            fn();
        }

        function getSelected() {
            var manager = $("#maingrid").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (!row) { alert('请选择行'); return; }
            alert(JSON.stringify(row));
        }
        function getData() {
            var manager = $("#maingrid").ligerGetGridManager();
            var data = manager.getData();
            alert(JSON.stringify(data));
        }
    </script>
 </head>
<body style="padding: 0px;overflow:hidden;">

    <form id="form1" onsubmit="return false">
 
<a class="l-button" style="width:100px;float:left; margin-left:10px;" onclick="f_import()">引入</a>
 
 <div class="l-clear"></div>
    <div id="maingrid" style="margin-top:20px"></div> <br>
       <br>
   <a class="l-button" style="width:120px" onclick="getSelected()">获取选中的值(选择行)</a>
   <br>
   <a class="l-button" style="width:120px" onclick="getData()">获取当前的值</a>
  <div style="display:none;">
  <!-- g data total ttt -->
</div>
         </form>

</body>
    </html>