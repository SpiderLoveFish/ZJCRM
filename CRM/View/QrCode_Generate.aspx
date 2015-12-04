<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>六家居装企系统</title>
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            toolbar();
            $("#stext").ligerTextBox({ width: 300, nullText: "请输入要生成二维码的内容" });
        })
        function toolbar() {
            var items = [];
            items.push({ type: 'textbox', id: 'stext', text: '内容：' });
            items.push({ type: 'button', text: '二维码生成', icon: '../../images/search.gif', disable: true, click: function () { generate(); } });
            $("#toolbar").ligerToolBar({
                items: items
            });
        }
        function generate() {
            var e = "M";
            var q = "Two";
            var s = "8";
            var t = $("#stext").val();
            if (t != "") {
                var url = 'QrCodeHandler.ashx?e=' + e + '&q=' + q + '&s=' + s + '&t=' + encodeURI(t);
                $("#result").attr("src", url);
                $("#result").css({
                    width: 300,
                    height: 300
                });
            }
        }
	</script>
</head>
<body style="margin:0 0 0 0;overflow:hidden;">
    <form id="form1" onsubmit="return false">
        <div style="position: relative; z-index: 9999">
            <div id="toolbar" />
        </div>
        <%--<div style="border:1px solid red;width:300px;height:300px;">--%>
            <img id="result"/>
        <%--</div>--%>
    </form>
</body>
</html>
