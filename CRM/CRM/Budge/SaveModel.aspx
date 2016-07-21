<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
       <link href="../../CSS/styles.css" rel="stylesheet" />
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
        var istc = getparastr("istc");
        var tc = "����";
        if (istc == "Y") tc = "�ײ�ģ��";
        else if (istc == "N") tc = "����ģ��";
        $(function () {
            
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();
                 loadForm();

         
            
        })
        function f_save() {
            //if ($('#T_employee_sg').val == "" || $('#T_employee_sg').val == null)
            //{
               // alert('����ʧ�ܣ�ʩ��������Ϊ�գ����ȵ��ͻ�������ά����');
            //    return;
            //}
            //if ($(form1).valid()) {
            var sendtxt = "&Action=savemodel&bid=" + getparastr("bid");
               // alert($("form :input").fieldSerialize() + sendtxt);
                return $("form :input").fieldSerialize() + sendtxt;
            //}
        }
        function f_saveinsert(){
            var sendtxt = "&Action=saveallmb&T_mblx=" + tc.replace("����","");//���Ʋ�����Ϊģ��
            // alert($("form :input").fieldSerialize() + sendtxt);
            return $("form :input").fieldSerialize() + sendtxt;
        }
         
        function loadForm() {            
            $("#T_companyid").val(getparastr("cid"));
            $("#T_company").val(tc+decodeURI(getparastr("cname")));
            $("#T_budgeid").val(getparastr("bid")); 
            $("#T_compname").val(tc + decodeURI(getparastr("bname")));
            IsExisModelID();
        }
         
            function IsExisModelID() {
        
                $.ajax({
                    type: "get",
                    url: "../../data/Budge.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                    data: { Action: 'isexistmodelid',bid:getparastr("bid"), rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                  
                        var obj = eval(result);
                  
                        for (var n in obj) {
                            if (obj[n] == "null" || obj[n] == null)
                                obj[n] = "";
                        }
                        //alert(obj.bid); //String ���캯��
                        if (obj.bid == undefined || obj.bid == '')
                        { $("#lbtips").html(); }
                        else{
                            $("#lbtips").html("��Ԥ���Ѿ�������ģ�壺" + obj.bid);
                            $("#lbtips").addClass("red");
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("��ȡԤ����ʧ�ܣ�����ѡ��");
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
                <td colspan="4" class="table_title1">������Ϣ</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">�ͻ�������</div>
                </td>
                <td>
                         <input type="text" id="T_company" name="T_company"  ltype="text" ligerui="{width:180,disabled:true}" validate="{required:true}" />
                     <input id="T_companyid" name="T_companyid" type="hidden" />
                   
                  
                    
                </td>
                <td>
                    <div style="width: 80px; text-align: right; float: right">Ԥ���ţ�</div>
                </td>
                <td>
                    <input id="T_budgeid" name="T_budgeid" type="text" ltype="text" ligerui="{width:180,disabled:true}" validate="{required:false}" /></td>
            </tr>
               
             <tr  >
                <td>
                    <div style="width: 80px; text-align: right; float: right">ģ�����ƣ�</div>
                </td>
                <td colspan="3">

                    <input id="T_compname" name="T_compname" type="text" ltype="text" ligerui="{width:490}" /></td>
            </tr>
            <tr id="tr_contact4">
                <td>
                    <div style="width: 80px; text-align: right; float: right">��ע��</div>
                </td>
                <td colspan="3">

                    <input id="T_remarks" name="T_remarks" type="text" ltype="text" ligerui="{width:490}" /></td>
            </tr>
            <tr id="tr_contact4">
                <td colspan="4">
                    <label id="lbtips"></label>
                </td>
            </tr>
        </table>


    </form>
</body>
</html>
