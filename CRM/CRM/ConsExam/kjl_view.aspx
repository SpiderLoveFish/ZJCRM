<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
 
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
        });
       
  
    
    </script>
    
</head>
<body style="padding: 0px;overflow:hidden;">

    <form id="form1" onsubmit="return false">
     <div id="content">      

        <div class="ifr-steps">
           <%-- <h3>iframe用户行为记录</h3>--%>
            <ol class="action-log">
                <input  type="hidden" id="name" />
            </ol>
        </div>

        <iframe id="iframe" name="demo-iframe" width="1100" height="600">
            <h2>这是酷家乐装修设计或户型修改页面，当前未登录</h2>
        </iframe>
    </div>
    </form>
  

</body>
</html>
