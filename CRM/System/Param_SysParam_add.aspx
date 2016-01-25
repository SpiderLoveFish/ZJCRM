<%@ Page Language="C#" AutoEventWireup="true"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head  >
    <title></title>
    <link href="../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />    
    <link href="../CSS/input.css" rel="stylesheet" type="text/css" />
    <link href="../CSS/spectrum.css" rel="stylesheet" />

    <script src="../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../jlui3.2/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
    
     <script src="../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>    
    
    <script src="../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../JS/XHD.js" type="text/javascript"></script>
         <script src="../JS/spectrum.js" type="text/javascript"></script>
    <script src="../lib/jquery.form.js" type="text/javascript"></script>

    <script type="text/javascript">
        var color = "#ECC";
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            //$("#T_Contract_name").focus();
            $("form").ligerForm();


            if (getparastr("paramid")) {
                loadForm(getparastr("paramid"));
            }
            else BindColor(color);

            $("#T_param_name").attr("validate", "{ required: true, remote: remote, messages: { required: '请输入参数', remote: '此参数已存在!' } }");
        });
        function remote() {
            var url = "../../data/Param_SysParam.ashx?Action=validate&T_cid=" + getparastr("paramid") + "&parentid=" + getparastr("parentid") + "&rnd=" + Math.random();
            return url;
        }
        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=save&paramid=" + getparastr("paramid") + "&parentid=" + getparastr("parentid");
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }


        function BindColor(vcolor) {
            $("#T_color").val("#" + vcolor);
            $("#T_color").spectrum({
                color: vcolor,
                // showPaletteOnly: true,//只显示固定的
                //  flat: true,
                // showInput: true,//是否需要点击显示
                className: "full-spectrum",
                showInitial: true,
                showPalette: true,
               // showPaletteOnly: true,
                showSelectionPalette: true,
                maxPaletteSize: 10,
                preferredFormat: "hex",
                hideAfterPaletteSelect: true,
                localStorageKey: "spectrum.demo",
                showButtons: false,//不需要确定下再保存

                move: function (color) {

                },
                show: function () {

                },
                beforeShow: function () {

                },
                hide: function () {

                },
                change: function () {

                },
                palette: [
                    ["rgb(0, 0, 0)", "rgb(67, 67, 67)", "rgb(102, 102, 102)",
                    "rgb(204, 204, 204)", "rgb(217, 217, 217)", "rgb(255, 255, 255)"],
                    ["rgb(152, 0, 0)", "rgb(255, 0, 0)", "rgb(255, 153, 0)", "rgb(255, 255, 0)", "rgb(0, 255, 0)",
                    "rgb(0, 255, 255)", "rgb(74, 134, 232)", "rgb(0, 0, 255)", "rgb(153, 0, 255)", "rgb(255, 0, 255)"],
                    ["rgb(230, 184, 175)", "rgb(244, 204, 204)", "rgb(252, 229, 205)", "rgb(255, 242, 204)", "rgb(217, 234, 211)",
                    "rgb(208, 224, 227)", "rgb(201, 218, 248)", "rgb(207, 226, 243)", "rgb(217, 210, 233)", "rgb(234, 209, 220)",
                    "rgb(221, 126, 107)", "rgb(234, 153, 153)", "rgb(249, 203, 156)", "rgb(255, 229, 153)", "rgb(182, 215, 168)",
                    "rgb(162, 196, 201)", "rgb(164, 194, 244)", "rgb(159, 197, 232)", "rgb(180, 167, 214)", "rgb(213, 166, 189)",
                    "rgb(204, 65, 37)", "rgb(224, 102, 102)", "rgb(246, 178, 107)", "rgb(255, 217, 102)", "rgb(147, 196, 125)",
                    "rgb(118, 165, 175)", "rgb(109, 158, 235)", "rgb(111, 168, 220)", "rgb(142, 124, 195)", "rgb(194, 123, 160)",
                    "rgb(166, 28, 0)", "rgb(204, 0, 0)", "rgb(230, 145, 56)", "rgb(241, 194, 50)", "rgb(106, 168, 79)",
                    "rgb(69, 129, 142)", "rgb(60, 120, 216)", "rgb(61, 133, 198)", "rgb(103, 78, 167)", "rgb(166, 77, 121)",
                    "rgb(91, 15, 0)", "rgb(102, 0, 0)", "rgb(120, 63, 4)", "rgb(127, 96, 0)", "rgb(39, 78, 19)",
                    "rgb(12, 52, 61)", "rgb(28, 69, 135)", "rgb(7, 55, 99)", "rgb(32, 18, 77)", "rgb(76, 17, 48)"]
                ]
            });
        }


        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../data/Param_SysParam.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', paramid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        
                    }
                    //alert(obj.constructor); //String 构造函数
                    $("#T_param_name").val(obj.params_name);
                    $("#T_param_order").val(obj.params_order);
                    BindColor("#" + obj.setcolor);
                }
            });
        }
        
    </script>
</head>
<body style="margin:5px 5px 5px 5px">
    <form id="form1" onsubmit="return false">
    <div>
        <table  align="left" border="0" cellpadding="3" cellspacing="1" 
            style="background: #fff; width:320px;">
            
            <tr>
                <td  width="65px"  ><div align="left" style="width: 61px">参数名称：</div></td>
                <td   >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_param_name" name="T_param_name" ltype="text"   ligerui="{width:180}" validate="{required:true}" />
                    </div>                    
                </td>
            </tr>
            
            <tr>
                <td  width="65px"  ><div align="left" style="width: 61px">参数排序：</div></td>
                <td   >
                    <input type="text" id="T_param_order" name="T_param_order" value="20"  ltype='spinner' ligerui="{type:'int',width:180}"/>
                </td>
            </tr>
             <tr>
                <td  width="65px"  ><div align="left" style="width: 61px">颜色：</div></td>
                <td   >
               <input type="text" id="T_color" name="T_color"       />   </td>
            </tr>
            </table>
    </div>
    </form>
</body>
</html>
