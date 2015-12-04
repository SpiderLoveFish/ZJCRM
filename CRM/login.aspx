<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <title>六家居装企管理系统</title>
    <link rel="stylesheet" type="text/css" href="css/login.css" />
    <script src="lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="JS/jquery.md5.js" type="text/javascript"></script>
    <script src="JS/remember.js" type="text/javascript"></script>
    <script src="JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        var isPostBack = "<%=IsPostBack%>";
        $(function () { 
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
                dologin();
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
                                    location.href = decodeURIComponent(FromUrl);
                                    break;
                                case 3:
                                    alert("账户异常，请联系管理员！");
                                    break;
                                case 4:
                                    alert("账户已限制登录！");
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
    </script>
    <script type="text/javascript">
        if (top.location != self.location) top.location = self.location;
    </script>
</head>
<body>
    <div id="wrap">
        <div id="Login">
            <div class="box">
                <p class="a01">
                    <img src="images/login01.jpg" alt="六家居装企管理系统" /></p>
                <dl>
                    <dt>
                        <table width="200" border="0">
                            <tr>
                                <td>自定义图标即将开放</td>
                            </tr>
                        </table>
                    </dt>

                </dl>
                <table width="325" summary="登录页面" class="a02">
                    <tr>
                        <th width="56">用户名：</th>
                        <td colspan="3">
                            <input id="T_uid" name="T_uid" type="text" class="a03" /></td>
                    </tr>
                    <tr>
                        <th>密  &nbsp;码：</th>
                        <td colspan="3">
                            <input id="T_pwd" name="T_pwd" type="password" class="a04" /></td>
                    </tr>
                    <tr>
                        <th>验证码：</th>
                        <td colspan="3">
                            <input id="T_validate" name="T_validte" type="text" class="a05" />
                            <img src="ValidateCode.aspx" alt="看不清楚，换一张" name="validate" width="75" height="25" id="validate" title="看不清楚，换一张" onclick="this.src=this.src+'?'" /></td>
                    </tr>
                    <tr>
                        <th style="padding-bottom: 0;">&nbsp;</th>
                        <td width="27" style="padding-bottom: 0;">
                            <input name="T_remember_user" type="checkbox" value="" /></td>
                        <td width="226" colspan="2" style="padding-bottom: 0;">记住用户名</td>
                    </tr>
                    <tr>
                        <th style="padding-top: 0; padding-bottom: 15px;">&nbsp;</th>
                        <td style="padding-top: 0; padding-bottom: 15px;">
                            <input name="T_remember_user_pwd" type="checkbox" value="" /></td>
                        <td colspan="2" style="padding-top: 0; padding-bottom: 15px;">记住用户名和密码</td>
                    </tr>
                    <tr>
                        <th>&nbsp;</th>
                        <td></td>
                        <td valign="middle">
                            <input type="image" src="images/login06.jpg" name="login" id="login" /></td>
                        <td valign="middle"><a href="#">
                            <img src="Images/bt_blue_76X24.png" width="76" height="24" onclick="qq_login()" /></a></td>
                    </tr>
                </table>
                </form>
            </div>
            <!-- #main-->
        </div>
        <!--container-->
    </div>
    <!--#wrap-->

</body>
</html>
