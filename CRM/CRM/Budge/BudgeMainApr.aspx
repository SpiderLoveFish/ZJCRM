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
        var manager = ""; var aprstyle = "apr";
        $(function () {
          
          
            var urlstr = "../../data/Budge.ashx?Action=grid&str_condition=1";
            if (getparastr("isprint") == "Y")//整体查询
                urlstr = "../../data/Budge.ashx?Action=grid&isprint=Y"
            else if (getparastr("CustOK") == "Y")
            {
                aprstyle = "aprCustOK";//审核时候用到
                urlstr = "../../data/Budge.ashx?Action=grid&str_condition=2";
            }
            else if (getparastr("isprint") == "V") {
                aprstyle = "aprCustOK";//客户查询
                urlstr = "../../data/Budge.ashx?Action=grid&str_condition=3&isprint=V";
            }
            $("#maingrid4").ligerGrid({
                columns: [
                   {
                       display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                       { return (page - 1) * pagesize + rowindex + 1; }
                   },
                      { display: '预算编号', name: 'id', width: 100, align: 'left' },
                          { display: '预算名称', name: 'BudgetName', width: 120, align: 'left' },
                      { display: '姓名', name: 'CustomerName', width: 60, align: 'left' },


                      {
                          display: '电话', name: 'tel', align: 'left', width: 40, render: function (item) {
                              var html = "<div class='abc'>";
                              if (item.tel)
                                  html += item.tel;
                              html += "</div>";
                              return html;
                          }

                      },
                        { display: '客户地址', name: 'address', width: 200, align: 'left' },
                   { display: '金额', name: 'BudgetAmount', width: 60, align: 'left' },

                      {
                          display: '状态', name: 'txtstatus', width: 60, align: 'left', render: function (item) {

                              var html;
                              if (item.txtstatus == "待审核") {
                                  html = "<div style='color:#FF0000'>";
                                  html += item.txtstatus;
                                  html += "</div>";
                              }
                              else if (item.txtstatus == "待确认") {
                                  html = "<div style='color:#CC0099'>";
                                  html += item.txtstatus;
                                  html += "</div>";
                              }
                              else {
                                  html = item.txtstatus;
                              }
                              return html;
                          }
                      },
                        { display: '创建人', name: 'name', width: 80, align: 'left' },
                        {
                            display: '创建日期', name: 'DoTime', width: 100, align: 'left', render: function (item) {
                                return formatTimebytype(item.DoTime, 'yyyy-MM-dd');
                            }
                        },
                        { display: '设计师', name: 'sjs', width: 80, align: 'left' },
                { display: '备注', name: 'Remarks', width: 100, align: 'left' },
                { display: '类型', name: 'ModelStyle', width: 80, align: 'left' }
                ],
                onAfterShowData: function (grid) {
                    $(".abc").hover(function (e) {
                        $(this).ligerTip({ content: $(this).text(), width: 200, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                    }, function (e) {
                        $(this).ligerHideTip(e);
                    });

                },
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: urlstr,//增加选择条件 0 编辑 1 审核
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
            var urlstr = "../../data/toolbar.ashx?Action=GetSys&mid=157&rnd=" + Math.random();
            if (getparastr("isprint") == "Y")
                urlstr = "../../data/toolbar.ashx?Action=GetSys&mid=158&rnd=" + Math.random();
            else if (getparastr("CustOK") == "Y")
                urlstr = "../../data/toolbar.ashx?Action=GetSys&mid=184&rnd=" + Math.random();
            else if (getparastr("isprint") == "V") {
                urlstr = "../../data/toolbar.ashx?Action=GetSys&mid=158&rnd=" + Math.random();
            }
            $.getJSON(urlstr, function (data, textStatus) {
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
                    text: ''
                });
                items.push({ type: 'textbox', id: 'stextlx', text: '类型：' });
                items.push({
                    type: 'button',
                    text: '搜索',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        doserch()
                    }
                });
      
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
                $("#keyword1").ligerTextBox({ width: 200, nullText: "输入关键词搜索" });
                $('#stextlx').ligerComboBox({
                    width: 97,
                    selectBoxWidth: 240,
                    selectBoxHeight: 200,
                    valueField: 'id',
                    textField: 'text',
                    treeLeafOnly: false,
                    tree: {
                        data: [
                   { text: '常规' },
                   { text: '套餐' }
                        ],
                        checkbox: false
                    }
                });
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
         
            $("#T_sjs").addClass("l-text");
            $("#T_ysbh").addClass("l-text");
            $('#t_zt').ligerComboBox({
                width: 100,
                selectBoxWidth: 100,
                selectBoxHeight: 100,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    data: [{ id: '', text: '全部' }, { id: '0', text: '待提交' }, { id: '1', text: '待审核' }, { id: '2', text: '已生效' }, { id: '99', text: '已删除' }],
                    checkbox: false
                }
            });
        }

        //查询
        function doserch() {
          

            var urlstr = "../../data/Budge.ashx?str_condition=1";
            if (getparastr("isprint") == "Y")//整体查询
                urlstr = "../../data/Budge.ashx?isprint=Y"
            else if (getparastr("CustOK") == "Y")//审核时候用到
                urlstr = "../../data/Budge.ashx?str_condition=2";
            else if (getparastr("isprint") == "V")//客户查询
                urlstr = "../../data/Budge.ashx?str_condition=2&isprint=V";
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
            var sertxt = $("#form1 :input").fieldSerialize() + "&" + serchtxt;
            var manager = $("#maingrid4").ligerGetGridManager();
            alert(urlstr + "&" + sertxt);
            manager.GetDataByURL(urlstr + "&" + sertxt);
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
        var activeDialog = null;
        function f_openWindow(url, title, width, height, buttontxt) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: buttontxt, onclick: function (item, dialog) {
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

        var activeDialogssh = null;
        function f_openWindow_sh(url, title, width, height, code) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: code, onclick: function (item, dialog) {
                            f_save(item, dialog);
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

     //审核
        function apr() {
    
          var manager = $("#maingrid4").ligerGetGridManager();
          var row = manager.getSelectedRow();
          if (row) {
              f_openWindow_sh("crm/Budge/BudgeMainAdd.aspx?bid=" + row.id + "&style=" + aprstyle, "审核预算", 1100, 600, "审核");
          } else {
              $.ligerDialog.warn('请选择行！');
          }
        }
        //作废
      function cancel() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("crm/Budge/BudgeMainAdd.aspx?bid=" + row.id + "&style=cancel", "作废预算", 1100, 600,"作废");
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        //打印
      function print() {
          var manager = $("#maingrid4").ligerGetGridManager();
          var row = manager.getSelectedRow();
          if (row) {
              f_openWindowview("crm/Print/BudgePrintlist.aspx?bid=" + row.id , "打印", 800, 400);
          } else {
              $.ligerDialog.warn('请选择行！');
          }
      }
      //查询
      function xq() {
          var manager = $("#maingrid4").ligerGetGridManager();
          var row = manager.getSelectedRow();
          if (row) {
            
              f_openWindowview("crm/Budge/BudgeMainAdd.aspx?bid=" + row.id + "&style=" + aprstyle, "查看预算", 1110, 600);
          } else {
              $.ligerDialog.warn('请选择行！');
          }
      }
       
      function ret() {
          var manager = $("#maingrid4").ligerGetGridManager();
          var row = manager.getSelectedRow();
          if (row) {
              $.ligerDialog.confirm("确定退回吗？", function (yes) {
                  if (yes) {
                      $.ajax({
                          url: "../../data/Budge.ashx", type: "POST",
                          data: { Action: "saveupdatestatus", status: 0, bid: row.id, rnd: Math.random() },
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

      //绝对退回
      function f_saveretrn(item, dialog) {
          var issave = dialog.frame.f_saveretrn();
          if (issave) {
              dialog.close();
              top.$.ligerDialog.waitting('数据保存中,请稍候...');
              $.ajax({
                  url: "../../data/Budge.ashx", type: "POST",
                  data: issave,
                  success: function (responseText) {
                      top.$.ligerDialog.closeWaitting();
                      if (responseText == "false") {
                          top.$.ligerDialog.error('操作失败！');
                      }
                      else if (responseText == "false:exist") {
                          top.$.ligerDialog.error('此客户已经有生效预算，此单不能生效！！');
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

        //复制预算
      function copy() {
          var manager = $("#maingrid4").ligerGetGridManager();
          var row = manager.getSelectedRow();
          if (row) {
              $.ligerDialog.confirm("确定引用单据：" + row.id, function (yes) {
                  if (yes) {
                      $.ajax({
                          url: "../../data/Budge.ashx", type: "POST",
                          data: { Action: 'copybudge', copyid: row.id, rnd: Math.random() }, /* 注意参数的格式和名称 */
                          success: function (responseText) {

                              top.$.ligerDialog.closeWaitting();
                              if (responseText == "false") {
                                  top.$.ligerDialog.error('操作失败！');
                              }
                              else {
                                  top.$.ligerDialog.alert("新单据：" + responseText);

                                  f_reload();
                              }
                          },
                          error: function () {
                              top.$.ligerDialog.closeWaitting();

                          }
                      });
                  }

              })
          }
      }
        function f_save(item, dialog) {
            var issave = dialog.frame.f_saveapr();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/Budge.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        if (responseText == "false") {
                            top.$.ligerDialog.error('操作失败！');
                        }
                        else    if (responseText == "false:exist") {
                            top.$.ligerDialog.error('此客户已经有生效预算，此单不能生效！！');
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
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
            top.flushiframegrid("tabid39");
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
                        <div style='width: 60px; text-align: right; float: right'>客户姓名：</div>
                    </td>
                    <td>

                        <input  ltype='text' ligerui='{width:120}' type='text' id='khstext' name='khstext'  /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>地址：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='dzstext' name='dzstext' ltype='text' ligerui='{width:120}'  />
                        </div>
                    
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>电话：</div>
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
                        <div style='width: 60px; text-align: right; float: right'>施工监理：</div>
                    </td>
                   <td>
                        <input id='sgjlstext' name="sgjlstext" type='text'  ltype='text' ligerui='{width:120}' /></td>
                  
                     <td>
                        <div style='width: 60px; text-align: right; float: right'>设计师：</div>
                    </td>
                    <td>
                        <input id='T_sjs' name="T_sjs" type='text'  ltype='text' ligerui='{width:120}' /></td>
                     <td>
                        <div style='width: 60px; text-align: right; float: right'>预算编号：</div>
                    </td>
                    <td>
                        <input id='T_ysbh' name="T_ysbh" type='text'  ltype='text' ligerui='{width:120}' /></td>
                     <td>
                        <input id="t_zt" name="t_zt" type="text" ltype="select" ligerui="{width:196,data:[{id:'',text:'全部'},{id:'0',text:'待提交'},{id:'1',text:'待审核'},{id:'2',text:'已生效'},{id:'99',text:'已删除'}]}"  />

                   </td>
           

                </tr>
            
            </table>
        </form>
    </div>


</body>
</html>
