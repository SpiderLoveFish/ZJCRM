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
    <link href="../../CSS/styles.css" rel="Stylesheet" type="text/css" />
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
        <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script type="text/javascript">
        var manager = ""; var Apr = "E";
        if (getparastr("Apr") == "Y") Apr = "Y";
        else if (getparastr("Apr") == "YY") Apr = "YY";
        else if (getparastr("Apr") == "YYY") Apr = "YYY";
        else if (getparastr("Apr") == "Print") Apr = "";
        $(function () {
            $("#maingrid4").ligerGrid({
                columns: [
                     {
                         display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                         { return (page - 1) * pagesize + rowindex + 1; }
                     },
                      { display: '调拨单号', name: 'Purid', width: 150, align: 'left' },
                    { display: '调入工地', name: 'supplier_name', width: 200, align: 'left' },
                          {
                          display: '调出工地', name: 'nr', align: 'left', width: 200, render: function (item) {
                              var html = "<div class='abc'>";
                              if (item.nr)
                                  html += item.nr;
                              html += "</div>";
                              return html;
                          }
                      },
                     // { display: '客户信息', name: 'nr', width: 400, align: 'left' },
                       { display: '施工监理', name: 'sg', width: 120, align: 'left' },
                       // { display: '客户电话', name: 'tel', width: 80, align: 'left' },

                    // { display: '已付金额', name: 'paid_amount', width: 80, align: 'left' },
                      // { display: '应付金额', name: 'payable_amount', width: 100, align: 'left' },
                        //{ display: '欠款', name: 'arrears', width: 80, align: 'left' },
                     {
                         display: '状态', name: 'isNode', width: 60, align: 'left'
                        , render: function (item) {
                             var st;
                             if (item.isNode == "0") st = "待提交";
                             //else if (item.isNode == "1") st = "待审核";
                             else if (item.isNode == "2") st = "待确认";
                             else if (item.isNode == "3") st = "待回单";
                             //else if (item.isNode == "4") st = "已回单";
                             else if (item.isNode == "99") st = "已废除";
                             else st = item.isNode;
                             if (item.isNode == "1") {
                                 st = "<div style='color:#FF0000'>";
                                 st += "待审核";
                                 st += "</div>";
                             }
                             if (item.isNode == "4") {
                                 st = "<div style='color:#00CD66'>";
                                 st += "已回单";
                                 st += "</div>";
                             }
                             return st;
                         }
                     },
                     
                        { display: '材料员', name: 'materialman', width: 80, align: 'left' },
                        {
                            display: '调拨日期', name: 'purdate', width: 100, align: 'left', render: function (item) {
                                return formatTimebytype(item.purdate, 'yyyy-MM-dd');
                            }
                        },
                      //  { display: '关联单号', name: 'correlation_id', width: 80, align: 'left' },
                            { display: '备注', name: 'remarks', width: 200, align: 'left' }

                ],
                                  onAfterShowData: function (grid) {
                    $(".abc").hover(function (e) {
                        $(this).ligerTip({ content: $(this).text(), width: 300, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                    }, function (e) {
                        $(this).ligerHideTip(e);
                    });
                },
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/Purchase.ashx?Action=griddb&Apr="+Apr,
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
            toolbar();
        });
        function toolbar() {

            var url = "../../data/toolbar.ashx?Action=GetSys&mid=159&rnd=" + Math.random();
            if (getparastr("Apr") == "Y") url = "../../data/toolbar.ashx?Action=GetSys&mid=161&rnd=" + Math.random();
            if (getparastr("Apr") == "YY") url = "../../data/toolbar.ashx?Action=GetSys&mid=162&rnd=" + Math.random();
            if (getparastr("Apr") == "YYY") url = "../../data/toolbar.ashx?Action=GetSys&mid=162&rnd=" + Math.random();

            if (getparastr("Apr") == "Print") url = "../../data/toolbar.ashx?Action=GetSys&mid=167&rnd=" + Math.random();
            $.getJSON(url, function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                items.push({
                    type: 'serchbtn',
                    text: '高级搜索',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        serchpanel();
                    }
                });
                $("#toolbar").ligerToolBar({
                    items: items

                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });

                $("#maingrid4").ligerGetGridManager().onResize();
            });
        }

        function serchpanel() {
            initSerchForm();
            if ($(".az").css("display") == "none") {
                $("#grid").css("margin-top", $(".az").height() + "px");
                $("#maingrid4").ligerGetGridManager().onResize();

            }
            else {
                $("#grid").css("margin-top", "0px");
                $("#maingrid4").ligerGetGridManager().onResize();

            }

        }
        function initSerchForm() {
            $("#khstext").addClass("l-text");
            $("#dzstext").addClass("l-text");
            $("#dhstext").addClass("l-text");
            $("#sgjlstext").addClass("l-text");
          
            $("#gystext").addClass("l-text");
 

        }

        //查询
        function doserch() {
            var sendtxt = "&Action=griddb&Apr="+Apr+"&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
            //  alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Purchase.ashx?" + serchtxt);
        }
        function doclear() {
            //var serchtxt = $("#serchform :input").reset();
            $("#serchform").each(function () {
                this.reset();
                $(".l-selected").removeClass("l-selected");
            });
        }

        var activeDialogs = null;
        function f_openWindowview(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [

                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialogs = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        //撤回
        var activeDialogsch = null;
        function f_openWindow_ch(url, title, width, height,code) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: code, onclick: function (item, dialog) {
                            f_saveret(item, dialog);
                        }
                    },
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialogsch = parent.jQuery.ligerDialog.open(dialogOptions);
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
                             text: '保存&提交', onclick: function (item, dialog) {
                                 f_submit(item, dialog);
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
     
        var activeDialogssh = null;
        function f_openWindow_sh(url, title, width, height, code) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: code, onclick: function (item, dialog) {
                            f_saveret(item, dialog);
                        }
                    },
                    {
                        text: '撤回', onclick: function (item, dialog) {
                            f_saveretrn(item, dialog);
                        }
                    },
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialogssh = parent.jQuery.ligerDialog.open(dialogOptions);
        }

      function add() {
          f_openWindow("crm/purchase/PurchaseMainAdd_DB.aspx?status=0", "新增调拨", 1100, 600);
        }

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
               // alert(row.isNode);
                if (row.isNode == 0)
                    f_openWindow("crm/purchase/PurchaseMainAdd_DB.aspx?pid=" + row.Purid + "&isauto=" + row.customid+"&status=" + row.isNode, "审核调拨单", 1200, 600);
                else if (row.isNode == 1)//已经提交
                {
                    if (getparastr("Apr") == 'Y')
                        f_openWindow_sh("crm/purchase/PurchaseMainAdd_DB.aspx?pid=" + row.Purid + "&status=" + row.isNode + "&style=apr", "审核调拨单", 1200, 600, '审核');
                  else 
                        f_openWindow_ch("crm/purchase/PurchaseMainAdd_DB.aspx?pid=" + row.Purid + "&status=" + row.isNode + "&style=ret", "审核调拨单", 1200, 600, '撤回');
                
                }
                else if (row.isNode == 2)//已经提交
                {

                    if (getparastr("Apr") == 'YY')
                        f_openWindow_sh("crm/purchase/PurchaseMainAdd_DB.aspx?pid=" + row.Purid + "&status=" + row.isNode + "&style=apry", "审核调拨单", 1200, 600, '确认');
                    else
                        f_openWindow_ch("crm/purchase/PurchaseMainAdd_DB.aspx?pid=" + row.Purid + "&status=" + row.isNode + "&style=ret", "审核调拨单", 1200, 600, '撤回');

                  

                } else if (row.isNode == 3)//待回单
                    if (getparastr("Apr") == 'YYY')
                        f_openWindow_sh("crm/purchase/PurchaseMainAdd_DB.aspx?pid=" + row.Purid + "&status=" + row.isNode + "&style=apryy", "回单调拨单", 1200, 600, '确认');
                    else
                        f_openWindow_ch("crm/purchase/PurchaseMainAdd_DB.aspx?pid=" + row.Purid + "&status=" + row.isNode + "&style=ret", "回单调拨单", 1200, 600, '撤回');

                  //  f_openWindow_ch("crm/purchase/PurchaseMainAdd_DB_CK.aspx?pid=" + row.Purid + "&status=" + row.isNode + "&style=apry", "审核调拨单", 1100, 600, '确认');

            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        //打印
        function print() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            
            if (row) {
                if (row.isNode == 3 || row.isNode == 2 || row.isNode == 4)//已经审核或者待审核
                {
                    f_openWindowview("crm/Print/PurchasePrint.aspx?pid=" + row.Purid, "打印", 1100, 600);

                } else {
                    $.ligerDialog.warn('已审核或者待审核的调拨单才能打印！');
                }
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }

        //查看
        function view() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();

            if (row) {
                
                f_openWindowview("crm/purchase/PurchaseMainAdd_DB.aspx?pid=" + row.Purid + "&isauto=" + row.customid + "&status=" + row.isNode, "查看调拨单", 1100, 600);

                
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }

        //绝对退回
        function f_saveretrn(item, dialog) {

            var issave = dialog.frame.f_saveretrn();

            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/Purchase.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        if (responseText == "false") {
                            top.$.ligerDialog.error('操作失败！');
                        }
                        else {
                            //  alert(issave); 
                            f_reload();
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();

                    }
                });

            }
        }

        function f_saveret(item, dialog)
        {

            var issave = dialog.frame.f_saveapr();

            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/Purchase.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        if (responseText == "false") {
                            top.$.ligerDialog.error('操作失败！');
                        }
                        else {
                            //  alert(issave); 
                            f_reload();
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();

                    }
                });

            }
        }
        function ret() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("确定退回吗？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/Purchase.ashx", type: "POST",
                            data: { Action: "saveupdatestatus", status: 0, pid: row.Purid, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    f_reload();
                                }

                                else {
                                    top.$.ligerDialog.closeWaitting();
                                    top.$.ligerDialog.error('退回失败！');
                                }
                            },
                            error: function () {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('退回失败！', "", null, 9003);
                            }
                        });
                    }
                })
            } else {
                $.ligerDialog.warn("请选择类别！");
            }
        }
        
        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("删除不能恢复，确定删除？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/Purchase.ashx", type: "POST",
                            data: { Action: "del", pid: row.Purid, rnd: Math.random() },
                            success: function (responseText) {
                               // if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    f_reload();
                                //}

                                //else {
                                //    top.$.ligerDialog.closeWaitting();
                                //    top.$.ligerDialog.error('删除失败！');
                                //    f_reload();
                                //}
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

        function f_save(item, dialog) {

            var issave = dialog.frame.f_save();
         
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/Purchase.ashx", type: "POST",
                    data: issave + "&status=0",
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        if (responseText == "false") {
                            top.$.ligerDialog.error('操作失败！');
                        }
                        else {
                          //  alert(issave); 
                            f_reload();
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();

                    }
                });

            }
        }
        function f_submit(item, dialog) {

            var issave = dialog.frame.f_save();

            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/Purchase.ashx", type: "POST",
                    data: issave + "&status=1",
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        if (responseText == "false") {
                            top.$.ligerDialog.error('操作失败！');
                        }
                        else {
                            //  alert(issave); 
                            f_reload();
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();

                    }
                });

            }
        } 

        function f_reload() {
            doserch();
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        };
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
      <div class="az">
        <form id='serchform'>
            <table style='width: 960px' class="bodytable1">
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>客户信息：</div>
                    </td>
                    <td>

                        <input  ltype='text' ligerui='{width:120}' type='text' id='khstext' name='khstext'  /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>施工监理：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='dzstext' name='dzstext' ltype='text' ligerui='{width:120}'  />
                        </div>
                    
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>调拨单号：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='dhstext' name='dhstext'   ltype='text' ligerui='{width:120}'  />
                        </div>
                       
                    </td>
                    <td>
                          <input id='Button1' type='button' value='搜索' style='width: 80px; height: 24px' onclick="doserch()" />
                  
                        <input id='Button2' type='button' value='重置' style='width: 80px; height: 24px'
                            onclick="doclear()" />
                        </td> 
                </tr>
                <tr>
                              <td>
                        <div style='width: 60px; text-align: right; float: right'>供应商：</div>
                    </td>
                    <td>
                        <input id='gystext' name="gystext" type='text'  ltype='text' ligerui='{width:120}' /></td>


                </tr>
            
            </table>
        </form>
    </div>


</body>
</html>
