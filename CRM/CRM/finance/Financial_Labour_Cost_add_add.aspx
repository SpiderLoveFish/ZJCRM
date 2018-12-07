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
       
        var manager = ""; var g,ck;
        var treemanager,gcombkh,gcombgys;
        $(function () {
            var urlstr = "";
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
            getparastr("isview")
            $("form").ligerForm();
            if (getparastr("fid") != null) {
            
                loadForm(getparastr("fid"));
                 
            }
            else {
 
            }

            if (getparastr("isview") == "Y")
            {
                $("#addmx").attr("style","display: none; ");
                $("#del").attr("style", "display: none; ");
            }
        
            initLayout();
            $(window).resize(function () {
                initLayout();
            });

          
            
            loadGrid();
          
        // $("#maingrid4 .l-grid-hd-cell-btn-checkbox").hide();

         //if (status != "0") {
         //    g.toggleCol('purprice', true);
         //    g.toggleCol('pursum', true);
         //}
        })
 
        
        //只允许编辑前3行
        function f_onBeforeEdit(e) {
       
            //if (getparastr("status") != "0")  //非编辑状态，不能修改！
            //return false;
            return true;
        }
        //限制
        function f_onBeforeSubmitEdit(e) {
            if (e.column.name == "purprice"||e.column.name=="pursum") {
                if (e.value < 0) {
                    alert("数量不能为负数！");
                    return false;
                }
            }
            return true;
        }
        //编辑后事件 
        function f_onAfterEdit(e) {
            var price=0,editsum=0,Remarks='';
            if (e.column.name == "Fprice") {
                price=e.value;
            }
            if (e.column.name == "Fsum") {
                editsum=e.value;
            } 
            if (e.column.name == "Remarks") {
                Remarks=e.value;
            }
            if(price>0||editsum>0||Remarks.length>0)
            {
                var manager = $("#maingrid4").ligerGetGridManager();
                var row = manager.getSelectedRow();
         
                if (row) {
                    $.ajax({
                        url: "../../data/Financial_Labour_Cost.ashx", type: "POST",
                        data: { Action: "updatedetail", pid: $("#T_Pid").val(), mid: row.material_id, editsum: editsum, price: price, remaks: Remarks,  rnd: Math.random() },
                        success: function (responseText) {
                         
                            if (responseText == "true") {
                                top.$.ligerDialog.closeWaitting();
                                fload();
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
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=160&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
  
                $("#toolbar").ligerToolBar({
                    items: items

                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });

                 $("#maingrid4").ligerGetGridManager().onResize();
            });
        }
        //选择全部材料
        function btnadd() {
           
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择全部材料', width: 850, height: 400,
                url: "../../CRM/ConsExam/getemp.aspx?style=JJ&fid=" + getparastr("fid") , buttons: [
                    { text: '确定(F2)', onclick: f_selectProductOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }

        function f_selectContactCancel(item, dialog) {
            fload();
            dialog.close();
        }
          function f_selectProductOK(item, dialog)
        {
            
            var rows = null;
         
            if (!dialog.frame.f_select()) {
                alert('请选择行!');
                return;
            }
            else {
                rows = dialog.frame.f_select();
                if (rows == "") {
                    alert('请选择行!');
                    return;
                }
                var pidlist = '';
                for (var i = 0; i < rows.length; i++) {
                    pidlist = pidlist + ',' + rows[i].product_id;

                }
                var url = '../../data/Financial_Labour_Cost.ashx?Action=savedetail&pid=' + $("#T_Pid").val() + "&bjlist=" + pidlist + '&rdm=' + Math.random();
                if(pidlist.length>0)
                dosave(url, dialog);
            }
        }

        function f_save() {
            
            var sendtxt = "&Action=savedetail&pid=" + $("#T_Pid").val();
            return $("form :input").fieldSerialize() + sendtxt;
        }
        function f_getfid() {
            return getparastr("fid");
        }
       
     
        function dosave(saveurl, dialog)
        {
            $.ajax({
                type: 'post',
                url: saveurl,
                success: function (data) {
                    dialog.close();
                    fload();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.ligerDialog.error("保存错误！！！检查是否有重复代码！");
                    dialog.close();
                }
            });
        }

        function btndel() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("删除不能恢复，确定删除？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/Financial_Labour_Cost.ashx", type: "POST",
                            data: { Action: "deldetail", pid: row.F_Num, mid: row.material_id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    fload();
                                }

                                else {
                                    top.$.ligerDialog.closeWaitting();
                                    top.$.ligerDialog.error('删除失败！');
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
        var activeDialogs = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                zindex: 9002,
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '保存', onclick: function (item, dialog) {
                                f_saveselect(item, dialog);
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

       function loadGrid()
        {
            
                    g = $("#maingrid4").ligerGrid({
                        columns: [
                            { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },

                            { display: '材料名称', name: 'material_name', width: 120 },
                             { display: '规格', name: 'specifications', width: 80 },
                             //  { display: '料号', name: 'ProModel', width: 80 },
                                //     { display: '品牌', name: 'Brand', width: 80 },

                            { display: '型号', name: 'model', width: 120 },
                             {
                                 display: '单价', name: 'Fprice', type: 'float', width: 60, align: 'right'
                                 , editor: { type: 'float' }
                             },

                                {
                                    display: '数量', name: 'Fsum', width: 120, align: 'right'
                                    , type: 'float', editor: { type: 'float' },
                                    totalSummary:
                                    {
                                        type: 'sum'
                                    }

                                },
                                 {
                                     display: '小计', name: 'totalMoney', type: 'float', width: 100, align: 'right',
                                     totalSummary:
                                     {
                                         type: 'sum'
                                     }
                                 },
                            
                                 
                                {
                                    display: '备注', name: 'remarks', align: 'left', width: 200, type: 'text' 
                            },
                                {
                                    display: '图文', width: 40, render: function (item) {
                                        var html = "<a href='javascript:void(0)' onclick=view(" + item.material_id + ")>查看</a>"
                                        return html;
                                    }
                                }
                            
                               

                        ],
                        dataAction: 'server',
                        url: "../../data/Financial_Labour_Cost.ashx?Action=griddetail&fid=" + getparastr("fid") + "&rnd=" + Math.random(),
                        pageSize: 30,
                        pageSizeOptions: [20, 30, 50, 100],
                        width: '100%',
                        height: '100%',
                        heightDiff: -1,
                        enabledEdit: true,
                        allowHideColumn: true,
                        onBeforeEdit: f_onBeforeEdit,
                        onBeforeSubmitEdit: f_onBeforeSubmitEdit,
                        onAfterEdit: f_onAfterEdit,
                        //onAfterShowData: function (grid) {
                        //    $(".abc").hover(function (e) {
                        //        $(this).ligerTip({ content: $(this).text(), width: 200, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                        //    }, function (e) {
                        //        $(this).ligerHideTip(e);
                        //    });
                        //},
                        // onAfterShowData:ishidecol,
                        //checkbox: true, name: "ischecked", checkboxAll: false, isChecked: f_isChecked, onCheckRow: f_onCheckRow, onCheckAllRow: f_onCheckAllRow,
                        onContextmenu: function (parm, e) {
                            actionproduct_id = parm.data.id;
                            menu.show({ top: e.pageY, left: e.pageX });
                            return false;
                        }
                    });
                 
        }

        //编辑
        function views(cid,id,sgjl) {
            var dialogOptions = {
                width: 770, height: 510, title: "辅助介绍", url: "../../CRM/ConsExam/PurProductList_edit.aspx?cid=" +cid + "&id=" + id + "&sgjl=" + sgjl, buttons: [
                    {
                        text: '关闭', onclick: function (item, dialog) {
                            dialog.close();
                        }
                    }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
            //var manager = $("#maingrid4").ligerGetGridManager();
            //var row = manager.getSelectedRow();
            //if (row) {
                //f_openWindow_("../../CRM/ConsExam/PurProductList_edit.aspx?cid=" + getparastr("cid") + "&id=" + row.id + "&sgjl=" + getparastr("sgjl"), "辅助信息", 800, 500);
            //} else {
            //    $.ligerDialog.warn("请选择类别！");
            //}

        }
        function view(id) {
            var dialogOptions = {
                width: 1000, height: 630, title: "材料档案图文介绍", url: '../view/product_view.aspx?id=' + id + '&rnd=' + Math.random(), buttons: [
                    {
                        text: '关闭', onclick: function (item, dialog) {
                            dialog.close();
                        }
                    }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function loadForm(oaid) {
           // alert(oaid)
            $("#T_Pid").val(oaid);
            // $.ajax({
            //    type: "GET",
            //    url: "../../data/Financial_Labour_Cost.ashx", /* 注意后面的名字对应CS的方法名称 */
            //    data: { Action: 'form', pid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
            //    contentType: "application/json; charset=utf-8",
            //    dataType: "json",
            //    success: function (result) {
            //        var obj = eval(result);
            //        for (var n in obj) {
            //            if (obj[n] == "null" || obj[n] == null)
            //                obj[n] = "";
            //        }
            //       // alert(obj.CustomerID); //String 构造函数
            //        $("#T_companyid").val(obj.customid);
            //        $("#T_companyname").val(obj.Customer + "(" + obj.address + ")");
            //        $("#T_gysid").val(obj.supplier_id);
            //        $("#T_gysname").val(obj.supplier_name);
            //        $("#T_Pid").val(obj.Purid);
            //        if (obj.IsGD=="1")
            //            ck.setValue(true);;
            //        $("#T_remarks").val(obj.Remarks);
            //        $("#T_employee2").val(obj.materialman);
            //        $("#T_cgrq").val(formatTime( obj.purdate));
            //        $("#T_yfje").val(obj.payable_amount);
            //        $("#T_yfje2").val(obj.paid_amount);
            //        $("#T_qk").val(obj.arrears);
            //        $("#T_employee").val(obj.Emp_sg);//施工监理
                   
            //    }
            //});
        }
         

       
        
  
         
           function doserch() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Financial_Labour_Cost.ashx?Action=griddetail&fid=" + $("#T_Pid").val());
        }
        function fload()
        {
            
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
                <td colspan="8" class="table_title1">基本信息
                     
                </td>
                
                  </tr>
          
         
               <tr>
                 
                <td>
  
              <div style="width: 70px; text-align: right; float: right">单据编号：</div></td>
                <td  colspan="3"><input type="text"  id="T_Pid" name="T_Pid"  ltype="text" ligerui="{width:240,disabled:true}"   /></td>
                                 <td> <input type="button" id="addmx" value="选择明细"     onclick="btnadd()"></input></td>
                    <td> <input type="button" id="del" value="删除"     onclick="btndel()"></input></td>
                    </tr>
          
        </table>
        </div>
   
            <div id="divcenter" position="center">
           
                <div id="maingrid4" style="margin: -1px;"></div>
            </div>
        
  </form>
   
</body>
</html>
