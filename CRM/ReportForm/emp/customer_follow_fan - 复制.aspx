<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
     <link href="../../jlui3.2/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css">
    <link href="../../jlui3.2/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css">
    <link href="../../jlui3.2/lib/ligerUI/skins/Aqua/css/all.css" rel="stylesheet" type="text/css">
    <script src="../../jlui3.2/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script> 
    <script src="../../jlui3.2/lib/ligerUI/js/ligerui.all.js"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
       <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerTip.js" ></script>
     <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
        <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerTextBox.js"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerGrid.js"></script>
    <%--<script src="../../jlui3.2/lib/ligerUI/echarts-all.js"></script>--%>

    <script src="../../JS/echarts-all.js" type="text/javascript"></script>
<%--     
    <link href="../../jlui3.2/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css">
     <script src="../../jlui3.2/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
        <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
     <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>--%>
  

    <script type="text/javascript">
        var g; var tb = ""; var te = "";
        $(function () {
            var cur = new Date();
            var y = cur.getFullYear();
            var m = cur.getMonth() + 1;
            var d = cur.getDate();
            if (m > 0 && m < 10)
                m = '0' + m;
              tb = y+'-'+m + '-' + d+' 00:00';
              te = y + '-' + m + '-' + d + ' 23:59';

              var urlheadcol = "../../data/CRM_Follow.ashx?Action=getprogrid_&startdate=" + tb + "&enddate=" + te + "&rnd=" + Math.random();
              reflash(urlheadcol);

            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            toolbar();
            var serchtxt = "Action=getprogrid&startdate=" + tb + "&enddate=" + te + "&rnd=" + Math.random();
            $.ajax({
                url: "../../data/CRM_Follow.ashx", type: "POST",
                data: serchtxt,
                dataType: 'json',
                beforeSend: function () {
                    // manager.showData({ Rows: [], Total: 0 });
                },
                success: function (responseText) {

                    test(responseText);
                },
                error: function () {
                    top.$.ligerDialog.closeWaitting();
                    top.$.ligerDialog.error('无数据，查询失败！请检查查询项。');
                }
            });

        });


        function reflash(url)
        {
            $.getJSON(url,
                function (json, textStatus) {

                    var colnames = "";
                    var col = [];

                    var x = 0;
                    var ctype = new Array();//初始化数组
                    for (var i in json.Rows[0]) { //在这里读json的列名，当作表格的列名
                        //for (var i = 0; i < json.Rows.length; i++) {
                        //display: '序号', //表头列显示的文本,支持html 
                        ////表头内容自定义函数 
                        //headerRender: function (column) { 
                        //    return "<b>" + column.display + "</b>"; 
                        //}, json.Rows[i]["testid"]

                        x++;

                        if (x < 4) {
                            ctype[x] = "0";
                            //if (x == 2)
                            //    col.push({
                            //        display: i, name: i, align: 'left', width: 20, hide: true });
                            //else
                            if (x == 3)
                                col.push({
                                    display: i, name: i, align: 'left', width: 60,
                                    totalSummary:
                                    {
                                        render: function (suminf, column) {
                                            return "合计：";
                                        }

                                    }
                                });
                            else col.push({
                                display: i, name: i, align: 'left', width: 60
                            });
                            //colnames += ",{name:'" + i + "',display:'" + i + "', width: 80, frozen: true    " +
                            //   " }";
                        }
                        else //+ '</br>'+i.substring(2,3) +
                        {
                            var a = i.split(";")[2];
                            // alert(JSON.stringify(i))
                            if (i.split(";")[1] == "99") {

                                col.push({
                                    name: i, display: a, width: 80,
                                    render: function (record, rowindex, value, column) {
                                        var r; var html = [];
                                        // alert(JSON.stringify(value))
                                        if (value != null) { html += value; }
                                        return html;

                                    },
                                    totalSummary:
                                    {
                                        render: function (suminf, column) {
                                            return suminf.sum;
                                        }

                                    }
                                });
                            }
                            else {
                                //var a = i.split(";")[2];
                                // ctype[x] = i.split(";")[1]
                                //alert(ctype[x])
                                col.push({
                                    name: i, display: a, width: 80,
                                    render: function (record, rowindex, value, column) {
                                        var r; var html = [];
                                        // alert(JSON.stringify(value))
                                        if (value != null) {
                                            // html = value;
                                            r = column.name.split(";")[1];

                                            html = "<a href='javascript:void(0)' onclick=view_follow(" + record.ID + "," + r + ")>";

                                            html += value;
                                            html += "</a>";
                                            //return html;
                                            //if (r.length > 0) {
                                            //    $(this).css('background', "#" + r + "")
                                            //    html = "<div class='tips' style='min-width:30px;;background:#" + r + "'> "
                                            //}
                                            //// html.push("<div style=' width:30,heigth:40,background-color::#800040'>'");
                                            //if (value.split(';')[4].length > 0) html += "&nbsp;۞";

                                            //html += "</br></br>" + value.split(';')[2] + "</br>";
                                            //html += value.split(';')[3] + "</br>";
                                            //html += "<span style='color:red'>" + value.split(';')[4] + "</span></br>";
                                            //html += value.split(';')[0];

                                            //html += "</div>"
                                        }
                                        return html;

                                    },
                                    totalSummary:
                                    {
                                        render: function (suminf, column) {
                                            return suminf.sum;
                                        }

                                    }
                                    //,
                                    //rowAttrRender: function (record, rowindex, value, column) {
                                    //    var r;
                                    //    if (value != null) {
                                    //        r = value.split(';')[0];
                                    //        $(this).css('background', "#" + r + "")
                                    //    }
                                    //}

                                });


                                " }";
                            }
                        }

                    }
                    //colnames = colnames.substr(1, colnames.length);
                    // $.ligerDialog.warn(eval(colnames));
                    j = json;
                    //eval(
                    //            "g=$('#maingrid4').ligerGrid({" +

                    //        "checkbox: false," +
                    //        "height: '100%'," +
                    //        "columns:[" + colnames + "]," +  //然后么拼字符串                        

                    //         "data:j,"+    //这么写适合不分页的grid,还少读一次数据库
                    //        //" + urlheadcol + "
                    //        //"url:'"+urlheadcol+"'," +
                    //        "heightDiff: -1," +
                    //        "dataAction:'server'," +
                    //        " isScroll:true," +
                    //        "resizable: true,"+
                    //        "pageSize:20,pageSizeOptions: [15, 20, 30, 50, 100]" +

                    //        "});"

                    //     );
                    //test(g.getData());
                    g = $("#maingrid4").ligerGrid({
                        columns: [
                        ],
                        onAfterShowData: function (grid) {
                            $('td[class^=l-grid-row-cell]').each(function () {

                                $(this).css('background', $(this).find("div.tips").css('background-color'));
                            });
                            $(".tips").hover(function (e) {
                                $(this).ligerTip({ content: $(this).html().replace("۞", "").replace(/^\s*|\s*$/g, ""), width: 200, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                            }, function (e) {
                                $(this).ligerHideTip(e);
                            });
                        },
                        autoFilter: false,
                        enabledSort: false,
                        dataType: 'server',
                        dataAction: 'server',
                        data: j,
                        //url: urlheadcol ,

                        pageSize: 100, pageSizeOptions: [15, 20, 30, 50, 100],
                        resizable: false,
                        headerRowHeight: 50,
                        height: '100%',
                        isScroll: true,
                        heightDiff: -1,
                        onRClickToSelect: true


                    });
                    var a = [];
                    a.push({ display: 'New主键', name: '序号', align: 'left', width: 220, frozen: true });

                    g.set('columns', col);
                    g.reRender();
                    //$('#mydiv div').each(function(i){

                    $('DIV[class=l-panel-topbar]').css('background', '#E0EDFF');
                    // l - grid - row - cell - inner
                    $('td[class^=l-grid-hd-cell]').each(function () {
                        if ($(this).find("span.l-grid-hd-cell-text").html() == "ID")
                            $(this).find("span.l-grid-hd-cell-text").html("客户编号");
                        var a = $(this).find("span.l-grid-hd-cell-text").html();
                        var b = a.replace(/\d+/g, '')
                        $(this).find("span.l-grid-hd-cell-text").html(b)
                    });

                    // var p = g.find(".l-panel-bar:first").html();
                    // alert(JSON.stringify(g));
                    $("#grid").height(document.documentElement.clientHeight - $(".toolbar").height() - 280);



                });
}


        function toolbar() {
            var items = [];
            items.push({ line: true });
            
            items.push({
                type: 'textbox',
                id: 'startdate',
                text: ''
            });
            items.push({
                type: 'textbox',
                id: 'enddate',
                text: ''
            });
            items.push({
                type: 'button',
                text: '查询',
                icon: '../../images/search.gif',
                disable: true,
                click: function () {
                    dosearch()
                }
            });

            $("#toolbar").ligerToolBar({
                items: items
            });
            //menu = $.ligerMenu({
            //    width: 120, items: getMenuItems(data)
            //});
            $("#startdate").ligerDateEditor();
            $("#enddate").ligerDateEditor();
            $("#startdate").val(tb); $("#enddate").val(te);
           // $("#startdate").ligerTextBox({ width: 100, ltype: "date", nullText: "" })
           // $("#enddate").ligerTextBox({ width: 100, ltype: "date", nullText: "" })
            //$("#maingrid4").ligerGetGridManager().onResize();
        }
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);

        };

        function dosearch() {


            var sendtxt = "Action=getprogrid_&rnd=" + Math.random();
            
            //var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;

            var serchtxt = sendtxt + "&startdate=" + $("#startdate").val() + "&enddate=" + $("#enddate").val();
           // alert(serchtxt);

            var manager = $("#maingrid4").ligerGetGridManager();
            //g.loadData({ url: "../../data/CRM_Follow.ashx?" + serchtxt });
            //manager.set({
            //    //值为local，数据在客户端进行分页
            //    dataAction: "server",
            //    //数据请求地址
            //    url: "../../data/CRM_Follow.ashx?" + serchtxt ,
            //    //数据书否分页，默认为true
            //    usePager: true 
            //});
            //manager.loadData(); //刷新
           // manager.GetDataByURL("../../data/CRM_Follow.ashx?" + serchtxt);
            $.ajax({
                url: "../../data/CRM_Follow.ashx", type: "POST",
                data: serchtxt,
                dataType: 'json',
                beforeSend: function () {
                   // manager.showData({ Rows: [], Total: 0 });
                },
                success: function (responseText) {
                    reflash("../../data/CRM_Follow.ashx?" + serchtxt);//刷新
                                   manager.set({
                                //值为local，数据在客户端进行分页
                                dataAction: "server",
                                //数据请求地址
                                url: "../../data/CRM_Follow.ashx?" + serchtxt ,
                                //数据书否分页，默认为true
                                usePager: true 
                            });
                            manager.loadData(); //刷新
                    top.$.ligerDialog.closeWaitting();
                    test(responseText);
                },
                error: function () {
                    top.$.ligerDialog.closeWaitting();
                    top.$.ligerDialog.error('查询失败！请检查查询项。');
                }
            });
            //test(manager.getData());

        }
        function view_follow(eid, ctype)
        {
             
            f_openWindowview("CRM/Customer/Customer_follow_view.aspx?eid=" + eid + "&ctype=" + ctype+"&startdate=" + $("#startdate").val() + "&enddate=" + $("#enddate").val(), "跟进查看", 867, 600);

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

        function test(GridData) {
            var series = [];
            var legend = [];
            //var mc1 = 0; mc2 = 0; mc3 = 0; mc4 = 0; mc5 = 0; mc6 = 0; mc7 = 0; mc8 = 0; mc9 = 0; mc10 = 0; mc11 = 0; mc12 = 0;
            var data = new Array(), vflowtype = new Array();
            var item_i = 0;

            if (GridData.Rows.length>0)
                for (var item in GridData.Rows[0]) {
                    if (item_i > 2)
                    {
                        var a = 0;
                        if (item == null) a = 0;
                        else if (item == "null") a = 0;
                        else a = item.split(';')[2];
                      //  vflowtype = vflowtype + "," + a;
                        vflowtype.push(a);
                    }
                  
                    item_i++;
                }
            for (var i = 0; i < GridData.Rows.length; i++) {
                var vname = "1";
                if (GridData.Rows[i].姓名 == null) vname = "1";
                else if (GridData.Rows[i].姓名 == "null" || GridData.Rows[i].姓名=="undefined") vname = "";
                else vname = GridData.Rows[i].姓名;
                var flowtype = vname;
             
                //alert(flowtype)
                x = 0;
                data = new Array();
             

                for (var item in GridData.Rows[i]) {
                    if (x > 2) {
                        var a = 0;
                        if (GridData.Rows[i][item] == null) a = 0;
                        else if (GridData.Rows[i][item] == "null") a = 0;
                        else a = GridData.Rows[i][item];
                        a = typeof (a) != 'number' ? 0 : a;
                        //data = data + "," + a;
                        data.push(a);
                    }
                    x++;  
                }
                //for (var ii= 3; ii < GridData.Rows[i].length; ii++)
                //{
                //    var a = 0;
                //    if (GridData.Rows[i][ii] == null) a = 0;
                //   else if (GridData.Rows[i][ii] == "null") a = 0;
                //    else a = GridData.Rows[i][ii];
                //    data = data + "," + a;
                //}
                // data = data.substring(1);
               // alert(JSON.stringify(data));
               // alert(JSON.stringify( GridData.Rows[i]))
           
               // alert(flowtype);
                series.push({ "name": flowtype, "type": "bar", "data": data });
                //if (flowtype=="合计")
                //    series.push({ "name": flowtype, "type": "line", "data": data });
                legend.push(flowtype);
              //  mc1 += m1; mc2 += m2; mc3 += m3; mc4 += m4; mc5 += m5; mc6 += m6; mc7 += m7; mc8 += m8; mc9 += m9; mc10 += m10; mc11 += m11; mc12 += m12;
            }
            //vflowtype = vflowtype.substring(1);
          
            //legend.push("总计");
            //var myChart = echarts.init(document.getElementById('graph'));

            var option = {
                tooltip: {
                    show: true
                },
                legend: {
                    data: legend
                },
                xAxis: [
                    {
                        type: 'category',
                        data: vflowtype
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: series,
                dataZoom: {
                    show: true,
                    realtime: true,
                    start: 0,
                    end: 100
                },
                grid: {
                    x: 40,
                    y: 20,
                    x2: 10
                }
            };

            // 为echarts对象加载数据 
            //myChart.setOption(option);
            //$("#graph").css({ "filter": "alpha(opacity=100)", "background": "#fff" });
        }

    </script>
    <style type="text/css">
        .l-leaving { background: #eee; color: #999; }
    </style>

</head>
<body style="padding: 0px;overflow:hidden;">


    <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar">
                <%--<input type="BUTTON" name="FullScreen" value="全屏" class="box_inp2" onClick="window.open(document.location, 'big', 'fullscreen=yes')">--%>
            </div>
               <%--<div id="graph" style="height: 280px; margin: 5px;"></div>--%>
              <div id="grid">
                  
            <div id="maingrid4" style="margin: -1px;"></div>
                  </div>
        </div>
    </form>


</body>
</html>
