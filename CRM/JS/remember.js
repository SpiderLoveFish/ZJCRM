//var isPostBack = "<%=IsPostBack%>";
//function onLoginLoaded() {
//    debugger;
//    if (isPostBack == "False") {
//        GetLastUser();
//    }
//}
function GetLastUser() {
    var id = "49BAC005-7D5B-4231-8CEA-16939BEACD67";
    var usr = GetCookie(id);
    if (usr != null) {
        document.getElementById('T_uid').value = usr;
    }
    else {
        document.getElementById('T_uid').value = "";
    }
    GetPwdAndChk();
}
//点击登录时触发客户端事件
function SetPwdAndChk() {
    //取用户名
    var usr = document.getElementById('T_uid').value;

    var pwd = document.getElementById('T_pwd').value;
    var expdate = new Date();
    expdate.setTime(expdate.getTime() + 14 * (24 * 60 * 60 * 1000));
    //如果记住密码选项被选中
    if (document.getElementById('T_remember_user').checked == true) {//记住账号 
        //将最后一个用户信息写入到Cookie
        SetLastUser(usr);
        //将用户名和密码写入到Cookie
        SetCookie(usr, '', expdate);
    } else if (document.getElementById('T_remember_user_pwd').checked == true) {//记住账号和密码         
        //将用户名和密码写入到Cookie
        SetCookie(usr, pwd, expdate);
    }
    else {
        //如果没有选中记住密码,则立即过期
        ResetCookie();
    }
}
function SetLastUser(usr) {
    var id = "49BAC005-7D5B-4231-8CEA-16939BEACD67";
    var expdate = new Date();
    //当前时间加上两周的时间
    expdate.setTime(expdate.getTime() + 14 * (24 * 60 * 60 * 1000));
    SetCookie(id, usr, expdate);
}
//用户名失去焦点时调用该方法
function GetPwdAndChk() {
    var usr = document.getElementById('T_uid').value;
    var pwd = GetCookie(usr);
    if (pwd != null) {
        if (pwd == '')
            document.getElementById('T_remember_user').checked = true;
        else
            document.getElementById('T_remember_user_pwd').checked = true;
        document.getElementById('T_pwd').value = pwd;
    }
    else {
        //document.getElementById('T_remember_user').checked = false;
        //document.getElementById('T_remember_user_pwd').checked = false;
        //document.getElementById('T_pwd').value = "";
    }
}
//取Cookie的值
function GetCookie(name) {
    var arg = name + "=";
    var alen = arg.length;
    var clen = document.cookie.length;
    var i = 0;
    while (i < clen) {
        var j = i + alen;
        //alert(j);
        if (document.cookie.substring(i, j) == arg)
            return getCookieVal(j);
        i = document.cookie.indexOf(" ", i) + 1;
        if (i == 0) break;
    }
    return null;
}

function getCookieVal(offset) {
    var endstr = document.cookie.indexOf(";", offset);
    if (endstr == -1)
        endstr = document.cookie.length;
    return unescape(document.cookie.substring(offset, endstr));
}
//写入到Cookie
function SetCookie(name, value, expires) {
    var argv = SetCookie.arguments;
    //本例中length = 3
    var argc = SetCookie.arguments.length;
    var expires = (argc > 2) ? argv[2] : null;
    var path = (argc > 3) ? argv[3] : null;
    var domain = (argc > 4) ? argv[4] : null;
    var secure = (argc > 5) ? argv[5] : false;
    document.cookie = name + "=" + escape(value) +
    ((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
    ((path == null) ? "" : ("; path=" + path)) +
    ((domain == null) ? "" : ("; domain=" + domain)) +
    ((secure == true) ? "; secure" : "");
}
function ResetCookie() {
    var usr = document.getElementById('T_uid').value;
    var expdate = new Date();
    SetCookie(usr, null, expdate);
}