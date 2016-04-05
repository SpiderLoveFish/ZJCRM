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
   <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/json2.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        var manager = "";
        $(function () {
            var urlstr = "../../data/Budge.ashx?Action=grid&str_condition=1";
            if (getparastr("isprint") == "Y")
                urlstr = "../../data/Budge.ashx?Action=grid"
            $("#maingrid4").ligerGrid({
                columns: [
                     {
                         display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                         { return (page - 1) * pagesize + rowindex + 1; }
                     },
                      { display: '预算编号', name: 'id', width: 150, align: 'left' },
                          { display: '预算名称', name: 'BudgetName', width: 150, align: 'left' },
                      { display: '客户姓名', name: 'CustomerName', width: 80, align: 'left' },
                       { display: '客户电话', name: 'tel', width: 100, align: 'left' },
                        { display: '客户地址', name: 'address', width: 200, align: 'left' },
                   { display: '预算金额', name: 'BudgetAmount', width: 80, align: 'left' },
                        {
                            display: '状态', name: 'txtstatus', width: 60, align: 'left', render: function (item) {

                                var html;
                                if (item.txtstatus == "待审核") {
                                    html = "<div style='color:#FF0000'>";
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
                { display: '备注', name: 'Remarks', width: 200, align: 'left' }

                ],
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
                urlstr = "../../data/toolbar.ashx?Action=GetSys&mid=158&rnd=" + Math.random()
 
            $.getJSON(urlstr, function (data, textStatus) {
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
         
            $("#T_sjs").addClass("l-text");
            $("#T_ysbh").addClass("l-text");
            
        }

        //查询
        function doserch() {
            var urlstr = "../../data/Budge.ashx?str_condition=1";
            if (getparastr("isprint") == "Y")
                urlstr = "../../data/Budge.ashx?Action=grid"
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
            //  alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL(urlstr+"&" + serchtxt);
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
     //审核
      function apr() {
          var manager = $("#maingrid4").ligerGetGridManager();
          var row = manager.getSelectedRow();
          if (row) {
              f_openWindow("crm/Budge/BudgeMainAdd.aspx?bid=" + row.id+"&style=apr", "审核预算", 1100, 600,"审核");
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
                        <div style='width: 60px; text-align: right; float: right'>设计师：</div>
                    </td>
                    <td>
                        <input id='T_sjs' name="T_sjs" type='text'  ltype='text' ligerui='{width:120}' /></td>
                     <td>
                        <div style='width: 60px; text-align: right; float: right'>预算编号：</div>
                    </td>
                    <td>
                        <input id='T_ysbh' name="T_ysbh" type='text'  ltype='text' ligerui='{width:120}' /></td>


                </tr>
            
            </table>
        </form>
    </div>


</body>
</html>
