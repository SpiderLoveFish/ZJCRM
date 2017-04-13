<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
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
        //图标
    
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
          
            //$("#T_Contract_name").focus();
            $("form").ligerForm();
        
            $("#T_name").val(decodeURI(getparastr("name")));
            $("#T_sms").val(decodeURI(getparastr("name")));
            
            $("#T_p1,#T_p2,#T_p3,#T_p4,#T_p5,#T_p6").change(function () {
             
                var smsname = decodeURI(getparastr("name"));
                if ($("#T_p1").val() != "")
                    smsname = smsname.replace("@p1", $("#T_p1").val());
                 if ($("#T_p2").val() != "")
                     smsname = smsname.replace("@p2", $("#T_p2").val());
                 if ($("#T_p3").val() != "")
                     smsname = smsname.replace("@p3", $("#T_p3").val());
                 if ($("#T_p4").val() != "")
                     smsname = smsname.replace("@p4", $("#T_p4").val());
                 if ($("#T_p5").val() != "")
                     smsname = smsname.replace("@p5", $("#T_p5").val());
                 if ($("#T_p6").val() != "")
                     smsname = smsname.replace("@p6", $("#T_p6").val());
                 $("#T_sms").val(smsname);
            });

        });

        function f_save() {
            var tel = $("#T_tel").val();
            if (!(/^1[34578]\d{9}$/.test(phone))) {
                alert("手机号码有误，请重填");
                return;
            }
             
            var paras =  {'name':'山山ERP','hdnr': $('#T_sms').val() };
            $.ajax({
                url: "../../data/crm_customer.ashx", type: "POST",
                data: { Action: "Send_aliyunSendSMS", tel: $('#T_tel').val(), type: 4, para: JSON.stringify(paras), rnd: Math.random() },
                success: function (responseText) {
                    if (responseText == "true") {
                       alert('发送成功！！');

                    }
                    else if (responseText == "false") {
                        alert('发送失败！！');
                    }

                },
                error: function () {
                    alert('发送失败！！');
                }
            });
        }
 
    </script>
 
</head>
<body style="padding: 0px">
    <form id="form1" onsubmit="return false">
        <table border="0" cellpadding="3" cellspacing="1" style="background: #fff; width: 400px;">

            <tr>
                <td height="33" style="width: 85px" colspan="2">

                    <div align="left" style="width: 80px">名称：</div>
                </td>
                <td colspan="3" height="33">

                   <textarea id="T_name" name="T_name" cols="50" rows="5" class="l-textarea" style="width:430px"> </textarea>

                </td>
            </tr>
            <tr>
                <td height="33" colspan="2">

                    <div align="left" style="width: 80px">参数1 ：</div>
                </td>
                <td height="33">
                    <input type="text" id="T_p1" name="T_p1" ltype="text" ligerui="{width:180}"   />
                </td>
             
                <td height="33" colspan="2">

                    <div align="left" style="width: 80px">参数2 ：</div>
                </td>
                <td height="33">
                    <input type="text" id="T_p2" name="T_p2" ltype="text" ligerui="{width:180}"    />
                </td>
            </tr>
               <tr>
                <td height="33" colspan="2">

                    <div align="left" style="width: 80px">参数3 ：</div>
                </td>
                <td height="33">
                    <input type="text" id="T_p3" name="T_p3" ltype="text" ligerui="{width:180}"    />
                </td>
             
                <td height="33" colspan="2">

                    <div align="left" style="width: 80px">参数4 ：</div>
                </td>
                <td height="33">
                    <input type="text" id="T_p4" name="T_p4" ltype="text" ligerui="{width:180}"    />
                </td>
            </tr>
               <tr>
                <td height="33" colspan="2">

                    <div align="left" style="width: 80px">参数5 ：</div>
                </td>
                <td height="33">
                    <input type="text" id="T_p5" name="T_p5" ltype="text" ligerui="{width:180}"   />
                </td>
            
                <td height="33" colspan="2">

                    <div align="left" style="width: 80px">参数6 ：</div>
                </td>
                <td height="33">
                    <input type="text" id="T_p6" name="T_p6" ltype="text" ligerui="{width:180}"    />
                </td>
            </tr>
          
             <tr>
                <td height="33" colspan="2">

                    <div align="left" style="width: 80px">电话：</div>
                </td>
                <td colspan="3" height="33">
                    <input type="text" id="T_tel" name="T_tel" ltype="text" ligerui="{width:380}"  />
             
                </td>
            </tr>
             <tr>
         <td height="33" colspan="2">

                    <div align="left" style="width: 80px">生成样式：</div>
                </td>
                <td colspan="3" height="33">
                  <textarea id="T_sms" name="T_sms" cols="50" rows="5" class="l-textarea" style="width:430px"> </textarea>

   
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
