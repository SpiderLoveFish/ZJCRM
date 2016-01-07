<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
     <link rel="stylesheet" type="text/css" href="../../css/DragFlow/common.css"/>
 
     <script type="text/javascript" src="../../js/TimeFlow/jquery.js"></script>
<script type="text/javascript" src="../../js/TimeFlow/jquery.timelinr.js"></script>

<script type="text/javascript" src="../../js/TimeFlow/jquery.mousewheel.js"></script>
   <script src="../../JS/XHD.js" type="text/javascript"></script>
    
 </head>
    <style type="text/css">
            #timeline {width: 760px;height: 440px;overflow: hidden;margin: 40px auto;position: relative;background: url('../../images/dot.gif') 110px top repeat-y;}
            #dates {width: 115px;height: 440px;overflow: hidden;float: left;}
            #dates li {list-style: none;width: 100px;height: 100px;line-height: 100px;font-size: 18px; padding-right:20px; text-align:right; background: url('../../images/biggerdot.png') 108px center no-repeat;}
            #dates a {line-height: 38px;padding-bottom: 10px;}
            #dates .selected {font-size: 38px;}
            #issues {width: 630px;height: 440px;overflow: hidden;float: right;}	
            #issues li {width: 630px;height: 440px;list-style: none;}
            #issues li h1 {color: #ffcc00;font-size: 14px; height:52px; line-height:52px; text-shadow: #000 1px 1px 2px;}
            #issues li p {font-size: 14px;margin: 10px;line-height: 26px;}
        </style>
   <script type="text/javascript">
        
       $(function () {
          
           toolbar();

           $().timelinr({
               orientation: 'vertical', //垂直滚动
               issuesSpeed: 300, // 对应内容区的滚动速度，可为100～1000之间的数字，或者设置为'slow', 'normal' or 'fast'
               datesSpeed: 100, //主轴滚动速度，可为100～1000之间的数字，或者设置为'slow', 'normal' or 'fast'
               arrowKeys: 'true', //支持方向键
               startAt: 3, //初始化起点，即初始化轴点位置，数字
               mousewheel: 'true'//是否支持鼠标滚轮
           });
       });
	    function toolbar() {
	        $.ajax({
	            type: "GET",
	            url: "../../data/SGJD_LIST.ashx", /* 注意后面的名字对应CS的方法名称 */
	            data: { Action: 'detailform', cid: getparastr("cid"), rnd: Math.random() }, /* 注意参数的格式和名称 */
	            //url: "../../data/SGJD_LIST.ashx?Action=formgrid&cid=" + getparastr("cid") + "&rdm=" + Math.random(),
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (result) {
	                
	                var obj = eval(result);
	                
                         
	                var tt = "<ul id='dates'>";
	                for (var i = 0; i < obj.length; i++) {

	                    tt += "<li><a href='#" + formatTimebytype(obj[i].LRRQ, "ddhhmmss") + "'>" + formatTimebytype(obj[i].LRRQ, "dd日hh时mm分") + "</a></li>";
	                    
	                     //tt += "	<span class='md'>" + formatTimebytype(obj[i].LRRQ, "hh: mm: ss") + "</span>";
	                }
	                tt += " </ul>";
	                  tt += "<ul id='issues'>";
	               
	                for (var i = 0; i < obj.length; i++) {
	                    tt += " <li id='" + formatTimebytype(obj[i].LRRQ, "ddhhmmss") + "'>";
	                    tt += "  <h1>" + obj[i].xmmc + "</h1>";
	                    tt += "   <p>" + obj[i].ry + "</p>";
	                    tt += "  </li>";
	                }
	                tt += " </ul>";
	                tt += " <a href='#' id='next'></a>";  
	                tt += " <a href='#' id='prev'></a>";
	                 
	                var btn = $(tt);

	                $("#timeline").append(btn);
	                //$("#timeline").listview("refresh");   //在使用'ul'标签时才使用，作用:刷新列表

	                //$("#timeline").trigger("create");  
	            },
	            error: function (e) {
	                alert("Init2");
	            }
	        });
	    }
	</script>
    
    <body>
     <div class="container" id="main">
         <div class="demo">
                <div id="timeline">
                  <%--   <ul id="dates">
                        <li><a href="#2005">2005</a></li>
                        <li><a href="#2006">2006</a></li>
                        <li><a href="#2007">2007</a></li>
                        <li><a href="#2008">2008</a></li>
                        <li><a href="#2009">2009</a></li>
                        <li><a href="#2010">2010</a></li>
                        <li><a href="#2011">2011</a></li>
                        <li><a href="#2012">2012</a></li>
                    </ul>
                    <ul id="issues">
                        <li id="2005">
                            <h1>2005 闪亮登场</h1>
                            <p>2005年，呱呱坠地。界面清爽、功能俱全、操作简单易上手，是大家都喜爱的网络家园。出生不久，就有越来越多的朋友到我这里分享自己的生活。</p>
                        </li>
                        <li id="2006">
                            <h1>2006 扬帆起航</h1>
                            <p>2006年，咿呀学语。面对每天千万级的用户访问，技术GG帮我优化了架构，设计师MM帮我设计了欢迎动画等个性化装扮，“妈妈再也不担心我404了”！</p>
                        </li>
                        <li id="2007">
                            <h1>2007 内外兼修</h1>
                            <p>2007年，初长成。咱推出了信息中心和好友圈，开始向SNS社区转型；首创4.0全屏模式，更加美观大方。</p>
                        </li>
                        <li id="2008">
                            <h1>2008 厚积薄发</h1>
                            <p>2008年，十八变。当年推出的个人中心，正式标志着我从传统博客向SNS社区的转变，注册用户和分享量稳居国内第一；每天都有超多用户在我这里分享生活中的新鲜事。</p>
                        </li>
                        <li id="2009">
                            <h1>2009 百花齐放</h1>
                            <p>2009年，百花齐放。引入众多国民级应用，其中最出名的QQ农场，给了好多人一个深夜上网的理由，也为拉近老爸老妈老婆老公的关系做出了卓越的贡献。</p>
                        </li>
                        <li id="2010">
                            <h1>2010 新体验、新起点</h1>
                            <p>2010年，强化内功。致力于在产品体验不断的精雕细琢。因为经历了飞速发展的5年，我明白只有不断的自我修炼，才能让大家真正把咱当成网络的家。</p>
                        </li>
                        <li id="2011">
                            <h1>2011 我的空间 我的家</h1>
                            <p>2011年，培养内涵。更优质的宽屏体验、更丰富的应用、更热闹的个人中心，都是我不断培养内涵的结果。让网络上的家越来越上流，是我追求的目标。</p>
                        </li>
                        <li id="2012">
                            <h1>2012 分享生活 留住感动</h1>
                            <p>2012年，蜕变，不变。和大家一起经历的7年，是我生命中最美好的7年。你们在这7年里，有的从学生步入社会，有的成立家庭，有的有了孩子。时光流转，我们都在成长，但唯一不变的，就是QQ空间——你永远的家！</p>
                        </li>
                    </ul>--%>
                    </div>
             </div>
          </div>
	</body>
</html>
