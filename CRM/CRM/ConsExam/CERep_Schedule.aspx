﻿<%@ Page Language="C#" AutoEventWireup="true" %>

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
<%--     
    <link href="../../jlui3.2/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css">
     <script src="../../jlui3.2/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
        <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
     <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>--%>
  

    <script type="text/javascript">
        var g;
        $(function () {
            var urlheadcol = "../../data/CERep_Schedule.ashx?Action=getprogrid&rnd=" + Math.random();
            $.getJSON(urlheadcol,
            function (json, textStatus)
            {
                
                var colnames = "";
                var col = [];
                var x = 0;
                for (var i in json.Rows[0]) { //在这里读json的列名，当作表格的列名
                    //for (var i = 0; i < json.Rows.length; i++) {
                    //display: '序号', //表头列显示的文本,支持html 
                    ////表头内容自定义函数 
                    //headerRender: function (column) { 
                    //    return "<b>" + column.display + "</b>"; 
                    //}, json.Rows[i]["testid"]
                    x++;
                    if (x < 5) {
                        if (x == 1)
                            col.push({ display: i, name: i, align: 'left', width: 40 });
                            else
                          col.push({ display: i, name: i, align: 'left', width: 80});
                         //colnames += ",{name:'" + i + "',display:'" + i + "', width: 80, frozen: true    " +
                         //   " }";
                    }
                    else //+ '</br>'+i.substring(2,3) +
                    {
                        col.push({
                            name: i, display: i, width: 30,  render: function (record, rowindex, value, column) {
                                var r; var html=[];
                             
                                if (value != null) {
                                    r = value.split(';')[0];
                                   
                                    if (r.length > 0) {
                                        $(this).css('background', "#" + r + "")
                                        html = "<div class='tips' style='min-width:30px;;background:#" + r + "'> "
                                    }
                                       // html.push("<div style=' width:30,heigth:40,background-color::#800040'>'");
                                    if (value.split(';')[3].length > 0) html += "&nbsp;۞";
                                     
                                    html += "</br>" + value.split(';')[1] + "</br>";
                                    html +=  value.split(';')[2] + "</br>";
                                    html += "<span style='color:red'>" + value.split(';')[3] + "</span></br>";
                                        html += value.split(';')[4];
                                    
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
                j=json;
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
                                $(this).ligerTip({ content: $(this).html().replace("۞", "").replace(/^\s*|\s*$/g, ""), width: 200, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                            }, function (e) {
                                $(this).ligerHideTip(e);
                            });
                        },
                        autoFilter: true,
                       enabledSort:false,
                        dataType: 'server',
                        dataAction: 'server',
                        data: j,
                        //url: urlheadcol ,
                     
                         pageSize: 100, pageSizeOptions: [15, 20, 30, 50, 100],
                         resizable: false,
                          headerRowHeight:50,
                        height: '100%',
                        isScroll: true,
                        heightDiff: -1,
                        onRClickToSelect: true 
                            
                        
                    });
                  var a=[];
                  a.push({ display: 'New主键', name: 'CID', align: 'left', width: 220, frozen: true });
              
                g.set('columns',col);
                g.reRender();
                //$('#mydiv div').each(function(i){
                
                $('DIV[class=l-panel-topbar]').css('background', '#E0EDFF');
                // l - grid - row - cell - inner
                $('td[class^=l-grid-hd-cell]').each(function () {
                    if ($(this).find("span.l-grid-hd-cell-text").html() == "CID")
                        $(this).find("span.l-grid-hd-cell-text").html("客户编号");
                });
               
                //toolbar();
            });
     

            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            
        });
    
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
            
        };
    </script>
    <style type="text/css">
        .l-leaving { background: #eee; color: #999; }
    </style>

</head>
<body style="padding: 0px;overflow:hidden;">


    <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar"></div>
              <div id="grid">
            <div id="maingrid4" style="margin: -1px;"></div>
                  </div>
        </div>
    </form>


</body>
</html>
