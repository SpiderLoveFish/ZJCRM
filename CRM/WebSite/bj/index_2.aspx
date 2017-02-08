<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>诚信合作单位智能装修报价器,在线装修报价,装修报价软件,装修预算软件,由一键一家认证授权使用</title>
<meta name="keywords" content="诚信合作单位智能装修报价器,在线装修报价,装修报价软件,装修预算软件" />
<meta name="description" content="几个条件，便可自动计算出当地装修报价，获得准确的装修报价清单" />
<style>

#msgTitle{ background: url(images/title.gif) repeat-x; width:350px; height:36px;}
#img1{ margin-top:5px; margin-right:7px;}
#msgDiv{ background:#fff;}
.texta{ width:202px; height:31px; background:url(images/inputbg.gif) no-repeat; border:none; line-height:31px;}
.texta1{width:204px; height:32px; background:url(images/hqyzmxx.gif) no-repeat; border:none; line-height:32px;}
.btttn{ width:96px; height:38px; background:url(images/anbtton.gif) no-repeat; border:none;}

</style>
<link href="css/baojia.css" type="text/css" rel="stylesheet" />

<%--<script src="../../js/jquery-1.6.1.min.js" type="text/javascript"></script>--%>
    <script src="../js/jquery-1.8.2.min.js"></script>
    <script src="js/checkform.js"></script>
    <script src="js/bj.js"></script>
    <script src="js/bjqd.js"></script>  

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

    //<!--点击后弹出招商窗口 结束-->

    function settimeclose(){
        //alert("123");
        document.body.removeChild(document.getElementById("ifbgDiv"));
        document.body.removeChild(document.getElementById("bgDiv"));
        document.body.removeChild(document.getElementById("msgDiv"));
        document.getElementById("msgDiv").removeChild(title);


    }

    function tip(){
        if(document.getElementById("hadpho").value != "Y") {
            var rand = document.getElementById("rdm").value;
            //alert("验证码："+rand);
            var len = document.getElementById("yzm").value.length;
            if(len != 6) {
                alert("请输入您手机收到的6位数字验证码！");
            } else {
                var yzm = document.getElementById("yzm").value;
                if(yzm == rand) {
                    //cleanpho();
                    document.form1.submit();
				
                    document.getElementById("xing").value=""
                    settimeclose();
                } else {
                    alert("验证码错误，请重新输入！");
                }
                //document.ckyzm.submit();
            }
        } else {
            document.form1.submit();
            document.getElementById("xing").value=""
            settimeclose();
        }
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
        document.getElementById("xing").value="";
	
    }
  
</script>
</head>
<body onload="full_city();selectedValue();" style = "">


<div class="bj_kuang" >
  	<div class="big_k">
  
  	<div class="bj_top">
    <div class="bjq_tab01 active"   >家装按面积报价</div>
    	<div class="bjq_tab " onclick="javascript:window.location.href='index1.aspx?jmid=ksxczs'">家装按户型报价</div>
   		
   	  <div class="bjq_tab_r_text"><span><img src="images/top_tip.png"  /></span>简单填写您的房屋信息，一分钟为您提供装修报价清单！</div>
   </div>
   <%--  --%>
   <form id = "form1" name = "form1" action="../../CRM/ConsExam/kjl_search_my.aspx" accept-charset="UTF-8" method="post"  target="_blank">
   <div class="jzmjbj" >
   		<div class="line_one">
   	    <ul>
                <li>户型 <select name="hx" id="hx" style="width:140px;">
                
                <option  value="0">选几房几厅</option>
	            
                <option  value="1">一房一厅</option>
	            
                <option  value="2">二房一厅</option>
	            
                <option  value="3">三房一厅</option>
	            
                <option  value="12">二房二厅</option>
	            
                <option  value="13">三房二厅</option>
	            
                <option  value="14">四房二厅</option>
	            
                <option  value="15">五房二厅</option>
	            
              </select></li>
              
          <li>卫生间 <select name="xxj" id="xxj"  style="width:140px;">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select></li>
              
        <li>阳台 <select name="yt" id="yt"  style="width:140px;">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select></li>
              
        <li style="border-right:none;">装修风格 
        
        
          <select id="fengge" name = "fengge" style="width:140px;">
                
                <option value="1">现代简约</option>
                
                <option value="2">中式怀旧</option>
                
                <option value="3">欧式古典</option>
                
                <option value="4">西式田园</option>
                
                <option value="5">中西合璧</option>
                
              </select></li>
            </ul>
        </div>
        
        <div class="line_two">
        	<ul>
             
              <li style="width:228px; padding-left:10px;">
              装修档次 <select id = "dc" name="dc" style="width:140px; margin-left:10px;">
                <option value="低档">简单装修</option>
                <option value="中档">中档装修</option>
                <option value="高档">精装修</option>
              </select>
              </li>
           	  <li style="width:228px; padding-left:10px;">房间总面积
       	      <input type="text" name="zmj" id="zmj" class="bj_inputtext1"  onkeyup="javascript:formatnums(this);" onblur="if(this.value==''){this.value='输入房屋面积';this.style.color='#aaa'}" onfocus="if(this.value=='输入房屋面积'){this.value='';this.style.color='#333'}" value="输入房屋面积"/>
       	      </li>
        		
              
              
            </ul>
            <div style="width:340px; height:39px;line-height:39px;float:left;text-align:center;">诚信合作单位</div>
        <img src="images/renzheng.png" style="float:right;margin-right:20px;"/>
            
        </div>
        
       <div class="line_two"  style="text-align: center;">
       
        	<ul >
            	<li style="width:415px; padding-left:10px;">业主所在地 <select id="city1" onchange="eval('city_1('+this.value+')');eval('city_2('+document.all.city2.value+')');getCityValue();getCityvaluename();" value = ""  name="cit1" style="width:110px;">
                  <option value="" selected>请选择</option>
                </select>
              <select id="city2" onchange="eval('city_2('+this.value+')');getCityValue();getCityvaluename();" name="cit2" value = "" style="width:86px;">
                  <option value="" selected>请选择</option>
                </select>
              <select id="city3" name="cit3" value = "" onchange="getCityValue();getCityvaluename();"  style="width:86px;">
                  <option value="" selected>请选择</option>
                </select></li>
              <input type=hidden name="city_values" id="city_value" value=""/>
              
              <li style="width:170px; padding-left:10px;">
              电话号码 <input type="text" id="phone" name="phone" value="" class="baojia_input" onkeyup="javascript:formatForInd(this,15);" /></li>
              
               <li style="width:200px; padding-left:10px;">
              业主称呼 
              <input id="xing" name="xing" type="text" maxlength="10" class="baojia_input01" /> <select id="chengfu" name="chengfu" >
                  <option value="0" selected="selected">男</option>
                  <option value="1">女</option>
                </select></li>
              
              <li style="width:139px; border-right:none;">
              <a style="cursor: pointer;" onclick="check();clearxing();" class="a1"><img src="images/ksbj_but.png" width="96" height="25" border="0" /></a>
              </li>
              
               </ul>
               
              <div style="display: none">
	        <input  type="text" id="bomarea2" name = "bomarea2" value="0"  readonly="readonly"  />
	        <input  type="text" id="bomarea3" name = "bomarea3" value="0" readonly="readonly"/>
	        <input  type="text" id="bomarea1" name = "bomarea1" value="0" readonly="readonly"  />
	        <input  type="text" id="bomarea4" name = "bomarea4" value="0" readonly="readonly"  />
	        <input  type="text" id="bomarea6" name = "bomarea6" value="0" readonly="readonly"  />
	        <input  type="text" id="bomarea5" name = "bomarea5" value="0" readonly="readonly"   />
	        
	        <input type="text"  name = "bom2" id="bom2" value="0" readonly="readonly"  />
            <input type="text" id="bom3" name = "bom3"  value="0" readonly="readonly"   />
            <input type="text" id="bom1" name = "bom1" value="0" readonly="readonly"  />
            <input type="text" id="bom4" name = "bom4" value="1" readonly="readonly"  />
            <input type="text" id="bom6" name = "bom6" value="0" readonly="readonly"  />
            <input type="text" id="bom5" name = "bom5" value="0" readonly="readonly"  />
            
            <input type="hidden" id = "kongzhi" name="kongzhi" value ="tijiao"/>
            
<!-- 
	        <input type="hidden" id = "cit1" name="cit1" value="" />
			<input type="hidden" id = "cit2" name="cit2" value="" />
			<input type="hidden" id = "cit3" name="cit3" value="" /> 
 -->
			<input type="hidden" id = "sumcityname" name = "sumcityname" value = "" />
			<input type="hidden" id = "pho" name="pho" value="" />
			<input type="hidden" id = "rdm" name="rdm" value="" />
			<input type="hidden" id = "hadpho" name="hadpho" value="N" />
			<input type="hidden" id = "xingshi" name="xingshi" value="" /><!-- 姓氏 -->
			   <input type="hidden" id = "keyword" name="keyword" value="" />
			<input type="hidden" id = "jmid" name="jmid" value="ksxczs" /><!-- 用于标释，区分此处为百度推广报价之用 -->
			<input type="hidden" id = "findman3" name="findman3" value="0" />
			<input type="hidden" name="flag" value ="true"/>
        </div>
           
        </div> 
      
   </div>

   </form>
   
   
   
</div>
</div>


 </body>
 </html> 