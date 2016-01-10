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
#timeline {width: 720px;height: 300px;overflow: hidden;margin: 10px auto;position: relative;background: url('../../Images/dot.gif') left 45px repeat-x;}
#dates {width: 720px;height: 60px;overflow: hidden;}
#dates li {list-style: none;float: left;width: 180px;height: 50px;font-size: 18px;text-align: center;background: url('../../Images/biggerdot.png') center bottom no-repeat;}
#dates a {line-height: 38px;padding-bottom: 10px;}
#dates .selected {font-size: 26px; color:green}
#issues {width: 720px;height: 300px;overflow: hidden;}	
#issues li {width: 720px;height: 300px;list-style: none;float: left;}
#issues li h1 {color: #007bc4;font-size: 18px;margin: 20px 0;} /*text-shadow: #000 1px 1px 2px;*/
#issues li p {font-size: 14px;margin-right: 70px; margin:10px; font-weight: normal;line-height: 22px;}

       .gj
       {font-size: 14px;color:red;margin: 10px 5px 0 0;text-align: right;
       }
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
          
           $('#title').append("<h2 id='titleh2' class='top_title'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客户：" + decodeURI(getparastr("khmc")) + "<lable class='gj'>电话：" + getparastr("tel") + "</lable></h2>")
            var t2 = "";
            //alert(getparastr("jhdate"));
            if(decodeURI(getparastr("sjzt"))=="施工完成" )
           {
               t2 += "<td><strong>工程状态:</strong><lable style='color:green'>" + decodeURI(getparastr("sjzt")) + "</lable></td>";
         
            }else   if(decodeURI(getparastr("sjzt"))=="正在施工" ){
               t2+= "<td><strong>工程状态:</strong><lable  style='color:red'>" + decodeURI(getparastr("sjzt")) + "</lable></td>";
     
           }
           t2+= "<td><strong>施工监理:</strong><lable  >" + decodeURI(getparastr("sgjl")) + "</lable></td>";
          // t2 += "<td><strong>要求完工时间:</strong><lable  >" + formatTimebytype((getparastr("jhdate"), "yyyy年MM月dd日")) + "</lable></td>";
           
           $('#title2').append($(t2));

               INIT();
           
        
       });
	    function INIT() {
	        $.ajax({
	            type: "GET",
	            url: "../../data/SGJD_LIST.ashx", /* 注意后面的名字对应CS的方法名称 */
	            data: { Action: 'detailform', cid: getparastr("cid"), rnd: Math.random() }, /* 注意参数的格式和名称 */
	            //url: "../../data/SGJD_LIST.ashx?Action=formgrid&cid=" + getparastr("cid") + "&rdm=" + Math.random(),
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (result) {      
	                var obj = eval(result);    
	               
	                for (var i = 0; i < obj.length; i++) {
	                       t+="<li><a href='#h"+i + "'>" + formatTimebytype(obj[i].LRRQ, "dd日hh时mm分") + "</a></li>";
	                }
	                
	                //$('#titleh2').append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<lable class='gj'>共计" + obj.length + "个时间点</lable>");
	                //var tt="";
	                for (var i = 0; i < obj.length; i++) {
	                    
	                   
	                    tt += "<li id='h" + i + "'>";
	                    tt += "<p><strong>说明：</strong>" + obj[i].REMARK + " <strong>状态：</strong>" + obj[i].JDMC + "</p>";
	                 
	                    tt += "<h1>项目清单：</h1>";
	                    tt += "<p>" + obj[i].xmmc + "</p>";
	                    tt += "<h1>人员清单：</h1>";
	                    tt += "<p>" + obj[i].ry + "</p>";
	                    tt += "</li>";
	                }
	              
	                //tt += " <a href='#' id='next'></a>";
	                //tt += " <a href='#' id='prev'></a>";
	                $('#dates').append($(t));
	                $('#issues').append($(tt));

	                $().timelinr({

	                    orientation: 'horizontal', //垂直滚动
	                    issuesSpeed: 300, // 对应内容区的滚动速度，可为100～1000之间的数字，或者设置为'slow', 'normal' or 'fast'
	                    datesSpeed: 100, //主轴滚动速度，可为100～1000之间的数字，或者设置为'slow', 'normal' or 'fast'
	                    arrowKeys: 'true', //支持方向键
	                    //startAt: 3, //初始化起点，即初始化轴点位置，数字
	                    mousewheel: 'true'//是否支持鼠标滚轮
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

             </tr>
         </table>
         <div style="width:720px;height:430px;">
    
              <div id="timeline">
                       
                      <ul id="dates">
                   
                    </ul>
                    <ul id="issues">
               
                    </ul>
           </div> 
       
<table class="bordered" id="tbry">
    <thead>

    <tr>
        <th colspan="6">全体施工人员名单</th>
        </tr>
    </thead>
    <tr >
        <td width="20%"><strong>设计师</strong></td>

        <td width="20%"> <a href="#">庞洪超</a></td>
     
        <td width="20%"><strong>油漆工</strong></td>
        <td width="20%"><a href="#">刘能</a></td>
     

        <td width="20%"><strong>卫生管家</strong></td>
        <td width="20%"><a href="#">谢大脚</a></td>
    </tr>    
    <tr>
        <td><strong>木工</strong></td>
        <td><a href="#">王五</a></td>

     
        <td><strong>瓦工</strong></td>
        <td><a href="#">赵四</a></td>
     
        <td><strong>水电工</strong></td>

        <td><a href="#">张三</a></td>
    </tr>
    <tr>
        <td><strong>保洁员</strong></td>
        <td><a href="#">查一</a></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>

    </tr> 

</table>
           
             </div>
          </div>
	</body>
</html>
