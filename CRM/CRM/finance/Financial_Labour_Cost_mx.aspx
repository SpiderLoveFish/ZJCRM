<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />

      <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
        <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    
    <script type="text/javascript">
      
        $(function () {
            
            var varurl = "";
            if (getparastr("IsApr") == "Y")
                varurl = "../../data/Financial_Labour_Cost.ashx?Action=grid&IsApr=Y";
            else if (getparastr("IsApr") == "V")
                varurl = "../../data/Financial_Labour_Cost.ashx?Action=grid&IsApr=V";
            else varurl = "../../data/Financial_Labour_Cost.ashx?Action=grid";
            $("#maingrid4").ligerGrid({
                columns: [
                    //{ display: 'ID', name: 'id', type: 'int', width: 50 },
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                    { display: '编号', name: 'F_Num', align: 'left', width: 120},
                    { display: '类型', name: 'F_StyleName', width: 70 },
                    { display: '客户', name: 'Customer', width: 350 },
                    { display: '工人', name: 'worker', width: 250 },
                     { display: '结算金额', name: 'TotalAmount', width: 70 },         
                    { display: '标准金额', name: 'Amount', width: 70 },
                      { display: '调整金额', name: 'AdjustAmount', width: 70 },
                 
                    { display: '工时', name: 'ManHour', width: 70 },
                    { display: '单价(人/天)', name: 'ManDayPrice', width: 70 },
                            
                  
                    { display: '保存人', name: 'CreatePerson', width: 70 },
                    { display: '备注', name: 'Remarks', width: 70 },
                    {
                        display: '保存日期', name: 'CreateTime', width: 90, render: function (item) {
                            return formatTimebytype(item.CreateTime, 'yyyy-MM-dd');
                        }
                    },
                    { display: '状态', name: 'IsStatus', width: 70 },
                    { display: '来源', name: 'FromWhere', width: 70 }
                ],
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                onSelectRow: function (row, index, data) {
                    //alert('onSelectRow:' + index + " | " + data.ProductName); 
                },
                url: varurl,
                width: '100%',
                height: '100%',
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });
           
            toolbar();
            
        });

        function f_select() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            return rows;
        }

        function toolbar() {

            var url = "../../data/toolbar.ashx?Action=GetSys&mid=241&rnd=" + Math.random();
            if (getparastr("IsApr") == "Y")
                url = "../../data/toolbar.ashx?Action=GetSys&mid=242&rnd=" + Math.random();
            else if (getparastr("IsApr") == "V")
                url = "../../data/toolbar.ashx?Action=GetSys&mid=244&rnd=" + Math.random();

            $.getJSON(url, function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }

                items.push({
                    type: 'textbox',
                    id: 'keyword1',
                    name: 'keyword1',
                    text: ''
                });
                items.push({
                    type: 'button',
                    text: '搜索',
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
                $("#maingrid4").ligerGetGridManager().onResize();

                $("#keyword1").ligerTextBox({ width: 200, nullText: "输入关键词搜索" })

            });
        }
        function doserch() {
            var sendtxt = "Action=grid&rnd=" + Math.random();

            var stxt = $("#form1 :input").fieldSerialize();
            var serchtxt = sendtxt + "&IsApr=" + getparastr("IsApr") + "&" + stxt;

            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Financial_Labour_Cost.ashx?" + serchtxt);


        }
      function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        };
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
                        text: '提交', onclick: function (item, dialog) {
                            f_save_tj(item, dialog);
                        }
                    }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        var activeDialog = null;
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
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        var activeDialog = null;
        function f_openWindow_sh(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: '审核', onclick: function (item, dialog) {
                            f_save_sh(item, dialog);
                        }
                    },
                    {
                        text: '退回', onclick: function (item, dialog) {
                            f_save_th(item, dialog);
                        }
                    }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        function view() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow_view('CRM/finance/Financial_Labour_Cost_add.aspx?fid=' + row.F_Num, "查看人工费用", 690, 400);
            } else {
                $.ligerDialog.warn("请选择行");
            }
        }
        function add() {
            f_openWindow('CRM/finance/Financial_Labour_Cost_add.aspx', "新建人工费用", 690, 400);
        }
        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('CRM/finance/Financial_Labour_Cost_add.aspx?fid=' + row.F_Num, "修改人工费用", 690, 400);
            } else {
                $.ligerDialog.warn("请选择行");
            }
        }
        function tj() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow_sh('CRM/finance/Financial_Labour_Cost_add.aspx?fid=' + row.F_Num, "审核变动费用", 690, 500);
            } else {
                $.ligerDialog.warn("请选择行");
            }
        }
        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm(" 删除后不能恢复，\n您确定要移除？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/Financial_Labour_Cost.ashx", type: "POST",
                            data: { Action: "del", fid: row.F_Num, rnd: Math.random() },
                            success: function (responseText) {
                                top.$.ligerDialog.closeWaitting();
                                if (responseText == "true") {
                                    f_reload();
                                }
                                 
                                else {
                                    top.$.ligerDialog.error('删除失败！');
                                }

                            },
                            error: function () {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('删除失败！');
                            }
                        });
                    }
                })
            } else {
                $.ligerDialog.warn("请选择行！");
            }
        }

        //退回
        function f_save_th(item, dialog) {
            var issave = dialog.frame.f_save_th();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/Financial_Labour_Cost.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        f_reload();
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('操作失败！');
                    }
                });

            }
        }

        //审核
        function f_save_sh(item, dialog) {
            var issave = dialog.frame.f_save_sh();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/Financial_Labour_Cost.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        f_reload();
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('操作失败！');
                    }
                });

            }
        }
        ///提交
        function f_save_tj(item, dialog) {
            var issave = dialog.frame.f_save_tj();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/Financial_Labour_Cost.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        f_reload();
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('操作失败！');
                    }
                });

            }
        }

        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/Financial_Labour_Cost.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        f_reload();
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('操作失败！');
                    }
                });

            }
        }
    </script>

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
