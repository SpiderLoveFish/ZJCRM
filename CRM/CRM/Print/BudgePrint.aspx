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
               url: "../../data/Budge.ashx", /* ע���������ֶ�ӦCS�ķ������� */
               data: { Action: 'gridrate', bid: oaid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
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

                       item =  data['RateName']+":����"+ (data['rate']*100)+"% ���ã�" + data['RateAmount'].toFixed(2) +";"
                   
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
               url: "../../data/sys_info.ashx", /* ע���������ֶ�ӦCS�ķ������� */
               data: { Action: 'grid', rnd: Math.random() }, /* ע������ĸ�ʽ������ */
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {
                   var obj = eval(result);
                   var rows = obj.Rows;

                   //alert(obj.constructor); //String ���캯��
                   $("#T_logo").html(rows[1].sys_value);
                   $("#T_logo_2").html(rows[1].sys_value);
                   $("#logo").attr("src", "../../" + rows[2].sys_value);
               }
           });
       }


       function loadHead(oaid) {
           $.ajax({
               type: "GET",
               url: "../../data/Budge.ashx", /* ע���������ֶ�ӦCS�ķ������� */
               data: { Action: 'form', bid: oaid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
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
                   if (obj.gender =='��') { itemgender = "����" }
                   else { itemgender = "Ůʿ"; }
                   $("#T_gender").append(itemgender);

                   var itemDetailDiscount="";
                   if (obj.DetailDiscount < 1) { itemDetailDiscount = "�ۿۣ�" + obj.DetailDiscount*10+"��" }
                   else { itemDetailDiscount = ""; }
                   $("#T_DetailDiscount").append(itemDetailDiscount);
                   var itemDiscountAmount = "";
                   if (obj.DetailDiscount < 1) { itemDiscountAmount = "�ۺ��" + ((obj.BudgetAmount + obj.FJAmount) * obj.DetailDiscount).toFixed(2) }
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
               url: "../../data/Budge.ashx", /* ע���������ֶ�ӦCS�ķ������� */
               data: { Action: 'griddetail', pagesize: 999, bid: oaid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {
                   var obj = result.Rows;
                   var item = ""; var cn = ""; var sum = 0;
                   $.each(obj, function (i, data) {

                       if (data['SUM'] == null) sum = 0;
                       else sum = data['SUM'];
                       if (data['ComponentName'] != cn) {
                           item = "<tr><td align='left' colspan='9' ><font size='2' ><b>&nbsp;&nbsp;" + data['ComponentName'] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(�ϼƣ�" + data['BwSubTotal'] + ")</b></font></td></tr>"
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
               url: "../../data/Budge.ashx", /* ע���������ֶ�ӦCS�ķ������� */
               data: { Action: 'formprint', bid: oaid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
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
               url: "../../data/Budge.ashx", /* ע���������ֶ�ӦCS�ķ������� */
               data: { Action: 'formprintdescr', id: oaid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
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
           LODOP.PRINT_INIT("��ҳ��ӡ�ۺϱ��");
           LODOP.ADD_PRINT_RECT("0%", "0%", "100%", "100%", 0, 1);//����
           LODOP.SET_PRINT_PAGESIZE(2, 0, 0, "A4");
           var strStyle = " <style> table,td,th {border-width: 1px;border-style: solid;border-collapse: collapse}</style>"
           LODOP.ADD_PRINT_HTM(90, "5%", "90%", 314, strStyle + document.getElementById("div2").innerHTML);

           LODOP.SET_PRINT_STYLEA(0, "Vorient", 3);
           LODOP.ADD_PRINT_TABLE(100, "5%", "90%", 314, document.getElementById("div3").innerHTML);
           LODOP.SET_PRINT_STYLEA(0, "ItemType", 0);
           LODOP.SET_PRINT_STYLEA(0, "LinkedItem", 1);
          
           //����ֻ�����һҳ��
           LODOP.ADD_PRINT_HTM(26, "5%", "90%", 54, document.getElementById("div4").innerHTML);
           LODOP.SET_PRINT_STYLEA(0, "ItemType", 0);
           LODOP.SET_PRINT_STYLEA(0, "LinkedItem", 2);



           LODOP.ADD_PRINT_HTM(26, "5%", "90%", 109, document.getElementById("div1").innerHTML);   
           LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);

           //LODOP.SET_PRINT_STYLEA(0, "LinkedItem", 1);//ȥ����ÿҳ����
           //����ÿҳ����
           //LODOP.ADD_PRINT_HTM(344, "5%", "90%", 54, document.getElementById("div4").innerHTML);
           //LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);
           //LODOP.SET_PRINT_STYLEA(0, "LinkedItem",2);

           LODOP.ADD_PRINT_HTM(1, 600, 300, 100, "<font color='#0000ff' format='ChineseNum'><span tdata='pageNO'>��##ҳ</span>/<span tdata='pageCount'>��##ҳ</span></font>");

           LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);

           LODOP.SET_PRINT_STYLEA(0, "Horient", 1);
           //LODOP.ADD_PRINT_TEXT(3,34,196,20,"��ҳü������������������ʾ��");
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
 <p><a href="javascript:PreviewMytable();">��ӡ</a>
</p>

         <div id="div1">
<DIV style="LINE-HEIGHT: 30px"  align="center">  <table width="100%"  border=0 cellSpacing=0 cellPadding=0>
    <tr>
      <td  width="20%" align="left"><img id="logo" alt="" style="height: 42px; margin-left: 5px; margin-top: 2px;" /></td>
      <td width="60%" align="center"><STRONG><font size="5" ><span id="T_BudgetName"></span></font></STRONG>

  <!--<STRONG><font size="6" >Ԥ���嵥 </font></STRONG>-->

      </td>
      <td  width="20%"  align="right"><strong><font size="2"><span id="T_logo"></span>��<SPAN id="T_pid" ></SPAN> ��</font></strong></td>
    </tr>
    <tr>
      <td colspan="3" align="left"><hr /></td>
      </tr>
  </table>
</DIV>  

    
<TABLE  border=0 cellSpacing=0 cellPadding=0 width="100%">
<%--  <TBODY>
  
  <TR>
     <TD width="35%" colspan="2"  ><font >�ͻ�:<SPAN id="T_kh" ></SPAN></font></TD>
    <TD  width="30%"><font >�绰�� <SPAN id="T_tel" ></SPAN></font></TD>
    <TD width="35%" ><font >���ʦ��<SPAN id="T_sjs"></SPAN></font></TD></TR>
   
      </TR>
      <TR>
    <TD width="25%"  ><font >�ܽ��:<SPAN id="T_zje" ></SPAN></font></TD>
          <TD  width="25%"></TD>
    <TD  width="25%"><font > <SPAN id="T_DetailDiscount" ></SPAN></font></TD>
    <TD width="25%" ><font ><SPAN id="T_DiscountAmount"></SPAN></font></TD>
  
      </TR>
      </TBODY>--%></TABLE>
</div>
<%--<p>----------------------div2:------------------------------------------------------------------------------------</p>--%>
<div id="div2"><table width="100%" cellSpacing=0 cellPadding=0 border=0 >
    <tr>
      <td > <p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�𾴵�<SPAN  style="color:blue" id="T_kh" ></SPAN><SPAN id="T_gender" ></SPAN>�����ã����ȷǳ���л�������ǵ����β�ѡ��<span id="T_logo_2"></span>Ϊ��װ�ޣ�����Ϊ���ṩ���İ���-<SPAN style="color:blue" id="T_address" ></SPAN>��װ��Ԥ�㣬�������ʦ<SPAN style="color:blue" id="T_sjs" ></SPAN>���ҵ���ϵ�绰��<SPAN  style="color:blue" id="T_sjstel" ></SPAN>,�����κ�������µ���ѯ��������ϵ�绰��<SPAN  style="color:blue" id="T_tel" ></SPAN>,�����ڼ����ǽ���ʱ�����㱨���ȡ�<br>
          <br>
          �˷�Ԥ����ܽ���Ϊ��������ɣ����ϡ��˹��븽�ӷ���   
     </p><p>
          &nbsp;1�������˹�����Ϊ<SPAN  style="color:blue" id="T_clje" ></SPAN>Ԫ<br>
          &nbsp;2�����Ҹ��ӷ���Ϊ<SPAN  style="color:blue" id="T_fjje" ></SPAN>Ԫ (<SPAN  style="font-size:10px" id="T_table3" ></SPAN>) <br>
          &nbsp;3������ϼƷ���Ϊ<SPAN  style="color:blue" id="T_zje" ></SPAN>Ԫ <br>
      
     </p>
�����Ƿֲ�λ�Ĳ����˹����ܽ�</td>
        </tr>
<tr>
 <td valign="top" >
<TABLE   class="table2 table-striped table-bordered table-condensed"border=1 cellSpacing=0 cellPadding=1 width="80%" style="border-collapse:collapse;font-size:15px" bordercolor="#333333">
<thead>
  <TR>
     <TD width="10%">
      <DIV align=center><b>��λ</b></DIV></TD>
    <!--<TD width="10%">
      <DIV align=center><b>��Ʒ����</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>������</b></DIV></TD>-->
    <TD width="10%">
      <DIV align=center><b>����С��</b></DIV></TD>
        <TD width="10%">
      <DIV align=center><b>����С��</b></DIV></TD>
    <TD width="10%">
          <DIV align=center><b>�˹�С��</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>�ܽ��</b></DIV></TD>
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
      <DIV align=center><b>���ӷ���</b></DIV></TD>
    <!--<TD width="10%">
      <DIV align=center><b>��Ʒ����</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>������</b></DIV></TD>-->
    </TR>
        <tr>
          <TD width="10%">
      <DIV align=center><b>������Ŀ</b></DIV></TD>
    <!--<TD width="10%">
      <DIV align=center><b>��Ʒ����</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>������</b></DIV></TD>-->
    <TD width="10%">
      <DIV align=center><b>����</b></DIV></TD>
        <TD width="10%">
          <DIV align=center><b>���</b></DIV></TD>
    </TR>
</thead>      
  <TBODY>      
 
  <tfoot>
  <tr>
   
    <TD ><b>�ϼ�</b></TD>
    
	   
	<TD width="14%" align="right">��</TD>
	<TD width="19%" tdata="allSum" format="#,##0.00" align="right"><font color="#0000FF">###Ԫ</font></TD>    
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
      <DIV align=center><b>��Ŀ����</b></DIV></TD>
  
       <TD width="7%">
      <DIV align=center><b>���ģ�</b></DIV></TD>
             <TD width="7%">
      <DIV align=center><b>���ģ�</b></DIV></TD>
             <TD width="7%">
      <DIV align=center><b>�˹���</b></DIV></TD>
             <TD width="7%">
      <DIV align=center><b>С�ƣ�</b></DIV></TD>
    <TD width="7%">
      <DIV align=center><b>����</b></DIV></TD>
    
    <TD width="7%">
      <DIV align=center><b>��</b></DIV></TD>
      <TD width="7%">

      <DIV align=center><b>��λ</b></DIV></TD>
       <TD width="31%">
      <DIV align=center><b>���ϼ�����˵��</b></DIV></TD>
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
          <td >�����ˣ�	</td> <td><SPAN id="T_bzr" ></SPAN>	</td>
           <td>����ˣ�	</td> <td><SPAN id="T_shr" ></SPAN>	</td>
           <td colspan="2">��Ч���ڣ�<SPAN id="T_sxrq" ></SPAN>	</td>
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
            
<td>  <DIV align=center><b>��ע˵��</b></DIV> 
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
