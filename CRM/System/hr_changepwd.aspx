<%@ Page Language="C#" AutoEventWireup="true"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head  >
    <title></title>
    <link href="../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />    

    <script src="../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    
    <script src="../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    
    <script src="../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../JS/XHD.js" type="text/javascript"></script>
    <script src="../lib/jquery.form.js" type="text/javascript"></script>
    <script type="text/javascript">
        var varCODE = "";
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            //$("#T_Contract_name").focus();
            $("form").ligerForm();
        });

        function f_save() {
            if ($("#T_yzm").val() == varCODE) {
                if ($(form1).valid()) {
                    var sendtxt = "&Action=changepwd";
                    var issave = $("form :input").fieldSerialize() + sendtxt;
                    $.ajax({
                        url: "../data/hr_employee.ashx", type: "POST",
                        data: issave,
                        success: function (responseText) {
                            if (responseText == "true") {
                                setTimeout(function () { parent.$.ligerDialog.close(); }, 100);
                            }
                            else {
                                $.ligerDialog.error('操作失败！请输入正确的原密码。');
                            }
                        },
                        error: function () {

                        }
                    });
                }
            } else {
                $.ligerDialog.error('验证码错误！。');
            }
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
        function send(e)
        {
            time(e);
            createCode();
            if (varCODE == "")
            {
                $.ligerDialog.error('验证码生成失败，关闭页面重新生成。');
                return;
            }
            $.ajax({
                type: "get",
                url: "../../data/sys_sms.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'GetMessage', yzm: varCODE, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    var obj = eval(result);
                   
                    for (var n in obj) {
                        if (obj.returnsms[n] == "null" || obj.returnsms[n] == null)
                            obj.returnsms[n] = "";
                      
                    }
                    if (obj.returnsms.returnstatus == "Success") {
                        alert('发送成功。' + obj.returnsms.message);
                    } else {
                        alert(obj.returnsms.message);
                    }
                   


                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("发送失败！");
                }
            });
        }

        var code; //在全局 定义验证码  
        function createCode() {
            code = "";
            var codeLength = 6;//验证码的长度  
            var checkCode = document.getElementById("checkCode");
            var selectChar = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');//所有候选组成验证码的字符，当然也可以用中文的  

            for (var i = 0; i < codeLength; i++) {


                var charIndex = Math.floor(Math.random() * 36);
                code += selectChar[charIndex];


            }
            varCODE = code;
                    alert(code);  
            //if (checkCode) //这里不是很懂,有高手可以解释下  
            //{
            //    checkCode.className = "code";
            //    checkCode.value = code;
            //}

        }

    </script>
</head>
<body style="margin:5px 5px 5px 5px">
    <form id="form1" onsubmit="return false">
                        
    <div>
        <table class="bodytable0" border="0" cellpadding="3" cellspacing="1" 
            style="background: #fff; width:280px;">
            
            <tr>
                <td height="23" width="70px" ><div align="right" style="width: 61px">
                    原密码：</div></td>
                <td height="23" >
                        <input type="password" id="T_oldpwd" name="T_oldpwd"    ltype="password" ligerui="{width:180}" 
                            validate="{required:true,minlength:4,maxlength:25,messages:{required:'请输入原密码'}}"  />
                    
                </td>
            </tr>

            <tr>
                <td height="23" width="70px" ><div align="right" style="width: 61px">
                    新密码：</div></td>
                <td height="23" >
                    <div style="float:left; height: 20px;">
                        <input type="password" id="T_newpwd"  name="T_newpwd"   ligerui="{width:180}" 
                             validate="{required:true,minlength:4,maxlength:25,messages:{required:'请输入新密码'}}" ltype="password"  />
                    </div>
                    
                </td>
            </tr>

             <tr>
                <td height="23" width="70px" >
                    <div align="right" style="width: 62px">确认密码：</div>
                    
                 </td>
                <td height="23" >
                    <div style="float:left; height: 20px;">
                        <input type="password" id="T_confime" name="T_confime"  ligerui="{width:180}" 
                             validate="{required:true,minlength:4,maxlength:25,equalTo:'#T_newpwd',equalTo:'#T_newpwd',messages:{required:'请再次输入新密码'}}" ltype="password" />
                    </div>
                    
                </td>
            </tr>

             <tr>
            
                    <td height="23" width="70px">验证码</td>
                    <td height="23"> <input type="text" id="T_yzm" name="T_yzm" ligerui="{width:180}"  ltype="text"/></td>
                   <td>
                       <input type="button" class="l-button" id="btn" style="width:150px;" value="免费获取验证码" onClick="send(this)"/>
                        <%--<a id="btnsend" class="l-button"  position="right" style="width:150px;" onClick="send(this)">
                          发送短信
                      </a>--%>
                       
                   </td>
            </tr>

             </table>
    </div>
    </form>
</body>
</html>
