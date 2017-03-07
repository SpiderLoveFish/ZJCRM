<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
       <link href="../../CSS/styles.css" rel="stylesheet" />
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
        var tel = getparastr("tel");
       
        $(function () {
            
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();
            $('#T_phone').val(getparastr("tel"))

         
            
        })
        function f_save() {
            if (rowid.length > 1) {
                $.ajax({
                    url: "../../data/crm_customer.ashx", type: "POST",
                    data: { Action: "Send_aliyunSendSMS", tel:$('#T_phone').val()  , type: 4, para: $('#T_sms').val(), rnd: Math.random() },
                    success: function (responseText) {
                        if (responseText == "true") {
                            top.$.ligerDialog.alert('发送成功！！');

                        }
                        else if (responseText == "false") {
                            $("#lbtips").html("提交失败！！：");
                            $("#lbtips").addClass("red");
                        }

                    },
                    error: function () {
                        $("#lbtips").html("提交失败！！：");
                        $("#lbtips").addClass("red");  
                    }
                });
            }
            else {
                $("#lbtips").html("无数据，无法发送！！："  );
                $("#lbtips").addClass("red");
            } 
        }
        
          
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">
        <input type="hidden" id="h_address" value="" />
        <table style="width: 550px; margin: 5px;" class='bodytable1'>
            <tr>
                <td colspan="4" class="table_title1">群发短信</td>
            </tr>
             
               
             <tr  >
                <td>
                    <div style="width: 80px; text-align: right; float: right">发送短信内容：</div>
                </td>
                <td colspan="3">
                    <textarea id="T_sms" name="T_sms" cols="100" rows="8" class="l-textarea" style="width:530px"></textarea> 
            </tr>
            <tr  >
                <td>
                    <div style="width: 80px; text-align: right; float: right">手机号码：</div>
                </td>
                <td colspan="3">

                   <textarea id="T_phone" name="T_phone" cols="100" rows="8" class="l-textarea" style="width:530px"></textarea>
            </tr>
            <tr  >
                <td colspan="4">
                    <label id="lbtips"> </label>
                </td>
            </tr>
        </table>


    </form>
</body>
</html>
