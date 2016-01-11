<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
        <link href="../../CSS/styles.css" rel="stylesheet" />
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />

     
    
    <script src="../../jlui3.2/lib/jquery/jquery-1.9.0.min.js"></script>
    
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
     <script src="../../lib/ligerUI/js/ligerui.all.js"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>

   
      <script src="../../jlui3.2/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
         <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>    
     <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
     <script src="../../jlui3.2/lib/ligerUI/js/ligerui.all.js"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBoxList.js"></script>
   <script src="../../lib/ligerUI/js/plugins/ligerRadioList.js"></script>
   <script src="../../jlib/ligerUI/js/plugins/ligerListBox.js"></script>
     <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>


    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    

     

    <script type="text/javascript">
        var manager, g;
        var pushry = [];
        $(function () {
            
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
           
            $("form").ligerForm();

           

            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            if (getparastr("cid") != null) {
                loadForm(getparastr("cid"));

            }
            
            divchecksgxmInit();
              T_privateInit();
            
            
           
           
        });

        


        function T_privateInit()
        {
   
            var columns = [
                { header: 'ID', name: 'id', width: 10 },
                { header: '名称', name: 'text', width: 100 },
                     {
                         header: '颜色', name: 'jdys', width: 40
                         ,
                         render: function (rowData) {
                             var html = [];
                             html = "<div style='background:#" + rowData + "'> "
                             html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                             html += "</div>"
                             return html;
                         }
                     }
            ];

            $.ajax({
                type: "GET",
                url: "../../data/CE_Para.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'combojd',  rnd: Math.random() }, /* 注意参数的格式和名称 */
                //url: "../../data/SGJD_LIST.ashx?Action=formgrid&cid=" + getparastr("cid") + "&rdm=" + Math.random(),
                
                success: function (result) {
                    var obj = eval(result);
                    $("#T_private").ligerComboBox({
                        width:150,
                        data: obj 
                    });


                },
                error: function (e) {
                    alert("Init2");
                }
            });
            
       
            //$('#T_private').ligerComboBox({
            //    width: 150,
            //   // columns: columns,
            //    //emptyText: '（空）',
            //    url: "../../data/CE_Para.ashx?Action=combojd&rnd=" + Math.random()
            //});
        }

        function divchecksgxmInit()
        {
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
                        //valueFieldCssClass: 'yellow',
                        //css: 'yellow',
                    });
                    $.ajax({
                        type: "GET",
                        url: "../../data/SGJD_LIST.ashx", /* 注意后面的名字对应CS的方法名称 */
                        data: { Action: 'formgrid', cid: getparastr("cid"), rnd: Math.random() }, /* 注意参数的格式和名称 */
                        //url: "../../data/SGJD_LIST.ashx?Action=formgrid&cid=" + getparastr("cid") + "&rdm=" + Math.random(),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            var obj = eval(result);
                            // top.$.ligerDialog.error(obj.A[0].ids);
                            liger.get("divchecksgxm").setValue(obj.A[0].ids);
                            for (var n = 0; n < obj.B.length; n++) {
                                addcss(obj.B[n].id, "#" + obj.B[n].color);
                            }
                            removecheck();

                        },
                        error: function (e) {
                           // alert("Init");
                        }
                    });

                    //全部禁用
                    // $("input:checkbox", this.radioList).attr("disabled", true);

                },

                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    top.$.ligerDialog.error("失败！！！");
                }
            });
        }
       
        function getry() {
            var strry="";
            //$('input:button[name^=divchecksgxm]:checked').each(function () {
            //加條件
            var n = 0;
            $("input:button").each(function () {
                // f_error($(this).attr("value"));
                if (n == 1)
                {
                    strry = strry + $(this).attr("id") + "," + $(this).attr("value") + ';';

                    n = 0;
                }
                else {
                    strry = strry + $(this).attr("id") + "," + $(this).attr("value") + ',';
                    n++;
                }
              });
            return strry;
        }

        function removecheck() {
            $('input:checkbox[name^=divchecksgxm]:checked').each(function () {
                $("input:checkbox", this.radioList).attr("checked", false);
            });
        }
        function addcss(id,color)
        {
            $('input:checkbox[name^=divchecksgxm]:checked').each(function () {
                //加條件
                if (this.value == id)
                    $(this).next("label").css("backgroundColor", color);
            });
        }
        
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
 

        function f_save() {
            
             //f_error(getry()); return;
            if ($("#T_private").val() == "")
            {
                f_error("必须选择一个有效施工进度！");
                return;
            }
           // var manager = $("#divchecksgxm").ligerGetCheckBoxManager();
            var sgxmvalue = liger.get("divchecksgxm").getValue();
            //f_error("必须选择一个有效的施工項目吧！" + sgxmvalue);
            //return;
            if (sgxmvalue == null || sgxmvalue == "")
            {
                f_error("必须选择一个有效的施工項目吧！" + sgxmvalue);
                return;
            }
            //var sgryvalue = liger.get("divsgry").getValue();
            var sgryvalue = getry();
            
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

        //引用
        function RefRow() {
            f_openWindow("system/getemp.aspx?Action=emplist&cid=" + getparastr("cid") + "&issgjd='Y'", "选择人员", 650, 400);

        }
       //新增打开页面
        function addNewRow() {
            f_openWindow("system/getemp.aspx", "选择人员", 650, 400);
            
            
        }
        //获取返回人员
        function f_getry(item, dialog) {
            var rows = null;
            if (!dialog.frame.f_select()) {
                alert('请选择行!');
                return;
            }
            else {
                var rid = "";
                var tt = "<table class='bodytable1' align='left' ><tr>";
                rows = dialog.frame.f_select();
                var br = 0; var flag = true;
                for (var i = 0; i < rows.length; i++) {
                    // alert(pushry.length);
                    if (pushry.length > 0) {
                        for (var p = 0; p < pushry.length; p++) {
                            // f_error(pushry[p]);
                            if (pushry[p] == rows[i].ID)
                                flag=false;
                        }
                    }  
                    //  f_error(rows.length);
                    if (flag) {
                        br++;// rid += rows[i].ID + ",";
                        tt += "<td><div class='divcss5' id='d" + rows[i].ID + "'> " +
                           " <input type='button' class='btn1' id='" + rows[i].ID + "' value='" + rows[i].name + "'>" +
                           " <input type='button' class='btn2' id='" + rows[i].zhiwuid + "-" + rows[i].ID + "' value='" + rows[i].zhiwu + "'>" +
                           "</div></td>";

                        pushry.push(rows[i].ID);
                        if (br == 5) {
                            tt += " </tr><tr>";
                            br = 0;
                        }
                        if (i == rows.length - 1) {
                            if (br < 5)
                                for (var c = br + 1; c <= 5; c++) {
                                    tt += "<td> </td>"
                                    if (c == 5)
                                        tt += " </tr>"
                                }
                        }
                        //alert(rows[i].ID);
                        // manager.addRow(rows[i]);
                    }
                }
                tt += "</tr></table>"
                var btn = $(tt);
                $("#divsgry").append(btn);
                for (var i = 0; i < rows.length; i++) {
                    addBtnEvent(rows[i].zhiwuid + "-" + rows[i].ID);
                    addBtnEventry(rows[i].ID);
                }
                dialog.close();
            }
             
        }
        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                zindex: 9002,
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '提交', onclick: function (item, dialog) {
                                f_getry(item, dialog);
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

        var activeDialogs = null;
        function f_openWindow_post(url, title, width, height) {
            var dialogOptions = {
                zindex: 9002,
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '提交', onclick: function (item, dialog) {
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
            activeDialogs = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        var chickid;
        function addBtnEvent(id) {
            $("#" + id).bind("click", function () {
                //  alert(id);
                chickid = id;
                f_openWindow_post("hr/hr_position.aspx?IsGet=Y", "选择职务", 650, 400);
            });
        }
        function addBtnEventry(id) {
            $("#" + id).bind("click", function () {
                $.ligerDialog.confirm("是否确定删除", "是否确定删除，操作不可逆！", function (ok) {
                    $.ligerDialog.closeWaitting();
                    if (ok) {
                        $("#d" + id).remove();
                        for (var p = 0; p < pushry.length; p++)
                        {
                           // alert(id); alert(pushry[p]);
                            if (pushry[p] == id)
                                pushry.splice(0, p+1);;
                        }
                       
                        //pushry.pop(id);
                    }
                    else { return;}
                });
              
            });
        }

        function f_getpost(item, dialog) {
            var rows = null;
            if (!dialog.frame.f_select()) {
                alert('请选择岗位!');
                return;
            }
            else {
                rows = dialog.frame.f_select();
                //rows.default_post = "0";
                 
                //alert(rows.position_name);
                $("#" + chickid).attr('value', rows.position_name);
                chickid = null;
                dialog.close();
                //onAfterShowData()
            }
        }

        
    </script>
    <style type="text/css">
        .checkboxlist label 
{ 
margin-right: 20px; 
} 
    </style>
    <style type="text/css">
        　.divcss5{ border-style:solid; border-width:1px; border-color:#003399}
  .btn1 {
    font-size: 9pt;
    color: #003399;
    border: 1px #003399 solid;
    color: #006699;
    border-bottom: #93bee2 1px solid;
    border-left: #93bee2 1px solid;
    border-right: #93bee2 1px solid;
    border-top: #93bee2 1px solid;
     background-color: #e8f4ff;
    font-style: normal;
    margin-left: 10px;
    height: 22px;
} 
  .btn2 {
    font-size: 9pt;
    color: #000000;
    border: 1px #FFEFDB  solid;
    color: #000000;
    border-bottom: #93bee2 1px solid;
    border-left: #93bee2 1px solid;
    border-right: #93bee2 1px solid;
    border-top: #93bee2 1px solid;
     background-color: #009900;
    font-style: normal;
    margin-left: 10px;
    height: 22px;
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
                     <input type='text' id='T_private' name='T_private' />
                          


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
                <td colspan="2" class="table_title1">施工人员</td>
                <td   class="table_title1">
                    <a class="l-button" style="width:80px;" onclick="addNewRow()">添加人員</a>
                  </td>
                <td   class="table_title1">
                      <a class="l-button" style="width:80px;" onclick="RefRow()">引用最新一次人员</a>
                </td>
            </tr>
            <tr>

                <td colspan="4">
                    <div id="divsgry" style="margin: -1px;height:100px;   overflow:auto; " ></div>
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
