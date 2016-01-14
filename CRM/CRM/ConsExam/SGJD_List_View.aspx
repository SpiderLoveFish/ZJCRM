<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
     <link rel="stylesheet" type="text/css" href="../../css/DragFlow/main.css"/>
    <script src="../../jlui3.2/lib/jquery/jquery-1.9.0.min.js"></script>
    
     <%--<script type="text/javascript" src="../../js/TimeFlow/jquery.js"></script>--%>
<script type="text/javascript" src="../../js/TimeFlow/jquery.timelinr-0.9.53.js"></script>

<script type="text/javascript" src="../../js/TimeFlow/jquery.mousewheel.js"></script>
   <script src="../../JS/XHD.js" type="text/javascript"></script>
    
 </head>
   <style type="text/css">
#timeline {width: 720px;height: 240px;overflow: hidden;margin: 10px auto;position: relative;background: url('../../Images/dot.gif') left 45px repeat-x;}
#dates {width: 720px;height: 60px;overflow: hidden;}
#dates li {list-style: none;float: left;width: 180px;height: 50px;font-size: 16px;text-align: center;background: url('../../Images/biggerdot.png') center bottom no-repeat;}
#dates a {line-height: 38px;padding-bottom: 10px;}
#dates .selected {font-size: 20px; color:green}
#issues {width: 720px;height: 240px;overflow: hidden;}	
#issues li {width: 720px;height: 240px;list-style: none;float: left;}
#issues li h1 {color: #007bc4;font-size: 16px;margin: 10px 0;} /*text-shadow: #000 1px 1px 2px;*/
#issues li p {font-size: 14px;margin-right: 70px; margin:10px; font-weight: normal;line-height: 22px;}

       .gj
       {font-size: 14px;color:red;margin: 10px 5px 0 0;text-align: right;
       }
       .blue
       {font-size: 14px;color:blue;margin: 10px 5px 0 0;text-align: right;
       }
       .trry {color:green;cursor:pointer;
       }
       .trry:hover{ text-decoration:underline; }

</style>
    <style>


table {
    *border-collapse: collapse; /* IE7 and lower */
    border-spacing: 0;
    width: 100%;    
}

.bordered {
    border: solid #ccc 1px;
    -moz-border-radius: 6px;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    -webkit-box-shadow: 0 1px 1px #ccc; 
    -moz-box-shadow: 0 1px 1px #ccc; 
    box-shadow: 0 1px 1px #ccc;         
}

.bordered tr:hover {
    background: #fbf8e9;
    -o-transition: all 0.1s ease-in-out;
    -webkit-transition: all 0.1s ease-in-out;
    -moz-transition: all 0.1s ease-in-out;
    -ms-transition: all 0.1s ease-in-out;
    transition: all 0.1s ease-in-out;     
}    
    
.bordered td, .bordered th {
    border-left: 1px solid #ccc;
    border-top: 1px solid #ccc;
    padding: 10px;
    text-align: left;    
}

.bordered th {
    background-color: #dce9f9;
    background-image: -webkit-gradient(linear, left top, left bottom, from(#ebf3fc), to(#dce9f9));
    background-image: -webkit-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:    -moz-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:     -ms-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:      -o-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:         linear-gradient(top, #ebf3fc, #dce9f9);
    -webkit-box-shadow: 0 1px 0 rgba(255,255,255,.8) inset; 
    -moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;  
    box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;        
    border-top: none;
    text-shadow: 0 1px 0 rgba(255,255,255,.5); 
}

.bordered td:first-child, .bordered th:first-child {
    border-left: none;
}

.bordered th:first-child {
    -moz-border-radius: 6px 0 0 0;
    -webkit-border-radius: 6px 0 0 0;
    border-radius: 6px 0 0 0;
}

.bordered th:last-child {
    -moz-border-radius: 0 6px 0 0;
    -webkit-border-radius: 0 6px 0 0;
    border-radius: 0 6px 0 0;
}

.bordered th:only-child{
    -moz-border-radius: 6px 6px 0 0;
    -webkit-border-radius: 6px 6px 0 0;
    border-radius: 6px 6px 0 0;
}

.bordered tr:last-child td:first-child {
    -moz-border-radius: 0 0 0 6px;
    -webkit-border-radius: 0 0 0 6px;
    border-radius: 0 0 0 6px;
}

.bordered tr:last-child td:last-child {
    -moz-border-radius: 0 0 6px 0;
    -webkit-border-radius: 0 0 6px 0;
    border-radius: 0 0 6px 0;
}



/*----------------------*/

.zebra td, .zebra th {
    padding: 10px;
    border-bottom: 1px solid #f2f2f2;    
}

.zebra tbody tr:nth-child(even) {
    background: #f5f5f5;
    -webkit-box-shadow: 0 1px 0 rgba(255,255,255,.8) inset; 
    -moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;  
    box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;        
}

.zebra th {
    text-align: left;
    text-shadow: 0 1px 0 rgba(255,255,255,.5); 
    border-bottom: 1px solid #ccc;
    background-color: #eee;
    background-image: -webkit-gradient(linear, left top, left bottom, from(#f5f5f5), to(#eee));
    background-image: -webkit-linear-gradient(top, #f5f5f5, #eee);
    background-image:    -moz-linear-gradient(top, #f5f5f5, #eee);
    background-image:     -ms-linear-gradient(top, #f5f5f5, #eee);
    background-image:      -o-linear-gradient(top, #f5f5f5, #eee); 
    background-image:         linear-gradient(top, #f5f5f5, #eee);
}

.zebra th:first-child {
    -moz-border-radius: 6px 0 0 0;
    -webkit-border-radius: 6px 0 0 0;
    border-radius: 6px 0 0 0;  
}

.zebra th:last-child {
    -moz-border-radius: 0 6px 0 0;
    -webkit-border-radius: 0 6px 0 0;
    border-radius: 0 6px 0 0;
}

.zebra th:only-child{
    -moz-border-radius: 6px 6px 0 0;
    -webkit-border-radius: 6px 6px 0 0;
    border-radius: 6px 6px 0 0;
}

.zebra tfoot td {
    border-bottom: 0;
    border-top: 1px solid #fff;
    background-color: #f1f1f1;  
}

.zebra tfoot td:first-child {
    -moz-border-radius: 0 0 0 6px;

    -webkit-border-radius: 0 0 0 6px;
    border-radius: 0 0 0 6px;
}

.zebra tfoot td:last-child {
    -moz-border-radius: 0 0 6px 0;
    -webkit-border-radius: 0 0 6px 0;
    border-radius: 0 0 6px 0;
}

.zebra tfoot td:only-child{
    -moz-border-radius: 0 0 6px 6px;
    -webkit-border-radius: 0 0 6px 6px
    border-radius: 0 0 6px 6px
}
  
</style>
   <script type="text/javascript">
       var t = ""; var tt = "";
       $(function () {

           $('#title').append("<h2 id='titleh2' class='top_title'>�ͻ���" + decodeURI(getparastr("khmc")) + "<lable >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�绰��" + getparastr("tel") + "</lable></h2>")
           var t2 = "";
           //alert(getparastr("jhdate"));
           if (decodeURI(getparastr("sjzt")) == "ʩ�����") {
               $("#lbgczt").append($("<span style='color:green'>" + decodeURI(getparastr("sjzt")) + "</span>"));
               // .val(decodeURI(getparastr("sjzt")));

           } else if (decodeURI(getparastr("sjzt")) == "����ʩ��") {
               $("#lbgczt").append($("<span style='color:red'>" + decodeURI(getparastr("sjzt")) + "</span>"));
               //t2 += "<td><strong>����״̬:</strong><lable  style='color:red'>" + decodeURI(getparastr("sjzt")) + "</lable></td>";

           }
           $("#lbsgjl").append($("<span>" + decodeURI(getparastr("sgjl")) + "</span>"));
           $("#lbjhrq").append($("<span>" + formatTimebytype(getparastr("jhdate"), "yyyy��MM��dd��") + "</span>"));

           // t2 += "<td><strong>Ҫ���깤ʱ��:</strong><lable  >" + formatTimebytype((getparastr("jhdate"), "yyyy��MM��dd��")) + "</lable></td>";
           var myDate = new Date();
           var days = getdays(formatTimebytype(getparastr("jhdate"), 'yyyy/MM/dd'), myDate);
           days = -days;
           if (days < 0)
               $("#lbsygq").append($("<span  class='gj'>������" + days*1 + "��</span>"));
           else
               $("#lbsygq").append($("<span  class='blue'>ʣ�๤��" + days + "��</span>"));

           INIT("init");


       });

       function addBtnEvent(id) {
           $("#b" + id).bind("click", function () {
               $('#lbryt2').text($('#b' + id).text() );
               INIT($('#b' + id).text());
               //alert("��" + $('#b' + id).text() + "��");
               // chickid = id;
               //  f_openWindow_post("hr/hr_position.aspx?IsGet=Y", "ѡ��ְ��", 650, 400);
           });
       }

       function getdays(dtbegin, dtend) {
           var ts = parseInt(new Date(dtend).getTime() - new Date(dtbegin).getTime());
           var days = Math.floor(ts / (24 * 3600 * 1000))
           return days;
       }

       function INIT(ryid) {
           $.ajax({
               type: "GET",
               url: "../../data/SGJD_LIST.ashx", /* ע���������ֶ�ӦCS�ķ������� */
               data: { Action: 'detailform', cid: getparastr("cid"), ry: ryid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
               //url: "../../data/SGJD_LIST.ashx?Action=formgrid&cid=" + getparastr("cid") + "&rdm=" + Math.random(),
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {
                   var obj = eval(result);
                    
                   if (obj.length > 0 && ryid == "init") {
                       var str = new Array();
                     
                       if (obj[0].zry != null&&obj[0].zry != 'null' && obj[0].zry != '' && obj[0].zry != 'undefined') {
                         
                           str = obj[0].zry.split(";");

                           if (str.length > 0) {
                             
                               var tb = ""; var br = 0;
                               tb += "<thead> <tr>  <th colspan='5' class='trry' id='bb'>ȫ��ʩ����Ա����</th> </tr></thead>";
                               tb += "<tr >";

                               for (var i = 0; i < str.length - 1; i++) {

                                   br++;
                                   tb += " <td width='16%'><span  class='trry' id='b" + i + "'>" + str[i] + "</span></td>";
                                   //  tb += "<td width='16%' ><lable  style='color:green' id='b" + i + "'>�Ӻ鳬</lable></td>";

                                   if (br == 5) {
                                       tb += " </tr><tr>";
                                       br = 0;
                                   }

                                   if (i == str.length - 2) {
                                       if (br < 5)
                                           for (var c = br + 1; c <= 5; c++) {
                                               tb += "<td> </td>"
                                               if (c == 5)
                                                   tb += " </tr>"
                                           }
                                   }
                               }
                               tb += " </tr>";
                               $('#tbry').empty();
                               $('#tbry').append($(tb));

                               for (var i = 0; i < str.length; i++) {
                                   // alert($("#b" + i).val());
                                   //$("#b" + id).text()
                                   addBtnEvent(i);
                               }
                               $("#bb").bind("click", function () {
                                   $('#lbryt2').text("��ȫ�塿");
                                   INIT("");
                                   // chickid = id;
                                   //  f_openWindow_post("hr/hr_position.aspx?IsGet=Y", "ѡ��ְ��", 650, 400);
                               });
                           }
                       }
                      
                       $('#lbryt2').text("��ȫ�塿");
                   }
                   
                   $('#lbtotalt2').text(obj.length);
                   t = "";
                   for (var i = 0; i < obj.length; i++) {
                       if (i == 0) {
                           $('#lbrq1').text(formatTimebytype(obj[i].LRRQ, "yyyy-MM-dd"));
                           $('#lbrq2').text(formatTimebytype(obj[obj.length - 1].LRRQ, "yyyy-MM-dd"));

                           if (decodeURI(getparastr("sjzt")) == "ʩ�����") {
                               $("#lbsygq").empty();
                               var dayss = getdays(formatTimebytype(obj[obj.length - 1].LRRQ, 'yyyy/MM/dd'), formatTimebytype(getparastr("jhdate"), 'yyyy/MM/dd'));
                               if (dayss < 0)
                                   $("#lbsygq").append($("<span  class='gj'>�����깤" + dayss*-1 + "��</span>"));
                               else
                                   $("#lbsygq").append($("<span  class='blue'>��ǰ�깤" + dayss + "��</span>"));
                           }

                           var days = getdays(formatTimebytype(obj[0].LRRQ, 'yyyy/MM/dd'), formatTimebytype(obj[obj.length - 1].LRRQ, 'yyyy/MM/dd'));

                           $('#lbtst2').text(days);
                       }

                       t += "<li><a href='#h" + i + "'>" + formatTimebytype(obj[i].LRRQ, "yyyy��MM��dd��") + "</a></li>";
                   }

                   tt = "";
                   for (var i = 0; i < obj.length; i++) {


                       tt += "<li id='h" + i + "'>";
                       tt += "<p><strong>˵����</strong>" + obj[i].REMARK + " <strong>״̬��</strong>" + obj[i].JDMC + "</p>";

                       tt += "<h1>��Ŀ�嵥��</h1>";
                       tt += "<p>" + obj[i].xmmc + "</p>";
                       tt += "<h1>��Ա�嵥��</h1>";
                       tt += "<p>" + obj[i].ry + "</p>";
                       tt += "</li>";
                   }

                   //tt += " <a href='#' id='next'></a>";
                   //tt += " <a href='#' id='prev'></a>";
                   $('#dates').find("li").remove();
                   $('#dates').append($(t));
                   $('#issues').find("li").remove();
                   $('#issues').append($(tt));

                   $().timelinr({
                       orientation: 'horizontal', //��ֱ����
                       issuesSpeed: 300, // ��Ӧ�������Ĺ����ٶȣ���Ϊ100��1000֮������֣���������Ϊ'slow', 'normal' or 'fast'
                       datesSpeed: 100, //��������ٶȣ���Ϊ100��1000֮������֣���������Ϊ'slow', 'normal' or 'fast'
                       arrowKeys: 'true', //֧�ַ����
                       //startAt: 3, //��ʼ����㣬����ʼ�����λ�ã�����
                       mousewheel: 'true'//�Ƿ�֧��������
                   });


               },
               error: function (e) {
                   alert("Init2");
               }
           });
       }
	</script>
    
    <body>
     <div   id="main">
         <div id="title"></div> 
          <table width="600px">
             <tr id="title2">
                 <td><strong>�˹���</strong><font id="lbgczt" > </font>
                  <strong>��</strong> <font  id="lbsgjl" > </font>
                  <strong>�����������Ҫ��</strong> <font id="lbjhrq"> </font>
                  <strong>��ɣ�</strong> <font  id="lbsygq"> </font></td>
             </tr>
              <tr>
                   
                  <td colspan="8" id="t2remark">
                      <label class="blue" id="lbryt2"></label>��ʱ<label  class="blue" id="lbtst2"></label>�죬��<label  class="blue" id="lbrq1"></label>��<label  class="blue" id="lbrq2"></label>������<label  class="blue" id="lbtotalt2"></label>��ʱ���
                  </td>
              </tr>
         </table>
         <div style="width:720px;height:430px;">
    <table class="bordered" id="tbry">
  

</table>
              <div id="timeline">
                       
                      <ul id="dates">
                   
                    </ul>
                    <ul id="issues">
               
                    </ul>
           </div> 
       

           
             </div>
          </div>
	</body>
</html>
