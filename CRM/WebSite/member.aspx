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
 
<div id="DIV1">
	<div class="top">
		<div class="wrap clearfix">
			<a href="#" class="logo left"><img src="images/logo.png"/></a>
			<div class="nav left dInline" id="Div2">
          <a href="http://www.xczs.com">首页</a>
      <a href="index.aspx">家装DIY</a>
      <a href="#">看案例</a>
                  <a id="MemberMenuChange" class="b-login" onclick="member()">会员中心</a>
      </div>
				<span class="right" id="rightMenuHtml">
        <a href="#">登录</a>|<a href="#" id="b-tuichu">退出</a>|&nbsp;&nbsp;&nbsp;&nbsp;
			</span>
		</div>
	</div>

</div>

<!--头部的结束-->
<%--<div id="header">
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
 
</div>--%>

<div >
	<div class="mebBox">
		<div class="meb-cont clearfix wrap">
			<div class="meb-nav left dInline">
				<ul class="clearfix">
					<li class="on"><a href="#">会员中心</a></li>
                    <li ><a href="my_sj.html">我的方案</a></li>
          
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
            <div class="mr-detail">
					<div class="me-box">
						<div class="mx-a">
							<ul class="clearfix">
								<li>
									<img src="images/hu1.png"/>
									<span>您目前有 <a href="my_sj.html"><b>1</b></a> 个装修方案</span>
								</li>
							</ul>
						</div>
						<div class="mx-b">
							<ul>
								<li class="clearfix">
									<span class="left">
										<img src="images/hu3.png"/>
									</span>
									<div class="mb-txt left dInline">
										<h2>马上查看 <a href="my_sj.html">我的方案</a> </h2>
										<p></p>
									</div>
								</li>
								<!--<li class="clearfix last">
									<span class="left">
										<img src="images/hu4.png"/>
									</span>
									<div class="mb-txt left dInline">
										<h2>您可以定制 <a href="#">到车通知</a> </h2>
										<p>不想在每天数以万计的车源中错过自己满意的二手车吗？亿金收集您的需求，第一时间为您推送符合您的信息</p>
									</div>
								</li>-->
							</ul>
						</div>
					</div>
					
				</div>
		</div>
	</div>
</div>


<!--底部的开始-->
<div id="footer">
  <div class="foot-a">
      <br />
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