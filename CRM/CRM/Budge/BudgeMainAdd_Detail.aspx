<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
     <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <title></title>
   <link href="../../CSS/input.css" rel="stylesheet" />
      <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/styles.css" rel="stylesheet" />
      <link href="../../jlui3.2/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
     <link href="../../../lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css"> 
     <script src="../../jlui3.2/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/json2.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
       <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
     <script src="../../jlui3.2/lib/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
    <script src="../../jlui3.2/lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
     <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
     <script src="../../jlui3.2/lib/ligerUI/js/ligerui.all.js"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
         <script src="../../lib/jquery.form.js" type="text/javascript"></script>
         <script src="../../JS/Toolbar.js" type="text/javascript"></script>
      <script type="text/javascript">
         var manager = ""; var g, ck;
         var bjmc, bid, gcombgys;
         $(function () {
             $("form").ligerForm();

           //  $('input:checkbox').ligerCheckBox();
             bjmc = decodeURI(getparastr("bjmc"));
            // alert(bjmc)
             bid = getparastr("bid");
             
             initLayout();
             $(window).resize(function () {
                 initLayout();
             });
             loadGrid();

           //  alert(ck);
         });
       
         //限制
         function f_onBeforeSubmitEdit(e) {
          
             if (e.column.name == "SUM" || e.column.name == "OrderBy") {
                 if (e.value < 0) {
                     alert("数量不能为负数！");
                     return false;
                 }
             } return true;
         }
         //编辑后事件 
         function f_onAfterEdit(e) {
           //  alert(JSON.stringify(e.record.id))
             if (e.column.name == "SUM" || e.column.name == "OrderBy") {
                 var manager = $("#maingrid4").ligerGetGridManager();
                 var row = manager.getSelectedRow();
                 var obvalue = -1; var sumvalue = -1;
                 if (e.column.name == "OrderBy") obvalue = e.value;
                 if (e.column.name == "SUM") sumvalue = e.value;
                 if (row) {
                     $.ajax({
                         url: "../../data/Budge.ashx", type: "POST",
                         data: { Action: "saveupdatesum", bid: bid, id: e.record.id, editorderby: obvalue, editsum: sumvalue, rnd: Math.random() },
                         success: function (responseText) {

                             if (responseText == "true") {
                                 //top.$.ligerDialog.closeWaitting();
                                 //fload();
                             } else {
                                 top.$.ligerDialog.error('修改失败！', "", null, 9003);
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


         function loadGrid() {
 
                 g=    $("#maingrid4").ligerGrid({
                         columns: [
                               { display: '名称', name: 'product_name', width: 120 },
                     { display: '部位', name: 'ComponentName', width: 50 },

                    { display: '类别', name: 'Cname', width: 120 },

                     {
                         display: '主材￥', name: 'zc_price', type: 'float', width: 50, align: 'right', render: function (item) {
                             return "<div style='color:#135294'>" + item.zc_price + "</div>";
                         }
                     }, {
                         display: '辅材￥', name: 'fc_price', type: 'float', width: 50, align: 'right', render: function (item) {
                             return "<div style='color:#135294'>" + item.fc_price + "</div>";
                         }
                     }, {
                         display: '人工￥', name: 'rg_price', type: 'float', width: 50, align: 'right', render: function (item) {
                             return "<div style='color:#135294'>" + item.rg_price + "</div>";
                         }
                     },
                     {
                         display: '总价￥', name: 'TotalPrice', type: 'float', width: 50, align: 'right'
                     },
                     {
                         display: "数量", name: "SUM", type: "float", align: "right", width: 60,
                         editor: { type: "float" },
                         totalSummary: {
                             //type:'sum,count,max,min,avg'
                             render: function (suminf, column) {
                                 return "<span style='color:red'>" + suminf.sum.toFixed(2) + "</span>";
                             }
                         }
                     },
                     
                        {
                            display: "金额￥", name: "je", type: "float", width: 50, align: 'right',
                            totalSummary: {
                                //type:'sum,count,max,min,avg'
                                render: function (suminf, column) {
                                    return "<span style='color:red'>" + suminf.sum.toFixed(2) + "</span>";
                                }
                            }
                        },
                                { display: '单位', name: 'unit', width: 40 },
                             { display: '类型', name: 'C_style', width: 40 },
                        {
                            display: '工艺说明', name: 'proremarks', align: 'left', width: 100, render: function (item) {
                                var html = "<div class='abc'>";
                                if (item.proremarks)
                                    html += item.proremarks;
                                html += "</div>";
                                return html;
                            }
                        },
                        {
                            display: "排序顺序", name: "OrderBy", type: "int", align: "right", width: 60,
                            editor: { type: "int" }

                        }
                         ],
                         enabledEdit: true, isScroll: true,
                         rownumbers: true,
                         dataAction: 'server',
                         url: "../../data/Budge.ashx?Action=griddetail&bid=" + bid + "&compname=" + escape(bjmc) + "&rnd=" + Math.random(),
                         pageSize: 20,
                         pageSizeOptions: [20, 30, 50, 100],
                         heightDiff: -1,
                         onBeforeSubmitEdit: f_onBeforeSubmitEdit,
                         onAfterEdit: f_onAfterEdit,
                         onAfterShowData: function (grid) {
                             $(".abc").hover(function (e) {
                                 $(this).ligerTip({ content: $(this).text(), width: 200, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                             }, function (e) {
                                 $(this).ligerHideTip(e);
                             });
                         },
                         height: '100%',
                         width: '100%' 
                   


                 });

                 $(document).bind('keydown.grid', function (event) {
                     if (event.keyCode == 9) //enter,也可以改成9:tab
                     {
                         g.endEditToNext();
                     }
                 });
               
         }


         function fload() {
             var manager = $("#maingrid4").ligerGetGridManager();
             manager.loadData(true);

         }
     </script>

 </head>
    <body style="padding: 0px;overflow:hidden;">
    <form id="form1" onsubmit="return false">
   
            <div id="divcenter" position="center">
           
                <div id="maingrid4" style="margin: -1px;"></div>
            </div>
        
  </form>
   
</body>
</html>
