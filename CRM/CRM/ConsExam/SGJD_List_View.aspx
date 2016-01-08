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
   <script type="text/javascript">
       var t = ""; var tt = "";
       $(function () {
          
           $('#title').append("<h2 id='titleh2' class='top_title'>客户：" + decodeURI(getparastr("khmc")) + "</h2>")
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
	                       t+="<li><a href='#" + formatTimebytype(obj[i].LRRQ, "yyyyMMddhhmmss") + "'>" + formatTimebytype(obj[i].LRRQ, "dd日hh时mm分") + "</a></li>";
	                }
	                
	                $('#titleh2').append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<lable class='gj'>共计" + obj.length + "次维护</lable>");
	                //var tt="";
	                for (var i = 0; i < obj.length; i++) {
	                    tt += "<li id='" + formatTimebytype(obj[i].LRRQ, "yyyyMMddhhmmss") + "'>";
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

         <div style="width:720px;height:430px;">
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
