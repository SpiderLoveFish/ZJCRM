<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />
      <style>
        body {padding-top:50px;}
        #content {padding:0 100px;}
        .intro {margin-top:20px; font-size:14px;}
        .ifr-steps {position:fixed; top:50px; left:1350px; min-width:400px;}
        .ifr-steps li {list-style-type:decimal; list-style-position:inside;}
        .sep {border-right:1px solid #999; margin:0 15px;}
        iframe {border:2px solid #666; margin-top:20px;}
        em {color:red}
    </style>
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
     <script src="../../lib/jquery.form.js" type="text/javascript"></script>
   <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/json2.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        var manager = "";
        $(function () {
            if (window.postMessage) {
                var callback = function (ev) {
                    console ? console.log(ev) : alert(ev.data);
                    if (ev.origin === 'http://www.kujiale.com' ||
                        ev.origin === 'http://yun.kujiale.com' ||
                        ev.origin === 'https://www.kujiale.com' ||
                        ev.origin === 'https://yun.kujiale.com') {
                        // handle message in ev ...
                        // var data = JSON.parse(ev.data)
                    }
                };
                if ('addEventListener' in document) {
                    window.addEventListener('message', callback, false);
                } else if ('attachEvent' in document) {
                    window.attachEvent('onmessage', callback);
                }
            } else {
                // 如果不支持postMessage， 则使用ie6/7的window共有属性navigator进行hack
                window.navigator.listenKJL = function (msg) {
                    alert(msg)
                    // var data = JSON.parse(ev.data)
                };
            }

            $.ajax({
                url: "../../data/SingleSignOn.ashx", type: "POST",
                data: { Action: "GetMD5", rnd: Math.random() },
               // dataType: 'content', //这里修改为content   
                success: function (responseText) {
                    // $.ligerDialog.warn(responseText);
                    //location.href = "http://www.baidu.com";
                     //alert(responseText);
                    //$.ligerDialog.warn(responseText);
                    //$.ligerDialog.warn(obj.errorMsg);
                   // $("#maingrid4").append("<lable >错误代码：" + obj.errorMsg + "</lable>");
                    try
                    {
                        var obj = JSON.parse(responseText);
                        if (obj.errorCode == 0)
                        {
                            location.href = obj.errorMsg;
                        }
                        else
                            $("#maingrid4").append("<lable >服务器错误：" + obj.errorMsg + "</lable>");
                    } catch (e)
                    {
                        $("#maingrid4").append("<lable >服务器错误：" + responseText +";客户端错误："+ e.message+"</lable>");
                       
                    }
               }
            });
            return;

            initLayout();
            $(window).resize(function () {
                initLayout();
            });
           
        });
       
    </script>
    
</head>
<body style="padding: 0px;overflow:hidden;">

    <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar"></div>
              <div id="grid">
            <div id="maingrid4" style="margin: -1px;"></div>
                  </div>
        </div>
    </form>
     

</body>
</html>
