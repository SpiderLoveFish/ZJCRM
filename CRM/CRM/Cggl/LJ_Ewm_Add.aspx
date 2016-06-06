<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LJ_Ewm_Add.aspx.cs" Inherits="LJ_Ewm.LJ_Ewm_Add" %>

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
                url: "LJ_Ewm_Add.aspx?cmd=form&cid=" + cid + "&rnd=" + Math.random(),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }

                    $("#Name").val(obj.Name);
                    $("#URL").val(obj.URL);
                    $("#A").val(obj.A);
                    $("#B").val(obj.B);
                    $("#C").val(obj.C);
                    $("#D").val(obj.D);
                    $("#E").val(obj.E);
                    $("#F").val(obj.F);
                    $("#Remark").val(obj.Remark);
                   

                   
                
                },
                error: function (ex) {
                    top.$.ligerDialog.error('操作失败，错误信息：' + ex.responseText);
                }
            });
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
                    <div style="width: 100px; text-align: right; float: right">名称：</div>
                </td>
                <td colspan="3">
                   
                
                     <div style="float: left; width: 420px;">
                       <input type="text" id="Name" name="Name" ltype="text" ligerui="{width:425}" /> 
                    </div>
                   


                </td>
                </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">网址：</div>
                </td>
                <td colspan="3">
                   
                
                     <div style="float: left; width: 365px;">
                       <input type="text" id="URL" name="URL" ltype="text" ligerui="{width:425}" /> 
                    </div>
                    <div style="float: left; width: 40px;"></div></td>

               
            </tr>
            <tr>
              <td><div style="width: 100px; text-align: right; float: right">第一行：</div
                ></td>
              <td><input type="text" id="A" name="A" ltype="text" ligerui="{width:150}" /></td>
              <td><div style="width: 100px; text-align: right; float: right">第二行：</div
                ></td>
              <td><div style="width: 100px; float: left">
                <input id="B" name="B" type="text" ltype="text" ligerui="{width:150}"  />
              </div></td>
            </tr>
            <tr>
              <td><div style="width: 100px; text-align: right; float: right">第三行：</div
                ></td>
              <td><div style="width: 100px; float: left">
                <input id="C" name="C" type="text"  ltype="text" ligerui="{width:150}"/>
              </div></td>
              <td><div style="width: 100px; text-align: right; float: right">第四行：</div
                ></td>
              <td><div style="width: 100px; float: left">
                <input id="D" name="D" type="text" ltype="text" ligerui="{width:150}" />
              </div></td>
            </tr>
            <tr>
                <td><div style="width: 100px; text-align: right; float: right">第五行：</div
                ></td>
                <td>
                    <input type="text" id="E" name="E" ltype="text" ligerui="{width:150}" />
                </td>
                <td><div style="width: 100px; text-align: right; float: right">第六行：</div
                ></td>
                <td>
                    <input type="text" id="F" name="F" ltype="text" ligerui="{width:150}" />
                </td>
            </tr>
           
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</div>
                </td>
                <td colspan="3">
                    <textarea id="Remark" name="Remark" cols="100" rows="4" class="l-textarea" style="width:425px"></textarea>
             
                </td>
            </tr>
             
        </table>
    </form>
</body>
</html>
