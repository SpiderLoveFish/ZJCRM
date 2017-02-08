<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户自助报价</title>
 
<style>

#msgTitle{ background: url(images/title.gif) repeat-x; width:350px; height:36px;}
#img1{ margin-top:5px; margin-right:7px;}
#msgDiv{ background:#fff;}
.texta{ width:202px; height:31px; background:url(images/inputbg.gif) no-repeat; border:none; line-height:31px;}
.texta1{width:204px; height:32px; background:url(images/hqyzmxx.gif) no-repeat; border:none; line-height:32px;}
.btttn{ width:96px; height:38px; background:url(images/anbtton.gif) no-repeat; border:none;}
*{margin:0;padding:0;list-style-type:none;}

.formbox{text-align:center;width:100%;margin:0 auto;height:351px;margin-top:0px;background-image:url('bj_files/bg.png');background-repeat:no-repeat;border-top:1px solid black;border-bottom:1px solid black;}
.formbox .con{text-align:center;height:340px;width:304px;float:right;border:1px solid black}
.coolbg{
	font-size:18px;
	line-height:30px;
	background-color:rgb(10,114,189);
	border:1px solid #bdc5ca;
	height:45px;
	width:100%;
	color:rgb(255,255,255);
	margin:0 auto;
}
td{padding:7px 10px;text-align:right;}
</style>
<link href="css/baojia.css" type="text/css" rel="stylesheet" />

<%--<script src="../../js/jquery-1.6.1.min.js" type="text/javascript"></script>--%>
    <script src="../js/jquery-1.8.2.min.js"></script>
    <script src="js/checkform.js"></script>
    <script src="js/bj.js"></script>
 
    <script src="../js/lazyload-min.js"></script>
<script type="text/javascript">


    LazyLoad.css(["../css/cityStyle.css"], function () {
        LazyLoad.js(["../js/cityScript.js"], function () {
            var test = new citySelector.cityInit("inputcity");
        });
    });


    function sAlert(str){

        var msgw,msgh,bordercolor;
        msgw=350;//提示窗口的宽度
        msgh=200;//提示窗口的高度
        bordercolor="#336699";//提示窗口的边框颜色
        titlecolor="#99CCFF";//提示窗口的标题颜色
            
        var sWidth,sHeight;
        sWidth=document.body.offsetWidth;
        sHeight=document.body.offsetHeight;

        var ifbgObj=document.createElement("iframe");
        ifbgObj.setAttribute('id','ifbgDiv');
        ifbgObj.style.position="absolute";
        ifbgObj.style.top="0";
        ifbgObj.style.background="#777";
        ifbgObj.style.filter="progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75";
        ifbgObj.style.opacity="0.6";
        ifbgObj.style.left="0";
        ifbgObj.style.width=sWidth + "px";
        ifbgObj.style.height=sHeight + "px";

        document.body.appendChild(ifbgObj);


        var bgObj=document.createElement("div");
        bgObj.setAttribute('id','bgDiv');
        bgObj.style.position="absolute";
        bgObj.style.top="0";
        bgObj.style.background="#777";
        bgObj.style.filter="progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75";
        bgObj.style.opacity="0.6";
        bgObj.style.left="0";
        bgObj.style.width=sWidth + "px";
        bgObj.style.height=sHeight + "px";
        document.body.appendChild(bgObj);
        var msgObj=document.createElement("div")
        msgObj.setAttribute("id","msgDiv");
        msgObj.setAttribute("align","center");
        msgObj.style.position="absolute";
        //msgObj.style.background="white";
        msgObj.style.font="14px '微软雅黑'";
        //msgObj.style.border="1px solid " + bordercolor;
        msgObj.style.width=msgw + "px";
        msgObj.style.height=msgh + "px";
        msgObj.style.top=(document.documentElement.scrollTop + (sHeight-msgh)/500) + "px";
        msgObj.style.left=(sWidth-msgw)/2 + "px";
        var title=document.createElement("h4");
        title.setAttribute("id","msgTitle");
        title.setAttribute("align","right");
        title.style.margin="0";
        //title.style.padding="3px";
        //title.style.background=bordercolor;
        //title.style.filter="progid:DXImageTransform.Microsoft.Alpha(startX=20, startY=20, finishX=100, finishY=100,style=1,opacity=75,finishOpacity=100);";
        //title.style.opacity="0.75";
        //title.style.border="1px solid " + bordercolor;
        //title.style.height="24px";
        title.style.font="12px Verdana, Geneva, Arial, Helvetica, sans-serif";
        title.style.color="white";
        title.style.cursor="pointer";
        title.innerHTML='<img id=img1 src="images/close.gif" width="22" height="22" />';
        title.onclick=function(){
            document.body.removeChild(document.getElementById("ifbgDiv"));
            document.body.removeChild(bgObj);
            document.getElementById("msgDiv").removeChild(title);
            document.body.removeChild(msgObj);
        }
        document.body.appendChild(msgObj);
        document.getElementById("msgDiv").appendChild(title);
        var txt=document.createElement("p");
        txt.style.margin="1em 0"
        txt.setAttribute("id","msgTxt");
        txt.innerHTML=str;
        document.getElementById("msgDiv").appendChild(txt);
    }

    //<!--点击后弹出招商窗口 结束-->

    function settimeclose(){
        //alert("123");
        document.body.removeChild(document.getElementById("ifbgDiv"));
        document.body.removeChild(document.getElementById("bgDiv"));
        document.body.removeChild(document.getElementById("msgDiv"));
        document.getElementById("msgDiv").removeChild(title);


    }
 
    function op(){
        sAlert('<table width="350" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;"><tr><td height="40" colspan="3" align="center" valign="middle" style="font-weight:bolder; color:#3aa7e8; font-size:16px;">请输入手机验证码</tr><tr><td height="40" align="center" valign="middle">输入验证码：</td><td height="40" align="left" valign="middle"><input type="text" name="useryzm" id="useryzm"  class="texta" /></td><td height="40" align="center" valign="middle">&nbsp;</td></tr><tr><td height="30" align="center" valign="middle">&nbsp;</td><td height="40" align="left" valign="middle"><input type="button" name="button" id="button" onclick="subm()" class="btttn"/></td><td height="40" align="center" valign="middle">&nbsp;</td></tr></table>');
    }

    function subm() {
 
        if (document.getElementById("useryzm").value == document.getElementById("rdm").value) {
            savecustromer();
            document.form1.action = "../../CRM/ConsExam/kjl_search_bj.aspx?jmid=" + document.getElementById("jmid").value + "&keyword=" + document.getElementById("keyword").value + "&cityid=166" + "&tel=" + tel;
            document.form1.submit();
            settimeclose();
        } else {
            alert("输入的验证码有误，请重新输入！");
            return false;
        }
    } 

    function formatForInd(obj,len){   //此方法与上面的formatnums方法一样，因为首页有一个同名的方法不好修改，现在重写一个用于首页的电话号码判断
        obj.value = obj.value.replace(/[^0-9]/g,'');
        if(eval("/[0-9]{"+len+"}/g").test(obj.value))
            obj.value=obj.value.substring(0,len); 
    }
    function formatname(obj,len){
        obj.value = obj.value.replace(/[^\u4E00-\u9FA5]/g,'');
        if(eval("/[\u4E00-\u9FA5]{"+len+"}/g").test(obj.value))
            obj.value=obj.value.substring(0,len); 
    }

    function clearxing(){
        //document.getElementById("xing").value="";
	
    }
  
</script>
</head>
<body   style = "">


<div  style='position:fixed; z-index:999; top:0;' class="formbox">
  	<div class="con">
  <img src="bj_files/yy_top.png">
  	 
   <form id = "form1" name = "form1" action="../../CRM/ConsExam/kjl_search_my.aspx" accept-charset="UTF-8" method="post"  target="_blank">
  <table width="101%" cellpadding="0" cellspacing="1" style="width:100%;">
				<tr>
					<td width="60px">地&nbsp;&nbsp;区</td>
					<td > <INPUT id="inputcity" style="width: 95%; border:1px  solid rgb(191, 209, 245); padding:4px; font-size:14px;" type="text" readonly value="苏州"> 
     <INPUT name="cityid" id="cityid" type="hidden" value="166"> 
					</td>
				</tr>
				<tr>
					<td>姓&nbsp;&nbsp;名</td>
					<td style="text-align:left;"><input type='text' name='xing' id='xing'  style="width:35%;  border:1px  solid rgb(191, 209, 245); padding:4px; font-size:14px;"   value='' /> 
					
					性别<input type='radio' name='sex' class='np' value='男' checked>男  <input type='radio' name='sex' class='np' value='女'>女 </td>
				</tr>
				<tr>
					<td>小&nbsp;&nbsp;区</td>
					<td><input type='text' name='xq' id='xq' style="width:95%;  border:1px  solid rgb(191, 209, 245); padding:4px; font-size:14px;"   value=''  />
					</td>
				</tr>
				<tr>
					<td>电&nbsp;&nbsp;话</td>
					<td><input type='text' name='phone' id='phone' style="width:95%; border:1px  solid rgb(191, 209, 245); padding:4px; font-size:14px;"  value='' />
					</td>
				</tr>
				<tr>
					<td>面&nbsp;&nbsp;积</td>
					<td style="text-align:left;"><input type='text' name='hx' id='hx' style="width:95%; border:1px  solid rgb(191, 209, 245); padding:4px; font-size:14px;"   value='' /></td>
				</tr>
               
				</table>
		 	<input type="hidden" id = "pho" name="pho" value="" />
			<input type="hidden" id = "rdm" name="rdm" value="" />
		 	<input type="hidden" id = "xingshi" name="xingshi" value="" /><!-- 姓氏 -->
			   <input type="hidden" id = "keyword" name="keyword" value="" />
			<input type="hidden" id = "jmid" name="jmid" value="ksxczs" /><!-- 用于标释，区分此处为百度推广报价之用 -->
		 <a style="cursor: pointer;" onclick="check();clearxing();" class='coolbg' >
       开始报价 </a>
         
  </form>
   
   </div>
</div>
 

 </body>
 </html> 