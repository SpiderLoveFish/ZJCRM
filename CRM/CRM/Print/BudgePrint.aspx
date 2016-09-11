<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   
   <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    
   <script src="LodopFuncs.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
   <script>
       $(function () {

           $("#T_pid").html(getparastr("bid"));
           loadHead(getparastr("bid"));
           loadFormPrint(getparastr("bid"));
           loadBody(getparastr("bid"));
           loadlogo();
           loadfjf(getparastr("bid"));
           if (getparastr("selectid") == null || getparastr("selectid") == "" || getparastr("selectid") == "null" || getparastr("selectid") == undefined)
           { }
           else
           loadbz(getparastr("selectid"));
       });


     
       function loadfjf(oaid) {
           $.ajax({
               type: "GET",
               url: "../../data/Budge.ashx", /* 注意后面的名字对应CS的方法名称 */
               data: { Action: 'gridrate', bid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {
                   var obj = result.Rows;
                   var item = "";
                   $.each(obj, function (i, data) {

                       item = "<tr><td>" + data['RateName'] + "</td> "
                           + " <td  align='right'>" + data['rate'].toFixed(2) + "</td> <td  align='right'>" + data['RateAmount'].toFixed(2) + "</td>"
                           + " </tr>";
                       $('.table3').append(item);

                                    

                   });
                   $.each(obj, function (i, data) {

                       item =  data['RateName']+":费率"+ (data['rate']*100)+"% 费用：" + data['RateAmount'].toFixed(2) +";"
                   
                       $('#T_table3').append(item);



                   });
                  
               },
               error: function (XMLHttpRequest, textStatus, errorThrown) {
                   alert(textStatus);
               }
           })
       }

       function loadlogo() {
           $.ajax({
               type: "GET",
               url: "../../data/sys_info.ashx", /* 注意后面的名字对应CS的方法名称 */
               data: { Action: 'grid', rnd: Math.random() }, /* 注意参数的格式和名称 */
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {
                   var obj = eval(result);
                   var rows = obj.Rows;

                   //alert(obj.constructor); //String 构造函数
                   $("#T_logo").html(rows[1].sys_value);
                   $("#T_logo_2").html(rows[1].sys_value);
                   $("#logo").attr("src", "../../" + rows[2].sys_value);
               }
           });
       }


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
                   $("#T_address").html(obj.address);
                   $("#T_tel").html(obj.tel);
                   $("#T_sjs").html(obj.sjs);
                   $("#T_zje").html((obj.BudgetAmount + obj.FJAmount).toFixed(2));
                   $("#T_clje").html((obj.BudgetAmount).toFixed(2));
                   $("#T_fjje").html((obj.FJAmount).toFixed(2));
                   $("#T_zcje").html(obj.ZCAmount.toFixed(2));
                   $("#T_jjje").html(obj.JJAmount.toFixed(2));
                   $("#T_bzr").html();
                   $("#T_shr").html();
                   $("#T_sxrq").html(formatTimebytype(obj.ConfirmDate, 'yyyy-MM-dd'));
                   $("#T_Remarks").html(obj.Remarks);
                   $("#T_BudgetName").html(obj.BudgetName);
                   $("#T_sjstel").html(obj.sjstel);
                   var itemgender = "";
                   if (obj.gender =='男') { itemgender = "先生" }
                   else { itemgender = "女士"; }
                   $("#T_gender").append(itemgender);

                   var itemDetailDiscount="";
                   if (obj.DetailDiscount < 1) { itemDetailDiscount = "折扣：" + obj.DetailDiscount*10+"折" }
                   else { itemDetailDiscount = ""; }
                   $("#T_DetailDiscount").append(itemDetailDiscount);
                   var itemDiscountAmount = "";
                   if (obj.DetailDiscount < 1) { itemDiscountAmount = "折后金额：" + ((obj.BudgetAmount + obj.FJAmount) * obj.DetailDiscount).toFixed(2) }
                   else { itemDiscountAmount = ""; }
                   $("#T_DiscountAmount").append(itemDiscountAmount);
                   

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
               data: { Action: 'griddetail', pagesize: 999, bid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {
                   var obj = result.Rows;
                   var item = ""; var cn = ""; var sum = 0;
                   $.each(obj, function (i, data) {

                       if (data['SUM'] == null) sum = 0;
                       else sum = data['SUM'];
                       if (data['ComponentName'] != cn) {
                           item = "<tr><td align='left' colspan='9' ><font size='2' ><b>&nbsp;&nbsp;" + data['ComponentName'] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(合计：" + data['BwSubTotal'] + ")</b></font></td></tr>"
                           + "<tr><td >"+ data['brand'] + "</td><td align='right'>" + data['zc_price'].toFixed(2) + "</td><td align='right'>" + data['fc_price'].toFixed(2) + "</td><td align='right'>" + data['rg_price'].toFixed(2) + "</td><td align='right'>" + data['TotalPrice'].toFixed(2) + "</td><td align='right'>" + sum.toFixed(2) + "</td> "
                               + " <td align='right'>" + data['je'].toFixed(2) + "</td><td>" + data['unit'] + "</td> <td>" + data['proremarks'].replace(/\n|\r|(\r\n)|(\u0085)|(\u2028)|(\u2029)/g, "<br>") + "</td>"
                               + " </tr>";
                       }
                       else {
                           item = "<tr><td>" + data['brand'] + "</td><td align='right'>" + data['zc_price'].toFixed(2) + "</td><td align='right'>" + data['fc_price'].toFixed(2) + "</td><td align='right'>" + data['rg_price'].toFixed(2) + "</td><td align='right'>" + data['TotalPrice'].toFixed(2) + "</td><td align='right'>" + sum.toFixed(2) + "</td> "
                               + " <td align='right'>" + data['je'].toFixed(2) + "</td><td>" + data['unit'] + "</td> <td>" + data['proremarks'].replace(/\n|\r|(\r\n)|(\u0085)|(\u2028)|(\u2029)/g, "<br>") + "</td>"
                               + " </tr>";
                       }
                       $('.table1').append(item);
                       cn = data['ComponentName'];
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
                   var item; var zcje = 0;
                   $.each(obj, function (i, data) {
                       if (data['zcje'] == null) zcje = 0;
                       else zcje = data['zcje'];
                       item = "<tr><td>" + data['ComponentName'] + "</td> "
                           + " <td  align='right'>" + data['zc_zje'].toFixed(2) + "</td><td  align='right'>" + data['fc_zje'].toFixed(2) + "</td> <td  align='right'>" + data['rg_zje'].toFixed(2) + "</td> <td  align='right'>" + data['zje'].toFixed(2) + "</td>"
                           + " </tr>";
                       $('.table2').append(item);

                   });
               },
               error: function (XMLHttpRequest, textStatus, errorThrown) {
                   alert(textStatus);
               }
           })
       }


       function loadbz(oaid) {
   
           $.ajax({
               type: "GET",
               url: "../../data/Budge.ashx", /* 注意后面的名字对应CS的方法名称 */
               data: { Action: 'formprintdescr', id: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {
                   var obj = eval(result);
                   for (var n in obj) {
                       if (obj[n] == "null" || obj[n] == null)
                           obj[n] = "";
                   }
               
                   $("#T_bzsm").html(obj.DescribeName);

               },
               error: function (XMLHttpRequest, textStatus, errorThrown) {
                   alert(textStatus);
               }
           });
       }

       function PreviewMytable() {
           var LODOP = getLodop();
           LODOP.PRINT_INIT("分页打印综合表格");
           LODOP.ADD_PRINT_RECT("0%", "0%", "100%", "100%", 0, 1);//满屏
           LODOP.SET_PRINT_PAGESIZE(2, 0, 0, "A4");
           var strStyle = " <style> table,td,th {border-width: 1px;border-style: solid;border-collapse: collapse}</style>"
           LODOP.ADD_PRINT_HTM(90, "5%", "90%", 314, strStyle + document.getElementById("div2").innerHTML);

           LODOP.SET_PRINT_STYLEA(0, "Vorient", 3);
           LODOP.ADD_PRINT_TABLE(100, "5%", "90%", 314, document.getElementById("div3").innerHTML);
           LODOP.SET_PRINT_STYLEA(0, "ItemType", 0);
           LODOP.SET_PRINT_STYLEA(0, "LinkedItem", 1);
          
           //这样只有最后一页有
           LODOP.ADD_PRINT_HTM(26, "5%", "90%", 54, document.getElementById("div4").innerHTML);
           LODOP.SET_PRINT_STYLEA(0, "ItemType", 0);
           LODOP.SET_PRINT_STYLEA(0, "LinkedItem", 2);



           LODOP.ADD_PRINT_HTM(26, "5%", "90%", 109, document.getElementById("div1").innerHTML);   
           LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);

           //LODOP.SET_PRINT_STYLEA(0, "LinkedItem", 1);//去掉就每页都有
           //这样每页都有
           //LODOP.ADD_PRINT_HTM(344, "5%", "90%", 54, document.getElementById("div4").innerHTML);
           //LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);
           //LODOP.SET_PRINT_STYLEA(0, "LinkedItem",2);

           LODOP.ADD_PRINT_HTM(1, 600, 300, 100, "<font color='#0000ff' format='ChineseNum'><span tdata='pageNO'>第##页</span>/<span tdata='pageCount'>共##页</span></font>");

           LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);

           LODOP.SET_PRINT_STYLEA(0, "Horient", 1);
           //LODOP.ADD_PRINT_TEXT(3,34,196,20,"总页眉：《两个发货单的演示》");
           LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);
           LODOP.SET_SHOW_MODE("LANDSCAPE_DEFROTATED", 1);


           LODOP.NewPageA();

           LODOP.ADD_PRINT_HTM("12%", "5%", "90%", "90%", document.getElementById("div5").innerHTML);

           LODOP.PREVIEW();
       };
    </script>
     <title id="T_id"></title>
</head>
<body style="padding: 0px;overflow:hidden;">
    <form id="form1" onsubmit="return false">
 <p><a href="javascript:PreviewMytable();">打印</a>
</p>

         <div id="div1">
<DIV style="LINE-HEIGHT: 30px"  align="center">  <table width="100%"  border=0 cellSpacing=0 cellPadding=0>
    <tr>
      <td  width="20%" align="left"><img id="logo" alt="" style="height: 42px; margin-left: 5px; margin-top: 2px;" /></td>
      <td width="60%" align="center"><STRONG><font size="5" ><span id="T_BudgetName"></span></font></STRONG>

  <!--<STRONG><font size="6" >预算清单 </font></STRONG>-->

      </td>
      <td  width="20%"  align="right"><strong><font size="2"><span id="T_logo"></span>（<SPAN id="T_pid" ></SPAN> ）</font></strong></td>
    </tr>
    <tr>
      <td colspan="3" align="left"><hr /></td>
      </tr>
  </table>
</DIV>  

    
<TABLE  border=0 cellSpacing=0 cellPadding=0 width="100%">
<%--  <TBODY>
  
  <TR>
     <TD width="35%" colspan="2"  ><font >客户:<SPAN id="T_kh" ></SPAN></font></TD>
    <TD  width="30%"><font >电话： <SPAN id="T_tel" ></SPAN></font></TD>
    <TD width="35%" ><font >设计师：<SPAN id="T_sjs"></SPAN></font></TD></TR>
   
      </TR>
      <TR>
    <TD width="25%"  ><font >总金额:<SPAN id="T_zje" ></SPAN></font></TD>
          <TD  width="25%"></TD>
    <TD  width="25%"><font > <SPAN id="T_DetailDiscount" ></SPAN></font></TD>
    <TD width="25%" ><font ><SPAN id="T_DiscountAmount"></SPAN></font></TD>
  
      </TR>
      </TBODY>--%></TABLE>
</div>
<%--<p>----------------------div2:------------------------------------------------------------------------------------</p>--%>
<div id="div2"><table width="100%" cellSpacing=0 cellPadding=0 border=0 >
    <tr>
      <td > <p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;尊敬的<SPAN  style="color:blue" id="T_kh" ></SPAN><SPAN id="T_gender" ></SPAN>，您好，首先非常感谢您对我们的信任并选择<span id="T_logo_2"></span>为您装修，现在为您提供您的爱家-<SPAN style="color:blue" id="T_address" ></SPAN>的装修预算，我是设计师<SPAN style="color:blue" id="T_sjs" ></SPAN>，我的联系电话是<SPAN  style="color:blue" id="T_sjstel" ></SPAN>,如有任何问题可致电咨询。您的联系电话是<SPAN  style="color:blue" id="T_tel" ></SPAN>,服务期间我们将及时向您汇报进度。<br>
          <br>
          此份预算的总金额分为两部分组成，材料、人工与附加费用   
     </p><p>
          &nbsp;1、材料人工费用为<SPAN  style="color:blue" id="T_clje" ></SPAN>元<br>
          &nbsp;2、您家附加费用为<SPAN  style="color:blue" id="T_fjje" ></SPAN>元 (<SPAN  style="font-size:10px" id="T_table3" ></SPAN>) <br>
          &nbsp;3、两项合计费用为<SPAN  style="color:blue" id="T_zje" ></SPAN>元 <br>
      
     </p>
下面是分部位的材料人工汇总金额。</td>
        </tr>
<tr>
 <td valign="top" >
<TABLE   class="table2 table-striped table-bordered table-condensed"border=1 cellSpacing=0 cellPadding=1 width="80%" style="border-collapse:collapse;font-size:15px" bordercolor="#333333">
<thead>
  <TR>
     <TD width="10%">
      <DIV align=center><b>部位</b></DIV></TD>
    <!--<TD width="10%">
      <DIV align=center><b>产品种类</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>总数量</b></DIV></TD>-->
    <TD width="10%">
      <DIV align=center><b>主材小计</b></DIV></TD>
        <TD width="10%">
      <DIV align=center><b>辅材小计</b></DIV></TD>
    <TD width="10%">
          <DIV align=center><b>人工小计</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>总金额</b></DIV></TD>
     </TR>
</thead>      
  <TBODY>      
 
  <tfoot>
  
      
  </tfoot>
</TABLE>
</td>
<%--<td  valign="top" width="50%">
    <TABLE   class="table3 table-striped table-bordered table-condensed" border=1 cellSpacing=0 cellPadding=1 width="99%" style="border-collapse:collapse;font-size:10px"; bordercolor="#333333" >
<thead>
  <TR>
     <TD colspan="3">
      <DIV align=center><b>附加费用</b></DIV></TD>
    <!--<TD width="10%">
      <DIV align=center><b>产品种类</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>总数量</b></DIV></TD>-->
    </TR>
        <tr>
          <TD width="10%">
      <DIV align=center><b>附加项目</b></DIV></TD>
    <!--<TD width="10%">
      <DIV align=center><b>产品种类</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>总数量</b></DIV></TD>-->
    <TD width="10%">
      <DIV align=center><b>费率</b></DIV></TD>
        <TD width="10%">
          <DIV align=center><b>金额</b></DIV></TD>
    </TR>
</thead>      
  <TBODY>      
 
  <tfoot>
  <tr>
   
    <TD ><b>合计</b></TD>
    
	   
	<TD width="14%" align="right">　</TD>
	<TD width="19%" tdata="allSum" format="#,##0.00" align="right"><font color="#0000FF">###元</font></TD>    
 </tr>

      
  </tfoot>
</TABLE>
    </td>--%>
    </tr>
    </table>
</div>
       
<%--<p>----------------------div3:------------------------------------------------------------------------------------</p>--%>
<div id="div3">
  <TABLE   class="table1 table-striped table-bordered table-condensed"border=1 cellSpacing=0 cellPadding=1 width="100%" style="border-collapse:collapse;font-size:9px" bordercolor="#333333">
<thead>
  <TR>
  
    <TD width="20%">
      <DIV align=center><b>项目名称</b></DIV></TD>
  
       <TD width="7%">
      <DIV align=center><b>主材￥</b></DIV></TD>
             <TD width="7%">
      <DIV align=center><b>辅材￥</b></DIV></TD>
             <TD width="7%">
      <DIV align=center><b>人工￥</b></DIV></TD>
             <TD width="7%">
      <DIV align=center><b>小计￥</b></DIV></TD>
    <TD width="7%">
      <DIV align=center><b>数量</b></DIV></TD>
    
    <TD width="7%">
      <DIV align=center><b>金额￥</b></DIV></TD>
      <TD width="7%">

      <DIV align=center><b>单位</b></DIV></TD>
       <TD width="31%">
      <DIV align=center><b>材料及工艺说明</b></DIV></TD>
     </TR>
</thead>      
  <TBODY>      
 
  <tfoot>
  
      
  </tfoot>
</TABLE>
</div>
   <%--<p>----------------------div4:------------------------------------------------------------------------------------</p>--%>
  <div id="div4">

  <TABLE  border=0 cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
      <tr>
          <td >编制人：	</td> <td><SPAN id="T_bzr" ></SPAN>	</td>
           <td>审核人：	</td> <td><SPAN id="T_shr" ></SPAN>	</td>
           <td colspan="2">生效日期：<SPAN id="T_sxrq" ></SPAN>	</td>
<td></td>
      </tr>
      </TBODY>
  </TABLE>
      </div>

          <%--<p>----------------------div5:------------------------------------------------------------------------------------</p>--%>
  <div id="div5">

  <TABLE  border=0 cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
      <tr>
            
<td>  <DIV align=center><b>备注说明</b></DIV> 
        <DIV>
            <SPAN id="T_bzsm" name="T_bzsm" ></SPAN>	

        </DIV>


</td>
      </tr>
      </TBODY>
  </TABLE>
      </div>
    </form>
</body>
</html>
