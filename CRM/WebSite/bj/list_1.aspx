<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   
   <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    
   
    <script src="../../JS/XHD.js" type="text/javascript"></script>
   <script>
       var jmid = "";
       var tel = "";
       var desid = "";
       $(function () {

           jmid=getparastr("jmid");
           tel = getparastr("tel");
           desid = getparastr("desid");
           loadBody(jmid, tel, desid);
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
                           + " <td  align='right'>" + (data['rate']*100).toFixed(2)+"%" + "</td> <td  align='right'>" +toMoney( data['RateAmount']) + "</td>"
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
                   $("#T_logo_3").html(rows[1].sys_value);
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
                   $("#T_kh_2").html(obj.CustomerName);
                   $("#T_address").html(obj.address);
                   $("#T_address_2").html(obj.address);
                   $("#T_tel").html(obj.tel);
                   $("#T_tel_2").html(obj.tel);
                   $("#T_sjs").html(obj.sjs);
                   $("#T_sjs_2").html(obj.sjs);
                   $("#T_zje").html(toMoney((obj.BudgetAmount + obj.FJAmount)));
                   $("#T_clje").html(toMoney((obj.BudgetAmount)));
                   $("#T_fjje").html(toMoney((obj.FJAmount)));
                   $("#T_zcje").html(obj.ZCAmount.toFixed(2));
                   $("#T_jjje").html(obj.JJAmount.toFixed(2));
                   $("#T_bzr").html();
                   $("#T_shr").html();
                   $("#T_sxrq").html(formatTimebytype(obj.ConfirmDate, 'yyyy-MM-dd'));
                   $("#T_Remarks").html(obj.Remarks);
                   $("#T_BudgetName").html(obj.BudgetName);
                   $("#T_sjstel").html(obj.sjstel);
                   $("#T_sjstel_2").html(obj.sjstel);
                   $("T_newdata").html(new Date());
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

       function loadBody(jmid, tel, desid) {
           $.ajax({
               type: "GET",
               url: "../../data/website.ashx", /* 注意后面的名字对应CS的方法名称 */
               data: { Action: 'griddetail', jmid: jmid, tel: tel,desid:desid, rnd: Math.random() }, /* 注意参数的格式和名称 */
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {
                   var obj = result.Rows;
                //  alert(JSON.stringify(result))
                   var item = ""; var cn = ""; var sum = 0;
                   $.each(obj, function (i, data) {
                      
                       if (data['hj'] == null) sum = 0;
                       else sum = data['hj'];
                       if (data['room'] != cn) {
                           //alert(JSON.stringify(data))
                           item = "<tr><td align='left' colspan='9' ><font size='3' ><b>&nbsp;&nbsp;" + data['room'] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(合计：" + data['hj'].toFixed(2) + ")</b></font></td></tr>"
                           + "<tr><td >" + data['name'] + "</td><td align='right'>" + data['price'] + "</td><td align='right'>" + toMoney(data['price']) + "</td><td align='right'>" + toMoney(data['price']) + "</td><td align='right'>" + data['price'] + "</td><td align='right'>" + toMoney(data['quantity'])   + "</td> "
                               + " <td align='right'>" + toMoney(data['price'] * data['quantity']) + "</td><td  align=center>" + data['type'] + "</td> <td>" + data['brandName'] + "</td>"
                               //.replace(/\n|\r|(\r\n)|(\u0085)|(\u2028)|(\u2029)/g, "<br>")
                               + " </tr>";
                       }
                       else {
                           item = "<tr><td>" + data['name'] + "</td><td align='right'>" + data['price'] + "</td><td align='right'>" + toMoney(data['price']) + "</td><td align='right'>" + toMoney(data['price']) + "</td><td align='right'>" + data['price'] + "</td><td align='right'>" + toMoney(data['quantity']) + "</td> "
                               + " <td align='right'>" + toMoney(data['price'] * data['quantity']) + "</td><td  align=center>" + data['type'] + "</td> <td>" + data['brandName'] + "</td>"
                               + " </tr>";
                       }
                       $('.table1').append(item);
                       cn = data['room'];
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
                           + " <td  align='right'>" + toMoney(data['zc_zje']) + "</td><td  align='right'>" + toMoney(data['fc_zje']) + "</td> <td  align='right'>" + toMoney(data['rg_zje']) + "</td> <td  align='right'>" + toMoney(data['zje']) + "</td>"
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
 
       
<%--<p>----------------------div3:---------------------------------------------------------------------------------font-size:12px---</p>--%>
<div id="div3">
  <TABLE   class="table1 table-striped table-bordered table-condensed"border=1 cellSpacing=0 cellPadding=1 width="100%" style="border-collapse:collapse;font-size:12px" bordercolor="#333333">
<thead>
  <TR>
  
    <TD width="20%">
      <DIV align=center><b>项目名称</b></DIV></TD>
  
       <TD width="5%">
      <DIV align=center><b>主材￥</b></DIV></TD>
             <TD width="5%">
      <DIV align=center><b>辅材￥</b></DIV></TD>
             <TD width="5%">
      <DIV align=center><b>人工￥</b></DIV></TD>
             <TD width="5%">
      <DIV align=center><b>小计￥</b></DIV></TD>
    <TD width="5%">
      <DIV align=center><b>数量</b></DIV></TD>
    
    <TD width="5%">
      <DIV align=center><b>金额￥</b></DIV></TD>
      <TD width="5%">

      <DIV align=center><b>单位</b></DIV></TD>
       <TD width="45%">
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
      <tr style="max-height:400px">
            
<td colspan="3">  <DIV align=center><b>备注说明</b></DIV> 
        <DIV>
            <SPAN id="T_bzsm" name="T_bzsm" ></SPAN>	

        </DIV>


</td>
      </tr>
      <tr>
        <td width="26%">客户签字：</td>
        <td width="31%">制作人：</td>
        <td width="43%">审核人：</td>
      </tr>
      <tr>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">年 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
      </tr>

      </TBODY>
  </TABLE>
      </div>
       
    </form>
</body>
</html>
