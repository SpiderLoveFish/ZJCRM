<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="qq_rebind.aspx.cs" Inherits="XHD.CRM.qq_rebind" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <title>六家居客户营销系统</title>
    <link href="lib/ligerUI/skins/ext/css/ligerui-dialog.css" rel="stylesheet" />
    <script src="lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="JS/jquery.md5.js" type="text/javascript"></script>
    <script src="JS/XHD.js" type="text/javascript"></script>
    <script src="lib/ligerUI/js/plugins/ligerTextBox.js"></script>
    <script src="lib/ligerUI/js/plugins/ligerComboBox.js"></script>
    <script src="lib/ligerUI/js/plugins/ligerSpinner.js"></script>
    <script src="lib/ligerUI/js/plugins/ligerDateEditor.js"></script>
    <script src="lib/ligerUI/js/plugins/ligerRadio.js"></script>
    <script src="lib/ligerUI/js/plugins/ligerCheckBox.js"></script>

    <script src="lib/ligerUI/js/plugins/ligerForm.js"></script>
    <link href="CSS/input.css" rel="stylesheet" />
    <script src="lib/jquery-validation/jquery.validate.js"></script>
    <script src="lib/jquery-validation/jquery.metadata.js"></script>
    <script src="lib/jquery-validation/jquery.validate.min.js"></script>
    <script>
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
            $("form").ligerForm();

            //$("#divMain")
            //document.getElementById("divMain").to
            debugger;
            var aa = document.body.clientHeight; //网页 可见区域的高度
            var dd = aa / 2; //网页 当前屏幕的50%的高度
            var cc = dd - 140;//100 是center 高度除以2得来的


            var cw = document.body.clientWidth;
            cw = cw / 2;
            cw = cw - 160;

            var divgv = document.getElementById("divMain");

            divgv.style.top = cc + "px";
            divgv.style.left = cw + "px";

            $.get("data/qqMessageList.ashx?Action=GetUserInfoLoginType&rnd=" + Math.random(), function (data, textStatus) {
 
                if (data != 'ab') {
                    var jsondata = eval('(' + data + ')');
                    $("#div_nc").html(jsondata.qqnc);
                    $("#imgheader").attr("src", jsondata.face);
                }
            });
        })
        var FromUrl = encodeURIComponent("main.aspx");
        function dologin() {
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

            $.ajax({
                type: 'post', dataType: 'json',
                url: 'Data/qqMessageList.ashx',
                data: [
                { name: 'Action', value: 'loginRebind' },
                { name: 'username', value: uid },
                { name: 'password', value: $.md5(pwd) },
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
                            case 5:
                                alert("此账号已经绑定QQ号码，不允许重复绑定！");
                                break;
                            case 998:
                                alert("非法打开页面，将为你跳转到登录界面！");
                                location.href = decodeURIComponent("login.aspx");
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

        function cancel() {
            location.href = decodeURIComponent("login.aspx");
        }
    </script>
    <style>
        .header {
            position: absolute;
            top: 5px;
            width: 95%;
            height: 100px;
            text-align: left;
        }
    </style>
</head>
<body>
    <form id="form1" style="width: 100%" runat="server"></form>
    <div id="divMain" class="header">
        <table style="width: 220px; margin: 5px;" class='bodytable1'>
            <tr>
                <td colspan="2" class="table_title1" style="text-align: center">QQ登录账号绑定</td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <img id="imgheader" width="100" height="100" />
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">QQ昵称： <span id="div_nc"></span>
                    <br />
                    <span style="color: red">对不起，该QQ未绑定系统账号，请绑定</span>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">账号：</div>
                </td>
                <td>
                    <input type="text" id="T_uid" name="T_uid" ltype="text" ligerui="{width:136}" validate="{required:true}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">密码：</div>
                </td>
                <td>
                    <input id="T_pwd" name="T_pwd" type="password" ltype="password" ligerui="{width:136}" validate="{required:true}" /></td>
            </tr>
            <tr>
                <td colspan="2" class="table_title1" style="text-align: center">
                    <input type="button" value="绑定" style="width: 40px; height: 20px" onclick="dologin()" />
                    <input type="button" value="取消" style="width: 40px; height: 20px" onclick="cancel()" />
                </td>
            </tr>
        </table>
    </div>


</body>
</html>
