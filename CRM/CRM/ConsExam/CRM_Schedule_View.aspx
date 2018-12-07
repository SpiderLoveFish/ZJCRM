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
    <script src="../../JS/XHD.js"></script>
<%--     
    <link href="../../jlui3.2/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css">
     <script src="../../jlui3.2/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
        <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
     <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>--%>
  

    <script type="text/javascript">
        var g;
        if (getparastr("type") == "sj") typename = "工地库存采购";
        if (getparastr("type") == "jh") typename = "工地库存采购";
        var a = i;
        var cur = new Date();
        var y = cur.getFullYear();
        var m = cur.getMonth() + 1;
        var d = cur.getDate();
        if (m > 0 && m < 10)
            m = '0' + m;
        var t = m+'-'+d;


        $(function () {
            var urlheadcol = "../../data/CRM_Follow.ashx?Action=getovgrid&rnd=" + Math.random();
            if (getparastr("type") == "sj")
                  urlheadcol = "../../data/CRM_Follow.ashx?Action=getovgridsj&rnd=" + Math.random();
            if (getparastr("type") == "jh") 
                  urlheadcol = "../../data/CRM_Follow.ashx?Action=getovgridjh&rnd=" + Math.random();
          
            reflash(urlheadcol);
            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            
        });

        function reflash(url)
        {
            $.getJSON(url,
                function (json, textStatus) {

                    var colnames = "";
                    var col = [];
                    var x = 0;
                    var ms = "";
                    for (var i in json.Rows[0]) { //在这里读json的列名，当作表格的列名
                        //for (var i = 0; i < json.Rows.length; i++) {
                        //display: '序号', //表头列显示的文本,支持html 
                        ////表头内容自定义函数 
                        //headerRender: function (column) { 
                        //    return "<b>" + column.display + "</b>"; 
                        //}, json.Rows[i]["testid"]
                        ms = "";
                        x++;
                        if (x <= 3) {
                            if (x == 3)
                                col.push({ display: i, name: i, align: 'left', width: 250 });
                            else col.push({ display: i, name: i, align: 'left', width: 80 });
                            //colnames += ",{name:'" + i + "',display:'" + i + "', width: 80, frozen: true    " +
                            //   " }";
                        }
                        else //+ '</br>'+i.substring(2,3) +
                        {

                            if (i == t) a = '今天';
                            else a = i;
                            // alert(ms)
                            col.push({
                                name: i, display: a, width: 50, render: function (record, rowindex, value, column) {
                                    var r; var html = [];

                                    if (value != null && value != "") {
                                        // r = value.split(';')[1];
                                        r = value.substring(0, 6); 
                                        //if (r.length > 0) {
                                        $(this).css('background', "#" + r + "");// "#9ACD32")// + r + ""
                                        html = "<div class='tips'  style='z-index:999999;min-width:30px;background:#" + r + "'> ";//" + 9ACD32r + "
                                        //}
                                        // html.push("<div style=' width:30,heigth:40,background-color::#800040'>'");
                                        //  if (value.split(';')[4].length > 0) html += "&nbsp;۞";

                                        html += "</br></br>" + value.substring(6, value.length); + "</br>";//.split(';')[2] 
                                        //html +=  value.split(';')[3] + "</br>";
                                        //html += "<span style='color:red'>" + value.split(';')[4] + "</span></br>";
                                        //    html += value.split(';')[0];

                                        //  if (r.length > 0)
                                        html += "</div>"
                                    }
                                    return html;

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

                    g = $("#maingrid4").ligerGrid({
                        columns: [
                        ],
                        onAfterShowData: function (grid) {
                            $('td[class^=l-grid-row-cell]').each(function () {

                                $(this).css('background', $(this).find("div.tips").css('background-color'));
                            });
                            $(".tips").hover(function (e) {
                                $(this).ligerTip({
                                    content: $(this).html().replace("۞", "").replace(";", "\n").replace("#", "----------------------</br>").replace(/^\s*|\s*$/g, ""),
                                    width: 400, x: 800, y: 300, distanceX: -400, distanceY: event.clientY - $(this).offset().top -120 ,
                                  //  event.clientX - $(this).offset().left - $(this).width() + 15 
                                });
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
                    a.push({ display: 'New主键', name: 'ID', align: 'left', width: 220, frozen: true });

                    g.set('columns', col);
                    g.reRender();
                    //$('#mydiv div').each(function(i){

                    $('DIV[class=l-panel-topbar]').css('background', '#E0EDFF');
                    // l - grid - row - cell - inner
                    $('td[class^=l-grid-hd-cell]').each(function () {
                        // var a = $(this).find("span.l-grid-hd-cell-text").html();
                        if ($(this).find("span.l-grid-hd-cell-text").html() == "ID")
                            $(this).find("span.l-grid-hd-cell-text").html("客户编号");
                        if ($(this).find("span.l-grid-hd-cell-text").html() == "今天")
                            $(this).css('background', "#FF8247")
                        //else $(this).find("span.l-grid-hd-cell-text").html(a.replace('-',''));
                        var a = $(this).find("span.l-grid-hd-cell-text").html();
                        //var b = a.replace(/\d+/g, '')
                        // $(this).find("span.l-grid-hd-cell-text").html(b)
                    });

                    // var p = g.find(".l-panel-bar:first").html();
                    // alert(JSON.stringify(g));
                    $("#grid").height(document.documentElement.clientHeight - $(".toolbar").height());
                    toolbar();
                });

        }

        function toolbar() {
            var items = [];
            items.push({ line: true });
            items.push({
                type: 'button',
                text: '全屏',
                icon: '../../images/search.gif',
                disable: true,
                click: function () {
                  window.open(document.location, 'big', 'fullscreen=yes')   
                }
            });     
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
        }
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
            
        };
        function dosearch() {


            var sendtxt = "Action=getovgridjh&rnd=" + Math.random();

            //var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;

            var serchtxt = sendtxt + "&startdate=" + $("#startdate").val() + "&enddate=" + $("#enddate").val();
            // alert(serchtxt);

            var manager = $("#maingrid4").ligerGetGridManager();
            //g.loadData({ url: "../../data/CRM_Follow.ashx?" + serchtxt });
            reflash("../../data/CRM_Follow.ashx?" + serchtxt);
            manager.set({
                //值为local，数据在客户端进行分页
                dataAction: "server",
                //数据请求地址
                url: "../../data/CRM_Follow.ashx?" + serchtxt ,
                //数据书否分页，默认为true
                usePager: true 
            });
            manager.loadData(); //刷新
            // manager.GetDataByURL("../../data/CRM_Follow.ashx?" + serchtxt);
            

        }
        function viewdy() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                // viewkjl('../../CRM/ConsExam/kjl_index.aspx?cid=' + row.id+ '&name=' + encodeURI("【" + row.Customer + "】" + row.address), "【" + row.address + "】");
                f_openWindow_view('CRM/Customer/Customer_DynamicGraphics.aspx?cid=' + row.CID + '&name=' + encodeURI(row.小区名称)
                    + '&tel=' + row.电话 , "【" + row.具体地址 + "】全景图库", 660, 550);
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
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
        //function viewdy() {
        //    //url, newname
        //    var manager = $("#maingrid4").ligerGetGridManager();
        //    var row = manager.getSelectedRow();
        //    //alert(JSON.stringify(row));
        //    if (row) {
        //        $.ajax({
        //            url: "../../Data/website.ashx", type: "GET",
        //            data: { Action: "getqjapi", tel: row.电话, rnd: Math.random() },
        //            //data: { tel: row.tel},
        //            success: function (result) {

        //                var obj = eval("(" + result + ")");


        //                if (obj.status == 1) {
        //                    $.each(obj.data, function (i, data) {
        //                        if (data.project.length > 0) {
        //                            $.each(data.project, function (i, r) {
        //                                window.open(r["thumb_path"] + "?1=1&width=" + screen.width +
        //                                    "&height=" + (screen.height - 70), r["name"],
        //                                    "top=0,left=0,toolbar=no, menubar=no, scrollbars=yes,resizable=no,location=no,status=no,width=" +
        //                                    screen.width + ",height=" +
        //                                    (screen.height - 70));
        //                                //alert(r["name"]);
        //                            })
        //                        } else {
        //                            alert("没有获取到有效得全景图！");
        //                        }
        //                    });
        //                } else {
        //                    alert("获取失败！！");
        //                }


        //            },
        //            error: function () {

        //                alert("获取失败2！");

        //            }
        //        });
        //    }

        //}
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
              <div id="grid">
            <div id="maingrid4" style="margin: -1px;"></div>
                  </div>
        </div>
    </form>


</body>
</html>
