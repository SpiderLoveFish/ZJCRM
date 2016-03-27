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
   <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/json2.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        var manager = "";
        var Apr = "E";
        if (getparastr("Apr") == "Y") Apr = "Y";
      //  else if (getparastr("Apr") == "YY") Apr = "YY";
        else if (getparastr("Apr") == "Print") Apr = "";
        $(function () {
            $("#maingrid4").ligerGrid({
                columns: [
                   {
                       display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                       { return (page - 1) * pagesize + rowindex + 1; }
                   },
                      { display: '客户', name: 'Customer', width: 150, align: 'left' },
                     { display: '财务年月', name: 'FYM', width: 80, align: 'left' },
                     { display: '使用类型', name: 'UseStyle', width: 120, align: 'left' },
                     { display: '状态', name: 'isNode', width: 80, align: 'left' },
                      { display: '备注', name: 'remarks', width: 80, align: 'left' },
                { display: '操作人', name: 'InPerson', width: 80, align: 'left' }
                ],
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/PickingList.ashx?Action=grid",
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

            

            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            toolbar();
        });
        function toolbar() {
            var url = "../../data/toolbar.ashx?Action=GetSys&mid=164&rnd=" + Math.random();
            if (getparastr("Apr") == "Y") url = "../../data/toolbar.ashx?Action=GetSys&mid=166&rnd=" + Math.random();
            if (getparastr("Apr") == "Print") url = "../../data/toolbar.ashx?Action=GetSys&mid=168&rnd=" + Math.random();
            $.getJSON(url, function (data, textStatus) {
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

        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '保存', onclick: function (item, dialog) {
                                f_save(item, dialog);
                            }
                        },
                         {
                             text: '保存&提交', onclick: function (item, dialog) {
                                 f_submit(item, dialog);
                             }
                         },
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
  
        //撤回
        var activeDialogsch = null;
        function f_openWindow_ch(url, title, width, height, code) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: code, onclick: function (item, dialog) {
                            f_saveret(item, dialog);
                        }
                    },
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialogsch = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        var activeDialogs = null;
        function f_openWindowview(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [

                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialogs = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        function add() {
            f_openWindow("crm/purchase/PickingList_add.aspx", "新增申请", 1100, 600);
        }

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                // alert(row.isNode);
                if (row.isNode == 0)
                    f_openWindow("crm/purchase/PickingList_add.aspx?pid=" + row.CKID + "&status=" + row.isNode, "修改申请", 1100, 600);
                else if (row.isNode == 1)//已经提交
                {
                    if (getparastr("Apr") == 'Y')
                        f_openWindow_ch("crm/purchase/PickingList_add.aspx?pid=" + row.CKID + "&status=" + row.isNode + "&style=apr", "修改申请", 1100, 600, '审核');
                    else
                        f_openWindow_ch("crm/purchase/PickingList_add.aspx?pid=" + row.CKID + "&status=" + row.isNode + "&style=ret", "修改申请", 1100, 600, '撤回');

                }
                else {
                    $.ligerDialog.warn('请选择行！');
                }
            }
        }

            function del() {
                var manager = $("#maingrid4").ligerGetGridManager();
                var row = manager.getSelectedRow();
                if (row) {
                    $.ligerDialog.confirm("删除不能恢复，确定删除？", function (yes) {
                        if (yes) {
                            $.ajax({
                                url: "../../data/PickingList.ashx", type: "POST",
                                data: { Action: "del", pid: row.CKID, rnd: Math.random() },
                                success: function (responseText) {
                                    if (responseText == "true") {
                                        top.$.ligerDialog.closeWaitting();
                                        f_reload();
                                    }

                                    else {
                                        top.$.ligerDialog.closeWaitting();
                                        top.$.ligerDialog.error('删除失败！');
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
       
        function f_submit(item, dialog) {

            var issave = dialog.frame.f_save();

            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/PickingList.ashx", type: "POST",
                    data: issave + "&status=1",
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        if (responseText == "false") {
                            top.$.ligerDialog.error('操作失败！');
                        }
                        else {
                            //  alert(issave); 
                            f_reload();
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();

                    }
                });

            }
        } 
        function f_saveret(item, dialog)
        {

            var issave = dialog.frame.f_saveapr();

            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/PickingList.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        if (responseText == "false") {
                            top.$.ligerDialog.error('操作失败！');
                        }
                        else {
                            //  alert(issave); 
                            f_reload();
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();

                    }
                });

            }
        }
        function ret() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("确定退回吗？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/PickingList.ashx", type: "POST",
                            data: { Action: "saveupdatestatus", status: 0, pid: row.CKID, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    f_reload();
                                }

                                else {
                                    top.$.ligerDialog.closeWaitting();
                                    top.$.ligerDialog.error('退回失败！');
                                }
                            },
                            error: function () {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('退回失败！', "", null, 9003);
                            }
                        });
                    }
                })
            } else {
                $.ligerDialog.warn("请选择类别！");
            }
        }
        
        function f_save(item, dialog) {
            
            var issave = dialog.frame.f_save();
          
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/PickingList.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        if (responseText == "false")
                        {
                            top.$.ligerDialog.error('操作失败1！');
                        }
                        else
                        {                              
                            f_reload();
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.error('操作失败！');

                        top.$.ligerDialog.closeWaitting();
                        
                    }
                });

            }
        }
        function f_reload() {
            
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
            
        };
    </script>
    
</head>
<body style="padding: 0px;overflow:hidden;">

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
