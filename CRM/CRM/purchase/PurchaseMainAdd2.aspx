<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
     <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <title></title>
       <link href="../../jlui3.2/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css">
    <link href="../../jlui3.2/lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css">
     <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />
      <link href="../../CSS/styles.css" rel="stylesheet" />
     <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
      <script type="text/javascript" src="../../jlui3.2/lib/jquery/jquery-1.9.0.min.js"  ></script> 
<script type="text/javascript" src="../../jlui3.2/lib/ligerUI/js/ligerui.all.js"></script>
    <script type="text/javascript" src="../../jlui3.2/lib/json2.js"></script>
     <script type="text/javascript">
         var manager = ""; var g, ck;
         $(function () {
             $("form").ligerForm();
             loadForm(getparastr("pid"));
             g = $("#maingrid4").ligerGrid({
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
                             display: '备注', name: 'Remarks', align: 'left', width: 200, type: 'text'
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
                 allowHideColumn: true,
                 onBeforeEdit: f_onBeforeEdit,
                 onBeforeSubmitEdit: f_onBeforeSubmitEdit,
                 onAfterEdit: f_onAfterEdit,
                      onContextmenu: function (parm, e) {
                     actionproduct_id = parm.data.id;
                     menu.show({ top: e.pageY, left: e.pageX });
                     return false;
                 }
             });
         });
         function f_onSelected(e) {
             if (!e.data || !e.data.length) return;

             var grid = liger.get("grid1");

             var selected = e.data[0];
             grid.updateRow(grid.lastEditRow, {
                 CustomerID: selected.CustomerID,
                 CompanyName: selected.CompanyName
             });

             var out = JSON.stringify(selected);
             $("#message").html('最后选择:' + out);
         }
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
                     if (obj.IsGD == "1")
                         ck.setValue(true);;
                     $("#T_remarks").val(obj.Remarks);
                     $("#T_employee2").val(obj.materialman);
                     $("#T_cgrq").val(formatTime(obj.purdate));
                     $("#T_yfje").val(obj.paid_amount);
                     $("#T_yfje2").val(obj.payable_amount);
                     $("#T_qk").val(obj.arrears);
                     $("#T_employee").val(obj.Emp_sg);//施工监理

                 }
             });
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
                   <td> 
                  
                    <div class="l-checkbox-wrapper">
                        <%--<a class="l-checkbox"></a>--%>
                        <input type="checkbox" name="ckisgd" id="ckisgd" 
                            class="l-hidden" 
                        ligeruiid="ckisgd"/></div> 是否现场 
  
                   </td>
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
