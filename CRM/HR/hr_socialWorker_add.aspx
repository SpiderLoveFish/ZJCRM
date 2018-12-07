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
            $("#T_uid").attr("validate", "{ required: true, username: true, remote: remote, messages: { required: '请输入编号', remote: '此编号已存在!' } }");
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

            $('#T_zhiwu').ligerComboBox({ width: 180, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=17&rnd=" + Math.random() });
            $('#T_zt').ligerComboBox({ width: 180, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=25&rnd=" + Math.random() });
            $('#T_xj').ligerComboBox({ width: 180, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=26&rnd=" + Math.random() });

            $('#T_sfzldj').ligerComboBox({ width: 180, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=32&rnd=" + Math.random() });
            $('#T_sfxydj').ligerComboBox({ width: 180, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=34&rnd=" + Math.random() });
            $('#T_sffwdj').ligerComboBox({ width: 180, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=35&rnd=" + Math.random() });
            $('#T_sfjgdj').ligerComboBox({ width: 180, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=33&rnd=" + Math.random() });


            if (getparastr("empid")) {
                loadForm(getparastr("empid"));
            }  
                $('#T_employee_sg').ligerComboBox({ width: 180, onBeforeOpen: f_selectContact_sg });

           
          
                 var empid = getparastr("empid") ? getparastr("empid") : 0;

            //$("#maingrid4").ligerGrid({
            //    columns: [
            //            //{ display: '公司', name: 'name', align: 'left', width: 150 },
            //            { display: '岗位', name: 'post_name', width: 100 },
            //            { display: '分组', name: 'depname', width: 100 },
            //            { display: '合伙类型', name: 'position_name', width: 100 },
            //            {
            //                display: '默认', name: 'default_post', width: 40, render: function (item) {
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

            var kk = $('#T_birthday').val().split("-");//以逗号作为分隔字符串
            if ($('#T_rqlx').val() == "阳历") {
                /**公历年月日转农历数据 返回json**/
                var c = calendar.solar2lunar(kk[0], kk[1], kk[2]);
                a = "阳历：" + $('#T_birthday').val() + ";阴历" + c.lYear + '-' + c.lMonth + '-' + c.lDay;
            } else if ($('#T_rqlx').val() == "阴历") {
                /**农历年月日转公历年月日**/

                var c = calendar.lunar2solar(kk[0], kk[1], kk[2]);
                // alert(i);
                a = "阳历：" + c.cYear + '-' + c.cMonth + '-' + c.cDay + ";阴历" + b;

            }
            $('#birthday').val(a);

        }

        function onAfterShowData() {
            //遍历复选框 并加上事件
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
                url: "../data/hr_socialWorker.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', id: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == null || obj[n] == "null" || obj[n] == undefined)
                            obj[n] = "";
                    }
                   //  alert(JSON.stringify(obj)); //String 构造函数
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
                    $("#T_edu").val(obj.education);
                    $("#T_remarks").val(obj.remarks);
                    $("#T_zt").val(obj.zt);
                    $("#T_xj").val(obj.xj);

                    $("#T_sfzldj").val(obj.zldj);
                    $("#T_sffwdj").val(obj.fwdj);
                    $("#T_sfjgdj").val(obj.jgdj);
                    $("#T_sfxydj").val(obj.xydj);
                   
                    $("#T_sex").ligerGetComboBoxManager().selectValue(obj.sex);
                    $("#T_private").ligerGetComboBoxManager().selectValue(obj.private_per);
                    //bq = obj.Emp_sg;
                    if (obj.Emp_sg != '' && obj.Emp_sg != null && obj.Emp_sg != 'null') {
                        var str = obj.Emp_sg.split(";");
                        for (var i = 1; i < str.length; i++) {
                            var strtext = str[i].split(",");
                            if (strtext[0] == "") break;
                            else
                                fillemp_sg("", "", strtext[1], strtext[0]);
                            //onSelect(strtext[0], strtext[1])
                        }
                    }
                   
                    
                    //$("#T_dep").ligerGetComboBoxManager().selectValue(obj.d_id);
                    //$("#T_Position").ligerGetComboBoxManager().selectValue(obj.zhiwuid);
                    $("#T_status").ligerGetComboBoxManager().selectValue(obj.status);
                    $("#T_zhiwu").ligerGetComboBoxManager().selectValue(obj.zhiwuid);
                    // $("#T_uid").ligerGetTextBoxManager().setDisabled();
                    // $("#T_uid").attr("validate", "{required:true}");
                    $("input[type=radio][value=" + obj.canlogin + "]").attr("checked", 'checked');
                    $("input[type=radio][value=" + obj.jbx + "]").attr("checked", 'checked');
                    $("#headurl").val(obj.title);
                    $("#userheadimg").attr("src", "../images/upload/portrait/" + obj.title);
                    searchCustomer();
                }
            });
        }
        function f_selectContact_sg() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择员工', width: 600, height: 400, url: "hr/Getemp.aspx?isvew=Y", buttons: [
                    { text: '确定', onclick: f_selectContactOK_sg },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
        var bq = "";
        function fillemp_sg(dep, depid, emp, empid) {
            $("#T_employee_sg").val( emp);
            $("#T_employee1_sg").val(emp);
            $("#T_employee_sg_val").val(empid);
            if (bq.indexOf(empid) > 0)
                return false;
            bq += ";" + empid + "," + emp;
            $("#bqspan").append(" <input type='button' class='btn1' id='a" + empid + "' value='" + emp + "'>");
            addBtnEventry(empid, emp);
          
        }
        function addBtnEventry(id, text) {
            $("#a" + id).bind("click", function () {
                $.ligerDialog.confirm("是否确定删除", "是否确定删除，操作不可逆！", function (ok) {
                    $.ligerDialog.closeWaitting();
                    if (ok) {
                        $("#a" + id).remove();

                        bq = bq.replace(";" + id + "," + text, "");//取消

                    }
                    else { return; }
                });

            });
        }
        function f_selectContactOK_sg(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('请选择员工!');
                return;
            }
            fillemp_sg(data.dname, data.d_id, data.name, data.ID);
            dialog.close();
        }
        function remote() {
            var url = "../data/hr_socialWorker.ashx?Action=Exist&emp_id=" + getparastr("empid") + "&rnd=" + Math.random();
            return url;
        }

        function uploadimg() {
            top.$.ligerDialog.open({
                zindex: 9004,
                width: 800, height: 500,
                title: '上传头像',
                url: 'hr/headimage.aspx',
                buttons: [
                {
                    text: '保存', onclick: function (item, dialog) {
                        saveheadimg(item, dialog);
                    }
                },
                {
                    text: '关闭', onclick: function (item, dialog) {
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
                top.$.ligerDialog.waitting('数据保存中,请稍候...');

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
                        top.$.ligerDialog.error('操作失败！');
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
                            text: '保存', onclick: function (item, dialog) {
                                f_getpost(item, dialog);
                            }
                        },
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function add() {
            f_openWindow("hr/hr_getpost.aspx", "选择岗位", 650, 400);
        }
        function removepost() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.deleteSelectedRow();
        }
        function f_getpost(item, dialog) {
            var rows = null;
            if (!dialog.frame.f_select()) {
                alert('请选择岗位!');
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
                var sendtxt = "&Action=save&id=" + getparastr("empid")+"&bq="+bq;
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
                alert('新增账号无法绑定，请先保存在编辑状态绑定!');
                return;
            }

            if ($("#T_professional").val() == "" || $("#T_uid").val() == "") {
                alert('请手工填入需要绑定的酷家乐账号!');
                return;
            }
            top.$.ligerDialog.confirm("绑定为一次性，请谨慎操作！！", "确认操作？",
                function (yes) {
                    if (yes == true)
                        $.ajax({
                            url: "../data/SingleSignOn.ashx", type: "POST",
                            data: { Action: "bind", id: getparastr("empid"), uid: $("#T_uid").val(), bindid: $("#T_professional").val(), rnd: Math.random() },
                            success: function (responseText) {
                                //if (responseText == "true") {
                                // fload();
                                alert("绑定结果：" + responseText);
                                //}

                                //else {
                                //    alert('绑定失败！' + responseText);
                                //}

                            },
                            error: function () {
                                alert('绑定失败！');
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
                            编号：
                        </div>
                    </td>
                    <td colspan="4">
                        <input type="text" id="T_uid" name="T_uid" ltype="text" ligerui="{width:180}" />
                    </td>
                    <td width="65">
                        <div align="right" style="width: 61px">
                            Email：
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
                        <div align="right" style="width: 62px">姓名：</div>
                    </td>
                    <td colspan="4">
                        <input type="text" id="T_name" name="T_name" ltype="text" ligerui="{width:180}" validate="{required:true,minlength:1,maxlength:50,messages:{required:'请输入姓名',maxlength:'你的名字有这么长嘛？'}}" />
                    </td>
                    <td>
                        <div align="right" style="width: 62px">生日：</div>
                    </td>
                    <td>
                        <%--<input type="text" id="T_birthday" name="T_birthday" ltype="date" ligerui="{width:180}" />--%>
                        <div style="width: 120px; float: left"  class='abc'>
                            <input type="text" id="T_birthday" name="T_birthday" ltype="date" ligerui="{width:116}" />
                        <input type="hidden" id="birthday"/>
                        </div>
                        <div style="width: 58px; float: left">
                            <input type="text" id="T_rqlx" name="T_rqlx" style="width: 56px" 
                                ltype="select" ligerui="{width:56,data:[{id:'阳历',text:'阳历'},{id:'阴历',text:'阴历'}]}"  />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div align="right" style="width: 62px">性别：</div>
                    </td>
                    <td width="30">
                        <input type="text" id="T_sex" name="T_sex" style="width: 30px" ltype="select" ligerui="{width:50,data:[{id:'男',text:'男'},{id:'女',text:'女'}]}" validate="{required:true}" />
                    </td>
                    <td ><div align="right">属性：</div></td>
                    <td colspan="2"><input type="text" id="T_status" name="T_status" style="width: 80px" ltype="select" ligerui="{width:75,data:[{id:'工人师傅',text:'工人师傅'},{id:'员工家人',text:'员工家人'},{id:'社会人员',text:'社会人员'},{id:'黑名单',text:'黑名单'}]}" validate="{required:true}" /></td>
                    <td>
                        <div align="right" style="width: 61px">
                            类型：
                        </div>
                    </td>              
                    <td>
                            <input id="T_zhiwu" name="T_zhiwu" type="text" style="width: 196px" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div align="right" style="width: 61px">
                            手机：
                        </div>
                    </td>
                    <td colspan="4">
                        <input type="text" id="T_tel" name="T_tel" ltype="text" ligerui="{width:180}" validate="{required:true,cellphone:true,messages:{required:'请输入手机号'}}" />
                    </td>
                    <td>
                        <div align="right" style="width: 62px">相识日期：</div>
                    </td>
                    <td>
                        <input type="text" id="T_entryDate" name="T_entryDate" ltype="date" ligerui="{width:180}" /></td>
                </tr>
                <tr>
                    <td>
                        <div align="right" style="width: 61px">
                            住址：
                        </div>
                    </td>
                    <td colspan="6">
                        <input type="text" id="T_Adress" name="T_Adress" ltype="text" ligerui="{width:446}" /></td>
                </tr>
                <tr>
                    <td>
                        <div align="right" style="width: 62px">毕业院校：</div>
                    </td>
                    <td colspan="6">
                        <input type="text" id="T_school" name="T_school" ltype="text" ligerui="{width:446}" />
                        <input type="hidden" id="headurl" name="headurl" /></td>
                    <td>
                        <div style="text-align: center">
                            <input type="button" value="上传头像" style="width: 80px; height: 22px;" onclick="uploadimg()" />
                        </div>

                    </td>
                </tr>
               
                <tr>
                  <td><div align="right" style="width: 61px"> 身份证： </div></td>
                  <td colspan="4">  <input type="text" id="T_idcard" name="T_idcard" ltype="text" ligerui="{width:180}" validate="{required:false,IdNumber:true,messages:{required:'请输入身份证号码'}}" /></td>
                  <td><div align="right" style="width: 61px"> 学历： </div></td>
                  <td><input type="text" id="T_edu" name="T_edu" ltype="text" ligerui="{width:180}" /></td>
                  <td>&nbsp;</td>
                </tr>
                
                 <tr>
              <td>
                        <div align="right" style="width: 61px">
                            星级：
                        </div>
                    </td>              
                    <td  colspan="4">
                   <input id="T_xj" name="T_xj" type="text" style="width: 180px" />
                    </td>
                  
                    <td >
                        <div align="right" style="width: 61px">
                            状态：
                        </div>
                    </td>              
                    <td  colspan="4">
                            <input id="T_zt" name="T_zt" type="text" style="width: 180px" />
                    </td>
                </tr>
                  
                 <tr>
              <td>
                        <div align="right" style="width: 61px">
                            师傅质量等级：
                        </div>
                    </td>              
                    <td  colspan="4">
                   <input id="T_sfzldj" name="T_sfzldj" type="text" style="width: 180px" />
                    </td>
                  
                    <td >
                        <div align="right" style="width: 61px">
                            师傅价格等级：
                        </div>
                    </td>              
                    <td  colspan="4">
                            <input id="T_sfjgdj" name="T_sfjgdj" type="text" style="width: 180px" />
                    </td>
                </tr>
                  
                 <tr>
              <td>
                        <div align="right" style="width: 61px">
                            师傅信誉等级：
                        </div>
                    </td>              
                    <td  colspan="4">
                   <input id="T_sfxydj" name="T_sfxydj" type="text" style="width: 180px" />
                    </td>
                  
                    <td >
                        <div align="right" style="width: 61px">
                            师傅服务等级：
                        </div>
                    </td>              
                    <td  colspan="4">
                            <input id="T_sffwdj" name="T_sffwdj" type="text" style="width: 180px" />
                    </td>
                </tr>

                 <tr>
                    <td>
                        <div align="right" style="width: 61px">
                            交保险：
                        </div>
                    </td>
                    <td colspan="6">
                        <table>
                            <tr>
                                <td>
                                    <input type="radio" value="1" name="jbx"  /></td>
                                <td>交社保 </td>
                                <td>
                                    <input type="radio" value="2" name="jbx" /></td>
                                <td>交意外保险 </td>
                                <td>
                                    <input type="radio" value="3" name="jbx"  /></td>
                                <td>交社保&意外保险 </td>
                                <td>
                                    <input type="radio" value="0" name="jbx" checked="checked" /></td>
                                <td>不交 </td>

                            </tr>
                        </table>
                    </td>
                   
                  
                </tr>
                 <tr>
                <td>
                    <div align="right" style="width: 61px">共享性质：</div>
                </td>
                <td  colspan="4">
                    <input id="T_private" name="T_private" type="text" ltype="select" ligerui="{width:180,data:[{id:'私有',text:'私有'},{id:'共有',text:'共有'}]}" validate="{required:true}" /></td>
                <td>
                    <%--<div align="right" style="width: 61px">归属人：</>--%>
                </td>
                <td  colspan="4">
                  <%--  <input id="T_employee_sg" name="T_employee_sg" type="text" validate="{required:true}" style="width: 180px" />
                    <input id="T_employee1_sg" name="T_employee1_sg" type="hidden" />
                  --%>
                </td>
            </tr>
                <tr>
                    <td>
                    <div align="right" style="width: 61px">归属人：</div>
                </td>
            <td  colspan="3">
                    <input id="T_employee_sg" name="T_employee_sg" type="text" validate="{required:true}" style="width: 90px" />
                    <input id="T_employee1_sg" name="T_employee1_sg" type="hidden" />
                  
                </td>
                    <td  colspan="6">
                         <div id="bqspan" style="margin: -1px;  overflow:auto; " ></div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="2">
                        <div align="right" style="width: 62px">备注：</div>
                    </td>
                    <td colspan="6" rowspan="2">
                        <textarea cols="100" id="T_remarks" name="T_remarks" rows="3" class="l-textarea" style="width: 442px"></textarea></td>
                    <td><div align="center" style="width: 100%"><span style="width: 100%;color:red">需要登陆系统</span></div></td>
                </tr>
                <tr>
                  <td><table  align="center">
                    <tr>
                      <td><input type="radio" value="1" name="canlogin"  /></td>
                      <td>是 </td>
                      <td><input type="radio" value="0" name="canlogin" checked="checked" /></td>
                      <td>否 </td>
                    </tr>
                  </table></td>
                </tr>
                 <tr>
                  <td colspan="8">&nbsp;</td>
                </tr>
                 <tr>
                  <td colspan="8"><span style="width: 100%;color:red">说明：如需此人员登录系统，请在“需要登录”选“是”。编号则是登录账号，初始密码123456。</span></td>
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
