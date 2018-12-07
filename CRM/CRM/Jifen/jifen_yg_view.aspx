<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />
    
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
        <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <style type="text/css">
       .gj
       {font-size: 14px;color:red;margin: 10px 5px 0 0;text-align: right;
       }
       .blue
       {font-size: 14px;color:blue;margin: 10px 5px 0 0;text-align: right;
       }
       </style>
    <script type="text/javascript">
        function appendZero(obj) {
            if(obj<10) return "0" +""+ obj;
             else return obj;
    }
        var manager = "";
        var szDevIP = "";
        var type = ""; var tb = ""; var te = ""; 
        $(function () {
            var cur = new Date();
            var y = cur.getFullYear();
            var m = cur.getMonth() + 1;
            var d = cur.getDate();
            if (m > 0 && m < 10)
                m = '0' + m;
            te = y + '-' + m + '-' + d + ' 23:59';
            type = getparastr("viewstyle");
           
            //周排名
            if (type == "Z") {
                tb = y + '-' + m + '-' + appendZero(d-7) + ' 00:00';
              
                strurl = "../../data/Crm_CEStage.ashx?Action=ygjfgrid&starttime="+tb+"&endtime="+te;
                
            }
            //月排名
            if (type == "Y") {
                tb = y + '-' + m + '-01 00:00';
                strurl = "../../data/Crm_CEStage.ashx?Action=ygjfgrid&starttime=" + tb + "&endtime=" + te;
                //document.getElementById("status1").style.display = "block";
                //document.getElementById("status").style.display = "block";
            }
            
           // alert(strurl)
            $("#maingrid4").ligerGrid({
                columns: [
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                    {
                        display: '员工姓名', name: 'name', width: 80, align: 'left', render: function (item) {
                            var html = "<a href='javascript:void(0)' onclick=view(8," + item.ID + ")>";
                            if (item.name)
                                html += item.name;
                            html += "</a>";
                            return html;
                        }
                    },
                    //{ display: '性别', name: 'Sex', width: 40 },
                    { display: '电话', name: 'tel', width: 120, align: 'right' },
                    { display: '奖励总分', name: 'jf1', width: 80 },
                    { display: '处罚积分', name: 'jf2', width: 80 },

                    //{ display: '考核积分', name: 'Jf_z1', width: 80 },
                    { display: '考核积分', name: 'jf3', width: 80 } 
                    //{ display: '剩余积分', name: 'Jf', width: 80 }

                ],
              
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: strurl,
                width: '100%', height: '100%',
                //tree: { columnName: 'StageDescription' },
                heightDiff: -1,
       
            });
 

            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            //$("#grid").height(document.documentElement.clientHeight - $(".toolbar").height());
            //$('form').ligerForm();
            toolbar();
        });

   
        //查询
        function dosearch() {
            

            var sendtxt = "&Action=ygjfgrid&rnd=" + Math.random();
             
            var serchtxt = "starttime=" + $("#startdate").val() + "&endtime=" + $("#enddate").val()  + sendtxt;

     
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Crm_CEStage.ashx?" + serchtxt);

           

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
     
    </script>
   <style type="text/css">
        .l-treeleve1 {
            background: yellow;
        }

        .l-treeleve2 {
            background: yellow;
        }

        .l-treeleve3 {
            background: #eee;
        }
    </style>

</head>
<body>
 <form id="form1" onsubmit="return false">
        <div id="toolbar"></div>

        <div id="grid">
            <div id="maingrid4" style="margin: -1px; min-width: 800px;"></div>
         
        </div>


    </form>
  

</body>
</html>
