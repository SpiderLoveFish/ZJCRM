<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
     <script src="../../jlui3.2/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
   <script src="../../jlui3.2/lib/ligerUI/js/ligerui.all.js"></script>
   <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerComboBox.js"></script>
   <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerCheckBoxList.js"></script>
   <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerRadioList.js"></script>
   <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerListBox.js"></script>
 
    <script src="../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
     
     <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>

    
    
    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>

    <script type="text/javascript">

        $(function () {

            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
            $("form").ligerForm();

            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            //var dataGrid = [
            //     { id: 1, name: '李三', sex: '男' }, 
            //      { id: 2, name: '李四', sex: '女' },
            //            { id: 3, name: '赵武', sex: '女' },
            //     { id: 4, name: '陈留', sex: '女' },
            //            { id: 5, name: '陈留2', sex: '女' },
            //     { id: 7, name: '陈留3', sex: '女' },
            //     { id: 1, name: '李三', sex: '男' },
            //      { id: 2, name: '李四', sex: '女' },
            //            { id: 3, name: '赵武', sex: '女' },
            //     { id: 4, name: '陈留', sex: '女' },
            //            { id: 5, name: '陈留2', sex: '女' },
            //     { id: 7, name: '陈留3', sex: '女' },
            //             { id: 6, name: '陈留4', sex: '女' }
            //];

            $.ajax({
                type: 'post',
                url: "../../data/XM_LIST.ashx?Action=formgrid&rdm=" + Math.random(),
                success: function (result) {
                    var datar = eval(result);
                    $("#divchecksgxm").ligerCheckBoxList({
                        rowSize: 11,
                        data: datar,
                        valueField: 'XMID',                      
                        textField: 'XMMC',

                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    top.$.ligerDialog.error("失败！！！");
                }
            });
            //$("#divchecksgxm").bind("click", function () {
            //    $("[name = chkItem]:checkbox").attr("checked", true);
            //});
            $("[name = chkItem]:checkbox").attr("checked", true);
            $("#divchecksgxm>:checkbox").attr("checked", true)
           // $("tbody> :checkbox").attr("checked", true);
            
           
        });


        function f_setbtn()
        {

            //var manager = $("#divchecksgxm").ligerGetGridManager();
            //manager.gridloading.hide();
            ////var note = treemanager.getSelected();
            ////if (!note) return;

            ////获取权限
            //var roleid = getparastr("Role_id");
            //var savetext = "{role_id:'" + roleid + "',";
            //savetext += "app:'" + 1 + "'}";

            //$.ajax({
            //    type: 'post',
            //    url: "../data/Sys_role.ashx?Action=getauth&postdata=" + savetext + '&rdm=' + Math.random(),
            //    success: function (data) {
            //        //alert(data);   
            //        var arrstr = new Array();
            //        var arrmenu = new Array();
            //        var arrbtn = new Array();
            //        arrstr = data.split("|");

            //        arrmenu = arrstr[0].split(",");
            //        for (var i = 0; i < arrmenu.length; i++) {
            //            if (arrmenu[i].length > 0) {
            //                manager.setCheck(arrmenu[i].replace("m", ""));
            //            }
            //        }

            //        if (arrstr[1])
            //            arrbtn = arrstr[1].split(",");
            //        for (var j = 0; j < arrbtn.length; j++) {
            //            if (arrbtn[j].length > 0) {
            //                $("#" + arrbtn[j]).attr("checked", true);
            //            }
            //        }
            //    },
            //    error: function (XMLHttpRequest, textStatus, errorThrown) {
            //        //f_error("角色还未授权！");
            //    }
            //});
        }

        //function f_save() {
        //    var notes = treemanager.getSelected();
        //    if (notes != null && notes != undefined) {
        //        var app = notes.data.id;

        //        var manager = $("#maingrid4").ligerGetGridManager();
        //        var rows = manager.getCheckedRows();
        //        var menu = "";
        //        $(rows).each(function () {
        //            menu += "m" + this.Menu_id + ",";
        //        });

        //        var btn = "";
        //        $("input[type='checkbox']").each(function (i) {
        //            if ($(this).attr("checked")) {
        //                btn += $(this).attr("id") + ",";
        //            }
        //        })


        //        var roleid = getparastr("Role_id");
        //        var savetext = "{role_id:'" + roleid + "',";
        //        savetext += "app:'a" + app + ",',";
        //        savetext += "menu:'" + menu + "',";
        //        savetext += "btn:'" + btn + "'}";

        //        //alert(savetext);

        //        f_saving();
        //        $.ajax({
        //            type: 'post',
        //            url: "../data/Sys_role.ashx?Action=saveauth&postdata=" + savetext + '&rdm=' + Math.random(),
        //            success: function (data) {
        //                //alert(data);
        //                setTimeout(function () {
        //                    f_success();
        //                }, 10);

        //            },
        //            error: function (XMLHttpRequest, textStatus, errorThrown) {
        //                f_error("授权失败！");
        //            }
        //        });
        //    }
        //    else {
        //        f_error("请选择模块！");
        //    }

        //}
        //function EditMenu() {
        //    $(":checkbox").attr("checked", true);
        //}
        //function DeleteMenu() {
        //    $(":checkbox").attr("checked", false);
        //    $("#_38").attr("checked", true);
        //}
        //function gridreload(Appid) {
        //    var manager = $("#maingrid4").ligerGetGridManager();
        //    manager.showData({ Rows: [], Total: 0 });
        //    //alert('onSelect:' + note.data.id);
        //    var url = "../data/Sys_Menu_data.aspx?action=treegrid&appid=" + Appid;
        //    manager.GetDataByURL(url);
        //};

        function f_onCheckRow(checked, data) {
            var returntxt = data.Sysroler;
            var arrstr = new Array();
            var arrstr1 = new Array();
            var arrid = new Array();
            var arrname = new Array();
            arrstr = returntxt.split(",");

            if (checked) {
                for (var j = 0; j < arrstr.length; j++) {
                    arrstr1 = arrstr[j].split("|");
                    arrid = arrstr1[0];
                    $("#b" + arrid).attr("checked", true);
                }
                //parent
                var manager = $("#divchecksgxm").ligerGetGridManager();
                if (manager.isLeaf(data)) {
                    var row = manager.getParent(data);
                    if(row) manager.setCheck(row.Menu_id);
                }
                else
                {
                    var rows = data.children;
                    if (!rows) return;
                    $(rows).each(function (i,item) {
                        manager.setCheck(rows[i].Menu_id);
                        var returntxt = item.Sysroler;
                        var arrstr = new Array();
                        var arrstr1 = new Array();
                        var arrid = new Array();
                        var arrname = new Array();
                        arrstr = returntxt.split(",");


                        for (var j = 0; j < arrstr.length; j++) {
                            arrstr1 = arrstr[j].split("|");
                            arrid = arrstr1[0];
                            if (checked) {
                                $("#b" + arrid).attr("checked", true);
                            }
                            else {
                                $("#b" + arrid).attr("checked", false);
                            }
                        }
                    })
                }
            }
            else {
                for (var j = 0; j < arrstr.length; j++) {
                    arrstr1 = arrstr[j].split("|");
                    arrid = arrstr1[0];
                    $("#b" + arrid).attr("checked", false);
                }
                //children
                var manager = $("#divchecksgxm").ligerGetGridManager();
                if (!manager.isLeaf(data)) {
                    var rows = data.children;
                    $(rows).each(function (i) {
                        manager.setUnCheck(rows[i].Menu_id);
                    })
                }
            }


        }
        function f_onCheckAllRow(checked, grid) {
            var manager = $("#divchecksgxm").ligerGetGridManager();
            var rows = manager.getAllRows();
            if (rows.length > 0) {
                $(rows).each(function (i, item) {
                    //alert(i+";"+item.Sysroler)
                    var returntxt = item.Sysroler;
                    var arrstr = new Array();
                    var arrstr1 = new Array();
                    var arrid = new Array();
                    var arrname = new Array();
                    arrstr = returntxt.split(",");


                    for (var j = 0; j < arrstr.length; j++) {
                        arrstr1 = arrstr[j].split("|");
                        arrid = arrstr1[0];
                        if (checked) {
                            $("#b" + arrid).attr("checked", true);
                        }
                        else {
                            $("#b" + arrid).attr("checked", false);
                        }
                    }

                })
            }
        }
        //function f_success() {
        //    setTimeout(function () {
        //        $.ligerDialog.confirm("是否继续编辑", "保存成功", function (ok) {
        //            $.ligerDialog.closeWaitting();
        //            if (!ok) {
        //                parent.$.ligerDialog.close();
        //            }
        //        });
        //    }, 200);
        //}
        //function f_error(message) {
        //    $(document).ready(function () {
        //        $.ligerDialog.error(message);
        //    });
        //}
        //function f_saving() {
        //    $.ligerDialog.waitting("正在保存中...");
        //}

    </script>

</head>
<body style="padding: 0px; overflow: hidden;">
      <div id="div1" style="margin: -1px;"></div>
    <form id="form1" onsubmit="return false">

        <table align="left" border="0" cellpadding="3" cellspacing="1" class='bodytable1'>

            <tr>
                <td colspan="4" class="table_title1">基础参数</td>
            </tr>
            <tr>
                <td>
                    <div align="left" style="width: 60px">客户编号：</div>
                </td>
                <td>
                    <input type="text" id="T_khbh" name="T_khbh" validate="{required:true}" ltype='text' ligerui="{width:180,disabled:true}" /></td>

                <td>
                    <div align="left" style="width: 90px">客户名称：</div>
                </td>
                <td>
                    <input type='text' id="T_khmc" name="T_khmc" ltype='text' ligerui="{width:140,disabled:true}" /></td>
            </tr>
            <tr>
                <td>
                    <div align="left" style="width: 60px">客户小区：</div>
                </td>
                <td>
                    <input type="text" id="T_khxq" name="T_khxq" validate="{required:true}" ltype='text' ligerui="{width:180,disabled:true}" /></td>

                <td>
                    <div align="left" style="width: 90px">客户楼号：</div>
                </td>
                <td>
                    <input type='text' id="T_khlh" name="T_khlh" ltype='text' ligerui="{width:140,disabled:true}" /></td>
            </tr>
            <tr>
                <td>
                    <div align="left" style="width: 60px">业主姓名：</div>
                </td>
                <td>
                    <input type="text" id="T_yzxm" name="T_yzxm" validate="{required:true}" ltype='text' ligerui="{width:180,disabled:true}" /></td>

                <td>
                    <div align="left" style="width: 90px">联系电话：</div>
                </td>
                <td>
                    <input type='text' id="T_tel" name="T_tel" ltype='text' ligerui="{width:140,disabled:true}" /></td>
            </tr>
            <tr>
                <td>
                    <div align="left" style="width: 60px">施工项目：</div>
                </td>
                <td>
                    <div align="left" style="width: 160px">请在下列需要的项目前打勾</div>
                </td>
                <td>
                    <div align="left" style="width: 90px">施工进度：</div>
                </td>
                <td>
                    <input id="T_private" name="T_private" type="text" ltype="select"
                        ligerui="{width:180,data:[{id:'还未处理',text:'还未处理'},
                {id:'无需施工',text:'无需施工'},
                {id:'急需安排',text:'急需安排'},
                {id:'正在进行',text:'正在进行'},
                {id:'施工完成',text:'施工完成'}]}"
                        validate="{required:false}" /></td>
            </tr>
            <tr>
                <td>
                    <div align="left" style="width: 60px">说明：</div>
                </td>
                <td colspan="3">
                    <input type="text" id="T_Remark" name="T_Remark" validate="{required:true}" ltype='text' ligerui="{width:637}" /></td>

            </tr>
            <tr>
                <td colspan="4" class="table_title1">施工项目</td>
            </tr>
            <tr>

                <td colspan="4">
                    <div id="divchecksgxm" style="margin: -1px; height:160px;  overflow:auto; "></div>
                    
                </td>
            </tr>
            <tr>
                <td colspan="3" class="table_title1">施工人员</td>
                <td class="table_title1">选择</td>
            </tr>
            <tr>

                <td colspan="4">
                    <div id="divsgry" style="margin: -1px;"></div>
                </td>
            </tr>
            <%--<tr>
                <td colspan="4">
                    <textarea id="editor" style="width: 637px;"></textarea>
                </td>
            </tr>--%>
        </table>
    </form>
</body>
</html>
