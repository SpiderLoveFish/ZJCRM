<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/login.css" type="text/css" rel="stylesheet" />

 <script src="lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="JS/jquery.md5.js" type="text/javascript"></script>
    <script src="JS/remember.js" type="text/javascript"></script>
    <script src="JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        var isPostBack = "<%=IsPostBack%>";
        var varCODE = "11";
        $(function () {
            $("#telyz").hide(); 
            var isshow = false;
            $("#T_validate").focus(function () {
                $.ajax({
                    type: 'post', dataType: 'json',
                    url: 'Data/login.ashx',
                    data: { Action: 'checkyzm', username: $("#T_uid").val(), rnd: Math.random() }, /* 注意参数的格式和名称 */
                    //contentType: "application/json; charset=utf-8",
                    //dataType: "json",
                    success: function (result) {
                        if (result == true) {
                            $("#telyz").show();
                            isshow = true;
                        }
                        else if (result == false) {
                            isshow = true;
                            $("#telyz").show();
                            alert("此帐号未维护手机号，请联系管理员！");
                        }
                        else { }
                    }
                });
            });
            $("#T_uid,#T_pwd,#T_validate").blur(function () {
                $.ajax({
                    type: 'post', dataType: 'json',
                    url: 'Data/login.ashx',
                    data: { Action: 'checkyzm', username: $("#T_uid").val(), rnd: Math.random() }, /* 注意参数的格式和名称 */
                    //contentType: "application/json; charset=utf-8",
                    //dataType: "json",
                    success: function (result) {
                        if (result == true)
                        {
                            $("#telyz").show();
                            isshow = true;
                        }
                        else if (result == false)
                        {
                            isshow = true;
                            $("#telyz").show();
                            alert("此帐号未维护手机号，请联系管理员！");
                        }
                        else { }
                    }
                });
               
              //  $("#T_uid").css("background-color", "#D6D6FF");
            });
            $.ajax({
                type: "GET",
                url: "data/sys_info.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'getinfo', rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    var obj = eval(result);
                    var rows = obj.Rows;

                    //document.title =rows[0].sys_value + "CRM客户关系管理系统-小黄豆CRM";                    
                    $("#logo").attr("src", rows[1].sys_value);
                }
            });

            if (isPostBack == "False") {
                GetLastUser();
            }

            delCookie("xhdcrm_show_wellcome")
            if (getCookie("xhdcrm_uid") && getCookie("xhdcrm_uid") != null)
                $("#T_uid").val(getCookie("xhdcrm_uid"))

            var FromUrl = getQueryStringByName("FromUrl");
            if (!FromUrl) {
                FromUrl = encodeURIComponent("main.aspx");
            }
            $(document).keydown(function (e) {
                if (e.keyCode == 13) {
                    dologin();
                }
            });
           
            $("#login").click(function () {
               
                if ($("#login").val() == "登录")
                    dologin();
                else if ($("#login").val() == "验证")
                {
                    var yzm = $('#T_yzm').val();
                    if (yzm.toUpperCase() != varCODE) 
                    {
                    alert("手机验证码错误！");
                    $("#T_yzm").focus();
                    return;
                    }
                    location.href = decodeURIComponent(FromUrl);
                }
            });
            $("#reset").click(function () {
                $(":input", "#form1").not(":button,:submit:reset:hidden").val("");
            });
            function dologin() {
                var uid = $("#T_uid").val();
                var pwd = $("#T_pwd").val();
                var validate = $("#T_validate").val();
                if (validate == "") {
                    alert("验证码不能为空！");
                    $("#T_validate").focus();
                    return;
                }
                else if (validate.length != 4) {
                    alert("验证码错误！");
                    $("#T_validate").focus();
                    return;
                }

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
               
                if (isshow) { 
                   
                    var yzm = $('#T_yzm').val();
                     alert(yzm + varCODE);
                    if (yzm.toUpperCase() != varCODE) {
                        alert("手机验证码错误！");
                        $("#T_yzm").focus();
                        return;
                    }
                }
                $.ajax({
                    type: 'post', dataType: 'json',
                    url: 'Data/login.ashx',
                    data: [
                    { name: 'Action', value: 'login' },
                    { name: 'username', value: uid },
                    { name: 'password', value: $.md5(pwd) },
                    { name: 'validate', value: validate },
                    { name: 'rnd', value: Math.random() }
                    ],
                    success: function (result) {
                        if (typeof (result) == "number") {
                            switch (result) {
                                case 0:
                                    alert("验证码错误！");
                                    $("#validate").click();
                                    $("#T_validate").val("");
                                    $("#T_validate").focus();
                                    break;
                                case 1:
                                    alert("用户名或密码错误！");
                                    $("#T_pwd").focus();
                                    break;
                                case 2:
                                    SetCookie("xhdcrm_uid", uid, 30);
                                    SetCookie("xhd_crm_show_wellcome", "1");
                                    SetCookie("screenlock", "1", 300);
                                    SetCookie("screenpwd", pwd, 300)
                                    location.href = decodeURIComponent(FromUrl);
                                    break;
                                case 3:
                                    alert("账户异常，请联系管理员！");
                                    break;
                                case 4:
                                    alert("账户已限制登录！");
                                    break;
                                case 5:
                                    $("#telyz").show();
                                    $("#login").val("验证");
                                    alert("账号需要验证手机号码，请点击短信验证码！");
                                    break;
                                case 6:
                                    alert("此帐号未维护手机号，请联系管理员！");
                                    break;
                                default:
                                    break;
                            }
                        }
                        else {
                            alert('登陆失败,账号或密码有误!');
                            $("#password").focus();
                            return;
                        }
                    },
                    error: function () {
                        $("#validate").click();
                        alert('发生系统错误,请与系统管理员联系!');
                    },
                    beforeSend: function () {
                        $.ligerDialog.waitting("正在登陆中,请稍后...");
                        $("#lgoin").attr("disabled", true);
                    },
                    complete: function () {
                        $.ligerDialog.closeWaitting();
                        $("#login").attr("disabled", false);
                    }
                });
            }
        })

        function qq_login() {
            $.get("Data/login.ashx?Rnd=" + new Date().getTime(),
            {
                Action: "qq_login"
            },
            function (data) {
                location.href = data;
            });
        }


        var wait = 60;
        function time(o) {
            if (wait == 0) {
                o.removeAttribute("disabled");
                o.value = "免费获取验证码";
                wait = 60;
            } else {
                o.setAttribute("disabled", true);
                o.value = "重新发送(" + wait + ")";
                wait--;
                setTimeout(function () {
                    time(o)
                },
                    1000)
            }
        }
        function send(e) {
            time(e);
             createCode();
            if (varCODE == "") {
                alert('验证码生成失败，关闭页面重新生成。');
                return;
            }
            var paras = { 'code': varCODE };

            $.ajax({
                type: "GET",
                url: "Data/website.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'Send_aliyunSendSMS', tel: '', uid: $("#T_uid").val(), type: 6, para: JSON.stringify(paras), rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    if (result == true) {
                        alert('发送成功！！'+result);

                    }
                    else if (result == false) {
                        alert('发送失败！！' + result);
                    }

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                }
            });



        }

        var code; //在全局 定义验证码  
        function createCode() {
            code = "";
            var codeLength = 4;//验证码的长度  

            var selectChar = new Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'K', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');//所有候选组成验证码的字符，当然也可以用中文的  

            for (var i = 0; i < codeLength; i++) {


                var charIndex = Math.floor(Math.random() * 31);
                code += selectChar[charIndex];


            }
            varCODE = code;


        }

        

    </script>
    <script type="text/javascript">
        if (top.location != self.location) top.location = self.location;
    </script>

</head>

<body>
  <div class="box1">
    <div class="box2">
      <h1> <img id="logo" alt="" style="height: 42px; margin-left: 5px; margin-top: 2px;" /></h1>
      
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="30%" align="right">用户：</td>
    <td width="40%"><input id="T_uid" name="T_uid" type="text" class="box_inp1"/></td>
    <td width="30%"></td>
  </tr>
  <tr>
    <td align="right">密码：</td>
    <td><input  id="T_pwd" name="T_pwd"  type="password" class="box_inp1"/></td>
    <td><a  name="forget" id="forget" href="View/forgetPwd/forgetPwd1.htm">忘了密码</a> </td>
  </tr>
  <tr>
    <td align="right">验证码：</td>
    <td> <input id="T_validate" name="T_validte" type="text" class="box_inp2"/><img src="ValidateCode.aspx" alt="看不清楚，换一张" name="validate" width="75" height="25" id="validate" title="看不清楚，换一张" onclick="this.src=this.src+'?'" />
      </td>
    <td>&nbsp;</td>
  </tr>
          <tr id="telyz">
    <td align="right">手机验证：</td>
    <td> <input id="T_yzm" name="T_yzm" type="text" class="box_inp2"/>  
      </td>
              <td><input type="button" class="l-button" id="btn"   value="获取验证码" onClick="send(this)" /></td>
   
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="image" src="images/login06.png" value="登录" name="login" id="login" /></td>
    <td> <input type="BUTTON" name="FullScreen" value="全屏" class="box_inp2" onClick="window.open(document.location, 'big', 'fullscreen=yes')">
   </td>
  </tr>
</table>
    </div>
    </form>
    <div class="copy">三人行 技术支持</div>
    <form> <div align="center"> &nbsp;</div> </form> 
  </div>
</body>
</html>
