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
    <script type="text/javascript" src="../../JS/ChineseCharactersToPinyin.js" charset="GBK"></script>  
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
                initialFrameWidth: 700, initialFrameHeight: 200, toolbars: [
               ['source', '|', 'undo', 'redo', '|',
                'bold', 'italic', 'underline', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
                'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
                'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
                'directionalityltr', 'directionalityrtl', 'indent', '|',
                'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
                'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
                'insertimage', 'emotion', '|',
                'horizontal', 'date', 'time', 'spechars']
                ],
                autoHeightEnabled: true
            });
            $("#T_product_unit").ligerComboBox({ width: 150, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=16&rnd=" + Math.random()})

            $("#T_product_category").ligerComboBox({
                width: 150,
                selectBoxWidth: 150,
                selectBoxHeight: 150,
                valueField: 'id',
                textField: 'text',
                initValue: getparastr("categoryid"),
                treeLeafOnly: false,
                tree: {
                    url: '../../data/crm_product_category.ashx?Action=tree&style=' + getparastr("style") + '&rnd=' + Math.random(),
                    //onSelect: onSelect,
                    idFieldName: 'id',
                    valueField: 'text',
                    usericon: 'd_icon',
                    checkbox: false,
                    itemopen: false
                },
                onSelected: function (newvalue, newtext) {
                    if (!newvalue) {
                        newvalue = -1;

                    } else {
                        //  $("#C_code").val((getpinyin(newtext)).substr(0, 2));
                    }
                }
            });

            if (getparastr("pid")) {
                loadForm(getparastr("pid"));
            }
            $('#T_gys').ligerComboBox({ width: 150, onBeforeOpen: f_selectContact });
      
        });
        function f_selectContact() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ��ͻ�', width: 850, height: 400,
                //../../data/Crm_product.ashx?Action=combogys&rnd=" + Math.random(), initValue: obj.Suppliers });
                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Product/Selectgys.aspx", buttons: [
                    { text: 'ȷ��', onclick: f_selectContactOK },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }

        function f_selectContactOK(item, dialog) {
            //var data = dialog.frame.f_select();
            var fn = dialog.frame.f_select;
            var data = fn();
            if (!data) {
                alert('��ѡ��һ����Ч��Ӧ��!');
                return;
            }
            fillemp(data.Name);
            dialog.close();
        }
        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
        function fillemp(Name) {
            $("#T_gys").val(Name);
        }
        function f_getcode() {
            return $("#C_code").val();
        }
        //����ѡ���Զ�����ϱ���
        function f_select() {

            if ($(form1).valid()) {
                var arr = [];
                arr.push(UE.getEditor('editor').getContent());
                var sendtxt = "&Action=save&pid=" + getparastr("pid") + "&T_content=" + escape(arr);
                var issave = $("form :input").fieldSerialize() + sendtxt + "&AddType=SelectMat&style=" + getparastr("style") + "&cid=" + getparastr("cid");
                if (issave) {
                    $.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                    $.ajax({
                        url: "../../data/Crm_product.ashx", type: "POST",
                        data: issave,
                        success: function (responseText) {
                            $.ligerDialog.closeWaitting();
                            if (responseText == "false:code") {
                                $.ligerDialog.error("���ϴ����ظ�����������д��");
                                return true;
                            }
                            else {
                                //  dialog.close();
                                top.$.ligerDialog.closeWaitting();
                                $.ligerDialog.alert("����ɹ���������ӣ�");
                                $("#form1").each(function () {
                                    this.reset();
                                    $(".l-selected").removeClass("l-selected");
                                });
                            }
                        },
                        error: function () {
                            top.$.ligerDialog.closeWaitting();
                            top.$.ligerDialog.error('����ʧ�ܣ�');
                            return true;
                        }
                    });
                } else return true;
            }
        }

        function f_saveSelect() {
            if ($(form1).valid()) {
                var arr = [];//getparastr("id") ����ͬ��ID������bid,pid,cid
                arr.push(UE.getEditor('editor').getContent());
                var sendtxt = "&Action=save&id=" + getparastr("id") + "&T_content=" + escape(arr); //compnameԤ���õ��Ĳ���
                return $("form :input").fieldSerialize() + sendtxt + "&style=" + getparastr("style") + "&AddType=" + getparastr("type") + "&compname=" + getparastr("compname");
            }


        }

        function f_save() {
            if ($(form1).valid()) {
                var arr = [];
                arr.push(UE.getEditor('editor').getContent());
                var sendtxt = "&Action=save&pid=" + getparastr("pid") + "&T_content=" + escape(arr);
                return $("form :input").fieldSerialize() + sendtxt + "&style=" + getparastr("style");
            }


        }

        function loadForm(oaid) {
            $.ajax({
                type: "get",
                url: "../../data/Crm_product.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'form', pid: oaid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(obj.unit); //String ���캯��
                    $("#T_product_name").val(obj.product_name);
                    // $("#T_product_unit").val(obj.unit);
                    $("#T_specifications").val(obj.specifications);
                    $("#T_remarks").val(obj.remarks);
                    $("#T_url").val(obj.url);
                    $("#T_price").val(toMoney(obj.price));
                    $("#T_zc_price").val(toMoney(obj.zc_price));
                    $("#T_fc_price").val(toMoney(obj.fc_price));
                    $("#T_rg_price").val(toMoney(obj.rg_price));
                    UE.getEditor('editor').setContent(myHTMLDeCode(obj.t_content));
                    $("#T_product_category").ligerGetComboBoxManager().selectValue(obj.category_id);
                    $("#T_nbj").val(toMoney(obj.InternalPrice));
                    $("#T_xh").val(obj.ProModel);
                    $("#T_gys").val(obj.Suppliers);
                    $("#T_xl").val(obj.ProSeries);
                    $("#T_zt").val(obj.Themes);
                    $("#T_pp").val(obj.Brand);
                    $("#C_code").val(obj.C_code);
                    //emptyText: '���գ�',
                    $("#T_product_unit").val(obj.unit);
                    //$("#T_product_unit").ligerComboBox({ width: 150, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=16&rnd=" + Math.random(), initValue: obj.unit })
                    // $("#T_gys").ligerComboBox({ width: 280, url: "../../data/Crm_product.ashx?Action=combogys&rnd=" + Math.random(), initValue: obj.Suppliers });

                }
            });
        }

        function set_tomoney(value) {
            $("#T_price").val(toMoney(value));

        }
        function set_tomoney_zc(value) {
            $("#T_price").val(parseFloat($("#T_zc_price").val().replace(",", "")) + parseFloat($("#T_fc_price").val().replace(",", "")) + parseFloat($("#T_rg_price").val().replace(",", "")));

            $("#T_zc_price").val(toMoney(value));

        }
        function set_tomoney_fc(value) {
            $("#T_price").val(parseFloat($("#T_zc_price").val().replace(",", "")) + parseFloat($("#T_fc_price").val().replace(",", "")) + parseFloat($("#T_rg_price").val().replace(",", "")));
            $("#T_fc_price").val(toMoney(value));

        }
        function set_tomoney_rg(value) {
            $("#T_price").val(parseFloat($("#T_zc_price").val().replace(",", "")) + parseFloat($("#T_fc_price").val().replace(",", "")) + parseFloat($("#T_rg_price").val().replace(",", "")));
            $("#T_rg_price").val(toMoney(value));

        }
        function set_tomoney_nbj(value) {
            $("#T_nbj").val(toMoney(value));
        }

        ///������Ĭ�ϵ�һ��
        function getpinyin(str) {
            //var str = document.getElementById("txtChinese").value.trim();
            if (str == "") return '';
            var py = '';
            var arrRslt = makePy(str);
            for (var j = 0; j < arrRslt.length; j++) {
                py = py + arrRslt[j];
            }
            return py;
        }

        function checkInt(o) {
            theV = isNaN(parseInt(o.value)) ? 0 : parseInt(o.value);
            if (theV != o.value) { o.value = theV; }
            T_price.value = T_zc_price.value + T_fc_price.value + T_rg_price.value;
        }
        function checkP(o) {
            theV = isNaN(parseFloat(o.value)) ? 0 : parseFloat(o.value);
            theV = parseInt(theV * 100) / 100;
            if (theV != o.value) {
                theV = (theV * 100).toString();
                theV = theV.substring(0, theV.length - 2) + "." + theV.substring(theV.length - 2, theV.length)
                o.value = theV;
            }
            T_price.value = T_zc_price.value + T_fc_price.value + T_rg_price.value;
        }

    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">     
        <table align="left" border="0" cellpadding="3" cellspacing="1">
                        <tr>
                <td colspan="8" class="table_title1">������Ϣ</td>
            </tr>
            <tr>
               
                <td>
                    <div align="left" style="width: 60px">��Ʒ���</div>
                </td>
                <td>
                    <input type="text" id="T_product_category" name="T_product_category" validate="{required:true}"  ligerui="{width:150}" /></td>
                 <td>
                    <div align="left" style="width:60px">��Ʒ���ƣ�</div>
                </td>
                <td><input type='text' id="T_product_name" name="T_product_name" ltype="text" ligerui="{width:150}" validate="{required:true}" /></td>
                <td><div align="left" style="width: 60px">��λ��</div></td>
                <td> <input type='text' id="T_product_unit" name="T_product_unit" validate="{required:true}"  ligerui="{width:150}" /></td>
                <td><div align="left" style="width: 60px">��Ʒ���</div></td>
                <td><input type='text' id="T_specifications" name="T_specifications" ltype="text" ligerui="{width:150}" /></td>
            </tr>

            <tr>
                <td>
                     <div align="left" style="width: 60px">Ʒ�ƣ�</div>
                </td>
                <td>
                  <input type='text' id="T_pp" name="T_pp" ltype="text" ligerui="{width:150}" /></td>
                <td>
                    <div align="left" style="width: 60px">�ͺţ�</div>
                </td>
                <td>
                <input type="text" id="T_xh" name="T_xh" ltype='text' ligerui="{width:150}"   />
                  </td>
                <td> <div align="left" style="width: 60px">ϵ�У�</div></td>
                <td>  <input type='text' id="T_xl" name="T_xl" ltype="text" ligerui="{width:150}" /></td>
                <td> <div align="left" style="width: 60px">���⣺</div></td>
                <td> <input type='text' id="T_zt" name="T_zt" ltype="text" ligerui="{width:150}" /></td>
            </tr>



            <tr>
             <td><div align="left" style="width:60px">���ϴ��룺</div></td>
                <td>  <input type='text' id="C_code" name="C_code" ltype="text" ligerui="{width:150,disabled:true}"   /></td>
            
                <td>
                    <div align="left" style="width: 60px">��ַ��</div>
                </td>
                <td>
                    <input type="text" id="T_url" name="T_url" ltype='text' ligerui="{width:150}" validate="{required:false,url:true}" /></td>
               
               
                <td>  <div align="left" style="width:60px">��Ӧ�̣�</div></td>
                <td>  <input type='text' id="T_gys" name="T_gys" ligerui="{width:150}"   /></td>
                 <td>
                    <div align="left" style="width: 60px">�ڲ��ۣ�</div>
                </td>
                <td>
                    <input type="text" id="T_nbj" name="T_nbj" value="0.00" ltype='text' onchange="set_tomoney_nbj(this.value)" style="text-align:right" ligerui="{width:150,number:true}" validate="{required:true}" /></td>
                
            </tr>
            <tr>
                <td colspan="8" class="table_title1">Ԥ��۸���Ϣ</td>
            </tr>
           
             <tr>
               <td>
                <div align="left" style="width: 60px">���ĵ��ۣ�</div>  
               </td>
               <td >
               <input type="text" id="T_zc_price" name="T_zc_price" value="0.00" ltype='text' onchange="set_tomoney_zc(this.value)" style="text-align:right" ligerui="{width:150,number:true}" validate="{required:true}"  />
               </td>
            <td>
                <div align="left" style="width: 60px">���ĵ��ۣ�</div>  
               </td>
               <td >
               <input type="text" id="T_fc_price" name="T_fc_price" value="0.00" ltype='text' onchange="set_tomoney_fc(this.value)" style="text-align:right" ligerui="{width:150,number:true}" validate="{required:true}" />
               </td>
                <td> <div align="left" style="width: 60px">�˹����ۣ�</div></td>
                <td> <input type="text" id="T_rg_price" name="T_rg_price" value="0.00" ltype='text' onchange="set_tomoney_rg(this.value)" style="text-align:right" ligerui="{width:150,number:true}" validate="{required:true}" /></td>
                <td>
                <div align="left" style="width: 60px">�ܼ۸�</div>  
               </td>
               <td >
               <input type="text" id="T_price" name="T_price" value="0.00" ltype='text' onchange="set_tomoney(this.value)" style="text-align:right" ligerui="{width:150,number:true,disabled:true}" validate="{required:true}" />
               </td>
               
          </tr>
                  <tr>
                <td colspan="8" class="table_title1">ͼ�ļ�����˵��</td>
            </tr>     
            <tr>
                <td colspan="6" rowspan="2">
                    <textarea id="editor" style="width: 700px;" cols="20"></textarea>
                </td>
                <td colspan="2"><div align="left" style="width: 60px">����˵����</div></td>
            </tr>
            <tr>
              <td colspan="2"> <textarea id="T_remarks" name="T_remarks" cols="100" rows="20" class="l-textarea" style="width:230px"></textarea></td>
            </tr>

        </table>
    </form>
</body>
</html>
