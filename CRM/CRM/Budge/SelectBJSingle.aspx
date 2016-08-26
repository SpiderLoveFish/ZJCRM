<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/styles.css" rel="Stylesheet" type="text/css" />
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
       <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
   <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
   
      <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
     <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
   
    <script type="text/javascript">
        var bjmc = getparastr("bjmc");
        $(function () {
            var strurl = "../../data/Budge.ashx?Action=selecttree";
        var  g=   $("#maingrid4").ligerGrid({
                columns: [
                    //{ display: 'ID', name: 'ID', type: 'int', width: 50 },
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                  { display: '部件编号', name: 'id', width: 80, align: 'left' },
                  { display: '部件名称', name: 'BP_Name', width: 100, align: 'left' }
                  
                ],
                checkbox: false,
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: strurl, 
                width: '100%',
                height: '100%',
                //title: "员工列表",
                heightDiff: 0,
                onContextmenu: function (parm, e) {
                actionCustomerID = parm.data.id;
                menu.show({ top: e.pageY, left: e.pageX });
                return false;
            }
            });

            toolbar();
            $("#lbtip").css("display", 'none');//提示先隐藏

            
        });


    //监听键盘事件
        document.onkeyup=function(event){
            var e=event||window.event;
            var keyCode=e.keyCode||e.which;
            switch(keyCode){
                   
                case 113://F2快捷键
                   // add();
                    break;      
                case 13://回车
                    doserch();
                    break;
            }

        }


        function f_select() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            //alert(rows);
            return rows;
            
          
        }
        function f_copybj() {
            return bjmc;
        }

        function f_sucess()
        {
            $.ligerDialog.closeWaitting();
            f_load();
            $("#lbtip").css("display", 'inline');
            $("#lbtip").addClass("green");
            $("#lbtip").val('添加成功！！！');
            setTimeout(function () {
                $("#lbtip").css("display", 'none');
                
                // $.ligerDialog.error("添加失败,请检查后继续操作！");
              
            }, 1000);
           
        }
        function f_error() {

            $.ligerDialog.closeWaitting();
            f_load();
          
              $.ligerDialog.error("添加失败,请检查后继续操作！");
          
        
        }
           function toolbar() {
            var items = [];

            items.push({ type: 'textbox', id: 'stext', text: '名称：' });
             items.push({ type: 'button', text: '搜索', icon: '../images/search.gif', disable: true, click: function () { doserch() } });
            items.push({ type: 'textbox', id: 'lbtip', text: '' });
            $("#toolbar").ligerToolBar({
                items: items

            });

            $("#stext").ligerTextBox({ width: 200 });
            
            $("#maingrid4").ligerGetGridManager().onResize();
          
        }
          function f_load() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);

        }
      </script>

</head>
<body>

    <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar" ></div>
            <div id="maingrid4" style="margin: -1px;"></div>
        </div>
    </form>


</body>
</html>
