<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Repair.aspx.cs" Inherits="Repair.Repair" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <title>维修管理</title>
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
        function request(paras) {
            var url = location.href;
            var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
            var paraObj = {}
            for (i = 0; j = paraString[i]; i++) {
                paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=") + 1, j.length);
            }
            var returnValue = paraObj[paras.toLowerCase()];
            if (typeof (returnValue) == "undefined") {
                return "";
            } else {
                return returnValue;
            }
        }
        var perurl = "Repair.aspx?cmd=grid&rnd=" + Math.random();
        if (request("Nv") != "")
            var perurl = "Repair.aspx?cmd=grid&Khdh=" + request("Khdh") + "&rnd=" + Math.random();

       // alert(request("Khdh"));
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
                        display: '', width: 40, render: function (item) {
                            var html;
                            html = "<a href='Repair_Print.aspx?rid=" + item.RepairID + "' target='_blank'>";
                            html += "打印";
                            html += "</a>";
                            return html;
                        }
                    },
                    {
                        display: '客户姓名', name: 'Khmc', width: 80, align: 'left', render: function (item) {
                            var html;
                            if (item.Khbh != "") {
                                if (request("Nv") == "")
                                html = "<a href='javascript:void(0)' onclick=view(1," + item.Khbh + ")>";
                                else html = "<a> ";
                                if (item.Khmc)
                                    html += item.Khmc;
                                html += "</a>";
                            }
                            else
                                html = item.Khmc;
                            return html;
                        }
                    },
                    { display: '性别', name: 'Khxb', width: 40 },
                    {
                        display: '电话', name: 'Khdh', width: 120, align: 'right'},
                    { display: '所在小区', name: 'Khxq', width: 200, align: 'left' },
                    {
                        display: '维修原因', name: 'wxyy', width: 60, align: 'right', render: function (item) {
                            var html;
                            html = "<div class='wxyy'> ";
                            if (item.Wxyy)
                                html += item.Wxyy;
                            html += "</div>";
                            return html;
                        }
                    },
                { display: '维修类别', name: 'Wxlb', width: 80 },
                    { display: '完成状态', name: 'Wczt', width: 80 },
                    { display: '登记人员', name: 'InEmpName', width: 80 },
                    { display: '登记时间', name: 'InDate', width: 145 },
                     
                    { display: '未完成', name: 'Wwts', width: 60 },
                    { display: '未跟踪', name: 'Wgts', width: 60 }
                

                ],

                onBeforeShowData: function (grid, data) {
                    startTime = new Date();
                },
                onSelectRow: function (data, rowindex, rowobj) {
                    var manager = $("#maingrid5").ligerGetGridManager();
                    manager.showData({ Rows: [], Total: 0 });
                    var url = "Repair.aspx?cmd=grid1&rid=" + data.RepairID + "&rnd=" + Math.random();
                    if (request("Khdh") != "")
                        var url = "Repair.aspx?cmd=grid1&rid=" + data.RepairID + "&Khdh=" + request("Khdh") + "&rnd=" + Math.random();
                    manager.GetDataByURL(url);
                },
               
                rowtype: "Wczt",
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                url: perurl,
                width: '100%',
                height: '65%',
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                },
                onAfterShowData: function (grid) {
                    
                    $(".wxyy").hover(function (e) {
                        $(this).ligerTip({ content: $(this).text(), width: 200, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                    }, function (e) {
                        $(this).ligerHideTip(e);
                    });
                }
                //onAfterShowData: function (grid) {
                //    $("tr[rowtype='完成']").addClass("l-treeleve1").removeClass("l-grid-row-alt");
                //    var nowTime = new Date();

                //}
            });
            $("#maingrid5").ligerGrid({
                columns: [
                        { display: '序号', width: 40, render: function (item, i) { return i + 1; } },
                        {
                            display: '跟进内容', name: 'FollowContent', align: 'left', width: 590, render: function (item) {
                                var html;
                                if (request("Nv") == "")
                                    html = "<div class='abc'><a href='javascript:void(0)' onclick=view(22," + item.FollowID + ")>";
                                else   html = "<div class='abc'> ";
                                if (item.FollowContent)
                                    html += item.FollowContent;
                                html += "</a></div>";
                                return html;
                            }
                        },
                        { display: '跟进时间', name: 'InDate', width: 145 },
                        { display: '跟进方式', name: 'FollowTypeName', width: 60 },
                        {
                            display: '跟进人', name: '', width: 180, render: function (item) {
                                return item.InEmpName;
                            }
                        }
                ],
                onAfterShowData: function (grid) {
                    $(".abc").hover(function (e) {
                        $(this).ligerTip({ content: $(this).text(), width: 200, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                    }, function (e) {
                        $(this).ligerHideTip(e);
                    });
                },
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                url: "CRM/Repair/Repair_Follow.aspx?cmd=grid",
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
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=91&rnd=" + Math.random(), function (data, textStatus) {
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                if (request("Nv") == "")
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
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=6&rnd=" + Math.random(), function (data, textStatus) { 
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
            manager.GetDataByURL("Repair.aspx?" + serchtxt);

        }
        function doclear() {
            $("#serchform").each(function () {
                this.reset();
                $(".l-selected").removeClass("l-selected");
            });
        }
        function add() {
            if (request("Nv") != "") {
               
                f_openWindow("Repair_add.aspx?tel=" + request("Khdh"), "报修登记", 850, 590);
            }
            else {
              
                f_openWindow("CRM/Repair/Repair_add.aspx", "报修登记", 850, 590);
            }
        }
        function addfollow() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                if (request("Nv") != "")
                    follow_openWindow("Repair_Follow_Add.aspx?rid=" + row.RepairID, "新增跟进", 530, 530);
                else
                    follow_openWindow("CRM/Repair/Repair_Follow_Add.aspx?rid=" + row.RepairID, "新增跟进", 530, 530);
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                if (request("Nv") != "")
                    f_openWindow("Repair_Add.aspx?cid=" + row.RepairID, "报修维护", 850, 590);
                else f_openWindow("CRM/Repair/Repair_Add.aspx?cid=" + row.RepairID, "报修维护", 850, 590);
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        function process() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                if (row.Wczt == "完成")
                    $.ligerDialog.error('对不起，此维修单已处理完成，不能再次操作！');
                else {
                    if (request("Nv") != "")
                    process_openWindow("Repair_Process.aspx?cid=" + row.RepairID, "维修处理", 770, 580);
                 else   process_openWindow("CRM/Repair/Repair_Process.aspx?cid=" + row.RepairID, "维修处理", 770, 580);

                }}
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        function editfollow() {
            var manager = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
              
                if (request("Nv") != "")
                    follow_openWindow("Repair_Follow_Add.aspx?fid=" + row.FollowID + "&rid=" + row.RepairID, "修改跟进", 530, 530);
                else follow_openWindow("CRM/Repair/Repair_Follow_Add.aspx?fid=" + row.FollowID + "&rid=" + row.RepairID, "修改跟进", 530, 530);
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("确定删除？", function (yes) {
                    if (yes) {
                        if (row.Wczt == "完成")
                            $.ligerDialog.error('对不起，此维修单已处理完成，不能删除！');
                        else {
                            $.ajax({
                                url: "Repair_Add.aspx?cmd=del&cid=" + row.RepairID + "&rnd=" + Math.random(), type: "POST",
                                success: function (data) {
                                    if (data == "") {
                                        f_reload();
                                        //f_followreload();
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
                    }
                });
            }
            else {
                $.ligerDialog.warn("请选择行！");
            }
        }
        function delfollow() {
            var manager = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("跟进删除无法恢复，确定删除？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "Repair_Follow_Add.aspx?cmd=del&rid=" + row.RepairID + "&fid=" + row.FollowID + "&rnd=" + Math.random(), type: "POST",
                            success: function (data) {
                                if (data == "") {
                                    //f_reload();
                                    f_followreload();
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
                $.ligerDialog.warn("请选择行！");
            }
        }
        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();

                $.ajax({
                    url: "Repair_Add.aspx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('数据保存中,请稍候...');
                    },
                    success: function (data) {
                        f_reload();
                        //f_followreload();
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
        function f_savefollow(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();

                $.ajax({
                    url: "Repair_Follow_Add.aspx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('数据保存中,请稍候...');
                    },
                    success: function (data) {
                        //f_reload();
                        f_followreload();
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
        function f_saveprocess(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();

                $.ajax({
                    url: "Repair_Process.aspx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('数据保存中,请稍候...');
                    },
                    success: function (data) {
                        f_reload();
                        //f_followreload();
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
            if (request("Nv") != "")
            activeDialog = jQuery.ligerDialog.open(dialogOptions);
            else {
                activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
            } 
        }
        function follow_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '保存', onclick: function (item, dialog) {
                                f_savefollow(item, dialog);
                            }
                        },
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'b'
            };
            if (request("Nv") != "")
                activeDialog = jQuery.ligerDialog.open(dialogOptions);
            else {
                activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
            }
        }
        function process_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '处理', onclick: function (item, dialog) {
                                f_saveprocess(item, dialog);
                            }
                        },
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'c', isScroll: true
            };
            activeDialog = top.jQuery.ligerDialog.open(dialogOptions);
        }
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        }
        function f_followreload() {
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
                        <input type='text' id='Khmc' name='Khmc' ltype='text' ligerui='{width:120}' />
                    </td>
                    <td style='width: 42px;'>
                        <div style='width: 40px; text-align: right; float: right'>电话：</div>
                    </td>
                    <td style='width: 122px;'>
                        <input type='text' id='Khdh' name='Khdh' ltype='text' ligerui='{width:120}' />
                    </td>
                    <td style='width: 42px;'>
                        <div style='width: 40px; text-align: right; float: right'>小区：</div>
                    </td>
                    <td style='width: 222px;'>
                        <input type='text' id='Khxq' name='Khxq' ltype='text' ligerui='{width:220}' />
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
