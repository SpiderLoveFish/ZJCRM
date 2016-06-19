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
            t = getparastr("pid");
            var image = document.getElementById('result');
            image.src = 'QrCodeHandler.ashx?e=' + e + '&q=' + q + '&s=' + s + '&t=' + encodeURI(t);

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
            
        </table>
    </form>
</body>
</html>
