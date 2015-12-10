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
        var manager = "";
        var treemanager;
        $(function () {
            $("#layout1").ligerLayout({ leftWidth: 200, allowLeftResize: false, allowLeftCollapse: true, space: 2, heightDiff: -1 });
            
            initLayout();
            $(window).resize(function () {
                initLayout();
            });

            $("#maingrid4").ligerGrid({
                    columns: [
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                     
                    { display: '编号', name: 'StageDetailID', width: 60 },
                    { display: '评分名称', name: 'Description', width: 200 },                     
                    //{ display: '类别编号', name: 'StageID', width: 60 },
                    { display: '类别名称', name: 'CEStage_category', width: 200 }

                    ],
            dataAction: 'server',
            url: "../../data/CRM_CEScore.ashx?Action=getdetailgrid&sid=" + getparastr("sid") + "&vid=" + getparastr("vid") + "&pid=" + getparastr("pid") + "&sty=" + getparastr("style") + "&rnd=" + Math.random(),
            pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                width: '100%',
                height: '100%',
                heightDiff: -1,
                checkbox: true, checkboxAll: false, isChecked: f_isChecked, onCheckRow: f_onCheckRow, onCheckAllRow: f_onCheckAllRow,
                onContextmenu: function (parm, e) {
                    actionStageDetailID = parm.data.StageDetailID;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });
           
        });
        

        function checkPermit(rowdata, data) {
            if (!data || !data.length) return false;
            for (o in data) {

                if (data[o] == rowdata.StageDetailID) // 用查出来的值与grid中的字段值对应  
                    return true;
            }
            return false;
        }

        function onSelect(note) {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.showData({ Rows: [], Total: 0 });
            var url = "../../data/Crm_product.ashx?Action=grid&categoryid=" + note.data.id + "&rnd=" + Math.random();
            manager.GetDataByURL(url);
            checkedID = [];
        }
        
 
        

 
 
        function f_saveitem(item, dialog) {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row =  manager.getCheckedRows();
            if (row.length > 0) {
                var rowid = "";
                for (var i = 0; i < row.length; i++) {
                    if (i == (row.length - 1)) {
                        rowid += row[i].StageDetailID;
                    }
                    else {
                        rowid += row[i].StageDetailID + ",";
                    }
                }
            }
           
            var sendtxt = "&Action=save&detailid=" + rowid + "&sid=" + getparastr("sid") + "&vid=" + getparastr("vid") + "&pid=" + getparastr("pid") + "&style=" + getparastr("style");
            return $("form :input").fieldSerialize() + sendtxt;
        }


        function prt() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rowid = checkedID.join(',');
            if (rowid.length > 0)
                ViewwStyle(rowid);
                //print_openWindow("crm/product/Product_QrCode_Print.aspx?id=" + rowid, "打印产品", 700, 700);
                //window.open("Product_QrCode_Print.aspx?id=" + rowid,"_blank", 'top=0, left=0, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=n o, status=no');
            else
                $.ligerDialog.warn('请选择产品！');
        }
 
        function f_load() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);

            //treemanager = $("#tree1").ligerGetTreeManager();
            //treemanager.clear();
            //treemanager.FlushData();
        }

        /*
        表单分页多选
        即利用onCheckRow将选中的行记忆下来，并利用isChecked将记忆下来的行初始化选中
        */
        var checkedID = [];
        function f_onCheckAllRow(checked) {
            for (var rowid in this.records) {
                if (checked)
                    addcheckedID(this.records[rowid]['StageDetailID']);
                else
                    removecheckedID(this.records[rowid]['StageDetailID']);
            }
        }
        function findcheckedID(StageDetailID) {
            for (var i = 0; i < checkedID.length; i++) {
                if (checkedID[i] == StageDetailID) return i;
            }
            return -1;
        }
        function addcheckedID(StageDetailID) {
            if (findcheckedID(StageDetailID) == -1)
                checkedID.push(StageDetailID);
        }
        function removecheckedID(StageDetailID) {
            var i = findcheckedID(StageDetailID);
            if (i == -1) return;
            checkedID.splice(i, 1);
        }
  
        function f_isChecked(rowdata) {
            if (rowdata.ischecked == 0)
                return false;
            return true;
        }
        function f_onCheckRow(checked, data) {
            if (checked) addcheckedID(data.StageDetailID);
            else removecheckedID(data.StageDetailID);
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
