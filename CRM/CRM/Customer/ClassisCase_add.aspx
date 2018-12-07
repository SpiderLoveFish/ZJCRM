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
        var ci = false;
        var thumimg = "";
        $(function () {
            

            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();

            $('#T_Community').ligerComboBox({ width: 196, onBeforeOpen: f_selectComm });
           $('#T_sjs').ligerComboBox({ width: 196, onBeforeOpen: f_selectContact_sj });


            if (getparastr("cid"))
            {
               // if (getparastr("status")=="1")
                loadForm(getparastr("cid"));
            }
            else
            {
               var gkh = $('#T_kh').ligerComboBox({
                width: 196,
                //initValue: obj.Community_id,
                url: "../../data/Param_City.ashx?Action=getBuilding&rnd=" + Math.random(),
                onBeforeOpen: f_selectComm

               });
               $("#T_lx").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=19&rnd=" + Math.random(), emptyText: '（空）' });

            }
               $("#btn_logo").click(function () {
                top.$.ligerDialog.open({
                    width: 400, height: 80, url: "CRM/Customer/thum_img_add.aspx", title: "缩略图修改", buttons: [
                        {
                            text: '提交', onclick: function (item, dialog) {
                                //dialog.frame.f_save();
                                f_save_img(item, dialog);
                                // setTimeout( loadForm(getparastr("cid")), 200);
                                
                            }
                        },
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                    ]
                });
            })
        })

        function f_selectComm() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择楼盘小区', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Customer/SelectCommunity.aspx", buttons: [
                    { text: '确定', onclick: f_selectCommOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectCommOK(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('请选择楼盘小区!');
                return;
            }
            $('#T_Community_val').val(data.id);
            $("#T_Community").val(data.Name)
            dialog.close();
        }
        function f_selectContact_sj() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择员工', width: 850, height: 400, url: "hr/Getemp.aspx?isvew=Y", buttons: [
                    { text: '确定', onclick: f_selectContactOK_sj },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectContactOK_sj(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('请选择员工!');
                return;
            }
            $('#T_sjs_val').val(data.ID);
            $("#T_sjs").val(data.name)
           // fillemp(data.dname, data.d_id, data.name, data.ID);
            dialog.close();
        }
        function f_save_img(item, dialog) {
            thumimg = dialog.frame.f_return();
            // alert(thumimg);
            if (thumimg == "")
            {
                alert('先上传图片才能提交！');
                return;
            }
            dialog.close();
            $("#thumimg").attr("src", "../../" + thumimg);
        }

        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=save&id=" + getparastr("cid") + "&thumimg=" + thumimg;
                var a = $("form :input").fieldSerialize() + sendtxt;
                return a;
            }
            else {alert("数据不完整，请填写标题！选择类型！"); }
        }
        function f_save_update() {
            var sendtxt = "&Action=UpdateStatus&id=" + getparastr("cid");
            return sendtxt;
        }
        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/CRM_Classic_case.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', cid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                   // alert(obj.Community);
                    $("#T_title").val(obj.c_title)
                    $('#T_khmc').val(obj.customer_name);
                    $("#T_kh").val(obj.customer_id)
                    $('#T_zxfg').val(obj.decorationtpye);
                    $("#T_Community").val(obj.Community)
                    $('#T_area').val(obj.housearea);
                    $("#T_hx").val(obj.housetype)
                    $('#T_sjs').val(obj.designer);
                    $('#T_bz').val(obj.remarks);
                    $('#T_URL').val(obj.URL);
                    $("#T_lx").ligerComboBox({ width: 196, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=19&rnd=" + Math.random(), emptyText: '（空）', initValue: obj.img_style });

                 
                    $("#thumimg").attr("src", "../../" + obj.thum_img);
                    thumimg = obj.thum_img;
 
                }
            });
        }

        function f_selectComm() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择客户', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Customer/GetCustomer.aspx", buttons: [
                    { text: '确定', onclick: f_selectCommOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectCommOK(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('请选择客户');
                return;
            }
            //alert(JSON.stringify(data))
            filltempComm(data);
            dialog.close();
        }

        function filltempComm(data)
        {
            $('#T_khmc').val(data.Customer);
            $("#T_kh").val(data.id)
            $('#T_zxfg').val(data.Zxfg);
            $("#T_Community").val(data.Community)
            $('#T_area').val(data.Fwmj);
            $("#T_hx").val(data.Fwhx)
            $('#T_sjs').val(data.Emp_sj);
          
        }

        
        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
         function num(obj){
            obj.value = obj.value.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符
            obj.value = obj.value.replace(/^\./g,""); //验证第一个字符是数字
            obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个, 清除多余的
            obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
            obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); //只能输入两个小数
        }
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">
   
        <table style="width: 550px; margin: 5px;" class='bodytable1'>
            <tr>
                <td colspan="4" class="table_title1">基本信息</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">客户选择：</div>
                </td>
                <td>
                   
                        <input type="text" id="T_kh" name="T_kh" value="0" ltype="text"  ligerui="{width:196,disabled:true}"  />
                  
                    
                </td>
                <td>
                    <div style="width: 80px; text-align: right; float: right">案例标题：</div>
                </td>
                <td>
                    <input id="T_title" name="T_title" type="text" ltype="text" ligerui="{width:196}" validate="{required:true}"  /></td>
            </tr>
             <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">客户名称：</div>
                </td>
                <td>
                    <div style="width: 140px; float: left">
                        <input type="text" id="T_khmc" name="T_khmc" ltype="text" ligerui="{width:196}"   />
                    </div>
                    
                </td>
                <td>
                    <div style="width: 80px; text-align: right; float: right">装修风格：</div>
                </td>
                <td>
                    <input id="T_zxfg" name="T_zxfg" type="text" ltype="text" ligerui="{width:196}"   /></td>
            </tr>
            <tr>

                <td>
                    <div style="width: 80px; text-align: right; float: right">所属楼盘：</div>
                </td>
                <td>
                   <input id="T_Community" name="T_Community" type="text"      /></td>   
                   
               
                <td>

                    <div style="width: 80px; text-align: right; float: right">面积：</div>

                </td>
                <td>
                    
                    <input id="T_area" name="T_area" type="text" ltype="text" ligerui="{width:196}"  onkeyup="num(this)"  /></td>   
                 
            </tr>
      
                <tr>

                <td>
                    <div style="width: 80px; text-align: right; float: right">户型：</div>
                </td>
                <td>
                      <input id="T_hx" name="T_hx" type="text" ltype="text" ligerui="{width:196}"    /></td>   
                 
               
                <td>

                    <div style="width: 80px; text-align: right; float: right">设计师：</div>

                </td>
                <td>
                  
                   <input id="T_sjs" name="T_sjs" type="text"   /></td>   
                 
            </tr>
            <tr>
                <td colspan="4" class="table_title1">其他信息</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">类型：</div>
                </td>
                <td>
                         <input id="T_lx" name="T_lx" type="text"   /></td>   
                   <%-- <input type="text" id="T_lx" name="T_lx" style="width: 56px" ltype="select" ligerui="{width:126,data:[{id:'1',text:'全景图'},{id:'2',text:'全景放样'},{id:'3',text:'施工图'},{id:'4',text:'竣工图'}]}"   />--%>
                <td>
                    <div style="width: 80px; text-align: right; float: right">URL地址：</div>
                </td>
                <td>
                    <input type="text" id="T_URL" name="T_URL" ltype="text" ligerui="{width:195}" /></td>
            </tr>
          
              <tr>
                <td colspan="4" class="table_title1">备注</td>
            </tr>
               <tr>
              <td colspan="4" >
                  
                   <input id="T_bz" name="T_bz" type="text" ltype="text" ligerui="{width:496}"   /></td>   
                 
            </tr>
                <tr>
                <td colspan="4" class="table_title1">缩略图</td>
            </tr>
             <tr>
                     <td  colspan="3">
                    <img id="thumimg" style="height: 144px" />
                </td>
                <td  >
                     
                    <input type="button" value="修改" style="width:80px;height:22px;" id="btn_logo"/></td>
          
            </tr>
    
         
        </table>


    </form>
</body>
</html>
