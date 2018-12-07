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
        var comkwg;
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
                'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify',
               // '|', 'touppercase', 'tolowercase', '|',
                '|', 'link', 'unlink', '|',
                'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
                'insertimage', 'emotion', '|',
                'horizontal', 'date', 'time', 'spechars']
                ],
                autoHeightEnabled:  false
            });
         
            $('#Receiver').val( decodeURI(getparastr("sgjl")));
            if (getparastr("id")) {
                loadForm(getparastr("id"), getparastr("cid"));
            }
            
            $('#T_gys').ligerComboBox({ width: 150, onBeforeOpen: f_selectContact });
      
        });
 
        function f_selectContact() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择客户', width: 850, height: 400,
                //../../data/Crm_product.ashx?Action=combogys&rnd=" + Math.random(), initValue: obj.Suppliers });
                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Product/Selectgys.aspx", buttons: [
                    { text: '确定', onclick: f_selectContactOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }

        function f_selectContactOK(item, dialog) {
            //var data = dialog.frame.f_select();
            var fn = dialog.frame.f_select;
            var data = fn();
            if (!data) {
                alert('请选择一个有效供应商!');
                return;
            }
            fillemp(data.Name, data.Lxr);
            dialog.close();
        }
        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
        function fillemp(Name, Sender) {
            $("#T_gys").val(Name);
            $("#Sender").val(Name);
        }
        

        function f_save() {
           
            if ($(form1).valid()) {
                var arr = [];
                arr.push(UE.getEditor('editor').getContent());
                var sendtxt = "&Action=updateremarks&id=" + getparastr("id") + "&cid=" + getparastr("cid") + "&T_content=" + escape(arr);
                return $("form :input").fieldSerialize() + sendtxt;
            }


        }

        function loadForm(id,cid) {
            $.ajax({
                type: "get",
                url: "../../data/PurchaseList.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', id: id, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(obj.unit); //String 构造函数
                    $("#T_product_name").val(obj.product_name);
          
                    UE.getEditor('editor').setContent(myHTMLDeCode(obj.t_contents));
                  
                    $("#T_gys").val(obj.SupplierName);
                    $("#Sender").val(obj.Sender); 
                    $("#RequestDate").val(formatTimebytype(obj.RequestDate, "yyyy-MM-dd"));
                     var sgjl = decodeURI(getparastr("sgjl"));
                    //$('#Receiver').val(decodeURI(getparastr("sgjl")));
                    if (obj.Receiver == null || obj.Receiver == "" || obj.Receiver == "null")
                        sgjl = decodeURI(getparastr("sgjl"));
                    else sgjl = obj.Receiver;
                   $("#Receiver").val(sgjl);
                   $("#ShippingMethod").val(obj.ShippingMethod);
                   $("#b1").val(obj.b1);
                }
            });
        }

      
        ///多音字默认第一个
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

      

    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">     
        <table align="left" border="0" cellpadding="3" cellspacing="1">
                   
            <tr>
               
                        <td>
                    <div align="left" style="width:60px">产品名称：</div>
                </td>
                      <td>      <input type='text' id="T_product_name" name="T_product_name" ltype="text" ligerui="{width:150,disabled:true}" validate="{required:true}" />
                </td>     
                      <td>      <div align="left" style="width:60px">供应商：</div></td>     
                      <td>      <input type='text' id="T_gys" name="T_gys" ligerui="{width:150}"   /></td>     
                      <td>      <div align="left" style="width:60px">送货人：</div></td>     
                      <td>     <input type='text' id="Sender" name="Sender"  ltype="text"   ligerui="{width: 150}"  /></td>     
                    </tr>



            <tr>
                   
               
                <td> <div align="left" style="width:60px">要求交期：</div> </td>
                <td> <input type='text' id="RequestDate" name="RequestDate" ltype="date"  ligerui="{width:150}" validate="{required:true}"   /> </td>
                      
                <td> <div align="left" style="width:60px">送货方式：</div></td>
                      
                <td>  <input id="ShippingMethod" name="ShippingMethod" type="text" ltype="select" ligerui="{width:196,data:[{id:'自提',text:'自提'},{id:'供应商送货',text:'供应商送货'}]}" validate="{required:true}" /></td>
                      
                <td>  <div align="left" style="width:60px">收货人：</div></td>
                      
                <td> <input type='text' id="Receiver" name="Receiver" ltype="text" ligerui="{width:150}"   /></td>
                      
            </tr>
            
           <tr>
                 <td>  <div align="left" style="width:60px">备注：</div></td>
                <td colspan="5">  
                   <input type='text' id="b1" name="b1" ltype="text" ligerui="{width:650}"   />
                <%--     <input type='text' id="b2" name="b2" ltype="text" ligerui="{width:150}"   />
                     <input type='text' id="b3" name="b ltype="text" ligerui="{width:150}"   />--%>
                </td>
           </tr>
           <%--  <tr>
                   
               
                <td>  <div align="left" style="width:60px">备注123：</div></td>
                <td>  
                   <input type='text' id="b1" name="b1" ltype="text" ligerui="{width:150}"   />
                     <input type='text' id="b2" name="b2" ltype="text" ligerui="{width:150}"   />
                     <input type='text' id="b3" name="b3" ltype="text" ligerui="{width:150}"   />
                </td>
                      
                <td>  
                    &nbsp;</td>
                      
                <td>  
                    &nbsp;</td>
                      
                <td>  
                    &nbsp;</td>
                      
                <td>  
                    &nbsp;</td>
                      
            </tr>--%>
                  <tr>
                <td  colspan="6" class="table_title1">特别说明</td>
                               
            </tr>   
             
            <tr>
                <td  colspan="4"  >
                    <textarea id="editor" style="width: 220px;" cols="20"></textarea>
                </td>
                
                <td  >
                    &nbsp;</td>
                
                <td  >
                    &nbsp;</td>
                
            </tr>
         

        </table>
    </form>
</body>
</html>
