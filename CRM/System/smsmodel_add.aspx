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
        
            loadForm(getparastr("id"));

           
        });

        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=save&id=" + getparastr("id") + "&params_id=" + getparastr("params_id");
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }

        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/smsmodel.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', id: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {

                    }
                    //alert(obj.constructor); //String 构造函数
                    $("#T_name").val(obj.modelname);
                    $("#T_p1").val(obj.para1);
                    $("#T_p2").val(obj.para2);
                    $("#T_p3").val(obj.para3);
                    $("#T_p4").val(obj.para4);
                    $("#T_p5").val(obj.para5);
                    $("#T_p6").val(obj.para6);
                    $("#T_remarks").val(obj.remarks);
                    


                }
            });
        }

     
    </script>
    <style type="text/css">
        .iconlist {
            width: 360px;
            padding: 3px;
        }

            .iconlist li {
                border: 1px solid #FFFFFF;
                float: left;
                display: block;
                padding: 2px;
                cursor: pointer;
            }

                .iconlist li.over {
                    border: 1px solid #516B9F;
                }

                .iconlist li img {
                    height: 16px;
                    height: 16px;
                }
    </style>

</head>
<body style="padding: 0px">
    <form id="form1" onsubmit="return false">
        <table border="0" cellpadding="3" cellspacing="1" style="background: #fff; width: 400px;">

            <tr>
                <td height="43" style="width: 85px" colspan="2">

                    <div align="left" style="width: 80px">名称：</div>
                </td>
                <td height="43">

                   <textarea id="T_name" name="T_name" cols="50" rows="10" class="l-textarea" style="width:230px">尊敬的@p1您好：很感谢您参加我们的@p2活动，我们的价格优惠是@p3 
                   </textarea>

                </td>
            </tr>
            <tr>
                <td height="43" colspan="2">

                    <div align="left" style="width: 80px">参数1描述：</div>
                </td>
                <td height="43">
                    <input type="text" id="T_p1" name="T_p1" ltype="text" ligerui="{width:180}"   />
                </td>
            </tr>
               <tr>
                <td height="43" colspan="2">

                    <div align="left" style="width: 80px">参数2描述：</div>
                </td>
                <td height="43">
                    <input type="text" id="T_p2" name="T_p2" ltype="text" ligerui="{width:180}"    />
                </td>
            </tr>
               <tr>
                <td height="43" colspan="2">

                    <div align="left" style="width: 80px">参数3描述：</div>
                </td>
                <td height="43">
                    <input type="text" id="T_p3" name="T_p3" ltype="text" ligerui="{width:180}"    />
                </td>
            </tr>
               <tr>
                <td height="43" colspan="2">

                    <div align="left" style="width: 80px">参数4描述：</div>
                </td>
                <td height="43">
                    <input type="text" id="T_p4" name="T_p4" ltype="text" ligerui="{width:180}"    />
                </td>
            </tr>
               <tr>
                <td height="43" colspan="2">

                    <div align="left" style="width: 80px">参数5描述：</div>
                </td>
                <td height="43">
                    <input type="text" id="T_p5" name="T_p5" ltype="text" ligerui="{width:180}"   />
                </td>
            </tr>
               <tr>
                <td height="43" colspan="2">

                    <div align="left" style="width: 80px">参数6描述：</div>
                </td>
                <td height="43">
                    <input type="text" id="T_p6" name="T_p6" ltype="text" ligerui="{width:180}"    />
                </td>
            </tr>
          
             <tr>
                <td height="43" colspan="2">

                    <div align="left" style="width: 80px">备注：</div>
                </td>
                <td height="43">
                    <input type="text" id="T_remarks" name="T_remarks" ltype="text" ligerui="{width:180}"  />
             
                </td>
            </tr>
             <tr>
         <td height="43" colspan="2">

                    <div align="left" style="width: 80px">解释：</div>
                </td>
                <td height="43">
                   如：尊敬的@p1您好：很感谢您参加我们的@p2活动，我们的价格优惠是@p3
                    </br>ps:@p1 客户 ；@p2 活动名称 ；@p3 活动介绍
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
