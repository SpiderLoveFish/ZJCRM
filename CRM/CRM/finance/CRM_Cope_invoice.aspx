<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />

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
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        var manager;
        var manager1;
        $(function () {

            initLayout();
            $(window).resize(function () {
                initLayout();
            });

            $("#maingrid4").ligerGrid({
                columns: [
                   { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                       {
                           display: '查看', width: 60, render: function (item) {
                               var html = "<a href='javascript:void(0)' onclick=view_cgd('" + item.Purid + "')>查看</a>";
                               return html;
                           }
                       },
                   {
                       display: '客户', name: 'Customer', width: 200, align: 'left', render: function (item) {
                           var html = "<a href='javascript:void(0)' onclick=view(1," + item.customid + ")>";
                           if (item.Customer)
                               html += item.Customer;
                           html += "</a>";
                           return html;
                       }
                   },

                   { display: '供应商', name: 'supplier_name', width: 180 },
                   { display: '订单状态', name: 'isNode', width: 70 },
                  {
                      display: '应付金额（￥）', name: 'payable_amount', width: 100, align: 'right', render: function (item) {
                          return "<div style='color:#135294'>" + toMoney(item.Total_Money) + "</div>";
                      }
                  },

                   {
                       display: '已付金额（￥）', name: 'paid_amount', width: 100, align: 'right', render: function (item) {
                           return "<div style='color:#135294'>" + toMoney(item.receive_money) + "</div>";
                       }
                   },

                   {
                       display: '欠款（￥）', name: 'arrears', width: 100, align: 'right', render: function (item) {
                           return "<div style='color:#135294'>" + toMoney(item.invoice_money) + "</div>";
                       }
                   },
                    {
                        display: '已开票额（￥）', name: 'invoice_money', width: 100, align: 'right', render: function (item) {
                            return "<div style='color:#135294'>" + toMoney(item.invoice_money) + "</div>";
                        }
                    },
                   {
                       display: '未开票额（￥）', name: 'arrears_invoice', width: 100, align: 'right', render: function (item) {
                           return "<div style='color:#135294'>" + toMoney(item.arrears_invoice) + "</div>";
                       }
                   },
                  { display: '材料员', name: 'materialman', width: 80, align: 'left' },
                          { display: '关联单号', name: 'correlation_id', width: 80, align: 'left' },
                   {
                       display: '成交时间', name: 'purdate', width: 90, render: function (item) {
                           return formatTimebytype(item.Order_date, 'yyyy-MM-dd');
                       }
                   }
                ],
                //fixedCellHeight:false,
                onSelectRow: function (data, rowindex, rowobj) {
                    var manager = $("#maingrid5").ligerGetGridManager();
                    manager.showData({ Rows: [], Total: 0 });
                    var url = "../../data/CRM_Cope_invoice.ashx?Action=grid&orderid=" + data.Purid;
                    manager.GetDataByURL(url);
                },
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/Purchase.ashx?Action=grid&Apr=view&rnd=" + Math.random(),
                width: '100%', height: '65%',
                heightDiff: -1,
                onRClickToSelect: true,
               
                detail: {
                    onShowDetail: function (r, p) {
                        for (var n in r) {
                            if (r[n] == null) r[n] = "";
                        }
                        var grid = document.createElement('div');
                        $(p).append(grid);
                        $(grid).css('margin', 3).ligerGrid({
                            columns: [
                                 { display: '序号', width: 30, render: function (item, i) { return i + 1; } },
                                 { display: '产品名', name: 'material_name', width: 120 },
                                 {
                                     display: '单价', name: 'purprice', width: 80, type: 'float', align: 'right', render: function (item) {
                                         return toMoney(item.price);
                                     }
                                 },
                                 { display: '数量', name: 'pursum', width: 40, type: 'int' },
                                 { display: '单位', name: 'unit', width: 40 },
                                 {
                                     display: '总价', name: 'subtotal', width: 100, type: 'float', align: 'right', render: function (item) {
                                         return toMoney(item.amount) + "元";
                                     }
                                 }
                            ],
                            //selectRowButtonOnly: true,
                            usePager: false,
                            checkbox: true,
                            url: "../../data/Purchase.ashx?Action=griddetail&pid=" + r.Purid,
                            width: '99%', height: '100',
                            heightDiff: 0
                        })

                    }
                }
            });
            $("#toolbar").ligerToolBar({
                items: [

                    { type: 'serchbtn', text: '高级搜索', icon: '../../images/search.gif', disable: true, click: function () { serchpanel() } }
                ]
            });
           
            $("#maingrid5").ligerGrid({
                columns: [
                    { display: '序号', width: 50, render: function (item, i) { return i + 1; } },
                    { display: '发票号码', name: 'invoice_num', width: 140 },
                    { display: '发票类型', name: 'invoice_type', width: 100 },
                    {
                        display: '发票金额(￥)', name: 'invoice_amount', width: 120, align: 'right', render: function (item) {
                            return toMoney(item.invoice_amount);
                        }
                    },
                    {
                        display: '开票人', width: 100, render: function (item) {
                            return item.C_depname + "." + item.C_empname;
                        }
                    },
                   {
                       display: '开票日期', name: 'invoice_date', width: 90, render: function (item) {
                           return formatTimebytype(item.invoice_date, 'yyyy-MM-dd');
                       }
                   },
                    { display: '录入人', name: 'create_name', width: 90 },
                    {
                        display: '查看', width: 60, render: function (item) {//71,
                            var html = "<a href='javascript:void(0)' onclick=view_inv('" + item.order_id + "'," + item.id + ")>查看</a>";
                            return html;
                        }
                    }

                ],
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                //checkbox:true,
                url: "../../data/CRM_Cope_invoice.ashx?Action=grid&orderid=0&rnd=" + Math.random(),
                width: '100%', height: '100%',
                //title: "发票信息",
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu1.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });

            $("#grid").height(document.documentElement.clientHeight - $(".toolbar").height());

            $('form').ligerForm();
            
            toolbar();
        });

        function toolbar() {

            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=37&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                $("#toolbar1").ligerToolBar({
                    items: items

                });
                menu1 = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });

                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();
            });
        }
        function initSerchForm() {
            var d = $('#contact').ligerComboBox({ width: 120, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=6&rnd=" + Math.random() });
            var e = $('#employee').ligerComboBox({ width: 96 });
            var f = $('#department').ligerComboBox({
                width: 97,
                selectBoxWidth: 240,
                selectBoxHeight: 200,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    url: '../../data/hr_department.ashx?Action=tree&rnd=' + Math.random(),
                    idFieldName: 'id',
                    //parentIDFieldName: 'pid',
                    checkbox: false
                },
                onSelected: function (newvalue) {
                    $.get("../../data/hr_employee.ashx?Action=combo&did=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        e.setData(eval(data));
                    });
                }
            });
        }
        function serchpanel() {
            initSerchForm();
            if ($(".az").css("display") == "none") {
                $("#grid").css("margin-top", $(".az").height() + "px");
                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();
            }
            else {
                $("#grid").css("margin-top", "0px");
                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();
            }
        }
        $(document).keydown(function (e) {
            if (e.keyCode == 13 && e.target.applyligerui) {
                doserch();
            }
        });
        function doserch() {
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
            //alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Crm_order.ashx?" + serchtxt);           
        }
        function doclear() {
            //var serchtxt = $("#serchform :input").reset();
            $("#serchform").each(function () {
                this.reset();
                $(".l-selected").removeClass("l-selected");
            });
        }
        var activeDialogsview = null;
        function f_openWindow_view(url, title, width, height, code) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [

                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialogsview = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        function view_cgd(id) {
            f_openWindow_view("crm/purchase/PurchaseMainAdd_CK.aspx?pid=" + id + "&status=3&style=view", "采购单", 1100, 600);

        }
        function view_inv(id,id1) {
            f_openWindow_view('CRM/finance/CRM_Cope_add.aspx?orderid=' + id + "&receiveid=" + id1, "应付发票单", 770, 490);

        }
        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '保存', onclick: function (item, dialog) {
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
            activeDialog = top.jQuery.ligerDialog.open(dialogOptions);
        }
        

        function add() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/finance/CRM_Cope_invoice_add.aspx?orderid=" + row.Purid, "新开发票", 770, 490);
            }
            else {
                $.ligerDialog.warn('请选择订单！');
            }
        }

        function edit() {
            var manager = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('CRM/finance/CRM_Cope_invoice_add.aspx?orderid=' + row.Purid + "&invoiceid=" + row.id, "修改发票", 770, 490);
            }
            else {
                $.ligerDialog.warn('请选择发票！');
            }
        }

        function del() {
            var manager = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("发票删除不能恢复，确定删除？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/CRM_Cope_invoice.ashx", type: "POST",
                            data: { Action: "del", id: row.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    f_reload();
                                }
                                else {
                                    top.$.ligerDialog.error('删除失败！');
                                }

                            },
                            error: function () {
                                top.$.ligerDialog.error('删除失败！');
                            }
                        });
                    }
                })
            }
            else {
                $.ligerDialog.warn("请选择发票");
            }
        }


        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();
                $.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/CRM_Cope_invoice.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        $.ligerDialog.closeWaitting();
                        f_reload();
                    },
                    error: function () {
                        $.ligerDialog.closeWaitting();
                        $.ligerDialog.error('操作失败！');
                    }
                });

            }

        }
        function f_reload() {
            $("#maingrid4").ligerGetGridManager().loadData(true);
            $("#maingrid5").ligerGetGridManager().loadData(true);
            top.flushiframegrid("tabid57");
        };

    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">
        <div id="toolbar"></div>

        <div id="grid">
            <div id="maingrid4" style="margin: -1px; min-width: 800px;"></div>
            <div id="toolbar1"></div>
            <div id="maingrid5" style="margin: -1px -1px;"></div>
        </div>


    </form>
    <div class="az">
        <form id='serchform'>
            <table style='width: 720px' class="bodytable1">
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>客户姓名：</div>
                    </td>
                    <td>
                        <input type='text' id='company' name='company' ltype='text' ligerui='{width:120}' /></td>


                    <td>
                        <div style='width: 60px; text-align: right; float: right'>成交时间：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='startdate' name='startdate' ltype='date' ligerui='{width:97}' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='enddate' name='enddate' ltype='date' ligerui='{width:96}' />
                        </div>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>订单状态：</div>
                    </td>
                    <td>
                        <input id='contact' name="contact" type='text' /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>成交人员：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='department' name='department' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='employee' name='employee' />
                        </div>
                    </td>
                    <td></td>
                    <td>
                        <input id='Button2' type='button' value='重置' style='width: 80px; height: 24px' onclick="doclear()" />
                        <input id='Button1' type='button' value='搜索' style='width: 80px; height: 24px' onclick="doserch()" />
                    </td>
                </tr>

            </table>
        </form>
    </div>
</body>
</html>
