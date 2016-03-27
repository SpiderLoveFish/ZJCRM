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
        var manager = ""; var g,ck;
        var treemanager,gcombkh,gcombgys;
        $(function () {
            var urlstr = "";
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));
            ck = $("#ckisgd").ligerCheckBox();
           // $('input:checkbox').ligerCheckBox();
            $("form").ligerForm();
            if (getparastr("pid") != null) {
                $("#qdkh").attr("style", "display:none");
                loadForm(getparastr("pid"));
                if (getparastr("status") == "0")
                toolbar();
            }
            else {

                gcombkh= $('#T_companyname').ligerComboBox({ width: 250, onBeforeOpen: f_selectContact });
                gcombgys= $('#T_gysname').ligerComboBox({ width: 250, onBeforeOpen: f_selectContactgys });
                var cur = new Date();
                var y = cur.getFullYear();
                var m = cur.getMonth() + 1;
                var d = cur.getDate();
                //return y + '-' + m + '-' + d;
                $('#T_cgrq').val(y + '-' + m + '-' + d);
            }

         
        
            initLayout();
            $(window).resize(function () {
                initLayout();
            });


         g= $("#maingrid4").ligerGrid({
                columns: [
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                  
                    { display: '��������', name: 'material_name', width: 120 },
                     { display: '���', name: 'specifications', width: 80 },

                    { display: '�ͺ�', name: 'model', width: 120 },
                     {
                         display: '����', name: 'purprice', type: 'float', width: 60, align: 'right'
                         , editor: { type: 'float' }
                     },
                     
                        {
                            display: '����', name: 'pursum', width: 120, align: 'left'
                            , type: 'float', editor: { type: 'float' },
                            totalSummary:
                            {
                                type: 'sum'
                            }

                        },
                         {
                             display: 'С��', name: 'subtotal', type: 'float', width: 100, align: 'right',
                             totalSummary:
                             {
                                 type: 'subtotal'
                             }
                         },
                  
                        {
                            display: '��ע', name: 'Remarks', align: 'left', width: 400,type:'text'
                            , editor: { type: 'text' }
                        }
                 
                ],
                dataAction: 'server',
                url: "../../data/Purchase.ashx?Action=griddetail&pid=" + getparastr("pid") + "&rnd=" + Math.random(),
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                width: '100%',
                height: '100%',
                heightDiff: -1,
                enabledEdit: true,
                allowHideColumn:true,
                onBeforeEdit: f_onBeforeEdit,
                onBeforeSubmitEdit: f_onBeforeSubmitEdit,
                onAfterEdit: f_onAfterEdit,
                //onAfterShowData: function (grid) {
                //    $(".abc").hover(function (e) {
                //        $(this).ligerTip({ content: $(this).text(), width: 200, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                //    }, function (e) {
                //        $(this).ligerHideTip(e);
                //    });
                //},
               // onAfterShowData:ishidecol,
                //checkbox: true, name: "ischecked", checkboxAll: false, isChecked: f_isChecked, onCheckRow: f_onCheckRow, onCheckAllRow: f_onCheckAllRow,
                onContextmenu: function (parm, e) {
                    actionproduct_id = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });
          
         $("#maingrid4 .l-grid-hd-cell-btn-checkbox").hide();

         //if (status != "0") {
         //    g.toggleCol('purprice', true);
         //    g.toggleCol('pursum', true);
         //}
        })
 
        
        //ֻ����༭ǰ3��
        function f_onBeforeEdit(e) {
            if (getparastr("status") != "0")  //�Ǳ༭״̬�������޸ģ�
            return false;
            return true;
        }
        //����
        function f_onBeforeSubmitEdit(e) {
            if (e.column.name == "purprice"||e.column.name=="pursum") {
                if (e.value < 0) {
                    alert("��������Ϊ������");
                    return false;
                }
            }
            return true;
        }
        //�༭���¼� 
        function f_onAfterEdit(e) {
            var price=0,editsum=0,Remarks='';
            if (e.column.name == "purprice") {
                price=e.value;
            }
            if (e.column.name == "pursum") {
                editsum=e.value;
            } 
            if (e.column.name == "Remarks") {
                Remarks=e.value;
            }
            if(price>0||editsum>0||Remarks.length>0)
            {
                var manager = $("#maingrid4").ligerGetGridManager();
                var row = manager.getSelectedRow();

                if (row) {
                    $.ajax({
                        url: "../../data/Purchase.ashx", type: "POST",
                        data: { Action: "saveupdatedetail", pid: $("#T_Pid").val(), mid: row.material_id, editsum: editsum,price:price,remaks:Remarks, rnd: Math.random() },
                        success: function (responseText) {
                    
                            if (responseText == "true") {
                                top.$.ligerDialog.closeWaitting();
                                fload();
                            }

                        },
                        error: function () {
                            top.$.ligerDialog.closeWaitting();
                            top.$.ligerDialog.error('�޸�ʧ�ܣ�', "", null, 9003);
                        }
                    });
                }
                else {
                    $.ligerDialog.warn("��ѡ��һ��Ч�У�");
                }
            }
        }

    

        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=160&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
  
                $("#toolbar").ligerToolBar({
                    items: items

                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });

                 $("#maingrid4").ligerGetGridManager().onResize();
            });
        }
        //ѡ��ȫ������
        function selall() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ��ȫ������', width: 850, height: 400,
                url: "CRM/Purchase/SelectProduct.aspx?style=all", buttons: [
                    { text: 'ȷ��', onclick: f_selectProductOK },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        //ѡ�񹤳̲���
        function selgc() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ�񹤳̲���', width: 850, height: 400,
                url: "CRM/Purchase/SelectProduct.aspx?style=cl&cid=" + $("#T_companyid").val(), buttons: [
                  { text: 'ȷ��', onclick: f_selectProductOK },
                  { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectProductOK(item, dialog)
        {
            if ($("#T_companyid").val() == "") {
                $.ligerDialog.error("��ѡ��һ����Ч�����ݣ�����");
                return;
            }
             
            var rows = null;
         
            if (!dialog.frame.f_select()) {
                alert('��ѡ����!');
                return;
            }
            else {
                rows = dialog.frame.f_select();
                var pidlist = '';
                for (var i = 0; i < rows.length; i++) {
                    pidlist = pidlist + ',' + rows[i].product_id;

                }
                var url = '../../data/Purchase.ashx?Action=savedetail&pid=' + $("#T_Pid").val() + "&bjlist=" + pidlist + '&rdm=' + Math.random();
                dosave(url,dialog);
            }
        }

        function f_save() {
            var isAccept = ck.getValue();
            var isgd = 0;
            if (isAccept) isgd = 1;
            var sendtxt = "&Action=save&isgd=" + isgd;
            return $("form :input").fieldSerialize() + sendtxt;
        }
        //��� ������
        function f_saveapr() {
            if ($("#T_companyid").val() == "") {
                $.ligerDialog.error("��ѡ�񱣴�һ����Ч�Ŀͻ�������");
                return;
            }
            var sta = 2;
            if (getparastr("style") == "apr")//���
                sta = 2;
            if (getparastr("style") == "apry")//ȷ��
                sta = 3;
            if (getparastr("style") == "cancel")//����
                sta = 99;
            if (getparastr("style") == "ret") sta = 0;//����
            var sendtxt = "&Action=saveupdatestatus&status=" + sta + "&pid=" + $("#T_Pid").val();
            return sendtxt;
        }
        function dosave(saveurl, dialog)
        {
            $.ajax({
                type: 'post',
                url: saveurl,

                success: function (data) {
                    dialog.close();
                    fload();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.ligerDialog.error("������󣡣���");
                    dialog.close();
                }
            });
        }

        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("ɾ�����ָܻ���ȷ��ɾ����", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/Purchase.ashx", type: "POST",
                            data: { Action: "deldetail", pid: row.Purid, mid: row.material_id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    fload();
                                }

                                else {
                                    top.$.ligerDialog.closeWaitting();
                                    top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                                }
                            },
                            error: function () {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('ɾ��ʧ�ܣ�', "", null, 9003);
                            }
                        });
                    }
                })
            } else {
                $.ligerDialog.warn("��ѡ�����");
            }
        }
      
        function loadForm(oaid) {
             $.ajax({
                type: "GET",
                url: "../../data/Purchase.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'form', pid: oaid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                   // alert(obj.CustomerID); //String ���캯��
                    $("#T_companyid").val(obj.customid);
                    $("#T_companyname").val(obj.Customer + "(" + obj.address + ")");
                    $("#T_gysid").val(obj.supplier_id);
                    $("#T_gysname").val(obj.supplier_name);
                    $("#T_Pid").val(obj.Purid);
                    if (obj.IsGD=="1")
                        ck.setValue(true);;
                    $("#T_remarks").val(obj.Remarks);
                    $("#T_employee2").val(obj.materialman);
                    $("#T_cgrq").val(formatTime( obj.purdate));
                    $("#T_yfje").val(obj.paid_amount);
                    $("#T_yfje2").val(obj.payable_amount);
                    $("#T_qk").val(obj.arrears);
                    $("#T_employee").val(obj.Emp_sg);//ʩ������
                   
                }
            });
        }
         

        //ѡ��ͻ�
        function f_selectContact() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ��ͻ�', width: 850, height: 400,
               
                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Budge/SelectBudgeCustomer.aspx", buttons: [
                    { text: 'ȷ��', onclick: f_selectContactOK },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        //ѡ��Ӧ��
        function f_selectContactgys() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ��Ӧ��', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Purchase/SelectSupplier.aspx", buttons: [
                    { text: 'ȷ��', onclick: f_selectContactgysOK },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectContactOK(item, dialog) {
            //var data = dialog.frame.f_select();
            var fn =  dialog.frame.f_select;           
            var data = fn();
            if (!data) {
                alert('��ѡ��һ����Ч�ͻ�!');
                return;
            }
            fillemp(data.CustomerID, data.CustomerName,  
                data.sgjl,data.address );
          
            dialog.close();
        }

        function f_selectContactgysOK(item, dialog) {
            //var data = dialog.frame.f_select();
            var fn = dialog.frame.f_select;
            var data = fn();
            if (!data) {
                alert('��ѡ��һ����Ч��Ӧ��!');
                return;
            }
            fillempgys(data.ID, data.Name);
          
            dialog.close();
        }


        function getmaxid() {
           
            $.ajax({
                type: "get",
                url: "../../data/Purchase.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'getmaxid', rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                   
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(obj.pid); //String ���캯��
                    $("#T_Pid").val(obj.pid);
                    $("#T_employee2").val(obj.cly);

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("��ȡԤ����ʧ�ܣ�����ѡ��");
                }
            });
        }

        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
        function fillemp(id,  emp, sgjl,address) {
            $("#T_companyid").val(id);
            $("#T_companyname").val(emp + '(' + address+')');
            $("#T_employee").val(sgjl);
        }
        function fillempgys(id, emp) {
            $("#T_gysid").val(id);
            $("#T_gysname").val(emp);
            getmaxid();
        }
         
        function addpur()
        {
           
            var isAccept = ck.getValue();
            if ($("#T_companyid").val() == "") {
                $.ligerDialog.error("��ѡ��һ����Ч�Ŀͻ�������");
                return;
            }
            var isgd = 0;
            if (isAccept) isgd = 1;
            $.ajax({
                type: 'post',
                url: "../../data/Purchase.ashx?Action=savetemp&pid=" + $("#T_Pid").val() + "&cid=" + $("#T_companyid").val() + "&remark=" + $("#T_remarks").val() + '&supid=' + $("#T_gysid").val() + '&isgd=' + isgd + '&rdm=' + Math.random(),
                success: function (data) {
                    if (data == 'false') {
                        getmaxid();
                        $.ligerDialog.error("������󣡣������±��棡");
                    }
                    else {
                        $("#qdkh").attr("style", "display:none");
                        gcombgys.setReadOnly;
                        gcombkh.setReadOnly;
                        toolbar();
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.ligerDialog.error("������󣡣���");
                }
            });
          
        }
   
       
        function fload()
        {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
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
                <td colspan="6" class="table_title1">������Ϣ
                     
                </td>
                <td colspan="3"  class="table_title1"> 
                      <a id="qdkh" class="l-button red"  position="right" style="width:150px;" onClick="addpur()">
                          ȷ���ɹ�

                      </a>
          
                </td>
                  </tr>
            <tr>
                <td>
                    <div style="width: 70px; text-align: right; float: right">�ͻ���Ϣ��</div>
                </td>
                <td  >
                         <input type="text" id="T_companyname" name="T_companyname"  ltype="text" ligerui="{width:250,disabled:true}" validate="{required:true}" />
                     <input id="T_companyid" name="T_companyid" type="hidden" />
               
                    
                </td>
                
                <td>
                    <div style="width: 70px; text-align: right; float: right">��Ӧ�̣�</div>
                </td>
                <td  >
                      <input id="T_gysid" name="T_gysid" type="hidden" />
                    <input id="T_gysname" name="T_gysname" type="text" ltype="text" 
                        ligerui="{width:250,disabled:true}" validate="{required:false}" />

                </td>
                 
                <td>  <div style="width: 70px; text-align: right; float: right">Ӧ����</div></td>
                <td><input type="text"  id="T_yfje" name="T_yfje"  ltype="text" ligerui="{width:80,disabled:true}"   /></td>
              <td> <div style="width: 70px; text-align: right; float: right">�Ѹ���</div></td>
              <td><input type="text"  id="T_yfje2" name="T_yfje2"  ltype="text" ligerui="{width:80,disabled:true}"   /></td>
              
               
                 </tr>
             <tr>
                    <td><div style="width: 70px; text-align: right; float: right">Ƿ�</div></td>
                <td><input type="text"  id="T_qk" name="T_qk"  ltype="text" ligerui="{width:80,disabled:true}"   /></td>
               <td><div style="width: 70px; text-align: right;   float: right">�ɹ����ڣ�</div></td>
                <td><input type="text"  id="T_cgrq" name="T_cgrq"  ltype="date" ligerui="{width:120}"   /></td>
             <td   ><span style="width: 60px; text-align: right; float: right">ʩ������</span></td>
                 <td   ><input id="T_employee" name="T_employee" validate="{required:false}"  ltype="text" ligerui="{width:80,disabled:true}"  /></td>
                 <td   ><span style="width: 60px; text-align: right; float: right">����Ա��</span></td>
                 <td    ><input id="T_employee2" name="T_employee2" validate="{required:false}"  ltype="text" ligerui="{width:80,disabled:true}"  /></td>
               
             </tr>
               <tr>
                 
                 <td    ><div style="width: 70px; text-align: right; float: right">��ע��</div></td>
                 <td colspan="3"  ><input id="T_remarks" name="T_remarks" type="text" ltype="text"  ligerui="{width:550}" /></td>
                   <td> 
                  
                    <div class="l-checkbox-wrapper">
                        <%--<a class="l-checkbox"></a>--%>
                        <input type="checkbox" name="ckisgd" id="ckisgd" 
                            class="l-hidden" 
                        ligeruiid="ckisgd"/></div> �Ƿ��ֳ� 
  
                   </td>
                <td>  <div style="width: 70px; text-align: right; float: right">�ɹ����ţ�</div></td>
                <td  colspan="2"><input type="text"  id="T_Pid" name="T_Pid"  ltype="text" ligerui="{width:150,disabled:true}"   /></td>
             
                    </tr>
          
        </table>
        </div>
   
            <div id="divcenter" position="center">
           
                <div id="maingrid4" style="margin: -1px;"></div>
            </div>
        
  </form>
   
</body>
</html>
