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
            var urlheadcol = "../../data/CERep_Schedule.ashx?Action=getheadcol&rnd=" + Math.random();
            $.getJSON(urlheadcol,
            function (json, textStatus)
            {
                var colnames = "";
               // $.ligerDialog.warn(json);
               // for (var i in json.Rows[0])  //�������json��������������������
                    for (var i = 0; i < json.Rows.length; i++) {
                        //display: '���', //��ͷ����ʾ���ı�,֧��html 
                        ////��ͷ�����Զ��庯�� 
                        //headerRender: function (column) { 
                        //    return "<b>" + column.display + "</b>"; 
                        //}, 
                        colnames += ",{name:'" + json.Rows[i]["testid"] + "',display:'" + json.Rows[i]["testname"] + "', width: 35}";
            }colnames=colnames.substr(1,colnames.length);
            //$.ligerDialog.warn(colnames);
            j=json;
            eval(

                    "grid=$('#maingrid4').ligerGrid({" +

                    "checkbox: false," +
                    "delayLoad: true, "+
                    "columns:[" + colnames + "]," +  //Ȼ��ôƴ�ַ���                        
                
                    //"data:j,"+    //��ôд�ʺϲ���ҳ��grid,���ٶ�һ�����ݿ�
                    //" + urlheadcol + "
                    "url:''," +
                    "heightDiff: -1," +
                    "dataAction:'server'," +
                    " isScroll:true," +
                 
                    "pageSize:10,pageSizeOptions: [10, 15, 20, 30, 50, 100]" +

                    "});"

                );

            });
            //$("#maingrid4").ligerGrid({
            //        columns: [
            //        { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                     
            //        { display: '���', name: 'StageDetailID', width: 60 },
            //        { display: '��������', name: 'Description', width: 200 },                     
            //        //{ display: '�����', name: 'StageID', width: 60 },
            //        { display: '�������', name: 'CEStage_category', width: 200 },
            //        {
            //            display: '', width: 40, render: function (item) {
            //                var html = "<a href='javascript:void(0)' onclick=view(" + item.StageDetailID + ")>�鿴����</a>"
            //                //," + item.StageID + ",'" + item.CEStage_category + "'
            //                return html;
            //            }
            //        }

            //        ],
            //dataAction: 'server',
            //url: "../../data/CRM_CEScore.ashx?Action=getdetailgrid&sid=" + getparastr("sid") + "&vid=" + getparastr("vid") + "&pid=" + getparastr("pid")  + "&sty=" + getparastr("style") + "&rnd=" + Math.random(),
            //pageSize: 30,
            //    pageSizeOptions: [20, 30, 50, 100],
            //    width: '100%',
            //    height: '100%',
            //    heightDiff: -1,
            //    checkbox: true, checkboxAll: false, isChecked: f_isChecked, onCheckRow: f_onCheckRow, onCheckAllRow: f_onCheckAllRow,
            //    onContextmenu: function (parm, e) {
            //        actionStageDetailID = parm.data.StageDetailID;
            //        menu.show({ top: e.pageY, left: e.pageX });
            //        return false;
            //    }
            //});
            $(".l-grid-hd-cell-text").css("height", "auto")
            
           
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
