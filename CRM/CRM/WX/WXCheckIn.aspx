<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=7" />
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
            var perurl = "../../Data/WX_Base.ashx?Action=grid&IsTop=Y";

            $("#maingrid4").ligerGrid({
                columns: [
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },

                    { display: '财务年月', name: 'cwny', width: 80 },
                         { display: '姓名', name: 'username', width: 160 },
                         { display: '应出勤天数', name: 'ycts', width: 160 },
                         { display: '出勤天数', name: 'cqts', width: 160 },
                         { display: '未正常出勤', name: 'wcqts', width: 160 }


                ],

                onBeforeShowData: function (grid, data) {
                    startTime = new Date();
                },
                onSelectRow: function (data, rowindex, rowobj) {
                    var manager = $("#maingrid5").ligerGetGridManager();
                    manager.showData({ Rows: [], Total: 0 });
                    var sendtxt = "&Action=grid&userid=" + data.userid +"&rnd=" + Math.random();
                    var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;

                    var manager = $("#maingrid5").ligerGetGridManager();
                    manager.GetDataByURL("../../data/WX_Base.ashx?" + serchtxt);
                    //var url = "../../data/WX_Base.ashx?Action=grid&userid=" + data.userid  + "&rnd=" + Math.random();
                    //manager.GetDataByURL(url);
                },

                rowtype: "Wczt",
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                url: perurl,
                width: '100%',
                height: '45%',
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
                    
                   // { display: '姓名', name: 'userid', width: 145 },
                  //  { display: '年月', name: 'cwny', width: 60 },
                    { display: '日期', name: 'rq', width: 120 },
                      { display: '星期', name: 'week', width: 120 },
                    { display: '上班打卡', name: 'sbdk', width: 80 },
                    { display: '下班打卡', name: 'xbdk', width: 80 },
                    { display: '上班位置', name: 'sbwz', width: 200 },
                    { display: '下班位置', name: 'xbwz', width: 200 },
                    { display: '上班状态', name: 'sbzt', width: 80, render: function (item) {

                        var html;
                        if (item.sbzt == "时间异常") {
                            html = "<div style='color:#FF0000'>";
                            html += item.sbzt;
                            html += "</div>";
                        }
                        else if (item.sbzt == "未打卡") {
                            html = "<div style='color:#f0f'>";
                            html += item.sbzt;
                            html += "</div>";
                        }
                        else if (item.sbzt == "地点异常") {
                            html = "<div style='color:#00f'>";
                            html += item.sbzt;
                            html += "</div>";
                        }
                        else {
                            html = item.sbzt;
                        }
                        return html;
                    }
                    },
                    {
                        display: '下班状态', name: 'xbzt', width: 80, render: function (item) {

                            var html;
                            if (item.xbzt == "时间异常") {
                                html = "<div style='color:#FF0000'>";
                                html += item.xbzt;
                                html += "</div>";
                            }
                            else if (item.xbzt == "未打卡") {
                                html = "<div style='color:#f0f'>";
                                html += item.xbzt;
                                html += "</div>";
                            }
                            else if (item.xbzt == "地点异常") {
                                html = "<div style='color:#00f'>";
                                html += item.xbzt;
                                html += "</div>";
                            }
                            else {
                                html = item.xbzt;
                            }
                            return html;
                        }
                    },
                    {
                        display: '状态', name: 'zt', width: 60, render: function (item) {

                            var html;
                            if (item.zt == "异常") {
                                html = "<div style='color:#FF0000'>";
                                html += item.zt;
                                html += "</div>";
                            }
                            else if (item.zt == "正常") {
                                html = "<div style='color:#00f'>";
                                html += item.zt;
                                html += "</div>";
                            }
                            else if (item.zt == "休息") {
                                html = "<div style='color:#2A7F00'>";
                                html += item.zt;
                                html += "</div>";
                            }
                            else {
                                html = item.xbzt;
                            }
                            return html;
                        }
                    }
                ],
                
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                url: "../../Data/WX_Base.ashx?Action = grid& rnd=" + Math.random(),
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
             var items = [];
             items.push({
                 type: 'textbox',
                 id: 'bt',
                 name: 'bt',
                 text: ''
             });
             //items.push({ line: true });
             //items.push({
             //    type: 'textbox',
             //    id: 'et',
             //    name: 'et',
             //    text: ''
             //});
             items.push({ line: true });
             items.push({
                 type: 'button',
                 text: '同步',
                 icon: '../../images/search.gif',
                 disable: true,
                 click: function () {
                     process()
                 }
             });  
             items.push({ line: true });
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
                     dosearch()
                 }
             }); 
             //items.push({
             //    type: 'button',
             //    text: '导出EXECL',
             //    icon: 'print',
             //    disable: true,
             //    click: function () {
             //        itemclick("execl")
             //    }
             //}); 
                $("#toolbar").ligerToolBar({
                    items: items
                });
                //menu = $.ligerMenu({
                //    width: 120, items: getMenuItems(data)
                //});
                var day2 = new Date();
                day2.setDate(day2.getDate() - 2);
                var s2 = day2.format("yyyy-MM");
                $("#bt").ligerDateEditor({ width: 120, nullText: s2, format: 'yyyy-MM' })

                //$("#et").ligerDateEditor({ width: 120, nullText: new Date().format("yyyy-MM-dd"), format: 'yyyy-MM-dd'})
                $("#keyword1").ligerTextBox({ width: 100, nullText: "输入关键词搜索" })
                $("#maingrid4").ligerGetGridManager().onResize();
                //$("#toolbar1").ligerToolBar({
                //    items: [
                //        { text: '导出Excel', id: 'excel', icon: 'print', click: itemclick },
                //        { text: '导出Word', id: 'word', icon: 'print', click: itemclick }
                //    ]
                //});
                $("#maingrid5").ligerGetGridManager().onResize();
        }
        
        $(document).keydown(function (e) {
            if (e.keyCode == 13 && e.target.applyligerui) {
                doserch();
            }
        });
        function  itemclick(item)         {
           var grid = $("#maingrid4").ligerGetGridManager();
            $.ligerDialog.open({ url: "toexecl.aspx?exporttype=xls" }); return;
                        //if (item.id)             {
                        //        switch  (item.id)                 {
                        //                case  "excel": $.ligerDialog.open({ url:  "toexecl.aspx?exporttype=xls" }); return;
                        //                //case  "word": $.ligerDialog.open({ url:  "../service/print.aspx?exporttype=doc" }); return;
                        //        }
                        //}
                }             
        function dosearch() {
            var sendtxt = "&IsTop=Y&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;
            
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../Data/WX_Base.ashx?" + serchtxt);

        }
        function doclear() {
            $("#serchform").each(function () {
                this.reset();
                $(".l-selected").removeClass("l-selected");
            });
        }
        function add() {
             
        }
        function addfollow() {
             
        }
        function edit() {
            
        }
        function getNowFormatDate(date) {
                //var date = new Date();
                var seperator1 = "-";
                var seperator2 = ":";
                var month = date.getMonth() + 1;
                var strDate = date.getDate();
                if (month >= 1 && month <= 9) {
                        month = "0" + month;
                }
                if (strDate >= 0 && strDate <= 9) {
                        strDate = "0" + strDate;
                }
                var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate;
                            //+ " " + date.getHours() + seperator2 + date.getMinutes()
                            //+ seperator2 + date.getSeconds();
                return currentdate;
        } 
        function process() {
           // alert($("#bt").val());
            //var day2 = new Date();
            //  day2.setDate(day2.getDate() - 2);
            //  var s2 = day2.format("yyyy-MM-dd");
            var bt = $("#bt").val();
            //var et = $("#et").val();
            //var bt = getNowFormatDate(vtt);
            //var et = getNowFormatDate(ett);
            $.ajax({
                url: "../../Data/WX_Base.ashx", type: "POST",
                data: { Action: "sync", bt:bt,  rnd: Math.random() },
                success: function (responseText) {
                    if (responseText == "true") {
                        top.$.ligerDialog.alert('获取成功！');
                        f_reload();
                        //f_followreload();
                    }
                    else if (responseText == "false") {
                        top.$.ligerDialog.error('同步操作失败，请联系系统管理员！');
                    }
                },
                error: function () {
                    top.$.ligerDialog.error('同步操作失败！');
                }
            });
        }
        function editfollow() {
            
        }
        function del() {
          
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
            <div id="grid1" style="position: relative;">
                <div id="maingrid5" style="margin: -1px -1px;"></div>
            </div>
        </div>
    </form>
   
</body>
</html>
