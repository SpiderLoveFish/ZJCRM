<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LJ_Ewm.aspx.cs" Inherits="LJ_Ewm.LJ_Ewm" %>

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
                    { display: '名称', name: 'Name', width: 150, align: 'left' },
                      {
                           display: '外链', width: 40, render: function (item) {
                               var html;
                               if (item.URL != "") {
                                   html = "<a href='" + item.URL + "' target='_blank'>";
                                   html += "查看";
                                   html += "</a>";
                              }
                               else html = "暂无";
                               return html;
                           }
                      },
                  {
                      display: '', width: 50, render: function (item) {
                          var html = "<a href='javascript:void(0)' onclick=QrCode('" + item.URL + "')>二维码</a>"
                          return html;
                      }
                  },
                    { display: '第一行', name: 'A', width: 200, align: 'left' },
                    { display: '第二行', name: 'B', width: 200, align: 'left' },
                    { display: '第三行', name: 'C', width: 200, align: 'left' },
                    { display: '备注', name: 'Remark', width: 150 },
                 //   { display: '第五行', name: 'E', width: 200, align: 'left' },
                  //  { display: '第六行', name: 'F', width: 200, align: 'left' },
                   // { display: '第七行', name: 'G', width: 200, align: 'left' },
                   // { display: '第八行', name: 'H', width: 200, align: 'left' },
                   // { display: '第九行', name: 'I', width: 200, align: 'left' },
                   // { display: '登记人', name: 'InEmpID', width: 80 },
                    { display: '登记日期', name: 'InDate', width: 150 }
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
                url: "LJ_Ewm.aspx?cmd=grid&rnd=" + Math.random(),
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
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=178&rnd=" + Math.random(), function (data, textStatus) {
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                items.push({ type: 'textbox', id: 'stext', text: '搜索内容：' });
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
            manager.GetDataByURL("LJ_Ewm.aspx?" + serchtxt);
        }
        function add() {
            f_openWindow("CRM/Cggl/LJ_Ewm_Add.aspx", "新增二维码", 600, 330);
        }
        function QrCode(pid) {
            var dialogOptions = {
                width: 320, height: 360, title: "二维码预览", url: '../view/QrCode_LJ_View.aspx?pid=' + pid, buttons: [
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/Cggl/LJ_Ewm_Add.aspx?cid=" + row.ID, "维护二维码", 600, 330);
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
                            url: "LJ_Ewm_Add.aspx?cmd=del&cid=" + row.ID + "&rnd=" + Math.random(), type: "POST",
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
                    url: "LJ_Ewm_Add.aspx", type: "POST",
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
