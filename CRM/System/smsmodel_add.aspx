<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
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
                    $("#T_title").val(obj.title);
                    $("#T_mbdm").val(obj.SmsCode);


                }
            });
        }
        function getVal(id) {
            $.ajax({
                url: "../../data/smsmodel.ashx", type: "POST",
                data: { Action: "IsExistCode", id: getparastr("id"), code: document.getElementById(id).value, rnd: Math.random() },
                success: function (responseText) {
                    if (responseText == "false:code") {
                        top.$.ligerDialog.alert(document.getElementById(id).value + '这个编码已经存在！');

                        $("#T_mbdm").val("");
                    }
                },
                error: function () {

                    // top.$.ligerDialog.error('操作失败！');
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
    <form id="form1" onSubmit="return false">
        <table border="0" cellpadding="3" cellspacing="1" style="background: #fff; width: 100%" class='bodytable1'>
                <tr>
         <td >

                    <div align="right" style="width: 80px">使用说明：</div>
                </td>
                <td height="20" colspan="5">
                   <p><strong style="color:red">模板设置的内容中可以使用参数作为动态内容，使用时根据需要的内容快速替换。
                   </br>最多可以设置六个参数：@p1,@p2,@p3,@p4,@p5,@p6</strong></br>如模板设置为：您好<strong style="color:red">@p1</strong>，我是<strong style="color:red">@p2</strong>，您家<strong style="color:red">@p3</strong>已完工。<strong style="color:red">（注意：p请用小写字母）</strong><br>
                   使用时填写参数：@p1：张先生，@p2：设计师张三，@p3：水电<br>
                   生成服务内容：您好张先生，我是设计师张三，您家水电已完工。</p>
                   </td>
            </tr>
            <tr>
                <td colspan="7" class="table_title1">模板内容设置</td>
            </tr>
            <tr>
                <td height="25">

                    <div align="right" style="width: 60px">标题：</div>
                </td>
                <td height="25" colspan="3">
                    <input type="text" id="T_title" name="T_title" ltype="text" ligerui="{width:290}"   />
                </td>
                <td height="43" style="width: 85px">

                    <div align="right" style="width: 60px">模板短码：</div>
                </td>
                <td height="43" style="width: 85px">

                   <input type="text" id="T_mbdm" name="T_mbdm" ltype="text" ligerui="{width:100}"  onBlur="getVal(this.id)"  />
                </td>
            </tr>
            <tr>
                <td height="43" style="width: 85px">

                    <div align="right" style="width: 60px">内容：</div>
                </td>
                <td height="43" colspan="5">

                   <textarea id="T_name" name="T_name" cols="50" rows="5" class="l-textarea" style="width:490px"></textarea>

                </td>
            </tr>
             <tr>
                <td colspan="7" class="table_title1">填写参数说明（将每个参数代表的含义进行说明）</td>
            </tr>
            <tr>
                <td height="26">

                    <div align="left" style="width: 60px">@P1：</div>
                </td>
                <td width="178" height="26">
                    <input type="text" id="T_p1" name="T_p1" ltype="text" ligerui="{width:100}"   />
                </td>
                <td width="113"><div align="left" style="width: 60px">@P2：</div></td>
                <td width="96"><input type="text" id="T_p2" name="T_p2" ltype="text" ligerui="{width:100}"    /></td>
                <td width="97"><div align="left" style="width: 60px">@P3：</div></td>
                <td width="194"><input type="text" id="T_p3" name="T_p3" ltype="text" ligerui="{width:100}"    /></td>
            </tr>
               <tr>
                <td height="25"><div align="left" style="width: 60px">@P4：</div></td>
                <td height="25"><input type="text" id="T_p4" name="T_p4" ltype="text" ligerui="{width:100}"    /></td>
                <td height="25"><div align="left" style="width: 60px">@P5：</div></td>
                <td height="25"><input type="text" id="T_p5" name="T_p5" ltype="text" ligerui="{width:100}"   /></td>
                <td height="25"><div align="left" style="width: 60px">@P6：</div></td>
                <td height="25"><input type="text" id="T_p6" name="T_p6" ltype="text" ligerui="{width:100}"    /></td>
            </tr>
          
             <tr>
                <td height="43">

                    <div align="left" style="width: 60px">备注：</div>
                </td>
                <td height="43" colspan="5">
                     <textarea id="T_remarks" name="T_remarks" cols="50" rows="3" class="l-textarea" style="width:490px">
                   </textarea>
             
                 
                </td>
            </tr>
         
        </table>
    </form>
</body>
</html>
