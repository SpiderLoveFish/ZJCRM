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
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/json2.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
    
        $(function () {
            $("#maingrid4").ligerGrid({
                columns: [
                    {
                        display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                        { return (page - 1) * pagesize + rowindex + 1; }
                    },
                    
                    { display: '车牌号', name: 'carNumber', width: 100, align: 'left' },
                    { display: '使用人', name: 'userPerson', width: 100, align: 'left' },
                  
                    {
                        display: '借用时间', name: 'useBeginTiime', width: 100, render: function (item) {
                            var useBeginTiime = formatTimebytype(item.useBeginTiime, 'yyyy-MM-dd');
                            return useBeginTiime;
                        }
                    },
                    {
                        display: '计划归还时间', name: 'useEndTiime', width: 100, render: function (item) {
                            var useEndTiime = formatTimebytype(item.useEndTiime, 'yyyy-MM-dd');
                            return useEndTiime;
                        }
                    },
   {
                           display: '登记日期', name: 'savetime', width: 200, render: function (item) {
                               var savetime = formatTimebytype(item.savetime, 'yyyy-MM-dd hh:mm:ss');
                               return savetime;
                           }
                    },
     {
                           display: '归还日期', name: 'gtime', width: 200, render: function (item) {
                               var gtime = formatTimebytype(item.gtime, 'yyyy-MM-dd hh:mm:ss');
                               return gtime;
                           }
                    },
                   
                    {
                        display: '状态', name: 'IsStatus', width: 60, align: 'left', render: function (item) {

                            var html;
                            if (item.IsStatus == "Y") {
                                html = "<div style='color:#4800ff'> 借用中";
                                html += "</div>";
                            }
                            else if (item.IsStatus == "0") {
                                html = "<div style='color:#FF0000'> 待审核";
                                html += "</div>";
                            }  
                            else {
                               html = "<div style='color:#06993d'> 已归还";
                                html += "</div>";
                            }
                            return html;
                        }
                    }

                ],
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/carmanageuse.ashx?Action=grid&Apr=" + getparastr("Apr"),
                width: '100%',
                height: '100%',
              //  tree: { columnName: 'CEStage_category' },
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
            var mid = 264;
            if (getparastr("Apr") == "Y") mid = 242;
                $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=" + mid+"&rnd=" + Math.random(), function (data, textStatus) {
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
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        var activeDialog_sh = null;
        function f_openWindow_sh(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: '审核', onclick: function (item, dialog) {
                            f_save_sh(item, dialog);
                        }
                    },
                    {
                        text: '关闭', onclick: function (item, dialog) {
                            dialog.close();
                        }
                    }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog_sh = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        var activeDialog_view = null;
        function f_openWindow_view(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                   
                    {
                        text: '关闭', onclick: function (item, dialog) {
                            dialog.close();
                        }
                    }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog_view = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function add() {
            f_openWindow("crm/car/carmanageuse_add.aspx?edit=N", "新增车辆借用", 680, 350);
        }

        function edit() {
          
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                if (row.IsStatus != "0") {
                    f_openWindow_view('crm/car/carmanageuse_add.aspx?edit=Y&cid=' + row.id + '&cname=' + encodeURI(row.carNumber), "修改车辆借用", 680, 350);

                } else if (row.IsStatus == "0")
                f_openWindow('crm/car/carmanageuse_add.aspx?edit=Y&cid=' + row.id + '&cname=' + encodeURI(row.carNumber), "修改车辆借用", 680, 350);
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        function tj() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow_sh('crm/car/carmanageuse_add.aspx?edit=Y&cid=' + row.id + '&cname=' + encodeURI(row.carNumber), "修改车辆借用", 680, 350);
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }  
        function StartStop() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row.IsStatus == "N")
            {
                top.$.ligerDialog.error('已经归还！');
                return;
            }
            if (row.IsStatus == "0") {
                top.$.ligerDialog.error('必须先审核通过,才能归还！');
                return;
            }
            if (row) {
       
                        $.ajax({
                            url: "../../data/carmanageuse.ashx", type: "POST",
                            data: { Action: "StartStop", id: row.id,carid:row.carid, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    f_reload();
                                }

                                else {
                                    top.$.ligerDialog.closeWaitting();
                                    top.$.ligerDialog.error('修改失败！');
                                }
                            },
                            error: function () {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('修改失败！', "", null, 9003);
                            }
                        });
                   
            } else {
                $.ligerDialog.warn("请选择车辆！");
            }
        }
        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("车辆删除不能恢复，确定删除？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/carmanageuse.ashx", type: "POST",
                            data: { Action: "del", id: row.id,carid:row.carid, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    f_reload();
                                }
                                else if (responseText == "false:exist")
                                {
                                    top.$.ligerDialog.closeWaitting();
                                    top.$.ligerDialog.error('删除失败！此车辆已经在使用中！！');
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
                $.ligerDialog.warn("请选择车辆！");
            }
        }
        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/carmanageuse.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                     if (responseText == "false:exist")
                        {
                            top.$.ligerDialog.closeWaitting();
                            top.$.ligerDialog.error('车辆调用失败！此车辆已经在使用中！！');
                        }
                     
                        else {
                            f_reload();
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();

                    }
                });

            }
        }
        function f_save_sh(item, dialog) {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row.IsStatus == "Y") {
                top.$.ligerDialog.error('已经审核！');
                return;
            }
            if (row) {
                dialog.close();
                        $.ajax({
                            url: "../../data/carmanageuse.ashx", type: "POST",
                            data: { Action: "StartStop", id: row.id, carid: row.carid,sfapr:"Y", rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    f_reload();
                                }

                                else {
                                    top.$.ligerDialog.closeWaitting();
                                    top.$.ligerDialog.error('修改失败！');
                                }
                            },
                            error: function () {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('修改失败！', "", null, 9003);
                            }
                        });
              
            } else {
                $.ligerDialog.warn("请选择车辆！");
            }
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
