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
        
           $("#T_pid").html(getparastr("pid"));
           loadHead(getparastr("pid"));
           loadBody(getparastr("pid"));
           loadlogo();
       });


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
                   //$("#T_logo_2").html(rows[1].sys_value);
                   //$("#T_logo_3").html(rows[1].sys_value);
                   //$("#logo").attr("src", "../../" + rows[2].sys_value);
               }
           });
       }
       function loadHead(oaid) {
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
                 
                   $("#T_gys").html(obj.supplier_name);
                   //$("#T_tel").html(obj.tel);
                   $("#T_lxr").html(obj.materialman);
             
                   $("#T_gysdz").html(obj.gysdz);
                   $("#T_kh").html(obj.Customer + '(' + obj.tel + ')');
                   $("#T_khdz").html(obj.address);
                     $("#T_remarks").html(obj.remarks);
                   $("#T_rq").html(formatTimebytype(obj.purdate, 'yyyy-MM-dd'));
                   $("#T_qdrq").html(formatTimebytype(obj.ConfirmDate, 'yyyy-MM-dd'));
                   if (obj.IsGD=="1")
                       $("#T_shfs").html("直送客户");
                   else $("#T_shfs").html("送至公司");
                    
               },
               error: function (XMLHttpRequest, textStatus, errorThrown) {
                   alert(textStatus);
               }
           });
       }

       function loadBody(oaid) {
           $.ajax({
               type: "GET",
               url: "../../data/Purchase.ashx", /* 注意后面的名字对应CS的方法名称 */
               data: { Action: 'griddetail', pid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {
                   var obj = result.Rows;
                   var item = ""; var cn = "";  
  var snn=1;
                   $.each(obj, function (i, data) {
                  
                       if (data['customer'] != cn) {
                          snn =1
                            //alert(JSON.stringify(data))
                           item = "<tr><td align='left' colspan='7' ><font size='3' ><b>&nbsp;&nbsp;" + data['customer'] +"   施工监理："+ data['Emp_sg']+"</b></font></td></tr>"
                               + "<tr><td>"+snn+"</td><td> " + data['c_code'] + "</td><td>" + data['material_name'] + "</td><td>" + data['specifications'] + "</td><td align=right>" + data['pursum'] + "</td> "
                               + " <td align=center>" + data['unit'] + "</td><td>" + data['b1'] + "</td>"
                               + " </tr>";
                       }
                       else {
                    snn=snn+1;
                           item = "<tr><td>"+snn+"</td><td>" + data['c_code'] + "</td><td>" + data['material_name'] + "</td><td>" + data['specifications'] + "</td><td align=right>" + data['pursum'] + "</td> "
                               + " <td align=center>" + data['unit'] + "</td><td>" + data['b1'] + "</td>"
                               + " </tr>";
                       }
                      //<td>" + data['purprice'] + "</td> <td>" + data['subtotal'] + "</td>
                       $('.table').append(item); 
                     
                       cn = data['customer'];
                   });
                   //$.each(obj, function (i, data) {
                     
                   //    item = "<tr><td>" + data['material_id'] + "</td><td>" + data['material_name'] + "</td><td>" + data['specifications'] + "</td><td>" + data['pursum'] + "</td> "
                   //        + " <td>" + data['unit'] + "</td><td>" + data['purprice'] + "</td> <td>" + data['subtotal'] + "</td>"
                   //        + " </tr>";
                   //    $('.table').append(item); 
                   
                   //});
               },
               error: function (XMLHttpRequest, textStatus, errorThrown) {
                   alert(textStatus);
               }
           })
       }


       function PreviewMytable() {
		var LODOP=getLodop();  
		LODOP.PRINT_INIT("分页打印综合表格");
		//LODOP.ADD_PRINT_TEXT(13, 22, 295, 110, "心诚装饰");
		//LODOP.SET_PRINT_STYLEA(0, "FontColor", "#808080");
		//LODOP.SET_PRINT_STYLEA(0, "ItemType", 1);
		//LODOP.SET_PRINT_STYLEA(0, "Angle", 45);
           //LODOP.SET_PRINT_STYLEA(0, "Repeat", true);
		LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");
		var strStyle="<style> table,td,th {border-width: 1px;border-style: solid;border-collapse: collapse}</style>"
		LODOP.ADD_PRINT_TABLE(128,"5%","90%",314,strStyle+document.getElementById("div2").innerHTML);
		LODOP.SET_PRINT_STYLEA(0,"Vorient",3);		
		LODOP.ADD_PRINT_HTM(26,"5%","90%",109,document.getElementById("div1").innerHTML);
		LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
		LODOP.SET_PRINT_STYLEA(0,"LinkedItem",1);	
	    LODOP.ADD_PRINT_HTM(444,"5%","90%",54,document.getElementById("div3").innerHTML);
		LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
		LODOP.SET_PRINT_STYLEA(0,"LinkedItem",1);	
		//LODOP.NewPageA();
    	//	LODOP.ADD_PRINT_TABLE(128,"5%","90%",328,strStyle+document.getElementById("div2").innerHTML);
		//LODOP.SET_PRINT_STYLEA(0,"Vorient",3);	
		////LODOP.ADD_PRINT_HTM(26,"5%","90%",80,document.getElementById("div4").innerHTML);
		//LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
		//LODOP.SET_PRINT_STYLEA(0,"LinkedItem",4);	
		////LODOP.ADD_PRINT_TEXT(460,96,"76.25%",20," 祝您好远！");
		//LODOP.SET_PRINT_STYLEA(0,"LinkedItem",4);
		//LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
		//LODOP.SET_PRINT_STYLEA(0,"FontColor","#FF0000");
		//LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
		//LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
		//LODOP.SET_PRINT_STYLEA(0,"Horient",3);	
		LODOP.ADD_PRINT_HTM(1,600,300,100,"<font color='#0000ff' format='ChineseNum'><span tdata='pageNO'>第##页</span>/<span tdata='pageCount'>共##页</span></font>");

		LODOP.SET_PRINT_STYLEA(0,"ItemType",1);

		LODOP.SET_PRINT_STYLEA(0,"Horient",1);	
		//LODOP.ADD_PRINT_TEXT(3,34,196,20,"总页眉：《两个发货单的演示》");
		LODOP.SET_PRINT_STYLEA(0,"ItemType",1);		
		LODOP.PREVIEW();	
	};	
    </script>
</head>
<body style="padding: 0px;overflow:hidden;">
    <form id="form1" onsubmit="return false">
 <p><a href="javascript:PreviewMytable();">预览打印</a>
</p>

         <div id="div1">
<DIV style="LINE-HEIGHT: 30px" class=size16 align=center><STRONG><font ><span id="T_logo"></span>采购单 （<SPAN id="T_pid" ></SPAN> ）</font></STRONG></DIV>        
<TABLE  border=0 cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
  <TR>
    <TD width="35%"  ><font >供货商:<SPAN id="T_gys" ></SPAN></font></TD>
    <TD  width="30%"><font >联系人： <SPAN id="T_lxr" ></SPAN></font></TD>
    <TD width="35%" ><font >地址：<SPAN id="T_gysdz"></SPAN></font></TD></TR>
  <%--<TR>
     <TD width="35%"  ><font >客户:<SPAN id="T_kh" ></SPAN></font></TD>
    <TD  width="30%"><font >地址： <SPAN id="T_khdz" ></SPAN></font></TD>
    <TD width="35%" ><font >订购日期：<SPAN id="T_rq"></SPAN></font></TD></TR>
   
      </TR>--%>
       <TR>
     <TD  colspan="2"  ><font >备注:<SPAN id="T_remarks" ></SPAN></font></TD> <TD width="35%" ><font >订购日期：<SPAN id="T_rq"></SPAN></font></TD>
   </TR>
   
      </TR>
      </TBODY></TABLE>
</div>
<%--<p>----------------------div2:------------------------------------------------------------------------------------</p>--%>
<div id="div2">

<TABLE   class="table table-striped table-bordered table-condensed"border=1 cellSpacing=0 cellPadding=1 width="100%" style="border-collapse:collapse" bordercolor="#333333">
<thead>
  <TR>
       <TD width="5%">
      <DIV align=center><b>序号</b></DIV></TD>
     <TD width="10%">
      <DIV align=center><b>产品代码</b></DIV></TD>
    <TD width="20%">
      <DIV align=center><b>产品名称</b></DIV></TD>
    <TD width="20%">
      <DIV align=center><b>规格/型号/品牌		</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>数量</b></DIV></TD>
        <TD width="10%">
      <DIV align=center><b>单位</b></DIV></TD>
<%--    <TD width="10%">
      <DIV align=center><b>单价</b></DIV></TD>
    <TD width="10%">
      <DIV align=center><b>金额</b></DIV></TD>--%>
      <TD width="30%">
      <DIV align=center><b>备注</b></DIV></TD>
  </TR>
</thead>      
  <TBODY>      
 </TBODY>
  <tfoot>
  <%--<tr>
    <TD ><b> </b></TD>
    <TD ><b></b></TD>
    <TD ><b>&nbsp;</b></TD>
	<TD  align="left">
  	<p align="center"> </p>
	</TD>
	<TD  align="left">
  	<p align="center"> </TD>    
	<%--<TD width="14%" align="right">　小计</TD>
	<TD width="19%" tdata="subSum" format="#,##0.00" align="right"><font >￥###</font></TD>   
 </tr>--%>
      
      <tr><td colspan="2">交货日期：</td>
          <td><SPAN id="T_qdrq"></SPAN></td> 
           
          <td>合计：</td> 
          <td  tdata="AllSum" format="#,##0.00" align="right">####</td>   
          <td ></td>  
          <td ><font ></font></TD>    

      </tr>
      
  </tfoot>
</TABLE>
</div>
<%--<p>----------------------div3:------------------------------------------------------------------------------------</p>--%>
<div id="div3">
  <DIV style="LINE-HEIGHT: 30px" 
align=center><font >感谢您对我们的支持.</font></DIV>
</div>
    
    </form>
</body>
</html>
