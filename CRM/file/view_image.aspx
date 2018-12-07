<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <script src="../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../JS/XHD.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="js/jquery.min.js"></script>
 
<script src="js/jquery.artZoom.js"></script>
 <LINK href="js/jquery.artZoom.css" rel="stylesheet" type="text/css"> 

    <script type="text/javascript">
        $(function () {
            var realname = getparastr("realname");
            if (realname && realname!=undefined && realname!="undefined") {
                $("#view").attr("src", "../file/contract/" + realname);
            }
            else {
                $.ajax({
                    type: "GET",
                    url: "../data/CRM_contract_attachment.ashx", /* 注意后面的名字对应CS的方法名称 */
                    data: { Action: 'get_realname', page_id: getparastr("page_id"), filename: getparastr("filename"), rnd: Math.random() }, /* 注意参数的格式和名称 */
                    contentType: "application/json; charset=utf-8",
                    dataType: "text",
                    success: function (result) {                          
                        //alert(obj.constructor); //String 构造函数
                        if (result == "sucess:false") {
                            $("#view").remove();
                            $.ligerDialog.warn("系统错误！找不到地址");
                        }
                        else {                             
                            $("#view").attr("src", "../file/contract/" + result);
                        } 
                    }
                });
            }
        })
    </script>
    <script type="text/javascript">
jQuery(function ($) {
	$('.artZoom').artZoom({
		path: '../arzoom/images',	// 设置artZoom图片文件夹路径
		preload: true,		// 设置是否提前缓存视野内的大图片
		blur: true,			// 设置加载大图是否有模糊变清晰的效果
		
		// 语言设置
		left: '左旋转',		// 左旋转按钮文字
		right: '右旋转',		// 右旋转按钮文字
        zoomMax:'放大',
        zoomMin:'缩小',
		source: '看原图'		// 查看原图按钮文字
	});
});
</script>
    <style type="text/css">
/*演示*/

.artZoom {
	padding:3px;
	background:#FFF;
    width: 450px;
    height: 700px;
	border:1px solid #EBEBEB;
}
body {
	font-size: 75%;
	font-family: '微软雅黑';
	padding-bottom: 200px;
	background-color: #292929;
}
img {
	border:0 none;
}
</style>
</head>
<body style="overflow: scroll;">
    <img  class="artZoom" id="view" width="200" height="200" src=""/>
</body>
</html>
