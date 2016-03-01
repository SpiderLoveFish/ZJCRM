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
        var manager = ""; var g;
        var treemanager,gcomb;
        $(function () {
            var urlstr = "";
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();
            if (getparastr("bid") != null) {
                $("#qdkh").attr("style", "display:none");
                 
                loadForm(getparastr("bid"));
                urlstr = '../../data/Budge.ashx?Action=tree&bid=' + getparastr("bid") + '&rnd=' + Math.random();

            }
            else {
                $("#divcenter").addClass("l-window-mask");
                $("#tr2").hide();
                $("#tr_contact4").hide();
                  $("#selecbj").addClass("l-window-mask");
                urlstr = '../../data/Budge.ashx?Action=tree&rnd=' + Math.random();
                 var myDate = new Date();

                 gcomb = $('#T_company').ligerComboBox({ width: 180, onBeforeOpen: f_selectContact });
            }

            toolbar();
          
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


         g= $("#maingrid4").ligerGrid({
                columns: [
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                  
                    { display: '��Ʒ����', name: 'product_name', width: 120 },
                     { display: '��������', name: 'ComponentName', width: 120 },

                    { display: '��Ʒ���', name: 'Cname', width: 120 },
                     {
                         display: '�۸񣨣���', name: 'TotalPrice', type: 'float', width: 80, align: 'right'
                     },
                     {
                         display: '�ۿ�', hide: true, name: 'Discount', width: 80, align: 'right',
                         type: 'float'
                     },
                      {
                          display: '�ۿۼ۸񣨣���',hide:true, name: 'TotalDiscountPrice', width: 80, align: 'right',
                           type: 'float' 
                      },
                     {
                         display: '����', name: 'SUM', width: 80, align: 'left'
                            , type: 'float', editor: { type: 'float' }

                     },
                    { display: '��λ', name: 'unit', width: 40 },
                    { display: '��ע', name: 'Remarks', width: 120 }

                ],
                dataAction: 'server',
                url: "../../data/Budge.ashx?Action=griddetail&bid=" + $("#T_budgeid").val() + "&compname=0&rnd=" + Math.random(),
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
                onAfterShowData:ishidecol,
                //checkbox: true, name: "ischecked", checkboxAll: false, isChecked: f_isChecked, onCheckRow: f_onCheckRow, onCheckAllRow: f_onCheckAllRow,
                onContextmenu: function (parm, e) {
                    actionproduct_id = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });
          
            $("#maingrid4 .l-grid-hd-cell-btn-checkbox").hide();
            //�Ƿ��ۿ�
            $("#iszktable").addClass("l-window-mask");
             $("#iszk").change(function () {
                if (this.checked == true) {
                    $("#iszktable").removeClass("l-window-mask");
                    g.toggleCol('TotalDiscountPrice', true);
                    g.toggleCol('Discount', true);
                }
                else if (this.checked == false) {
                    g.toggleCol('TotalDiscountPrice', false);
                    $("#iszktable").addClass("l-window-mask");
                    g.toggleCol('Discount', false);


                }
            });
        })
        function ishidecol()
        {
          
            if ($("#iszk").attr('checked')) {
             
                $("#iszktable").removeClass("l-window-mask");
                g.toggleCol('TotalDiscountPrice', true);
                g.toggleCol('Discount', true);
            }
            else if (!$("#iszk").attr('checked')) {
                g.toggleCol('TotalDiscountPrice', false);
                $("#iszktable").addClass("l-window-mask");
                g.toggleCol('Discount', true);


            }
        }

        //ֻ����༭ǰ3��
        function f_onBeforeEdit(e) {
            //if (e.rowindex <= 2) return true;
            //return false;
            return true;
        }
        //����
        function f_onBeforeSubmitEdit(e) {
            if (e.column.name == "SUM") {
                if (e.value < 0) {
                    alert("��������Ϊ������");
                    return false;
                }
            }
            return true;
        }
        //�༭���¼� 
        function f_onAfterEdit(e) {
            if (e.column.name == "SUM") {
               
                var manager = $("#maingrid4").ligerGetGridManager();
                var row = manager.getSelectedRow();

                if (row) {
                    $.ajax({
                        url: "../../data/Budge.ashx", type: "POST",
                        data: { Action: "saveupdatesum", bid: $("#T_budgeid").val() , id: row.id, editsum: e.value, rnd: Math.random() },
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

        function onSelect(note) {
            var manager = $("#maingrid4").ligerGetGridManager();
          
            manager.showData({ Rows: [], Total: 0 });
            var url = "../../data/Budge.ashx?Action=griddetail&bid=" + $("#T_budgeid").val() + "&compname=" + escape(note.data.text) + "&rnd=" + Math.random();
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
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ����Ŀ', width: 850, height: 400,
                  url: "CRM/Budge/SelectProduct.aspx", buttons: [
                    { text: 'ȷ��', onclick: f_selectProductOK },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectProductOK(item, dialog)
        {
            if ($("#T_companyid").val() == "") {
                $.ligerDialog.error("��ѡ��һ����Ч�Ŀͻ�������");
                return;
            }
            var notes = $("#tree1").ligerGetTreeManager().getSelected();
            var compname = "";
            if (notes != null && notes != undefined) {
                // notes.data.id
               
                compname = notes.data.text;
            }
            else {
                $.ligerDialog.warn('��ѡ�񲿼���');
            }
            var rows = null;
         
            if (!dialog.frame.f_select()) {
                alert('��ѡ����!');
                return;
            }
            else {
                rows = dialog.frame.f_select();
                var pid = '';
                for (var i = 0; i < rows.length; i++) {
                    pid = pid + ',' + rows[i].product_id;

                }
                var url = '../../data/Budge.ashx?Action=savedetailadd&bid=' + $("#T_budgeid").val() + "&xmlist=" + pid + '&compname=' + escape(compname) + '&rdm=' + Math.random();
                dosave(url,dialog);
            }
        }

        function edit() {
           // f_openWindow("crm/Budge/BudgeMainAdd.aspx", "�����ͻ�", 1100, 660);
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
                            url: "../../data/Budge.ashx", type: "POST",
                            data: { Action: "deldetail", bid: row.budge_id, id: row.id, rnd: Math.random() },
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
                url: "../../data/Budge.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'form', bid: oaid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                   // alert(obj.CustomerID); //String ���캯��
                    $("#T_companyid").val(obj.CustomerID);
                    $("#T_company").val(obj.CustomerName);     
                    $("#T_budge_name").val(obj.BudgetName);
                   
                

                    $("#T_remarks").val(obj.Remarks);
                   

                    $("#T_budgeid").val(obj.id);

                     

                }
            });
        }
         
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
        
        function f_selectContactOK(item, dialog) {
            //var data = dialog.frame.f_select();
            var fn =  dialog.frame.f_select;           
            var data = fn();
            if (!data) {
                alert('��ѡ��һ����Ч�ͻ�!');
                return;
            }
            fillemp(data.CustomerID, data.tel, data.CustomerName,
                data.sgjl, data.sjs
                , data.ywy, data.sjsid, data.sgjlid, data.ywyid, data.jhdate);
            getmaxid();
            dialog.close();
        }
        function getmaxid() {
           
            $.ajax({
                type: "get",
                url: "../../data/Budge.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'getmaxid',  rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                   
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    //alert(obj.bid); //String ���캯��
                    $("#T_budgeid").val(obj.bid);

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("��ȡԤ����ʧ�ܣ�����ѡ��");
                }
            });
        }

        function f_selectContactCancel(item, dialog) {
            dialog.close();
        }
        function fillemp(id, tel, emp, sgjl, sjs, ywy, sjsid, sgjlid, ywyid,jhdate) {
            $("#T_companyid").val(id);
            $("#T_company").val(emp);
            $("#T_budge_name").val(tel);
           

            $("#T_remarks").val("");
         

        
        }
        
         
        function addcustomer() {
            if ($("#T_companyid").val() == "") {
                $.ligerDialog.error("��ѡ��һ����Ч�Ŀͻ�������");
                return;
            }
            $.ajax({
                type: 'post',
                url: "../../data/Budge.ashx?Action=saveadd&bid=" + $("#T_budgeid").val() + "&cid=" + $("#T_companyid").val() + "&remark=" + $("#T_remarks").val() + '&bname=' + $("#T_budge_name").val() + '&rdm=' + Math.random(),
                success: function (data) {
                    if (data == 'false')
                    {
                        getmaxid();
                        $.ligerDialog.error("������󣡣������±��棡");
                    }
                    else {
                        $("#qdkh").attr("style", "display:none");
                        gcomb.setReadOnly()
                        $("#divcenter").removeClass("l-window-mask");
                        $("#selecbj").removeClass("l-window-mask");
                        $("#tr2").show();
                        $("#tr_contact4").show();
                        }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.ligerDialog.error("������󣡣���");
                }
            });
        }
        //��Ӳ�λ
        function addbj()
        {
            if ($("#T_companyid").val() == "") {
                $.ligerDialog.error("��ѡ��һ����Ч�Ŀͻ�������");
                return;
            }
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ�񲿼�', width: 850, height: 400,
                url: "CRM/Budge/SelectBJ.aspx", buttons: [
                  { text: 'ȷ��', onclick: f_getbj },
                  { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
          // f_openWindow_bj("CRM/Budge/SelectBJ.aspx", "ѡ��λ", 650, 400);
        }
        //��ȡ����
        function f_getbj(item, dialog) {
            var rows = null;
         
            if (!dialog.frame.f_select()) {
                alert('��ѡ����!');
                return;
            }
            else {
                rows = dialog.frame.f_select();
                var bjid='';
                for (var i = 0; i < rows.length; i++) {
                    bjid = bjid + ',' + rows[i].id;
 
                }
              
                $.ajax({
                    type: 'post',
                    url: "../../data/Budge.ashx?Action=savebjlist&cid=" + $("#T_companyid").val() + "&bid=" + $("#T_budgeid").val() + '&bjlist=' + bjid + '&rdm=' + Math.random(),
                    success: function (data) {
                       // alert(bjid);
                        var url = '../../data/Budge.ashx?Action=tree&bid=' + $("#T_budgeid").val() +'&rnd=' + Math.random();

                        treemanager.clear();
                        treemanager.loadData(0,url,"");
                        dialog.close();
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        dialog.frame.f_error();
                    }
                });
               
            }
        }
        //���һ��ȫ������
        function f_save()
        {
            var sendtxt = "&Action=saveall";
             return $("form :input").fieldSerialize() + sendtxt;
        }
        //�洢ģ��
        function savemodel()
        {
            if ($("#T_companyid").val() == "") {
                $.ligerDialog.error("��ѡ�񱣴�һ����Ч�Ŀͻ�������");
                return;
            }
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '�洢ģ��', width: 600, height: 200,
                url: "CRM/Budge/SaveModel.aspx?cid=" + $("#T_companyid").val() + "&cname=" + encodeURI($("#T_company").val()) +
                    "&bid=" + $("#T_budgeid").val() + "&bname=" + encodeURI($("#T_budge_name").val()),
                buttons: [
                  { text: 'ȷ��', onclick: f_savemodel },
                  { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_savemodel(item, dialog)
        {
           var issave = dialog.frame.f_save();   
                if (issave) {
                    dialog.close();
                    top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                    $.ajax({
                        url: "../../data/Budge.ashx", type: "POST",
                        data: issave,
                        success: function (responseText) {
                            top.$.ligerDialog.closeWaitting();
                            if (responseText == "false") {
                                top.$.ligerDialog.error('����ʧ�ܣ�');
                            }
                            else {
                                fload();
                            }
                        },
                        error: function () {
                            top.$.ligerDialog.closeWaitting();

                        }
                    });

                }
            
        }
        //ѡ��ģ��
        function selectmodel()
        {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ��ģ��', width: 850, height: 400,
                url: "CRM/Budge/SelectModel.aspx",
                buttons: [
                  { text: 'ȷ��', onclick: f_selectmodel },
                  { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        //����ģ��
        function f_selectmodel(item, dialog)
        {
            if (!dialog.frame.f_select()) {
                alert('��ѡ����!');
                return;
            }
            var rows = dialog.frame.f_select();
             //alert(rows.model_id);
            $.ajax({
                url: "../../data/Budge.ashx", type: "POST",
                data: { Action: "savemodeltobudge", bid: $("#T_budgeid").val(), modelid: rows.model_id, rnd: Math.random() },
                success: function (responseText) {
                    top.$.ligerDialog.closeWaitting();
                    if (responseText == "false") {
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    }
                    else {
                        dialog.close();
                        fload();
                        var url = '../../data/Budge.ashx?Action=tree&bid=' + $("#T_budgeid").val() + '&rnd=' + Math.random();
                        treemanager.clear();
                        treemanager.loadData(0, url, "");
                    }
                },
                error: function () {
                    top.$.ligerDialog.closeWaitting();

                }
            });
          
        }
        //�����ۿ�
        function addzk()
        {
            if ($("#T_zk").val() <= 0) {
                top.$.ligerDialog.error('�ۿ۱������0��');
                return;
            }
            var url = '../../data/Budge.ashx?Action=saveupdatedisprice&bid=' + $("#T_budgeid").val() + "&zk=" + $("#T_zk").val() + '&rdm=' + Math.random();
            $.ajax({
                type: 'post',
                url: url,

                success: function (data) {
                    if (data == 'true') {
                        fload(); 
                    }
                    else $.ligerDialog.error("������󣡣���");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.ligerDialog.error("������󣡣���");
                    
                }
            });
            
        }
        //ˢ�¼۸�
        function refreshprice() {
           
            var url = '../../data/Budge.ashx?Action=saveupdaterefprice&bid=' + $("#T_budgeid").val() + '&rdm=' + Math.random();
            $.ajax({
                type: 'post',
                url: url,

                success: function (data) {
                    if (data == 'true')
                        fload();
                    else $.ligerDialog.error("������󣡣���");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.ligerDialog.error("������󣡣���");

                }
            });

        }
        function savetotal()
        {
            if ($("#T_sl").val() > 1 || $("#T_sl").val()<=0) {
                top.$.ligerDialog.error('�ۿ۱������0С��1��');
                return;
            }
            $.ajax({
                type: "get",
                url: "../../data/Budge.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'savetotal',bid:getparastr("bid"),sl:$("#T_sl").val(), rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                  
                    var obj = eval(result);
                  
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                   // alert(obj.sj); //String ���캯��
                    
                        $("#T_sj").val(toMoney(obj.sj));
                        $("#T_zje").val(toMoney(obj.zje));
                    

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("����ʧ�ܣ����±��棡");
                }
            });
                    
        }
        //���ӽ��
        function addfjje()
        {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '���ӽ��', width: 850, height: 550,
                url: "CRM/Budge/SelectFjje.aspx?bid=" + $("#T_budgeid").val(),
                buttons: [
                  //{ text: 'ȷ��', onclick: f_selectmodel },
                  { text: '�ر�', onclick: f_selectContactCancel }
                ]
            });
            return false;
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
                <td colspan="7" class="table_title1">������Ϣ
                     
                </td>
                <td  class="table_title1"> 
                      <a id="qdkh" class="l-button red"  position="right" style="width:150px;" onclick="addcustomer()">
                          ȷ���ͻ�

                      </a>
          
                </td>
                  </tr>
            <tr>
                <td>
                    <div style="width: 70px; text-align: right; float: right">�ͻ�������</div>
                </td>
                <td>
                         <input type="text" id="T_company" name="T_company"  ltype="text" ligerui="{width:180,disabled:true}" validate="{required:true}" />
                     <input id="T_companyid" name="T_companyid" type="hidden" />
                     <input id="T_version" name="T_version" type="hidden" />
                  
                    
                </td>
                
                <td>
                    <div style="width: 70px; text-align: right; float: right">Ԥ���ţ�</div>
                </td>
                <td>
                      <%--<input id="T_budgeid" name="T_budgeid" type="text" validate="{required:true}" style="width: 196px" />--%>
                    <input id="T_budgeid" name="T_budgeid" type="text" ltype="text" 
                        ligerui="{width:180,disabled:true}" validate="{required:false}" />

                </td>
                <td>
                    <div style="width: 70px; text-align: right; float: right">Ԥ�����ƣ�</div>
                </td>
                <td>
                    <input id="T_budge_name" name="T_budge_name" type="text" ltype="text" ligerui="{width:180}" validate="{required:false}" /></td>
          
             
                <td>
                    <div style="width: 70px; text-align: right; float: right">ҵ��Ա��</div>
                </td>
                <td>
                    <input id="T_employee" name="T_employee" validate="{required:false}"  ltype="text" ligerui="{width:180,disabled:true}"  />
                    <input id="T_employee1" name="T_employee1" type="hidden" />
                   
                </td>
             </tr>
             
            <tr    >
                <td>
                    <div style="width: 70px; text-align: right; float: right">��ע��</div>
                </td>
                <td colspan="3">

                    <input id="T_remarks" name="T_remarks" type="text" ltype="text"  ligerui="{width:490}" /></td>
          
               <td colspan="4" id="tr_contact4">
                   <table class="table_title1"><tr>
                        <td>˰��</td>
               <td>
                            <input type="text"  id="T_sl" name="T_sl"  ltype="text" ligerui="{width:80,number: true}"   />
                   </td><td>˰��</td> <td>  <input type="text"  id="T_sj" name="T_sj"  ltype="text" ligerui="{width:80,disabled:true}"   />
               </td>
                       <td>Ԥ���ܽ��</td> <td>  <input type="text"  id="T_zje" name="T_zje"  ltype="text" ligerui="{width:80,disabled:true}"   />
               </td>
                       <td><a id="A5" class="l-button"  position="right" style="width:80px;" onclick="savetotal()">
                          ����

                      </a></td>
                          </tr></table>

           </td> 
                 </tr>
               <tr id="tr2">
                <td   class="table_title1">ά����Ϣ
                     
                </td>
                   <td   class="table_title1">
                       <table><tr>
                           <td>
                        <a id="A2" class="l-button"  position="right" style="width:80px;" onclick="savemodel()">
                          ����ģ�� </a>
                     </td><td>
                      <a id="A3" class="l-button"  position="right" style="width:80px;" onclick="selectmodel()">
                          ����ģ��

                      </a>
                    </td>
                     </tr></table>
                </td><td   class="table_title1">  <a id="A4" class="l-button"  position="right" style="width:80px;" onclick="refreshprice()">
                          ˢ�¼۸� </a>
                     
                </td><td   class="table_title1"> 
                        <table><tr>
                           <td>
                        <input type="text"  id="T_fjje" name="T_fjje"  ltype="text" ligerui="{width:80,disabled:true}"   />
              
                     </td><td>
                      <a id="A7" class="l-button"  position="right" style="width:80px;" onclick="addfjje()">
                          ���ӽ��

                      </a>
                    </td>
                     </tr></table>
                </td><td   class="table_title1"> 
                     
                </td><td   class="table_title1"> 
                     
                </td>
                       <td  class="table_title1" > 
                         <input  type="checkbox" id="iszk" name="iszk" ltype="checkbox"   ligerui="{width:80}" > �ۿ� </input>
                           </td>
                <td  class="table_title1" > 
                    <table id="iszktable"> <tr> 
                        <td>
                        <input type="text"  id="T_zk" name="T_zk"  ltype="text" ligerui="{width:80,number: true}"   />
                   </td>
                        <td>
                      <a id="A1" class="l-button"  position="right" style="width:80px;" onclick="addzk()">
                          ȷ���ۿ�

                      </a></td>
                        </tr>
                    </table>
                </td>
                  </tr>
           
        </table>
        </div>
  
                <div id="layout1" style="margin: 5px">
            <div id="selecbj" position="left" title="��λ" >
                 <a class="l-button" style="width:150px;" onclick="addbj()">��Ӳ�λ</a>
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
