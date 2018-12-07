<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>

    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>

    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ci = false;
        var  bq = "";
        var type = 0;
        $(function () {
            

            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();
             
        })

          function f_save() {
              var date = $("#jgrq").val()
              if (date == null || date == "")
              {
                  alert("竣工日期不能为空！"); return;
              }
              var sendtxt = "&Action=UpdateStatus&id=" + getparastr("id") ;
                return $("form :input").fieldSerialize() + sendtxt;
             
        }
       
       
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">
        
        <table style="width: 350px; margin: 5px;" class='bodytable1'>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">竣工日期：</div>
                </td>
                <td>
                    <input type="text" id="jgrq" name="jgrq" ltype="date" ligerui="{width:195}" /></td>
                
            </tr>
           
         
        </table>


    </form>
</body>
</html>
