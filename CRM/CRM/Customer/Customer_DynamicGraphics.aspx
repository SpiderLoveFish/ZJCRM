<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
      <link href="../../CSS/styles.css" rel="stylesheet" />
     <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
   
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
  
     <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
     <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
   
      <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
      <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
   
    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">

        var manager = ""; 
        $(function () {
            var urlstr = "";
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
          
            $("form").ligerForm();
            if (getparastr("cid") != null) {
                loadForm(getparastr("cid"));
             toolbar();
            }
      
            initLayout();
            $(window).resize(function () {
                initLayout();
            });



 
        })

 

        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=177&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
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
                $("#toolbar").ligerToolBar({
                    items: items

                });
                $('#stextlx').ligerComboBox({
                    width: 80,
                    selectBoxWidth: 100,
                    selectBoxHeight: 100,
                    valueField: 'id',
                    textField: 'text',
                    treeLeafOnly: false,
                    tree: {
                        data: [
                   {id:0, text: '自定义' },
                   { id: 1, text: '云端数据' }
                        ],
                        checkbox: false
                    }
                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });

                $("#maingrid4").ligerGetGridManager().onResize();
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
        //关闭刷新
        function f_close(item, dialog) {
            fload();
            dialog.close();
        }
        var activeDialog = null;
        function f_openWindow_view(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [

                        {
                            text: '关闭', onclick: function (item, dialog) {
                                f_close(item, dialog);
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = top.jQuery.ligerDialog.open(dialogOptions);
        }
        function getLocalTime(nS) {
            return new Date(parseInt(nS) * 1000).toLocaleString().substr(0, 10)
        }
        function loadGrid(tel) {

            g = $("#maingrid4").ligerGrid({
                columns: [
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },

                 //   { display: '客户', name: 'Customer', width: 120 },
 
                   { display: '名称', name: 'title', width: 160 },

                      {
                          display: '', width: 50, render: function (item) {

                                   
                               var html;
                               if (item.DyUrl !== "") {
                                   var html = "<a href='javascript:void(0)' onclick=viewkjl('" + item.link + "','aa')>查看</a>"

                                 
                              }
                              else html = "暂无";
                              return html;
                          }
                      },
                          {
                              display: '创建时间', name: 'DoTime', width: 90, render: function (item) {
                                  var Create_date = getLocalTime(item.addtime);
                                  return Create_date;
                              }
                          },
                           //{
                           //    display: '3D图', name: 'desid', width: 80, render: function (item) {
                           //        var html;
                           //        if (item.desid != "") html = "有";
                           //        else html = "无";
                           //        return html;
                           //    }
                           //},
                           //{
                           //    display: '预览图', name: 'img', width: 80, render: function (item) {
                           //        var html;
                           //        if (item.simg !== "") {
                           //            var html = "<a href='javascript:void(0)' onclick=viewurl('" + item.img + "')>查看</a>";
                           //            html += "</a>"
                           //        }
                           //        else html = "暂无";
                           //        return html;
                           //    }
                           //},
                           //{
                           //    display: '全景图', name: 'pano', width: 80, render: function (item) {
                           //        var html;
                           //        if (item.pano !== "") {
                           //            var html = "<a href='javascript:void(0)' onclick=viewurl('" + item.pano + "')>查看</a>";
                           //            html += "</a>"
                           //        }
                           //        else html = "暂无";
                           //        return html;
                           //    }
                           //},
                        {
                            display: '备注', name: 'views', align: 'left', width: 250, type: 'text'
                            
                        }



                ],
                dataAction: 'server',
                url: "../../data/crm_customer.ashx?Action=griddyapi&cid=" + getparastr("cid")+'&keytel='+tel + "&rnd=" + Math.random(),
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                width: '100%',
                height: '100%',
                heightDiff: -1,
                enabledEdit: true,
                allowHideColumn: true,
                  onContextmenu: function (parm, e) {
                    actionproduct_id = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });

        }
        
        function loadForm(oaid) {
            $("#T_customerid").val(oaid);
            $("#T_customer").val(decodeURI(getparastr("name")));
            $("#T_tel").val(decodeURI(getparastr("tel")));
            $("#T_sjs").val(decodeURI(getparastr("sjs")));
            
            loadGrid(decodeURI(getparastr("tel")));
        }


        function add() {
            f_openWindow("CRM/Customer/Customer_DynamicGraphics_add.aspx?cid=" + getparastr("cid"), "新增全景图", 500, 200);

        }

        function viewkjl(url,newname)
        {
            
            window.open(url + "&width=" + screen.width +
                                "&height=" + (screen.height - 70), newname,
                                "top=0,left=0,toolbar=no, menubar=no, scrollbars=yes,resizable=no,location=no,status=no,width=" +
                                screen.width + ",height=" +
                                (screen.height - 70));
        }

        function kjl() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                    // f_openWindow_view("CRM/ConsExam/kjl_edit.aspx?cid=" + getparastr("cid") + "&style=insert" + "&dest=0", "新增效果图", 1200, 710);
                viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=insert' + '&dest=0', "新增全景图");
            }
            else {
               // f_openWindow_view("CRM/ConsExam/kjl_edit.aspx?cid=" + getparastr("cid") + "&style=insert" + "&dest=0", "新增效果图", 1200, 710);
                viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=insert' + '&dest=0', "新增全景图");
            }
        }
        //修改3D图
        function kjl3d() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
              
                if (row.desid == null || row.desid == "")
                    $.ligerDialog.warn('没有对应的3D图，请先在对应户型图里新增！');
                else
                   // f_openWindow_view("CRM/ConsExam/kjl_edit.aspx?cid=" + getparastr("cid") + "&style=Edit" + "&dest=1" + "&desid=" + row.desid, "修改3D图", 1200, 710);
                    viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=Edit' + '&dest=1' + '&desid=' + row.desid, "修改3D图");

            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        //修改户型图
        function kjlhx() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                //alert(row.fpId);
                if( row.fpId==null||row.fpId=="")
                    $.ligerDialog.warn('没有对应的户型图，请先新增！');
                else  
                   // f_openWindow_view("CRM/ConsExam/kjl_edit.aspx?cid=" + getparastr("cid") + "&style=Edit" + "&dest=2" + "&fid=" + row.fpId, "修改户型图", 1200, 650);
                    viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=Edit' + '&dest=2' + "&fid=" + row.fpId, "修改户型图");

            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('CRM/Customer/Customer_DynamicGraphics_add.aspx?id=' + row.ccid + '&cid=' + getparastr("cid") + '&fid=' + row.fpId + '&desid=' + row.desid, "修改全景图", 500, 200);
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }

        function viewurl(url) {
           // f_openWindow_view('CRM/ConsExam/kjl_view.aspx?strurl=' + url, "查看图", screen.width, screen.height);
            viewkjl('../../CRM/ConsExam/kjl_view.aspx?strurl=' + url, "查看图");
        }
       
        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("确定删除？", function (yes) {
                    if (yes) {
                        if (row.fpId != "") {
                            if (row.desid != "") {
                                $.ajax({
                                    url: "../../data/SingleSignOn.ashx", type: "POST",
                                    data: { Action: "delete", fid: row.fpId, desid: row.desid, cid: getparastr("cid"), rnd: Math.random() },
                                    success: function (responseText) {
                                        if (responseText == "success") {
                                            $.ajax({
                                                url: "../../data/SingleSignOn.ashx", type: "POST",
                                                data: { Action: "deleteAPI", fid: row.fpId, desid: row.desid, cid: getparastr("cid"), rnd: Math.random() },
                                                success: function (responseText) {
                                                    if (responseText == "true") {
                                                        fload();

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

                                        else {
                                            top.$.ligerDialog.error('删除失败！');
                                        }

                                    },
                                    error: function () {
                                        top.$.ligerDialog.error('删除失败！');
                                    }
                                });
                            }//end row.desid != ""
                            else {
                                $.ajax({
                                    url: "../../data/SingleSignOn.ashx", type: "POST",
                                    data: { Action: "deleteHXT", fid: row.fpId, desid: row.desid, cid: getparastr("cid"), rnd: Math.random() },
                                    success: function (responseText) {
                                        if (responseText == "success") {
                                            $.ajax({
                                                url: "../../data/SingleSignOn.ashx", type: "POST",
                                                data: { Action: "deleteAPI", fid: row.fpId, desid: row.desid, cid: getparastr("cid"), rnd: Math.random() },
                                                success: function (responseText) {
                                                    if (responseText == "true") {
                                                        fload();

                                                    }

                                                    else {
                                                        top.$.ligerDialog.error('删除失败！' + responseText);
                                                    }

                                                },
                                                error: function () {
                                                    top.$.ligerDialog.error('删除失败！');
                                                }
                                            });

                                        }

                                        else {
                                            top.$.ligerDialog.error('删除失败！');
                                        }

                                    },
                                    error: function () {
                                        top.$.ligerDialog.error('删除失败！');
                                    }
                                });
                            }//END ELSE
                        }//END if (row.fpId != "")
                        else {//ccid特意为这个
                            $.ajax({
                                url: "../../data/CRM_Customer.ashx", type: "POST",
                                data: { Action: "deldy", id: row.ccid, cid: getparastr("cid"), rnd: Math.random() },
                                success: function (responseText) {
                                    if (responseText == "true") {
                                        fload();

                                    }

                                    else {
                                        top.$.ligerDialog.error('删除失败！');
                                    }

                                },
                                error: function () {
                                    top.$.ligerDialog.error('删除失败！');
                                }
                            });
                        }//end else
                    }//end yes
                });
            }
            else {
                $.ligerDialog.warn("请选择客户");
            }
        }
        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            var fid = dialog.frame.f_fid();
            if (fid != "" && fid != null)
            {
                var name = dialog.frame.f_fid_name();
                dialog.close();
                $.ajax({
                    url: "../../data/SingleSignOn.ashx", type: "POST",
                    data: { Action: "updatehxtname", fid: fid, T_name: name, rnd: Math.random() },
                    beforesend: function () {
                        top.$.ligerDialog.waitting('数据保存中,请稍候...');
                    },
                    success: function (responseText) {
                        if (responseText == "success") {
                            fload();
                        }

                        else {
                            top.$.ligerDialog.error('保存失败！');
                        }

                    },
                    error: function () {
                        top.$.ligerDialog.error('保存失败！');
                    },
                    complete: function () {
                        top.$.ligerDialog.closeWaitting();
                    }
                });

            }


            else if (issave) {
                dialog.close();

                $.ajax({
                    url: "../../data/CRM_Customer.ashx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('数据保存中,请稍候...');
                    },
                    success: function (responseText) {

                        fload();
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

        function doserch() {
            //var serchtxt = $("#form1 :input").fieldSerialize();

            
            var manager = $("#maingrid4").ligerGetGridManager();
            if ($("#stextlx_val").val() == "0")
            {
               // alert(1)
                manager.GetDataByURL("../../data/crm_customer.ashx?Action=griddy&cid=" + getparastr("cid") );
            
            }else if ($("#stextlx_val").val() == "1")
            {   
                manager.GetDataByURL("../../data/crm_customer.ashx?Action=griddyapi&cid=" + getparastr("cid") + '&keytel=' + getparastr("tel") + "&rnd=" + Math.random());
            }
        }
        function fload() {

            doserch();

            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);

        }
    </script>
  
</head>
<body style="padding: 0px;overflow:hidden;">
    <form id="form1" onsubmit="return false">
    
        <div>
            <div id="toolbar"></div>
             <input type="hidden" id="h_address" value="" />
        <table style="width: 550px; margin: 5px;" class='bodytable1'>
            <tr>
                <td colspan="8" class="table_title1">客户信息
                     
                </td>
              
                  </tr>
            <tr>
                <td>
                    <div style="width: 70px; text-align: right; float: right">客户：</div>
                </td>
                <td  >
                         <input type="text" id="T_customer" name="T_customer"  ltype="text" ligerui="{width:150,disabled:true}" validate="{required:true}" />
                     <input id="T_customerid" name="T_customerid" type="hidden" />
               
                    
                </td>
             
                 
                <td>  <div style="width: 70px; text-align: right; float: right">电话：</div></td>
                <td><input type="text"  id="T_tel" name="T_tel"  ltype="text" ligerui="{width:100,disabled:true}"   /></td>
              <td> <div style="width: 70px; text-align: right; float: right">设计师：</div></td>
              <td><input type="text"  id="T_sjs" name="T_sjs"  ltype="text" ligerui="{width:100,disabled:true}"   /></td>
              
               
                 </tr>
        
        </table>
        </div>
   
            <div id="divcenter" position="center">
           
                <div id="maingrid4" style="margin: -1px;"></div>
            </div>
        
  </form>
   
</body>
</html>
