﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Budge_Rate.aspx.cs" Inherits="Budge_Rate.Budge_Rate" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=7" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />

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
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>


    <script type="text/javascript">
        var manager;
        var manager1;
        $(function () {
           // //debugger;
            initLayout();
            $(window).resize(function () {
                initLayout();
            });

            $("#maingrid4").ligerGrid({
                columns: [
                    {
                        display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                        {
                            //debugger;
                            return (page - 1) * pagesize + rowindex + 1;
                        }
                    },
                    { display: '附加费名称', name: 'RateName', width: 150, align: 'left' },
                    
                    { display: '费率 / 单价', name: 'rate', width: 80, align: 'right' },
                    { display: '公式', name: 'formula', width: 100, align: 'left' },
                    { display: '说明', name: 'bz', width: 200, align: 'left' },
                    { display: '备注', name: 'Remarks', width: 500, align: 'left' }
                   // { display: '登记人', name: 'InEmpID', width: 80 },
                   // { display: '登记日期', name: 'InDate', width: 150 }
                    //{ display: '售楼电话', name: 'Sldh', width: 80 },
                    //{ display: '开发商', name: 'Kfs', width: 100, align: 'left' },
                    //{ display: '交通状况', name: 'Jtzk', width: 200, align: 'left' },
                    //{ display: '均价', name: 'Jj', width: 100 },
                    //{ display: '省份', name: 'Provinces', width: 80, align: 'left' },
                    //{ display: '城市', name: 'City', width: 80, align: 'left' },
                    //{ display: '区镇', name: 'Towns', width: 80, align: 'left' },
                 //   { display: '备注', name: 'Remark', width: 200, align: 'left' }
                ],
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                url: "Budge_Rate.aspx?cmd=grid&rnd=" + Math.random(),
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

            $("#grid").height(document.documentElement.clientHeight - $(".toolbar").height());
            $('form').ligerForm();
            toolbar();
        });

        function toolbar() {
            ////debugger;
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=182&rnd=" + Math.random(), function (data, textStatus) {
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                items.push({ type: 'textbox', id: 'stext', text: '附加费名称：' });
                items.push({ type: 'button', text: '搜索', icon: '../../images/search.gif', disable: true, click: function () { doserch() } });
                $("#toolbar").ligerToolBar({
                    items: items
                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
                $("#stext").ligerTextBox({ width: 200 });
                $("#maingrid4").ligerGetGridManager().onResize();
            });
        }
        function doserch() {
            var sendtxt = "&cmd=grid&rnd=" + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("Budge_Rate.aspx?" + serchtxt);
        }
        function add() {
            f_openWindow("CRM/KcGl/Budge_Rate_Add.aspx", "新增附加费", 600, 300);
        }
        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/KcGl/Budge_Rate_Add.aspx?cid=" + row.id, "附加费维护", 600, 300);
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("确定删除？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "Budge_Rate_Add.aspx?cmd=del&cid=" + row.id + "&rnd=" + Math.random(), type: "POST",
                            success: function (data) {
                                if (data == "") {
                                    f_reload();
                                    top.$.ligerDialog.success('操作成功！');
                                }
                                else {
                                    top.$.ligerDialog.error('操作失败，错误信息：' + data);
                                }
                            },
                            error: function (ex) {
                                top.$.ligerDialog.error('操作失败，错误信息：' + ex.responseText);
                            }
                        });
                    }
                });
            }
            else {
                $.ligerDialog.warn("请选择行！");
            }
        }
        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();

                $.ajax({
                    url: "Budge_Rate_Add.aspx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('数据保存中,请稍候...');
                    },
                    success: function (data) {
                        f_reload();
                        if (data == "")
                            top.$.ligerDialog.success('操作成功！');
                        else
                            top.$.ligerDialog.error('操作失败，错误信息：' + data);
                    },
                    error: function (ex) {
                        top.$.ligerDialog.error('操作失败，错误信息：' + ex.responseText);
                    },
                    complete: function () {
                        top.$.ligerDialog.closeWaitting();
                    }
                });
            }
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
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        }
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false;">
        <div id="toolbar"></div>
        <div id="grid">
            <div id="maingrid4" style="margin: -1px; min-width: 800px;"></div>
            <div id="toolbar1"></div>
        </div>
    </form>
</body>
</html>
