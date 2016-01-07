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
               orientation: 'vertical', //��ֱ����
               issuesSpeed: 300, // ��Ӧ�������Ĺ����ٶȣ���Ϊ100��1000֮������֣���������Ϊ'slow', 'normal' or 'fast'
               datesSpeed: 100, //��������ٶȣ���Ϊ100��1000֮������֣���������Ϊ'slow', 'normal' or 'fast'
               arrowKeys: 'true', //֧�ַ����
               startAt: 3, //��ʼ����㣬����ʼ�����λ�ã�����
               mousewheel: 'true'//�Ƿ�֧��������
           });
       });
	    function toolbar() {
	        $.ajax({
	            type: "GET",
	            url: "../../data/SGJD_LIST.ashx", /* ע���������ֶ�ӦCS�ķ������� */
	            data: { Action: 'detailform', cid: getparastr("cid"), rnd: Math.random() }, /* ע������ĸ�ʽ������ */
	            //url: "../../data/SGJD_LIST.ashx?Action=formgrid&cid=" + getparastr("cid") + "&rdm=" + Math.random(),
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (result) {
	                
	                var obj = eval(result);
	                
                         
	                var tt = "<ul id='dates'>";
	                for (var i = 0; i < obj.length; i++) {

	                    tt += "<li><a href='#" + formatTimebytype(obj[i].LRRQ, "ddhhmmss") + "'>" + formatTimebytype(obj[i].LRRQ, "dd��hhʱmm��") + "</a></li>";
	                    
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
	                //$("#timeline").listview("refresh");   //��ʹ��'ul'��ǩʱ��ʹ�ã�����:ˢ���б�

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
                            <h1>2005 �����ǳ�</h1>
                            <p>2005�꣬����׹�ء�������ˬ�����ܾ�ȫ�������������֣��Ǵ�Ҷ�ϲ���������԰���������ã�����Խ��Խ������ѵ�����������Լ������</p>
                        </li>
                        <li id="2006">
                            <h1>2006 �﷫��</h1>
                            <p>2006�꣬��ѽѧ����ÿ��ǧ�򼶵��û����ʣ�����GG�����Ż��˼ܹ������ʦMM��������˻�ӭ�����ȸ��Ի�װ�磬��������Ҳ��������404�ˡ���</p>
                        </li>
                        <li id="2007">
                            <h1>2007 �������</h1>
                            <p>2007�꣬�����ɡ����Ƴ�����Ϣ���ĺͺ���Ȧ����ʼ��SNS����ת�ͣ��״�4.0ȫ��ģʽ���������۴󷽡�</p>
                        </li>
                        <li id="2008">
                            <h1>2008 �������</h1>
                            <p>2008�꣬ʮ�˱䡣�����Ƴ��ĸ������ģ���ʽ��־���ҴӴ�ͳ������SNS������ת�䣬ע���û��ͷ������Ⱦӹ��ڵ�һ��ÿ�춼�г����û�����������������е������¡�</p>
                        </li>
                        <li id="2009">
                            <h1>2009 �ٻ����</h1>
                            <p>2009�꣬�ٻ���š������ڶ����Ӧ�ã������������QQũ�������˺ö���һ����ҹ���������ɣ�ҲΪ�����ϰ����������Ϲ��Ĺ�ϵ������׿Խ�Ĺ��ס�</p>
                        </li>
                        <li id="2010">
                            <h1>2010 �����顢�����</h1>
                            <p>2010�꣬ǿ���ڹ����������ڲ�Ʒ���鲻�ϵľ���ϸ������Ϊ�����˷��ٷ�չ��5�꣬������ֻ�в��ϵ����������������ô���������۵�������ļҡ�</p>
                        </li>
                        <li id="2011">
                            <h1>2011 �ҵĿռ� �ҵļ�</h1>
                            <p>2011�꣬�����ں��������ʵĿ������顢���ḻ��Ӧ�á������ֵĸ������ģ������Ҳ��������ں��Ľ�����������ϵļ�Խ��Խ����������׷���Ŀ�ꡣ</p>
                        </li>
                        <li id="2012">
                            <h1>2012 �������� ��ס�ж�</h1>
                            <p>2012�꣬�ɱ䣬���䡣�ʹ��һ������7�꣬���������������õ�7�ꡣ��������7����еĴ�ѧ��������ᣬ�еĳ�����ͥ���е����˺��ӡ�ʱ����ת�����Ƕ��ڳɳ�����Ψһ����ģ�����QQ�ռ䡪������Զ�ļң�</p>
                        </li>
                    </ul>--%>
                    </div>
             </div>
          </div>
	</body>
</html>
