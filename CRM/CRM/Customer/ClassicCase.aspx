<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=7" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
        <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script type="text/javascript">
        var manager;
        var manager1;
        $(function () {

            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            $("#maingrid4").ligerGrid({
                columns: [
                    {
                        display: '���', width: 30, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                        { return (page - 1) * pagesize + rowindex + 1; }
                    },
                 
                    {
                        display: '����', name: 'Customer', width: 50, align: 'left', render: function (item) {
                            var html = "<a href='javascript:void(0)' onclick=view(1," + item.id + ")>";
                            if (item.Customer)
                                html += item.Customer;
                            html += "</a>";
                            return html;
                        }
                    },
                    { display: '�Ա�', name: 'Gender', width: 40 },
                     {
                         display: '�绰', name: 'tel', align: 'left', width: 40, render: function (item) {
                             var html = "<div class='abc'>";
                             if (item.tel)
                                 html += item.tel;
                             html += "</div>";
                             return html;
                         }
                     },
                   {
                       display: '��ַ', name: 'address', align: 'left', width: 120, render: function (item) {
                           var html = "<div class='abc'>";
                           if (item.address)
                               html += item.address;
                           html += "</div>";
                           return html;
                       }
                   },
                    { display: 'С��', name: 'Community', width: 60 },
                  
             
                    {
                        display: '�ͻ�����', name: 'CustomerType', width: 60, align: 'right', render: function (item) {
                            return "<span><div  style='background:#" + item.setcolor + "'>" + item.CustomerType + "</div></span>";
                        }
                    },
                        {
                            display: '�ͻ�״̬', name: 'industry', width: 60, align: 'right', render: function (item) {
                                return "<span><div style='color:#" + item.indcolor + "'>" + item.industry + "</div></span>";
                            }
                        },
                             // { display: '�ͻ�״̬', name: 'industry', width: 80 },
                    { display: 'Ԥ���λ', name: 'CustomerLevel', width: 60 },
                    { display: '�ͻ���Դ', name: 'CustomerSource', width: 60 },
                    //{ display: 'ʡ��', name: 'Provinces', width: 80 },
                    //{ display: '����', name: 'City', width: 80 },
                    //{ display: '����', name: 'Towns', width: 80 },
                    //{ display: '¥��', name: 'BNo', width: 80 },
                    //{ display: '����', name: 'RNo', width: 80 },
                   
                   // { display: '����', name: 'Department', width: 80 },
                    { display: 'ҵ��Ա', name: 'Employee', width: 50 },
                    { display: '���ʦ', name: 'Emp_sj', width: 50 },
                    { display: 'ʩ������', name: 'Emp_sg', width: 60 },
                    { display: '����', name: 'privatecustomer', width: 40 },
     
                    {
                        display: '������', name: 'lastfollow', width: 90, render: function (item) {
                            var lastfollow = formatTimebytype(item.lastfollow, 'yyyy-MM-dd');
                            if (lastfollow == "1900-01-01")
                                lastfollow = "";
                            return lastfollow;
                        }
                    },
                    {
                        display: '����ʱ��', name: 'Create_date', width: 90, render: function (item) {
                            var Create_date = formatTimebytype(item.Create_date, 'yyyy-MM-dd');
                            return Create_date;
                        }
                    }
                ],
             
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/crm_customer.ashx?Action=grid&rnd=" + Math.random(),
                width: '100%', height: '65%',
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                } 
            });
           

            $("#grid").height(document.documentElement.clientHeight - $(".toolbar").height());
            $('form').ligerForm();
            toolbar();
        });

        function toolbar() {
            var url="../../data/toolbar.ashx?Action=GetSys&mid=189&rnd=" + Math.random();
            if(getparastr("apr")=="Y")url="../../data/toolbar.ashx?Action=GetSys&mid=190&rnd=" + Math.random();
            $.getJSON(url, function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
               
                items.push({
                    type: 'textbox',
                    id: 'keyword1',
                    name: 'keyword1',
                    text: ''
                });
                items.push({
                    type: 'button',
                    text: '����',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        doserch()
                    }
                });
               
                items.push({
                    type: 'serchbtn',
                    text: '�߼�����',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        serchpanel();
                    }
                });
                $("#toolbar").ligerToolBar({
                    items: items
                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });

            });
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=6&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                $("#toolbar1").ligerToolBar({
                    items: items
                });
                menu1 = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
                $("#stype").ligerComboBox({
                    width: 200,
                    isMultiSelect: true,
                    url: "../../data/param_sysparam.ashx?Action=combo&parentid=1&rnd=" + Math.random()
                })
                $("#keyword1").ligerTextBox({ width: 200, nullText: "����ؼ�������" })
                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();

            });
        }
        function initSerchForm() {
           
            //var a = $('#T_City').ligerComboBox({ width: 96, emptyText: '���գ�' });
            //var b = $('#T_Provinces').ligerComboBox({
            //    width: 97,

            //    url: "../../data/Param_City.ashx?Action=combo1&rnd=" + Math.random(),
            //    onSelected: function (newvalue) {
            //        $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
            //            a.setData(eval(data));
            //        });
            //    }, emptyText: '���գ�'
            //});

            b = $('#T_Towns').ligerComboBox({
                width: 97,
                //url: "../../data/Param_City.ashx?Action=combo&rnd=" + Math.random(),
                onSelected: function (newvalue, newtext) {
                    if (!newvalue)
                        newvalue = -1;
                    $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        a.setData(eval(data));
                        a.selectValue(obj.Community_id);
                    });
                }, emptyText: '���գ�'
            });
            c = $('#T_City').ligerComboBox({
                width: 97,
                //url: "../../data/Param_City.ashx?Action=combo&rnd=" + Math.random(),
                onSelected: function (newvalue, newtext) {
                    if (!newvalue)
                        newvalue = -1;
                    $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        b.setData(eval(data));
                        b.selectValue(obj.Towns_id);
                    });
                }, emptyText: '���գ�'
            });
            d = $('#T_Provinces').ligerComboBox({
                width: 97,
                url: "../../data/Param_City.ashx?Action=combo1&rnd=" + Math.random(),
                onSelected: function (newvalue, newtext) {
                    if (!newvalue)
                        newvalue = -1;
                    $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        c.setData(eval(data));
                        c.selectValue(obj.City_id);
                    });
                }, emptyText: '���գ�'
            });
            $('#customertype').ligerComboBox({ width: 97, emptyText: '���գ�', url: "../../data/Param_SysParam.ashx?Action=combo&parentid=1&rnd=" + Math.random() });
            $('#WXZHT').ligerComboBox({ width: 97, emptyText: '���գ�', url: "../../data/Param_SysParam.ashx?Action=combo&parentid=15&rnd=" + Math.random() });
            $('#customerlevel').ligerComboBox({ width: 96, emptyText: '���գ�', url: "../../data/Param_SysParam.ashx?Action=combo&parentid=2&rnd=" + Math.random() });
            $('#cus_sourse').ligerComboBox({ width: 120, emptyText: '���գ�', url: "../../data/Param_SysParam.ashx?Action=combo&parentid=3&rnd=" + Math.random() });
           // $('#T_Community').ligerComboBox({ width: 120, emptyText: '���գ�', url: "../../data/Param_City.ashx?Action=getBuilding&rnd=" + Math.random() });
            var gCommunity = $('#T_Community').ligerComboBox({
                width: 120,
                //initValue: obj.Community_id,
                url: "../../data/Param_City.ashx?Action=getBuilding&rnd=" + Math.random(),
                onBeforeOpen: f_selectComm

            });
            var e = $('#employee').ligerComboBox({ width: 96, emptyText: '���գ�' });
            var f = $('#department').ligerComboBox({
                width: 97,
                selectBoxWidth: 240,
                selectBoxHeight: 200,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    url: '../../data/hr_department.ashx?Action=tree&rnd=' + Math.random(),
                    idFieldName: 'id',
                    //parentIDFieldName: 'pid',
                    checkbox: false
                },
                onSelected: function (newvalue) {
                    $.get("../../data/hr_employee.ashx?Action=combo&did=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        e.setData(eval(data));
                    });
                }
            });

            var g = $('#employee_sg').ligerComboBox({ width: 96, emptyText: '���գ�' });
            var h = $('#department_sg').ligerComboBox({
                width: 97,
                selectBoxWidth: 240,
                selectBoxHeight: 200,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    url: '../../data/hr_department.ashx?Action=tree&rnd=' + Math.random(),
                    idFieldName: 'id',
                    //parentIDFieldName: 'pid',
                    checkbox: false
                },
                onSelected: function (newvalue) {
                    $.get("../../data/hr_employee.ashx?Action=combo&did=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        g.setData(eval(data));
                    });
                }
            });

            var k = $('#employee_sj').ligerComboBox({ width: 96, emptyText: '���գ�' });
            var l = $('#department_sj').ligerComboBox({
                width: 97,
                selectBoxWidth: 240,
                selectBoxHeight: 200,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    url: '../../data/hr_department.ashx?Action=tree&rnd=' + Math.random(),
                    idFieldName: 'id',
                    //parentIDFieldName: 'pid',
                    checkbox: false
                },
                onSelected: function (newvalue) {
                    $.get("../../data/hr_employee.ashx?Action=combo&did=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        k.setData(eval(data));
                    });
                }
            });
        }
        //¥��
        function f_selectComm() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: 'ѡ��¥��С��', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Customer/SelectCommunity.aspx", buttons: [
                    { text: 'ȷ��', onclick: f_selectCommOK },
                    { text: 'ȡ��', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectCommOK(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('��ѡ��¥��С��!');
                return;
            }
            filltempComm(data.id, data.Name);
            dialog.close();
        }
        function filltempComm(newvalue, text) {
            $('#T_Community_val').val(newvalue);
            $("#T_Community").val(text)
        }
        function serchpanel() {
            initSerchForm();
            if ($(".az").css("display") == "none") {
                $("#grid").css("margin-top", $(".az").height() + "px");
                $("#maingrid4").ligerGetGridManager().onResize(); 
            }
            else {
                $("#grid").css("margin-top", "0px");
                $("#maingrid4").ligerGetGridManager().onResize(); 
            }
            $("#company").focus();
        }
        $(document).keydown(function (e) {
            if (e.keyCode == 13 && e.target.applyligerui) {
                doserch();
            }
        });
        function doserch() {
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var stxt = $("#form1 :input").fieldSerialize();

            var serchtxt = $("#serchform :input").fieldSerialize() + "&" + stxt + sendtxt;
             //alert(serchtxt);           
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/crm_customer.ashx?" + serchtxt);

        }
        function doclear() {
            //var serchtxt = $("#serchform :input").reset();
            $("#serchform").each(function () {
                this.reset();
                $(".l-selected").removeClass("l-selected");
            });
        }

        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '����', onclick: function (item, dialog) {
                                f_save(item, dialog);
                            }
                        },
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function toimport() {
            var dialogOptions = {
                width: 540, height: 295, title: '�ͻ�����', url: 'crm/customer/customer_import.aspx', buttons: [
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function add() {
            f_openWindow("CRM/Customer/Customer_add.aspx", "�����ͻ�", 660, 550);
        }

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('CRM/Customer/Customer_add.aspx?cid=' + row.id, "�޸Ŀͻ�", 660, 550);
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }
        function apr() {  
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('CRM/Customer/Customer_add.aspx?cid=' + row.id, "�޸Ŀͻ�", 660, 550);
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }
        //�˻�
        function ret() {
        }
        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("ȷ����������", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/CRM_Customer.ashx", type: "POST",
                            data: { Action: "AdvanceDelete", id: row.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    f_reload();
                                    f_followreload();
                                }
                                else if (responseText == "delfalse") {
                                    top.$.ligerDialog.error('Ȩ�޲�����ɾ��ʧ�ܣ�');
                                }
                                else if (responseText == "false") {
                                    top.$.ligerDialog.error('δ֪����ɾ��ʧ�ܣ�');
                                }
                                else {
                                    top.$.ligerDialog.warn('�˿ͻ��º��� ' + responseText + '��ɾ��ʧ�ܣ������Ƚ���Щ����ɾ����');
                                }

                            },
                            error: function () {
                                top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                            }
                        });
                    }
                });
            }
            else {
                $.ligerDialog.warn("��ѡ��ͻ�");
            }
        }
         f_save(item, dialog) {
            var issave = dialog.frame.f_save();
        
            if (issave) {
                dialog.close();

                $.ajax({
                    url: "../../data/CRM_Customer.ashx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                    },
                    success: function (responseText) {

                        f_reload();
                        top.flushiframegrid("tabid5");
                    },
                    error: function () {
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    },
                    complete: function () {
                        top.$.ligerDialog.closeWaitting();
                    }
                });

            }
        }
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        };

        //follow
    
    </script>
    <style type="text/css">
        .l-treeleve1 {
            background: yellow;
        }

        .l-treeleve2 {
            background: yellow;
        }

        .l-treeleve3 {
            background: #eee;
        }
    </style>
</head>
<body>
    <form id="form1" onsubmit="return false">
        <div id="toolbar"></div>

        <div id="grid">
            <div id="maingrid4" style="margin: -1px; min-width: 800px;"></div>
            <div id="toolbar1"></div>
            <div id="Div1" style="position: relative;">
                <div id="maingrid5" style="margin: -1px -1px;"></div>
            </div>
        </div>


    </form>
    <div class="az">
        <form id='serchform'>
            <table style='width: 960px' class="bodytable1">
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�ͻ�������</div>
                    </td>
                    <td>
                        <input type='text' id='company' name='company' ltype='text' ligerui='{width:120}' /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�ͻ����ͣ�</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='customertype' name='customertype' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='customerlevel' name='customerlevel' />
                        </div>
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>¼��ʱ�䣺</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='startdate' name='startdate' ltype='date' ligerui='{width:97}' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='enddate' name='enddate' ltype='date' ligerui='{width:96}' />
                        </div>
                    </td>
                    <td>
                        <input id='keyword' name="keyword" type='text' ltype='text' ligerui='{width:196, nullText: "����ؼ���������ַ����������ע"}' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>����¥�̣�</div>
                    </td>
                    <td>
                        <input id='T_Community' name="T_Community" type='text' /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>����ʡ�У�</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='T_Provinces' name='T_Provinces' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='T_City' name='T_City' />
                        </div>
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>��������</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='startfollow' name='startfollow' ltype='date' ligerui='{width:97}' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='endfollow' name='endfollow' ltype='date' ligerui='{width:96}' />
                        </div>
                    </td>

                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�绰��</div>
                    </td>
                    <td>
                        <input type='text' id='tel' name='tel' ltype='text' ligerui='{width:120}' />
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>��������</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='T_Towns' name='T_Towns' />
                        </div>

                    </td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>ҵ��Ա��</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='department' name='department' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='employee' name='employee' />
                        </div>
                    </td>
                    <td>

                        <input id='Button2' type='button' value='����' style='width: 80px; height: 24px'
                            onclick="doclear()" />
                        <input id='Button1' type='button' value='����' style='width: 80px; height: 24px' onclick="doserch()" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�ͻ���Դ��</div>
                    </td>
                    <td>
                        <input type='text' id='cus_sourse' name='cus_sourse' />
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>ʩ������</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='department_sg' name='department_sg' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='employee_sg' name='employee_sg' />
                        </div>
                    </td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>���ʦ��</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='department_sj' name='department_sj' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='employee_sj' name='employee_sj' />
                        </div>
                    </td>
                </tr>
                                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>΢��״̬��</div>
                    </td>
                    <td>
                        <input type='text' id='WXZHT' name='WXZHT' /> 
                    </td>
                                    <td>
                        <div style='width: 60px; text-align: right; float: right'>��ͼ״̬��</div>
                    </td>
                    <td>
                             <input id="t_mapstasus" name="t_mapstasus" type="text" ltype="select" ligerui="{width:196,data:[{id:'0',text:'ȫ��'},{id:'1',text:'�ѱ��ͼ'},{id:'2',text:'δ���ͼ'}]}"  /></td>
           
                     
                 
                    

                    <td>
                        <div style='width: 60px; text-align: right; float: right'></div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                           
                        </div>
                        <div style='width: 98px; float: left'>
                            
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <form id='toexcel'></form>
</body>
</html>
