<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
      <link href="../../CSS/styles.css" rel="stylesheet" />
     <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
   
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
  
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
        $(function () {
            var urlstr = "";
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();
            if (getparastr("mid") != null) {
                 loadForm(getparastr("mid"));
                urlstr = '../../data/Budge.ashx?Action=treemodel&mid=' + getparastr("mid") + '&rnd=' + Math.random();

            }
           
            $("#layout1").ligerLayout({ leftWidth: 150, allowLeftResize: false, allowLeftCollapse: true, space: 2, heightDiff: -1 });

            $("#tree1").ligerTree({
                url: urlstr,
                onSelect: onSelect,
                idFieldName: 'id',
                //parentIDFieldName: 'pid',
                //usericon: 'd_icon',
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


            g = $("#maingrid4").ligerGrid({
                columns: [
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },

                    { display: '产品名称', name: 'product_name', width: 120 },
                     { display: '部件名称', name: 'ComponentName', width: 120 },

                    { display: '产品类别', name: 'Cname', width: 120 },
                     {
                         display: '价格（￥）', name: 'TotalPrice', type: 'float', width: 80, align: 'right'
                     },
                     {
                         display: '折扣',   name: 'Discount', width: 80, align: 'right',
                         type: 'float'
                     },
                      {
                          display: '折扣价格（￥）',  name: 'TotalDiscountPrice', width: 80, align: 'right',
                          type: 'float'
                      },
                     {
                         display: '数量', name: 'SUM', width: 80, align: 'left'
                            , type: 'float' 

                     },
                    { display: '单位', name: 'unit', width: 40 },
                    { display: '备注', name: 'Remarks', width: 120 }

                ],
                dataAction: 'server',
                url: "../../data/Budge.ashx?Action=griddetailmodel&mid=" + getparastr("mid") + "&compname=0&rnd=" + Math.random(),
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                width: '100%',
                height: '100%',
                heightDiff: -1,
                enabledEdit: true,
                allowHideColumn: true,
             
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
            var url = "../../data/Budge.ashx?Action=griddetailmodel&mid=" + getparastr("mid") + "&compname=" + escape(note.data.text) + "&rnd=" + Math.random();
            manager.GetDataByURL(url);
            checkedID = [];
        }
        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/Budge.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'formmodel', mid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    // alert(obj.CustomerID); //String 构造函数
                     $("#T_yyys").val(obj.budge_id);
                    $("#T_citations").val(obj.citations);
                    $("#T_budge_name").val(obj.model_name);



                    $("#T_remarks").val(obj.Remarks);


                    $("#T_modelid").val(obj.model_id);



                }
            });
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
                <td colspan="7" class="table_title1">基本信息
                     
                </td>
                <td  class="table_title1"> 
                      
          
                </td>
                  </tr>
            <tr>
               
                
                <td>
                    <div style="width: 70px; text-align: right; float: right">模板编号：</div>
                </td>
                <td>
                      <%--<input id="T_modelid" name="T_modelid" type="text" validate="{required:true}" style="width: 196px" />--%>
                    <input id="T_modelid" name="T_modelid" type="text" ltype="text" 
                        ligerui="{width:180,disabled:true}" validate="{required:false}" />

                </td>
                <td>
                    <div style="width: 70px; text-align: right; float: right">模板名称：</div>
                </td>
                <td>
                    <input id="T_budge_name" name="T_budge_name" type="text" ltype="text" ligerui="{width:180,disabled:true}" validate="{required:false}" /></td>
          
             
                <td>
                    <div style="width: 70px; text-align: right; float: right">引用次数：</div>
                </td>
                <td>
                    <input id="T_citations" name="T_citations" validate="{required:false}"  ltype="text" ligerui="{width:180,disabled:true}"  />
 
                   
                </td>
                 <td>
                    <div style="width: 70px; text-align: right; float: right">引用预算：</div>
                </td>
                <td>
                         <input type="text" id="T_yyys" name="T_yyys"  ltype="text" ligerui="{width:180,disabled:true}" validate="{required:true}" />
               
                    
                </td>
             </tr>
             
            <tr    >
                <td>
                    <div style="width: 70px; text-align: right; float: right">备注：</div>
                </td>
                <td colspan="3">

                    <input id="T_remarks" name="T_remarks" type="text" ltype="text"  ligerui="{width:490,disabled:true}" /></td>
          
               <td colspan="4" id="tr_contact4">
                
           </td> 
                 </tr>
            
        </table>
        </div>
  
                <div id="layout1" style="margin: 5px">
            <div id="selecbj" position="left" title="部位" >
                    <div id="treediv"   style="width: 150px; height: 100%; margin: -1px; float: left; border: 1px solid #ccc; overflow: auto;">
                    <ul id="tree1"></ul>
                </div>
            </div>
            <div id="divcenter" position="center">
           
                <div id="maingrid4" style="margin: -1px;"></div>
            </div>
        </div>  
  </form>
   
</body>
</html>
