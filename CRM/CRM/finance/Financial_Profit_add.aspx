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
               // $("#T_fylx").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=31&rnd=" + Math.random(), emptyText: '（空）' });

            }


        });

        function f_save() {
            if ($(form1).valid()) {
                if ($("#T_gs_status").val() == $("#T_ywy_status").val() ||
                    $("#T_ywy_status").val() == $("#T_sgjl_status").val() ||
                    $("#T_sgjl_status").val() == $("#T_sjs_status").val() ||
                    $("#T_sjs_status").val() == $("#T_company_status").val() ||
                    $("#T_company_status").val() == $("#T_gs_status").val() ||
                    $("#T_ywy_status").val() == $("#T_sjs_status").val() ||
                    $("#T_sjs_status").val() == $("#T_sgjl_status").val())
                {
                    alert("计算顺序的    编号不能重复！")
                    return;
                }
                var sendtxt = "&Action=save&fid=" + getparastr("fid");
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }

        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/Financial_Profit.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', fid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        
                    }
                    //alert(obj.constructor); //String 构造函数
                   // alert(JSON.stringify(obj));
                    var Formula = obj.Formula;
                    var sjs_Profit = obj.sjs_Profit;
                    var Company_Profit = obj.Company_Profit;
                    var sgjl_Profit = obj.sgjl_Profit;
                    var ywy_Profit = obj.ywy_Profit;
                  //  $("#T_fylx").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=31&rnd=" + Math.random(), emptyText: '（空）', initValue: obj.F_StyleID });
                    $("#T_fylx").val(obj.F_StyleName)
                    $("#T_gs").val(Formula.split("|")[1]); $("#T_gs_status").val(Formula.split("|")[0]);
                    $("#T_remarks").val(obj.Remarks);
                    $("#T_company").val(obj.Company_Profit.split("|")[1]); $("#T_company_status").val(Company_Profit.split("|")[0]);
                    $("#T_sjs").val(obj.sjs_Profit.split("|")[1]); $("#T_sjs_status").val(sjs_Profit.split("|")[0]);
                    $("#T_sgjl").val(obj.sgjl_Profit.split("|")[1]); $("#T_sgjl_status").val(sgjl_Profit.split("|")[0]);
                    $("#T_ywy").val(obj.ywy_Profit.split("|")[1]); $("#T_ywy_status").val(ywy_Profit.split("|")[0]);
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
            style="background: #fff; width:620px;">
          
            
            <tr style="height:30px">
                <td  width="120px" align="right" >计算方法名称：</td>
                <td colspan="2"   >
                        <%--<input type="text" id="T_fylx" name="T_fylx" />--%>
                       <input type="text" id="T_fylx" name="T_fylx"        ltype="text"   ligerui="{width:300}" validate="{required:true}"/>
                </td>
            </tr>
             <tr style="height:30px">
                <td  width="120px" align="right" >非维护项目：</td>
                <td colspan="2"   >
                     <span> 客户金额<span style="color:red">(AA)</span></span>
                     <span> 固定费用<span style="color:red">(BB)</span></span>
                     <span> 变动费用<span style="color:red">(CC)</span></span>
                     <span> 材料成本<span style="color:red">(DD)</span></span>
                      <span> 人工成本<span style="color:red">(EE)</span></span>
                      <span>   计算顺序↘</span>

                </td>
            </tr>
            <tr style="height:30px">
                <td  >
                
                    <div align="right" style="width: 120px">公司毛利=</div></td>
                <td  >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_gs" name="T_gs"        ltype="text"   ligerui="{width:300}" validate="{required:true}"/>
                    </div><span style="color:red">(GG)</span>
                </td>
                
                <td  >     <div style="float:left; ">
                    <input type="text" id="T_gs_status" name="T_gs_status" style="width: 80px" ltype="select" ligerui="{width:75,data:[{id:'1',text:'1'},{id:'2',text:'2'},{id:'3',text:'3'},{id:'4',text:'4'},{id:'5',text:'5'}]}" validate="{required:true}" />   </div></td>
             
            </tr>
             <tr style="height:30px">
                <td  >
                
                    <div align="right" style="width: 120px">业务员利润=</div></td>
                <td  >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_ywy" name="T_ywy"   ltype="text"   ligerui="{width:300}" validate="{required:true}" />
                    </div><span style="color:red">(HH)</span>
                </td>
                                 <td  >     <div style="float:left; ">
                    <input type="text" id="T_ywy_status" name="T_ywy_status" style="width: 80px" ltype="select" ligerui="{width:75,data:[{id:'1',text:'1'},{id:'2',text:'2'},{id:'3',text:'3'},{id:'4',text:'4'},{id:'5',text:'5'}]}" validate="{required:true}" />   </div></td>
             
            </tr>
             
            <tr style="height:30px">
                <td  >
                
                    <div align="right" style="width: 120px">施工监理利润=</div></td>
                <td  >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_sgjl" name="T_sgjl"   ltype="text"   ligerui="{width:300}" validate="{required:true}" />
                    </div><span style="color:red">(II)</span>
                </td>
                                <td  >     <div style="float:left; ">
                    <input type="text" id="T_sgjl_status" name="T_sgjl_status" style="width: 80px" ltype="select" ligerui="{width:75,data:[{id:'1',text:'1'},{id:'2',text:'2'},{id:'3',text:'3'},{id:'4',text:'4'},{id:'5',text:'5'}]}" validate="{required:true}" />   </div></td>
             
            </tr>
            <tr style="height:30px">
                <td  >
                
                    <div align="right" style="width: 120px">设计师利润=</div></td>
                <td   >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_sjs" name="T_sjs"   ltype="text"   ligerui="{width:300}" validate="{required:true}" />
                    </div><span style="color:red">(JJ)</span>
                </td>
                                <td  >     <div style="float:left; ">
                    <input type="text" id="T_sjs_status" name="T_sjs_status" style="width: 80px" ltype="select" ligerui="{width:75,data:[{id:'1',text:'1'},{id:'2',text:'2'},{id:'3',text:'3'},{id:'4',text:'4'},{id:'5',text:'5'}]}" validate="{required:true}" />   </div></td>
             
            </tr>
             <tr style="height:30px">
                <td  >
                
                    <div align="right" style="width: 120px">公司净润=</div></td>
                <td  >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_company" name="T_company"   ltype="text"   ligerui="{width:300}" validate="{required:true}" />
                    </div><span style="color:red">(KK)</span>
                </td>
                                 <td  >     <div style="float:left; ">
                    <input type="text" id="T_company_status" name="T_company_status" style="width: 80px" ltype="select" ligerui="{width:75,data:[{id:'1',text:'1'},{id:'2',text:'2'},{id:'3',text:'3'},{id:'4',text:'4'},{id:'5',text:'5'}]}" validate="{required:true}" />   </div></td>
             
            </tr>
          <tr style="height:30px">
                <td  >
                
                    <div align="right" style="width: 80px">备注：</div></td>
                <td colspan="2"  >
                    <div style="float:left; height: 20px;">
                        <input type="text" id="T_remarks" name="T_remarks"   ltype="text"   ligerui="{width:300}" validate="{required:true}" />
                    </div>
                </td>
            </tr>
               <tr>
         <td >

                    <div align="right" style="width: 80px">使用说明：</div>
                </td>
                <td height="20" colspan="2">
                   <p><strong style="color:red">设置每一项利润公式，把相应公式填入保存。
                   AA、BB..KK 代替各费用项目在设置公式时使用。</strong></br>如公司毛利= <strong style="color:red">客户成交金额*14%</strong>，则公司毛利中填入<strong style="color:red">AA*0.14</strong>。</br>
                   如不针对每个客户向设计师提成，则设计师利润中填写0，其他以此类推！</br>
                       <strong style="color:red">注意：两个项目中不能相互使用，如AA=BB,BB=AA,这样就死循环了！</strong></br>
                           <strong style="color:red"> 理论上公司设置的所有利润点之和应等于客户成交金额。</strong>
                        </br>非维护项说明：
                       </br>客户金额= <strong style="color:red">客户收款管理中维护的金额之和。</strong>
                        </br>固定费用= <strong style="color:red">按月维护的固定费用 除以 此月客户数量，如按年的费用则先 除以12分摊到月。</strong>
                        </br>变动费用= <strong style="color:red">按月维护的变动费用 除以 此月客户数量。</strong>
                           </br>材料成本= <strong style="color:red">客户对应采购领用金额之和。</strong>
                           </br>人工成本= <strong style="color:red">客户对应维护的人工成本之和。</strong>
                   </p>
                   </td>
            </tr>
             
            </table>
    </div>
    </form>
</body>
</html>
