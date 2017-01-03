<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>

    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>

    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>

    <script src="../../JS/XHD.js" type="text/javascript"></script>
   
   <script type="text/javascript">
       var g;
       $(function () {
           g = $("#select2").ligerComboBox({
               width: 196,
               selectBoxWidth: 240,
               selectBoxHeight: 200,
               valueField: 'id',
               textField: 'text',
               url: "../../data/Budge.ashx?Action=comboprintdescr&rnd=" + Math.random(), emptyText: '（空）' 
                , onSelected: function (value, newvalue) {
                    $("#selectvalue").val(value)
                }
           });
           loadForm("YS");
           
         
          // $("#select2").ligerComboBox();
       });
       function OpenURL(url) {
 
           window.open(url + "?bid=" + getparastr("bid") + "&selectid=" + $("#selectvalue").val(), "_blank", 'top=0, left=0, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=n o, status=no');

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
                 //  alert(JSON.stringify(result.Rows))
                   var item = ""; var len = 0;//4格换一行
                   $.each(obj, function (i, data) {

                       if (len == 0)
                           item = " <tr>";
                       else
                           item = "";
                       item += " <td class='table_title1'>" +
                   "  <input  id='A5'  class='l-button' value=" + data['Budge_Print'] + " name='" + data['Budge_File'] + "'  position='right' style='width:120px;' onClick='OpenURL(this.name)'>" +
                    "   </input > " +
             "</td> " +
             " <td style='width:50px;height:10px'> <div id='tip' class='tips' style='width:60px;height:15px; overflow: hidden;'>   " +

                 " 查看介绍 ：" + data['Remark'] + "   </div>  </td> ";
                  

                       len++;
                       if (len == 1) {

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
       选择一个预算备注说明： 
          <input  type='text' ltype='text'ligerui="{width:150 }" id='select2' name='select2'/> 
   <table class="table" align="left" border="0" cellpadding="3" cellspacing="1">
          </table>
        <br />
         

        <input id="selectvalue" type="hidden" name="selectvalue" />
    </form>
</body>
</html>
