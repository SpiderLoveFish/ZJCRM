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
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
            Years(); month();
            //$("#T_Contract_name").focus();
            $("form").ligerForm();
            $('#T_company').ligerComboBox({ width: 245, onBeforeOpen: f_selectContact });


             
                 $("#T_fylx").ligerComboBox({ width: 196, url: "../../data/Financial_Reports_SingleCustomer.ashx?Action=combo&rnd=" + Math.random(), emptyText: '（空）' });
 

        });
        function f_selectContact() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择客户', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "../../CRM/Budge/SelectBudgeCustomer.aspx", buttons: [
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
            fillemp(data.CustomerID, data.CustomerName, data.address);

            dialog.close();
        }

        function fillemp(id, CustomerName, address) {
            $("#T_companyid").val(id);
            $("#T_company").val(CustomerName + "【" + address + "】");




        }
        function f_save() {
            if ($("#T_companyid").val() == "")
            {
                alert("选择一个正确的客户！");
                return;
            }
            if ($("#T_fylx").val() == "") {
                alert("选择一个正确的计算公式！");
                return;
            }
                var sendtxt = "&Action=save1&fid=" + getparastr("fid");
                return $("form :input").fieldSerialize() + sendtxt;
            }
       
        function f_selectContactCancel(item, dialog) {
            dialog.close();
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
        
    </script>
</head>
<body style="margin:5px 5px 5px 5px">
    <form id="form1" onsubmit="return false">
    <div>
        <table  align="left" border="0"   cellspacing="1" 
            style="background: #fff; width:620px;">
           <tr>
                <td  width="120px"  align="right"  >
                    客户：</td>
                <td   >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_company" name="T_company"  ltype="text" ligerui="{width:250,disabled:true}" validate="{required:true}"/>
                    </div>    
                      <input id="T_companyid" name="T_companyid" type="hidden" />
                    
                </td>
            </tr>
            
            <tr style="height:30px">
                <td  width="120px" align="right" >计算方法名称：</td>
                <td colspan="2"   >
                        <input type="text" id="T_fylx" name="T_fylx"  />
                       <%--<input type="text" id="T_fylx" name="T_fylx"        ltype="text"   ligerui="{width:300}" validate="{required:true}"/>--%>
                </td>
            </tr>
         <%--   <tr>
                <td  width="65px"  ><div align="left" style="width: 61px">
                    财务年月：</div></td>
                <td   >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_year" name="T_year"     />
                    </div>    
                      <div style="float:left; height: 20px;">
                        <input type="text" id="T_month" name="T_month"   />
                    </div> 
                </td>
            </tr>--%>
            <%--  <tr style="height:30px">
                <td  >
                
                    <div align="right" style="width: 80px">备注：</div></td>
                <td colspan="2"  >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_remarks" name="T_remarks"   ltype="text"   ligerui="{width:300}" validate="{required:true}" />
                    </div>
                </td>
            </tr>--%>
               <tr>
        
            
              </tr>
             
            </table>
    </div>
    </form>
</body>
</html>
