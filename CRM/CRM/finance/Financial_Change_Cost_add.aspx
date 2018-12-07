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
          
            if (getparastr("fid")) {
                loadForm(getparastr("fid"));
            }
            else {
                $("#T_fylx").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=29&rnd=" + Math.random(), emptyText: '（空）' });
                $('#T_invoice_type').ligerComboBox({ width: 182, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=5&rnd=" + Math.random() });
            }


        });
      
        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=save&fid=" + getparastr("fid") + "&IsStatus=0";
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
                var sendtxt = "&Action=savestatus&fid=" + getparastr("fid") + "&IsStatus=Y" ;
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }
        function f_save_th() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=savestatus&fid=" + getparastr("fid") + "&IsStatus=0";
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }
        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/Financial_Change_Cost.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', fid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        
                    }
                    //alert(obj.constructor); //String 构造函数
                    var cwny = obj.cwny;
                    var year = cwny.substring(0,4);
                    var mounth = cwny.substring(cwny.length - 2, cwny.length);
 
                    $("#T_year").val(year);
                    $("#T_month").val(mounth);
                    $("#T_fylx").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=29&rnd=" + Math.random(), emptyText: '（空）', initValue: obj.F_StyleID });
                    $("#T_je").val(obj.Amount);
                    $("#T_remarks").val(obj.Remarks);
                    $("#T_rperson").val(obj.RelevantPerson);
                    $('#T_invoice_type').ligerComboBox({ width: 182, initValue: obj.Pay_type_id, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=5&rnd=" + Math.random() });
                }
            });
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
            style="background: #fff; width:550px;">
            
            <tr>
                <td  width="65px"  ><div align="left" style="width: 61px">
                    财务年月：</div></td>
                <td>
                    <div style="float:left; height: 30px;">
                        <input type="text" id="T_year" name="T_year"     />
                    </div>    
                      <div style="float:left; height: 30px;">
                        <input type="text" id="T_month" name="T_month"   />
                    </div> 
                </td>
           
                <td  width="65px"  >费用项目：</td>
                <td   >
                        <input type="text" id="T_fylx" name="T_fylx" /></td>
            </tr>
            <tr>
                <td  >
                
                    <div align="left" style="width: 62px">金额：</div></td>
                <td  >
                    <div style="float:left; height: 30px;">
                        <input type="text" id="T_je" name="T_je"        ltype="text"   ligerui="{width:180}" validate="{required:true}"/>
                    </div>
                </td>
                <td  >
                
                    <div align="left" style="width: 60px">关联人员：</div></td>
                <td  >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_rperson" name="T_rperson"   ltype="text"   ligerui="{width:180}" validate="{required:true}" />
                    </div>
                </td>
            </tr>
           
              <tr>
                <td  >
                
                    <div align="left" style="width: 62px">付款方式：</div></td>
              <td>
                        <input type="text" id="T_invoice_type" name="T_invoice_type" validate="{required:true}" ligerui="{width:182}" />

                    </td>
                  <td  >
                
                    <div align="left" style="width: 62px"></div></td>
                <td  >
                    <div style="float:left; height: 30px;">
                      
                    </div>
                </td>
            </tr>
            <tr>
                <td  >
                
                    <div align="left" style="width: 62px">备注：</div></td>
                <td colspan="3" >
                    <div style="float:left; height: 30px;">
                        <textarea id="T_remarks" name="T_remarks" rows="4" class="l-textarea"  validate="{required:true}" style="width:490px" ></textarea >
                    </div>
                </td>
            </tr>
            </table>
    </div>
    </form>
</body>
</html>
