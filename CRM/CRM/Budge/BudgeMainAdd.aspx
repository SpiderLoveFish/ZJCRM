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
     <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
   
      <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
      <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
   
    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        var manager = "";
        var treemanager;
        $(function () {
            
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();
            if (getparastr("cid") != null) {
                loadForm(getparastr("cid"));

            }
            else {
                var myDate = new Date()
                $("#T_jhrq").val(formatTimebytype(myDate.getDate(), "yyyy-MM-dd"));
                $('#T_company').ligerComboBox({ width: 180, onBeforeOpen: f_selectContact });
            }

            toolbar();
          
            $("#layout1").ligerLayout({ leftWidth: 200, allowLeftResize: false, allowLeftCollapse: true, space: 2, heightDiff: -1 });
 
            $("#tree1").ligerTree({
                url: '../../data/crm_product_category.ashx?Action=tree&rnd=' + Math.random(),
                onSelect: onSelect,
                idFieldName: 'id',
                //parentIDFieldName: 'pid',
                usericon: 'd_icon',
                checkbox: false,
                itemopen: false,
                onSuccess: function () {
                    $(".l-first div:first").click();
                }
            });
         
            treemanager = $("#tree1").ligerGetTreeManager();

            initLayout();
            $(window).resize(function () {
                initLayout();
            });


            $("#maingrid4").ligerGrid({
                columns: [
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                    {
                        display: '', width: 40, render: function (item) {
                            var html = "<a href='javascript:void(0)' onclick=view(" + item.product_id + ")>预览</a>"
                            return html;
                        }
                    },
                    {
                        display: '', width: 50, render: function (item) {
                            var html = "<a href='javascript:void(0)' onclick=QrCode(" + item.product_id + ")>二维码</a>"
                            return html;
                        }
                    },
                    {
                        display: '网址', width: 50, render: function (item) {
                            var html;
                            if (item.url != "" && item.url != null) {
                                html = "<a href='" + item.url + "' target='_blank'>";
                                html += "查看";
                                html += "</a>";
                            }
                            else
                                html = "无";
                            return html;
                        }
                    },
                    { display: '产品名称', name: 'product_name', width: 120 },
                    { display: '产品类别', name: 'category_name', width: 120 },
                    { display: '产品规格', name: 'specifications', width: 120 },
                    {
                        display: '价格（￥）', name: 'price', width: 120, align: 'right', render: function (item) {
                            return toMoney(item.price);
                        }
                    },
                    { display: '单位', name: 'unit', width: 40 },
                    { display: '备注', name: 'remarks', width: 120 }

                ],
                dataAction: 'server',
                url: "../../data/Crm_product.ashx?Action=grid&categoryid=0&rnd=" + Math.random(),
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                width: '100%',
                height: '100%',
                heightDiff: -1,
                //checkbox: true, name: "ischecked", checkboxAll: false, isChecked: f_isChecked, onCheckRow: f_onCheckRow, onCheckAllRow: f_onCheckAllRow,
                onContextmenu: function (parm, e) {
                    actionproduct_id = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });
          
            $("#maingrid4 .l-grid-hd-cell-btn-checkbox").hide();
          
        })

        function onSelect(note) {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.showData({ Rows: [], Total: 0 });
            var url = "../../data/Crm_product.ashx?Action=grid&categoryid=" + note.data.id + "&rnd=" + Math.random();
            manager.GetDataByURL(url);
            checkedID = [];
        }

        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=156&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                //items.push({
                //    type: 'serchbtn',
                //    text: '高级搜索',
                //    icon: '../../images/search.gif',
                //    disable: true,
                //    click: function () {
                //        serchpanel();
                //    }
                //});
                $("#toolbar").ligerToolBar({
                    items: items

                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });

                 $("#maingrid4").ligerGetGridManager().onResize();
            });
        }

        function add() {
           // f_openWindow("crm/Budge/BudgeMainAdd.aspx", "新增客户", 1100, 660);
        }
        function edit() {
           // f_openWindow("crm/Budge/BudgeMainAdd.aspx", "新增客户", 1100, 660);
        }
        function del() {
           // f_openWindow("crm/Budge/BudgeMainAdd.aspx", "新增客户", 1100, 660);
        }
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
                url: "../../data/Budge.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', cid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                   // alert(obj.Jh_date); //String 构造函数
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
                    $("#T_jhrq").val(formatTimebytype(obj.Jh_date, "yyyy-MM-dd"));
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
                url: "CRM/Budge/SelectBudgeCustomer.aspx", buttons: [
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
                , data.ywy, data.sjsid, data.sgjlid, data.ywyid,data.jhdate);
            dialog.close();
        }
        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
        function fillemp(id, tel, emp, sgjl, sjs, ywy, sjsid, sgjlid, ywyid,jhdate) {
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
            $("#T_jhrq").val(jhdate);
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
<body style="padding: 0px;overflow:hidden;">
    <form id="form1" onsubmit="return false">
    
        <div>
            <div id="toolbar"></div>
             <input type="hidden" id="h_address" value="" />
        <table style="width: 550px; margin: 5px;" class='bodytable1'>
            <tr>
                <td colspan="8" class="table_title1">基本信息</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 70px; text-align: right; float: right">客户姓名：</div>
                </td>
                <td>
                         <input type="text" id="T_company" name="T_company"  ltype="text" ligerui="{width:180}" validate="{required:true}" />
                     <input id="T_companyid" name="T_companyid" type="hidden" />
                   
                  
                    
                </td>
                <td>
                    <div style="width: 70px; text-align: right; float: right">客户电话：</div>
                </td>
                <td>
                    <input id="T_company_tel" name="T_company_tel" type="text" ltype="text" ligerui="{width:180,disabled:true}" validate="{required:false}" /></td>
          
             
                <td>
                    <div style="width: 70px; text-align: right; float: right">状态：</div>
                </td>
                <td>
                      <%--<input id="T_private" name="T_private" type="text" validate="{required:true}" style="width: 196px" />--%>
                    <input id="T_private" name="T_private" type="text" ltype="select" 
                        ligerui="{width:180,data:[{id:'正在施工',text:'正在施工'},{id:'施工完成',text:'施工完成'}]}" validate="{required:false}" /></td>
                <td>
                    <div style="width: 70px; text-align: right; float: right">业务员：</div>
                </td>
                <td>
                    <input id="T_employee" name="T_employee" validate="{required:false}"  ltype="text" ligerui="{width:180,disabled:true}"  />
                    <input id="T_employee1" name="T_employee1" type="hidden" />
                   
                </td>
             </tr>
            <tr>
                <td>
                    <div style="width: 70px; text-align: right; float: right">施工监理：</div>
                </td>
                <td>
                    <input id="T_employee_sg" name="T_employee_sg" ltype="text"  ligerui="{width:180,disabled:true}"  validate="{required:true}" />
                    <input id="T_employee1_sg" name="T_employee1_sg" type="hidden" />
                   
                </td>
                <td>
                    <div style="width: 70px; text-align: right; float: right">设计师：</div>
                </td>
                <td>
                    <input id="T_employee_sj" name="T_employee_sj" ltype="text" ligerui="{width:180,disabled:true}"  />
                    <input id="T_employee1_sj" name="T_employee1_sj" type="hidden" />
                 
                </td>
         
           
                <td>
                    <div style="width: 70px; text-align: right; float: right">计划工期：</div>
                </td>
                <td>
                      <input id="T_jhrq" name="T_jhrq" type="text"  ltype="date" validate="{required:false}" style="width: 170px" />
                    </td>
               <td>
                    <div style="width: 70px; text-align: right; float: right">附加分值：</div>
                </td>
                <td>
                      <input id="T_SpecialScore" name="T_SpecialScore" type="text"  ltype="text" validate="{required:false}" style="width: 170px" />
             </td>
             </tr>
                  
            <tr id="tr_contact4">
                <td>
                    <div style="width: 70px; text-align: right; float: right">备注：</div>
                </td>
                <td colspan="7">

                    <input id="T_remarks" name="T_remarks" type="text" ltype="text" ligerui="{width:490}" /></td>
            </tr>
        </table>
        </div>
        
                <div id="layout1" style="margin: 5px">
            <div position="left" title="部位">
                <div id="treediv" style="width: 250px; height: 100%; margin: -1px; float: left; border: 1px solid #ccc; overflow: auto;">
                    <ul id="tree1"></ul>
                </div>
            </div>
            <div position="center">
           
                <div id="maingrid4" style="margin: -1px;"></div>
            </div>
        </div>
  </form>
   
</body>
</html>
