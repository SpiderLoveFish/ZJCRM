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
                       display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                       { return (page - 1) * pagesize + rowindex + 1; }
                   },
                    // { display: '客户编号', name: 'CustomerID', width: 50, align: 'left' },
                      { display: '产品名称', name: 'product_name', width: 80, align: 'left' },
                    
                        { display: '类型', name: 'specifications', width: 250, align: 'left' },
                        { display: '单位', name: 'unit', width: 80, align: 'left' },
                        {
                            display: '数量', name: 'AmountSum', width: 80, align: 'left'
                            , type: 'int', editor: { type: 'int' } 
                             
                        }
                        //, { display: '价格', name: 'Price', width: 80, align: 'left' }
              

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


        //只允许编辑前3行
        function f_onBeforeEdit(e) {
            //if (e.rowindex <= 2) return true;
            //return false;
            return true;
        }
        //限制
        function f_onBeforeSubmitEdit(e) {
            if (e.column.name == "AmountSum") {
                if (e.value < 0) {
                    alert("数量不能为负数！");
                    return false;
                }
            }
            return true;
        }
        //编辑后事件 
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
                            top.$.ligerDialog.error('修改失败！', "", null, 9003);
                        }
                    });
                }
                else {
                    $.ligerDialog.warn("请选择一有效行！");
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
                $.ligerDialog.confirm("删除不能恢复，确定删除？", function (yes) {
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
                                    top.$.ligerDialog.error('状态已经改变，无法删除！');
                                }
                            },
                            error: function () {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('删除失败！', "", null, 9003);
                            }
                        });
                    }
                })
            } else {
                $.ligerDialog.warn("请选择类别！");
            }
        }

        function f_error(message) {
            $(document).ready(function () {
                $.ligerDialog.error(message);
            });
        }
        function f_saving() {
            $.ligerDialog.waitting("正在保存中...");
        }
    

       
        //新增打开页面
        function add() {
            f_openWindow("../../CRM/ConsExam/getemp.aspx?style=ALL", "选择产品", 650, 400);


        }
        function edit() {
            f_openWindow("../../CRM/ConsExam/getemp.aspx?style=ALL&customid=" + getparastr("cid"), "选择产品", 650, 400);


        }
        //获取返回人员
        function f_getry(item, dialog) {
            var rows = null;
            if (!dialog.frame.f_select()) {
                alert('请选择行!');
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
            //    $.ligerDialog.confirm("是否继续编辑", "保存成功", function (ok) {
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
                            text: '提交', onclick: function (item, dialog) {
                                f_getry(item, dialog);
                            }
                        },
                        {
                            text: '关闭', onclick: function (item, dialog) {
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
