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
     <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
   <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
     <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/json2.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        var manager = "";
        $(function () {
            
            $("#maingrid4").ligerGrid({
                columns: [
                    {
                        display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                        { return (page - 1) * pagesize + rowindex + 1; }
                    },
                     { display: '采购单号', name: 'Purid', width: 100, align: 'left' },
                    { display: '客户', name: 'Customer', width: 60, align: 'left' },
                      { display: '地址', name: 'address', width: 120, align: 'left' },
                 //   { display: '供应商', name: 'supplier_name', width: 100, align: 'left' },
                 
                    { display: '采购数量', name: 'pursum', width: 80, align: 'left' },

                    { display: '采购金额', name: 'subtotal', width: 80, align: 'left' },
                    { display: '标准成本', name: 'InternalPrice', width: 100, align: 'left' },
                    { display: '成本金额', name: 'CostSum', width: 80, align: 'left' },
                      {
                          display: '采购日期', name: 'purdate', width: 90, render: function (item) {
                              var purdate = formatTimebytype(item.purdate, 'yyyy-MM-dd');
                              return purdate;
                          }
                      }
                        
                    //{
                    //    display: '单据状态', name: 'isNode', width: 60, align: 'left'
                    //    , render: function (item) {
                    //        var st;
                    //        if (item.isNode == "0") st = "待提交";
                    //        else if (item.isNode == "1") st = "待审核";
                    //        else if (item.isNode == "2") st = "待确认";
                    //        else if (item.isNode == "3") st = "已确认";
                    //        else if (item.isNode == "99") st = "已废除";
                    //        else st = item.isNode;
                    //        if (item.isNode == "1") {
                    //            st = "<div style='color:#FF0000'>";
                    //            st += "待审核";
                    //            st += "</div>";
                    //        }
                    //        return st;
                    //    }
                    //},

                    //{ display: '产品', name: 'product_name', width: 60, align: 'left' },
                    //{ display: '规格', name: 'specifications', width: 60, align: 'left' },
                    //{ display: '型号', name: 'ProModel', width: 60, align: 'left' },
                    //{ display: '系列', name: 'ProSeries', width: 60, align: 'left' },
                    //{ display: '品牌', name: 'Brand', width: 60, align: 'left' },
                    //{ display: '单位', name: 'unit', width: 60, align: 'left' },
                    //{ display: '材料类型', name: 'c_style', width: 60, align: 'left' },
                    //{ display: '备注', name: 'remarks', width: 200, align: 'left' }

                ],
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: '../../data/Purchase.ashx?Action=gridspdetail&sid=' + getparastr("sid") + '&pid=' + getparastr("pid") + '&isnode=' + getparastr("isnode") + '&starttime=' + getparastr("starttime") + '&endtime=' + getparastr("endtime"),
                width: '100%',
                height: '100%',
                //tree: { columnName: 'StageDescription' },
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }

            });



            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            //toolbar();
        });
                   //查询
        function toolbar() {
            var items = [];
            items.push({ type: 'textbox', id: 'strwhere', text: '搜索内容：' });
            items.push({ type: 'textbox', id: 'starttime', name: 'starttime', text: '开始时间：' });
            items.push({ type: 'textbox', id: 'endtime', name: 'endtime', text: '结束时间：' });
            items.push({ type: 'textbox', id: 'sectype', text: '筛选状态：' });
            items.push({ type: 'button', text: '搜索', icon: '../../images/search.gif', disable: true, click: function () { doserch() } });
            items.push({ type: 'button', text: '明细', icon: '../../images/search.gif', disable: true, click: function () { mx() } });

            $("#toolbar").ligerToolBar({
                items: items

            });
            //menu = $.ligerMenu({
            //    width: 120, items: getMenuItems(data)
            //});
            $('#sectype').ligerComboBox({
                width: 80,
                selectBoxWidth: 100,
                selectBoxHeight: 100,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    data: [
                        { id: 0, text: '采购录入' },
                        { id: 1, text: '采购提交' },
                        { id: 2, text: '采购审核' },
                        { id: 3, text: '采购确认' }
                    ],
                    checkbox: false
                }
            });
          
            $("#strwhere").ligerTextBox({ width: 150 });
            $("#starttime").ligerTextBox({ width: 100, ltype: 'date',nulltext:"11" })
            $("#endtime").ligerTextBox({ width: 100, ltype: 'date' })

            $("#maingrid4").ligerGetGridManager().onResize();

        }
        //查询
        function doserch() {
            var sendtxt = '&Action=gridspview&sid=' + getparastr("sid") + '&pid=' + getparastr("pid") + '&starttime=' + getparastr("starttime") + '&endtime=' + getparastr("endtime")+'&rnd=' + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;
            //  alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Purchase.ashx?" + serchtxt);
        }
        function doclear() {
            //var serchtxt = $("#serchform :input").reset();
            $("#form1").each(function () {
                this.reset();
                $(".l-selected").removeClass("l-selected");
            });
        }
           function f_reload() {
            doserch();
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        };

        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
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

        function mx()
        {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('CRM/Cggl/SupplierPurchase_Detail.aspx?cid=' + row.ID, "明细", 750, 600);
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }
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
