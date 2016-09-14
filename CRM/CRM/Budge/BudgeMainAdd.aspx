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
        var treemanager, gcomb;
        var isshowzk = getparastr("isshowzk");
        var IsModel = getparastr("IsModel");
        var istc = getparastr("istc");
        var tc = "����ģ��";
        if (istc == "Y") tc = "�ײ�ģ��";
        else if (istc == "N") tc = "����ģ��";
        $(function () {
            var urlstr = "";
            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();

            if (getparastr("bid") != null || IsModel == 'Y')//���༭��ģ���ʱ��
            {
                $("#qdkh").attr("style", "display:none");
                loadfjf(getparastr("bid"));//���ӽ��  
                // $("#tipfjje").attr("style", "display:none");
                $("#tipfjje").hover(function () {
                    $(this).ligerTip({ content: $("#tipfjje").html(), width: 300 });
                },
                    function ()
                    { $(this).ligerHideTip(); }
                   ); //͸��jquery��hover����ֵһ����������Ƴ��¼�
                $("#tipfjje").ligerHideTip(); //�رյ�����tip
                loadForm(getparastr("bid"));
                urlstr = '../../data/Budge.ashx?Action=tree&bid=' + getparastr("bid") + '&rnd=' + Math.random();
                //��ˣ�ʧЧ���߱༭ʱ���Ѿ��ύ
                if (getparastr("style") != null || getparastr("status") == "1")
                    InitButton();
                else {
                    toolbar();
                }
            }
            else {
                $("#divcenter").addClass("l-window-mask");
                $("#tr2").hide();
                $("#tr_contact4").hide();
                $("#selecbj").addClass("l-window-mask");
                urlstr = '../../data/Budge.ashx?Action=tree&rnd=' + Math.random();
                var myDate = new Date();

                gcomb = $('#T_company').ligerComboBox({ width: 180, onBeforeOpen: f_selectContact });
                toolbar();
            }



            $("#layout1").ligerLayout({ leftWidth: 150, allowLeftResize: false, allowLeftCollapse: true, space: 2, heightDiff: -1 });

            $("#tree1").ligerTree({
                url: urlstr,
                onSelect: onSelect,
                idFieldName: 'id',
                //parentIDFieldName: 'pid',
                //usericon: 'd_icon',
                nodeDraggable: true,
                checkbox: false,
                itemopen: false,
                onSuccess: function () {
                    $(".l-first div:first").click();
                },
                onContextmenu: function (node, e) {

                    menuNodeID = node.data.id;

                    menuNodeParentID = node.data.parentid;

                    menuNodeText = node.data.text;

                    menutree.show({ top: e.pageY, left: e.pageX });

                    return false;

                }
            });

            var menutree = $.ligerMenu({

                top: 100, left: 100, width: 120, items:

                [

                { text: 'ɾ������', click: removeTreeItem },
                { text: '���Ʋ���', click: copyTreeItem }

                ]

            });

            treemanager = $("#tree1").ligerGetTreeManager();

            initLayout();
            $(window).resize(function () {
                initLayout();
            });


            g = $("#maingrid4").ligerGrid({
                columns: [
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                     {
                         display: "����", name: "OrderBy", type: "int", align: "right", width: 40,
                         editor: { type: "int" }

                     },
                    { display: '����', name: 'product_name', width: 120 },
                     { display: '��λ', name: 'ComponentName', width: 50 },

                    { display: '���', name: 'Cname', width: 120 },

                     {
                         display: '���ģ�', name: 'zc_price', type: 'float', width: 50, align: 'right', render: function (item) {
                             return "<div style='color:#135294'>" + item.zc_price + "</div>";
                         }
                     }, {
                         display: '���ģ�', name: 'fc_price', type: 'float', width: 50, align: 'right', render: function (item) {
                             return "<div style='color:#135294'>" + item.fc_price + "</div>";
                         }
                     }, {
                         display: '�˹���', name: 'rg_price', type: 'float', width: 50, align: 'right', render: function (item) {
                             return "<div style='color:#135294'>" + item.rg_price + "</div>";
                         }
                     },
                     {
                         display: '�ܼۣ�', name: 'TotalPrice', type: 'float', width: 50, align: 'right'
                     },
                    {
                        display: "����", name: "SUM", type: "float", align: "right", width: 60,
                        editor: { type: "float" },
                        totalSummary: {
                            //type:'sum,count,max,min,avg'
                            render: function (suminf, column) {
                                return "<span style='color:red'>" + suminf.sum.toFixed(2) + "</span>";
                            }
                        }
                    },
                        {
                            display: "��", name: "je", type: "float", width: 50, align: 'right',
                            totalSummary: {
                                //type:'sum,count,max,min,avg'
                                render: function (suminf, column) {
                                    return "<span style='color:red'>" + suminf.sum.toFixed(2) + "</span>";
                                }
                            }
                        },


                     //{
                     //    display: '�ۿ�', name: 'Discount', width: 30, align: 'right',
                     //    type: 'float'
                     //},
                     //   {
                     //       display: "�ۺ���", name: "zkje", type: "float", isAllowHide: false, align: "right", width: 60,
                     //       editor: { type: "spinner" },
                     //       totalSummary: {
                     //           //type:'sum,count,max,min,avg'
                     //           render: function (suminf, column) {
                     //               return "<span style='color:red'>" + suminf.sum.toFixed(2) + "</span>";
                     //           }
                     //       }
                     //   },

                    { display: '��λ', name: 'unit', width: 40 },
                     { display: '����', name: 'C_style', width: 40 },
                        {
                            display: '����˵��', name: 'proremarks', align: 'left', width: 150, render: function (item) {
                                var html = "<div class='abc'>";
                                if (item.proremarks)
                                    html += item.proremarks;
                                html += "</div>";
                                return html;
                            }
                        },
                         {
                             display: 'ͼ��', width: 40, render: function (item) {
                                 var html = "<a href='javascript:void(0)' onclick=view(" + item.xmid + ")>�鿴</a>"
                                 return html;
                             }
                         }

                ],
                dataAction: 'server',
                url: "../../data/Budge.ashx?Action=griddetail&bid=" + $("#T_budgeid").val() + "&compname=0&rnd=" + Math.random(),
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                width: '100%',
                height: '100%',
                heightDiff: -1,
                enabledEdit: true,
                allowHideColumn: true,
                onBeforeEdit: f_onBeforeEdit,
                onBeforeSubmitEdit: f_onBeforeSubmitEdit,
                onAfterEdit: f_onAfterEdit,
                onAfterShowData: function (grid) {
                    $(".abc").hover(function (e) {
                        $(this).ligerTip({ content: $(this).text(), width: 200, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                    }, function (e) {
                        $(this).ligerHideTip(e);
                    });
                },
                // onAfterShowData: ishidecol,
                //checkbox: true, name: "ischecked", checkboxAll: false, isChecked: f_isChecked, onCheckRow: f_onCheckRow, onCheckAllRow: f_onCheckAllRow,
                onContextmenu: function (parm, e) {
                    actionproduct_id = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });

            $("#maingrid4 .l-grid-hd-cell-btn-checkbox").hide();
            if (isshowzk == "Y") {
            }
            else {
                //g.toggleCol('Discount', false);
                //g.toggleCol('zkje', false);
                $("#zk1").attr("style", "display:none");
                $("#zk2").attr("style", "display:none");
            }

            if (IsModel == 'Y') {
                //getmaxid();
                $("#T_budgeid").val(getparastr("bid"));
                $("#T_companyid").val(0);
                $("#T_company").val("ģ��");
                $("#T_budge_name").val("ģ��");
                $("#T_remarks").val("");
                $("#tbmb").attr("style", "display:none");
                $("#T_mblx").val(tc);
            }

        })
    
        //document.onkeyup = function (event) {
        //    var e = event || window.event;
        //    var keyCode = e.keyCode || e.which;
        //    switch (keyCode) {

                
        //        case 9://�س�
        //            g.endEditToNext();
        //            break;
        //    }

        //}
        function updateall()
        {
            if (getparastr("style") != null || getparastr("status") == "1") {
                top.$.ligerDialog.error('�Ǳ༭״̬�޷����ƣ�');
                return;
            }
            var node = treemanager.getSelected();
            if (node) {
                top.$.ligerDialog.open({
                    zindex: 9003,
                    title: '�༭' + node.data.text + '��ϸ', width: 950, height: 600,
                    url: "CRM/Budge/BudgeMainAdd_Detail.aspx?bjmc=" + encodeURI(node.data.text) + "&bid=" + $("#T_budgeid").val(), buttons: [
            
                      { text: '����', onclick: f_selectContactCancel }
                    ]
                });
                return false;

            } else {
                top.$.ligerDialog.error('���Ȳ�λѡ��ڵ㣡');  
            }

        }
      
        function loadfjf(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/Budge.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'gridrate', bid: oaid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = result.Rows;
                    var item;
                    $.each(obj, function (i, data) {

                        item = "<tr><td>" + data['RateName'] + "</td> "
                            + " <td>" + data['rate'] + "</td> <td>" + data['RateAmount'] + "</td>"
                            + " </tr>";
                        $('.abcde').append(item);

                    });

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                }
            })
        }

        function copyTreeItem() {
            if (getparastr("style") != null || getparastr("status") == "1") {
                top.$.ligerDialog.error('�Ǳ༭״̬�޷����ƣ�');
                return;
            }
            var node = treemanager.getSelected();
            if (node) {
                top.$.ligerDialog.open({
                    zindex: 9003,
                    title: 'ѡ�񲿼�', width: 850, height: 400,
                    url: "CRM/Budge/SelectBJSingle.aspx?bjmc=" + node.data.text, buttons: [
                      { text: 'ȷ��', onclick: f_getbjsingle },
                      { text: 'ȡ��', onclick: f_selectContactCancel }
                    ]
                });
                return false;

            } else {
                alert('����ѡ��ڵ�');
            }
        }


        function removeTreeItem() {
            if (getparastr("style") != null || getparastr("status") == "1") {
                top.$.ligerDialog.error('�Ǳ༭״̬�޷�ɾ����');
                return;
            }
            var node = treemanager.getSelected();
            if (node) {
                $.ligerDialog.confirm("ɾ�����ָܻ���ȷ��ɾ����", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/Budge.ashx", type: "POST",
                            data: { Action: "delcomp", bid: $("#T_budgeid").val(), comp: node.data.text, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    treemanager.remove(node.target);

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

            }
            else {
                alert('����ѡ��ڵ�');
            }


        }


        function InitButton() {

            $(".l-button").each(function () {
                $(this).css('background', 'none')
                $(this).css('color', '#666')
                $(this).removeAttr('onclick');

            });


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
                        data: { Action: "saveupdatesum", bid: $("#T_budgeid").val(), id: row.id,editorderby:-1, editsum: e.value, rnd: Math.random() },
                        success: function (responseText) {

                            if (responseText == "true") {
                                top.$.ligerDialog.closeWaitting();
                                fload();
                            } else {
                                top.$.ligerDialog.error('�޸�ʧ�ܣ�', "", null, 9003);
                            }
                           // <td class="l-grid-row-cell" columnindex="0" style="width:50px; "><div class="l-grid-row-cell-inner l-grid-row-cell-inner-fixedheight" style="width:42px; ">4</div></td>
                            // alert(JSON.stringify(e));
                            
                           // var cell = g.grideditor;
                           //var jprev = $(cell);
                           //alert(JSON.stringify(cell));
                          
                           //jprev.parent("tr").next(".l-grid-row").find("td:first");
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
            var notes = $("#tree1").ligerGetTreeManager().getSelected();
            var compname = "";
            if (notes != null && notes != undefined) {
                // notes.data.id

                compname = notes.data.text;
            }
            else {
                $.ligerDialog.warn('��ѡ�񲿼���');
                return;
            }
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ����Ŀ', width: 850, height: 400,
                url: "CRM/Budge/SelectProduct.aspx?bid=" + getparastr("bid") + '&compname=' + escape(compname), buttons: [
                    { text: 'ȷ��(F2)', onclick: f_selectProductOK },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        var activeDialogs = null;
        function f_openWindowselect(url, title, width, height) {
            var dialogOptions = {
                zindex: 9002,
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '����', onclick: function (item, dialog) {
                                f_saveselect(item, dialog);
                            }
                        },
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                f_close(item, dialog);
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialogs = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        //�ر�ˢ��
        function f_close(item, dialog) {
            fload();
            dialog.close();
        }
        function addcl() {
            var notes = $("#tree1").ligerGetTreeManager().getSelected();
            var compname = "";
            if (notes != null && notes != undefined) {
                // notes.data.id

                compname = notes.data.text;
            }
            else {
                $.ligerDialog.warn('��ѡ�񲿼���');
            }
            f_openWindowselect("../../crm/product/product_add.aspx?type=Selectbudge&id=" + getparastr("bid") + "&compname=" + escape(compname), "�������ϵ���", 800, 500);


        }
        function f_saveselect(item, dialog) {
            var issave = dialog.frame.f_saveSelect();
            if (issave) {

                top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                $.ajax({
                    url: "../../data/Crm_product.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        if (responseText == "false:code") {
                            top.$.ligerDialog.error("���ϴ����ظ�����������д��");
                            top.$.ligerDialog.closeWaitting();
                        }
                        else {
                            dialog.close();
                            top.$.ligerDialog.closeWaitting();
                            fload();
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    }
                });

            }
        }
        function f_selectProductOK(item, dialog) {
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
                dosave(url, dialog);
            }
        }

        function edit() {
            // f_openWindow("crm/Budge/BudgeMainAdd.aspx", "�����ͻ�", 1100, 660);
        }
        function dosave(saveurl, dialog) {
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
                    //  alert(obj.BudgetName); //String ���캯��
                    $("#T_companyid").val(obj.customer_id);
                    $("#T_company").val(obj.CustomerName + "(" + obj.address + ")");
                    $("#T_budge_name").val(obj.BudgetName);
                    $("#T_zje").val(obj.zje);
                    $("#T_zje2").val(obj.JJAmount);
                    $("#T_zje3").val(obj.ZCAmount);
                    $("#T_fjje").val(obj.fjfy);
                    $("#T_remarks").val(obj.Remarks);
                    $("#T_sj").val(obj.b_sj);
                    $("#T_sl").val(obj.b_sl);
                    $("#T_budgeid").val(obj.id);
                    $("#T_employee").val(obj.ywy);
                    $("#T_employee2").val(obj.sjs);
                    $("#T_zjezk").val(obj.zkzje);
                    $("#T_mblx").val(obj.ModelStyle);
                    var zk = obj.DetailDiscount;
                    if (zk == "") zk = 1;
                    if (zk != 1) {
                        // alert(obj.DetailDiscount);
                        //g.toggleCol('Discount', true);
                        //g.toggleCol('zkje', true);
                        $("#zk1").attr("style", "display:");
                        $("#zk2").attr("style", "display:");


                    }
                    $("#T_zk").val(zk);


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
            var fn = dialog.frame.f_select;
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
                data: { Action: 'getmaxid', rnd: Math.random() }, /* ע������ĸ�ʽ������ */
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
            fload();
        }
        function fillemp(id, tel, emp, sgjl, sjs, ywy, sjsid, sgjlid, ywyid, jhdate) {
            $("#T_companyid").val(id);
            $("#T_company").val(emp);
            $("#T_budge_name").val("Ԥ��" + emp);


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
                    if (data == 'false') {
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
        function addbj() {
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

        function f_getbjsingle(item, dialog) {


            if (!dialog.frame.f_select()) {
                alert('��ѡ����!');
                return;
            }
            else {
                var data = dialog.frame.f_select();
                var bjid = data.id;
                var copybj = dialog.frame.f_copybj();
                // alert(copybj)
                //for (var i = 0; i < rows.length; i++) {
                //    bjid = bjid + ',' + rows[i].id;

                $.ajax({
                    type: 'post',
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    url: "../../data/Budge.ashx?Action=savebjcopylist&bjid=" + bjid + "&bid=" + $("#T_budgeid").val() + '&copybj=' + copybj + '&rdm=' + Math.random(),
                    success: function (data) {
                        // alert(bjid);
                        var url = '../../data/Budge.ashx?Action=tree&bid=' + $("#T_budgeid").val() + '&rnd=' + Math.random();

                        treemanager.clear();
                        treemanager.loadData(0, url, "");
                        dialog.close();
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        dialog.frame.f_error();
                    }
                });
            }



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
                var bjid = '';
                for (var i = 0; i < rows.length; i++) {
                    bjid = bjid + ',' + rows[i].id;

                }

                $.ajax({
                    type: 'post',
                    url: "../../data/Budge.ashx?Action=savebjlist&cid=" + $("#T_companyid").val() + "&bid=" + $("#T_budgeid").val() + '&bjlist=' + bjid + '&rdm=' + Math.random(),
                    success: function (data) {
                        // alert(bjid);
                        var url = '../../data/Budge.ashx?Action=tree&bid=' + $("#T_budgeid").val() + '&rnd=' + Math.random();

                        treemanager.clear();
                        treemanager.loadData(0, url, "");
                        dialog.close();
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        dialog.frame.f_error();
                    }
                });

            }
        }
        //ģ�屣��
        function f_savemb() {
            if ($("#T_budge_name").val() == "") {
                $.ligerDialog.error("������һ����Ч�������ƣ�����");
                return;
            }
            var sendtxt = "&Action=saveallmb";
            return $("form :input").fieldSerialize() + sendtxt;
        }
        //���һ��ȫ������
        function f_save() {
            if ($("#T_companyid").val() == "" || $("#T_budge_name").val() == "") {
                $.ligerDialog.error("��ѡ�񱣴�һ����Ч�Ŀͻ����������ƣ�����");
                return;
            }
            var sendtxt = "&Action=saveall";
            return $("form :input").fieldSerialize() + sendtxt;
        }
        //�����˻�
        function f_saveretrn() {
            if ($("#T_companyid").val() == "") {
                $.ligerDialog.error("��ѡ�񱣴�һ����Ч�Ŀͻ�������");
                return;
            }
            var sendtxt = "&Action=saveupdatestatus&status=0&bid=" + $("#T_budgeid").val() + "&cid=" + $("#T_companyid").val();
            return sendtxt;
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
            if (getparastr("style") == "aprCustOK")//�ͻ�ȷ�����
                sta = 3; 
            if (getparastr("style") == "cancel")//����
                sta = 99;
            if (getparastr("status") == "1") sta = 0;//����
            var sendtxt = "&Action=saveupdatestatus&status=" + sta + "&bid=" + $("#T_budgeid").val() + "&cid=" + $("#T_companyid").val();
            return sendtxt;
        }
        //�洢ģ��
        function savemodel() {
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
        function f_savemodel(item, dialog) {
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
        function selectmodel() {
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
        function f_selectmodel(item, dialog) {
            if (!dialog.frame.f_selectMB()) {
                alert('��ѡ����!');
                return;
            }
            var rows = dialog.frame.f_selectMB();
            // alert(rows.id);
            $.ajax({
                url: "../../data/Budge.ashx", type: "POST",
                data: { Action: "savemodeltobudge", bid: $("#T_budgeid").val(), modelid: rows.id, rnd: Math.random() },
                success: function (responseText) {
                    top.$.ligerDialog.closeWaitting();
                    if (responseText == "false") {
                        dialog.frame.f_error();
                        // top.top.$.ligerDialog.error('����ʧ�ܣ����ȼ���ģ���Ƿ�����ȷ��ϸ��');
                    }
                    else {
                        $("#T_mblx").val(rows.ModelStyle);//���ú����ͱ�Ϊ���õ�ģ������
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
        function addzk() {

            if ($("#T_zk").val() <= 0) {
                top.$.ligerDialog.error('�ۿ۱������0��');
                return;
            }
            var sl = $("#T_sl").val();
            if (sl == "") sl = 0;
            var url = '../../data/Budge.ashx?Action=saveupdatedisprice&bid=' + $("#T_budgeid").val() + "&zk=" + $("#T_zk").val() + '&sl=' + sl + '&rdm=' + Math.random();
            $.ajax({
                type: 'post',
                url: url,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    // alert(obj.sj); //String ���캯��
                    $("#T_zjezk").val(toMoney(obj.b_zkzje));
                    $("#T_sj").val(toMoney(obj.sj));
                    $("#T_zje").val(toMoney(obj.zje));
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.ligerDialog.error("������󣡣���");

                }
            });

        }
        //ˢ�¼۸��Ϊ���¼���
        function refreshprice() {

            var issave = $("form :input").fieldSerialize() + "&Action=saveall";
            $.ajax({
                url: "../../data/Budge.ashx", type: "POST",
                data: issave,
                success: function (responseText) {
                    top.$.ligerDialog.closeWaitting();
                    if (responseText == "false") {
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    }
                    else {
                        //  alert(issave); 
                        loadForm(getparastr("bid"));
                        f_reload();
                    }
                },
                error: function () {
                    top.$.ligerDialog.closeWaitting();

                }
            });
            //var url = '../../data/Budge.ashx?Action=saveupdaterefprice&bid=' + $("#T_budgeid").val() + '&rdm=' + Math.random();
            //$.ajax({
            //    type: 'post',
            //    url: url,

            //    success: function (data) {
            //        if (data == 'true')
            //            fload();
            //        else $.ligerDialog.error("������󣡣���");
            //    },
            //    error: function (XMLHttpRequest, textStatus, errorThrown) {
            //        $.ligerDialog.error("������󣡣���");

            //    }
            //});

        }
        //�ۿۣ�Ĭ�Ϻ��ֶ�
        function savetotal() {


            if ($("#T_sl").val() > 1 || $("#T_sl").val() < 0) {
                top.$.ligerDialog.error('˰�ʱ�����ڵ���0С��1��');
                return;
            }
            var t_sl = $("#T_sl").val();
            var t_zk = $("#T_zk").val();
            if (t_zk == "") t_zk == 1;
            $.ajax({
                type: "get",
                url: "../../data/Budge.ashx", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'savetotal', bid: getparastr("bid"), sl: t_sl, zk: t_zk, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    var obj = eval(result);

                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                    // alert(obj.sj); //String ���캯��
                    $("#T_zjezk").val(toMoney(obj.b_zkzje));
                    $("#T_sj").val(toMoney(obj.sj));
                    $("#T_zje").val(toMoney(obj.zje));


                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("����ʧ�ܣ����±��棡");
                }
            });

        }
        //���ӽ��
        function addfjje() {
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
        function fload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        }

        function view(id) {
            var dialogOptions = {
                width: 770, height: 510, title: "���ϵ���ͼ�Ľ���", url: '../view/product_view.aspx?pid=' + id + '&rnd=' + Math.random(), buttons: [
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
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
                <td colspan="11" class="table_title1">������Ϣ
                     
                </td>
                <td colspan="3"  class="table_title1"> 
                      <a id="qdkh" class="l-button red"  position="right" style="width:150px;" onClick="addcustomer()">
                          ȷ���ͻ�

                      </a>
          
                </td>
                  </tr>
            <tr>
                <td class="table_title1">
                    <div style="width: 70px; text-align: right; float: right">�ͻ���Ϣ��</div>
                </td>
                <td colspan="3" class="table_title1">
                         <input type="text" id="T_company" name="T_company"  ltype="text" ligerui="{width:250,disabled:true}" validate="{required:true}" />
                     <input id="T_companyid" name="T_companyid" type="hidden" />
                     <input id="T_version" name="T_version" type="hidden" />
                  
                    
                </td>
                
                <td class="table_title1">
                    <div style="width: 70px; text-align: right; float: right">Ԥ���ţ�</div>
                </td>
                <td colspan="3" class="table_title1">
                      <%--<input id="T_budgeid" name="T_budgeid" type="text" validate="{required:true}" style="width: 196px" />--%>
                    <input id="T_budgeid" name="T_budgeid" type="text" ltype="text" 
                        ligerui="{width:250,disabled:true}" validate="{required:false}" />

                </td>
                <td class="table_title1">
                    <div style="width: 70px; text-align: right; float: right">Ԥ�����ƣ�</div>
                </td>
                <td colspan="5" class="table_title1">
                    <input id="T_budge_name" name="T_budge_name" type="text" ltype="text" ligerui="{width:280}" validate="{required:false}" />                    <input id="T_employee1" name="T_employee1" type="hidden" />                </td>
             </tr>
             
            <tr    >
                <td class="table_title1">  <div style="width: 70px; text-align: right; float: right">�ܽ�</div></td>
                <td class="table_title1"><input type="text"  id="T_zje" name="T_zje"  ltype="text" ligerui="{width:80,disabled:true}"   /></td>
              <td class="table_title1"> <div style="width: 70px; text-align: right; float: right">������</div></td>
              <td class="table_title1"><input type="text"  id="T_zje2" name="T_zje2"  ltype="text" ligerui="{width:80,disabled:true}"   /></td>
                <td class="table_title1"><div style="width: 70px; text-align: right; float: right">���Ľ�</div></td>
                <td class="table_title1"><input type="text"  id="T_zje3" name="T_zje3"  ltype="text" ligerui="{width:80,disabled:true}"   /></td>
                <td class="table_title1"><div style="width: 70px; text-align: right; float: right">���ӽ�</div></td>
                <td class="table_title1"><input type="text"  id="T_fjje" name="T_fjje"  ltype="text" ligerui="{width:80,disabled:true}"   /></td>
          
               <td colspan="6" id="tr_contact4" class="table_title1">
                   <table class="table_title1"><tr>
                        <td><div style="width: 60px; text-align: right; float: right">˰��</div></td>
               <td><input type="text"  id="T_sj" name="T_sj"  ltype="text" ligerui="{width:60,disabled:true}"   /></td>
               <td><div style="width: 60px; text-align: right; float: right">˰�ʣ�</div></td> <td><input type="text"  id="T_sl" name="T_sl"  ltype="text" ligerui="{width:60,number: true}"   />
               </td>
                       <td>&nbsp;</td> <td>&nbsp;</td>
                       <td><a id="A5" class="l-button"  position="right" style="width:60px;" onClick="savetotal()">
                          ����˰��

                      </a></td>
                          </tr></table>

           </td> 
                 </tr>
               <tr>
                 <td   class="table_title1"><div style="width: 70px; text-align: right; float: right">��ע��</div></td>
                 <td colspan="7"   class="table_title1"><input id="T_remarks" name="T_remarks" type="text" ltype="text"  ligerui="{width:550}" /></td>
                 <td   class="table_title1"><span style="width: 60px; text-align: right; float: right">ҵ��Ա��</span></td>
                 <td   class="table_title1"><input id="T_employee" name="T_employee" validate="{required:false}"  ltype="text" ligerui="{width:60,disabled:true}"  /></td>
                 <td   class="table_title1"><span style="width: 60px; text-align: right; float: right">���ʦ��</span></td>
                 <td colspan="3"  class="table_title1" ><input id="T_employee2" name="T_employee2" validate="{required:false}"  ltype="text" ligerui="{width:60,disabled:true}"  /></td>
               </tr>
               <tr id="tr2">
                <td   class="table_title1">ά����Ϣ
                     
                </td>
                   <td colspan="3"   class="table_title1">
                           
                 <input id="T_mblx" name="T_mblx" value="����ģ��" type="hidden"/>
                       <table >
                           <tr id="tbmb">
                           <td>
                        <a id="A2" class="l-button"  position="right" style="width:80px;" onClick="savemodel()">
                          ����ģ�� </a>
                     </td><td>
                      <a id="A3" class="l-button"  position="right" style="width:80px;" onClick="selectmodel()">
                          ����ģ��

                      </a>
                    </td>
                     </tr>
                           
                       </table>
                </td><td   class="table_title1">  <a id="A4" class="l-button"  position="right" style="width:80px;" onClick="refreshprice()">
                          ���¼��� </a>
                     
                </td><td colspan="3"   class="table_title1"> 
                        <table><tr>
                           <td>&nbsp;</td><td>
                               <table>
                                   <tr><td>
                      <a id="A7" class="l-button"  position="right" style="width:80px;" onClick="addfjje()">
                          ��Ӹ��ӷ���

                      </a></td>
                                       <td> 
                         <div id="tipfjje" class="abcd" style="width:-30px;height:15px">
                             <table  class="abcde" >
                             <tr>
                                        <TD colspan="3">���ӷ���ϸ</td>
                                        </tr>
                              <tr>
                               
                                       <TD width="40%">��Ŀ</td>
                                        <TD width="40%">����</td>
                                        <TD width="20%">���</td>
                         
                                   </tr>

                             </table>
                         </div>
                             </td>  </tr>    </table>
                    </td>
                     </tr></table>
                </td>
                   <td colspan="2"    class="table_title1"> 
           <table id="zk1">
               <tr>
                   <td>
                          �ۿ۽��:
                   </td>
                   <td>

                      <input type="text"  id="T_zjezk" name="T_zjezk"  ltype="text" ligerui="{width:80,disabled:true}"

                   </td>
               </tr>
           </table>
                   
                     </td>
                <td colspan="4"   class="table_title1">
                    <table id="zk2">
                  <tr>
                    <td><input type="text"  value="1" id="T_zk" name="T_zk"  ltype="text" ligerui="{width:40,number: true}"   /></td>
                    <td><a id="A1" class="l-button"  position="right" style="width:50px;" onClick="addzk()"> ����</a></td>
                   <td> <span class="red">(0.9=���ۣ�</span> </td>
                  </tr>
                </table></td>
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
