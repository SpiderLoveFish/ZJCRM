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
     <script src="../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
   

    <script type="text/javascript">
        var manager, g;
        var pushry = [];
        $(function () {
           
         g=   $("#maingrid4").ligerGrid({
                columns: [
                   {
                       display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                       { return (page - 1) * pagesize + rowindex + 1; }
                    },
                 { display: '供应商', name: 'SupplierName', width: 100, align: 'left' },
                     { display: '客户地址', name: 'address', width: 120, align: 'left' },
                   
                      { display: '材料名称', name: 'product_name', width: 100, align: 'left' },
                     { display: '材料型号', name: 'ProModel', width: 100, align: 'left' },
                        { display: '材料规格', name: 'specifications', width: 100, align: 'left' },
                         { display: '所属品牌', name: 'Brand', width: 100, align: 'left' },

                        { display: '单位', name: 'unit', width: 40, align: 'left' },
                        
//                        {
//                            display: '申请数量', name: 'sqsl', width: 60, align: 'right'
//                            , type: 'float'

//                        },
                         {
                             display: '申请数量', name: 'sqsl', width: 90, align: 'right', render: function(item) {
                             
                                 var html
                                 if (item.sqsl < 0) {
                                     html = "<font color='#CC0000'>" + item.sqsl + "</font>"
                                 }
                                 else
                                     html = item.sqsl

                                 return html;
                             }
                         },
                        //{
                        //    display: '采购数量', name: 'cgsl', width: 60, align: 'left'
                        //    , type: 'float' 

                        //},
                        {
                            display: '已领数量', name: 'llsl', width: 60, align: 'right'
                            , type: 'float' 

                        },
                    //{
                    //    display: '提交申请', width: 60, render: function (item) {
                    //        var html;
                    //        if (item.IsStatus == 0) {
                    //            html = "<a href='javascript:void(0)' onclick=Submit(" + item.id + ")>提交</a>"
 
                    //        }
                    //        else html = "<a href='javascript:void(0)' onclick=Revoke(" + item.id + ") ><font color='CC0000'>撤回</font></a>";
                           

                    //        return html;
                    //    }

                    //},
                    //{
                    //    display: '状态', width: 80, render: function (item) {
                    //        var html;
                    //        switch(item.IsStatus)
                    //        { 
                                
                    //            case '1':
                    //                html = "<font color='AA0000'>采购未完</font>";
                    //                break;
                    //            case '2':
                    //                html = "<font color='BB0000'>领料未完</font>";
                    //                break;
                    //            case '3':
                    //                html = "<font color='CC0000'>未处理</font>";
                    //                break;
                    //            case '4':
                    //                html = "<font color='DD0000'>采购已完</font>";
                    //                break;
                    //            case '5':
                    //                html = "<font color='EE0000'>领料已完</font>";
                    //                break;
                    //            case '7':
                    //                html = "<font color='FF0000'>已结案</font>";
                    //                break;
                    //            default:
                    //                html = "未知" + item.IsStatus;
                    //                break;
                    //        }
                         
                        //    return html;
                        //}

                    //},
                      { display: '类别', name: 'category_name', width: 80, align: 'left' },
                      { display: '材料编号', name: 'C_code', width: 80, align: 'left' },
                        { display: '添加人', name: 'name', width: 60, align: 'left' },
                        {
                            display: '添加时间', name: 'DoTime', width: 90, render: function (item) {
                                var DoTime = formatTimebytype(item.DoTime, 'yyyy-MM-dd');
                                return DoTime;
                            }
                        },
                   
                        { display: '备注', name: 'b1', width: 200, align: 'left' },

                        {
                            display: '辅助明细', width: 60, render: function (item) {
                                var html = "<a href='javascript:void(0)' onclick=viewfz(" + item.CustomerID + ","+item.id +","+item.sgjl+")>查看</a>"
                                return html;
                            }
                        },

                         {
                             display: '图文', width: 40, render: function (item) {
                                 var html = "<a href='javascript:void(0)' onclick=view(" + item.product_id + ")>查看</a>"
                                 return html;
                             }
                         }
              

                ],
               
                dataAction: 'server',
                pageSize: 100,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/PurchaseList.ashx?Action=RefMaterialsListgrid",
                width: '100%',
                height: '100%',
                enabledEdit: true,
                onBeforeEdit: f_onBeforeEdit,
                onBeforeSubmitEdit: f_onBeforeSubmitEdit,
                onAfterEdit: f_onAfterEdit,
                heightDiff: -1,
                showToggle: true,
                checkbox: true, name: "ischecked", isChecked: f_isChecked, onCheckRow: f_onCheckRow, onCheckAllRow: f_onCheckAllRow,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }

            });
            //$("#maingrid4 .l-grid-hd-cell-btn-checkbox").show();
            initLayout();
            $(window).resize(function () {
                initLayout();
            });

            toolbar();
        });


        //只允许编辑前3行
        function f_onBeforeEdit(e) {
            //if (e.rowindex <= 2) return true;
            //return false;
            return true;
        }
        //限制
        function f_onBeforeSubmitEdit(e) {
            if (e.column.name == "AmountSum") {
                if (e.value < 0) {
                    alert("数量不能为负数！");
                    return false;
                }
            }
            return true;
        }
        //编辑后事件 
        function f_onAfterEdit(e) {
            if (e.column.name == "AmountSum") {
                var manager = $("#maingrid4").ligerGetGridManager();
                var row = manager.getSelectedRow();
               
                if (row) {
                    $.ajax({
                        url: "../../data/PurchaseList.ashx", type: "POST",
                        data: { Action: "save", cid: getparastr("cid"), id: row.id, editsum: e.value, rnd: Math.random() },
                        success: function (responseText) {
                            if (responseText == "true") {
                                top.$.ligerDialog.closeWaitting();
                                f_load();
                            }

                        },
                        error: function () {
                            top.$.ligerDialog.closeWaitting();
                            top.$.ligerDialog.error('修改失败！', "", null, 9003);
                        }
                    });
                }
                else {
                    $.ligerDialog.warn("请选择一有效行！");
                }
            }
        }

            function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=199&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                items.push({ type: 'textbox', id: 'stext', text: '条件一：' });
                items.push({ type: 'textbox', id: 'stextb', text: '条件二：' });
                items.push({ type: 'textbox', id: 'stextc', text: '条件三：' });
              //  items.push({ type: 'textbox', id: 'bgtxt', text: '开始时间：' });
                //items.push({ type: 'textbox', id: 'endtxt', text: '结束时间：' });
               // items.push({ type: 'textbox', id: 'sectype', text: '筛选状态：' });
                items.push({ type: 'button', text: '搜索', icon: '../../images/search.gif', disable: true, click: function () { doserch() } });
                $("#toolbar").ligerToolBar({
                    items: items

                });
            
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
                //$('#sectype').ligerComboBox({
                //    width: 120,
                //    //isMultiSelect: true,
                //    selectBoxWidth: 120,
                //    selectBoxHeight: 120,
                //    valueField: 'id',
                //    textField: 'text',
                //    treeLeafOnly: true,
                //    tree: {
                //        data: [
                //   { id: 99, text: '全部' },
                //   { id: 1, text: '采购未完' },
                //   { id: 2, text: '领料未完' },
                //   { id: 3, text: '未处理' },
                //   { id: 4, text: '采购已完' },
                //   { id: 5, text: '领料已完' },
                //    { id: 7, text: '已结案' }

                //        ],
                //        checkbox: false
                //    }
                //});
                $("#stext").ligerTextBox({ width: 150 });
                $("#stextb").ligerTextBox({ width: 150 });
                $("#stextc").ligerTextBox({ width: 150 });
                $("#bgtxt").ligerTextBox({ width: 100,ltype:'date',  nullText: "" })
                $("#endtxt").ligerTextBox({ width: 100,ltype:'date', nullText: "" })
                $("#maingrid4").ligerGetGridManager().onResize();
            });
        }

            function key()
            {
                if (event.keyCode == 13)  //回车键的键值为13
                    doserch(); //调用查询函数的事件
            }
            function doserch() {
            
                var sendtxt = "&Action=RefMaterialsListgrid&rnd=" + Math.random();
                var stxt = $("#form1 :input").fieldSerialize();
                var serchtxt = $("#serchform :input").fieldSerialize() + "&" + stxt + sendtxt;
                var manager = $("#maingrid4").ligerGetGridManager();
                manager.GetDataByURL("../../data/PurchaseList.ashx?" + serchtxt);
            }
        
        //提交
        function Submit(id)
        {
          
            $.ajax({
                type: 'post',
                url: "../../data/PurchaseList.ashx?Action=updatestatus&id=" + id + "&isstatus=1&rdm=" + Math.random(),
                success: function (data) {
                    if (data == "false")
                        f_error("保存失败！");

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    f_error("保存失败！");
                }
            });
            // f_success();
            f_load();
        }
        //撤回
        function Revoke(id)
        {
            $.ajax({
                type: 'post',
                url: "../../data/PurchaseList.ashx?Action=updatestatus&id=" + id + "&isstatus=0&rdm=" + Math.random(),
                success: function (data) {
                    if (data == "false")
                    f_error("保存失败！");

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    f_error("保存失败！");
                }
            });
            // f_success();
            f_load();
        }

        function del()
        {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("删除不能恢复，确定删除？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/PurchaseList.ashx", type: "POST",
                            data: { Action: "del", id: row.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    f_load();
                                }

                                else if (responseText == "false:order") {
                                    top.$.ligerDialog.closeWaitting();
                                    top.$.ligerDialog.error('状态已经改变，无法删除！');
                                }
                            },
                            error: function () {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('删除失败！', "", null, 9003);
                            }
                        });
                    }
                })
            } else {
                $.ligerDialog.warn("请选择类别！");
            }
        }

        function f_error(message) {
            $(document).ready(function () {
                $.ligerDialog.error(message);
            });
        }
        function f_saving() {
            $.ligerDialog.waitting("正在保存中...");
        }
        //生成采购单
        function addcgd()
        {
          //  alert(1)
            var rowid = checkedID.join(',');
            var customer = checkedCustomerID.join(',');
            
            var customerid = ""; var customer = "";
           alert(checkedID)
            //for (var k = 0; k < checkedCustomerID.length; k++)
            //{
            //    if (k == 0)
            //    { customerid = checkedCustomerID[k]; }
            //    else {
            //        if (customerid != checkedCustomerID[k])
            //            f_error("所选材料必须为同一客户！"); return;
            //    }
               

            //}
            var data = g.getData();
            //for (var d = 0; d < data.length; d++)
            //{
            //    if (data[d]["CustomerID"] == customerid) {
                   
            //        customer = data[d]["address"]; break;

            //    }
            //}
           
        if (rowid.length > 0)
         //  alert(rowid);
            f_openWindow('crm/purchase/SavePickList.aspx?rowid=' + rowid + '&cid=0&cname=' + encodeURI("批量生成"),
                //' + customerid + '& cname=' + encodeURI(customer), 
                "生成采购单", 600, 350);
            }
        //结案
        function close() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row.length == 1) {
                $.ajax({
                    type: 'post',
                    url: "../../data/PurchaseList.ashx?Action=updatestatus&id=" + row.id + "&isstatus=7&rdm=" + Math.random(),
                    success: function (data) {
                        if (data == "false")
                            f_error("保存失败！");

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        f_error("保存失败！");
                    }
                });
                // f_success();
                f_load();
            } else
                $.ligerDialog.warn('请选择产品！');
        } 
         
       
        function f_load() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
  
        }
        function f_success() {
            //setTimeout(function () {
            //    $.ligerDialog.confirm("是否继续编辑", "保存成功", function (ok) {
            //        if (!ok) {
            //            parent.$.ligerDialog.close();
            //        }
            //    });
            //}, 200);
        }
        //关闭刷新
        function f_close(item, dialog)
        {
            f_load();
            dialog.close();
        }


        function f_savePurList()
        {

        }

        //保存信息
        function f_save(item, dialog)
        {
            var issave = dialog.frame.f_save();
          
            if (issave) {
                $.ajax({
                    type: 'post',
                    url: "../../data/Purchase.ashx?Action=savetemp&" + issave,
                    success: function (data) {
                        if (data == 'false') {
                            dialog.frame.getmaxid();
                            $.ligerDialog.error("保存错误！！！重新保存！");
                        }
                        else {

                            savedetail(dialog, issave);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        top.$.ligerDialog.error("保存错误！！！");
                    }
                });
               
                 
            }
        }

        function savedetail(dialog, issave) {
       
            //var pidlist = "," + pidlist;
            var url = '../../data/Purchase.ashx?Action=savedetail&isauto=Y&'+issave;
            $.ajax({
                type: 'post',
                url: url,
                success: function (data) {
                    dialog.frame.alertcgd();
                    dialog.close();
                   
                    f_reload();//刷新上半部分
                   // top.$.ligerDialog.waitting('数据保存中,请稍候...');
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    top.$.ligerDialog.error("保存错误！！！");
                }
            });


        }

         
        var activeDialogs = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                zindex: 9002,
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '保存', onclick: function (item, dialog) {
                                f_save(item, dialog);
                            }
                        },
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                f_close(item, dialog);
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialogs = parent.jQuery.ligerDialog.open(dialogOptions);
        }


        function view(id) {
            var dialogOptions = {
                width: 1000, height: 650, title: "材料档案图文介绍", url: '../view/product_view.aspx?id=' + id + '&rnd=' + Math.random(), buttons: [
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
                function viewfz(cid,id,sgjl) {
            var dialogOptions = {
                width: 800, height: 510, title: "辅助信息", url: "../../CRM/ConsExam/PurProductList_edit.aspx?cid=" + cid + "&id=" + id + "&sgjl=" + sgjl+ "&rnd=" + Math.random(), buttons: [
                    {
                        text: '关闭', onclick: function (item, dialog) {
                            dialog.close();
                        }
                    }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        /*
        表单分页多选
        即利用onCheckRow将选中的行记忆下来，并利用isChecked将记忆下来的行初始化选中
        */
        var checkedID = []; var checkedCustomerID = [];
        function f_onCheckAllRow(checked) {
            var manager = $("#maingrid4").ligerGetGridManager();
            var data = manager.records;
              //  alert(JSON.stringify(data));
            for (var rowid in data) {
                if (checked)
                    addcheckedID(data[rowid]['id'], data[rowid]['CustomerID']);
                else
                    removecheckedID(data[rowid]['id'], data[rowid]['CustomerID']);
            }
        }
        function findcheckedID(id) {
            for (var i = 0; i < checkedID.length; i++) {
                if (checkedID[i] == id) return i;
            }
            
            return -1;
        }
        function findcheckedCustomerID(customreid) {
       
            for (var i = 0; i < checkedCustomerID.length; i++) {
                if (checkedCustomerID[i] == customreid) return i;
            }
            return -1;
        }
        function addcheckedID(id, customerid) {
            if (findcheckedID(id) == -1)
                checkedID.push(id);
            if (findcheckedCustomerID(customerid) == -1)
                checkedCustomerID.push(customerid);
        }
        function removecheckedID(id,customerid) {
            var i = findcheckedID(id);
            if (i == -1) return;
            checkedID.splice(i, 1);
            var ii = findcheckedCustomerID(customerid);
            if (ii == -1) return;
            checkedCustomerID.splice(ii, 1);
        }
        function f_isChecked(rowdata) {
            if (findcheckedID(rowdata.id) == -1)
                return false;
            return true;
        }
        function f_onCheckRow(checked, data) {
            if (checked) addcheckedID(data.id, data.CustomerID);
            else removecheckedID(data.id, data.CustomerID);
        }
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
            checkedID = [];
            //alert(1)
        };

    </script>

    
</head>
<body style="padding: 0px; overflow: hidden;" onkeydown="key()">
   
      <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar"> 
               
            </div>
              <div id="grid">
            <div id="maingrid4" style="margin: -1px;"></div>
                  </div>
        </div>
    </form>
</body>
</html>
