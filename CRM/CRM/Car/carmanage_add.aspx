<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />

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
        var jiconlist, winicons, currentComboBox;
        $(function () {
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            //$("#T_Contract_name").focus();
            $("form").ligerForm();
           
         
            $('#T_lead').ligerComboBox({ width: 180, onBeforeOpen: f_selectContact });
           
            if (getparastr("cid") == null || getparastr("cid") == "null" ||getparastr("cid")=="")
            {
                $('#T_lb').ligerComboBox({ width: 180, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=36&rnd=" + Math.random(), emptyText: '（空）'});

            } else
                loadForm(getparastr("cid"));

           
        });

        function f_selectContact() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择员工', width: 850, height: 400, url: "hr/Getemp.aspx?isvew=Y", buttons: [
                    { text: '确定', onclick: f_selectContactOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectContactOK(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('请选择员工!');
                return;
            }
            fillemp(data.name);
            dialog.close();
        }
        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
        function fillemp(emp) {
            $("#T_lead").val(emp);   
         
        }

        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=save&id=" + getparastr("cid");
                return $("form :input").fieldSerialize() + sendtxt;
            }         
        }


        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/carmanage.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', id: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {

                    }
                    fillemp(obj.leadPerson);
                    $('#T_lb').ligerComboBox({ width: 180, url: "../../data/Param_SysParam.ashx?Action=combo&parentid=36&rnd=" + Math.random(), emptyText: '（空）', initValue: obj.cartype_id });

                    // alert(obj.BP_Name); //String 构造函数
                    $("#T_buydate").val(formatTimebytype(obj.carbuydate,'yyyy-MM-dd'));
                    $("#T_carNo").val(obj.carNumber);
                    $("#T_carFrame").val(obj.carFrame);
                    $("#T_lastMOT").val(formatTimebytype(obj.lastMOT, 'yyyy-MM-dd') );
                    $("#T_LastTimeInsured").val(formatTimebytype(obj.LastTimeInsured, 'yyyy-MM-dd'));
                    $("#T_MOTgapYear").val(obj.MOTgapYear);
                    $("#T_KM").val(obj.CurrentKM);
                    $("#T_remarks").val(obj.Remarks);
                      $("#T_engine_number").val(obj.engine_number);
                }
            });
        }

         
         
    </script>
    <style type="text/css">
        .iconlist {
            width: 360px;
            padding: 3px;
        }

            .iconlist li {
                border: 1px solid #FFFFFF;
                float: left;
                display: block;
                padding: 2px;
                cursor: pointer;
            }

                .iconlist li.over {
                    border: 1px solid #516B9F;
                }

                .iconlist li img {
                    height: 16px;
                    height: 16px;
                }
    </style>

</head>
<body style="padding: 0px">
    <form id="form1" onsubmit="return false">
        <table border="0" cellpadding="3" cellspacing="1" style="background: #fff; width: 400px;">

            <tr>
                <td height="23" style="width: 85px">

                    <div align="left" style="width: 62px">类别名称：</div>
                </td>
                <td height="23">

                    <input type="text"  id="T_lb" name="T_lb"  ligerui="{width:180}" validate="{required:true}" />

                </td>
                <td height="23" style="width: 85px">

                    <div align="left" style="width: 62px">购买日期：</div>
                </td>
                <td height="23">

                       <input type="text" id="T_buydate" name="T_buydate" ltype="date" ligerui="{width:180}" />
                       
                    </td>

            </tr>
                <tr>
                <td height="23" style="width: 85px">

                    <div align="left" style="width: 62px">车牌：</div>
                </td>
                <td height="23">

                    <input type="text" id="T_carNo" name="T_carNo" ltype="text" ligerui="{width:180}" validate="{required:true}" />

                </td>
                    <td height="23" style="width: 85px">

                    <div align="left" style="width: 62px">车架：</div>
                </td>
                <td height="23">

                    <input type="text" id="T_carFrame" name="T_carFrame" ltype="text" ligerui="{width:180}" validate="{required:true}" />

                </td>
            </tr>
             <tr>
                <td height="23" style="width: 85px">

                    <div align="left" style="width: 62px">负责人：</div>
                </td>
                <td height="23">

                    <input type="text" id="T_lead" name="T_lead"  ligerui="{width:180}" validate="{required:true}" />

                </td>
                   <td height="23" style="width: 85px">

                    <div align="left" style="width: 62px">发动机号：</div>
                </td>
                <td height="23">

                    <input type="text" id="T_engine_number" name="T_engine_number" ltype="text" ligerui="{width:180}" validate="{required:true}" />

                </td>
            </tr>
             <tr>
                <td height="23" style="width: 85px">

                    <div align="left" style="width: 62px">上次投保：</div>
                </td>
                <td height="23">
                    <input type="text" id="T_LastTimeInsured" name="T_LastTimeInsured" ltype="date" ligerui="{width:180}" />
                 
                </td>
                 
                    <td height="23" style="width: 85px">

                    <div align="left" style="width: 62px">上次车检：</div>
                </td>
                <td height="23">
                       <input type="text" id="T_lastMOT" name="T_lastMOT" ltype="date" ligerui="{width:180}" />
           
                </td>
            </tr>
             <tr>
                <td height="23" style="width: 85px">

                    <div align="left" style="width: 62px">当前公里：</div>
                </td>
                <td height="23">

                    <input type="text" id="T_KM" name="T_KM" ltype="text" ligerui="{width:180}" validate="{required:true}" /></td>
          
                    <td height="23" style="width: 85px">

                    <div align="left" style="width: 62px">年检年数：</div>
                </td>
                <td height="23">

                    <input type="text" id="T_MOTgapYear" name="T_MOTgapYear" ltype="text" ligerui="{width:180}" validate="{required:true}" />

                </td>
            </tr>
            <tr>
                
                
                    <td height="23" style="width: 85px">

                    <div align="left" style="width: 62px">备注：</div>
                </td>
                <td height="23" colspan="3">
 <textarea id="T_remarks" name="T_remarks" rows="4" class="l-textarea"  validate="{required:true}" style="width:450px" ></textarea >
               
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
