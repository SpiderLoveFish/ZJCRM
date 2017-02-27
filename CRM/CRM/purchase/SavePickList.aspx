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
        var rowid = "";
        $(function () {
            rowid = getparastr("rowid")
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
            ck = $("#ckisgd").ligerCheckBox();
            $("form").ligerForm();
            gcombkh = $('#T_companyname').ligerComboBox({ width: 250, onBeforeOpen: f_selectContact });
            gcombgys = $('#T_gysname').ligerComboBox({ width: 250, onBeforeOpen: f_selectContactgys });
            var cur = new Date();
            var y = cur.getFullYear();
            var m = cur.getMonth() + 1;
            var d = cur.getDate();
            $('#T_cgrq').val(y + '-' + m + '-' + d);
            $('#T_cwny').val(y + '' + pad(m, 2));
         
            
        })
        function f_save() {
            if ($('#T_compname').val() == "" || $('#T_gysname').val() == "")
            {
                alert('�ͻ��͹�Ӧ�̱���ѡ��');
                return;
            }
            if ($('#T_Pid').val() == "" || $('#T_Pid').val() == null)
            {   
            alert('�������ʧ�ܣ���');
            return;
             }
                var isAccept = ck.getValue();
                var isgd = 0;
                if (isAccept) isgd = 1;
                var sendtxt = "&isgd=" + isgd + "&bjlist=" + "," + rowid + "&pid=" + $('#T_Pid').val() + "&cid=" + $('#T_companyid').val();
                sendtxt += "&remark=" + $('#T_remarks').val() + "&supid=" + $('#T_gysid').val()
                var a = $("form :input").fieldSerialize() + sendtxt;
                return a;
             
        }
    

        //ѡ��ͻ�
        function f_selectContact() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ��ͻ�', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Budge/SelectBudgeCustomer.aspx", buttons: [
                    { text: 'ȷ��', onclick: f_selectContactOK },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        //ѡ��Ӧ��
        function f_selectContactgys() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ��Ӧ��', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Purchase/SelectSupplier.aspx", buttons: [
                    { text: 'ȷ��', onclick: f_selectContactgysOK },
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
                alert('��ѡ��һ����Ч�ͻ�!');
                return;
            }
            fillemp(data.CustomerID, data.CustomerName,
                data.sgjl, data.address);

            dialog.close();
        }

        function f_selectContactgysOK(item, dialog) {
            //var data = dialog.frame.f_select();
            var fn = dialog.frame.f_select;
            var data = fn();
            if (!data) {
                alert('��ѡ��һ����Ч��Ӧ��!');
                return;
            }
            fillempgys(data.ID, data.Name);

            dialog.close();
        }
        function getmaxid() {

            $.ajax({
                type: "get",
                url: "../../data/Purchase.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'getmaxid', rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(obj.pid); //String ���캯��
                    $("#T_Pid").val(obj.pid);
                    $("#T_employee2").val(obj.cly);

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("��ȡԤ����ʧ�ܣ�����ѡ��");
                }
            });
        }

        function f_selectContactCancel(item, dialog) {
            dialog.close();
            fload();
        }
        function fillemp(id, emp, sgjl, address) {
            $("#T_companyid").val(id);
            $("#T_companyname").val(emp + '(' + address + ')');
            $("#T_employee").val(sgjl);
        }
        function fillempgys(id, emp) {
            $("#T_gysid").val(id);
            $("#T_gysname").val(emp);
            getmaxid();
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
                <td >
                    <div style="width: 80px; text-align: right; float: right">�ͻ���Ϣ��</div>
                </td>
                <td colspan="3">
                         <input type="text" id="T_companyname" name="T_companyname"  ltype="text" ligerui="{width:250,disabled:true}" validate="{required:true}" />
                     <input id="T_companyid" name="T_companyid" type="hidden" />
                   
                  
                    
                </td>
                            </tr>
               
             <tr  >
                <td>
                    <div style="width: 80px; text-align: right; float: right">��Ӧ�����ƣ�</div>
                </td>
                <td colspan="3">

                     <input id="T_gysid" name="T_gysid" type="hidden" />
                    <input id="T_gysname" name="T_gysname" type="text" ltype="text" 
                        ligerui="{width:250,disabled:true}" validate="{required:false}" />
            </tr>
             <tr>
<td>
                    <div style="width: 80px; text-align: right; float: right">��ţ�</div>
                </td>
                 <td>
                <input type="text"  id="T_Pid" name="T_Pid"  ltype="text" ligerui="{width:150,disabled:true}"   />
                   </td>
                 <td>
                    <div style="width: 80px; text-align: right; float: right">�������£�</div>
                </td>
               <td>
                               <input type="text"  id="T_cwny" name="T_cwny"  ltype="text" ligerui="{width:80,disabled:true}"   />
                  </td>
             </tr>
            <tr>
                  <td   ><span style="width: 60px; text-align: right; float: right">ʩ������</span></td>
                 <td   ><input id="T_employee" name="T_employee" validate="{required:false}"  ltype="text" ligerui="{width:80,disabled:true}"  />


                 </td>
                 <td   ><span style="width: 60px; text-align: right; float: right">����Ա��</span></td>
                 <td    ><input id="T_employee2" name="T_employee2" validate="{required:false}"  ltype="text" ligerui="{width:80,disabled:true}"  /></td>
         
            </tr>
            <tr>
                 <td> 
                  
                    <div class="l-checkbox-wrapper">
                        <%--<a class="l-checkbox"></a>--%>
                        <input type="checkbox" name="ckisgd" id="ckisgd" 
                            class="l-hidden" 
                        ligeruiid="ckisgd"/></div> ֱ�Ϳͻ� 
  
                   </td>
                 <td    ><div style="width: 70px; text-align: right; float: right">��ע��</div></td>
                 <td colspan="2"  ><input id="T_remarks" name="T_remarks" type="text" ltype="text"  ligerui="{width:250}" /></td>
                
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
