﻿<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
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
        $(function () {
            $("#maingrid4").ligerGrid({
                columns: [
                     {
                         display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                         { return (page - 1) * pagesize + rowindex + 1; }
                     },
                    // { display: '客户编号', name: 'CustomerID', width: 50, align: 'left' },
                      { display: '客户姓名', name: 'CustomerName', width: 80, align: 'left' },
                       { display: '客户电话', name: 'tel', width: 100, align: 'left' },
                        { display: '客户地址', name: 'address', width: 200, align: 'left' },
                      { display: '施工监理', name: 'sgjl', width: 80, align: 'left' },
                        { display: '业务员', name: 'ywy', width: 80, align: 'left' },
                   { display: '设计师', name: 'sjs', width: 80, align: 'left' },
                 //  { display: '附加分', name: 'SpecialScore', width: 50, align: 'right' },
                //{
                //  display: '考核分', name: 'StageScore', width: 50, align: 'right', render: function (item) {
                //    return "<div style='color:#135294'>" + item.StageScore + "</div>";
                //}
                //},
              //   { display: '总得分', name: 'sum_Score', width: 50, align: 'right' },
                  { display: '材料总数', name: 'sl', width: 80, align: 'right' },
                  { display: '提交采购', name: 'cgsl', width: 80, align: 'right' },
                 {
                     display: '考核达成', name: 'Scoring', width: 80, align: 'right', render: function (item) {

                         var html;
                         if (item.sum_Score / item.TotalScorce > 0.9) {
                             html = "<div style='color:#008040'>";
                             if (item.Scoring)
                                 html += item.Scoring;
                             html += "</div>";
                         }
                         else
                             if (item.sum_Score / item.TotalScorce > 0.5) {
                                 html = "<div style='color:#800040'>";
                                 if (item.Scoring)
                                     html += item.Scoring;
                                 html += "</div>";
                             }
                             else
                                 html = "<div style='color:#F00'>" + item.Scoring + "</div>";
                         return html;
                     }
                 },
                     //   { display: '状态', name: 'Stage_icon', width: 80, align: 'left' },
                { display: '备注', name: 'Remarks', width: 200, align: 'left' }

                ],
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/Crm_CEStage.ashx?Action=grid1",
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
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=148&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
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

                $("#maingrid4").ligerGetGridManager().onResize();
            });
        }

        function serchpanel() {
            initSerchForm();
            if ($(".az").css("display") == "none") {
                $("#grid").css("margin-top", $(".az").height() + "px");
                $("#maingrid4").ligerGetGridManager().onResize();

            }
            else {
                $("#grid").css("margin-top", "0px");
                $("#maingrid4").ligerGetGridManager().onResize();

            }

        }
        function initSerchForm() {
            $("#khstext").addClass("l-text");
            $("#dzstext").addClass("l-text");
            $("#dhstext").addClass("l-text");
            $("#sgjlstext").addClass("l-text");
            $("#ztstext").ligerComboBox({ width: 100 })
            //$("#dclbstext").ligerTextBox({ width: 100 });

            $("#dclbstext").addClass("l-text");
            $("#dclestext").addClass("l-text");

        }

        //查询
        function doserch() {
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
            //  alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Crm_CEStage.ashx?" + serchtxt);
        }
        function doclear() {
            //var serchtxt = $("#serchform :input").reset();
            $("#serchform").each(function () {
                this.reset();
                $(".l-selected").removeClass("l-selected");
            });
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
        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        //{
                        //    text: '保存', onclick: function (item, dialog) {
                        //        f_save(item, dialog);
                        //    }
                        //},
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        //明细
        function detail() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindowview("crm/ConsExam/CEStage_ViewDetail.aspx?pid=" + row.id
                    + "&name=" + encodeURI(row.CustomerName)
                    + "&address=" + encodeURI(row.address)
                    + "&sgjl=" + encodeURI(row.sgjl)
                     + "&zf=" + row.TotalScorce
                    + "&dcl=" + row.Scoring
                    + "&df=" + row.sum_Score,
                    "明细查询", 700, 530);
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        //施工进度
        function process() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindowview("crm/ConsExam/SGJD_List_View.aspx?cid=" + row.CustomerID
                    + "&khmc=" + encodeURI(row.CustomerName + "[" + row.address + "]")
                    + "&tel=" + row.tel
                + "&sjzt=" + encodeURI(row.Stage_icon)
                + "&sgjl=" + encodeURI(row.sgjl)
                + "&jhdate=" + row.Jh_date
                   ,
                    "时间轴查询", 800, 550);
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        //工地配料
        function add() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("crm/ConsExam/SelectMaterials_add.aspx?cid=" + row.CustomerID + "&sgjl=" + encodeURI(row.sgjl), "【" + row.CustomerName + "】" + row.address + " - 材料清单", 1100, 600);
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        function pro() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("crm/ConsExam/SelectMaterials_pro.aspx?cid=" + row.CustomerID, "【" + row.CustomerName + "】" + row.address + " - 材料处理", 1100, 600);
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
           
            if (row) {
                f_openWindow("crm/ConsExam/SelectMaterials_add.aspx?cid=" + row.CustomerID , "修改客户", 720, 500);
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }

        function f_save(item, dialog) {

            var issave = dialog.frame.f_save();

            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/CRM_CEStage.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        if (responseText == "false:type") {
                            top.$.ligerDialog.error('操作失败，施工监理不能为空，请先到客户档案维护！');
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
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
            top.flushiframegrid("tabid39");
        };
    </script>
    <style type="text/css">
        .l-leaving {
            background: #eee;
            color: #999;
        }
    </style>

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
    <div class="az">
        <form id='serchform'>
            <table style='width: 960px' class="bodytable1">
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>客户姓名：</div>
                    </td>
                    <td>

                        <input ltype='text' ligerui='{width:120}' type='text' id='khstext' name='khstext' /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>地址：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='dzstext' name='dzstext' ltype='text' ligerui='{width:120}' />
                        </div>

                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>电话：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='dhstext' name='dhstext' ltype='text' ligerui='{width:120}' />
                        </div>

                    </td>
                    <td>
                        <input id='Button1' type='button' value='搜索' style='width: 80px; height: 24px' onclick="doserch()" />

                        <input id='Button2' type='button' value='重置' style='width: 80px; height: 24px'
                            onclick="doclear()" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>施工监理：</div>
                    </td>
                    <td>
                        <input id='sgjlstext' name="sgjlstext" type='text' ltype='text' ligerui='{width:120}' /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>状态：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='ztstext' name='ztstext' ltype='text' ligerui="{width:196,data:[{id:'正在施工',text:'正在施工'},{id:'施工完成',text:'施工完成'}]}" validate="{required:false}" />
                        </div>

                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>达成率：</div>
                    </td>
                    <td>
                        <div style='width: 300px; float: left'>
                            <input type='text' id='dclbstext' name='dclbstext' ltype='text' ligerui="{width:50}" />

                            -->
                   
                            <input type='text' id='dclestext' name='dclestext' ltype='text' ligerui="{width:50}" />
                        </div>
                    </td>

                </tr>

            </table>
        </form>
    </div>


</body>
</html>
