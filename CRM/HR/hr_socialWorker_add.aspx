<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title></title>
    <link href="../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />

    <script src="../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>

    <script src="../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>

    <script src="../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../lib/jquery.form.js" type="text/javascript"></script>

    <script src="../lib/json2.js" type="text/javascript"></script>
    <script src="../js/calendar.js" type="text/javascript"></script>

    <script src="../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("#T_uid").attr("validate", "{ required: true, username: true, remote: remote, messages: { required: '��������', remote: '�˱���Ѵ���!' } }");
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            //$("#T_Contract_name").focus();
            $("form").ligerForm();

            $("#T_dep").ligerComboBox({
                width: 180,
                selectBoxWidth: 180,
                selectBoxHeight: 180,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    url: '../data/hr_department.ashx?Action=tree&rnd=' + Math.random(),
                    idFieldName: 'id',
                    parentIDFieldName: 'pid',
                    checkbox: false
                }
            })

            $('#T_zhiwu').ligerComboBox({ width: 97, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=17&rnd=" + Math.random() });

            if (getparastr("empid")) {
                loadForm(getparastr("empid"));
            }
            var empid = getparastr("empid") ? getparastr("empid") : 0;

            //$("#maingrid4").ligerGrid({
            //    columns: [
            //            //{ display: '��˾', name: 'name', align: 'left', width: 150 },
            //            { display: '��λ', name: 'post_name', width: 100 },
            //            { display: '����', name: 'depname', width: 100 },
            //            { display: '�ϻ�����', name: 'position_name', width: 100 },
            //            {
            //                display: 'Ĭ��', name: 'default_post', width: 40, render: function (item) {
            //                    var html = "<div style='margin-top:5px;'><input type='checkbox'";
            //                    if (item.default_post == 1) html += "checked='checked' ";
            //                    else html += " /></div>";
            //                    return html;
            //                }
            //            }
            //    ],
            //    selectRowButtonOnly: true,
            //    onAfterShowData: onAfterShowData,
            //    usePager: false,
            //    checkbox: true,
            //    url: "../data/hr_post.ashx?Action=getpostbyempid&empid=" + empid,
            //    width: '446px', height: '95px',
            //    heightDiff: 0
            //})

            $('#T_rqlx').bind('select propertychange', function () { searchCustomer(); });
            $('T_birthday').bind('input propertychange', function () { searchCustomer(); });
            $(".abc").hover(function (e) {
                $(this).ligerTip(
                    {
                        content: $('#birthday').val(),//$(this).text(),
                        width: 200,
                        distanceX: event.clientX - $(this).offset().left - $(this).width() + 15
                    });
            }, function (e) {
                $(this).ligerHideTip(e);
            });

        });

        function searchCustomer() {
            var a; var b = $('#T_birthday').val();

            var kk = $('#T_birthday').val().split("-");//�Զ�����Ϊ�ָ��ַ���
            if ($('#T_rqlx').val() == "����") {
                /**����������תũ������ ����json**/
                var c = calendar.solar2lunar(kk[0], kk[1], kk[2]);
                a = "������" + $('#T_birthday').val() + ";����" + c.lYear + '-' + c.lMonth + '-' + c.lDay;
            } else if ($('#T_rqlx').val() == "����") {
                /**ũ��������ת����������**/

                var c = calendar.lunar2solar(kk[0], kk[1], kk[2]);
                // alert(i);
                a = "������" + c.cYear + '-' + c.cMonth + '-' + c.cDay + ";����" + b;

            }
            $('#birthday').val(a);

        }

        function onAfterShowData() {
            //������ѡ�� �������¼�
            var manager = $("#maingrid4").ligerGetGridManager();
            $("#maingrid4 td.l-grid-row-cell[columnname=default_post] input").change(function () {
                $("#maingrid4 td.l-grid-row-cell[columnname=default_post] input").each(function (i, val) {
                    this.checked = false;
                    $(this).prev(".l-checkbox").removeClass("l-checkbox-checked");
                    manager.updateCelldata(i, 3, 0);
                })
                this.checked = true;
                $(this).prev(".l-checkbox").addClass("l-checkbox-checked");
                manager.updateCelldata($(this).parent().parent().parent().parent().parent().attr("rowid"), 3, 1)
            }).ligerCheckBox();

        }



        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../data/hr_socialWorker.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'form', id: oaid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == null || obj[n] == "null" || obj[n] == undefined)
                            obj[n] = "";
                    }
                    //  alert(obj.professional); //String ���캯��
                    $("#T_uid").val(obj.uid);
                    $("#T_email").val(obj.email);
                    //$("#T_professional").val(obj.professional);
                    $("#T_name").val(obj.name);
                    $("#T_birthday").val(obj.birthday);
                    $("#T_rqlx").val(obj.rqlx);
                    $("#T_idcard").val(obj.idcard);
                    $("#T_tel").val(obj.tel);
                    $("#T_entryDate").val(obj.EntryDate);
                    $("#T_Adress").val(obj.address);
                    $("#T_school").val(obj.schools);
                    $("#T_edu").val(obj.education);

                    $("#T_remarks").val(obj.remarks);

                    $("#T_sex").ligerGetComboBoxManager().selectValue(obj.sex);
                    //$("#T_dep").ligerGetComboBoxManager().selectValue(obj.d_id);
                    //$("#T_Position").ligerGetComboBoxManager().selectValue(obj.zhiwuid);
                    $("#T_status").ligerGetComboBoxManager().selectValue(obj.status);
                    $("#T_zhiwu").ligerGetComboBoxManager().selectValue(obj.zhiwuid);
                    // $("#T_uid").ligerGetTextBoxManager().setDisabled();
                    // $("#T_uid").attr("validate", "{required:true}");
                    $("input[type=radio][value=" + obj.canlogin + "]").attr("checked", 'checked');
                    $("#headurl").val(obj.title);
                    $("#userheadimg").attr("src", "../images/upload/portrait/" + obj.title);
                    searchCustomer();
                }
            });
        }

        function remote() {
            var url = "../data/hr_socialWorker.ashx?Action=Exist&emp_id=" + getparastr("empid") + "&rnd=" + Math.random();
            return url;
        }

        function uploadimg() {
            top.$.ligerDialog.open({
                zindex: 9004,
                width: 800, height: 500,
                title: '�ϴ�ͷ��',
                url: 'hr/headimage.aspx',
                buttons: [
                {
                    text: '����', onclick: function (item, dialog) {
                        saveheadimg(item, dialog);
                    }
                },
                {
                    text: '�ر�', onclick: function (item, dialog) {
                        dialog.close();
                    }
                }
                ],
                isResize: true
            });
        }

        function saveheadimg(item, dialog) {
            var upfile = dialog.frame.f_save();
            //alert(upfile);
            if (upfile) {
                dialog.close();
                top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');

                $.ajax({
                    url: "../data/upload.ashx", type: "POST",
                    data: upfile,
                    success: function (responseText) {
                        $("#headurl").val(responseText);
                        $("#userheadimg").attr("src", "../images/upload/portrait/" + responseText);
                        top.$.ligerDialog.closeWaitting();
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    }
                });
            }
        }

        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                zindex: 9002,
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '����', onclick: function (item, dialog) {
                                f_getpost(item, dialog);
                            }
                        },
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function add() {
            f_openWindow("hr/hr_getpost.aspx", "ѡ���λ", 650, 400);
        }
        function removepost() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.deleteSelectedRow();
        }
        function f_getpost(item, dialog) {
            var rows = null;
            if (!dialog.frame.f_select()) {
                alert('��ѡ���λ!');
                return;
            }
            else {
                rows = dialog.frame.f_select();
                rows.default_post = "0";
                var manager = $("#maingrid4").ligerGetGridManager();
                manager.addRow(rows);
                dialog.close();
                onAfterShowData()
            }
        }
        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=save&id=" + getparastr("empid");
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }
        function f_postnum() {
            return $("#maingrid4 td.l-grid-row-cell[columnname=default_post] input").length;
        }
        function f_postdata() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var data = manager.getCurrentData();
            return JSON.stringify(data);
        }
        function f_checkdefault() {
            var checked = false;
            if ($("#maingrid4 td.l-grid-row-cell[columnname=default_post] input").length > 0) {
                $("#maingrid4 td.l-grid-row-cell[columnname=default_post] input").each(function () {
                    if (this.checked == true) {
                        checked = true;
                        return false;
                    }
                })
            }
            else {
                checked = false;
            }
            return checked;
        }

        function bind() {

            if (getparastr("empid") == undefined || getparastr("empid") == "" || getparastr("empid") == null || getparastr("empid") == "null") {
                alert('�����˺��޷��󶨣����ȱ����ڱ༭״̬��!');
                return;
            }

            if ($("#T_professional").val() == "" || $("#T_uid").val() == "") {
                alert('���ֹ�������Ҫ�󶨵Ŀ�����˺�!');
                return;
            }
            top.$.ligerDialog.confirm("��Ϊһ���ԣ��������������", "ȷ�ϲ�����",
                function (yes) {
                    if (yes == true)
                        $.ajax({
                            url: "../data/SingleSignOn.ashx", type: "POST",
                            data: { Action: "bind", id: getparastr("empid"), uid: $("#T_uid").val(), bindid: $("#T_professional").val(), rnd: Math.random() },
                            success: function (responseText) {
                                //if (responseText == "true") {
                                // fload();
                                alert("�󶨽����" + responseText);
                                //}

                                //else {
                                //    alert('��ʧ�ܣ�' + responseText);
                                //}

                            },
                            error: function () {
                                alert('��ʧ�ܣ�');
                            }
                        });

                });
        }

    </script>

</head>
<body style="margin: 0;overflow:hidden">
    <form id="form1" onsubmit="return false">
        <div>
            <table>
                <tr>
                    <td width="65">
                        <div align="right" style="width: 61px">
                            ��ţ�
                        </div>
                    </td>
                    <td colspan="4">
                        <input type="text" id="T_uid" name="T_uid" ltype="text" ligerui="{width:180}" />
                    </td>
                    <td width="65">
                        <div align="right" style="width: 61px">
                            Email��
                        </div>
                    </td>
                    <td width="172">
                        <input type="text" id="T_email" name="T_email" ltype="text" ligerui="{width:180}" validate="{required:false,email:true}" /></td>
                    <td width="134" rowspan="5">
                        <img id="userheadimg" src="a.gif" onerror="noheadimg()" style="border-radius: 4px; box-shadow: 1px 1px 3px #111; width: 120px; height: 120px; margin-left: 5px; background: #d2d2f2; border: 3px solid #fff; behavior: url(../css/pie.htc);" />

                    </td>
                </tr>
                <tr>
                    <td>
                        <div align="right" style="width: 62px">������</div>
                    </td>
                    <td colspan="4">
                        <input type="text" id="T_name" name="T_name" ltype="text" ligerui="{width:180}" validate="{required:true,minlength:1,maxlength:50,messages:{required:'����������',maxlength:'�����������ô���'}}" />
                    </td>
                    <td>
                        <div align="right" style="width: 62px">���գ�</div>
                    </td>
                    <td>
                        <%--<input type="text" id="T_birthday" name="T_birthday" ltype="date" ligerui="{width:180}" />--%>
                        <div style="width: 120px; float: left"  class='abc'>
                            <input type="text" id="T_birthday" name="T_birthday" ltype="date" ligerui="{width:116}" />
                        <input type="hidden" id="birthday"/>
                        </div>
                        <div style="width: 58px; float: left">
                            <input type="text" id="T_rqlx" name="T_rqlx" style="width: 56px" 
                                ltype="select" ligerui="{width:56,data:[{id:'����',text:'����'},{id:'����',text:'����'}]}"  />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div align="right" style="width: 62px">�Ա�</div>
                    </td>
                    <td width="30">
                        <input type="text" id="T_sex" name="T_sex" style="width: 30px" ltype="select" ligerui="{width:50,data:[{id:'��',text:'��'},{id:'Ů',text:'Ů'}]}" validate="{required:true}" />
                    </td>
                    <td ><div align="right">���ԣ�</div></td>
                    <td colspan="2"><input type="text" id="T_status" name="T_status" style="width: 80px" ltype="select" ligerui="{width:75,data:[{id:'Ա������',text:'Ա������'},{id:'�����Ա',text:'�����Ա'},{id:'������',text:'������'}]}" validate="{required:true}" /></td>
                    <td>
                        <div align="right" style="width: 61px">
                            ���ͣ�
                        </div>
                    </td>              
                    <td>
                            <input id="T_zhiwu" name="T_zhiwu" type="text" style="width: 196px" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div align="right" style="width: 61px">
                            �ֻ���
                        </div>
                    </td>
                    <td colspan="4">
                        <input type="text" id="T_tel" name="T_tel" ltype="text" ligerui="{width:180}" validate="{required:true,cellphone:true,messages:{required:'�������ֻ���'}}" />
                    </td>
                    <td>
                        <div align="right" style="width: 62px">��ʶ���ڣ�</div>
                    </td>
                    <td>
                        <input type="text" id="T_entryDate" name="T_entryDate" ltype="date" ligerui="{width:180}" /></td>
                </tr>
                <tr>
                    <td>
                        <div align="right" style="width: 61px">
                            סַ��
                        </div>
                    </td>
                    <td colspan="6">
                        <input type="text" id="T_Adress" name="T_Adress" ltype="text" ligerui="{width:446}" /></td>
                </tr>
                <tr>
                    <td>
                        <div align="right" style="width: 62px">��ҵԺУ��</div>
                    </td>
                    <td colspan="6">
                        <input type="text" id="T_school" name="T_school" ltype="text" ligerui="{width:446}" />
                        <input type="hidden" id="headurl" name="headurl" /></td>
                    <td>
                        <div style="text-align: center">
                            <input type="button" value="�ϴ�ͷ��" style="width: 80px; height: 22px;" onclick="uploadimg()" />
                        </div>

                    </td>
                </tr>
               
                <tr>
                  <td><div align="right" style="width: 61px"> ����֤�� </div></td>
                  <td colspan="4">  <input type="text" id="T_idcard" name="T_idcard" ltype="text" ligerui="{width:180}" validate="{required:false,IdNumber:true,messages:{required:'����������֤����'}}" /></td>
                  <td><div align="right" style="width: 61px"> ѧ���� </div></td>
                  <td><input type="text" id="T_edu" name="T_edu" ltype="text" ligerui="{width:180}" /></td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                    <td rowspan="2">
                        <div align="right" style="width: 62px">��ע��</div>
                    </td>
                    <td colspan="6" rowspan="2">
                        <textarea cols="100" id="T_remarks" name="T_remarks" rows="3" class="l-textarea" style="width: 442px"></textarea></td>
                    <td><div align="center" style="width: 100%"><span style="width: 100%;color:red">��Ҫ��½ϵͳ</span></div></td>
                </tr>
                <tr>
                  <td><table  align="center">
                    <tr>
                      <td><input type="radio" value="1" name="canlogin"  /></td>
                      <td>�� </td>
                      <td><input type="radio" value="0" name="canlogin" checked="checked" /></td>
                      <td>�� </td>
                    </tr>
                  </table></td>
                </tr>
                 <tr>
                  <td colspan="8">&nbsp;</td>
                </tr>
                 <tr>
                  <td colspan="8"><span style="width: 100%;color:red">˵�����������Ա��¼ϵͳ�����ڡ���Ҫ��¼��ѡ���ǡ���������ǵ�¼�˺ţ���ʼ����123456��</span></td>
                </tr>
                
            </table>
        </div>
    </form>

<%--    <form id="form2">
        <div>
            <table>

                <tr>
                    <td width="62px">&nbsp;</td>
                    <td colspan="5">
                        <div id="maingrid4" style="margin: -1px;"></div>
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>--%>
</body>
</html>