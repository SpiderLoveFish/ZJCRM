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
            $.ajax({
                type: "GET",
                url: "public_data_share.aspx",
                data: { cmd: 'form', pid: getparastr("pid"), rnd: Math.random() },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    $("#news_title").html(obj.Rows[0]["category_name"] + '-' + obj.Rows[0]["title"]);
                    $("#fly_title").html(formatTimebytype(obj.Rows[0]["create_time"], 'yyyy-MM-dd') + "　　　编辑：" + obj.Rows[0]["create_name"]);
                    $("#news_content").html(myHTMLDeCode(obj.Rows[0]["t_content_"]));
                }
            });
        })
    </script>
</head>
<body>
    <form id="form2" onsubmit="return false">
        <div id="news_title" style="text-align:center;font-size:xx-large;font-weight:bold;"></div>
        <br />
        <div id="fly_title" style="text-align:center;font-size:12px;border-bottom:1px solid #aaa;vertical-align:middle;height:27px;"></div>
        <div id="news_content"></div>
    </form>
</body>
</html>
