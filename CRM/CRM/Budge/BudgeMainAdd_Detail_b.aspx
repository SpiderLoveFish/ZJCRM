<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
 <title></title>
  
      <link href="../../jlui3.2/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
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
   <script type="text/javascript">
         var manager = ""; var g, ck;
         var bjmc, bid, gcombgys;
         $(function () {
            // $("form").ligerForm();

           //  $('input:checkbox').ligerCheckBox();
             bjmc = decodeURI(getparastr("bjmc"));
            // alert(bjmc)
             bid = getparastr("bid");
             
             //initLayout();
             //$(window).resize(function () {
             //    initLayout();
             //});
             loadGrid();

           //  alert(ck);
         });
         //获取参数
         function getparastr(strname) {
             var hrefstr, pos, parastr, para, tempstr;
             hrefstr = window.location.href;
             pos = hrefstr.indexOf("?")
             parastr = hrefstr.substring(pos + 1);
             para = parastr.split("&");
             tempstr = "";
             for (i = 0; i < para.length; i++) {
                 tempstr = para[i];
                 pos = tempstr.indexOf("=");
                 if (tempstr.substring(0, pos) == strname) {
                     return tempstr.substring(pos + 1);
                 }
             }
             return null;
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
                             { display: '类型', name: 'C_style', width: 40 }
                             , {
                                 display: "排序顺序", name: "OrderBy", type: "int", align: "right", width: 60,
                                 editor: { type: "int" }

                             }
                    
                         ],

                         enabledEdit: true, isScroll: true,
                         rownumbers: true,
                         dataAction: 'server',
                         url: "../../data/Budge.ashx?Action=griddetail&bid=" + bid + "&compname=" + bjmc + "&rnd=" + Math.random(),
                         pageSize: 20,
                         pageSizeOptions: [20, 30, 50, 100],
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

 
     </script>

 </head>
    <body style="padding: 0px;overflow:hidden;">
  
           
                <div id="maingrid4" style="margin: -1px;"></div>
          
</body>
</html>
