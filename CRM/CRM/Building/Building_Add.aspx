<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Building_Add.aspx.cs" Inherits="Building.Building_Add" %>

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
                url: "Building_Add.aspx?cmd=form&cid=" + cid + "&rnd=" + Math.random(),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }

                    $("#Name").val(obj.Name);
                    $("#Address").val(obj.Address);
                    $("#Jzlb").val(obj.Jzlb);
                    $("#Rjl").val(obj.Rjl);
                    $("#Lhl").val(obj.Lhl);
                    $("#Kpsj").val(obj.Kpsj);
                    $("#Wygs").val(obj.Wygs);
                    $("#Wydh").val(obj.Wydh);
                    $("#Wyf").val(obj.Wyf);
                    $("#Sldh").val(obj.Sldh);
                    $("#Kfs").val(obj.Kfs);
                    $("#Jtzk").val(obj.Jtzk);
                    $("#Jj").val(obj.Jj);
                    $("#Remark").val(obj.Remark);

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
        function savemap(item, dialog) {
            var xy = dialog.frame.f_save();
            if (xy) {
                //  $.ligerDialog.success(xy);
                $("#T_xy").val(xy);
                dialog.close();
            }
        }
            function map() {
                var url = "../../CRM/Building/map_mark.aspx?type=mark&xy=" + $("#T_xy").val();
                f_openWindow(url, "楼盘标记【" + $("#Name").val() + "】", 800, 500, savemap, 9003);
            }
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false;">
        <table style="width: 550px; margin: 5px;">
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">所属省份：</div>
                </td>
                <td>
                    <div style="width: 100px; float: left">
                        <input id="Provinces" name="Provinces" type="text" />
                    </div>
                </td>
                <td>
                    <div style="width: 80px; text-align: right; float: right">所属城市：</div>
                </td>
                <td>
                    <div style="width: 100px; float: left">
                        <input id="City" name="City" type="text" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">所属区镇：</div>
                </td>
                <td>
                    <div style="width: 100px; float: left">
                        <input id="Towns" name="Towns" type="text" />
                    </div>
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">楼盘名称：</div>
                </td>
                <td>
                    <div style="width: 200px; text-align: left; float: left">
                        <input type="text" id="Name" name="Name" ltype="text" ligerui="{width:150}" validate="{required:true}" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">楼盘地址：</div>
                </td>
                <td colspan="3">
                   
                
                     <div style="float: left; width: 365px;">
                       <input type="text" id="Address" name="Address" ltype="text" ligerui="{width:350}" /> 
                    </div>
                    <div style="float: left; width: 40px;">
                        <input type="button" value="地图" style="width: 40px;"  onclick="map()"/>
                    </div>
                    <input type="hidden" id="T_xy" name="T_xy" />

                </td>

               
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">建筑类别：</div
                </td>
                <td>
                    <input type="text" id="Jzlb" name="Jzlb" ltype="text" ligerui="{width:150}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">容&nbsp;积&nbsp;&nbsp;率：</div>
                </td>
                <td>
                    <input type="text" id="Rjl" name="Rjl" ltype="text" ligerui="{width:150}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">开盘时间：</div>
                </td>
                <td>
                    <input type="text" id="Kpsj" name="Kpsj" ltype="text" ligerui="{width:150}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">绿&nbsp;化&nbsp;&nbsp;率：</div>
                </td>
                <td>
                    <input type="text" id="Lhl" name="Lhl" ltype="text" ligerui="{width:150}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">物业公司：</div>
                </td>
                <td>
                    <input type="text" id="Wygs" name="Wygs" ltype="text" ligerui="{width:150}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">物业电话：</div>
                </td>
                <td>
                    <input type="text" id="Wydh" name="Wydh" ltype="text" ligerui="{width:150}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">物&nbsp;业&nbsp;&nbsp;费：</div>
                </td>
                <td>
                    <input type="text" id="Wyf" name="Wyf" ltype="text" ligerui="{width:150}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">售楼电话：</div>
                </td>
                <td>
                    <input type="text" id="Sldh" name="Sldh" ltype="text" ligerui="{width:150}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">开&nbsp;发&nbsp;&nbsp;商：</div>
                </td>
                <td>
                    <input type="text" id="Kfs" name="Kfs" ltype="text" ligerui="{width:150}" />
                </td>
                <td>
                    <div style="width: 100px; text-align: right; float: right">均&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：</div>
                </td>
                <td>
                    <input type="text" id="Jj" name="Jj" ltype="text" ligerui="{width:150}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">全景网址：</div>
                </td>
                <td colspan="3">
                    <input type="text" id="Jtzk" name="Jtzk" ltype="text" ligerui="{width:410}" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="width: 100px; text-align: right; float: right">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</div>
                </td>
                <td colspan="3">
                    <textarea id="Remark" name="Remark" cols="100" rows="4" class="l-textarea" style="width:405px"></textarea>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
