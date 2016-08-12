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
       
        $(function () {
            //var strurl = "../../data/Budge.ashx?Action=gridselectmodel";
            var strurl = "../../data/Budge.ashx?Action=grid&IsModel=Y";
           

            $("#maingrid4").ligerGrid({
                columns: [
                     {
                         display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                         { return (page - 1) * pagesize + rowindex + 1; }
                     },
                      { display: '模板编号', name: 'id', width: 100, align: 'left' },
                          { display: '模板名称', name: 'BudgetName', width: 120, align: 'left' },
                    //  { display: '姓名', name: 'CustomerName', width: 60, align: 'left' },





                        { display: '创建人', name: 'name', width: 80, align: 'left' },
                        {
                            display: '创建日期', name: 'DoTime', width: 100, align: 'left', render: function (item) {
                                return formatTimebytype(item.DoTime, 'yyyy-MM-dd');
                            }
                        },
                          { display: '引用次数', name: 'FromTimes', width: 100, align: 'left' },

                      //  { display: '原预算', name: 'id', width: 80, align: 'left' },
                { display: '备注', name: 'Remarks', width: 100, align: 'left' },
                 { display: '类型', name: 'ModelStyle', width: 100, align: 'left' }

                ],

                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: strurl,//增加选择条件 0 编辑 1 审核
                width: '100%',
                height: '100%',
                //tree: { columnName: 'StageDescription' },
                heightDiff: -1,
                onRClickToSelect: true,
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


        function f_selectMB() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            return rows;
            
          
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
          
            $.ligerDialog.error("添加失败,请检查后继续操作！如：模板是否有正确明细");
          
        
        }
           function toolbar() {
            var items = [];

            items.push({ type: 'textbox', id: 'stext', text: '名称：' });
            items.push({ type: 'textbox', id: 'stextlx', text: '类型：' });
             items.push({ type: 'button', text: '搜索', icon: '../images/search.gif', disable: true, click: function () { doserch() } });
            items.push({ type: 'textbox', id: 'lbtip', text: '' });
            $("#toolbar").ligerToolBar({
                items: items

            });

            $("#stext").ligerTextBox({ width: 200 });
            $('#stextlx').ligerComboBox({
                width: 97,
                selectBoxWidth: 240,
                selectBoxHeight: 200,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                     data: [                
                { text: '常规模板' },
                { text: '套餐模板' } 
                     ],
                     checkbox: false
                }
            });
            $("#maingrid4").ligerGetGridManager().onResize();
          
           }
           //查询
           function doserch() {
               var strurl = "../../data/Budge.ashx?Action=grid&IsModel=Y";

               var sendtxt = "&rnd=" + Math.random();
               var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;
               //alert(serchtxt);           
               var manager = $("#maingrid4").ligerGetGridManager();
               manager.GetDataByURL(strurl + "&" + serchtxt);
               //manager.loadData(true);
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
            <div id="toolbar" >
                <font size="3" color="red">引用模板会自动覆盖原先数据，请谨慎操作！
                   </font> </div>
            <div id="maingrid4" style="margin: -1px;"></div>
        </div>
    </form>


</body>
</html>
