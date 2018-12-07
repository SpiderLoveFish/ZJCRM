<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
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
  
    <script type="text/javascript">
        $(function () {

            $("#maingrid4").ligerGrid({
                columns: [
                    //{ display: 'ID', name: 'id', type: 'int', width: 50 },
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                    { display: '客户', name: 'Customer', width: 200 },
                    {
                        display: '财务年月', name: 'cwny', width: 90, render: function (item) {
                            return formatTimebytype(item.cwny, 'yyyy-MM-dd');
                        }   
                    },
                    //{ display: '财务年月', name: 'cwny', width: 70 },
                    { display: '类型', name: 'costtype', width: 70 },
                    { display: '摘要', name: 'summary', width: 600 },
                    { display: '单价', name: 'Price', width: 60 },
                    { display: '数量', name: 'QTY', width: 60 },
                    { display: '预算单数', name: 'BudgeQty', width: 60 },
                    { display: '预算金额', name: 'BudgeAmount', width: 60 },
                    { display: '收款金额', name: 'CollectedAmount', width: 60 },
                    { display: '材料成本', name: 'MaterialCost', width: 60 },
                    { display: '人工成本', name: 'LabourCost', width: 60 },
                    { display: '公司利润', name: 'CompanyMaori', width: 60 },
                    { display: '施工利润', name: 'ConstructionProfit', width: 60 },
                    { display: '业务利润', name: 'BusinessProfit', width: 60 },
                    { display: '设计利润', name: 'DesignProfit', width: 60 },
                    { display: '备注', name: 'Remarks', width: 70 } 
                ],
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                onSelectRow: function (row, index, data) {
                    //alert('onSelectRow:' + index + " | " + data.ProductName); 
                },
                url: "../../data/Financial_Reports_SingleCustomer.ashx?Action=grid1",
                width: '100%',
                height: '100%',
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });
           
            toolbar();
            
        });

        function f_select() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            return rows;
        }

        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=228&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                items.push({ line: true });
                 items.push({
                    type: 'button',
                    text: '导出EXECL',
                    icon: '../../images/icon/43.png',
                    disable: true,
                    click: function () {
                        toexport()
                    }
                });   
                //items.push({
                //    type: 'textbox',
                //    id: 'customer',
                //    name: 'customer',
                //    text: '客户'
                //});
                //items.push({
                //    type: 'textbox',
                //    id: 'type',
                //    name: 'type',
                //    text: '计算类型'
                //});
                items.push({ line: true });
                //items.push({
                //    type: 'button',
                //    text: '搜索',
                //    icon: '../../images/search.gif',
                //    disable: true,
                //    click: function () {
                //        doserch()
                //    }
                //});   
                $("#toolbar").ligerToolBar({
                    items: items

                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
                //$('#customer').ligerComboBox({ width: 120, onBeforeOpen: f_selectContact });
                //$("#type").ligerComboBox({
                //    width: 100, 
                //    url: "../../data/Financial_Reports_SingleCustomer.ashx?Action=combo&rnd=" + Math.random()
                //})
                var manager = $("#maingrid4").ligerGetGridManager();
                manager.onResize();
            });
        }

        function toexport() {
            var sendtxt = "&Action=ToExcel&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
            var url = "../../data/Financial_Reports_SingleCustomer.ashx?" + serchtxt;

            window.open(url);
        }

        function f_selectContact() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择客户', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "../../CRM/Budge/SelectBudgeCustomer.aspx", buttons: [
                    { text: '确定', onclick: f_selectContactOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }

        function f_selectContactOK(item, dialog) {
            //var data = dialog.frame.f_select();
            var fn = dialog.frame.f_select;
            var data = fn();
            if (!data) {
                alert('请选择一个有效客户!');
                return;
            }
            fillemp(data.CustomerID, data.CustomerName, data.address);

            dialog.close();
        }

        function fillemp(id, CustomerName, address) {
          $("#T_companyid").val(id);
            $("#customer").val(CustomerName + "【" + address + "】");




        }
        function f_save() {
            if ($("#T_companyid").val() == "") {
                alert("选择一个正确的客户！");
                return;
            }
            if ($("#T_fylx").val() == "") {
                alert("选择一个正确的计算公式！");
                return;
            }
            var sendtxt = "&Action=save1&fid=" + getparastr("fid");
            return $("form :input").fieldSerialize() + sendtxt;
        }

        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }

        function doserch() {

            if ($('#customer').val() == "")
            {
                alert("选择一个正确的客户！");
                return; }

            var sendtxt = "&Action=grid1&type=0&rnd=" + Math.random();
            var stxt = $("#form1 :input").fieldSerialize();


            var serchtxt = $("#serchform :input").fieldSerialize() + "&" + stxt  + sendtxt;
             //alert(serchtxt);           
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Financial_Reports_SingleCustomer.ashx?" + serchtxt);

        }

        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        };
        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '核算', onclick: function (item, dialog) {
                                f_save(item, dialog);
                            }
                        },
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function hs() {
            f_openWindow('CRM/finance/Financial_Reports_SingleCustomer_add1.aspx', "核算利润分配设置", 690, 500);
        }
         
        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/Financial_Reports_SingleCustomer.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        f_reload();
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('操作失败！');
                    }
                });

            }
        }
    </script>

</head>
<body>

    <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar">
   <input id="T_companyid" name="T_companyid" type="hidden" />
            </div>
            
            <div id="maingrid4" style="margin: -1px;"></div>

        </div>
    </form>


</body>
</html>
