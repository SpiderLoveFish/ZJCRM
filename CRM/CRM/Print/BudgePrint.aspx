<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
   <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    
   <script src="LodopFuncs.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
   <script>
       $(function () {

           $("#T_pid").html(getparastr("bid"));
           loadHead(getparastr("bid"));
           loadFormPrint(getparastr("bid"));
           loadBody(getparastr("bid"));
       });


       function loadHead(oaid) {
           $.ajax({
               type: "GET",
               url: "../../data/Budge.ashx", /* 注意后面的名字对应CS的方法名称 */
               data: { Action: 'form', bid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {
                   var obj = eval(result);
                   for (var n in obj) {
                       if (obj[n] == "null" || obj[n] == null)
                           obj[n] = "";
                   }

                   $("#T_kh").html(obj.CustomerName);
                    $("#T_tel").html(obj.tel);
                    $("#T_sjs").html(obj.sjs);
                    $("#T_zje").html(obj.BudgetAmount);
                    $("#T_fjje").html(obj.AdditionalCost);
                    $("#T_zcje").html(obj.ZCAmount);
                    $("#T_jjje").html(obj.JJAmount);
                    $("#T_bzr").html();
                    $("#T_shr").html();
                    $("#T_sxrq").html(formatTimebytype(obj.ConfirmDate, 'yyyy-MM-dd'));
                  

               },
               error: function (XMLHttpRequest, textStatus, errorThrown) {
                   alert(textStatus);
               }
           });
       }

       function loadBody(oaid) {
           $.ajax({
               type: "GET",
               url: "../../data/Budge.ashx", /* 注意后面的名字对应CS的方法名称 */
               data: { Action: 'griddetail', bid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {
                   var obj = result.Rows;
                   var item;
                   $.each(obj, function (i, data) {

                       item = "<tr><td>" + data['Cname'] + "</td><td>" + data['Cname'] + "</td><td>" + data['TotalPrice'] + "</td><td>" + data['SUM'] + "</td> "
                           + " <td>" + data['je'] + "</td><td>" + data['unit'] + "</td> <td>" + data['C_style'] + "</td>"
                           + " </tr>";
                       $('.table1').append(item);

                   });
               },
               error: function (XMLHttpRequest, textStatus, errorThrown) {
                   alert(textStatus);
               }
           })
       }

       function loadFormPrint(oaid) {
           $.ajax({
               type: "GET",
               url: "../../data/Budge.ashx", /* 注意后面的名字对应CS的方法名称 */
               data: { Action: 'formprint', bid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {
                   var obj = result.Rows;
                   var item;
                   $.each(obj, function (i, data) {

                       item = "<tr><td>" + data['ComponentName'] + "</td><td>" + data['zl'] + "</td><td>" + data['zsl'] + "</td> "
                           + " <td>" + data['zje'] + "</td><td>" + data['zcje'] + "</td> <td>" + data['jcje'] + "</td>"
                           + " </tr>";
                       $('.table').append(item);

                   });
               },
               error: function (XMLHttpRequest, textStatus, errorThrown) {
                   alert(textStatus);
               }
           })
       }


       function PreviewMytable() {
           var LODOP = getLodop();
           LODOP.PRINT_INIT("分页打印综合表格");
           LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");
           var strStyle = "<style> table,td,th {border-width: 1px;border-style: solid;border-collapse: collapse}</style>"
           LODOP.ADD_PRINT_TABLE(128, "5%", "90%", 314,  document.getElementById("div2").innerHTML);
           LODOP.SET_PRINT_STYLEA(0, "Vorient", 3);
           LODOP.ADD_PRINT_TABLE(228, "5%", "90%", 314, strStyle + document.getElementById("div3").innerHTML);
           LODOP.SET_PRINT_STYLEA(0, "Vorient", 3);
           LODOP.ADD_PRINT_HTM(26, "5%", "90%", 109, document.getElementById("div1").innerHTML);
           LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);
           LODOP.SET_PRINT_STYLEA(0, "LinkedItem", 1);
           LODOP.ADD_PRINT_TABLE(544, "5%", "90%", 54, document.getElementById("div4").innerHTML);
           LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);
           LODOP.SET_PRINT_STYLEA(0, "LinkedItem", 1);
            
           LODOP.ADD_PRINT_HTM(1, 600, 300, 100, "<font color='#0000ff' format='ChineseNum'><span tdata='pageNO'>第##页</span>/<span tdata='pageCount'>共##页</span></font>");

           LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);

           LODOP.SET_PRINT_STYLEA(0, "Horient", 1);
           //LODOP.ADD_PRINT_TEXT(3,34,196,20,"总页眉：《两个发货单的演示》");
           LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);
           LODOP.PREVIEW();
       };
    </script>
</head>
<body style="padding: 0px;overflow:hidden;">
    <form id="form1" onsubmit="return false">
 <p><a href="javascript:PreviewMytable();">预览打印</a>
</p>

         <div id="div1">
<DIV style="LINE-HEIGHT: 30px" class=size16 align=center><STRONG><font >心成装饰预算清单 （<SPAN id="T_pid" ></SPAN> ）</font></STRONG></DIV>        
<TABLE  border=0 cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
  
  <TR>
     <TD width="35%" colspan="2"  ><font >客户:<SPAN id="T_kh" ></SPAN></font></TD>
    <TD  width="30%"><font >电话： <SPAN id="T_tel" ></SPAN></font></TD>
    <TD width="35%" ><font >设计师：<SPAN id="T_sjs"></SPAN></font></TD></TR>
   
      </TR>
      <TR>
    <TD width="25%"  ><font >总金额:<SPAN id="T_zje" ></SPAN></font></TD>
    <TD  width="25%"><font >基建金额： <SPAN id="T_jjje" ></SPAN></font></TD>
    <TD width="25%" ><font >主材金额：<SPAN id="T_zcje"></SPAN></font></TD>
  <TD  width="25%"><font >附加金额： <SPAN id="T_fjje" ></SPAN></font></TD>

      </TR>
      </TBODY></TABLE>
</div>
<p>----------------------div2:------------------------------------------------------------------------------------</p>
<div id="div2">

<TABLE   class="table table-striped table-bordered table-condensed"border=1 cellSpacing=0 cellPadding=1 width="100%" style="border-collapse:collapse" bordercolor="#333333">
<thead>
  <TR>
     <TD width="10%">
      <DIV align=center><b>部位</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>产品种类</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>总数量</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>基建金额</b></DIV></TD>
        <TD width="10%">
      <DIV align=center><b>主材金额</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>总金额</b></DIV></TD>
     </TR>
</thead>      
  <TBODY>      
 
  <tfoot>
  
      
  </tfoot>
</TABLE>
</div>
<p>----------------------div3:------------------------------------------------------------------------------------</p>
<div id="div3">
  <TABLE   class="table1 table-striped table-bordered table-condensed"border=1 cellSpacing=0 cellPadding=1 width="100%" style="border-collapse:collapse" bordercolor="#333333">
<thead>
  <TR>
  
    <TD width="20%">
      <DIV align=center><b>产品名称</b></DIV></TD>
    <TD width="20%">
      <DIV align=center><b>规格/型号/品牌		</b></DIV></TD>
       <TD width="10%">
      <DIV align=center><b>单价</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>数量</b></DIV></TD>
    
    <TD width="10%">
      <DIV align=center><b>金额</b></DIV></TD>
      <TD width="10%">
      <DIV align=center><b>单位</b></DIV></TD>
       <TD width="10%">
      <DIV align=center><b>类型</b></DIV></TD>
     </TR>
</thead>      
  <TBODY>      
 
  <tfoot>
  
      
  </tfoot>
</TABLE>
</div>
   <p>----------------------div4:------------------------------------------------------------------------------------</p>
  <div id="div4">

  <TABLE  border=0 cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
      <tr>
          <td>编制人：	</td> <td><SPAN id="T_bzr" ></SPAN>	</td>
           <td>审核人：	</td> <td><SPAN id="T_shr" ></SPAN>	</td>
           <td colspan="2">生效日期：<SPAN id="T_sxrq" ></SPAN>	</td>
<td></td>
      </tr>
      </TBODY>
  </TABLE>
      </div>
    </form>
</body>
</html>
