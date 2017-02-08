//公司按面积报价专用
var tel;
function check() {
    //var hx = document.getElementById("hx").value;  
    document.getElementById("jmid").value = getQueryString("jmid");//参数
    document.getElementById("xingshi").value = document.getElementById("xing").value;
    //if (hx == 0) {
       
    //    alert("请输入面积！");
    //    return false;
    //}
   

    var phone = checkPone(document.getElementById("phone").value);
      tel =  document.getElementById("phone").value ;
    if (!phone) {
        return false;
    } else {
        document.getElementById("pho").value = document.getElementById("phone").value;
    }
    if (!tijiao()) {
        return false;
    }
    if (!xishi()) {
        return false;
    }
 
    

    //document.form1.submit();
    /* 验证手机 */
    var pho = document.getElementById("phone").value;
    try {
        xmlreq = new ActiveXObject("Msxml2.XMLHTTP"); // 针对IE5或之后
        // alert("IE5或之后");
    } catch (e) {
        try {
            xmlreq = new ActiveXObject("Microsoft.XMLHTTP");
            // alert("IE5之前");
        } catch (e2) {
            xmlreq = new XMLHttpRequest();
            // alert("M内核");
        }
    }

    if (!xmlreq) {
        alert("当前浏览器不支持Ajax效果");
        return;
    }
    //document.getElementById("hadpho").value = "Y";
    //document.form1.action = "../../CRM/ConsExam/kjl_search_bj.aspx?jmid=" + document.getElementById("jmid").value + "&keyword=" + document.getElementById("keyword").value + "&cityid=166" + "&tel=" + tel;
    //document.form1.submit();
     fxyzm();
    op();
  
    //url = "pho=" + pho;
    //var action = "checkpho.action";
    //xmlreq.open("POST", action, false);

    //// 2. 指定监听器函数(用于在服务端处理完毕后,动态跟新页面的数据)
    //xmlreq.onreadystatechange = function () {
    //    // 一般在监听器方式中需要操作 对象状态 以及 数据包状态
    //    // alert(xmlreq.readyState+","+xmlreq.status);
    //    if (xmlreq.readyState == 4) { // 成功完成
    //        if (xmlreq.status == 200) {

    //            var responseText = xmlreq.responseText;

    //            if ("Y" == responseText) {
    //                document.getElementById("hadpho").value = "Y";
    //                document.form1.submit();
    //            } else {
    //                document.getElementById("hadpho").value = "N";
    //                fxyzm();
    //                op();
    //                // changeValidateCode();
    //            }
    //        }
    //    }

    //}

    //xmlreq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    //xmlreq.send(url);
    //**验证手机end  **********************end********************************** *//*

}

function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}
//公司户型报价专用。checkgshxbj
function checkgshxbj() {
    if (document.getElementById("bomarea1").value == "平方米" || document.getElementById("bomarea1").value == "卧房") {
        document.getElementById("bomarea1").value = "0";
    }
    if (document.getElementById("bomarea2").value == "平方米" || document.getElementById("bomarea2").value == "客厅") {
        document.getElementById("bomarea2").value = "0";
    }
    if (document.getElementById("bomarea3").value == "平方米" || document.getElementById("bomarea3").value == "餐厅") {
        document.getElementById("bomarea3").value = "0";
    }
    if (document.getElementById("bomarea4").value == "平方米" || document.getElementById("bomarea4").value == "厨房") {
        document.getElementById("bomarea4").value = "0";
    }
    if (document.getElementById("bomarea5").value == "平方米" || document.getElementById("bomarea5").value == "阳台") {
        document.getElementById("bomarea5").value = "0";
    }
    if (document.getElementById("bomarea6").value == "平方米" || document.getElementById("bomarea6").value == "卫生间") {
        document.getElementById("bomarea6").value = "0";
    }

    //面积之和要大于10平方的判断
    var bomarea1 = document.getElementById("bomarea1").value;
    var bomarea2 = document.getElementById("bomarea2").value;
    var bomarea3 = document.getElementById("bomarea3").value;
    var bomarea4 = document.getElementById("bomarea4").value;
    var bomarea5 = document.getElementById("bomarea5").value;
    var bomarea6 = document.getElementById("bomarea6").value;
    document.getElementById("jmid").value = getQueryString("jmid");//参数
    document.getElementById("xingshi").value = document.getElementById("xing").value;
      tel = document.getElementById("phone").value;
    var bomareazong = Number(bomarea1) + Number(bomarea2) + Number(bomarea3) + Number(bomarea4) + Number(bomarea5) + Number(bomarea6);
    if (bomareazong == "" || bomareazong == null || bomareazong < 11) {
        alert("请完善各房间面积，房屋总面积必须大于10平方米");
        return false;
    }


    var phone = checkPone(document.getElementById("phone").value);
    if (!phone) {
        return false;
    } else {
        document.getElementById("pho").value = document.getElementById("phone").value;
    }
    if (!tijiao()) {
        return false;
    }
    if (!xishi()) {
        return false;
    }


    //document.form1.submit();
    /* 验证手机 */
    var pho = document.getElementById("phone").value;
    try {
        xmlreq = new ActiveXObject("Msxml2.XMLHTTP"); // 针对IE5或之后
        // alert("IE5或之后");
    } catch (e) {
        try {
            xmlreq = new ActiveXObject("Microsoft.XMLHTTP");
            // alert("IE5之前");
        } catch (e2) {
            xmlreq = new XMLHttpRequest();
            // alert("M内核");
        }
    }

    if (!xmlreq) {
        alert("当前浏览器不支持Ajax效果");
        return;
    }

    //            if ("Y" == responseText) {
                 //document.getElementById("hadpho").value = "Y";
                 //document.form1.submit();
    //            } else {
    //                document.getElementById("hadpho").value = "N";
                    fxyzm();
                    op();
    //                // changeValidateCode();
    //            }
    //$.ajax({
    //    type: "get",
    //    url: "../data/website.ashx", /* 注意后面的名字对应CS的方法名称 */
    //    data: { Action: 'GetMessage', tel: pho, yzm: code, rnd: Math.random() }, /* 注意参数的格式和名称 */
    //    contentType: "application/json; charset=utf-8",
    //    dataType: "json",
    //    success: function (result) {
    //        var obj = eval(result);

    //        for (var n in obj) {
    //            if (obj.returnsms[n] == "null" || obj.returnsms[n] == null)
    //                obj.returnsms[n] = "";

    //        }
    //        if (obj.returnsms.returnstatus == "Success") {
    //            alert('短信发送成功。注意查收！' + obj.returnsms.message);
    //        } else {
    //            alert(obj.returnsms.message);
    //        }
    //    },
    //    error: function (XMLHttpRequest, textStatus, errorThrown) {
    //        alert("发送失败！");
    //    }
    //});
    //url = "pho=" + pho;
    //var action = "checkpho.action";
    //xmlreq.open("POST", action, false);

    //// 2. 指定监听器函数(用于在服务端处理完毕后,动态跟新页面的数据)
    //xmlreq.onreadystatechange = function () {
    //    // 一般在监听器方式中需要操作 对象状态 以及 数据包状态
    //    // alert(xmlreq.readyState+","+xmlreq.status);
    //    if (xmlreq.readyState == 4) { // 成功完成
    //        if (xmlreq.status == 200) {

    //            var responseText = xmlreq.responseText;

    //            if ("Y" == responseText) {
    //                document.getElementById("hadpho").value = "Y";
    //                document.form1.submit();
    //            } else {
    //                document.getElementById("hadpho").value = "N";
    //                fxyzm();
    //                op();
    //                // changeValidateCode();
    //            }
    //        }
    //    }

    //}

    //xmlreq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    //xmlreq.send(url);
    //**验证手机end  **********************end********************************** *//*

}

function xxj() {
    document.getElementById("bom6").value = document.getElementById("xxj").value;
    alert(document.getElementById("bom6").value);
}

function yt() {
    document.getElementById("bom5").value = document.getElementById("yt").value;
    alert(document.getElementById("bom5").value);
}

//已不用有bdtg的js替代
function tijiao() {
    var city = "";

    var c1 = document.getElementById("cityid").value;
    var c2 = document.getElementById("inputcity").value; 
    if (c1 == "" || c2 == "") {
        alert("请选择对应城市！");
        return false;
    }
    return true;
}

function xishi() {
    if (document.getElementById("xing").value == "") {
        alert("请输入姓氏！");
        return false;
    }
    return true;
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
     return code
}

function savecustromer()
{
    $.ajax({
        type: "POST",
        url: "../../data/website.ashx", /* 注意后面的名字对应CS的方法名称 */
        data: { Action: 'SaveCustomer', tel: document.getElementById("pho").value, c: document.getElementById("xingshi").value, custmer: document.getElementById("jmid").value, rnd: Math.random() }, /* 注意参数的格式和名称 */
        //contentType: "application/json; charset=utf-8",
        //dataType: "json",
        success: function (result) {
            //var obj = eval(result);
            if (result == "true") {
                

            } else {
                alert("保存失败！");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("请求失败！~~");
        }
    });
}

    function fxyzm() {
        var random= createCode();
        /** **********************ajax生成要发到手机的验证码********************************** */
   
        document.getElementById("pho").value = document.getElementById("phone").value;
        var pho = document.getElementById("pho").value;
        var c1 = document.getElementById("cityid").value;
        var c2 = document.getElementById("inputcity").value;
        // alert(c1+","+c2+","+c3);
        try {
            xmlreq = new ActiveXObject("Msxml2.XMLHTTP"); // 针对IE5或之后
            // alert("IE5或之后");
        } catch (e) {
            try {
                xmlreq = new ActiveXObject("Microsoft.XMLHTTP");
                // alert("IE5之前");
            } catch (e2) {
                xmlreq = new XMLHttpRequest();
                // alert("M内核");
            }
        }

        if (!xmlreq) {
            alert("当前浏览器不支持Ajax效果");
            return;
        }
        $.ajax({
            type: "POST",
            url: "../../data/website.ashx", /* 注意后面的名字对应CS的方法名称 */
            data: { Action: 'aliyunSendSMS', tel: pho, yzm: random, rnd: Math.random() }, /* 注意参数的格式和名称 */
            //contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                var obj = eval(result);
                //alert(JSON.stringify(obj))
                //for (var n in obj) {
                //    if (obj.returnsms[n] == "null" || obj.returnsms[n] == null)
                //        obj.returnsms[n] = "";

                //}
                //if (obj.returnsms.returnstatus == "Success") {
                if(obj=="200")
                {
                    document.getElementById("rdm").value = random;
                    //alert('短信发送成功。注意查收！' + obj.returnsms.message);
              
                } else {
                    alert(obj.returnsms.message);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("发送失败！~~");
            }
        });

        alert("验证码已发送到您手机，若60秒后没收到验证码，请重新点击按钮。");
        document.getElementById("phone").value = "";
    }