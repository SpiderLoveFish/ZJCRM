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

            //UE.getEditor('editor', {
            //    initialFrameWidth: 700, initialFrameHeight: 200, toolbars: [
            //   ['source', '|', 'undo', 'redo', '|',
            //    'bold', 'italic', 'underline', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
            //    'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
            //    'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
            //    'directionalityltr', 'directionalityrtl', 'indent', '|',
            //    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
            //    'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
            //    'insertimage', 'emotion', '|',
            //    'horizontal', 'date', 'time', 'spechars']
            //    ],
            //    autoHeightEnabled: true
            //});
        
            //alert(getparastr("bid"));
            if (getparastr("bid")) {
                loadForm(getparastr("bid"), getparastr("id"));
            }
           
        });
  

   
        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
 
   
        function f_savePZ() {
            if ($(form1).valid()) {
                var arr = [];
              
                var sendtxt = "&Action=savepz&bid=" + getparastr("bid")+"&id="+ getparastr("id") ;
                return $("form :input").fieldSerialize() + sendtxt  ;
            }


        }

        function loadForm(oaid,id) {
            $.ajax({
                type: "get",
                url: "../../data/Budge.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'formdetailMX', bid: oaid,id:id, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    //alert(JSON.stringify(result));
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    
                   
                    $("#T_remarks").val(obj.Remarks);
                    $("#T_budge_id").val(obj.budge_id);
                    $("#T_price").val(toMoney(obj.TotalPrice));
                    $("#T_zc_price").val(toMoney(obj.zc_price));
                    $("#T_fc_price").val(toMoney(obj.fc_price));
                    $("#T_rg_price").val(toMoney(obj.rg_price));
                   // UE.getEditor('editor').setContent(myHTMLDeCode(obj.Remarks));
                 
                    $("#T_id").val( obj.id);
                    $("#T_comp").val(obj.ComponentName);
                    $("#T_name").val(obj.Cname);
               
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
                <td colspan="8" class="table_title1">基本信息</td>
            </tr>
            <tr>
               
                <td>
                    <div align="left" style="width: 60px">预算单号：</div>
                </td>
                <td>
                    <input type="text" ltype="text" id="T_budge_id" name="T_budge_id" validate="{required:true}"  ligerui="{width:150,disabled:true}" /></td>
                 <td>
                    <div align="left" style="width:60px">明细编号：</div>
                </td>
                <td><input type='text' id="T_id" name="T_id" ltype="text" ligerui="{width:50,disabled:true}" validate="{required:true}" /></td>
                <td><div align="left" style="width: 60px">部件：</div></td>
                <td> <input type='text' ltype="text" id="T_comp" name="T_comp" validate="{required:true}"  ligerui="{width:150,disabled:true}" /></td>
                <td><div align="left" style="width: 60px">名称：</div></td>
                <td><input type='text' id="T_name" name="T_name" ltype="text" ligerui="{width:150,disabled:true}" /></td>
            </tr>
 
   <tr>
                <td colspan="8" class="table_title1">预算价格信息</td>
            </tr>
           
             <tr>
               <td>
                <div align="left" style="width: 60px">主材单价：</div>  
               </td>
               <td >
               <input type="text" id="T_zc_price" name="T_zc_price" value="0.00" ltype='text' onchange="set_tomoney_zc(this.value)" style="text-align:right" ligerui="{width:150,number:true}" validate="{required:true}"  />
               </td>
            <td>
                <div align="left" style="width: 60px">辅材单价：</div>  
               </td>
               <td >
               <input type="text" id="T_fc_price" name="T_fc_price" value="0.00" ltype='text' onchange="set_tomoney_fc(this.value)" style="text-align:right" ligerui="{width:150,number:true}" validate="{required:true}" />
               </td>
                <td> <div align="left" style="width: 60px">人工单价：</div></td>
                <td> <input type="text" id="T_rg_price" name="T_rg_price" value="0.00" ltype='text' onchange="set_tomoney_rg(this.value)" style="text-align:right" ligerui="{width:150,number:true}" validate="{required:true}" /></td>
                <td>
                <div align="left" style="width: 60px">总价格：</div>  
               </td>
               <td >
               <input type="text" id="T_price" name="T_price" value="0.00" ltype='text' onchange="set_tomoney(this.value)" style="text-align:right" ligerui="{width:150,number:true,disabled:true}" validate="{required:true}" />
               </td>
               
          </tr>
                  <tr>
                <td colspan="8" class="table_title1">图文及工艺说明</td>
            </tr>     
           
            <tr>
              <td colspan="8" class="table_title1"> <textarea id="T_remarks" name="T_remarks" cols="100" rows="20" class="l-textarea" style="width:730px"></textarea></td>
            </tr>

        </table>
    </form>
</body>
</html>
