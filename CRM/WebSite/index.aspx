<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/base.css">
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
            var startstr = 0;
            var startnum = 0;
            var searchnum = 10;
            var varCODE = "code";
             LazyLoad.css(["css/cityStyle.css"], function () {
                LazyLoad.js(["js/cityScript.js"], function () {
                    var test = new citySelector.cityInit("inputcity");
                   });
            });
          
             $(function () {
                 ajax_tesstfpId();
                 //ajax_lists('3FO4JOMIUHXP');
              //  if (getCookie("website_uid") == null || getCookie("website_uid") == 'null' || getCookie("website_uid") == "" || getCookie("website_uid") == undefined)
              //  { }
              //  else
              //      loginin(getCookie("website_nickname"))

              //ajaxhxtapi($('#keyword1').val());
          
             });

             function ajax_tesstfpId() {
                 $.ajax({
                     url: "../data/website.ashx", type: "POST",
                     data: { Action: "test", fpId: '3FO4J1G598MG', strstart: 0, num: 999, rnd: Math.random() },
                     success: function (responseText) {
                         alert(JSON.stringify(responseText));
                     },
                     error: function (XMLHttpRequest, textStatus, errorThrown) {
                         alert(XMLHttpRequest.status);

                     }
                 });
             }

             function ajax_romminfos(fpId) {
                 $.ajax({
                     url: "../data/SingleSignOn.ashx", type: "POST",
                     data: { Action: "floorplanlists", fpId: fpId, strstart: 0, num: 999, rnd: Math.random() },
                     success: function (responseText) {
                         alert(JSON.stringify(responseText));
                     },
                     error: function (XMLHttpRequest, textStatus, errorThrown) {
                         alert(XMLHttpRequest.status);

                     }
                 });
             }
             function ajax_romminfos(fpId) {
                 $.ajax({
                     url: "../data/SingleSignOn.ashx", type: "POST",
                     data: { Action: "floorplanlists", fpId: fpId, strstart: 0, num: 999, rnd: Math.random() },
                     success: function (responseText) {
                         alert(JSON.stringify(responseText));
                     },
                     error: function (XMLHttpRequest, textStatus, errorThrown) {
                         alert(XMLHttpRequest.status);

                     }
                 });
             }
            function ajax_lists(desId) {
                $.ajax({
                    url: "../data/SingleSignOn.ashx", type: "POST",
                    data: { Action: "roomlists", desId: desId, strstart: 0, num: 999, rnd: Math.random() },
                    success: function (responseText) {
                        alert(JSON.stringify(responseText));
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(XMLHttpRequest.status);

                    }
                });
            }
            

        //搜索户型图接口
            function ajaxhxtapi(keystr) {
                //x选择城市
                var ciid = 166;
                if ($('#cityid').val() != undefined)
                    ciid = $('#cityid').val();
                if (keystr == undefined) keystr = "";
            $.ajax({
                url: "../data/website.ashx", type: "POST",
                data: { Action: "gethxtapi", uid: 'admin', cityid: ciid, keystr: keystr, strstart: startnum,searchnum:searchnum, rnd: Math.random() },
                success: function (responseText) {
                    // alert(responseText);
                    var obj = eval(responseText);
                    var html = "";
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";

                        var names = obj[n].name;
                        if (names.length >= 15) names = names.substr(0, 15) + '...';

                        html += '    <li class="pve"> ' +
                        '<a href="#" target="_blank"></a>' +
                        ' <div class="car-pic">' +
                        '   <img src=' + obj[n].pics + '@!200x200   /> ' +
                        '  </div>'+ 
                        '  <h3>' + obj[n].commName + ' </h3>'+
                        '  <div class="price">面积：' +
                        '  <span class="num nBlue">' + obj[n].srcArea + '</span><font> 平方米</font></div><p>户型：' + obj[n].specName + ' </p> ' +
                        ' <p><div class="login-button"><input type="button" class="fM"  style="cursor:pointer; width:160px; height:40px;" value="家装DIY" onclick="docreate(\'' + obj[n].obsPlanId + '\')" ></input></div></p>' +

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
                if (getCookie("website_uid") == undefined || getCookie("website_uid") == "" || getCookie("website_uid") == null)
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
            //查询
        function search()
            {
            //alert($('#keyword1').val());
            ajaxhxtapi($('#keyword1').val());
        }
            //更多
        function more()
        {
            startstr++;
            startnum = startstr * searchnum;
            ajaxhxtapi($('#keyword1').val() );
        }
       
            //登录
        function ok()
        {
            var uid = $("#T_uid").val();
            var pwd = $("#T_pwd").val();
            if (uid == "") {
                $('#msg1').html("登录失败!账号不能为空！");  
                $("#T_uid").focus();
                return;
            }
            if (pwd == "") {
                $('#msg1').html("登录失败!密码不能为空！");  
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
                   
                    if (responseText == "[]" || responseText == "null" || responseText == undefined)
                    {
                          $('#msg1').html("登录失败!用户名或密码错误！");
                        return;
                    }
                   //alert(responseText);
                    var obj = eval(responseText);
                     for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                        if (obj[0].tel != null && n == 0) {
                            if ($('#ck').is(':checked'))
                            {
                                SetCookie("website_uid", obj[0].tel, 60*30);
                                SetCookie("website_nickname", obj[0].nickname, 60 * 30);
                                SetCookie("website_sex", obj[0].sex, 60 * 30);
                                SetCookie("website_village", obj[0].village, 60 * 30);
                            }
                            else
                            {
                                SetCookie("website_uid", obj[0].tel, 30);
                                SetCookie("website_nickname", obj[0].nickname, 30);
                                SetCookie("website_sex", obj[0].sex,  30);
                                SetCookie("website_village", obj[0].village,  30);
                            }
                            loginin(obj[0].nickname);
                        }
                     }
                    

                },
                error: function () {
                    $('#msg1').html("登录失败!");
                }
            });

            

          
        }

            //注册
        function regist()
        {
            
            var mobile = $("#mobile").val();
            //alert(mobile);
            var nickname = $("#nickname").val();
            //alert(nickname);
            var pwd = $("#pwd").val();
            var xq = $("#txtxq").val();
            //alert(pwd);
            var gender = document.getElementById("sex");
            
            //var gender = $("[name='gender']").filter(":checked");
            //alert(gender.attr("value"));
            //alert(varCODE);
            if ($("#T_yzm").val().toUpperCase() == varCODE) {
                $.ajax({
                    url: "../data/website.ashx", type: "POST",
                    data: { Action: "reg", tel: mobile, pwd: $.md5(pwd), nickname: nickname, sex: gender.value,xq:xq, rnd: Math.random() },
                    success: function (responseText) {
                        if (responseText == "false:tel")
                        {
                            alert("此手机已经注册过，请直接登录或找回密码!");
                        }
                        {
                            if (responseText == "true") {
                                alert("注册成功，已自动登录!");
                                SetCookie("website_uid", tel, 30);
                                SetCookie("website_nickname", nickname, 30);
                                loginin(nickname);

                            }
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
           // alert(nickname);
            var html =' 你好：' + nickname + '|<a href="#" id="b-tuichu">退出</a>|&nbsp;&nbsp;&nbsp;&nbsp;400-0512-004	';
            $('#rightMenuHtml').html(html);
            $('#popBox').fadeOut();
               
        }

        function add()
        {
            if (getCookie("website_uid") == undefined || getCookie("website_uid") == "" || getCookie("website_uid") == null) {
                $('.b-login').click();
            }
            else {
              
                viewkjl('kjl_edit.aspx?style=insert' + '&dest=4', "新增方案");
            }
        }

        function copyob1toob2() {
            
            $("#keyword1").val($("#keyword").val());
           
        }
        function copyob1toob() {
            $("#keyword").val($("#keyword1").val());
        } 
        function member()
        {
            if (getCookie("website_uid") == undefined || getCookie("website_uid") == "" || getCookie("website_uid") == null) {
                $('.b-login').click();
            }
            else {
                location.href = "member.aspx";
            }
        }

       function searchHot(keystr)
        {
            startstr = 0;
            ajaxhxtapi(keystr);
            $("#keyword1").val(keystr);
            $("#keyword").val(keystr);
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
      <!--<a href="shfw.html">售后服务</a>-->
      <a id="MemberMenuChange" class="b-login" onclick="member()">个人中心</a>
      </div>
        当前城市：<input type="text" style="width:40px;" class="file" readonly="readonly"   id="inputcity"  value="苏州" >
     <input type="hidden" id="cityid" value="166" />
    <span class="right" id="rightMenuHtml">
            
				 <a href="#" class="b-login" id="b-login">登录</a>|<a href="#" id="b-regist">注册</a>|&nbsp;&nbsp;&nbsp;&nbsp;400-0512-004		
                </span> </div>
  </div>
  <div class="head-search"> 
    <div class="wrap clearfix">

           <div class="yjxj clearfix left" action="/index/keyword/" method="post" enctype="multipart/form-data">     
 <input type="text" id="keyword" name="keyword" onkeyup="copyob1toob2()" placeholder="请输入小区名称" class="left" />
                      <script type="text/javascript">
                           var test = new Vcity.CitySelector({ input: 'keyword' });
</script>
        <input type="button" value="搜 索"  onclick="search()" class="right" />
      </div>
      <div class="hotWords left dInline"> <a  onclick="more()">换一批</a> 热门小区：
         <a  onclick="searchHot('新城域')">新城域</a><a  onclick="searchHot('新城柏丽湾')">新城柏丽湾</a>
              </div>
     
    </div>
  
  </div>

  </div>
<style type="text/css">
    .file {
    position: relative;
    display: inline-block;
    background: #fee703;
    border: 1px solid #fee703;
    border-radius: 4px;
    padding: 4px 18px;
    overflow: hidden;
    color: #000;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
 
    
   
}
.file input {
    position: absolute;
    font-size: 200px;
    right: 0;
    top: 0;
    opacity: 0;

}
.file:hover {
    background: #ffd800;
    border-color: #fff200;
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
          
      <input type="text" maxlength="" onkeyup="copyob1toob()" id="keyword1" name="keyword"  placeholder="请输入小区名称" class="left" />
      <input type="button" value=""  onclick="search()" class="right" />
        <script type="text/javascript">
            var test = new Vcity.CitySelector({ input: 'keyword1' });
</script>
    </form>

   </div>
  </div>
  
</div>
 
<div id="main">
   <div class="mDiv main-a">
    <div class="wrap">
          <div class="proMore"> 
<table width="100%" border="0">
  <tr>
      <td> <h1 class="left dInline"> 搜索户型结果 </h1></td>
       
    <td><a  onclick="more()">换一批</a></td>
      <td><a  onclick="more()">重新加载</a></td>
    <td><a  onclick="add()">自已画</a></td>
  </tr>
</table>
 </div>
      <div class="jpBox">
      
        <div class="jpCont">
          <div class="jpDl" style="display: block;">
            <ul id="ullist" class="clearfix">
           
               
              
            </ul>
            <div class="proMore"> <table width="100%" border="0">
  <tr>
    <td><a  onclick="more()">换一批</a></td>
        <td><a  onclick="more()">重新加载</a></td>
    <td><a  onclick="add()">自已画</a></td>
  </tr>
</table> </div>
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

<!--右侧内容的开始-->
<%--<div id="miniBus" style="right:-280px;">
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
	 </div>
	 
</div>--%>

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
              <label>手机号</label>
              <input class="input" id="T_uid" type="text" value="" maxlength="32"  name="username" placeholder="请输入您的手机号">
            </li>
            <li>
              <label>密码</label>
              <input class="input" id="T_pwd" type="password" value="" maxlength="16"  name="password">
            </li>
          </ul>
          <!--<div class="login-check">
            <input type="checkbox" name="checkbox" style=" width:auto;" />
            <label>记住我</label>
            <a href="#">忘记登录密码？</a> </div>-->
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
        <form  name="reg" id="reg">
          <ul class="login-items">
            <li>
                 <label>手机号</label>
             <input class="input"  name="mobile" id="mobile" type="text" value="" placeholder="手机号码（登录帐号）">
            </li>
            <li class="clearfix">
            <label>短信</label>  <input class="input left" id="T_yzm" type="text" value=""  name="verify" placeholder="输入验证码" style="width:100px;" />
               <div id="send">
                    <input type="button" "send_code right" id="btn" style="width:140px;height:42px" value="免费获取验证码" onClick="send(this)"/>
                
                   <%--<a   class="send_code right">获取验证码</a>--%></div>
            </li>
            <li class="clearfix">
              <label>姓&nbsp;&nbsp;名</label><input class="input" id="nickname" type="text" value=""  name="realname" placeholder="姓名" style="width:100px;">
                <select class="input" name="makeid"  id="Select1" placeholder="性别" style="width:140px; height:42px">
                    <option value=""> 选择性别</option>
                    <option value="男" >男</option>
                  <option value="女">女</option>
                    
                  </select>
            </li>
         
              <li class="clearfix">
             <label>小&nbsp;&nbsp;区</label><input type="text" width="20" class="cityinput" id="citySelect" placeholder="请输入小区">
	
	<!-- 以下仅测试IE6下的状况,不用管它 -->



<!-- 实例化 -->
<script type="text/javascript">
    var test = new Vcity.CitySelector({ input: 'citySelect' });
</script> </li>
            <li class="clearfix">
              <label>密&nbsp;&nbsp;码</label><input id="pwd"  class="input" type="password" name="password" value="" placeholder="输入密码（六位字符）">
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
<%--<script type="text/javascript" src="js/miniBar.js"></script>--%>
<script type="text/javascript" src="js/lg_reg.js"></script>




</body>


</html>
