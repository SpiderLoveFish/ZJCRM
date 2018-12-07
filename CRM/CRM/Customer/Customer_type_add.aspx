<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
     <link href="../../CSS/spectrum.css" rel="stylesheet" />
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
        var color = "#ECC";
        $(function () {

            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();


          
            if (getparastr("id") == null || getparastr("id") == "" || getparastr("id")=="null") {
                $("#typeid").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=1&rnd=" + Math.random(), emptyText: '（空）' });


            } else {
                 loadForm(getparastr("id"));

            };

        })

     
        function f_save() {
           
            var sendtxt = "&Action=save&id=" + getparastr("cid");
            //alert($("form :input").fieldSerialize() + sendtxt);
            //return;
            return $("form :input").fieldSerialize() + sendtxt;
            //}
        }

        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/Customer_type.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', id: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(result); //String 构造函数
                    $('#typeid').ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=1&rnd=" + Math.random(), emptyText: '（空）', initValue: obj.typeid });


                    $("#followhours").val(obj.followhours);
                
                    $("#T_remarks").val(obj.remarks);



                }
            });
        }






    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">
        <input type="hidden" id="h_address" value="" />
        <table style="width: 550px; margin: 5px;" class='bodytable1'>
            <tr>
                <td colspan="3" class="table_title1"> 属性维护</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">类别名称：</div>
                </td>
                <td>
                                            <input id="typeid" name="typeid" type="text" style="width: 96px" validate="{required:true}"/>
 
                    
                </td>
                           <td> </td>
                     </tr>
               
         
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">标准跟进小时：</div>
                </td>
                <td>
                    <input id="followhours" name="followhours" ltype="text"  ligerui="{width:180}"  validate="{required:true}" />
                   
                </td>
                 <td></td>
            </tr>
            <tr id="tr_contact4">
                <td>
                    <div style="width: 80px; text-align: right; float: right">描述：</div>
                </td>
                <td colspan="2">

                    <input id="T_remarks" name="T_remarks" type="text" ltype="text" ligerui="{width:490}" /></td>
            
            </tr>

                
        </table>

 
    </form>
</body>
</html>
