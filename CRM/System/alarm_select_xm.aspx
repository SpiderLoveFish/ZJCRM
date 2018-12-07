<%@ Page Language="C#" AutoEventWireup="true" %>

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
                    { display: '项目ID', name: 'XMID', width: 80, align: 'left' },
                    { display: '项目名称', name: 'XMMC', width: 120, align: 'left' },
                    { display: '项目排序', name: 'XMPX', width: 80, align: 'left' },
                    { display: '操作人', name: 'CZR', width: 80, align: 'left' }
                ],
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/XM_LIST.ashx?Action=grid",
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
            var items = [];
            items.push({ type: 'textbox', id: 'company', text: '姓名：' });
            items.push({ type: 'button', text: '搜索', icon: '../images/search.gif', disable: true, click: function () { doserch() } });

            $("#serchbar1").ligerToolBar({
                items: items

            });
            $("#company").ligerTextBox({ width: 200, nullText: "输入关键词智能搜索客户" });
            $("#maingrid4").ligerGetGridManager().onResize();


        }
        function f_select() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            //alert(rows);
            return rows;
        }


        //查询
        function doserch() {
            var sendtxt = "&Action=getcustomer&rnd=" + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;
            //  alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Crm_CEStage.ashx?" + serchtxt);
        }


        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
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
