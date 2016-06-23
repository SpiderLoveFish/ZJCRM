<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
<link rel="stylesheet" type="text/css" href="css/base.css">
<link rel="stylesheet" type="text/css" href="css/layout.css">
<link rel="stylesheet" type="text/css" href="css/hurst.css">
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <link rel="stylesheet" type="text/css" href="css/layout.css">
     <link rel="stylesheet"  type="text/css"href="css/cityselect.css">
      <script type="text/javascript" src="js/jquery-1.8.2.min.js"></script> 
    <script type="text/javascript" src="../JS/XHD.js"></script>
     <script src="../jlui3.2/lib/json2.js" type="text/javascript"></script>
    <script src="../lib/jquery.form.js" type="text/javascript"></script>
     <script src="js/website.js"></script>
     <script src="../JS/jquery.md5.js" type="text/javascript"></script>
     <script src="js/lazyload-min.js"></script>
   
<script type="text/javascript" src="js/cityselect.js"></script> 
        <script type="text/javascript"> 
            $(function () {
                if (getCookie("website_uid") == null || getCookie("website_uid") == "" || getCookie("website_uid") == undefined)
                { }
                else  
                     loginin(getCookie("website_nickname"))

              
            });

            function loginin(nickname) {
                // alert(nickname);
                var html =   ' 你好：' + nickname + '|<a href="#" id="b-tuichu">退出</a>|&nbsp;&nbsp;&nbsp;&nbsp;400-0512-004	';
                $('#rightMenuHtml').html(html);

                var htmlhy = " <h2>尊敬的会员 <b>" + nickname + "</b></h2>  <p> 手机：" + getCookie("website_uid") + "       </p>";
                $('#divhy').html(htmlhy);

            }
        </script>
</head>
<body>
 
<div id="header">
 <div class="top">
    <div class="wrap clearfix"> <a href="#" class="logo left"><img src="images/logo.png"/></a>
      <div class="nav left dInline" id="headerMenu">
      <a href="http://www.xczs.com">首页</a>
      <a href="index.aspx">家装DIY</a>
      <a href="#">看案例</a>
        
       </div>
	<span class="right" id="rightMenuHtml">
        <a href="#">登录</a>|<a href="#" id="b-tuichu">退出</a>|&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/tel.png"/>
			</span>
		</div>
	</div>
 
</div>

<div id="about">
	<div class="mTags wrap">
		<a href="#">心成装饰</a>><a href="#">会员中心</a>
	</div>
	<div class="mebBox">
		<div class="meb-cont clearfix wrap">
			<div class="meb-nav left dInline">
				<ul class="clearfix">
					<li class="on"><a href="#">会员中心</a></li>
                    <li ><a href="#">我的需求</a></li>
          
                    <li><a href="memberEdit.aspx">账户管理</a></li>				
                </ul>
			</div>
			<div class="meb-right right dInline">
				<div class="mr-top">
    <div class="mr-top-div clearfix">
        <span class="left">
            <img src="images/photo.png"/>
        </span>
        <div class="mr-infor left dInline" >
           <span class="left" id="divhy"></span>
        </div>
    </div>
</div>
	 		</div>
		</div>
	</div>
</div>


<!--底部的开始-->
<div id="footer">
  <div class="foot-a1">
    <div class="wrap">
      <ul class="clearfix">
        
      </ul>
    </div>
  </div>
  <div class="foot-a">
    <div class="wrap clearfix">
      <div class="fDl left dInline "> <strong>心成承诺</strong>
        <ul>
          <li><a href="#">质量保证</a></li>
        </ul>
      </div>
      <div class="fDl left dInline "> <strong>装修指南</strong>
        <ul>
          <li><a href="#" target="_blank">五要素</a></li>
          <li><a href="#" target="_blank">20年前开桑塔纳的大款们，</a></li>
        </ul>
      </div>
      <div class="fDl left dInline "> <strong>售后服务</strong>
        <ul>
          <li><a href="#">24小时上门</a></li>
          <li><a href="#">免费维修</a></li>
        </ul>
      </div>
      <div class="fDl left dInline "> <strong>关于心成</strong>
        <ul>
          <li><a href="#" target="_blank">心成动态</a></li>
          <li><a href="#" target="_blank">心成荣誉</a></li>
          <li><a href="#" target="_blank">心成优势</a></li>
          <li><a href="#" target="_blank">联系心成</a></li>
          <li><a href="#" target="_blank">心成团队</a></li>
        </ul>
      </div>
      <div class="fDl left dInline "> <strong>心成文化</strong>
        <ul>
          <li><a href="#">改变、规范、引领市场</a></li>
          <li><a href="#">颠覆装修理念</a></li>
        </ul>
      </div>
      <div class="fDl left dInline fDl1">
        <div class="dLx"> <img src="images/dLx.jpg"/> </div>
        <div style="height:50px;"></div>
      </div>
    </div>
  </div>
  <div class="foot-b"> Copyright © 2007 - 2016 昆山心成装饰设计工程有限公司 版权所有 苏ICP备09040162号 <br/>
 
     </div>
</div>
<!--底部的结束-->
<!--footer部分结束-->
<div id="miniBus" style="right:-270px;">
	<div class="mini-bar">
		<div class="mini-barlist">
			<ul>
				<li class="miItem">
				 
				</li>
				<li class="miItem">
					 
				</li>
				<li>
					 
				</li>
				<li class="callItem">
				 
				</li>
				<li class="miItem">
				 
				</li>
			</ul>
		</div>
		<a class="mini-gotop"></a>
		<a class="wx1"><img src="images/wx_1.png"></a>
		<div class="wmImg hide">
			<img src="images/wx_2.png">
		</div>
	</div>
	<div class="mini-cont">
		<div class="mini-contlist">
		 </div>
	</div>
 </div>
 
<script type="text/javascript" src="js/miniBar.js"></script>
<script type="text/javascript" src="js/lg_reg.js"></script>

 
</body>
</html>