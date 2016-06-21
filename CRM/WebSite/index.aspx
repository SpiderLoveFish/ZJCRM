<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <link rel="stylesheet" type="text/css" href="css/layout.css">
      <script type="text/javascript" src="js/jquery-1.8.2.min.js"></script> 
    <script type="text/javascript" src="../JS/XHD.js"></script>
     <script src="../jlui3.2/lib/json2.js" type="text/javascript"></script>
    <script src="../lib/jquery.form.js" type="text/javascript"></script>
     <script src="js/website.js"></script>
     <script src="../JS/jquery.md5.js" type="text/javascript"></script>
     <script src="js/lazyload-min.js"></script>
        <script type="text/javascript">
            var startstr = 0;
            var varCODE = "code";
             LazyLoad.css(["css/cityStyle.css"], function () {
                LazyLoad.js(["js/cityScript.js"], function () {
                    var test = new citySelector.cityInit("inputcity");
                   });
            });
          
            $(function () {
                if (getCookie("website_uid") == null || getCookie("website_uid") == "" || getCookie("website_uid") == undefined)
                { }
                else
                    loginin(getCookie("website_uid"))

              ajaxhxtapi($('#keyword1').val());
          
             });

       
            $("#citySelect").on('input', function (e) {
                alert('Changed!')
                $('#citySelect').val(JSON.stringify(test))

            });

        //搜索户型图接口
            function ajaxhxtapi(keystr) {
                //x选择城市
                var ciid = 166;
                if ($('#cityid').val() != undefined)
                    ciid = $('#cityid').val();
                if (keystr == undefined) keystr = "";
            $.ajax({
                url: "../data/website.ashx", type: "POST",
                data: { Action: "gethxtapi", uid: 'admin', cityid: ciid, keystr: keystr, strstart: startstr, rnd: Math.random() },
                success: function (responseText) {
                    // alert(responseText);
                    var obj = eval(responseText);
                    var html = "";
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";

                        var names = obj[n].name;
                        if (names.length >= 15) names = names.substr(0, 15) + '...';

                        html += '    <li class="clearfix" style="position: relative;"> ' +
                        '<a href="#" target="_blank"></a>' +
                        ' <div class="carImg left dInline"> ' +
                        '   <img src=' + obj[n].pics + ' width="266" /> ' +
                        '  </div>' +
                
                        ' <div style="height:260px" class="right carTxt dInline pve">' +
                        ' <div class="c-txt">' +
                        '  <h3>' +
                        ' <a href="#" target="_blank">' + obj[n].commName + '</a>' +
                        ' </h3>' +
                    
                        ' <p>' + obj[n].name + '</p>' +
                        '  <div class="price">' +
                        '   <p>面积：' +
                        '  <i></i> <span class="num nBlue">' + obj[n].srcArea + '</span><font> 平方米</font></p> <p>户型： <font> ' + obj[n].specName + '</font> </p> ' +
                        '   </div>' +
                        ' <p><div class="login-button"><input type="button" class="fM"  style="cursor:pointer;" value="自己DIY" onclick="docreate(\'' + obj[n].obsPlanId + '\')" ></input>></p>&nbsp;' +
                        '  </div> </div>' +
                        ' </div>' +
                
                        ' </a>' +
                        ' </li>';
                       
                    }
                     
                  
                    $('#ullist').html(html);

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest.status);
                    
                }
            });
            }

            //创建
            function docreate(pid) {
                // alert(pid);
                if (getCookie("tel") == undefined || getCookie("tel") == "" || getCookie("tel") == null)
                {
                    $('.b-login').click();
                }
                else
                {
                    ajaxhxtfb(pid);
                }


            }
            //获取指定户型图的副本
            function ajaxhxtfb(planid) {
                $.ajax({
                    url: "../data/website.ashx", type: "POST",
                    data: { Action: "getuserhxdatafb", planid: planid, rnd: Math.random() },
                    success: function (responseText) {
                        var copyid = responseText;

                        if (copyid == "" || copyid == "null" || copyid == undefined || copyid == "request time out") {
                            alert("创建失败，请重新创建！" + copyid);
                            return;
                        }
                        viewkjl('kjl_edit.aspx?fid=' + copyid + '&style=insert' + '&dest=2', "新增方案");

                     
                    },
                    error: function () {
                        alert("创建失败");
                    }
                });
            }
            function viewkjl(url, newname) {
                window.open(url + "&width=" + screen.width +
                                    "&height=" + (screen.height - 70), newname,
                                    "top=0,left=0,toolbar=no, menubar=no, scrollbars=yes,resizable=no,location=no,status=no,width=" +
                                    screen.width + ",height=" +
                                    (screen.height - 70));
            }
        function search()
            {
            //alert($('#keyword1').val());
            ajaxhxtapi($('#keyword1').val() + $('#keyword').val());
        }

        function more()
        {
            startstr++;
            ajaxhxtapi($('#keyword1').val());
        }
       
        function ok()
        {
            var uid = $("#T_uid").val();
            var pwd = $("#T_pwd").val();
            if (uid == "") {
                alert("账号不能为空！");
                $("#T_uid").focus();
                return;
            }
            if (pwd == "") {
                alert("密码不能为空！");
                $("#T_pwd").focus();
                return;
            }
            $("#T_pwd").val("");
            $.ajax({
                url: "../data/website.ashx", type: "POST",
                data: { Action: "login", uid: uid, pwd: $.md5(pwd), rnd: Math.random() },
                //contentType: "application/json; charset=utf-8",
                //dataType: "json",
                success: function (responseText) {
 
                    if (responseText == null || responseText == "null" || responseText == "")
                    {
                          $('#msg1').html("登录失败!");
                        return;
                    }
                   //alert(responseText);
                    var obj = eval(responseText);
                     for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                        if (obj[0].tel != null&&n==0) {
                            SetCookie("website_uid", obj[0].tel, 30);
                            loginin(obj[0].nickname);
                        }
                     }
                    

                },
                error: function () {
                    $('#msg1').html("登录失败!");
                }
            });

            

          
        }

        function regist()
        {
            
            var mobile = $("#mobile").val();
            //alert(mobile);
            var nickname = $("#nickname").val();
            //alert(nickname);
            var pwd = $("#pwd").val();
            //alert(pwd);
            var gender = $("[name='gender']").filter(":checked");
            //alert(gender.attr("value"));
            //alert(varCODE);
            if ($("#T_yzm").val().toUpperCase() == varCODE) {
                $.ajax({
                    url: "../data/website.ashx", type: "POST",
                    data: { Action: "reg", tel: mobile, pwd: $.md5(pwd), nickname: nickname, sex: gender.attr("value"), rnd: Math.random() },
                    success: function (responseText) {
                        if (responseText == "true") {
                            alert("注册成功，已自动登录!");
                            SetCookie("website_uid", tel, 30);
                            loginin(nickname);
                            
                        }
                    },
                    error: function () {
                        $('#msg2').html("注册失败!");
                        return;
                    }
                });

            }
            else {
                $('#msg2').html("验证码错误！！");
                return;
            }
            $('#popBox').fadeOut();
        }
        
        function loginin(nickname)
        {
            alert(nickname);
            var html = '   你好：' + nickname + '|<a href="#" id="b-tuichu">退出</a>|&nbsp;&nbsp;&nbsp;&nbsp;400-0512-004	';
            $('#rightMenuHtml').html(html);
            $('#popBox').fadeOut();
               
        }

    </script>
</head>
<body>
<div id="header">
  <div class="top">
    <div class="wrap clearfix"> <a href="#" class="logo left"><img src="images/logo.png"/></a>
      <div class="nav left dInline" id="headerMenu">
      <a href="index.aspx">首页</a>
      <a href="about.html">关于亿金</a>
      <a href="maiche_list.html">我要买车</a>
      <a href="wymc.html">我要卖车</a>
      <a href="srdz.html">私人定制</a>
      <!--<a href="shfw.html">售后服务</a>-->
      <a id="MemberMenuChange" class="b-login" href="会员中心首页.html" target="_self">会员中心</a>
      </div>
          <input type="text" class="file" readonly="readonly"   id="inputcity"  value="苏州" >
     <input type="hidden" id="cityid" value="166" />
     <span class="right" id="rightMenuHtml">
				<a href="#" class="b-login" id="b-login">登录</a>|<a href="#" id="b-regist">注册</a>|&nbsp;&nbsp;&nbsp;&nbsp;400-0512-004		
                </span> </div>
  </div>
  <div class="head-search">
    <div class="wrap clearfix">

           <div class="yjxj clearfix left" action="/index/keyword/" method="post" enctype="multipart/form-data">     
 <input type="text" id="keyword" name="keyword" placeholder="请输入您想要的户型搜索" class="left" />
        <input type="button" value="搜 索" onclick="search()" class="right" />
      </div>
      <div class="hotWords left dInline"> <a  onclick="more()">换一批</a> 热门小区：
         <a href="#">新城域</a><a href="#">新城柏丽湾</a>
              </div>
     
    </div>
  
  </div>

  </div>
<style type="text/css">
    .file {
    position: relative;
    display: inline-block;
    background: #D0EEFF;
    border: 1px solid #99D3F5;
    border-radius: 4px;
    padding: 4px 12px;
    overflow: hidden;
    color: #1E88C7;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
.file:hover {
    background: #AADFFD;
    border-color: #78C3F3;
    color: #004974;
    text-decoration: none;
}
#banner .prevs,#banner .nexts{position:absolute;top:220px;z-index: 100;margin-top:-25px;}
#banner .nexts{right:0;}
#banner .banShow a{display:block;width: 100%;height:465px;}
</style>
<div id="banner">
  <div class="banShow clearfix" style="width:100%;"> 
    <a href="#" class="bDiv" style="background: url(images/y77.jpg) no-repeat center top;"></a>  
    <a href="#" class="bDiv" style="background:url(images/1.jpg) no-repeat center top;"></a> 
  </div>
  <div class="b_btn wrap"> 
    <!--<a class="prevs"><img src="images/l1.png"></a> 
    <a class="nexts"><img src="images/r1.png"></a>-->   
  </div>
  
  <div class="searchBox">
   <div class="xbg"></div>
   <div class="xnrj">
   <img src="images/in1.png"/>
    <form class="clearfix" >
          
      <input type="text" maxlength="" id="keyword1" name="keyword" placeholder="请输入您想要的户型搜索" class="left" />
      <input type="button" value="" onclick="search()" class="right" />
    </form>

   </div>
  </div>
  
</div>
 
<div id="main">
   <div class="mDiv main-a">
    <div class="wrap">
      <div class="in-tit clearfix">
        <h1 class="left dInline"> 精品户型 </h1>
      </div>
         <div class="proMore"> <a  onclick="more()">换一批</a> </div>
      <div class="jpBox">
      
        <div class="jpCont">
          <div class="jpDl" style="display: block;">
            <ul id="ullist" class="clearfix">
           
               
              
            </ul>
            <div class="proMore"> <a  onclick="more()">换一批</a> </div>
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
        <li> <img src="images/db1.png"/>
          <p>365项检测认证</p>
        </li>
        <li> <img src="images/db2.png"/>
          <p>5000公里无需保养</p>
        </li>
        <li> <img src="images/db3.png"/>
          <p>1年或两万公里无忧质保</p>
        </li>
        <li> <img src="images/db4.png"/>
          <p>7天无忧退换</p>
        </li>
        <li> <img src="images/db5.png"/>
          <p> 置换有增值</p>
        </li>
      </ul>
    </div>
  </div>
  <div class="foot-a">
    <div class="wrap clearfix">
      <div class="fDl left dInline "> <strong>亿金承诺</strong>
        <ul>
          <li><a href="#">365项严苛检测</a></li>
          <li><a href="#">5000公里无需保养</a></li>
          <li><a href="#">一年或两万公里质保</a></li>
          <li><a href="#">7天退换</a></li>
        </ul>
      </div>
      <div class="fDl left dInline "> <strong>买卖二手车指南</strong>
        <ul>
          <li><a href="#" target="_blank">“禁止长时间停车”到底能</a></li>
          <li><a href="#" target="_blank">20年前开桑塔纳的大款们，</a></li>
          <li><a href="#" target="_blank">豪华入门跨界车之争,奔驰G</a></li>
          <li><a href="#" target="_blank">像初恋一样爱它，该给它怎</a></li>
          <li><a href="#" target="_blank">常开车不等于会开车 你的</a></li>
        </ul>
      </div>
      <div class="fDl left dInline "> <strong>售后服务</strong>
        <ul>
          <li><a href="#">24小时道路救援</a></li>
          <li><a href="#">豪车凹陷修复</a></li>
          <li><a href="#">定期上门维修保养服务</a></li>
          <li><a href="#">预约保养工时优惠</a></li>
        </ul>
      </div>
      <div class="fDl left dInline "> <strong>关于亿金</strong>
        <ul>
          <li><a href="#" target="_blank">亿金动态</a></li>
          <li><a href="#" target="_blank">亿金荣誉</a></li>
          <li><a href="#" target="_blank">亿金优势</a></li>
          <li><a href="#" target="_blank">联系亿金</a></li>
          <li><a href="#" target="_blank">评估团队</a></li>
        </ul>
      </div>
      <div class="fDl left dInline "> <strong>亿金文化</strong>
        <ul>
          <li><a href="#">中原文化</a></li>
          <li><a href="#">立天下</a></li>
          <li><a href="#">改变、规范、引领一方市场</a></li>
          <li><a href="#">颠覆中原人购车理念</a></li>
        </ul>
      </div>
      <div class="fDl left dInline fDl1">
        <div class="dLx"> <img src="images/dLx.jpg"/> </div>
        <div style="height:50px;"></div>
      </div>
    </div>
  </div>
  <div class="foot-b"> Copyright © 2007 - 2016 昆山心成装饰设计工程有限公司 版权所有 苏ICP备09040162号 <br/>
    地址：江苏昆山市新城域北门59-33号(中环南线)<br/>
     </div>
</div>
<!--底部的结束-->

<!--右侧内容的开始-->
<div id="miniBus" style="right:-270px;">
	<div class="mini-bar">
		<div class="mini-barlist">
			<ul>
				<li class="miItem">
					<div class="mini-mi browse">
						<i class="mini-ease"></i>
						<code></code>
						<span>最近浏览</span>
					</div>
				</li>
				<li class="miItem">
					<div class="mini-mi collec">
						<i class="mini-ease"></i>
						<code></code>
						<span>我的收藏</span>
					</div>
				</li>
				<li>
					<div class="mini-mi service">
						<i class="mini-ease" id="BizQQWPA"></i>
						<code></code>
						<span>在线客服</span>
                       
					</div>
				</li>
				<li class="callItem">
					<div class="mini-mi callback">
						<i class="mini-ease"></i>
						<code></code>
						<span>意见反馈</span>
					</div>
				</li>
				<li class="miItem">
					<div class="mini-mi shopping">
						<i class="mini-ease"></i>
						<code></code>
						<span>对比车辆</span>
						<abbr id="Dbnumber">0</abbr>
					</div>
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
			<div class="mini-ni">
				<div class="mini-h clearfix">
					<a class="mini-close mini-ease lf-fl"></a>
					<span class="lf-fr"><code>最近浏览</code></span>
				</div>
				<div class="miList" id="Liulan">
					<ul>
											</ul>
				</div>
			</div>
			<div class="mini-ni">
				<div class="mini-h clearfix">
					<a class="mini-close mini-ease lf-fl"></a>
					<span class="lf-fr"><code>我的收藏</code></span>
				</div>
				<div class="miList" id="shoucang">
					<ul>
											</ul>
<a  href="javascript:void(0)" class="mini-fav b-login">查看更多收藏</a>
				</div>
			</div>
			<!--<div class="mini-ni">
				<div class="mini-h clearfix">
					<a class="mini-close mini-ease lf-fl"></a>
					<span class="lf-fr"><code>在线客服</code></span>
				</div>
			</div>-->
			<div class="mini-ni" id="shopping">
				<div class="mini-h clearfix">
					<a class="mini-close mini-ease lf-fl"></a>
					<span class="lf-fr"><code>对比车辆</code></span>
                    <span class="lf-fr" style="margin:auto 10px; font-size:26px; font-weight:bolder" id="deletealldb"><a><code>×</code></a></span>
				</div>
                <div class="miList" id="Carduibi">
					<ul>
											</ul>
					<a href="#" class="mini-fav">立即对比</a>
				</div>
			</div>
		</div>
	</div>
	<div class="lf-view" id="lf-view">
    	<form onsubmit="return Lmessage();" enctype="multipart/form-data" method="post" name="leaveMess" id="leaveMess">
		<b>您对我们的看法~</b>
		<div>
			<textarea placeholder="您的声音对我们很重要哟(必填)~" name="bankAuthSrc"></textarea>
		</div>
		<div>
			<a id="viewSubmit" onclick="$('#leaveMess').submit()"></a>
            <input type="text" placeholder="请留下您的手机号码(必填)" id="viewAbout" name="mobile" />
            		</div>
        </form>
		<a id="viewClose"></a>
		<i id="viewIcon"></i>
		<p id="viewSign"></p>
	</div>
</div>

<!--右侧内容的结束-->

<!--会员登录和注册弹出框开始-->
<div id="popBox">
  <div class="popCont"> <a class="p_closed">关闭</a>
    <div class="p-tab"> <a>会员登录<i></i></a><a>会员注册<i></i></a> </div>
    <div class="p-detail">
      <div class="p-dl">
        <form name="form" id="form">
          <ul class="login-items">
            <li>
              <label>用户名(手机号)</label>
              <input class="input" id="T_uid" type="text" value="" maxlength="32"  name="username" placeholder="请输入您的手机号">
            </li>
            <li>
              <label>密码</label>
              <input class="input" id="T_pwd" type="password" value="" maxlength="16"  name="password">
            </li>
          </ul>
          <div class="login-check">
            <input type="checkbox" name="checkbox" style=" width:auto;" />
            <label>记住我</label>
            <a href="#">忘记登录密码？</a> </div>
          <div class="login-button">
            <input type="hidden" value="" name="carid" class="ordercarid" />
            <input type="hidden" value="" name="carstatus" class="orderstatus" />
            <input type="button"  value="登&nbsp;&nbsp;&nbsp;&nbsp;陆" class="fM" onclick="ok()" />
             <span id="msg1"style="font-family:华文中宋; font-size:large; color:red; "></span>
               </div>
          <!--<div class="security-pro">
			            <i class="icons ver-green-down"></i>
			            <b>您的信息已通过256位SGC加密保护，数据传输安全</b>
			        </div>-->
        </form>
      </div>
      <div class="p-dl">
        <form class="registForm" name="reg" id="reg">
          <ul class="login-items">
            <li class="clearfix">
              <input class="input"  name="mobile" id="mobile" type="text" value="" placeholder="手机号码（登录帐号）">
            </li>
            <li class="clearfix">
              <input class="input left" id="T_yzm" type="text" value=""  name="verify" placeholder="输入验证码" style="width:100px;" />
               <div id="send">
                    <input type="button" "send_code right" id="btn" style="width:150px;" value="免费获取验证码" onClick="send(this)"/>
                
                   <%--<a   class="send_code right">获取验证码</a>--%></div>
            </li>
            <li class="clearfix">
              <input class="input" id="nickname" type="text" value=""  name="realname" placeholder="姓名">
            </li>
            <li class="clearfix sex">
              <input type="radio" checked="" name="gender" value="M" />
              男&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="radio" name="gender" value="F" />
              女 </li>
            <li class="clearfix">
              <input id="pwd"  class="input" type="password" name="password" value="" placeholder="输入密码（六位字符）">
            </li>
          </ul>
          <div class="login-button">
            <input type="hidden" value="" name="carid" class="ordercarid" />
            <input type="hidden" value="" name="carstatus" class="orderstatus" />
            <input type="button"  value="立即注册" class="fM" onclick="regist()" />
              <span id="msg2"style="font-family:华文中宋;font-size:large; color:red; "></span>
             
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<!--会员登录和注册弹出框结束-->


<script type="text/javascript" src="js/jquery.SuperSlide.2.1.1.js"></script> 
<script type="text/javascript" src="js/index.js"></script> 
<!--右侧滑动-->
<script type="text/javascript" src="js/miniBar.js"></script>
<script type="text/javascript" src="js/lg_reg.js"></script>




</body>


</html>
