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
            $("#T_uid").attr("validate", "{ required: true, username: true, remote: remote, messages: { required: '请输入账号名', remote: '此账户存在!' } }");
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            //$("#T_Contract_name").focus();
            $("form").ligerForm();

            //$("#T_dep").ligerComboBox({
            //    width: 180,
            //    selectBoxWidth: 180,
            //    selectBoxHeight: 180,
            //    valueField: 'id',
            //    textField: 'text',
            //    treeLeafOnly: false,
            //    tree: {
            //        url: '../data/hr_department.ashx?Action=tree&rnd=' + Math.random(),
            //        idFieldName: 'id',
            //        parentIDFieldName: 'pid',
            //        checkbox: false
            //    }
            //})
           
            $('#T_accountType').ligerComboBox({ width: 182, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=21&rnd=" + Math.random() });
         
            if (getparastr("accountID")) {
                loadForm(getparastr("accountID"));
            }
            var accountID = getparastr("accountID") ? getparastr("accountID") : 0;

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
                url: "../data/hr_employee_accounts.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', accountId: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == null || obj[n] == "null" || obj[n] == undefined)
                            obj[n] = "";
                    }

                    $("#T_accountType").val(obj.accountType);
                    $("#T_account").val(obj.account);
                    $("#T_pwd").val(obj.pwd);
                    $("#T_bz").val(obj.bz);
                }
            });
        }

        function remote() {
            var url = "../data/hr_employee_accounts.ashx?Action=Exist&emp_id=" + getparastr("accountID") + "&rnd=" + Math.random();
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
        function f_save(employeeID) {
            if ($(form1).valid()) {
                var sendtxt = "&Action=save&id=" + getparastr("accountID") + "&employeeID=" + employeeID;
                //alert($("form :input").fieldSerialize() + sendtxt);
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }
        //function f_postnum() {
        //    return $("#maingrid4 td.l-grid-row-cell[columnname=default_post] input").length;
        //}
        function f_postdata() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var data = manager.getCurrentData();
            return JSON.stringify(data);
        }
        function f_checkdefault() {
            //var checked = false;
            //if ($("#maingrid4 td.l-grid-row-cell[columnname=default_post] input").length > 0) {
            //    $("#maingrid4 td.l-grid-row-cell[columnname=default_post] input").each(function () {
            //        if (this.checked == true) {
            //            checked = true;
            //            return false;
            //        }
            //    })
            //}
            //else {
            //    checked = false;
            //}
            //return checked;

            return true;
        }              

    </script>

</head>
<body style="margin: 0;overflow:hidden">
    <form id="form1" onsubmit="return false">
        <div>
            <table>
                <tr>
                    <td width="62px">
                        <div align="right" style="width: 61px">
                            账号类型：
                        </div>
                    </td>
                    <td colspan="3">
                        <input type="text" id="T_accountType" name="T_accountType" ltype="text" ligerui="{width:182}" validate="{required:true}" />
                    </td>                    
                </tr>
                <tr>
                    <td width="62px">
                        <div align="right" style="width: 61px">
                            账号：
                        </div>
                    </td>
                    <td width="182px">
                        <input type="text" id="T_account" name="T_account" ltype="text" ligerui="{width:180}" validate="{required:true}" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div align="right" style="width: 62px">密码：</div>
                    </td>
                    <td colspan="3">
                        <input type="text" id="T_pwd" name="T_pwd" ltype="text" ligerui="{width:180}" validate="{required:true}" />
                    </td>                  
                </tr>
                <tr>
                    <td>
                        <div align="right" style="width: 62px">备注：</div>
                    </td>
                    <td>
                        <div style="width: 182px; float: left"  class='abc'>
                            <input type="text" id="T_bz" name="T_bz" ltype="text" ligerui="{width:180}" validate="{required:true}" />
                        </div>
                    </td>
                </tr>
                <%--<tr>
                    <td>
                        <div align="right" style="width: 62px">员工ID：</div>
                    </td>
                    <td width="50px">
                        <input type="text" id="T_employeeID" name="T_employeeID" style="width: 50px" ltype="text"  validate="{required:true}" />
                    </td>
                </tr>--%>                             
            </table>
        </div>
    </form>

    <form id="form2">
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
    </form>
</body>
</html>
