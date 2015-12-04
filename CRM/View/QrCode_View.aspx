<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            var e = "M";
            var q = "Two";
            var s = "8";
            t = "http://" + window.location.host + "/view/product_view.aspx?pid=" + getparastr("pid");
            var image = document.getElementById('result');
            image.src = 'QrCodeHandler.ashx?e=' + e + '&q=' + q + '&s=' + s + '&t=' + encodeURI(t);
            $.ajax({
                type: "GET",
                url: "product_handler.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', pid: getparastr("pid"), rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    $("#d1").html("&nbsp;<font color='red'>产品名称:</font>(" + obj.product_id + ")" + obj.product_name);
                    $("#d2").html("&nbsp;<font color='red'>规格型号:</font>" + obj.specifications);
                }
            });
        })
	</script>
    <style>
        table{border:0;margin:0;border-collapse:collapse;border-spacing:0;}
        table td{border:0;padding:2px;}
    </style>
</head>
<body style="margin:0 0 0 0;">
    <form id="form1" onsubmit="return false">
        <table style="width:100%;">
            <tr><td></td><td style="width:250px;"><img id="result" width="250" height="250"/></td><td></td></tr>
            <tr><td></td><td style="width:250px;"><div id="d1"></div></td><td></td></tr>
            <tr><td></td><td style="width:250px;"><div id="d2"></div></td><td></td></tr>
        </table>
    </form>
</body>
</html>
