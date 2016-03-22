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
        var manager = ""; var g;
        var treemanager,gcombkh,gcombgys;
        $(function () {
            var urlstr = "";
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();
            if (getparastr("pid") != null) {
                $("#qdkh").attr("style", "display:none");
                loadForm(getparastr("pid"));
                if (getparastr("status") == "0")
                toolbar();
            }
            else {

                gcombkh= $('#T_companyname').ligerComboBox({ width: 250, onBeforeOpen: f_selectContact });
                gcombgys= $('#T_gysname').ligerComboBox({ width: 250, onBeforeOpen: f_selectContactgys });
                var cur = new Date();
                var y = cur.getFullYear();
                var m = cur.getMonth() + 1;
                var d = cur.getDate();
                //return y + '-' + m + '-' + d;
                $('#T_cgrq').val(y + '-' + m + '-' + d);
            }

         
        
            initLayout();
            $(window).resize(function () {
                initLayout();
            });


         g= $("#maingrid4").ligerGrid({
                columns: [
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                  
                    { display: '材料名称', name: 'material_name', width: 120 },
                     { display: '规格', name: 'specifications', width: 80 },

                    { display: '型号', name: 'model', width: 120 },
                     {
                         display: '单价', name: 'purprice', type: 'float', width: 60, align: 'right'
                         , editor: { type: 'float' }
                     },
                     
                        {
                            display: '数量', name: 'pursum', width: 120, align: 'left'
                            , type: 'float', editor: { type: 'float' },
                            totalSummary:
                            {
                                type: 'sum'
                            }

                        },
                         {
                             display: '小计', name: 'subtotal', type: 'float', width: 100, align: 'right',
                             totalSummary:
                             {
                                 type: 'subtotal'
                             }
                         },
                  
                        {
                            display: '备注', name: 'Remarks', align: 'left', width: 400,type:'text'
                            , editor: { type: 'text' }
                        }
                 
                ],
                dataAction: 'server',
                url: "../../data/Purchase.ashx?Action=griddetail&pid=" + getparastr("pid") + "&rnd=" + Math.random(),
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                width: '100%',
                height: '100%',
                heightDiff: -1,
                enabledEdit: true,
                allowHideColumn:true,
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
          
         $("#maingrid4 .l-grid-hd-cell-btn-checkbox").hide();

         //if (status != "0") {
         //    g.toggleCol('purprice', true);
         //    g.toggleCol('pursum', true);
         //}
        })
 
        
        //只允许编辑前3行
        function f_onBeforeEdit(e) {
            if (getparastr("status") != "0")  //非编辑状态，不能修改！
            return false;
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
            if (e.column.name == "purprice") {
                price=e.value;
            }
            if (e.column.name == "pursum") {
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
                        url: "../../data/Purchase.ashx", type: "POST",
                        data: { Action: "saveupdatedetail", pid: $("#T_Pid").val(), mid: row.material_id, editsum: editsum,price:price,remaks:Remarks, rnd: Math.random() },
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
        function selall() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择全部材料', width: 850, height: 400,
                url: "CRM/Purchase/SelectProduct.aspx?style=all", buttons: [
                    { text: '确定', onclick: f_selectProductOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        //选择工程材料
        function selgc() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择工程材料', width: 850, height: 400,
                url: "CRM/Purchase/SelectProduct.aspx?style=cl&cid=" + $("#T_companyid").val(), buttons: [
                  { text: '确定', onclick: f_selectProductOK },
                  { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectProductOK(item, dialog)
        {
            if ($("#T_companyid").val() == "") {
                $.ligerDialog.error("请选择一个有效的数据！！！");
                return;
            }
             
            var rows = null;
         
            if (!dialog.frame.f_select()) {
                alert('请选择行!');
                return;
            }
            else {
                rows = dialog.frame.f_select();
                var pidlist = '';
                for (var i = 0; i < rows.length; i++) {
                    pidlist = pidlist + ',' + rows[i].product_id;

                }
                var url = '../../data/Purchase.ashx?Action=savedetail&pid=' + $("#T_Pid").val() + "&bjlist=" + pidlist + '&rdm=' + Math.random();
                dosave(url,dialog);
            }
        }

        function f_save() {
            
            var sendtxt = "&Action=save";
            return $("form :input").fieldSerialize() + sendtxt;
        }
        //审核 ，作废
        function f_saveapr() {
            if ($("#T_companyid").val() == "") {
                $.ligerDialog.error("请选择保存一个有效的客户！！！");
                return;
            }
            var sta = 2;
            if (getparastr("style") == "apr")//审核
                sta = 2;
            if (getparastr("style") == "cancel")//作废
                sta = 99;
            if (getparastr("status") == "1") sta = 0;//撤回
            var sendtxt = "&Action=saveupdatestatus&status=" + sta + "&pid=" + $("#T_Pid").val();
            return sendtxt;
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
                    $.ligerDialog.error("保存错误！！！");
                    dialog.close();
                }
            });
        }

        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("删除不能恢复，确定删除？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/Purchase.ashx", type: "POST",
                            data: { Action: "deldetail", pid: row.Purid, mid: row.material_id, rnd: Math.random() },
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
      
        function loadForm(oaid) {
             $.ajax({
                type: "GET",
                url: "../../data/Purchase.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', pid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                   // alert(obj.CustomerID); //String 构造函数
                    $("#T_companyid").val(obj.customid);
                    $("#T_companyname").val(obj.Customer + "(" + obj.address + ")");
                    $("#T_gysid").val(obj.supplier_id);
                    $("#T_gysname").val(obj.supplier_name);
                    $("#T_Pid").val(obj.Purid);
                    $("#ckisgd").val(obj.IsGD);
                    $("#T_remarks").val(obj.Remarks);
                    $("#T_employee2").val(obj.materialman);
                    $("#T_cgrq").val(formatTime( obj.purdate));
                    $("#T_yfje").val(obj.paid_amount);
                    $("#T_yfje2").val(obj.payable_amount);
                    $("#T_qk").val(obj.arrears);
                    $("#T_employee").val(obj.Emp_sg);//施工监理
                   
                }
            });
        }
         

        //选择客户
        function f_selectContact() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择客户', width: 850, height: 400,
               
                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Budge/SelectBudgeCustomer.aspx", buttons: [
                    { text: '确定', onclick: f_selectContactOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        //选择供应商
        function f_selectContactgys() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择供应商', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Purchase/SelectSupplier.aspx", buttons: [
                    { text: '确定', onclick: f_selectContactgysOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectContactOK(item, dialog) {
            //var data = dialog.frame.f_select();
            var fn =  dialog.frame.f_select;           
            var data = fn();
            if (!data) {
                alert('请选择一个有效客户!');
                return;
            }
            fillemp(data.CustomerID, data.CustomerName,  
                data.sgjl,data.address );
          
            dialog.close();
        }

        function f_selectContactgysOK(item, dialog) {
            //var data = dialog.frame.f_select();
            var fn = dialog.frame.f_select;
            var data = fn();
            if (!data) {
                alert('请选择一个有效供应商!');
                return;
            }
            fillempgys(data.ID, data.Name);
          
            dialog.close();
        }


        function getmaxid() {
           
            $.ajax({
                type: "get",
                url: "../../data/Purchase.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'getmaxid', rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                   
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(obj.pid); //String 构造函数
                    $("#T_Pid").val(obj.pid);
                    $("#T_employee2").val(obj.cly);

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("获取预算编号失败，重新选择！");
                }
            });
        }

        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
        function fillemp(id,  emp, sgjl,address) {
            $("#T_companyid").val(id);
            $("#T_companyname").val(emp + '(' + address+')');
            $("#T_employee").val(sgjl);
        }
        function fillempgys(id, emp) {
            $("#T_gysid").val(id);
            $("#T_gysname").val(emp);
            getmaxid();
        }
         
        function addpur()
        {
            if ($("#T_companyid").val() == "") {
                $.ligerDialog.error("请选择一个有效的客户！！！");
                return;
            }
            $.ajax({
                type: 'post',
                url: "../../data/Purchase.ashx?Action=savetemp&pid=" + $("#T_Pid").val() + "&cid=" + $("#T_companyid").val() + "&remark=" + $("#T_remarks").val() + '&supid=' + $("#T_gysid").val() + '&rdm=' + Math.random(),
                success: function (data) {
                    if (data == 'false') {
                        getmaxid();
                        $.ligerDialog.error("保存错误！！！重新保存！");
                    }
                    else {
                        $("#qdkh").attr("style", "display:none");
                        gcombgys.setReadOnly;
                        gcombkh.setReadOnly;
                        toolbar();
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.ligerDialog.error("保存错误！！！");
                }
            });
          
        }
   
       
        function fload()
        {
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
                <td colspan="6" class="table_title1">基本信息
                     
                </td>
                <td colspan="3"  class="table_title1"> 
                      <a id="qdkh" class="l-button red"  position="right" style="width:150px;" onClick="addpur()">
                          确定采购

                      </a>
          
                </td>
                  </tr>
            <tr>
                <td>
                    <div style="width: 70px; text-align: right; float: right">客户信息：</div>
                </td>
                <td  >
                         <input type="text" id="T_companyname" name="T_companyname"  ltype="text" ligerui="{width:250,disabled:true}" validate="{required:true}" />
                     <input id="T_companyid" name="T_companyid" type="hidden" />
               
                    
                </td>
                
                <td>
                    <div style="width: 70px; text-align: right; float: right">供应商：</div>
                </td>
                <td  >
                      <input id="T_gysid" name="T_gysid" type="hidden" />
                    <input id="T_gysname" name="T_gysname" type="text" ltype="text" 
                        ligerui="{width:250,disabled:true}" validate="{required:false}" />

                </td>
                 
                <td>  <div style="width: 70px; text-align: right; float: right">应付金额：</div></td>
                <td><input type="text"  id="T_yfje" name="T_yfje"  ltype="text" ligerui="{width:80,disabled:true}"   /></td>
              <td> <div style="width: 70px; text-align: right; float: right">已付金额：</div></td>
              <td><input type="text"  id="T_yfje2" name="T_yfje2"  ltype="text" ligerui="{width:80,disabled:true}"   /></td>
              
               
                 </tr>
             <tr>
                    <td><div style="width: 70px; text-align: right; float: right">欠款：</div></td>
                <td><input type="text"  id="T_qk" name="T_qk"  ltype="text" ligerui="{width:80,disabled:true}"   /></td>
               <td><div style="width: 70px; text-align: right;   float: right">采购日期：</div></td>
                <td><input type="text"  id="T_cgrq" name="T_cgrq"  ltype="date" ligerui="{width:120}"   /></td>
             <td   ><span style="width: 60px; text-align: right; float: right">施工监理：</span></td>
                 <td   ><input id="T_employee" name="T_employee" validate="{required:false}"  ltype="text" ligerui="{width:80,disabled:true}"  /></td>
                 <td   ><span style="width: 60px; text-align: right; float: right">材料员：</span></td>
                 <td    ><input id="T_employee2" name="T_employee2" validate="{required:false}"  ltype="text" ligerui="{width:80,disabled:true}"  /></td>
               
             </tr>
               <tr>
                 
                 <td    ><div style="width: 70px; text-align: right; float: right">备注：</div></td>
                 <td colspan="3"  ><input id="T_remarks" name="T_remarks" type="text" ltype="text"  ligerui="{width:550}" /></td>
                   <td> <input id="ckisgc" name="ckisgd" type="checkbox"  />确认现场</td>
                <td>  <div style="width: 70px; text-align: right; float: right">采购单号：</div></td>
                <td  colspan="2"><input type="text"  id="T_Pid" name="T_Pid"  ltype="text" ligerui="{width:150,disabled:true}"   /></td>
             
                    </tr>
          
        </table>
        </div>
   
            <div id="divcenter" position="center">
           
                <div id="maingrid4" style="margin: -1px;"></div>
            </div>
        
  </form>
   
</body>
</html>
