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
        var customerIdSelected; //记录当前选择操作的行的客户ID
        $(function () {
        
            var varurl   = "../../data/Financial_Labour_Cost.ashx?Action=grid&IsApr=FK";
                  $("#maingrid4").ligerGrid({
                columns: [
                  
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                    { display: '编号', name: 'F_Num', align: 'left', width: 120},
                    { display: '类型', name: 'F_StyleName', width: 70 },
                    { display: '客户', name: 'Customer', width: 350 },
                    { display: '工人', name: 'worker', width: 250 },
                    {
                              display: '结算金额', name: 'TotalAmount', width: 80, align: 'right', render: function (item) {
                                  return "<div style='color:#135294'>" + toMoney(item.TotalAmount) + "</div>";
                              }
                    },
                    {
                              display: '已付金额', name: 'Receive_amount', width: 80, align: 'right', render: function (item) {
                                  return "<div style='color:#135294'>" + toMoney(item.Receive_amount) + "</div>";
                              }
                          },
                                  {
                                      display: '未付金额', name: 'UnReceive_amount', width: 80, align: 'right', render: function (item) {
                                          var html;
                                     if (item.UnReceive_amount== 0) {
                                      html = "<div style='color:#135294'>" + toMoney(item.UnReceive_amount) + "</div>";
                                                                 }
                                  else  
                                  {
                                      html = "<div style='color:#ff0000'>" + toMoney(item.UnReceive_amount) + "</div>";
                                                       }
                                           return html;
                                 
                              }
                          },
                
                    { display: '标准金额', name: 'Amount', width: 70 },
                      { display: '调整金额', name: 'AdjustAmount', width: 70 },
                 
                    { display: '工时', name: 'ManHour', width: 70 },
                    { display: '单价(人/天)', name: 'ManDayPrice', width: 70 },
                            
                  
                    { display: '保存人', name: 'CreatePerson', width: 70 },
                    { display: '备注', name: 'Remarks', width: 70 },
                    {
                        display: '保存日期', name: 'CreateTime', width: 90, render: function (item) {
                            return formatTimebytype(item.CreateTime, 'yyyy-MM-dd');
                        }
                    },
                    { display: '状态', name: 'IsStatus', width: 70 },
                    { display: '来源', name: 'FromWhere', width: 70 }
                ],
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                onSelectRow: function (data, rowindex, rowobj) {
                    //alert(JSON.stringify(data))
                    customerIdSelected = data.F_Num;
                    var manager = $("#maingrid5").ligerGetGridManager();
                    manager.showData({ Rows: [], Total: 0 });
                    var url =   "../../data/Financial_Labour_Cost_Recive.ashx?Action=grid&F_Num=" + data.F_Num;
                    
                    manager.GetDataByURL(url);
                },
                url: varurl,
                width: '100%',
                height: '65%',
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });
           
          
            $("#maingrid5").ligerGrid({
                columns: [
                    { display: '序号', width: 50, render: function (item, i) { return i + 1; } },



                    {
                        display: '类型', name: 'receive_direction_name', width: 60, render: function (item) {

                            var html;


                            if (item.receive_direction_name == "付款") {
                                html = "<div style='color:#00f'>";
                                html += "付款";
                                html += "</div>";
                            }
                            else if (item.receive_direction_name == "退款") {
                                html = "<div style='color:#FF0000'>";
                                html += "退款";
                                html += "</div>";
                            }
                     
                            else {
                                html = item.receive_direction_name;
                            }
                            return html;
                        }
                    },
                    {
                        display: '金额（￥）', name: 'Receive_amount', width: 80, align: 'right', render: function (item) {

                            var html;


                            if (item.receive_direction_name == "应收") {
                                html = "<div style='color:#000'>";
                                html += toMoney(item.Receive_amount);
                                html += "</div>";
                            }
                            else if (item.Receive_amount >= 0) {
                                html = "<div style='color:#00f'>";
                                html += toMoney(item.Receive_amount);
                                html += "</div>";
                            }
                            else if (item.Receive_amount < 0) {
                                html = "<div style='color:#FF0000'>";
                                html += toMoney(item.Receive_amount);
                                html += "</div>";
                            }

                            else {
                                html = item.Receive_amount;
                            }
                            return html;
                        }
                    },
                    { display: '方式', name: 'Pay_type', width: 100 },
                    { display: '凭证号码', name: 'Receive_num', width: 140 },

                    {
                        display: '处理人', width: 100, render: function (item) {
                            return item.C_depname + "." + item.C_empname;
                        }
                    },
                    {
                        display: '处理日期', name: 'Receive_date', width: 90, render: function (item) {
                            return formatTimebytype(item.Receive_date, 'yyyy-MM-dd');
                        }
                    },
                    { display: '录入人', name: 'create_name', width: 90 },

                    {
                        display: '状态', name: 'IsStatus', width: 60, render: function (item) {

                            var html;


                            if (item.IsStatus == "待确认") {
                                html = "<div style='color:#FF0000'>";
                                html += "待确认";
                                html += "</div>";
                            }
                            else if (item.IsStatus == "已确认") {
                                html = "<div style='color:#00f'>";
                                html += "已确认";
                                html += "</div>";
                            }
                            else if (item.IsStatus == "作废") {
                                html = "<div style='color:#999'>";
                                html += "作废";
                                html += "</div>";
                            }

                            else {
                                html = item.IsStatus;
                            }
                            return html;
                        }
                    },
                    {
                        display: '查看', width: 60, render: function (item) {
                            var html = "";
                            if (item.receive_direction_name == "收定金" || item.receive_direction_name == "退定金" || item.receive_direction_name == "收装修款" || item.receive_direction_name == "退装修款") {
                                html = "<a href='javascript:void(0)' onclick=\"view_fk(  '" + customerIdSelected + "' , '" + item.id + "' )\">查看</a>";
                            }
                            //else if (item.receive_direction_name == "定金" || item.receive_direction_name == "签单") {
                            //    html = "<a href='javascript:void(0)' onclick=view_fk(2,'" + customerIdSelected  + "'," + item.id + ")>查看</a>";
                            //}
                            return html;
                        }
                    }

                ],
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                //checkbox:true,
                url: "../../data/Financial_Labour_Cost_Recive.ashx?Action=grid&F_Num=0&rnd=" + Math.random(),
                width: '100%', height: '100%',
                //title: "收款信息",
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

        function f_select() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            return rows;
        }

        function toolbar() {

            var   url = "../../data/toolbar.ashx?Action=GetSys&mid=244&rnd=" + Math.random();

            $.getJSON(url, function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }

                items.push({
                    type: 'textbox',
                    id: 'keyword1',
                    name: 'keyword1',
                    text: ''
                });
                items.push({
                    type: 'button',
                    text: '搜索',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        doserch()
                    }
                });


                $("#toolbar").ligerToolBar({
                    items: items
                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
                $("#maingrid4").ligerGetGridManager().onResize();

                $("#keyword1").ligerTextBox({ width: 200, nullText: "输入关键词搜索" })

            });

            //下面的菜单
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=261&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                items.push({ line: true });
                items.push({
                    type: 'textbox',
                    id: 'sectype1',
                    name: 'sectype1',
                    text: '筛选'
                });
                items.push({
                    type: 'button',
                    text: '搜索',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        doserch1()
                    }
                });

                $("#toolbar1").ligerToolBar({
                    items: items
                });
                menu1 = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
                $("#stype").ligerComboBox({
                    width: 100,
                    isMultiSelect: true,
                    url: "../../data/param_sysparam.ashx?Action=combo&parentid=1&rnd=" + Math.random()
                })
                $('#sectype').ligerComboBox({
                    width: 80,
                    isMultiSelect: true,
                    selectBoxWidth: 100,
                    selectBoxHeight: 160,
                    valueField: 'id',
                    textField: 'text',
                    treeLeafOnly: true,
                    tree: {
                        data: [
                            { text: '' },
                            { text: '仅付定金' },
                            { text: '需要退款' },
                            { text: '应收未收' },
                            { text: '有效果图' },
                            { text: '无效果图' }


                        ],
                        checkbox: false
                    }
                });
                $('#thtype').ligerComboBox({
                    width: 80,
                    isMultiSelect: true,
                    selectBoxWidth: 120,
                    selectBoxHeight: 160,
                    valueField: 'id',
                    textField: 'text',
                    treeLeafOnly: true,
                    tree: {
                        data: [
                            { text: '' },
                            { text: '未签单' },
                            { text: '签单未施工' },
                            { text: '正在施工' },
                            { text: '施工完成' }


                        ],
                        checkbox: false
                    }
                });
                $("#sbq").ligerComboBox({
                    width: 100,
                    isMultiSelect: true,
                    url: "../../data/param_sysparam.ashx?Action=combo&parentid=18&rnd=" + Math.random()
                })

                $('#sectype1').ligerComboBox({
                    width: 180,
                    isMultiSelect: true,
                    selectBoxWidth: 200,
                    selectBoxHeight: 50,
                    valueField: 'id',
                    textField: 'text',
                    treeLeafOnly: true,
                    tree: {
                        data: [
                            { text: '跟进方式' },
                            { text: '跟进内容' }


                        ],
                        checkbox: false
                    }
                });
                 
                $("#maingrid5").ligerGetGridManager().onResize();

            });

        }
        function doserch() {
            var sendtxt = "Action=grid&IsApr=FK&rnd=" + Math.random();

            var stxt = $("#form1 :input").fieldSerialize();
            var serchtxt = sendtxt   + "&" + stxt;

            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Financial_Labour_Cost.ashx?" + serchtxt);


        }
      function f_reload() {
            var manager = $("#maingrid5").ligerGetGridManager();
            manager.loadData(true);
        };
 	function f_reload1() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        };
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
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        
      
        //应收
        function addys() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('CRM/finance/Financial_Labour_Cost_add_FK.aspx?fid=' + row.F_Num, "新增应收", 650, 400);
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        //收定金
        function addDj() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
             
            if (row) {
                f_openWindow("CRM/finance/Receive_add_Financial_Labour.aspx?fid=" + row.F_Num.replace(/\s+$|^\s+/g, "") +"&sklb=addDj", "收款", 800, 600); //sklb收款类别
            }
            else {
                $.ligerDialog.warn('请选择订单！');
            }
        }
        //退定金
        function minusDj() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/finance/Receive_add_Financial_Labour.aspx?fid=" + row.F_Num.replace(/\s+$|^\s+/g, "") + "&sklb=minusDj", "退款", 800, 600);
            }
            else {
                $.ligerDialog.warn('请选择订单！');
            }
        }
        //确认收款
        function confirm() {
            var manager = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
              
                if (row.IsStatus == "作废")
                {
                    $.ligerDialog.error('单据已经删除了，无法确认！');
                    return;
                }else
                f_save_cost(row.id, "1","");
            }
            else {
                $.ligerDialog.warn('请选择订单！');
            }
        }
        //删除收款
        function del() {
            var manager = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
 
            if (row) {
                if (row.IsStatus == "作废") {
                    $.ligerDialog.error('请勿重复作废！');
                    return;
                }else
                    f_save_cost(row.id, "7", customerIdSelected);
            }
            else {
                $.ligerDialog.warn('请选择订单！');
            }
        }
           //修改收款状态
        function f_save_cost(id, status,f_num) { 
            $.ligerDialog.confirm(" 您正在修改收款状态，\n您确定要操作？", function (yes) {
                if (yes) {
                $.ajax({
                    url: "../../data/Financial_Labour_Cost.ashx", type: "POST",
                    data: { Action: 'savecost', id: id, status: status,f_num:f_num, rnd: Math.random() }, /* 注意参数的格式和名称 */
                    success: function (responseText) {
                        if (responseText == "true") {
                            top.$.ligerDialog.closeWaitting();
                            f_reload();
                        } else {
                            top.$.ligerDialog.closeWaitting();
                            top.$.ligerDialog.error('修改失败！');
                        }
                       
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('操作失败！');
                    }
                });
                }
            })
         
        }


        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/Financial_Labour_Cost_Recive.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        f_reload();
			f_reload1();
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('操作失败！');
                    }
                });

            }
        }
        function view_fk(id, id1) {
            var type = 1;
            var width = 100, height = 50, title = '', url = '';
            switch (type) {
                case 1:
            width = 800, height = 600, title = "查看收款", url = 'CRM/finance/Receive_add_Financial_Labour.aspx?fid=' + id + "&receiveid=" + id1;
            break;
               case 2: width = 800, height = 680, title = "查看订单", url = "CRM/finance/Financial_Labour_Cost_add_FK.aspx?customerid=" + id + "&orderid=" + id1; break;
            }
            top.$.ligerDialog.open({
                width: width,
                height: height,
                title: title,
                url: url,
                buttons: [{ text: '关闭', onclick: function (item, dialog) { dialog.close(); } }]
            });
        }
   </script>

</head>
<body>

    <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar"></div>

        <div id="grid">
            
            <div id="maingrid4" style="margin: -1px; min-width: 800px;"></div>
                   <div id="toolbar1"></div>
            <div id="Div1" style="position: relative;">
                <div id="maingrid5" style="margin: -1px -1px;"></div>
            </div>
        </div>
              </div>
    </form>


</body>
</html>
