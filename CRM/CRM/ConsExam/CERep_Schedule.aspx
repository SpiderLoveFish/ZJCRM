<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />
     <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>

    <script type="text/javascript">
        var grid = null;

        var j;
        $(function () {
            $("#layout1").ligerLayout({ leftWidth: 200, allowLeftResize: false, allowLeftCollapse: true, space: 2, heightDiff: -1 });
            
            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            var urlheadcol = "../../data/CERep_Schedule.ashx?Action=getprogrid&rnd=" + Math.random();
            $.getJSON(urlheadcol,
            function (json, textStatus)
            {
                
                var colnames = "";
                var x = 0;
                for (var i in json.Rows[0]) { //在这里读json的列名，当作表格的列名
                    //for (var i = 0; i < json.Rows.length; i++) {
                        //display: '序号', //表头列显示的文本,支持html 
                        ////表头内容自定义函数 
                        //headerRender: function (column) { 
                        //    return "<b>" + column.display + "</b>"; 
                    //}, json.Rows[i]["testid"]
                    x++;
                    if(x<5)
                        colnames += ",{name:'" + i + "',display:'" + i + "', width: 80,bgcolor:'#800040'   " +
                            " }";  
                    else //+ '</br>'+i.substring(2,3) +
                        colnames += ",{name:'" + i + "',display:'" + i + "', width: 35,bgcolor:'#800040' " +
                          "   , render: function (record, rowindex, value, column) { " +
                              "  var r;  var html; this.bgcolor='#800040'; " +
                              //"   html = \"&lt;div&nbsp;style='color:\#800040'&gt;\"; " +
                              "  if(value!=null)  {r= value.split(';')[3];if(r.length>0)html=\"██\";} " +//&lt;a\ &gt;
                               //" html += \"&lt;/div&gt;\"; " +
                    " return  html;  " +
                              "   }         "+
                         " }";
                      
                    //else {
                    //    colnames += ",{name:'" + i + "',display:'" + i + "', width: 35 " +
                    //        ", render: function (item) {" +
                    //        "   return \"<div class='abc'>"+i+"</div>\";" +
                    //        "}" +
                    //" }";
                    //}
            }colnames=colnames.substr(1,colnames.length);
           // $.ligerDialog.warn(colnames);
            j=json;
            eval(
                    "$('#maingrid4').ligerGrid({" +

                    "checkbox: false," +
                    
                    "columns:[" + colnames + "]," +  //然后么拼字符串                        
              
                     "data:j,"+    //这么写适合不分页的grid,还少读一次数据库
                    //" + urlheadcol + "
                    //"url:'"+urlheadcol+"'," +
                    "heightDiff: -1," +
                    "dataAction:'server'," +
                    " isScroll:true," +
                "resizable: true,"+
                    "pageSize:18,pageSizeOptions: [15, 20, 30, 50, 100]" +

                    "});"

                    );
          
             //$("#maingrid4").ligerGrid({
             //    columns: [
             //        {
             //            name: '量淋浴房', display: '量淋浴房', width: 35,
             //            render: function (record, rowindex, value, column)
             //            {
             //                var r; var html; html = "<div style='color:#135294'>";
             //                if (value != null) {
             //                    r = value.split(';')[3];
             //                    if (r.length > 0) html = "▇";
             //                } html += "</div>"; return html;
             //            }
             //        }
             //    ],
             //       dataAction: 'server',
             //       data: j,
             //       //url: urlheadcol ,
             //        pageSize: 20,
             //        pageSize: 18, pageSizeOptions: [15, 20, 30, 50, 100],
             //       width: '100%',
             //       height: '100%',
             //       heightDiff: -1,
             //       isScroll: true,
             //       checkbox: false 
             //   });

           

            });
           
           
        });
        
 
        
        
  
       
        
 
        function f_load() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);

            //treemanager = $("#tree1").ligerGetTreeManager();
            //treemanager.clear();
            //treemanager.FlushData();
        }

     
    </script>

</head>
<body style="padding: 0px;overflow:hidden;">
    <form id="form1" onsubmit="return false">
        <div id="layout1" style="margin: -1px">
            
            <div position="center">
                <div id="toolbar"></div>
                <div id="maingrid4" style="margin: -1px;"></div>
            </div>
        </div>
    </form>
</body>
</html>
