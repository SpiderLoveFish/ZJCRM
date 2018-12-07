<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta name="viewport" content="initial-scale=1, user-scalable=0, minimal-ui"/>  
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>六家居装企系统</title>
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <link href="../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../CSS/input.css" rel="stylesheet" type="text/css" />

    <script src="../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
     <script src="../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>

    <script src="../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../JS/XHD.js" type="text/javascript"></script>
    <script src="../lib/jquery.form.js" type="text/javascript"></script>
    <script type="text/javascript" src="../JS/ChineseCharactersToPinyin.js" charset="GBK"></script>  
    <script type="text/javascript" charset="utf-8" src="../ueditor1_2_5_1-utf8-net/editor_config.js"></script>
    <script src="../ueditor1_2_5_1-utf8-net/editor_all.js" type="text/javascript"></script>
    <script src="../ueditor1_2_5_1-utf8-net/lang/zh-cn/zh-cn.js" type="text/javascript"></script>
    <link href="../ueditor1_2_5_1-utf8-net/themes/default/css/ueditor.css" rel="stylesheet" />

    <script type="text/javascript">
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            //$("#T_Contract_name").focus();
            $("form").ligerForm();
            if (getparastr("uid")) {
                loadForm(getparastr("uid"), getparastr("sfkh"));
            } else {
                alert("没有信息！");
            }
        })
        function loadForm(oaid,sfkh) {
            $.ajax({
                type: "get",
                url: "View_APP.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'viewscore', uid: oaid, sfkh: sfkh, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    // alert(obj.unit); //String 构造函数
                   //alert(JSON.stringify(obj));
                    $("#userheadimg").attr("src", "../images/upload/portrait/" + obj.title);
                    $("#T_jf").val(obj.Jf);
                    $("#T_Name").val(obj.name);
                    $("#T_remarks").val(obj.Content);
                }
            });
        }
    </script>
</head>
<body>
      <form id="form1" onsubmit="return false">     
        <table align="left" border="0" cellpadding="3" cellspacing="1">
                        <tr class="table_title1">
                <td  colspan="4" >基本信息</td> 
            </tr>
            <tr>
               
                        <td   rowspan="4">
                        <img id="userheadimg" src="a.gif" onerror="noheadimg()" style="border-radius: 4px; box-shadow: 1px 1px 3px #111; width: 120px; height: 120px; margin-left: 5px; background: #d2d2f2; border: 3px solid #fff; behavior: url(../css/pie.htc);" />

                    </td>
                   </tr>

            <tr>
                <td>
                     <div align="left" style="width: 60px">姓名：</div>
                </td>
                <td>
                  <input type='text' id="T_Name" name="T_Name" ltype="text" ligerui="{width:150}" /></td>
               </tr>
                 <tr>  <td>
                    <div align="left" style="width: 60px">积分：</div>
                </td>
                <td>
                <input type="text" id="T_jf" name="T_jf" ltype='text' ligerui="{width:150}"   />
                  </td>
                      </tr>


 
              
            
            <tr>
                
                <td colspan="4"><div align="left" style="width: 60px">说明↓</div></td>
            </tr>
            <tr>
              <td colspan="4"> <textarea id="T_remarks" name="T_remarks" cols="100" rows="10" class="l-textarea" style="width:230px"></textarea></td>
            </tr>

        </table>
    </form>

</body>
</html>
