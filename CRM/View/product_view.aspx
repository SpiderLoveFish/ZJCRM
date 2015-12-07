<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta name="viewport" content="initial-scale=1, user-scalable=0, minimal-ui"/>  
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>六家居装企系统</title>
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                type: "GET",
                url: "product_handler.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', pid: getparastr("pid"), rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    //$("#title").html(obj.product_name + obj.category_name);
                    //$("#fly_title").html(formatTimebytype(obj.news_time, 'yyyy-MM-dd') + "　　　编辑：" + obj.create_name);
                    $("#content").html(myHTMLDeCode(obj.t_content));
                    document.title = obj.product_name + "(六家居装企系统)";
                }
            });
        })
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">
        <%--<div id="title" style="text-align:center;font-size:xx-large;font-weight:bold;"></div>
        <br />
        <div id="fly_title" style="text-align:center;font-size:12px;border-bottom:1px solid #aaa;vertical-align:middle;height:10px;"></div>--%>
        <div id="content"></div>
    </form>
</body>
</html>
