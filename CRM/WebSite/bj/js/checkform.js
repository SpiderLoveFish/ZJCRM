function isNull(str) {
    var flag = false;
    if (str == "") {
        return flag;
    }
    var regu = "^[ ]+$";
    var re = new RegExp(regu);
    flag = re.test(str);
    if (flag) {
        return flag;
    }
    return true;

}
function checkNull(str) {
    if (str == "" || str.length < 1 || str.trim().length < 1) {
        alert("输入值为空");
        return false;
    }
    return true;
}

/*
 * 用途：检查输入对象的值是否符合整数格式 输入：str 输入的字符串 返回：如果通过验证返回true,否则返回false
 * 
 */
function isInteger(str) {
    var regu = "^[-]{0,1}[0-9]+$";// 正负
    var re = new RegExp(regu);
    var flag = re.test(str);
    if (!flag) {
        alert("不是整数");
    }
    return flag;
}


/*
 * 用途：检查输入字符串是否符合正整数格式 输入： s：字符串 返回： 如果通过验证返回true,否则返回false
 * 
 */
function isNumber(s) {
    var regu = "^[0-9]+$";
    var re = new RegExp(regu);
    if (s.search(re) != -1) {
        return true;
    } else {
        alert("不是正整数");
        return false;
    }
}

/*
 * 用途：检查输入字符串是否是带小数的数字格式,可以是负数 输入： s：字符串 返回： 如果通过验证返回true,否则返回false
 * 
 */
function isDecimal(str) {
    if (isInteger(str))
        return true;
    var re = "^[-]{0,1}(\d+)[\.]+(\d+)$";
    if (re.test(str)) {
        if (RegExp.$1 == 0 && RegExp.$2 == 0)
            return false;
        return true;
    } else {
        return false;
    }
}

/*
 * 用途：检查输入对象的值是否符合E-Mail格式 输入：str 输入的字符串 返回：如果通过验证返回true,否则返回false
 * 
 */
function isEmail(str) {
    var myReg = /^[-_A-Za-z0-9]+@([_A-Za-z0-9]+\.)+[A-Za-z0-9]{2,3}$/;
    if (myReg.test(str))
        return true;
    return false;
}

/*
 * 用途：判断是否是日期 输入：date：日期；fmt：日期格式 返回：如果通过验证返回true,否则返回false
 */
function isDate(date, fmt) {
    if (fmt == null) fmt = "yyyyMMdd";
    var yIndex = fmt.indexOf("yyyy");
    if (yIndex == -1)
        return false;
    var year = date.substring(yIndex, yIndex + 4);
    var mIndex = fmt.indexOf("MM");
    if (mIndex == -1)
        return false;
    var month = date.substring(mIndex, mIndex + 2);
    var dIndex = fmt.indexOf("dd");
    if (dIndex == -1)
        return false;
    var day = date.substring(dIndex, dIndex + 2);
    if (!isNumber(year) || year > "2100" || year < "1900")
        return false;
    if (!isNumber(month) || month > "12" || month < "01")
        return false;
    if (day > getMaxDay(year, month) || day < "01")
        return false;
    return true;
}

function getMaxDay(year, month) {
    if (month == 4 || month == 6 || month == 9 || month == 11)
        return "30";
    if (month == 2) {
        if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)
            return "29";
        else
            return "28";
    }
    return "31";
}

/*
 * 用途：检查输入的起止日期是否正确，规则为两个日期的格式正确， 且结束如期>=起始日期 输入： startDate：起始日期，字符串
 * endDate：结束如期，字符串 返回： 如果通过验证返回true,否则返回false
 * 
 */
function checkTwoDate(startDate, endDate) {
    if (!isDate(startDate)) {
        alert("起始日期不正确!");
        return false;
    } else if (!isDate(endDate)) {
        alert("终止日期不正确!");
        return false;
    } else if (startDate > endDate) {
        alert("起始日期不能大于终止日期!");
        return false;
    }
    return true;
}

/*
 * 用途：检查输入的Email信箱格式是否正确 输入： strEmail：字符串 返回： 如果通过验证返回true,否则返回false
 * 
 */
function checkEmail(strEmail) {
    // var emailReg = /^[_a-z0-9]+@([_a-z0-9]+\.)+[a-z0-9]{2,3}$/;
    var emailReg = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
    if (emailReg.test(strEmail)) {
        return true;
    } else {

        return false;
    }
}
/*
 * 根据给定长度判断此字符串是否符合此长度
 * 
 */
function checkIsPhone(strPhone, num, maxNum) {
    if (strPhone.length >= num && strPhone.length < maxNum) {
        return true;
    }
    return false;
}
/**
 * 检查是否有中文
 * 
 * @return 没有中文返回true
 */
function checkChinese(str) {
    var re = /[\u4E00-\u9FA0]{2,5}$/;
    if (re.test(str)) {
        return false;
    }
    return true;
}

/*
 * 注册页面的表单验证
 * 
 */
function checkForm() {
    /*
	 * 得到表单里面需要提交的值
	 */
    // var phone = checkPone(document.getElementById("phone").value);

    // var address = document.getElementById("address").value;
    var i = 0;
    //if(tijiao()){
    //document.getElementById("pho").value=document.getElementById("phone").value;
    //document.getElementById("cit1").value=document.getElementById("city1").value;
    //document.getElementById("cit2").value=document.getElementById("city2").value;
    // document.getElementById("cit3").value=document.getElementById("city3").value;
    // alert(document.getElementById("pho").value);
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
    var bomareazong = Number(bomarea1) + Number(bomarea2) + Number(bomarea3) + Number(bomarea4) + Number(bomarea5) + Number(bomarea6);
    if (bomareazong == "" || bomareazong == null || bomareazong < 11) {
        alert("请完善各房间面积，房屋总面积必须大于10平方米");
        return false;
    }

    //document.form1.submit();
    op("bj");

    // }

    // return false;

}

function checkphone() {
    /** **********************ajax判断是否已用此手机号报过价，如果报过直接出报价，如果没报过则需要验证码********************************** */
    //alert("");
    var phone = checkPone(document.getElementById("phone").value);
    if (!phone) {
        return false;
    }
    if (!tijiao()) {
        return false;
    }
    //alert("");
    document.getElementById("pho").value = document.getElementById("phone").value;

    var pho = document.getElementById("pho").value;
    //alert(pho);
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


    url = "pho=" + pho;
    var action = "checkpho.action";
    xmlreq.open("POST", action, true);
    xmlreq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xmlreq.send(url);
    // 2. 指定监听器函数(用于在服务端处理完毕后,动态跟新页面的数据)
    xmlreq.onreadystatechange = function () {
        // 一般在监听器方式中需要操作 对象状态 以及 数据包状态
        // alert(xmlreq.readyState+","+xmlreq.status);
        if (xmlreq.readyState == 4) {  // 成功完成
            if (xmlreq.status == 200) {
                var responseText = xmlreq.responseText;
                if ("Y" == responseText) {
                    document.getElementById("hadpho").value = "Y";
                    document.getElementById("tsyzm").style.display = "none";
                    document.getElementById("tsxx").style.display = "";
                    //document.form1.submit();
                } else {
                    document.getElementById("hadpho").value = "N";
                    fxyzm();
                    // changeValidateCode();
                }
            }
        }

    }


    /** **********************end********************************** */
}

/**
 * 验证真实姓名
 * 
 * @return
 */
function checkRealName(str) {
    var name = document.getElementById("spanRealName");
    name.style.display = "block";
    // 先判断是否为空
    if (isNull(str)) {
        if (checkChinese(str)) {
            name.innerText = "必须2-4个中文";
        } else {
            return true;
        }
    } else {
        name.innerText = "不能为空";
    }


    return false;
}
function tijiao() {
    var city = "";

    var c1 = document.getElementById("city1").value;
    var c2 = document.getElementById("city2").value;
    var c3 = document.getElementById("city3").value;
    if (c1 == "" || c2 == "" || c3 == "") {
        alert("请选择对应城市以便获得准确报价！");
        return false;
    }

    if (document.getElementById("xing").value != "") {
        document.getElementById("xingshi").value = document.getElementById("xing").value;
        var arr = document.getElementsByName("xb");
        for (var i = 0; i < arr.length; i++) {
            if (arr[i].checked) {
                document.getElementById("chengfu").value = arr[i].value;
            }
        }
    } else {
        alert("请输入您的姓氏，以便我们更好地为您服务。");
        return false;
    }
    return true;
}
function removeStyle(id) {
    document.getElementById(id).innerText = "";
}
/**
 * 验证手机长度
 * 
 * @param str
 * @return
 */
function checkPone(str) {

    if (isNull(str)) {
        if (formatPhone(str)) {
            return true;
        } else {
            alert("请正确输入手机号以便获得准确报价！");
        }
    } else {
        alert("请输入手机号获得准确报价！");
    }
    return false;

}

/* 验证手机号码 */
function formatPhone(str) {
    var patrn = /^[1]\d{10}$/;
    if (!patrn.exec(str)) {
        return false;
    } else {
        return true;
    }
}

/*
 * 验证邮箱
 */
function checkEmail(str) {
    var pass = document.getElementById("spanEmail");
    if (isNull(str)) {
        if (isEmail(str)) {
            return true;
        } else {
            pass.innerText = "邮箱格式不正确";
        }
    } else {
        pass.innerText = "不能为空";
    }
    pass.style.display = "block";
    return false;
}
/**
 * 验证验证码是否为null
 */
function checkNums(checkNum) {
    if (isNull(checkNum)) {
        return true;
    }
    var pass = document.getElementById("spanCheckNum");
    pass.innerText = "验证码不能为空";
    pass.style.display = "block";
    return false;
}
/**
 * 验证密码
 */
function checkPassWord(password, repassword) {

    var pass = document.getElementById("spanPassword");
    var repass = document.getElementById("spanRePassword");
    // 先判断是否为空
    if (isNull(password)) {
        if (checkChinese(password)) {
            if (checkIsPhone(password, 6, 20)) {
                if (password == repassword) {
                    return true;
                } else {
                    repass.innerText = "要与上面密码一致";
                    repass.style.display = "block";
                    return false;

                }
            } else {
                pass.innerText = "长度不符合6-20个字符";
                pass.style.display = "block";
                return false;
            }
        } else {
            pass.innerText = "包含中文";
            pass.style.display = "block";
            return false;
        }
    } else {
        pass.innerText = "不能为空";
        pass.style.display = "block";
        return false;
    }

    return false;
}
/**
 * 验证姓名
 * 
 * @param strName
 * @return
 */
function checkName(strName) {

    var name = document.getElementById("spanName");
    name.style.display = "block";
    // 先判断是否为空
    if (isNull(strName)) {
        if (checkChinese(strName)) {
            if (checkIsPhone(strName, 6, 16)) {
                return true;
            } else {
                name.innerText = "长度不符合6-16个字符";
            }
        } else {
            name.innerText = "包含中文";
        }
    } else {
        name.innerText = "不能为空";
    }


    return false;
}



/*
 * 谭剑 判断手机是否已经报价
 */

function checkphone2() {
    /** **********************ajax判断是否已用此手机号报过价，如果报过直接出报价，如果没报过则需要验证码********************************** */
    var phone = checkPone(document.getElementById("phone").value);
    if (!phone) {
        return false;
    }
    document.getElementById("pho").value = document.getElementById("phone").value;
    var pho = document.getElementById("pho").value;
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


    url = "pho=" + pho;
    var action = "checkpho2.action";
    xmlreq.open("POST", action, true);

    // 2. 指定监听器函数(用于在服务端处理完毕后,动态跟新页面的数据)
    xmlreq.onreadystatechange = function () {
        // 一般在监听器方式中需要操作 对象状态 以及 数据包状态
        // alert(xmlreq.readyState+","+xmlreq.status);
        if (xmlreq.readyState == 4) {  // 成功完成
            if (xmlreq.status == 200) {

                var responseText = xmlreq.responseText;
                if ("Y" == responseText) {
                    document.getElementById("hadpho").value = "Y";
                    document.getElementById("tsyzm").style.display = "none";
                    document.getElementById("tsxx").style.display = "";
                    // document.form1.submit();
                } else {
                    document.getElementById("hadpho").value = "N";
                    fxyzm();
                    // changeValidateCode();
                }
            }
        }

    }

    xmlreq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xmlreq.send(url);
}



// 1、实现限制只能录入中文及字母其他符号不给录入及长度，通常用于文章商品名称等查找控制,一般用onkeyup 及onchange事件触发，
function formatname(obj, len) {
    obj.value = obj.value.replace(/[^\u4E00-\u9FA5]/g, '');
    if (eval("/[\u4E00-\clearxingclearxingu9FA5]{" + len + "}/g").test(obj.value))
        obj.value = obj.value.substring(0, len);
}

// 控制只能录入整数
function formatnums(obj, len) {
    obj.value = obj.value.replace(/[^0-9]/g, '');
    if (eval("/[0-9]{" + len + "}/g").test(obj.value))
        obj.value = obj.value.substring(0, len);
}

function formatForInd(obj, len) {   // 此方法与上面的formatnums方法一样，因为首页有一个同名的方法不好修改，现在重写一个用于首页的电话号码判断
    obj.value = obj.value.replace(/[^0-9]/g, '');
    if (eval("/[0-9]{" + len + "}/g").test(obj.value))
        obj.value = obj.value.substring(0, len);
}
