<%@ Page Language="C#" AutoEventWireup="true"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head  >
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />    
    <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />

   
      <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>    
    
    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>

    <script type="text/javascript">
        var ck;
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
            Years(); month();
            //$("#T_Contract_name").focus();
            $("form").ligerForm();

           // ck = $('#ck').ligerCheckBox();
          //  $("#ck").ligerCheckBox();
            $("#ck").click(function () {
                ckchange();
            });
            function ckchange()
            {
               
                    $("#T_dj").attr("disabled", $("#ck").attr("checked")) 
                    $("#T_gs").attr("disabled", $("#ck").attr("checked")) 
                    if ($("#ck").attr("checked") == false) {
                        top.$.ligerDialog.warning('如果取消明细，将清空单据明细内容，确定吗？', function (type)
                        {
                            if (type == "yes")
                            { $("#addmx").hide(); }
                            else {
                                $("#ck").checked = true;
                                $("#ck").attr("checked", true);
                            }
                             
                        });
                        
                           
                        
                    }
                    else {
                        $("#addmx").show();
                    }
               // alert($("#ck").attr("checked"))
            }
            $('#T_company').ligerComboBox({ width: 450, onBeforeOpen: f_selectContact });

            if (getparastr("fid")) {
                loadForm(getparastr("fid"));
            }
            else {
                $("#T_fylx").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=30&rnd=" + Math.random(), emptyText: '（空）' });
                $('#T_invoice_type').ligerComboBox({ width: 182,  url: "../../data/Param_SysParam.ashx?Action=combo&parentid=5&rnd=" + Math.random() });
            }
            $('#T_rperson').ligerComboBox({ width: 450, onBeforeOpen: f_selectContact_gr });

        });
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
            fillemp(data.CustomerID, data.CustomerName, data.address,data.tel);

            dialog.close();
        }
      
        function fillemp(id, CustomerName, address,tel) {
            $("#T_companyid").val(id);
            $("#T_company").val(CustomerName + "【" + address + "】"+tel);




        }
        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=save&fid=" + getparastr("fid") + "&IsStatus=0";
               // alert($("form :input").fieldSerialize() + sendtxt);
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }
        function f_save_tj() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=save&fid=" + getparastr("fid") + "&IsStatus=1";
               
                 return $("form :input").fieldSerialize() + sendtxt;
            }
        }
        function f_save_sh() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=savestatus&fid=" + getparastr("fid") + "&IsStatus=Y";
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }
        function f_save_th() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=savestatus&fid=" + getparastr("fid") + "&IsStatus=0";
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }

        Date.prototype.Format = function (fmt) { //author: meizz 
            var o = {
                "M+": this.getMonth() + 1, //月份 
                "d+": this.getDate(), //日 
                "h+": this.getHours(), //小时 
                "m+": this.getMinutes(), //分 
                "s+": this.getSeconds(), //秒 
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
                "S": this.getMilliseconds() //毫秒 
            };
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        }
        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/Financial_Labour_Cost.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', fid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {

                    }
                    // alert(JSON.stringify(obj)); //String 构造函数
                    var str = obj.DeleteTime;
                    var d = eval('new ' + str.substr(1, str.length - 2)); //new Date()
                    var t = d.format("yyyy-MM-dd")
                    $("#T_fylx").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=30&rnd=" + Math.random(), emptyText: '（空）', initValue: obj.F_StyleID });
                    $("#T_je").val(obj.Amount);
                    $("#T_dj").val(obj.ManDayPrice);
                    $("#T_gs").val(obj.ManHour);
                    $("#T_tzje").val(obj.AdjustAmount);
                    $("#T_sj").val(t);
                    $("#T_zje").val(obj.TotalAmount);
                    $("#T_remarks").val(obj.Remarks);
                    $("#T_rperson").val(obj.worker);
                    //alert(obj.CustomerID)
                    $("#T_company").val(obj.Customer);
                    $("#T_companyid").val(obj.CustomerID);
                    $('#T_invoice_type').ligerComboBox({ width: 182, initValue: obj.Pay_type_id, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=5&rnd=" + Math.random() });
                   // alert(obj.IsHaveDetail);
                    if (obj.IsHaveDetail==1)
                    {
                      //  alert(obj.IsHaveDetail)
                        $("#ck").checked = true;
                        $("#ck").attr("checked", true);
                        $("#addmx").show();
                    }
                    else
                        {
                             $("#ck").checked =  false;
                            $("#addmx").hide();
                    }
                    $("#T_dj").attr("disabled", $("#ck").attr("checked"))
                    $("#T_gs").attr("disabled", $("#ck").attr("checked"))
                       
                }
               
            });
        }
        ///选中工人
        function f_selectContact_gr() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择工人', width: 850, height: 400, url: "hr/Getemp_SocialWorker.aspx?isvew=Y", buttons: [
                    { text: '确定', onclick: f_selectContactOK_gr },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectContactOK_gr(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('请选择工人!');
                return;
            }
            fillemp_gr(data.zhiwu, data.tel, data.name, data.ID);
            dialog.close();
        }
        function fillemp_gr(zhiwu, tel, emp, empid) {
            $("#T_rperson").val(emp + "-" + zhiwu + "-" + tel );
            
        }
        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
        function computer()
        {
           
            var je = Number($("#T_gs").val()) * Number( $("#T_dj").val());
            var zje = je+ Number($("#T_tzje").val())
            $("#T_je").val(je);
            $("#T_zje").val(zje);
        }

        function Years()
        {
            var data = [];//创建年度数组
            
            var thisYear = new Date().getUTCFullYear();//今年
            var startYear = thisYear-10;//起始年份
            var endYear = thisYear + 1;//结束年份
            //数组添加值（2012-2016）//根据情况自己修改
            for (startYear; startYear<= endYear ; startYear++) 
                data.push({"id": startYear,"text": startYear });
 //           var dataGrid = [
 //               2                 { id: 1, name: '李三', sex: '男' },
 //               3                 { id: 2, name: '李四', sex: '女' },
 //               4                 { id: 3, name: '赵武', sex: '女' },
 //               5                 { id: 4, name: '陈留', sex: '女' }
 //6                 ];
 //           7             $("#txtGrid").ligerComboBox({
 //               8                 data: dataGrid,
 //               9                 textField: 'name',

            $("#T_year").ligerComboBox({
                width:96,
                data: data,
                initValue: thisYear 
            });
        }
        function month() {
            var data1 = [];//创建月份数组
            var startMonth = 1;//起始月份
            var thisMonth = new Date().getUTCMonth() + 1;//本月
            //数组添加值（1-12月）为固定值
            for (startMonth; startMonth < 13; startMonth++) {
                data1.push({ "id": startMonth, "text": startMonth });
            }
            $("#T_month").ligerComboBox({
                width:  96,
                data: data1,
                initValue: thisMonth
            });
        }

        function btnadd()
        {
            //var manager = $("#maingrid4").ligerGetGridManager();
            //var row = manager.getSelectedRow();
           // alert(getparastr("fid"));
            if (getparastr("fid") == null || getparastr("fid") == "" || getparastr("fid")=='null') {
                alert("编辑明细，必须先保存主表，再进行编辑！");
          } else {
                f_openWindow('CRM/finance/Financial_Labour_Cost_add_add.aspx?fid=' + getparastr("fid"), "修改人工费用明细", 890, 600);

            }
        }
        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: '保存', onclick: function (item, dialog) {
                            f_save_mx(item, dialog);
                        }
                    },
                    {
                        text: '关闭', onclick: function (item, dialog) {
                            dialog.close();
                        }
                    }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        var activeDialog = null;
        function f_openWindow_view(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: '关闭', onclick: function (item, dialog) {
                            dialog.close();
                        }
                    }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        function f_save_mx(item, dialog) {
            var issave = dialog.frame.f_save();
            var fid = dialog.frame.f_getfid();
           
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/Financial_Labour_Cost.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        loadForm(fid);
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('操作失败！');
                    }
                });

            }
        }
    
    </script>
</head>
<body style="margin:5px 5px 5px 5px">
    <form id="form1" onsubmit="return false">
    <div>
        <table  align="left" border="0"   cellspacing="1" 
            style="background: #fff; width:320px;">
            
            <tr height="40px">
                <td  width="65px"  ><div align="left" style="width: 61px">
                    客户：</div></td>
                 <td colspan="3" >
                    <div style="float:left; height: 20px;">
                        <input  type="text" id="T_company" name="T_company"  ligerui="{width:400,disabled:true}" validate="{required:true}" />
                    </div>    
                      <input id="T_companyid" name="T_companyid" type="hidden" />
                    
                </td>
            </tr>
            <tr height="40px">
                <td  >
                
                    <div align="left" style="width: 62px">工人：</div></td>
                <td colspan="3" >
                    <div style="float:left; height: 20px;">
                        <input  id="T_rperson" name="T_rperson"     ligerui="{width:220}" validate="{required:true}" />
                    </div>
                </td>
            </tr>
            <tr height="30px">
                <td  width="80px"  >费用项目：</td>
                <td   >
                        <input type="text" id="T_fylx" name="T_fylx" /></td>
           
         
                <td  >
                
                    <div align="left" style="width: 62px">时间：</div></td>
                <td  >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_sj" name="T_sj"        ltype="date"   ligerui="{width:180}" validate="{required:true}"/>
                    </div>
                </td>
                
            </tr>
            <tr>
                <td>
                    <div align="left" style="width: 62px">按明细：</div></td>
                <td  colspan="2">
                  <input type="checkbox" name="ck" id="ck"   /> 
                      
                </td>
                <td> <input type="button" id="addmx" value="添加明细"  style="display:none"  onclick="btnadd()"></input></td>
            </tr>
             <tr height="30px">
                <td  >
                
                    <div align="left" style="width: 62px">单价：</div></td>
                <td  >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_dj" name="T_dj"   onchange="computer()" onfocus="computer()"     ltype="text"   ligerui="{width:180}" validate="{required:true}"/>
                    </div>
                </td>
                
         
                <td  >
                
                    <div align="left" style="width: 62px">工时：</div></td>
                <td  >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_gs" name="T_gs"  onchange="computer()"  onfocus="computer()"      ltype="text"   ligerui="{width:180}" validate="{required:true}"/>
                    </div>
                </td>
                
            </tr>
              <tr height="30px">
                <td  >
                
                    <div align="left" style="width: 62px">金额：</div></td>
                <td  >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_je" name="T_je"        ltype="text"   ligerui="{width:180,disabled:true}" validate="{required:true}"/>
                    </div>
                </td>
                
           
                <td  >
                
                    <div align="left" style="width: 80px">调整金额：</div></td>
                <td  >
                    <div style="float:left; height: 20px;">
                                <input type="text" id="T_tzje" name="T_tzje"   onchange="computer()"  onfocus="computer()"      ltype="text"   ligerui="{width:180}" validate="{required:true}"/>
          
                        <%--<input type="text" id="T_tzje" name="T_tzje"    onfocus="computer()"     ltype="text"   ligerui="{width:180}" validate="{required:true}"/>--%>
                    </div>
                </td>
                
            </tr>
              <tr height="30px">
                <td  >
                
                    <div align="left" style="width: 80px">结算金额：</div></td>
                <td  >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_zje" name="T_zje"        ltype="text"   ligerui="{width:180,disabled:true}" validate="{required:true}"/>
                    </div>
                </td>
                   <td  >
                
                    <div align="left" style="width: 80px">付款方式：</div></td>
                <td>
                        <input type="text" id="T_invoice_type" name="T_invoice_type" validate="{required:true}" ligerui="{width:182}" />

                    </td>
                
            </tr>
            <tr height="30px">
                <td  >
                
                    <div align="left" style="width: 62px">说明：</div></td>
                 <td colspan="3" >
                    <div style="float:left; height: 20px;">
                           <textarea id="T_remarks" name="T_remarks" rows="4" class="l-textarea"  validate="{required:true}" style="width:490px" ></textarea >
<%--                        <input type="text" id="T_remarks" name="T_remarks"   ltype="text"   ligerui="{width:450}" validate="{required:true}" />--%>
                    </div>
                </td>
            </tr>
              
            </table>
    </div>
    </form>
</body>
</html>
