<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
     <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    
    <link rel="stylesheet" type="text/css" href="../../css/DragFlow/history.css"/>
     <script type="text/javascript" src="../../jlui3.2/lib/jquery/jquery-1.9.0.min.js"></script>

<script type="text/javascript" src="../../js/TimeFlow/jquery.mousewheel.js"></script>
<script type="text/javascript" src="../../js/TimeFlow/jquery.easing.js"></script>
<script type="text/javascript" src="../../js/TimeFlow/history.js"></script>
	
 </head>
   
   <script type="text/javascript">
        
       $(document).ready(function () {
          
	        //var items = [];
	       
	        var tt = "<ul id='u' class='list'>";
	        for (var i = 0; i < 10; i++) {
	            if (i == 0) {
	                tt += "<li style='margin-top:-110px;'>";
	            } else
	                tt += "<li>";
	            tt += " <div id='d1' class='liwrap'>";
	            tt += " <div id='d2' class='lileft'>";
	            tt += " <div id='d3' class='date'>";
	            tt += " <span class='year'>2013</span>";
	            tt += "	<span class='md'>0905</span>";
	            tt += " </div>";
	            tt += " </div>";

	            tt += " <div id='d4' class='point'><b></b></div>";

	            tt += " <div id='d5' class='liright'>";
	            tt += " <div id='d6' class='histt'> HTML5 CSS3 ��չ���� ���� </div> ";
	            tt += "	<div id='d7' class='hisct'>��������һ�汾�еĴ��󣬻�ӭ��Ҳ��ԣ����������������ϵ����,лл��</div>";
	            tt += "	 </div>";
	            tt += "	</div>";
	            tt += "  </li> ";
	           
	        }
	        tt += " </ul>";
	        var btn = $(tt);
	       
	        $("#content").append(btn);

	        $("#content").find("div").each(function () {
	           // alert($(this).attr("id"));
	            if ($(this).attr("id") == "d1")
	                $(this).addClass("liwrap");
	            else if ($(this).attr("id") == "d6")
	                $(this).addClass("histt");
	        });
	        $("#content").listview("refresh");   //��ʹ��'ul'��ǩʱ��ʹ�ã�����:ˢ���б�

	        $("#content").trigger("create");  //�ص㣺��������˼�����¼������ڱ�ǩ����ʽ���ǳ����õ�һ�仰��������һ���㶯̬append�ı�ǩ����ʧCss��ʽ
	        $("#content").find("ul").each(function () {
	            $(this).addClass("list");
	        });
	       

       });
	    function toolbar() {
	        $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=141&rnd=" + Math.random(), function (data, textStatus) {
	          
	            var items = [];
	            var arr = data.Items;
	            var tt = "<ul class='list'>";
	            for (var i = 0; i < arr.length; i++) {
	                //arr[i].icon = "../../" + arr[i].icon;
	                //items.push(arr[i]);
	                if (i == 0) {
	                    tt += "<li style='margin-top:-110px;'>";
	                } else
	                    tt += "<li>";
	                tt += " <div class='liwrap'>";
	                tt += "<div class='lileft'>";
	                tt += "<div class='date'>";
	                tt += "<span class='year'>2013</span>";
	                tt += "	<span class='md'>0905</span>";
	                tt += "</div>";
	                tt += "</div>";

	                tt += "<div class='point'><b></b></div>";

	                tt += "<div class='liright'>";
	                tt += "<div class='histt'> HTML5 CSS3 ��չ���� ���� </div> ";
	                tt += "	<div class='hisct'>��������һ�汾�еĴ��󣬻�ӭ��Ҳ��ԣ����������������ϵ����,лл��</div>";
	                tt += "	 </div>";
	                tt += "	</div>";
	                tt += "  </li> ";

	            }
	            tt += "</ul>";
	            var btn = $(tt);
	            $("#content").append(btn);
	        });
	    }
	</script>
    
    <body>
        <div id="arrow">
	<ul>
		<li class="arrowup"></li>
		<li class="arrowdown"></li>
	</ul>
</div>

<div id="history">

	<div class="title">
		<h2>ʩ������ʱ����</h2>
		<div id="circle">
			<div class="cmsk"></div>
			<div class="circlecontent">
				<div thisyear="2013" class="timeblock">
					<span class="numf"></span>
					<span class="nums"></span>
					<span class="numt"></span>
					<span class="numfo"></span>
					<div class="clear"></div>
				</div>
				<div class="timeyear">YEAR</div>
			</div>
			<a href="#" class="clock"></a>
		</div>
	</div>
	
	<div id="content">
        <%--<ul class='list'>
		 <li style="margin-top:-110px;">
				<div class="liwrap">
					<div class="lileft">
						<div class="date">
							<span class="year">2013</span>
							<span class="md">0905</span>
						</div>
					</div>
					
					<div class="point"><b></b></div>
					
					<div class="liright">
						<div class="histt"><a href="#">HTML5 CSS3 ��չ���� ����</a></div>
						<div class="hisct">��������һ�汾�еĴ��󣬻�ӭ��Ҳ��ԣ����������������ϵ����,лл��</div>
					</div>
				</div>
			</li>
            </ul>--%>
	</div>
</div>
	</body>
</html>
