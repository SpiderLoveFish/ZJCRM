<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>按户型家装报价器,在线家装报价,家装报价软件,家装预算软件</title>
<meta name="keywords" content="按户型家装报价器,在线家装报价,家装报价软件,家装预算软件" />
<meta name="description" content="一键一家按户型装修报价器是由广州尚好家家居科技有限公司旗下一键一家装修网研制，任何人只需选择户型、厨房、阳台、卫生间、面积、档次与风格几个条件，便可自动计算出当地装修报价，获得准确的装修报价清单" />
<link href="css/baojia.css" type="text/css" rel="stylesheet" />

<%--<script src="../../js/jquery-1.6.1.min.js" type="text/javascript"></script>--%>
    <script src="../js/jquery-1.8.2.min.js"></script>
    <script src="js/checkform.js"></script>
    <script src="js/bj.js"></script>
    <script src="js/bjqd.js"></script>
<style>

#msgTitle{ background: url(images/title.gif) repeat-x; width:350px; height:36px;}
#img1{ margin-top:5px; margin-right:7px;}
#msgDiv{ background:#fff;}
.texta{ width:202px; height:31px; background:url(images/inputbg.gif) no-repeat; border:none; line-height:31px;}
.texta1{width:204px; height:32px; background:url(images/hqyzmxx.gif) no-repeat; border:none; line-height:32px;}
.btttn{ width:96px; height:38px; background:url(images/anbtton.gif) no-repeat; border:none;}

</style>
<!--点击后弹出招商窗口 开始-->
<script type="text/javascript" language="javascript">
    function sAlert(str){

        var msgw,msgh,bordercolor;
        msgw=510;//提示窗口的宽度
        msgh=200;//提示窗口的高度
        bordercolor="#336699";//提示窗口的边框颜色
        titlecolor="#99CCFF";//提示窗口的标题颜色
            
        var sWidth,sHeight;
        sWidth=document.body.offsetWidth;
        sHeight=document.body.offsetHeight;



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
        msgObj.style.top=(document.documentElement.scrollTop + (sHeight-msgh)/10) + "px";
        msgObj.style.left=(sWidth-msgw)/2 + "px";
        var title=document.createElement("h4");
        title.setAttribute("id","msgTitle");
        title.setAttribute("align","right");
        title.style.margin="0";
        //title.style.padding="3px";
        //title.style.background=bordercolor;
        title.style.filter="progid:DXImageTransform.Microsoft.Alpha(startX=20, startY=20, finishX=100, finishY=100,style=1,opacity=75,finishOpacity=100);";
        title.style.opacity="0.75";
        //title.style.border="1px solid " + bordercolor;
        //title.style.height="24px";
        title.style.font="12px Verdana, Geneva, Arial, Helvetica, sans-serif";
        title.style.color="white";
        title.style.cursor="pointer";
        title.innerHTML='<img id=img1 src="./images/close.gif" width="22" height="22" />';
        title.onclick=function(){
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
 
    function settimeclose(){
        //alert("123");
        document.body.removeChild(document.getElementById("bgDiv"));
        document.body.removeChild(document.getElementById("msgDiv"));
        document.getElementById("msgDiv").removeChild(title);

    }
</script>

<script type="text/javascript">
    function initTecVideoType(value){
        //var videotype = document.getElementsByName("fengge").length;
        //alert(videotype);
        var videotype = document.getElementsByName("fengge");
        //alert(videotype);
        var len = videotype.length;
        var i=0;
        for(;i<len;i++){
            if(value == videotype[i].value){
                //alert(videotype[i].value);
                videotype[i].checked=true;
                break;
            }
        } 
    }
	</script>
	
	<script type="text/javascript">
	    function zhuce(){
	        window.location.href = "./regist.jsp";
	    }
	    function baojia(){
	        // alert(1);
	        form1.submit();
	    }	
	    function changeValidateCode(obj) {   
	  
	        //获取当前的时间作为参数，无具体意义    
	        var timenow = new Date().getTime();    
	        //每次请求需要一个不同的参数，否则可能会返回同样的验证码    
	        //这和浏览器的缓存机制有关系，也可以把页面设置为不缓存，这样就不用这个参数了。    
	        obj.src="rand.action?id="+timenow;    
	    }	
	
	

	    function a(){
	        //alert(form1.findman2.value);卫生间
	        //alert(form1.bomarea6.value);卫生间
	        document.getElementById("bom6").value=form1.findman2.value;
	        document.getElementById("bomarea6").readOnly = false;
	        if(form1.findman2.value == 0){
	            document.getElementById("bomarea6").readOnly = true;
	            document.getElementById("bomarea6").value="卫生间";
	        }
	    }
	    function b(){
	        //alert(form1.findman2.value);阳台
	        document.getElementById("bom5").value=form1.findman.value;
	        document.getElementById("bomarea5").readOnly = false;
	        //alert(form1.findman.value);
	        if(form1.findman.value == 0){
	            document.getElementById("bomarea5").readOnly = true;
	            document.getElementById("bomarea5").value="阳台";
	        }
	    }   
	    function d(){
	        //alert(form1.findman2.value);厨房
	        document.getElementById("bom4").value=form1.findman4.value;
	        document.getElementById("bomarea4").readOnly = false;
	        if(form1.findman4.value == 0){
	            document.getElementById("bomarea4").readOnly = true;
	            document.getElementById("bomarea4").value="厨房";
	        }
	    }   
	    function c(){
	        //    	alert(form1.findman3.value);//户型  客厅  餐厅 卧房  2 3 1
	        if(form1.findman3.value ==0) {
	            document.getElementById("bom2").value=0;
	            document.getElementById("bom3").value=0;
	            document.getElementById("bomarea1").value="卧房";
	            document.getElementById("bomarea1").readOnly = true;
	            document.getElementById("bomarea2").value="客厅";
	            document.getElementById("bomarea2").readOnly = true;
	            document.getElementById("bomarea3").value="餐厅";
	            document.getElementById("bomarea3").readOnly = true;
	            document.getElementById("bomarea4").value="厨房";
	            document.getElementById("bomarea4").readOnly = true;
	            document.getElementById("bomarea5").value="阳台";
	            document.getElementById("bomarea5").readOnly = true;
	            document.getElementById("bomarea6").value="卫生间";
	            document.getElementById("bomarea6").readOnly = true;
	            document.getElementById("bom1").value=0;
	        }
	        if(form1.findman3.value ==1){
	            document.getElementById("bom2").value=1;
	            document.getElementById("bom3").value=0;
	            document.getElementById("bomarea1").value="卧房";
	            document.getElementById("bomarea1").readOnly = false;
	            document.getElementById("bomarea2").value="客厅";
	            document.getElementById("bomarea2").readOnly = false;
	            document.getElementById("bomarea3").value="餐厅";
	            document.getElementById("bomarea3").readOnly = true;
	            document.getElementById("bomarea4").value="厨房";
	            document.getElementById("bomarea4").readOnly = false;
	            document.getElementById("bom1").value=1;
	        }
	        if(form1.findman3.value ==2){
	            document.getElementById("bom2").value=1;
	            document.getElementById("bom3").value=0;
	            document.getElementById("bomarea3").value="餐厅";
	            document.getElementById("bomarea3").readOnly = true;
	            document.getElementById("bomarea1").value="卧房";
	            document.getElementById("bomarea1").readOnly = false;
	            document.getElementById("bomarea2").value="客厅";
	            document.getElementById("bomarea2").readOnly = false;
	            document.getElementById("bomarea4").value="厨房";
	            document.getElementById("bomarea4").readOnly = false;
	            document.getElementById("bom1").value=2;
	        }
	        if(form1.findman3.value ==3){
	            document.getElementById("bom2").value=1;
	            document.getElementById("bom3").value=0;
	            document.getElementById("bomarea3").value="餐厅";
	            document.getElementById("bomarea3").readOnly = true;
	            document.getElementById("bomarea1").value="卧房";
	            document.getElementById("bomarea1").readOnly = false;
	            document.getElementById("bomarea2").value="客厅";
	            document.getElementById("bomarea2").readOnly = false;
	            document.getElementById("bomarea4").value="厨房";
	            document.getElementById("bomarea4").readOnly = false;
	            document.getElementById("bom1").value=3;
	        }
	        if(form1.findman3.value ==4){
	            document.getElementById("bom2").value=1;
	            document.getElementById("bom3").value=0;
	            document.getElementById("bomarea3").value="餐厅";
	            document.getElementById("bomarea3").readOnly = true;
	            document.getElementById("bom1").value=4;
	        }
	        if(form1.findman3.value ==5){
	            document.getElementById("bom2").value=1;
	            document.getElementById("bom3").value=0;
	            document.getElementById("bomarea3").value="餐厅";
	            document.getElementById("bomarea3").readOnly = true;
	            document.getElementById("bom1").value=5;
	        }
	        if(form1.findman3.value ==6){
	            document.getElementById("bom2").value=1;
	            document.getElementById("bom3").value=0;
	            document.getElementById("bomarea3").value="餐厅";
	            document.getElementById("bomarea3").readOnly = true;
	            document.getElementById("bom1").value=6;
	        }
            	
	        if(form1.findman3.value ==11){
	            document.getElementById("bom2").value=1;
	            document.getElementById("bom3").value=1;
	            document.getElementById("bomarea3").readOnly = false;
	            document.getElementById("bom1").value=1;
	        }
	        if(form1.findman3.value ==12){
	            document.getElementById("bom2").value=1;
	            document.getElementById("bom3").value=1;
	            document.getElementById("bomarea3").readOnly = false;
            		
	            document.getElementById("bomarea1").value="卧房";
	            document.getElementById("bomarea1").readOnly = false;
	            document.getElementById("bomarea2").value="客厅";
	            document.getElementById("bomarea2").readOnly = false;
	            document.getElementById("bomarea4").value="厨房";
	            document.getElementById("bomarea4").readOnly = false;
            		
	            document.getElementById("bom1").value=2;
	        }
	        if(form1.findman3.value ==13){
	            document.getElementById("bom2").value=1;
	            document.getElementById("bom3").value=1;
	            document.getElementById("bomarea3").readOnly = false;
	            document.getElementById("bomarea1").value="卧房";
	            document.getElementById("bomarea1").readOnly = false;
	            document.getElementById("bomarea2").value="客厅";
	            document.getElementById("bomarea2").readOnly = false;
	            document.getElementById("bomarea4").value="厨房";
	            document.getElementById("bomarea4").readOnly = false;
	            document.getElementById("bom1").value=3;
	        }
	        if(form1.findman3.value ==14){
	            document.getElementById("bom2").value=1;
	            document.getElementById("bom3").value=1;
	            document.getElementById("bomarea3").readOnly = false;
	            document.getElementById("bomarea1").value="卧房";
	            document.getElementById("bomarea1").readOnly = false;
	            document.getElementById("bomarea2").value="客厅";
	            document.getElementById("bomarea2").readOnly = false;
	            document.getElementById("bomarea4").value="厨房";
	            document.getElementById("bomarea4").readOnly = false;
	            document.getElementById("bom1").value=4;
	        }
	        if(form1.findman3.value ==15){
	            document.getElementById("bom2").value=1;
	            document.getElementById("bom3").value=1;
	            document.getElementById("bomarea3").readOnly = false;
	            document.getElementById("bomarea1").value="卧房";
	            document.getElementById("bomarea1").readOnly = false;
            		
	            document.getElementById("bomarea2").value="客厅";
	            document.getElementById("bomarea2").readOnly = false;
	            document.getElementById("bomarea4").value="厨房";
	            document.getElementById("bomarea4").readOnly = false;
	            document.getElementById("bom1").value=5;
	        }
	        if(form1.findman3.value ==16){
	            document.getElementById("bom2").value=1;
	            document.getElementById("bom3").value=1;
	            document.getElementById("bomarea3").readOnly = false;
	            document.getElementById("bom1").value=6;
	        }
            	
	    }
            
            
	    function fgsch() {
	        document.getElementById('fengge').value = document.getElementById('fengges').value;
	    }
            
	    function dcsch() {
	        document.getElementById('dc').value = document.getElementById('dcs').value;
	    }
          </script>
      
<script type="text/javascript">
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

   
    function settimeclose(){
        //alert("123");
        document.body.removeChild(document.getElementById("ifbgDiv"));
        document.body.removeChild(document.getElementById("bgDiv"));
        document.body.removeChild(document.getElementById("msgDiv"));
        document.getElementById("msgDiv").removeChild(title);


    }

    function tip(){
        alert(document.getElementById("test").value);
    }

    function op(){
        sAlert('<table width="350" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;"><tr><td height="40" colspan="3" align="center" valign="middle" style="font-weight:bolder; color:#3aa7e8; font-size:16px;">请输入手机验证码</tr><tr><td height="40" align="center" valign="middle">输入验证码：</td><td height="40" align="left" valign="middle"><input type="text" name="useryzm" id="useryzm"  class="texta" /></td><td height="40" align="center" valign="middle">&nbsp;</td></tr><tr><td height="30" align="center" valign="middle">&nbsp;</td><td height="40" align="left" valign="middle"><input type="button" name="button" id="button" onclick="subm()" class="btttn"/></td><td height="40" align="center" valign="middle">&nbsp;</td></tr></table>');
    }

    function subm(){
        if(document.getElementById("useryzm").value == document.getElementById("rdm").value) {
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
        document.getElementById("xing").value="";
	
    }


</script>
 
</head>
<body onload="full_city();selectedValue();" >
<form id = "form1" name = "form1" action="../../CRM/ConsExam/kjl_search_my.aspx" target="_blank" accept-charset="UTF-8" method="post" > 
<div class="bj_kuang">
  	<div class="big_k">
  	<div class="bj_top">
   <div class="bjq_tab01 " onclick="javascript:window.location.href='index.aspx?jmid=ksxczs'">家装按面积报价</div> 	<div class="bjq_tab active">家装按户型报价</div>
   		
   	  <div class="bjq_tab_r_text"><span><img src="images/top_tip.png"  /></span>简单填写您的房屋信息，一分钟为您提供装修报价清单！</div>
   </div>
   
   

   <div class="zdbj">
   		<div class="line_one">
   	    <ul>
                <li>户型 
                
		          
                <select name="findman3" id="findman3" onchange="c()" style="width:140px;">
                <option value="0">请选择户型</option>
                
                	<option value="1" >一房一厅</option>
                
                	<option value="2" >二房一厅</option>
                
                	<option value="3" >三房一厅</option>
                
                	<option value="12" >二房二厅</option>
                
                	<option value="13" >三房二厅</option>
                
                	<option value="14" >四房二厅</option>
                
                	<option value="15" >五房二厅</option>
                
              </select></li>
              
          <li>卫生间 <select name="select" onchange="a()"  id="findman2" style="width:140px;">
                <option value="0">请选择数量</option>
                <option value="1">一间</option>
                <option value="2">二间</option>
                <option value="3">三间</option>
                <option value="4">四间</option>
              </select></li>
              
        <li>阳台 <select name="select01" onchange="b()" id="findman" style="width:140px;">
                <option value="0">请选择数量</option>
                <option value="1">一个</option>
                <option value="2">二个</option>
                <option value="3">三个</option>
                <option value="4">四个</option>
              </select></li>
              
        <li style="border-right:none;">装修风格
         
	           
          <select name="langage2" id="fengges" onchange="fgsch();" style="width:140px;">
                
                <option value="1">现代简约</option>
                
                <option value="2">中式怀旧</option>
                
                <option value="3">欧式古典</option>
                
                <option value="4">西式田园</option>
                
                <option value="5">中西合璧</option>
                
              </select></li>
            </ul>
        </div>
        
        <div class="line_two">
        <div style="display: none">
                  		<ul>
                        	<li>数&nbsp;&nbsp;&nbsp;&nbsp;量</li>
                            <li><input type="text" name = "bom2" id="bom2" value="" readonly="readonly" /></li>
		                    <li><input type="text" id="bom3" name = "bom3"  value="" readonly="readonly" /></li>
		                    <li><input type="text" id="bom1" name = "bom1" value="" readonly="readonly"/></li>
		                    <li><input type="text" id="bom4" name = "bom4" value="1" readonly="readonly"/></li>
		                    <li><input type="text" id="bom6" name = "bom6" value="" readonly="readonly" /></li> 
		                    <li><input type="text" id="bom5" name = "bom5" value="" readonly="readonly" /></li> 
                        </ul>
                  </div>
        	<ul>
            	<li style="width:706px; padding-left:10px;">面积
            	<input type="text" class="bj_inputtext1" style="margin-left:15px;" onblur="if(this.value==''){this.value='客厅';this.style.color='#aaa'}" onfocus="if(this.value=='客厅'){this.value='';this.style.color='#333'}" value="客厅"  id="bomarea2" name = "bomarea2" readonly="readonly"/> 
            	<input type="text" class="bj_inputtext1" onblur="if(this.value==''){this.value='餐厅';this.style.color='#aaa'}" onfocus="if(this.value=='餐厅'){this.value='';this.style.color='#333'}" value="餐厅" id="bomarea3" name = "bomarea3" readonly="readonly"/>
            	<input type="text" class="bj_inputtext1" onblur="if(this.value==''){this.value='卧房';this.style.color='#aaa'}" onfocus="if(this.value=='卧房'){this.value='';this.style.color='#333'}" value="卧房" id="bomarea1" name = "bomarea1" readonly="readonly" /> 
            	<input type="text" class="bj_inputtext1"  onblur="if(this.value==''){this.value='厨房';this.style.color='#aaa'}" onfocus="if(this.value=='厨房'){this.value='';this.style.color='#333'}" value="厨房" id="bomarea4" name = "bomarea4" readonly="readonly"/> 
            	<input type="text" class="bj_inputtext1" onblur="if(this.value==''){this.value='卫生间';this.style.color='#aaa'}" onfocus="if(this.value=='卫生间'){this.value='';this.style.color='#333'}" value="卫生间" id="bomarea6" name = "bomarea6" readonly="readonly" /> 
            	<input type="text" class="bj_inputtext1" onblur="if(this.value==''){this.value='阳台';this.style.color='#aaa'}" onfocus="if(this.value=='阳台'){this.value='';this.style.color='#333'}" value="阳台" id="bomarea5" name = "bomarea5" readonly="readonly" /></li>
              
              <li style="width:230px; border-right:none; padding-left:10px;">
              装修档次 <select name="select2"  id="dcs" onchange="dcsch()" style="width:140px; margin-left:10px;">
                <option value="1">经济实惠</option>
              <option value="2">小康实用</option>
              <option value="3">高档豪华</option>
              </select></li>
              
              
            </ul>
        </div>
        
        
        <div class="line_two">
        	<ul>
            	<li style="width:415px; padding-left:10px;">业主所在地
            	<select style="width:108px;" id="city1"  onchange="eval('city_1('+this.value+')');eval('city_2('+document.all.city2.value+')');getCityValue();getCityvaluename();"  name="cit1">
	              <option value="" selected>请选择</option>
	            </select>
	            <select style="width:86px;" id="city2"  onchange="eval('city_2('+this.value+')');getCityValue();getCityvaluename();" name="cit2">
	              <option value="" selected>请选择</option>
	            </select>
	            <select style="width:86px;" id="city3" name="cit3" onchange="getCityValue();getCityvaluename();">
	              <option value="" selected>请选择</option>
	            </select>
              </li>
              <input type=hidden name="F0208" id="city_value" value=""/>
              <li style="width:170px; padding-left:10px;">
              电话号码 <input type="text" id="phone" name="phone" value="" class="baojia_input" onkeyup="javascript:formatForInd(this,15);"/></li>
              
               <li style="width:200px; padding-left:10px;">
              业主称呼 
              <input type="text" id="xing" name="xing" value="" maxlength="10" class="baojia_input01" /> <select id="chengfu" name="chengfu" >
                  <option value="0" selected="selected">男</option>
                  <option value="1">女</option>
                </select></li>
              <input type="hidden" id = "kongzhi" name="kongzhi" value ="tijiao"/>
<!-- 
       		<input type="hidden" id = "cit1" name="cit1" value="" />
       		<input type="hidden" id = "cit2" name="cit2" value="" />
       		<input type="hidden" id = "cit3" name="cit3" value="" />
 -->
 			<input type="hidden" id = "sumcityname" name = "sumcityname" value = "" />
       		<input type="hidden" id = "pho" name="pho" value="" />
       		<input type="hidden" id = "fengge" name="fengge" value="1" />
       		<input type="hidden" id = "dc" name="dc" value="1" />
       		<input type="hidden" id = "xingshi" name="xingshi" value="" /><!-- 姓氏 -->
       		<input type="hidden" id = "hadpho" name="hadpho" value="N" />
		    <input type="hidden" id = "rdm" name="rdm" value="" />
       		<input type="hidden" id = "jmid" name="jmid" value="ksxczs" /> <!-- 加盟商ID号，用于区分游客信息来源 -->
       		
              <li style="width:139px; border-right:none;">
              <a  class="a1"><img src="images/ksbj_but.png" width="96" height="25" border="0" onclick= "checkgshxbj();clearxing();"/></a>
              </li>
            </ul>
        </div>
   </div>
   
   
   
   
</div>
</div>

</form>
 </body>
 </html>  