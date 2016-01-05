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
    <script src="../../jlui3.2/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
    
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
     <script src="../../JS/spectrum.js" type="text/javascript"></script>
    <script type="text/javascript">
        var color = "#ECC";
        $(function () {

            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();



            if (getparastr("cid") != null) {
                loadForm(getparastr("cid"));

            } else BindColor(color);

        })

        function BindColor(vcolor) {

            $("#T_color").spectrum({
                color: vcolor,
                // showPaletteOnly: true,//只显示固定的
                //  flat: true,
                // showInput: true,//是否需要点击显示
                className: "full-spectrum",
                showInitial: true,
                showPalette: true,
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

        function f_save() {
            //if ($('#T_employee_sg').val == "" || $('#T_employee_sg').val == null)
            //{
            // alert('操作失败，施工监理不能为空，请先到客户档案中维护！');
            //    return;
            //}
            //if ($(form1).valid()) {
            var sendtxt = "&Action=save&id=" + getparastr("cid");
            // alert($("form :input").fieldSerialize() + sendtxt);
            return $("form :input").fieldSerialize() + sendtxt;
            //}
        }

        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/CE_Para.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', cid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(result); //String 构造函数
                    $("#T_px").val(obj.JDPX);
                    $("#T_name").val(obj.JDMC);
                    //$("#T_color").spectrum.bind("#" + obj.JDYS);
                    // $("#T_color").val("#" + obj.JDYS);
                    BindColor("#" + obj.JDYS);
                    $("#T_remarks").val(obj.REMARK);



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
                <td colspan="3" class="table_title1">进度属性维护</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">名称：</div>
                </td>
                <td>
                         <input type="text" id="T_name" name="T_name"  ltype="text"  ligerui="{width:180}"  validate="{required:true}" />
                    
                </td>
                           <td> </td>
                     </tr>
               
         
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">排序：</div>
                </td>
                <td>
                    <input id="T_px" name="T_px" ltype="text"  ligerui="{width:180}"  validate="{required:true}" />
                   
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

                 <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">颜色：</div>
                </td>
                <td>
          <div   >
		  <input type="text" id="T_color" name="T_color"       />
           
	  </div>
        
                    </td>
                  <td align="left">
                       
                      </td>
            </tr>
        </table>

 
    </form>
</body>
</html>
