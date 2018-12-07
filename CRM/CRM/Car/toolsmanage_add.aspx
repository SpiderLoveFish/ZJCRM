<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>

    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>

    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>

    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        //图标
        var jiconlist, winicons, currentComboBox;
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            //$("#T_Contract_name").focus();
            $("form").ligerForm();
           
         
            $('#T_borrowers').ligerComboBox({ width: 180, onBeforeOpen: f_selectContact });
           
            if (getparastr("cid") == null || getparastr("cid") == "null" ||getparastr("cid")=="")
            {
                
            } else
                loadForm(getparastr("cid"));

            $("#maingrid4").ligerGrid({
                columns: [
                    //{ display: 'ID', name: 'RoleID', type: 'int', width: 50 },
                    { display: '序号', width: 50, render: function (item, i) { return i + 1; } },
                    { display: '产品编号', name: 'productid', width: 100 },
                    { display: '产品', name: 'product_name', width: 100 },
                    { display: '型号', name: 'ProModel', width: 80 },
                    { display: '规格', name: 'specifications', width: 80 },
                    { display: '品牌', name: 'Brand', width: 80 },
                    { display: '数量', name: 'productnumber', width: 60 },
                    { display: '备注', name: 'remarks', width: 50 }
                ],
                title: '借用产品',
                usePager: false,
                url: "../../data/toolsmanage.ashx?Action=gridmx&toolsid=" + getparastr("toolsid"), 
                selectRowButtonOnly: true,
                onAfterShowData: onAfterShowData,
                usePager: false,
                checkbox: false, 
                width: '446px', height: '95px',
                heightDiff: 0
            })

           
        });

        function f_selectContact() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择员工', width: 850, height: 400, url: "hr/Getemp.aspx?isvew=Y", buttons: [
                    { text: '确定', onclick: f_selectContactOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectContactOK(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('请选择员工!');
                return;
            }
             
            fillemp(data.ID,data.name);
            dialog.close();
        }
        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
        function fillemp(id, emp) {
            $("#T_borrowersid").val(id);   
            $("#T_borrowers").val(emp);   
         
        }

        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=save&id=" + getparastr("cid");
                return $("form :input").fieldSerialize() + sendtxt;
            }         
        }
        function removepost() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.deleteSelectedRow();
        }

        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/toolsmanage.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', id: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {

                    }
                   // alert(JSON.stringify(obj))
                    fillemp(obj.borrowersid, obj.borrowers);
               
                    // alert(obj.BP_Name); //String 构造函数
                    $("#T_begintime").val(formatTimebytype(obj.begintime,'yyyy-MM-dd')); 
                    $("#T_endtime").val(formatTimebytype(obj.endtime, 'yyyy-MM-dd') ); 
                    //$("#T_MOTgapYear").val(obj.MOTgapYear);
                    $("#T_tools").val(obj.toolsid);
                    $("#T_remarks").val(obj.remarks);
                }
            });
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
            f_openWindow("CRM/car/SelectProduct.aspx", "选择产品", 650, 400);
        }
        function f_getpost(item, dialog) {
            var rows = null;
            if (!dialog.frame.f_select()) {
                alert('请选择产品!');
                return;
            }
            else {
                rows = dialog.frame.f_select(); 
               // rows = rows.replace("product_id", "productid").replace("product_name", "productname");    
                var manager = $("#maingrid4").ligerGetGridManager();
                manager.addRow(rows);
                dialog.close();
                onAfterShowData()
            }
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
        function f_postnum() {
            return $("#maingrid4 td.l-grid-row-cell[columnname=default_post] input").length;
        }
        function f_postdata() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var data = manager.getCurrentData();
            //alert(JSON.stringify(data));
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
    </script>
    <style type="text/css">
        .iconlist {
            width: 360px;
            padding: 3px;
        }

            .iconlist li {
                border: 1px solid #FFFFFF;
                float: left;
                display: block;
                padding: 2px;
                cursor: pointer;
            }

                .iconlist li.over {
                    border: 1px solid #516B9F;
                }

                .iconlist li img {
                    height: 16px;
                    height: 16px;
                }
    </style>

</head>
<body style="padding: 0px">
    <form id="form1" onsubmit="return false">
        <table border="0" cellpadding="3" cellspacing="1" style="background: #fff; width: 440px;">

            <tr>
                 <td height="23" style="width: 85px" colspan="2">

                    <div align="left" style="width: 62px">借用日期：</div>
                </td>
                <td height="23">

                       <input type="text" id="T_begintime" name="T_begintime" ltype="date" ligerui="{width:125}" />
                       
                    </td>
                <td height="23" style="width: 85px" colspan="2">

                    <div align="left" style="width: 62px">返回日期：</div>
                </td>
                <td height="23">

                       <input type="text" id="T_endtime" name="T_endtime" ltype="date" ligerui="{width:125}" />
                       
                    </td>

            </tr>
                
             <tr>
                <td height="23" style="width: 85px" colspan="2">

                    <div align="left" style="width: 62px">借用人：</div>
                </td>
                <td height="23">

                    <input type="text" id="T_borrowers" name="T_borrowers"    />
                    <input type="hidden" id="T_borrowersid" name="T_borrowersid" />
                     <input type="hidden" id="T_tools" name="T_tools" />
                </td>
                  
                    <td height="23" style="width: 85px" colspan="2">

                    <div align="left" style="width: 62px">备注：</div>
                </td>
                <td height="23">

                    <input type="text" id="T_remarks" name="T_remarks" ltype="text" ligerui="{width:180}" validate="{required:true}" />

                </td>
            </tr>
            <tr>
                     <td colspan="3">
                        <input id="Button1" type="button" value="新增" style="height: 21px" onclick="add()" />
                        <input id="Button2" type="button" value="删除" style="height: 21px" onclick="removepost()" /></td>
                   
            </tr>
        </table>
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
