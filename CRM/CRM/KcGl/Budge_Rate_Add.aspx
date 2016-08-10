<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Budge_Rate_Add.aspx.cs" Inherits="Budge_Rate.Budge_Rate_Add" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
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
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
            $("form").ligerForm();
            loadForm(getparastr("cid"));
          
        })
        function loadForm(cid) {
            $.ajax({
                type: "GET",
                url: "Budge_Rate_Add.aspx?cmd=form&cid=" + cid + "&rnd=" + Math.random(),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                   
                    $("#Name").val(obj.Name);
                    $("#Address").val(obj.Address);
                    $("#lxrid").val(obj.Lxrid);
                    $("#lxr").val(obj.Lxr);
                    $("#lxrdh").val(obj.Lxrdh);
                    $("#Remark").val(obj.Remark);

                   
                   
      
                },
                error: function (ex) {
                    top.$.ligerDialog.error('操作失败，错误信息：' + ex.responseText);
                }
            });
        }
        function f_selectlxr() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择员工', width: 850, height: 400, url: "hr/Getemp.aspx?isvew=Y", buttons: [
                    { text: '确定', onclick: f_selectlxrOK },
                    { text: '取消', onclick: function (item, dialog) { dialog.close(); } }
                ]
            });
            return false;
        }

        
        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&cmd=save&cid=" + getparastr("cid");
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }

     
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false;">
        <table style="width: 550px; margin: 5px;">
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">附加费名称：</div>
                </td>
                <td colspan="3">
                   
                
                     <div style="float: left; width: 420px;">
                       <input type="text" id="Name" name="Name" ltype="text" ligerui="{width:420}" /> 
                    </div>
                   


                </td>
                </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">附加费说明：</div>
                </td>
                <td colspan="3">
                   
                
                     <div style="float: left; width: 365px;">
                       <input type="text" id="Address" name="Address" ltype="text" ligerui="{width:420}" /> 
                    </div>
                    

                </td>

               
            </tr>
            
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">附加费率：</div>
                </td>
                <td>
                  <input type="text" id="lxr" name="lxr" ltype="text" ligerui="{width:100}" validate="{required:true}" />
                   
                </td>
                                <td>
                 说明：20% 请录入 0.2
                   
                </td>
                
            </tr>
           
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</div>
                </td>
                <td colspan="3">
                    <textarea id="Remark" name="Remark" cols="100" rows="4" class="l-textarea" style="width:420px"></textarea>
             
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
