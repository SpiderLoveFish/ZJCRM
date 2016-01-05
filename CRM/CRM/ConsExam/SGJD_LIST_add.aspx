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
            $('#T_private').ligerComboBox({
                width: 150,
                url: "../../data/CE_Para.ashx?Action=combojd&rnd=" + Math.random(),
               // url: "../../data/Crm_CEDetail.ashx?Action=combo&sid=" + 1+ "&pid=" + 3 + "&rnd=" + Math.random(),
                    
                emptyText: '（空）'
            });
            $("form").ligerForm();
           
            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            if (getparastr("cid") != null) {
                loadForm(getparastr("cid"));

            }
             
           
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
                        //css:"background-color:yellow",
                    });
                    $.ajax({
                        type: 'post',
                        url: "../../data/SGJD_LIST.ashx?Action=formgrid&rdm=" + Math.random(),
                        success: function (result) {
                            //var datar = eval(result);
                           // top.$.ligerDialog.error(datar);
                            liger.get("divchecksgxm").setValue(result);
                           // liger.get("divchecksgxm").css("background-color", "yellow");
                        }
                    });
                 
                },

                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    top.$.ligerDialog.error("失败！！！");
                }
            });
           
            $("#divsgry").ligerCheckBoxList({
                rowSize: 11,
                data: null,
                valueField: 'ID',
                textField: 'name',

            });
         
           // $("tbody> :checkbox").attr("checked", true);
            var label;
            $("#divchecksgxm input:checkbox:checked").each(function () {
                label += $(this).next().html();
            });
             
        });
        
        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/CRM_Customer.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', cid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(obj.constructor); //String 构造函数
                    $("#T_khbh").val(obj.id);
                    $("#T_khmc").val(obj.Customer);
                    $("#T_tel").val(obj.tel);

                    $("#T_khxq").val(obj.Community);
                    $("#T_khlh").val(obj.BNo + '栋' + obj.RNo + '室');
                    $("#T_yzxm").val(obj.Customer);
                   


                }
            });
        }

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

        function f_save() {
            
           // var manager = $("#divchecksgxm").ligerGetCheckBoxManager();
            var sgxmvalue = liger.get("divchecksgxm").getValue();
            var sgryvalue = liger.get("divsgry").getValue();
            if ($(form1).valid()) {
                var sendtxt = "&Action=save&id=" + getparastr("cid")  
                    + "&sgxm=" + sgxmvalue
                + "&sgry=" + sgryvalue
                ;
                return $("form :input").fieldSerialize() + sendtxt;
            }

            return;
                 
          
        

        }
       
        
  
        function f_error(message) {
            $(document).ready(function () {
                $.ligerDialog.error(message);
            });
        }
        function f_saving() {
            $.ligerDialog.waitting("正在保存中...");
        }

    </script>
    <style type="text/css">
        .checkboxlist label 
{ 
margin-right: 20px; 
} 
    </style>
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
                      <input type="text" id="T_private" name="T_private" validate="{required:true}" ltype='text' ligerui="{width:150}" /></td>
                     <input type="hidden" id="T_pid" name="T_pid" />
                 <%--   <input id="T_private" name="T_private" type="text" ltype="select"
                        ligerui="{width:180,data:[{id:'还未处理',text:'还未处理'},
                {id:'无需施工',text:'无需施工'},
                {id:'急需安排',text:'急需安排'},
                {id:'正在进行',text:'正在进行'},
                {id:'施工完成',text:'施工完成'}]}"
                        validate="{required:false}" />--%>

                </td>
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
