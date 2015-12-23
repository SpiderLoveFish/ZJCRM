<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/json2.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>

    <link href="../../jlui3.2/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css">
    <script src="../../jlui3.2/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
        <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>


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
                        col.push({ name: i, display: i, width: 80, frozen: true });
                         colnames += ",{name:'" + i + "',display:'" + i + "', width: 80, frozen: true    " +
                            " }";
                    }
                    else //+ '</br>'+i.substring(2,3) +
                    {
                        col.push({ name: i, display: i, width: 80});

                        colnames += ",{name:'" + i + "',display:'" + i + "', width: 35,bgcolor:'#800040' " +
                          "   , render: function (record, rowindex, value, column) { " +
                              "  var r;  var html;var htmls = [];  " +
                              //" htmls.push('&lt;div&nbsp;style=\"background-color:Black;\"&gt;');" +
                              //"   html = \"&lt;div&nbsp;style='color:#800040'&gt;\"; " +
                              "  if(value!=null)  {r= value.split(';')[3];if(r.length>0)html=\"██\";} " +//&lt;a\ &gt;
                               //" html += \"&lt;/div&gt;\"; " +
                               //"htmls.push('&lt;/div&gt;');" +
                    " return  html;  " +
                              "   }         " +
                         " }";
                    }
                     
                }colnames=colnames.substr(1,colnames.length);
                // $.ligerDialog.warn(eval(colnames));
                j=json;
                eval(
                            "g=$('#maingrid4').ligerGrid({" +

                        "checkbox: false," +
                        "height: '100%'," +
                        "columns:[" + colnames + "]," +  //然后么拼字符串                        
              
                         "data:j,"+    //这么写适合不分页的grid,还少读一次数据库
                        //" + urlheadcol + "
                        //"url:'"+urlheadcol+"'," +
                        "heightDiff: -1," +
                        "dataAction:'server'," +
                        " isScroll:true," +
                        "resizable: true,"+
                        "pageSize:20,pageSizeOptions: [15, 20, 30, 50, 100]" +

                        "});"

                     );
           
                //g = $("#maingrid4").ligerGrid({
                //        columns: [
                         
                //     ],
                //        dataAction: 'server',
                //        data: j,
                //        //url: urlheadcol ,
                //         pageSize: 20,
                //         pageSize: 18, pageSizeOptions: [15, 20, 30, 50, 100],
                //        width: '100%',
                //        height: '100%',
                //        heightDiff: -1,
                //        isScroll: true,
                //        checkbox: false 

                //    });
                // var a=[];
                // a.push({ display: 'New主键', name: 'CID', align: 'left', width: 220 });
                // a.push({ display: 'New公司名', name: 'Cname', width: 140 });
                // var b;
                // b = "{ display: 'New主键', name: 'CID', align: 'left', width: 220 }," +
                //     "{ display: 'New公司名', name: 'Cname', width: 140 }";
                ////    //function f_setColumns() {
                //var columns = [
                //  b
                //];
                //g.set('columns', a.join());
                //g.reRender();

                //}

            });
            

           
       

            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            //toolbar();
        });
        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=44&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                $("#toolbar").ligerToolBar({
                    items: items

                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });

                $("#maingrid4").ligerGetGridManager().onResize();
            });
        }

       
        function f_reload() {
            //var manager = $("#maingrid4").ligerGetGridManager();
            //manager.loadData(true);
            
        };
    </script>
    <style type="text/css">
        .l-leaving { background: #eee; color: #999; }
    </style>

</head>
<body>

    <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar"></div>
            
            <div id="maingrid4" style="margin: -1px;"></div>
        </div>
    </form>


</body>
</html>
