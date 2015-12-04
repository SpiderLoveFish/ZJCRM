<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Jifen_kh.aspx.cs" Inherits="Jifen.Jifen_kh" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        var manager;
        var manager1;
        $(function () {
            initLayout();
            $(window).resize(function () {
                initLayout();
            });

            $("#maingrid4").ligerGrid({
                columns: [
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                    {
                        display: '客户姓名', name: 'Name', width: 80, align: 'left', render: function (item) {
                            var html = "<a href='javascript:void(0)' onclick=view(1," + item.ID + ")>";
                            if (item.Name)
                                html += item.Name;
                            html += "</a>";
                            return html;
                        }
                    },
                    { display: '性别', name: 'Sex', width: 40 },
                    { display: '电话', name: 'Tel', width: 120 },
                    { display: '当前总积分', name: 'Jf', width: 80 },
                    { display: '已发放积分', name: 'Jf1', width: 80 },
                    { display: '已使用积分', name: 'Jf2', width: 80 },
                    { display: '客户地址', name: 'Khdz', width: 200, align: 'left' }
                ],
                onBeforeShowData: function (grid, data) {
                    startTime = new Date();
                },
                onSelectRow: function (data, rowindex, rowobj) {
                    var manager = $("#maingrid5").ligerGetGridManager();
                    manager.showData({ Rows: [], Total: 0 });
                    var url = "Jifen_kh.aspx?cmd=grid1&rid=" + data.ID + "&rnd=" + Math.random();
                    manager.GetDataByURL(url);
                },
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                url: "Jifen_kh.aspx?cmd=grid&rnd=" + Math.random(),
                width: '100%',
                height: '65%',
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });
            $("#maingrid5").ligerGrid({
                columns: [
                        { display: '序号', width: 40, render: function (item, i) { return i + 1; } },
                        { display: '积分类型', name: 'Jflx', width: 80 },
                        { display: '分值', name: 'Jf', width: 60 },
                        { display: '积分描述', name: 'Content', width: 200, align: 'left' },
                        { display: '操作人员', name: 'InEmpName', width: 60 },
                        { display: '操作时间', name: 'InDate', width: 145 }
                ],
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                url: "CRM/Jifen/Jifen_kh.aspx",
                width: '100%', height: '100%',
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu1.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });

            $("#grid").height(document.documentElement.clientHeight - $(".toolbar").height());
            $('form').ligerForm();
            toolbar();
        });

        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=93&rnd=" + Math.random(), function (data, textStatus) {
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                items.push({
                    type: 'serchbtn',
                    text: '高级搜索',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        serchpanel();
                    }
                });
                $("#toolbar").ligerToolBar({
                    items: items
                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
            });
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=94&rnd=" + Math.random(), function (data, textStatus) {
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                $("#toolbar1").ligerToolBar({
                    items: items
                });
                menu1 = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });

                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();
            });
        }
        function initSerchForm() {
            $('#Name').val("");
            $('#Tel').val("");
        }
        function serchpanel() {
            initSerchForm();
            if ($(".az").css("display") == "none") {
                $("#grid").css("margin-top", $(".az").height() + "px");
                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();
            }
            else {
                $("#grid").css("margin-top", "0px");
                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();
            }
            $("#company").focus();
        }
        $(document).keydown(function (e) {
            if (e.keyCode == 13 && e.target.applyligerui) {
                doserch();
            }
        });
        function dosearch() {
            var sendtxt = "&cmd=grid&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;           
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("Jifen_kh.aspx?" + serchtxt);

        }
        function doclear() {
            $("#serchform").each(function () {
                this.reset();
                $(".l-selected").removeClass("l-selected");
            });
        }
        function add() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/Jifen/Jifen_kh_add.aspx?cid=" + row.ID + "&jid=0&zjf=" + row.Jf + "&jlx=0", "发放积分", 580, 400);
            } else {
                $.ligerDialog.warn('操作失败，请选择行！');
            }
        }
        function add1() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/Jifen/Jifen_kh_add.aspx?cid=" + row.ID + "&jid=0&zjf=" + row.Jf + "&jlx=1", "使用积分", 580, 400);
            } else {
                $.ligerDialog.warn('操作失败，请选择行！');
            }
        }
        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var manager1 = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
            var row1 = manager1.getSelectedRow();
            if (row && row1) {
                if (row1.Jflx == "0")
                    f_openWindow("CRM/Jifen/Jifen_kh_add.aspx?cid=" + row.ID + "&jid=" + row1.JfID + "&zjf=" + row.Jf + "&jlx=0", "发放积分维护", 770, 530);
                else
                    f_openWindow("CRM/Jifen/Jifen_kh_add.aspx?cid=" + row.ID + "&jid=" + row1.JfID + "&zjf=" + row.Jf + "&jlx=1", "使用积分维护", 770, 530);
            }
            else {
                $.ligerDialog.warn('操作失败，请选择行！');
            }
        }
        function del() {
            var manager = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("删除后将无法恢复，是否确定删除？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "Jifen_kh_add.aspx?cmd=del&jid=" + row.JfID + "&rnd=" + Math.random(), type: "POST",
                            success: function (data) {
                                if (data == "") {
                                    f_reload();
                                    f_reload1();
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
                })
            }
            else {
                $.ligerDialog.warn("操作失败，请选择行！");
            }
        }
        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();

                $.ajax({
                    url: "Jifen_kh_add.aspx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('数据保存中,请稍候...');
                    },
                    success: function (data) {
                        f_reload();
                        f_reload1();
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
        function f_reload1() {
            var manager = $("#maingrid5").ligerGetGridManager();
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
            <div id="grid1" style="position: relative;">
                <div id="maingrid5" style="margin: -1px -1px;"></div>
            </div>
        </div>
    </form>
    <div class="az">
        <form id='serchform'>
            <table style='width: 960px' class="bodytable1">
                <tr>
                    <td style='width: 62px;'>
                        <div style='width: 60px; text-align: right; float: right'>客户姓名：</div>
                    </td>
                    <td style='width: 122px;'>
                        <input type='text' id='Name' name='Name' ltype='text' ligerui='{width:120}' />
                    </td>
                    <td style='width: 42px;'>
                        <div style='width: 40px; text-align: right; float: right'>电话：</div>
                    </td>
                    <td style='width: 122px;'>
                        <input type='text' id='Tel' name='Tel' ltype='text' ligerui='{width:120}' />
                    </td>
                    <td style='width: 42px;'>
                        <div style='width: 40px; text-align: right; float: right'>地址：</div>
                    </td>
                    <td style='width: 222px;'>
                        <input type='text' id='Khdz' name='Khdz' ltype='text' ligerui='{width:220}' />
                    </td>
                    <td>
                        <input id='btnClear' type='button' value='重置' style='width: 80px; height: 24px' onclick="doclear()" />
                        <input id='btnSearch' type='button' value='搜索' style='width: 80px; height: 24px' onclick="dosearch()" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
