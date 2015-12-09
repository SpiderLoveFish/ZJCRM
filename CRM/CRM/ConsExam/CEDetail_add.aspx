<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>

    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>

    <script type="text/javascript" charset="utf-8" src="../../ueditor1_2_5_1-utf8-net/editor_config.js"></script>
    <script src="../../ueditor1_2_5_1-utf8-net/editor_all.js" type="text/javascript"></script>
    <script src="../../ueditor1_2_5_1-utf8-net/lang/zh-cn/zh-cn.js" type="text/javascript"></script>
    <link href="../../ueditor1_2_5_1-utf8-net/themes/default/css/ueditor.css" rel="stylesheet" />

    <script type="text/javascript">
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            //$("#T_Contract_name").focus();
            $("form").ligerForm();

            UE.getEditor('editor', {
                initialFrameWidth: 738, toolbars: [
               ['source', '|', 'undo', 'redo', '|',
                'bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
                'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
                'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
                'directionalityltr', 'directionalityrtl', 'indent', '|',
                'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
                'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
                'insertimage', 'emotion', 'template', 'background', '|',
                'horizontal', 'date', 'time', 'spechars', '|',
                'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', '|',
                'preview', 'searchreplace']
                ],
                autoHeightEnabled: false
            });

            $("#T_product_category").ligerComboBox({
                width: 280,
                selectBoxWidth: 280,
                selectBoxHeight: 280,
                valueField: 'id',
                textField: 'text',
                initValue: getparastr("categoryid"),
                treeLeafOnly: false,
                tree: {
                    url: '../../data/crm_product_category.ashx?Action=tree&rnd=' + Math.random(),
                    //onSelect: onSelect,
                    idFieldName: 'id',
                    valueField: 'text',
                    usericon: 'd_icon',
                    checkbox: false,
                    itemopen: false
                }
            });

            if (getparastr("pid")) {
                loadForm(getparastr("pid"));
            }
        });

        function f_save() {
            if ($(form1).valid()) {
                var arr = [];
                arr.push(UE.getEditor('editor').getContent());
                var sendtxt = "&Action=save&pid=" + getparastr("pid") + "&T_content=" + escape(arr);;
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }

        function loadForm(oaid) {
            $.ajax({
                type: "get",
                url: "../../data/Crm_product.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', pid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(obj.constructor); //String 构造函数
                    $("#T_product_name").val(obj.product_name);
                    $("#T_product_unit").val(obj.unit);
                    $("#T_specifications").val(obj.specifications);
                    $("#T_remarks").val(obj.remarks);
                    $("#T_url").val(obj.url);
                    $("#T_price").val(toMoney(obj.price));
                    UE.getEditor('editor').setContent(myHTMLDeCode(obj.t_content));
                    $("#T_product_category").ligerGetComboBoxManager().selectValue(obj.category_id);
                    $("#T_nbj").val(toMoney(obj.InternalPrice));
                    $("#T_xh").val(obj.ProModel);
                    $("#T_gys").val(obj.Suppliers);
                    $("#T_xl").val(obj.ProSeries);
                    $("#T_zt").val(obj.Themes);
                    $("#T_pp").val(obj.Brand);
                }
            });
        }

        function set_tomoney(value) {
            $("#T_price").val(toMoney(value));
           
        }
        function set_tomoney_nbj(value) {
          
            $("#T_nbj").val(toMoney(value));
        }


    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">     
        <table align="left" border="0" cellpadding="3" cellspacing="1">
            <tr>
                <td>
                    <div align="left" style="width:60px">产品名称：</div>
                </td>
                <td colspan="3">
                    <input type='text' id="T_product_name" name="T_product_name" ltype="text" ligerui="{width:637}" validate="{required:true}" /></td>
            </tr>

            <tr>
                <td>
                    <div align="left" style="width: 60px">产品类别：</div>
                </td>
                <td>
                    <input type="text" id="T_product_category" name="T_product_category" validate="{required:true}"  ligerui="{width:280}" /></td>
                <td>
                    <div align="left" style="width: 60px">单位：</div>
                </td>
                <td>
                    <input type='text' id="T_product_unit" name="T_product_unit" ltype='text' ligerui="{width:280}" /></td>
            </tr>

            <tr>
                <td>
                    <div align="left" style="width: 60px">价格(元)：</div>
                </td>
                <td>
                    <input type="text" id="T_price" name="T_price" value="0.00" ltype='text' onchange="set_tomoney(this.value)" style="text-align:right" ligerui="{width:280,number:true}" validate="{required:true}" /></td>
                <td>
                    <div align="left" style="width: 60px">产品规格：</div>
                </td>
                <td>
                    <input type='text' id="T_specifications" name="T_specifications" ltype="text" ligerui="{width:280}" /></td>
            </tr>

            <tr>
                <td>
                    <div align="left" style="width: 60px">网址：</div>
                </td>
                <td>
                    <input type="text" id="T_url" name="T_url" ltype='text' ligerui="{width:280}" validate="{required:false,url:true}" /></td>
                <td style="vertical-align: top">
                    <div align="left" style="width: 60px">备注：</div>
                </td>
                <td>
                    <input type='text' id="T_remarks" name="T_remarks" ltype="text" ligerui="{width:280}" /></td>
            </tr>
            <tr>
                <td>
                    <div align="left" style="width: 60px">型号：</div>
                </td>
                <td>
                    <input type="text" id="T_xh" name="T_xh" ltype='text' ligerui="{width:280}"   /></td>
                <td style="vertical-align: top">
                    <div align="left" style="width: 60px">系列：</div>
                </td>
                <td>
                    <input type='text' id="T_xl" name="T_xl" ltype="text" ligerui="{width:280}" /></td>
            </tr>
            <tr>
                <td>
                    <div align="left" style="width: 60px">品牌：</div>
                </td>
                <td>
                          <input type='text' id="T_pp" name="T_pp" ltype="text" ligerui="{width:280}" /></td>
          <td>
                    <div align="left" style="width: 60px">主题：</div>
                </td>
                <td>
                    <input type='text' id="T_zt" name="T_zt" ltype="text" ligerui="{width:280}" /></td>
            </tr>
             <tr>
                <td>
                    <div align="left" style="width:60px">供应商：</div>
                </td>
                <td >
                    <input type='text' id="T_gys" name="T_gys" ltype="text" ligerui="{width:280}"   /></td>
           <td>
                    <div align="left" style="width: 60px">内部价(元)：</div>
                </td>
                <td>
                    <input type="text" id="T_nbj" name="T_nbj" value="0.00" ltype='text' onchange="set_tomoney_nbj(this.value)" style="text-align:right" ligerui="{width:280,number:true}" validate="{required:true}" /></td>
               
                  </tr>
            <tr>
                <td colspan="4">
                    <textarea id="editor" style="width: 637px;"></textarea>
                </td>
            </tr>

        </table>
    </form>
</body>
</html>
