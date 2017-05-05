<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
      <link href="../../CSS/input.css" rel="stylesheet" />
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
        var jpname = "";
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
          var  gcomb = $('#T_company').ligerComboBox({ width: 245, onBeforeOpen: f_selectContact });
            //$("#T_Contract_name").focus();
            $("form").ligerForm();
            
            if (getparastr("style") == "JPGJ")//金牌管理
            {
                loadFormJP(getparastr("id"));
            }
            else {
                loadForm(getparastr("id"));
            }
            $("#T_name").val(decodeURI(getparastr("name")));
            $("#T_sms").val(decodeURI(getparastr("name")));
            
            $("#T_p1,#T_p2,#T_p3,#T_p4,#T_p5,#T_p6").change(function () {

                replace();

            });

        });

        function replace()
        {
            var smsname = "";
            if (getparastr("style") == "JPGJ")//金牌管理
                smsname = jpname;
            else
                smsname = decodeURI(getparastr("name"));
            if ($("#T_p1").val() != "")
                smsname = smsname.replace("@p1", $("#T_p1").val());
            if ($("#T_p2").val() != "")
                smsname = smsname.replace("@p2", $("#T_p2").val());
            if ($("#T_p3").val() != "")
                smsname = smsname.replace("@p3", $("#T_p3").val());
            if ($("#T_p4").val() != "")
                smsname = smsname.replace("@p4", $("#T_p4").val());
            if ($("#T_p5").val() != "")
                smsname = smsname.replace("@p5", $("#T_p5").val());
            if ($("#T_p6").val() != "")
                smsname = smsname.replace("@p6", $("#T_p6").val());
            $("#T_sms").val(smsname);
        }

        function f_selectContact() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择客户', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Budge/SelectBudgeCustomer.aspx", buttons: [
                    { text: '确定', onclick: f_selectContactOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectContactOK(item, dialog) {
            //var data = dialog.frame.f_select();
            var fn = dialog.frame.f_select;
            var data = fn();
            if (!data) {
                alert('请选择一个有效客户!');
                return;
            }
            $('#T_company').val("【" + data.CustomerName + "】" + data.address);
            $('#T_tel').val(data.tel)
           
            dialog.close();
        }
        function f_selectContactCancel(item, dialog) {
            dialog.close();
         
        }

        function loadFormJP(oaid) {//金牌
            $.ajax({
                type: "GET",
                url: "../../data/smsmodel.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'formJP', id: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {

                    }
                    //alert(obj.modelname); //String 构造函数
                   
                    $("#l1").html(obj.para1);
                    $("#l2").html(obj.para2);
                    $("#l3").html(obj.para3);
                    $("#l4").html(obj.para4);
                    $("#l5").html(obj.para5);
                    $("#l6").html(obj.para6);
                    $("#T_name").val(obj.modelname  );
                    $("#T_sms").val(obj.modelname);
                    jpname = obj.modelname;

                    $.ajax({
                        type: "GET",
                        url: "../../data/smsmodel.ashx", /* 注意后面的名字对应CS的方法名称 */
                        data: { Action: 'formXM_LIST_CONFIG', id: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            var obj = eval(result);
                            for (var n in obj) {

                            }
                            //$("#l1").html(obj.p1);
                            //$("#l2").html(obj.p2);
                            //$("#l3").html(obj.p3);
                            //$("#l4").html(obj.p4);
                            //$("#l5").html(obj.p5);
                            //$("#l6").html(obj.p6);
                            var from = obj.p1.split(";")[0] + ',' + obj.p2.split(";")[0] + ',' + obj.p3.split(";")[0] + ','
                            + obj.p4.split(";")[0] + ',' + obj.p5.split(";")[0] + ',' + obj.p6.split(";")[0];
                             //alert(from)
                            ///

                            $.ajax({
                                type: "GET",
                                url: "../../data/smsmodel.ashx", /* 注意后面的名字对应CS的方法名称 */
                                data: { Action: 'formCRM_CE_CONFIG', from: from, from: from, rnd: Math.random() }, /* 注意参数的格式和名称 */
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (result) {
                                    var obj = eval( result );
                                    // alert(JSON.stringify(obj));
                                    var strfrom = ""; 
                                    for (var n in obj.Rows) {
                                        // alert(obj.Rows[n].C_Value);
                                        if (obj.Rows[n].C_Value == '')
                                            strfrom = strfrom +  "'',";
                                        else 
                                        strfrom= strfrom + obj.Rows[n].C_Value + "," ;
                                    }
                                    
                                      // alert(strfrom);
                                    ///
                                    $.ajax({
                                        type: "GET",
                                        url: "../../data/smsmodel.ashx", /* 注意后面的名字对应CS的方法名称 */
                                        data: { Action: 'formmx', cid: getparastr("cid"), from: strfrom.toString(), rnd: Math.random() }, /* 注意参数的格式和名称 */
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (result) {
                                            var obj = eval(result);
                                            //alert(JSON.stringify(obj));
                                            var p = 1;
                                            for (var n in obj) {
                                                //alert(obj[n])
                                                if(p==1)
                                                    $("#T_p1").val(obj[n]);
                                                if (p == 2)
                                                    $("#T_p2").val(obj[n]);
                                                if (p == 3)
                                                    $("#T_p3").val(obj[n]);
                                                if (p == 4)
                                                    $("#T_p4").val(obj[n]);
                                                if (p == 5)
                                                    $("#T_p5").val(obj[n]);
                                                if (p == 6)
                                                    $("#T_p6").val(obj[n]);
                                                p++;
                                                
                                            }
                                            replace();
                                           
                                        }
                                    });


                                }
                            });
                            ///

                        }
                             
                    });

                    ///



                    ///
                }
            });
        }

        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/smsmodel.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', id: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {

                    }
                    //alert(obj.constructor); //String 构造函数
                   
                    $("#l1").html(obj.para1);
                    $("#l2").html(obj.para2);
                    $("#l3").html(obj.para3);
                    $("#l4").html(obj.para4);
                    $("#l5").html(obj.para5);
                    $("#l6").html(obj.para6);
                   



                }
            });
        }


        function f_save() {
            var tel = $("#T_tel").val();
            if (!(/^1[34578]\d{9}$/.test(tel))) {
                alert("手机号码有误，请重填");
                return;
            }
             
            var paras =  {'name':'山山ERP','fwnr': $('#T_sms').val() };
            $.ajax({
                url: "../../data/crm_customer.ashx", type: "POST",
                data: { Action: "Send_aliyunSendSMS", tel: $('#T_tel').val(), type: 4, para: JSON.stringify(paras), rnd: Math.random() },
                success: function (responseText) {
                    if (responseText == "true") {
                       alert('发送成功！！');

                    }
                    else if (responseText == "false") {
                        alert('发送失败！！');
                    }

                },
                error: function () {
                    alert('发送失败！！');
                }
            });
        }
 
    </script>
 <script type="text/javascript">
     function copyUrl2() {
         var Url2 = document.getElementById("T_sms");
         Url2.select(); // 选择对象
         document.execCommand("Copy"); // 执行浏览器复制命令
         alert("已复制好，可贴粘。");
     }
 </script>
</head>
<body style="padding: 0px">
    <form id="form1" onsubmit="return false">
        <table border="0" cellpadding="3" cellspacing="1" style="background: #fff; width: 99%;">
            <tr>
                <td colspan="6" class="table_title1">模板信息</td>
            </tr>
            <tr>
                <td height="33" style="width: 60px">

                    <div align="right" style="width: 60px">模板内容：</div>
                </td>
                <td height="33" colspan="5" style="width: 60px">
                  
                  <textarea  id="T_name" name="T_name" cols="50" rows="5" class="l-textarea" style="width:520px" disabled="true" readonly> </textarea>                </td>
            </tr>
             <tr>
                <td colspan="6" class="table_title1">录入参数</td>
            </tr>
            <tr>
                <td height="25">

                    <div align="right" style="width: 60px">@P1：</div>
                </td>
                <td height="25"><input type="text" id="T_p1" name="T_p1" ltype="text" ligerui="{width:100}"   /></td>
                <td height="25"><div align="right" style="width: 60px">@P2：</div></td>
                <td height="25"><input type="text" id="T_p2" name="T_p2" ltype="text" ligerui="{width:100}"    /></td>
             
                <td><div align="right" style="width: 60px">@P3：</div></td>
                <td height="25"><input type="text" id="T_p3" name="T_p3" ltype="text" ligerui="{width:100}"    /></td>
            </tr>
               <tr>
                <td height="25"><div align="right" style="width: 60px">@P4：</div></td>
                <td height="25"><input type="text" id="T_p4" name="T_p4" ltype="text" ligerui="{width:100}"    /></td>
                <td height="25"><div align="right" style="width: 60px">@P5：</div></td>
                <td height="25"><input type="text" id="T_p5" name="T_p5" ltype="text" ligerui="{width:100}"   /></td>
             
                <td height="25"><div align="right" style="width: 60px">@P6：</div></td>
                <td height="25"><input type="text" id="T_p6" name="T_p6" ltype="text" ligerui="{width:100}"    /></td>
            </tr>
               <tr>
                 <td height="25"><div align="right" style="width: 60px">说明 ：</div></td>
                 <td height="25" colspan="5">@P1 ：<strong style="color:red"><label id="l1"></label></strong>，@P2 ：<strong style="color:red"><label id="l2"></label></strong>，@P3 ：<strong style="color:red"><label id="l3"></label></strong>，@P4 ：<strong style="color:red"><label id="l4"></label></strong>，@P5 ：<strong style="color:red"><label id="l5"></label></strong>，@P6 ：<strong style="color:red"><label id="l6"></label></strong></td>
               </tr>
           <tr>
                <td colspan="6" class="table_title1">生成服内容</td>
            </tr>
             
         <td height="33">

                    <div align="right" style="width: 60px">生成内容：</div></br>
              <input type="button" onClick="copyUrl2()" value="点击复制" />
                </td>
         <td height="33" colspan="5">
           <textarea id="T_sms" name="T_sms" cols="50" rows="5" class="l-textarea" style="width:520px"> </textarea>         </td>
            </tr>
            <tr>
                <td height="33">

                    <div align="right" style="width: 60px">手机号码：</div>
                </td>
                <td height="33"><input type="text" id="T_tel" name="T_tel" ltype="text" ligerui="{width:120}"  /></td>
                <td height="33"><div style="width: 70px; text-align: right; float: right">客户信息：</div></td>
                <td height="33" colspan="3"><input type="text" id="T_company" name="T_company"    />
                <input id="T_companyid" name="T_companyid" type="hidden" /></td>
            </tr>
            <tr>
                <td colspan="6" ><strong style="color:red">如需发送短信，可以直接录入手机号码或选择客户带出手机号码后，点击下方发送短信。</strong></td>
        </table>
    </form>
</body>
</html>
