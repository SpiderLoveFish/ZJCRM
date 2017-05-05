<%@ Page Language="C#" AutoEventWireup="true"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
     <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>

    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>

    <script src="../../lib/jquery.form.js" type="text/javascript"></script>      
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    
    <script type="text/javascript">

        $(function () {
            $("#maingrid4").ligerGrid({
                columns: [
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                    { display: '����', name: 'title', width: 150 },
                 {
                     display: '����', name: 'modelname', align: 'left', width: 250, render: function (item) {
                         var html = "<div class='abc'> ";
                         if (item.modelname)
                             html += item.modelname;
                         html += " </div>";
                         return html;
                     }
                 },

                    { display: '����(@P1)', name: 'para1', width: 70 },
                   { display: '����(@P2)', name: 'para2', width: 70 },
                      { display: '����(@P3)', name: 'para3', width: 70 },
                         { display: '����(@P4)', name: 'para4', width: 70 },
                            { display: '����(@P5)', name: 'para5', width: 70 },
                            { display: '����(@P6)', name: 'para6', width: 70 },
                      { display: 'ģ�����', name: 'SmsCode', width: 70 },
                    { display: '��ע', name: 'remarks', width: 120 }

                ],
                dataAction: 'server',

                url: "../../data/smsmodel.ashx?Action=grid&rnd=" + Math.random(),
                width: '100%',
                height: '100%',
                //title: "Ա���б�",
                heightDiff: 0
            });
            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            toolbar();
           
        });
        function toolbar() {
            var items = [];
            items.push({ type: 'textbox', id: 'keyword1', text: '�ؼ��֣�' });
            items.push({ type: 'button', text: '����', icon: '../images/search.gif', disable: true, click: function () { doserch() } });

            $("#serchbar1").ligerToolBar({
                items: items

            });
            $("#keyword1").ligerTextBox({ width: 200, nullText: "����ؼ�������" });
            $("#maingrid4").ligerGetGridManager().onResize();


        }
        function f_select() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            //alert(rows);
            return rows;
        }
 
     
        //��ѯ
        function doserch() {
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;
            //  alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/smsmodel.ashx?" + serchtxt);
        }
        
         
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        };
    </script>
   
</head>
<body> 

  <form id="form1" onsubmit="return false"> 
    <div>
            <div id="serchbar1"></div>
              
        <div id="maingrid4" style="margin:-1px; "></div>   
                     
        </div>
    </div>
     
  </form>
   
 
</body>
</html>
