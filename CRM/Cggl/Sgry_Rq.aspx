<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sgry_Rq.aspx.cs" Inherits="Sgry.Sgry_Rq" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
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
            loadForm(getparastr("cid"));
        })
        function loadForm(cid) {
            $.ajax({
                type: "GET",
                url: "Sgry_Add.aspx?cmd=form&cid=" + cid + "&rnd=" + Math.random(),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
          
                    $("#BNL").val(obj.BNL);
                    $("#Sex").val(obj.Sex);
                    $("#Name").val(obj.Name);
                    $("#Address").val(obj.Address);
                    $("#dh").val(obj.dh);
                    $("#lxr").val(obj.Lxr);
                    $("#lxrdh").val(obj.Lxrdh);
                    $("#Gzjs").val(obj.Gzjs);
                    $("#Remark").val(obj.Remark);
                    //客户来源
                    $("#Gz").ligerComboBox({ width: 150, initValue: obj.GzID, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=17&rnd=" + Math.random() });
                    a = $('#Towns').ligerComboBox({
                        width: 150,
                        initValue: obj.TownsID,
                        emptyText: '（空）'
                    });
                    b = $('#City').ligerComboBox({
                        width: 150,
                        initValue: obj.CityID,
                        onSelected: function (newvalue, newtext) {
                            if (!newvalue)
                                newvalue = -1;
                            $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                                a.setData(eval(data));
                                a.selectValue(obj.TownsID);
                            });
                        }, emptyText: '（空）'
                    });
                    c = $('#Provinces').ligerComboBox({
                        width: 150,
                        initValue: obj.ProvincesID,
                        url: "../../data/Param_City.ashx?Action=combo1&rnd=" + Math.random(),
                        onSelected: function (newvalue, newtext) {
                            if (!newvalue)
                                newvalue = -1;
                            $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                                b.setData(eval(data));
                                b.selectValue(obj.CityID);
                            });
                        }, emptyText: '（空）'
                    });
                },
                error: function (ex) {
                    top.$.ligerDialog.error('操作失败，错误信息：' + ex.responseText);
                }
            });
        }
        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&cmd=save&cid=" + getparastr("cid");
                return $("form :input").fieldSerialize() + sendtxt;
            }
        }

    </script>
    <style type="text/css">
        .auto-style2 {
            width: 60px;
        }
    </style>
</head>
<body>
    <form id="form1" onsubmit="return false;">
       <table style="width: 550px; margin: 5px;">
            <tr>
                <td width="100">
                    <div style="width: 100px; text-align: right; float: right">姓名：</div>
                </td>
                <td width="189">
                   
                
                     <div style="float: left; width: 80px;">
                       <input type="text" id="Name" name="Name" ltype="text" ligerui="{width:150}" validate="{required:true}" /> 
                    </div>
                   


                </td>
                <td width="113"><div style="width: 60px; text-align: right; float: right">性别：</div></td>
                <td class="auto-style2"><span style="float: left; width: 80px;">
                                         <input type="text" id="Sex" name="Sex" style="width: 56px" ltype="select" ligerui="{width:56,data:[{id:'男',text:'男'},{id:'女',text:'女'}]}" validate="{required:true}" />

                </span></td>
                <td><div style="width: 60px; text-align: right; float: right">年龄：</div></td>
                <td width="12">    <div style="float: left; width: 20px;">
                       <input type="text" id="BNL" name="BNL" ltype="text" ligerui="{width:20}" /> 
                    </div></td>
                </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">常住地址：</div>
                </td>
                <td>
                   
                
                     <div style="float: left; width: 80px;">
                       <input type="text" id="Address" name="Address" ltype="text" ligerui="{width:150}" /> 
                    </div></td>
               <td>
                    <div style="width: 80px; text-align: right; float: right">工种：</div>
              </td>
                <td colspan="3">
                  <div style="width: 100px; float: left">  <input id="Gz" name="Gz" type="text" validate="{required:true}" /></div>
                </td>

               
            </tr>
            <tr>
              <td><div style="width: 100px; text-align: right; float: right">电&nbsp;&nbsp;话：</div
                ></td>
              <td><div style="width: 100px; float: left"><input type="text" id="dh" name="dh" ltype="text" ligerui="{width:150}" /></div></td>
              <td><div style="width: 80px; text-align: right; float: right">籍贯省份：</div></td>
              <td colspan="3"><div style="width: 100px; float: left">
                <input id="Provinces" name="Provinces" type="text" />
              </div></td>
            </tr>
            <tr>
              <td><div style="width: 80px; text-align: right; float: right">籍贯城市：</div></td>
              <td><div style="width: 100px; float: left">
                <input id="City" name="City" type="text" />
              </div></td>
              <td><div style="width: 80px; text-align: right; float: right">籍贯区镇：</div></td>
              <td colspan="3"><div style="width: 100px; float: left">
                <input id="Towns" name="Towns" type="text" />
              </div></td>
            </tr>
            <tr>
              <td><div style="width: 100px; text-align: right; float: right">手艺说明：</div></td>
              <td colspan="5">
                         <textarea id="Gzjs" name="Gzjs" cols="100" rows="4" class="l-textarea" style="width:425px"></textarea>
              </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">主要联系人：</div>
                </td>
                <td>
                    <input type="text" id="lxr" name="lxr" ltype="text" ligerui="{width:150}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">联系人电话：</div>
                </td>
                <td colspan="3">
                    <input type="text" id="lxrdh" name="lxrdh" ltype="text" ligerui="{width:150}" />
                </td>
            </tr>
           
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</div>
                </td>
                <td colspan="5">
                    <textarea id="Remark" name="Remark" cols="100" rows="4" class="l-textarea" style="width:425px"></textarea>
             
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
