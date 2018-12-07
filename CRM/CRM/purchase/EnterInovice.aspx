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
            var customerIdSelected;
            initLayout();
            $(window).resize(function () {
                initLayout();
            });

            $("#maingrid4").ligerGrid({
                columns: [
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                      
                    {
                        display: '客户', name: 'Customer', width: 80, align: 'left', render: function (item) {
                            var html = "<a href='javascript:void(0)' onclick=view(1," + item.Customer_id + ")>";
                            if (item.Customer)
                                html += item.Customer;
                            html += "</a>";
                            return html;
                        }
                    },
                      { display: '地址', name: 'address', width: 150 },

                    { display: '金额类型', name: 'Pay_type', width: 70 },
                   
                    { display: '类型', name: 'receive_direction_name', width: 70 },
                    
                     
                    {
                        display: '余额（￥）', name: 'Receive_amount', width: 100, align: 'right', render: function (item) {
                            return "<div style='color:#135294'>" + toMoney(item.Receive_amount) + "</div>";
                        }
                    },
                    
                      {
                          display: '收款日期', name: 'Receive_date', width: 90, render: function (item) {
                              return formatTimebytype(item.Receive_date, 'yyyy-MM-dd');
                          }
                         
                      },
                        { display: '收款人', name: 'C_empname', width: 70 },
                   

                       
                {
                          display: '查看', width: 60, render: function (item) {
                              var html = "";
                              if (item.receive_direction_name == "收定金" || item.receive_direction_name == "退定金" || item.receive_direction_name == "收装修款" || item.receive_direction_name == "退装修款") {
                                  html = "<a href='javascript:void(0)' onclick=view(66," + item.Customer_id + "," + item.id + ")>查看</a>";
                              }
                              else if (item.receive_direction_name == "定金" || item.receive_direction_name == "签单") {
                                  html = "<a href='javascript:void(0)' onclick=view(44," + item.Customer_id + "," + item.id + ")>查看</a>";
                              }
                              return html;
                          }
                      }

                ],
                 
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/CRM_receive.ashx?Action=grid_enter&rnd=" + Math.random(),
                width: '100%', height: '100%',
                heightDiff: -1,
                onRClickToSelect: true

                 
            });
            $('form').ligerForm();
            initSerchForm();

        });

        $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=216&rnd=" + Math.random(), function (data, textStatus) {
            //alert(data);
            var items = [];
            var arr = data.Items;
               for (var i = 0; i < arr.length; i++) {
                arr[i].icon = "../../" + arr[i].icon;
                items.push(arr[i]);

            }
               items.push(
                   {
                       type: 'serchbtn',
                       text: '高级搜索',
                       icon: '../../images/search.gif',
                       disable: true,
                       click: function () {
                           serchpanel()
                       }
                   });
            $("#toolbar1").ligerToolBar({
                items: items
            });
            menu1 = $.ligerMenu({
                width: 120, items: getMenuItems(data)
            });

            $("#maingrid4").ligerGetGridManager().onResize();
           
        });

         $(document).keydown(function (e) {
            if (e.keyCode == 13 && e.target.applyligerui) {
                doserch();
            }
        });
        function doserch() {
            var sendtxt = "&Action=grid_enter&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
            //alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/CRM_receive.ashx?" + serchtxt);
        }
        function doclear() {
            //var serchtxt = $("#serchform :input").reset();
            $("#serchform").each(function () {
                this.reset();
                $(".l-selected").removeClass("l-selected");
            });
        } function initSerchForm() {
            var d = $('#pay_type').ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=5&rnd=" + Math.random() });
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
            if ($(".az").css("display") == "none") {
                $("#grid").css("margin-top", $(".az").height() + "px");
                $("#maingrid4").ligerGetGridManager().onResize();
            }
            else {
                $("#grid").css("margin-top", "0px");
                $("#maingrid4").ligerGetGridManager().onResize();
            }
        }
    
        function add() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("确定收款吗？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/CRM_receive.ashx", type: "POST",
                            data: { Action: "updateisdelete", id: row.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    f_reload();
                                    
                                }
                                

                            },
                            error: function () {
                                top.$.ligerDialog.error('失败！');
                            }
                        });
                    }
                })
            }
             
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
               
                f_openWindow("CRM/finance/receive_add_khjdgl.aspx?sklbs=" + row.receive_direction_id+"&type=View&customerid=" + row.Customer_id+"&receiveid="+row.id, "上传资料", 800, 580);

            }

            else {
                $.ligerDialog.warn('请选择行！');
            }   
        }

        function del() {
           
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("确定作废此收款吗？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/CRM_receive.ashx", type: "POST",
                            data: { Action: "updateisdelete_del", id: row.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    f_reload();

                                }


                            },
                            error: function () {
                                top.$.ligerDialog.error('失败！');
                            }
                        });
                    }
                })
            }

            else {
                $.ligerDialog.warn('请选择行！');
            }
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
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();

            if (issave) {
                dialog.close();

                $.ajax({
                    url: "../../data/CRM_Customer.ashx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('数据保存中,请稍候...');
                    },
                    success: function (responseText) {

                        f_reload();
                        
                    },
                    error: function () {
                        top.$.ligerDialog.error('操作失败！');
                    },
                    complete: function () {
                        top.$.ligerDialog.closeWaitting();
                    }
                });

            }
        }

         function f_reload() {
            $("#maingrid4").ligerGetGridManager().loadData(true);
           
        };

    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">
        <div id="toolbar"></div>
          <div id="toolbar1"></div>

        <div id="grid">
            <div id="maingrid4" style="margin: -1px; min-width: 800px;"></div>
            <div id="toolbar1"></div>
            <div id="maingrid5" style="margin: -1px -1px;"></div>
        </div>


    </form>
      <div class="az">
        <form id='serchform'>
            <table style='width: 920px' class="bodytable1">
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>客户姓名：</div>
                    </td>
                    <td>
                        <input type='text' id='company' name='company' ltype='text' ligerui='{width:120}' />
                    </td>
                    <td>
                         <div style='width: 60px; text-align: right; float: right'>收款人：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='department' name='department' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='employee' name='employee' />
                        </div>
                    </td>
                    
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>收款时间：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='startdate' name='startdate' ltype='date' ligerui='{width:97}' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='enddate' name='enddate' ltype='date' ligerui='{width:96}' />
                        </div>
                    </td>
                    <td>
                        
                    </td>
                    <td>
                                             
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>凭证收据：</div>
                    </td>
                    <td>
                        <input type='text' id='receive_num' name='receive_num' ltype='text' ligerui='{width:120}' />
                      </td>  
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>收款方式：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='pay_type' name='pay_type' />
                        </div>   
                    </td>
                    <td>
                       
                        
                    </td>
                    <td>
                         <input id='Button2' type='button' value='重置' style='width: 80px; height: 24px'
                            onclick="doclear()" />
                        <input id='Button1' type='button' value='搜索' style='width: 80px; height: 24px' onclick="doserch()" />
                    </td>
                </tr>
               
            </table>
        </form>
    </div>
  </body>
</html>
