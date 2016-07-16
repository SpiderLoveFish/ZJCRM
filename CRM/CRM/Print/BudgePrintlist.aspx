<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
      <link href="../../CSS/styles.css" rel="stylesheet" />
     <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
   
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
      <script src="../../lib/jquery.form.js" type="text/javascript"></script>
   <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
  
     <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
   <script src="../../JS/XHD.js" type="text/javascript"></script>
   <script type="text/javascript">
       $(function () {        
           loadForm("YS");           
       });
       function OpenURL(url) {
           window.open(url + "?bid=" + getparastr("bid"), "_blank", 'top=0, left=0, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=n o, status=no');

          // f_openWindowview("crm/Print/" + url + "?bid=" + getparastr("bid"), "打印", 800, 400);

       }
       function loadForm(style) {
           $.ajax({
               type: "GET",
               url: "../../data/Budge.ashx", /* 注意后面的名字对应CS的方法名称 */
               data: { Action: 'gridprint', style: style, rnd: Math.random() }, /* 注意参数的格式和名称 */
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (result) {
                   var obj = result.Rows;
                   var item = ""; var len = 0;//4格换一行
                   $.each(obj, function (i, data) {
                     
                       if (len==0)
                           item = " <tr>";
                           else
                           item ="";
                       item += " <td class='table_title1'>" +
                   "  <a id='A5' class='l-button' value='" + data['Budge_File'] + "'  position='right' style='width:120px;' onClick='OpenURL(this.value)'>" +
                    "   "+data['Budge_Print'] +"</a> "+
             " <img src=' " + data['PrintIcon'] + "' width='100' height='100'></td> " +
             " <td style='width:10px;height:10px'> <div id='tip' class='tips' style='width:20px;height:20px; overflow: hidden;'>   " +
                        
                 " " + data['Remark'] + "   </div>  </td> " +
                  "  " ;
                       len++;
                       if (len == 3) {
                         
                           item += " </tr>";
                           len = 0;
                       }
                     

                           $('.table').append(item);
                       $(".tips").hover(function (e) {
                           $(this).ligerTip({ content: $(this).html(), width: 200, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                       }, function (e) {
                           $(this).ligerHideTip(e);
                       });
                       // $(".tips").ligerHideTip(); //关闭弹出的tip
                       

                   });
               },
               error: function (XMLHttpRequest, textStatus, errorThrown) {
                   alert(textStatus);
               }
           })
       }
       var activeDialogs = null;
       function f_openWindowview(url, title, width, height) {
           var dialogOptions = {
               width: width, height: height, title: title, url: url, buttons: [

                       {
                           text: '关闭', onclick: function (item, dialog) {
                               dialog.close();
                           }
                       }
               ], isResize: true, showToggle: true, timeParmName: 'a'
           };
           activeDialogs = parent.jQuery.ligerDialog.open(dialogOptions);
       }
    </script>
     
</head>
<body style="padding: 0px;overflow:hidden;">
    <form id="form1" onsubmit="return false">
   <table class="table" align="left" border="0" cellpadding="3" cellspacing="1">
          </table>
    </form>
</body>
</html>
