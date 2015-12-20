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
        $(function () {
            
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();
            if (getparastr("cid") != null) {
                loadForm(getparastr("cid"));
               
            }
            else
            $('#T_company').ligerComboBox({ width: 180, onBeforeOpen: f_selectContact });
          
            
        })
        function f_save() {
            //if ($('#T_employee_sg').val == "" || $('#T_employee_sg').val == null)
            //{
               // alert('操作失败，施工监理不能为空，请先到客户档案中维护！');
            //    return;
            //}
            //if ($(form1).valid()) {
                var sendtxt = "&Action=save&id=" + getparastr("cid");
               // alert($("form :input").fieldSerialize() + sendtxt);
                return $("form :input").fieldSerialize() + sendtxt;
            //}
        }
       
        function loadForm(oaid) {
             $.ajax({
                type: "GET",
                url: "../../data/CRM_CEStage.ashx", /* 注意后面的名字对应CS的方法名称 */
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
                    $("#T_companyid").val(obj.CustomerID);
                    $("#T_company").val(obj.CustomerName);     
                    $("#T_company_tel").val(obj.tel);
                   
                    $("#T_employee").val(obj.ywy);
                    $("#T_employee1").val(obj.ywyid);
                    $("#T_employee_sg").val(obj.sgjl);
                    $("#T_employee1_sg").val(obj.sgjlid);
                    $("#T_employee_sj").val(obj.sjs);
                    $("#T_employee1_sj").val(obj.sjsid);
                    $("#T_SpecialScore").val(obj.SpecialScore);
                    $("#T_StageScore").val(obj.StageScore);
                    $("#T_remarks").val(obj.Remarks);
                    //状态 
                    $("#T_private").ligerGetComboBoxManager().selectValue(obj.Stage_icon);

                     

                }
            });
        }
         
        function f_selectContact() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择客户', width: 850, height: 400,
               
                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/ConsExam/SelectCEStageCustomer.aspx", buttons: [
                    { text: '确定', onclick: f_selectContactOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        
        function f_selectContactOK(item, dialog) {
            //var data = dialog.frame.f_select();
            var fn =  dialog.frame.f_select;           
            var data = fn();
            if (!data) {
                alert('请选择一个有效客户!');
                return;
            }
            fillemp(data.CustomerID, data.tel, data.CustomerName,
                data.sgjl, data.sjs
                , data.ywy, data.sjsid, data.sgjlid, data.ywyid);
            dialog.close();
        }
        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
        function fillemp(id, tel, emp, sgjl, sjs, ywy, sjsid, sgjlid, ywyid) {
            $("#T_companyid").val(id);
            $("#T_company").val(emp);
            $("#T_company_tel").val(tel);
            $("#T_private").val("正在施工");
            $("#T_employee").val(ywy);
            $("#T_employee1").val(ywyid);
            $("#T_employee_sg").val(sgjl);
            $("#T_employee1_sg").val(sgjlid);
            $("#T_employee_sj").val(sjs);
            $("#T_employee_sj1").val(sjsid);
            $("#T_SpecialScore").val("0");
            $("#T_StageScore").val("0");
            $("#T_remarks").val("");
        //    $("#T_employee").val("【" + dep + "】" + emp);
        //    $("#T_employee1").val(emp);
        //    $("#T_employee_val").val(empid);
        //    $("#T_dep").val(dep);
        //    $("#T_dep_val").val(depid);
        }
        
        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
        

    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">
        <input type="hidden" id="h_address" value="" />
        <table style="width: 550px; margin: 5px;" class='bodytable1'>
            <tr>
                <td colspan="4" class="table_title1">基本信息</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">客户姓名：</div>
                </td>
                <td>
                         <input type="text" id="T_company" name="T_company"  ltype="text" ligerui="{width:180}" validate="{required:true}" />
                     <input id="T_companyid" name="T_companyid" type="hidden" />
                   
                  
                    
                </td>
                <td>
                    <div style="width: 80px; text-align: right; float: right">客户电话：</div>
                </td>
                <td>
                    <input id="T_company_tel" name="T_company_tel" type="text" ltype="text" ligerui="{width:180,disabled:true}" validate="{required:false}" /></td>
            </tr>
               
              <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">状态：</div>
                </td>
                <td>
                      <%--<input id="T_private" name="T_private" type="text" validate="{required:true}" style="width: 196px" />--%>
                    <input id="T_private" name="T_private" type="text" ltype="select" 
                        ligerui="{width:180,data:[{id:'正在施工',text:'正在施工'},{id:'施工完成',text:'施工完成'}]}" validate="{required:false}" /></td>
                <td>
                    <div style="width: 80px; text-align: right; float: right">业务员：</div>
                </td>
                <td>
                    <input id="T_employee" name="T_employee" validate="{required:false}"  ltype="text" ligerui="{width:180,disabled:true}"  />
                    <input id="T_employee1" name="T_employee1" type="hidden" />
                   
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">施工监理：</div>
                </td>
                <td>
                    <input id="T_employee_sg" name="T_employee_sg" ltype="text"  ligerui="{width:180,disabled:true}"  validate="{required:true}" />
                    <input id="T_employee1_sg" name="T_employee1_sg" type="hidden" />
                   
                </td>
                <td>
                    <div style="width: 80px; text-align: right; float: right">设计师：</div>
                </td>
                <td>
                    <input id="T_employee_sj" name="T_employee_sj" ltype="text" ligerui="{width:180,disabled:true}"  />
                    <input id="T_employee1_sj" name="T_employee1_sj" type="hidden" />
                 
                </td>
            </tr>
                  <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">附加分值：</div>
                </td>
                <td>
                      <input id="T_SpecialScore" name="T_SpecialScore" type="text"  ltype="text" validate="{required:false}" style="width: 180px" />
                     <td>
                    <div style="width: 80px; text-align: right; float: right">总分数：</div>
                </td>
                <td>
                    <input id="T_StageScore" name="T_StageScore" ltype="text" validate="{required:false}" ligerui="{width:180,disabled:true}"  />
                    
                </td>
            </tr><tr id="tr_contact4">
                <td>
                    <div style="width: 80px; text-align: right; float: right">备注：</div>
                </td>
                <td colspan="3">

                    <input id="T_remarks" name="T_remarks" type="text" ltype="text" ligerui="{width:490}" /></td>
            </tr>
        </table>


    </form>
</body>
</html>
