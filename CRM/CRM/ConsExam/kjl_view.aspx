<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
 <style type="text/css">
body { margin: 0px;  }  
iframe {border: 0px;} 
.box {height:100%;  position:absolute; width:100%;} 
</style>
 
     
      <link href="../../jlui3.2/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
     <link href="../../../lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css"> 
     <script src="../../jlui3.2/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/json2.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
       <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
     <script src="../../jlui3.2/lib/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
    <script src="../../jlui3.2/lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
     <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
     <script src="../../jlui3.2/lib/ligerUI/js/ligerui.all.js"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
         <script src="../../lib/jquery.form.js" type="text/javascript"></script>
         <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script type="text/javascript">
        var manager = "";
        $(function () {
            var strurl = getparastr("strurl");
          $('#iframe').attr("src", strurl);
            //initLayout();
            //$(window).resize(function () {
            //    initLayout();
            //});
          //manager=  top.$.ligerDialog.open({ height: 200, url: strurl, width: null, showMax: true, showToggle: true, showMin: true, isResize: true, slide: false });
          //manager.show();
            // f_open(strurl)
      
          requestFullScreen();
        });
     
        //进入全屏
        function requestFullScreen() {
            var de = document.documentElement;
            if (de.requestFullscreen) {
                de.requestFullscreen();
            } else if (de.mozRequestFullScreen) {
                de.mozRequestFullScreen();
            } else if (de.webkitRequestFullScreen) {
                de.webkitRequestFullScreen();
            }
        }
        //退出全屏
        function exitFullscreen() {
            var de = document;
            if (de.exitFullscreen) {
                de.exitFullscreen();
            } else if (de.mozCancelFullScreen) {
                de.mozCancelFullScreen();
            } else if (de.webkitCancelFullScreen) {
                de.webkitCancelFullScreen();
            }
        }
    
    </script>
    
</head>
<body style="padding: 0px;overflow:hidden;">

    <form id="form1" onsubmit="return false">
     <div id="content">      

        <div class="box"   >
           <%-- <h3>iframe用户行为记录</h3>--%>
            <ol class="action-log">
                <input  type="hidden" id="name" />
            </ol>
        </div>

        <iframe id="iframe" name="iframe" class="box"  >
            <h2></h2>
        </iframe>
    </div>
    </form>
  

</body>
</html>
