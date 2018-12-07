<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
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
        var ci = false;
        var  bq = "";
        
        $(function () {
            

            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();

            loadForm(getparastr("cid"));

            $('#T_employee').ligerComboBox({ width: 196, onBeforeOpen: f_selectContact });
            $('#T_employee_sg').ligerComboBox({ width: 196, onBeforeOpen: f_selectContact_sg });
            $('#T_employee_sj').ligerComboBox({ width: 196, onBeforeOpen: f_selectContact_sj });
            $("#T_company").attr("validate", "{ required: true, remote: remote, messages: { required: '������ͻ�����', remote: '�˿ͻ��Ѵ���!' } }");
            $('#T_bq').ligerComboBox({ width: 97, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=18&rnd=" + Math.random(), emptyText: '���գ�', onSelected: function (newvalue, newtext) { onSelect(newvalue, newtext); } });

            var T_company = document.getElementById("T_company");
            T_company.readOnly = true;
        })

        function onSelect(newvalue, newtext)
        {
            if (bq.indexOf(newvalue) > 0)
                return false;
            bq += ";" + newvalue + "," + newtext;;
            $("#bqspan").append(" <input type='button' class='btn1' id='a" + newvalue + "' value='" + newtext + "'>");
            addBtnEventry(newvalue, newtext);
          
        }
        function addBtnEventry(id, text) {
            $("#a" + id).bind("click", function () {
                $.ligerDialog.confirm("�Ƿ�ȷ��ɾ��", "�Ƿ�ȷ��ɾ�������������棡", function (ok) {
                    $.ligerDialog.closeWaitting();
                    if (ok) {
                        $("#a" + id).remove();
                      
                        bq = bq.replace(";" + id + "," + text, "");//ȡ��
    
                    }
                    else { return; }
                });

            });
        }
        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=save_GJXG&id=" + getparastr("cid") + "&bq=" + bq;
                //alert($("form :input").fieldSerialize()+"@"+sendtxt);
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }
        var a; var b; var c; var d; var e; var f; var g; var h; var i;

        function loadForm(oaid) {
            $("#tr_contact0,#tr_contact1,#tr_contact2,#tr_contact3,#tr_contact4,#tr_contact5").remove();
            $.ajax({
                type: "GET",
                url: "../../data/crm_customer.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'form', cid: oaid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(obj.constructor); //String ���캯��
                    $("#T_company").val(obj.Customer);
                    $("#T_Gender").val(obj.Gender);
                    $("#T_BNo").val(obj.BNo);
                    $("#T_RNo").val(obj.RNo);
                    $("#T_DyNo").val(obj.DyNo);
                    $("#T_customername").val(obj.contact);
                    $("#T_address").val(obj.address);
                    $("#T_qq").val(obj.QQ);
                    $("#T_mobil").val(obj.mobil);
                    $("#T_tel").val(obj.tel);
                    $("#T_fax").val(obj.fax);
                    $("#T_Website").val(obj.site);
                    $("#T_email").val(obj.email);
                    $("#T_descript").val(obj.DesCripe);
                    $("#T_remarks").val(obj.Remarks);
                    $("#T_contact_dep").val(obj.contact_dep);
                    $("#T_contact_position").val(obj.contact_position);
                    $("#T_company_tel").val(obj.tel);
                    $("#T_jfrq").val(obj.Jfrq);
                    $("#T_zxrq").val(obj.Zxrq);
                    $("#T_jhrq1").val(obj.Jhrq1);
                    $("#T_jhrq2").val(obj.Jhrq2);
                    $("#T_fwyt").val(obj.Fwyt);
                    $("#T_fwmj").val(obj.Fwmj);
                    $("#T_xy").val(obj.xy);
                    $("#T_QQ").val(obj.QQ);
                    $("#T_JKDZ").val(obj.JKDZ);
                    $("#T_hxt").val(obj.hxt);
                    $("#T_ybqjt").val(obj.ybqjt);
                    $("#T_jgqjt").val(obj.jgqjt);
                    $("#T_lrrq").val(obj.Create_date1);

                    if (obj.DesCripe != '' && obj.DesCripe != null && obj.DesCripe != 'null') {
                        var str = obj.DesCripe.split(";");
                        for (var i = 1; i < str.length; i++) {
                            var strtext = str[i].split(",");
                            if (strtext[0] == "") break;
                            else
                            onSelect(strtext[0], strtext[1])
                        }
                    }
                       

                    if (obj.Department && obj.Employee)
                        fillemp(obj.Department, obj.Department_id, obj.Employee, obj.Employee_id);
                    else {
                        $.getJSON("../../data/hr_employee.ashx?Action=form&id=epu&rnd=" + Math.random(), function (result) {
                            var obj = eval(result);
                            for (var n in obj) {
                                if (obj[n] == null)
                                    obj[n] = "";
                            }
                            fillemp(obj.dname, obj.d_id, obj.name, obj.ID);
                        })
                    }
                    if (obj.Dpt_sg && obj.Emp_sg)
                        fillemp_sg(obj.Dpt_sg, obj.Dpt_id_sg, obj.Emp_sg, obj.Emp_id_sg);
                    if (obj.Dpt_sj && obj.Emp_sj)
                        fillemp_sj(obj.Dpt_sj, obj.Dpt_id_sj, obj.Emp_sj, obj.Emp_id_sj);
                    //�ɻ����� ����
                    $('#T_customertype').ligerComboBox({ width: 97, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=1&rnd=" + Math.random(), emptyText: '���գ�', initValue: obj.CustomerType_id });

                    //�ͻ����ͽ��
                    $('#T_customerlevel').ligerComboBox({ width: 96, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=2&rnd=" + Math.random(), emptyText: '���գ�', initValue: obj.CustomerLevel_id });
                    //�ͻ���Դ
                    $('#T_CustomerSource').ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=3&rnd=" + Math.random(), emptyText: '���գ�', initValue: obj.CustomerSource_id });
                    //�ͻ�ְҵ
                    $("#T_industry").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=8&rnd=" + Math.random(), emptyText: '���գ�', initValue: obj.industry_id });
                    //���ݻ���
                    $("#T_fwhx").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=9&rnd=" + Math.random(), emptyText: '���գ�', initValue: obj.Fwhx_id });
                    //΢��״̬
                    $("#T_WXZT_NAME").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=15&rnd=" + Math.random(), emptyText: '���գ�', initValue: obj.WXZT_ID });

                    //װ�޽���
                    $("#T_zxjd").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=11&rnd=" + Math.random(), emptyText: '���գ�', initValue: obj.Zxjd_id });
                    //װ�޷��
                    $("#T_zxfg").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=10&rnd=" + Math.random(), emptyText: '���գ�', initValue: obj.Zxfg_id });


                    //�ͻ�״̬ 
                    $("#T_private").ligerGetComboBoxManager().selectValue(obj.privatecustomer);

                  
                    var gCommunity = $('#T_Community').ligerComboBox({
                        width: 196,
                        initValue: obj.Community_id,
                        url: "../../data/Param_City.ashx?Action=getBuilding&rnd=" + Math.random(),
                        onBeforeOpen: f_selectComm 
                       
                    });
                    //����¥�� С������
                    //$('#T_Community').ligerComboBox({
                    //    width: 196,
                    //    initValue: obj.Community_id,
                    //    url: "../../data/Param_City.ashx?Action=getBuilding&rnd=" + Math.random(),
                    //    onSelected: function (newvalue, newtext) {
                    //       // debugger
                    //        if (!newvalue) {
                    //            newvalue = -1;
                    //            $("#T_address").val("");//T_BNo T_RNo
                    //            $("#h_address").val("");
                    //        } else {
                    //            $.get("../../data/Param_City.ashx?Action=getAddressByID&pid=" + newvalue + "&rnd=" + Math.random(),
                    //               function (data, textStatus) {

                    //                   var address = data;
                    //                   if ($("#T_BNo").val() != "")
                    //                       address = address + $("#T_BNo").val() + '��'

                    //                   if ($("#T_RNo").val() != "")
                    //                       address = address + $("#T_RNo").val() + '��'

                    //                   $("#T_address").val(address);//T_BNo T_RNo
                    //                   $("#h_address").val(data);

                    //                   if ((obj.address != '') && ci > 0) { ci = true; }
                    //                   else
                    //                   {
                    //                       $("#T_address").val(obj.address);//T_BNo T_RNo
                    //                       ci = true;
                    //                   }

                    //               });

                              

                    //        }
                    //    },
                    //    emptyText: '���գ�'
                    //});
                    $("#T_BNo,#T_RNo,#T_DyNo").change(function () {
                        
                        //if ($("#h_address").val() == "") return;
                        var address = $("#h_address").val();
                        if ($("#T_BNo").val() != "")
                            address = address + $("#T_BNo").val() + '��'
                        if ($("#T_DyNo").val() != "")
                            address = address + $("#T_DyNo").val() + '��Ԫ'
                        if ($("#T_RNo").val() != "")
                            address = address + $("#T_RNo").val() + '��'

                        $("#T_address").val(address);//T_BNo T_RNo 
                    });


 
          

                }
            });
        }

        function f_selectComm() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ��¥��С��', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Customer/SelectCommunity.aspx", buttons: [
                    { text: 'ȷ��', onclick: f_selectCommOK },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectCommOK(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('��ѡ��¥��С��!');
                return;
            }
            filltempComm(data.id, data.Name);
            dialog.close();
        }

        function filltempComm(newvalue, text)
        {
            $('#T_Community_val').val(newvalue);
            $("#T_Community").val(text)
            $.get("../../data/Param_City.ashx?Action=getAddressByID&pid=" + newvalue + "&rnd=" + Math.random(),
                                     function (data, textStatus) {

                                         var address = data;
                                         if ($("#T_BNo").val() != "")
                                             address = address + $("#T_BNo").val() + '��'
                                         if ($("#T_DyNo").val() != "")
                                             address = address + $("#T_DyNo").val() + '��Ԫ'
                                         if ($("#T_RNo").val() != "")
                                             address = address + $("#T_RNo").val() + '��'

                                         $("#T_address").val(address);//T_BNo T_RNo
                                         $("#h_address").val(data);

                                         if ((obj.address != '') && ci > 0) { ci = true; }
                                         else
                                         {
                                             $("#T_address").val(obj.address);//T_BNo T_RNo
                                             ci = true;
                                         }

                                     });

        }

        function f_selectContact() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ��Ա��', width: 850, height: 400, url: "hr/Getemp.aspx?isvew=Y", buttons: [
                    { text: 'ȷ��', onclick: f_selectContactOK },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectContact_sg() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ��Ա��', width: 850, height: 400, url: "hr/Getemp.aspx?isvew=Y", buttons: [
                    { text: 'ȷ��', onclick: f_selectContactOK_sg },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectContact_sj() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ��Ա��', width: 850, height: 400, url: "hr/Getemp.aspx?isvew=Y", buttons: [
                    { text: 'ȷ��', onclick: f_selectContactOK_sj },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectContactOK(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('��ѡ��Ա��!');
                return;
            }
            fillemp(data.dname, data.d_id, data.name, data.ID);
            dialog.close();
        }
        function f_selectContactOK_sg(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('��ѡ��Ա��!');
                return;
            }
            fillemp_sg(data.dname, data.d_id, data.name, data.ID);
            dialog.close();
        }
        function f_selectContactOK_sj(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('��ѡ��Ա��!');
                return;
            }
            fillemp_sj(data.dname, data.d_id, data.name, data.ID);
            dialog.close();
        }
        function fillemp(dep, depid, emp, empid) {
            $("#T_employee").val("��" + dep + "��" + emp);
            $("#T_employee1").val(emp);
            $("#T_employee_val").val(empid);
            $("#T_dep").val(dep);
            $("#T_dep_val").val(depid);
        }
        function fillemp_sg(dep, depid, emp, empid) {
            $("#T_employee_sg").val("��" + dep + "��" + emp);
            $("#T_employee1_sg").val(emp);
            $("#T_employee_sg_val").val(empid);
            $("#T_dep_sg").val(dep);
            $("#T_dep_val_sg").val(depid);
        }
        function fillemp_sj(dep, depid, emp, empid) {
            $("#T_employee_sj").val("��" + dep + "��" + emp);
            $("#T_employee1_sj").val(emp);
            $("#T_employee_sj_val").val(empid);
            $("#T_dep_sj").val(dep);
            $("#T_dep_val_sj").val(depid);
        }


        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
        function remote() {
            var url = "../../data/CRM_Customer.ashx?Action=validate&T_cid=" + getparastr("cid") + "&rnd=" + Math.random();
            return url;
        }
        function map() {
            var url = "../../CRM/Customer/map_mark.aspx?type=mark&xy=" + $("#T_xy").val();
            f_openWindow(url, "�ͻ���ͼ��ǡ�" + $("#T_company").val() + "��", 800, 500, savemap, 9003);
        }
        function savemap(item, dialog) {
            var xy = dialog.frame.f_save();
            if (xy) {
              //  $.ligerDialog.success(xy);
                $("#T_xy").val(xy);
                dialog.close();
            }
        }

        function checkVal(id) {
            $.ajax({
                url: "../../data/CRM_Customer.ashx", type: "POST",
                data: { Action: "IsExistaddress", cid: getparastr("cid"), address: document.getElementById(id).value, rnd: Math.random() },
                success: function (responseText) {
                    if (responseText == "false:address") {
                        top.$.ligerDialog.alert(document.getElementById(id).value + '---��ַ�Ѿ����ڣ�');
                    }
                },
                error: function () {

                    // top.$.ligerDialog.error('����ʧ�ܣ�');
                }
            });
        }
        function getVal(id) {
            $.ajax({
                url: "../../data/CRM_Customer.ashx", type: "POST",
                data: { Action: "IsExistphone", cid: getparastr("cid"), tel: document.getElementById(id).value, rnd: Math.random() },
                success: function (responseText) {
                    if (responseText == "false:tel") {
                        top.$.ligerDialog.alert(document.getElementById(id).value+'�����Ѿ����ڣ�');
                        
                        $("#T_company_tel").val("");
                    }
                    },
                    error: function () {
                        
                       // top.$.ligerDialog.error('����ʧ�ܣ�');
                    }
                });
        }
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">
        <input type="hidden" id="h_address" value="" />
        <table style="width: 250px; margin: 5px;" class='bodytable1'>
            <tr>
                <td colspan="4" class="table_title1">�����������ò���</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">�������ƣ�</div>
                </td>
                <td>
                    <div style="width: 140px; float: left">
                        <input type="text" id="T_company" name="T_company" ltype="text" ligerui="{width:136,disabled:true}" />
                    </div>
                </td>
                 <td>
                    <div style="width: 80px; text-align: right; float: right">�����ͺţ�</div>
                </td>
                <td>
                    <div style="width: 140px; float: left">
                        <input type="text" id="Text1" name="T_company" ltype="text" ligerui="{width:136,disabled:true}" />
                    </div>
                </td>
            </tr>
              <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">���Ϲ��</div>
                </td>
                <td>
                    <div style="width: 140px; float: left">
                        <input type="text" id="Text2" name="T_company" ltype="text" ligerui="{width:136,disabled:true}"  />
                    </div>
                </td>
                 <td>
                    <div style="width: 80px; text-align: right; float: right">����Ʒ�ƣ�</div>
                </td>
                <td>
                    <div style="width: 140px; float: left">
                        <input type="text" id="Text3" name="T_company" ltype="text" ligerui="{width:136,disabled:true}"  />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">�����ͺţ�</div>
                </td>
                <td>
                    <input id="T_company_tel" name="T_company_tel" type="text" ltype="text" ligerui="{width:136,disabled:true}" /></td>
            
               <td>
                    <div style="width: 80px; text-align: right; float: right">��λ��</div>
                </td>
                <td>
                    <input id="Text8" name="T_company_tel" type="text" ltype="text" ligerui="{width:136,disabled:true}"" /></td>
            
                <td>
            </tr>  
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">����������</div>
                </td>
                <td>
                    <input id="Text5" name="T_company_tel" type="text" ltype="text" ligerui="{width:136,disabled:true}"" /></td>
            
                <td>
                    <div style="width: 80px; text-align: right; float: right">������������</div>
                </td>
                <td>
                    <input id="Text6"  name="T_company_tel" type="text" ltype="text" ligerui="{width:136,disabled:true} "   /></td>
            </tr>    
             <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">������������</div>
                </td>
                <td>
                    <input id="Text4" name="T_company_tel" type="text" ltype="text" ligerui="{width:136,disabled:true}"" /></td>
            
                <td>
                    <div style="width: 80px; text-align: right; float: right">�������룺</div>
                </td>
                <td>
                    <input id="Text7" value="0" name="T_company_tel" type="text" ltype="text" ligerui="{width:136}" validate="{required:true}"  /></td>
            </tr>     
             <tr>
                <td colspan="4" align="center" style="color:red">
                                   ������������ �� ��������-�������� &nbsp;     &nbsp;     &nbsp;     &nbsp;    ���� </br>
                    ������+�������� �� �ɹ���;+�ڿ�����+������;+���﹤��(���Ƽ���������߼���</td>
            </tr>     
             <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">��ע��</div>
                </td>
                <td colspan="3">
                     <textarea id="T_remarks" name="T_remarks" rows="3" class="l-textarea"  validate="{required:true}" style="width:380px" ></textarea></td>
         
            </tr>   
        </table>


    </form>
</body>
</html>