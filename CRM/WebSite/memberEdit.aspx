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

                $('.mr-tab a').each(function (index) {
                    $(this).click(function () {
                        $(this).addClass('on').siblings().removeClass('on');
                        $('.me-dl').eq(index).show().siblings().hide();
                    })
                });
            });

            function loginin(nickname) {
                // alert(nickname);
                var html =   ' 你好：' + nickname + '|<a href="#" id="b-tuichu">退出</a>|&nbsp;&nbsp;&nbsp;&nbsp;400-0512-004	';
                $('#rightMenuHtml').html(html);

                var htmlhy = " <h2>尊敬的会员 <b>" + nickname + "</b></h2>  <p> 手机：" + getCookie("website_uid") + "       </p>";
                $('#divhy').html(htmlhy);

                $('#mobile').val(getCookie("website_uid"));
                $('#realname').val(nickname);
                if (getCookie("website_sex")=="M")
                    $('input:radio[name=gender]')[0].checked = true;
                else $('input:radio[name=gender]')[1].checked = true;
               // $("[name='gender']").filter(":checked")
                //$('#realname').val(getCookie("website_sex"));
                $('#email').val(getCookie("website_village"));
            }
            //function update()
            //{
            //    alert(1);
            //}
            //function changepwd()
            //{ alert(21); }
         
            function checkpost() {
                var mobile = editM.mobile.value;//手机号
                var realname = editM.realname.value;//手机号
                var gender = editM.gender.value;// 
                var email = editM.email.value;//小区
                var Yemail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/; //邮箱验证
 
                if (realname.length > 10) {
                    alert("姓名要不得大于10个字符");
                    editM.realname.focus();
                    return false;
                }
                //!Yemail.exec(email) &&
                //if ( email != '') {
                //    alert("邮箱格式不正确");
                //    editM.email.focus();
                //    return false;
                //}
                $.ajax({
                    url: "../data/website.ashx", type: "POST",
                    data: { Action: "reg", id: 0, tel: mobile, nickname: realname, sex: gender, xq: email, rnd: Math.random() },
                    success: function (responseText) {
                        {
                            if (responseText == "true") {
                                alert("修改成功!");
                                SetCookie("website_nickname", realname, 30);
                            }
                        }
                    },
                    error: function () {
                        alert("修改失败!");
                        return;
                    }
                });
                return false;
            }
            function checkPasspost() {
                var password = editP.password.value;//性别
                var password1 = editP.password1.value;//密码
                var password2 = editP.password2.value;//密码
                var Ypass = /\S{6,}/;//密码验证
                
                if (!password1) {
                    alert("请输入新密码");
                    editP.password1.focus();
                    return false;
                }
                if (!password2) {
                    alert("请重复输入新密码");
                    editP.password2.focus();
                    return false;
                }
                if (password1 != password2) {
                    alert("两次新密码输入不同");
                    editP.password1.focus();
                    return false;
                }
                if (!Ypass.exec(password1)) {
                    alert("密码格式不正确，必须以字母开头的6-16 字母，数字");
                    editP.password1.focus();
                    return false;
                }
                $.ajax({
                    url: "../data/website.ashx", type: "POST",
                    data: { Action: "reg", id: 0, pwd: $.md5(password1), tel: getCookie("website_uid"), rnd: Math.random() },
                    success: function (responseText) {
                        {
                            if (responseText == "true") {
                                alert("密码修改成功!请重新登录！");
                                SetCookie("website_uid", null, 30);
                                SetCookie("website_nickname", null, 30);
                                location.href = "index.aspx";
                            }
                        }
                    },
                    error: function () {
                        alert("修改失败!");
                        return;
                    }
                });
                return false;
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
                  <a id="MemberMenuChange" class="b-login" onclick="member()">个人中心</a>
      </div>
				<span class="right" id="rightMenuHtml">
        <a href="#">登录</a>|<a href="#" id="b-tuichu">退出</a>|&nbsp;&nbsp;&nbsp;&nbsp;
			</span>
		</div>
	</div>

</div>

<div id="div2">
	<div class="mebBox">
		<div class="meb-cont clearfix wrap">
			<div class="meb-nav left dInline">
				<ul class="clearfix">
					<li ><a href="member.aspx">会员中心</a></li>
                   <%-- <li ><a href="#">我的设计</a></li>--%>
          
                    <li class="on"><a href="#">账户管理</a></li>				
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
<%-- 开始 --%>
	<div class="mr-detail">
					<div class="mr-tab clearfix">
						<a class="on">个人资料管理 </a>
                        <a>修改密码</a>
					</div>
					<div class="me-box me-box1">
						<div class="me-dl" style="display:block;">
							<div class="me-one">
								<div class="accForm">
									<form action="" enctype="multipart/form-data" name="editM" method="post" onsubmit="return checkpost();">
										<div class="afl clearfix">
											<label class="left">
												手机号码
											</label>
											<div class="af-r left dInline">
												<input type="text" id="mobile" class="ar-txt" name="mobile" placeholder="请输入手机号码" value="15138911875" disabled="disabled" />
											</div>
										</div>
										<div class="afl clearfix">
											<label class="left">
												姓名
											</label>
											<div class="af-r left dInline">
												<input type="text" class="ar-txt" id="realname" name="realname" placeholder="请输入您的姓名" value="董平运" />
											</div>
										</div>
										<div class="afl clearfix">
											<label class="left">
												性别
											</label>
											<div class="af-r left dInline">
												<span>
													<input type="radio" name="gender" value="M"> 男
												</span>
												<span>
													<input type="radio" name="gender" checked="" value="F"> 女
												</span>											</div>
										</div>
										<div class="afl clearfix">
											<label class="left">
												小区
											</label>
											<div class="af-r left dInline">
												<input type="text" class="ar-txt" id="email"  name="email" placeholder="请输入您的小区" value="" />
											</div>
										</div>
										<div class="afl clearfix">
											<label class="left">
											</label>
											<div class="af-r left dInline">
												<input type="submit" value="提 交"  class="ar-btn">
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
                        <div class="me-dl" style="display:block;">
							<div class="me-one">
								<div class="accForm">
									<form action="" enctype="multipart/form-data" name="editP" method="post" onsubmit="return checkPasspost();">
										<div class="afl clearfix">
											<label class="left">
												当前密码
											</label>
											<div class="af-r left dInline">
												<input type="password" class="ar-txt" name="password" placeholder="请输入当前密码" value="" />
											</div>
										</div>
										<div class="afl clearfix">
											<label class="left">
												新密码
											</label>
											<div class="af-r left dInline">
												<input type="password" class="ar-txt" name="password1" placeholder="请输入新密码" value="" />
											</div>
										</div>
										<div class="afl clearfix">
											<label class="left">
												确认新密码
											</label>
											<div class="af-r left dInline">
												<input type="password" class="ar-txt" name="password2" placeholder="请确认输入的新密码" value="" />
											</div>
										</div>
										<div class="afl clearfix">
											<label class="left">
											</label>
											<div class="af-r left dInline">
												<input type="submit" value="提 交"   class="ar-btn">
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
<%-- 结束 --%>


	 		</div>
		</div>
	</div>
</div>


<!--底部的开始-->
<div id="footer">
  <div class="foot-a">
  </div>
  <div class="foot-b"> Copyright © 2007 - 2016 昆山心成装饰设计工程有限公司 版权所有 苏ICP备09040162号 <br/>
 
     </div>
</div>
<!--底部的结束-->
<!--footer部分结束-->
<div id="miniBus" style="right:-270px;">
	<div class="mini-cont">
		<div class="mini-contlist">
		 </div>
	</div>
 </div>
 
<script type="text/javascript" src="js/miniBar.js"></script>
<script type="text/javascript" src="js/lg_reg.js"></script>

 
</body>
</html>