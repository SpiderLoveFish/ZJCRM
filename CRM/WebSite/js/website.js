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
    $.ajax({
        type: "get",
        url: "../data/website.ashx", /* 注意后面的名字对应CS的方法名称 */
        data: { Action: 'GetMessage', tel: $("#mobile").val(), yzm: varCODE, rnd: Math.random() }, /* 注意参数的格式和名称 */
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {

            var obj = eval(result);

            for (var n in obj) {
                if (obj.returnsms[n] == "null" || obj.returnsms[n] == null)
                    obj.returnsms[n] = "";

            }
            if (obj.returnsms.returnstatus == "Success") {
                alert('短信发送成功。注意查收！' + obj.returnsms.message);
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
    //  alert(code);  
    //if (checkCode) //这里不是很懂,有高手可以解释下  
    //{
    //    checkCode.className = "code";
    //    checkCode.value = code;
    //}

}
