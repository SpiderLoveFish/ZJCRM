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
                    { display: '借用人', name: 'toolsid', width: 50, align: 'left' ,hide:true },
                    { display: '借用人', name: 'borrowers', width: 50, align: 'left' },
                    {
                        display: '开始时间', name: 'begintime', width: 90, render: function (item) {
                            var useBeginTiime = formatTimebytype(item.begintime, 'yyyy-MM-dd');
                            return useBeginTiime;
                        }
                    },
                    {
                        display: '结束时间', name: 'endtime', width: 90, render: function (item) {
                            var useEndTiime = formatTimebytype(item.endtime, 'yyyy-MM-dd');
                            return useEndTiime;
                        }
                    },
                    { display: '剩余天数', name: 'ts', width: 250, align: 'left' },
                    { display: '备注', name: 'remarks', width: 250, align: 'left' },
                    {
                        display: '录入日期', name: 'dotime', width: 90, render: function (item) {
                            var useEndTiime = formatTimebytype(item.dotime, 'yyyy-MM-dd');
                            return useEndTiime;
                        }
                    },
                    {
                        display: '状态', name: 'isstatus', width: 60, align: 'left', render: function (item) {

                         
                            var html;
                            if (item.isstatus == "Y") {
                                html = "<div style='color:#4800ff'> 借用中";
                                html += "</div>";
                            }
                            else if (item.isstatus == "0") {
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
                url: "../../data/toolsmanage.ashx?Action=grid&Apr=" + getparastr("Apr"),
                width: '100%',
                height: '100%',
              //  tree: { columnName: 'CEStage_category' },
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                },
                detail: {
                    onShowDetail: function (r, p) {
                        for (var n in r) {
                            if (r[n] == null) r[n] = "";
                        }
                        var grid = document.createElement('div');
                        $(p).append(grid);
                        $(grid).css('margin', 3).ligerGrid({
                            columns: [
                                //{ display: 'ID', name: 'RoleID', type: 'int', width: 50 },
                                { display: '序号', width: 50, render: function (item, i) { return i + 1; } },
                                { display: '产品', name: 'product_name', width: 100 },
                                { display: '型号', name: 'ProModel', width: 80 },
                                { display: '规格', name: 'specifications', width: 80 },
                                { display: '品牌', name: 'Brand', width: 80 },
                                { display: '数量', name: 'productnumber', width: 60 },
                                { display: '备注', name: 'remarks', width: 80 }
                            ],
                            title: '借用产品',
                            usePager: false,
                            url: "../../data/toolsmanage.ashx?Action=gridmx&toolsid=" + r.toolsid + "&Apr=" + getparastr("Apr"),
                            height: '100px',
                            heightDiff: 0
                        })

                    }
                }

            });



            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            toolbar();
        });
        function toolbar() {
            var mid = 264;//155
            if (getparastr("Apr") == "Y") mid = 242;
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=" + mid +"&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                //items.push({
                //    type: 'textbox',
                //    id: 'keyword1',
                //    text: ''
                //});
                items.push({
                    type: 'button',
                    text: '刷新',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        doserch()
                    }
                });
                $("#toolbar").ligerToolBar({
                    items: items

                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
              //  $("#keyword1").ligerTextBox({ width: 200, nullText: "" })
                $("#maingrid4").ligerGetGridManager().onResize();
            });
        }
        //查询
        function doserch() {
            //   var sendtxt = "&Action=grid&Apr=" + getparastr("Apr")+"&rnd=" + Math.random();
             
            //var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;

           

            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/toolsmanage.ashx?Action=grid&Apr=" + getparastr("Apr") + "&rnd=" + Math.random());



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
            f_openWindow("crm/car/toolsmanage_add.aspx?edit=N", "新增工具", 680, 520);
        }

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            // alert(JSON.stringify(row));
            if (row) {
                if (row.isstatus != "0") {
                    f_openWindow_view('crm/car/toolsmanage_add.aspx?edit=Y&cid=' + row.id + '&toolsid=' + row.toolsid, "修改工具", 680, 520);
                } else if (row.isstatus == "0") {
                    f_openWindow('crm/car/toolsmanage_add.aspx?edit=Y&cid=' + row.id + '&toolsid=' + row.toolsid, "修改工具", 680, 520);

                } else {
                    $.ligerDialog.warn('请选择行！');
                }
            }
        }
            function tj() {
                var manager = $("#maingrid4").ligerGetGridManager();
                var row = manager.getSelectedRow();
                if (row) {
                    f_openWindow_sh('crm/car/toolsmanage_add.aspx?edit=Y&cid=' + row.id + '&toolsid=' + row.toolsid, "修改工具", 680, 350);
                } else {
                    $.ligerDialog.warn('请选择行！');
                }
            }  
        function StartStop() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row.isstatus == "N") {
                top.$.ligerDialog.error('已经归还！');
                return;
            }
            if (row.isstatus == "0") {
                top.$.ligerDialog.error('必须先审核通过,才能归还！');
                return;
            }
            if (row) {
                $.ligerDialog.confirm("确定要修改状态，如果停用，则后续无法选择此工具！？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/toolsmanage.ashx", type: "POST",
                            data: { Action: "StartStop", id: row.id, rnd: Math.random() },
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
                    }
                })
            } else {
                $.ligerDialog.warn("请选择工具！");
            }
        }
        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("工具删除不能恢复，确定删除？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/toolsmanage.ashx", type: "POST",
                            data: { Action: "del", id: row.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    f_reload();
                                }
                                else if (responseText == "false:exist")
                                {
                                    top.$.ligerDialog.closeWaitting();
                                    top.$.ligerDialog.error('删除失败！此工具已经在使用中！！');
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
                $.ligerDialog.warn("请选择工具！");
            }
        }
        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            var postdata = dialog.frame.f_postdata();

            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/toolsmanage.ashx", type: "POST",
                    data: issave + "&PostData=" + postdata,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                     if (responseText == "false:exist")
                        {
                            top.$.ligerDialog.closeWaitting();
                            top.$.ligerDialog.error('工具修改失败！此工具名称已经在使用中！！');
                        }
                     else
                         if (responseText == "false:type") {
                            top.$.ligerDialog.error('操作失败，上级类别不能是自己！');
                        }
                        
                            f_reload();
                        
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
            if (row.isstatus == "Y") {
                top.$.ligerDialog.error('已经审核！');
                return;
            }
            if (row) {
                dialog.close();
                $.ajax({
                    url: "../../data/toolsmanage.ashx", type: "POST",
                    data: { Action: "StartStop", id: row.id,  sfapr: "Y", rnd: Math.random() },
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
          //  top.flushiframegrid("tabid39");
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
