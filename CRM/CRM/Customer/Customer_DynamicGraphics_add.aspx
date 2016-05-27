<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <link href="../../CSS/input.css" rel="stylesheet" />
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>

    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();
            
            loadForm(getparastr("cid"), getparastr("id"));

 
        })
    
        function f_save() {
        
            if ($(form1).valid()) {
           
                var sendtxt = "&Action=savedy&id=" + getparastr("id") + "&cid=" + getparastr("cid");
       
                return $("form :input").fieldSerialize() + sendtxt;
                
            }
        }

        function loadForm(cid,id) {
            $.ajax({
                type: "GET",
                url: "../../data/crm_customer.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'formdy', cid: cid,id:id, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                   // alert(obj.DyGraphicsName); //String 构造函数
                    //$("#T_follow").val(obj.Follow);
                    //$("#T_followtype").ligerComboBox({ width: 352, initValue: obj.Follow_Type_id, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=4&rnd=" + Math.random() });
                    $("#T_name").val(obj.DyGraphicsName);
                    $("#T_url").val(obj.DyUrl);
                    $("#T_remarks").val(obj.Remarks);
                }
            });

        }
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">
        <table class="bodytable1" style="width: 500px; margin: 2px;">
            <tr>
                <td class="table_title1" colspan="2">基础资料</td>
            </tr>
            <tr>

                <td style="width: 85px">
                    <div style="width: 80px; text-align: right; float: right">动图名词：</div>
                </td>
                <td>
                    <input type="text" id="T_name" name="T_name"  ltype="text"  ligerui="{width:350}" validate="{required:true}" /></td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">动图地址：</div>
                </td>
                <td>
                    <textarea id="T_url" cols="3" name="T_url" class="l-textarea" style="width: 350px;" rows="3" validate="{required:true}"></textarea></td>

           
            </tr>
            <tr>
                 <td>
                    <div style="width: 80px; text-align: right; float: right">备注：</div>
                </td>
                <td>
                    <input type="text" id="T_remarks" name="T_remarks"  ltype="text"  ligerui="{width:350}" validate="{required:true}" /></td>
        
            </tr>
           
        </table>



    </form>
</body>
</html>
