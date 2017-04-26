<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />

    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
      <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>

    <script type="text/javascript">
        var manager = "";
        var treemanager;
        $(function () {
            //style=0 ���ϣ�1Ԥ��
            $("#layout1").ligerLayout({ leftWidth: 100, allowLeftResize: false, allowLeftCollapse: true, space: 2, heightDiff: -1 });
            $("#tree1").ligerTree({
                url: "../data/smsmodel.ashx?Action=tree&parentid=22&rnd=" + Math.random(),
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

            $("#maingrid4").ligerGrid({
                columns: [
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                    { display: '����', name: 'title', width: 150 },
                 {
                     display: '����', name: 'modelname', align: 'left', width: 250, render: function (item) {
                         var html = "<div class='abc'> ";
                         if (item.modelname)
                             html += item.modelname;
                         html += " </div>";
                         return html;
                     }
                 },
                
                    { display: '����(@P1)', name: 'para1', width: 70 },
                   { display: '����(@P2)', name: 'para2', width: 70 },
                      { display: '����(@P3)', name: 'para3', width: 70 },
                         { display: '����(@P4)', name: 'para4', width: 70 },
                            { display: '����(@P5)', name: 'para5', width: 70 },
                            { display: '����(@P6)', name: 'para6', width: 70 },
                      { display: 'ģ�����', name: 'SmsCode', width: 70 },
                    { display: '��ע', name: 'remarks', width: 120 }

                ],
                dataAction: 'server',
              
                url: "../../data/smsmodel.ashx?Action=grid&params_id=0&rnd=" + Math.random(),
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                width: '100%',
                height: '100%',
                heightDiff: -1,
                checkbox: false        , name:"ischecked", checkboxAll:false, isChecked: f_isChecked, onCheckRow: f_onCheckRow, onCheckAllRow: f_onCheckAllRow,
                onContextmenu: function (parm, e) {
                    actionproduct_id = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
                , onAfterShowData: function (grid) {
                $(".abc").hover(function (e) {
                    $(this).ligerTip({ content: $(this).text(), width: 300, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                }, function (e) {
                    $(this).ligerHideTip(e);
                });
            },
            });
            toolbar();
            $("#maingrid4 .l-grid-hd-cell-btn-checkbox").hide();
        });
        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=201&rnd=" + Math.random(), function (data, textStatus) {
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
                items.push({ line: true });
                items.push({
                    type: 'button',
                    text: '����',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        doserch()
                    }
                });
                $("#toolbar").ligerToolBar({
                    items: items

                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
               
                $("#keyword1").ligerTextBox({ width: 200, nullText: "����ؼ�������" })
                $("#maingrid4").ligerGetGridManager().onResize();
            });
        }

        function onSelect(note) {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.showData({ Rows: [], Total: 0 });
            var url = "../../data/smsmodel.ashx?Action=grid&params_id=" + note.data.id + "&rnd=" + Math.random();
            manager.GetDataByURL(url);
            checkedID = [];
        }
        //��ѯ
        function doserch() {
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;

            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/smsmodel.ashx?" + serchtxt);
        }

        //����
        function doclear() {
            //var serchtxt = $("#serchform :input").reset();
            $("#form1").each(function () {
                this.reset();
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
       

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            //alert(JSON.stringify(rows))
            if (rows)
                f_openWindow('system/smsmodel_add.aspx?id=' + rows.id, "�޸�ģ��", 650, 500);
            else
                $.ligerDialog.warn('��ѡ��ģ�壡');
        }

        function add() {
            var notes = $("#tree1").ligerGetTreeManager().getSelected();

            if (notes != null && notes != undefined) {
                f_openWindow('system/smsmodel_add.aspx?params_id=' + notes.data.id, "����ģ��", 650, 500);
            }
            else {
                $.ligerDialog.warn('��ѡ��ģ�����');
            }
        }

        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            //alert(JSON.stringify(rows))
            if (rows) {
                $.ligerDialog.confirm("ģ��ɾ�����ָܻ���ȷ��ɾ����", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/smsmodel.ashx", type: "POST",
                            data: { Action: "del", id: rows.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    f_load();
                                }
                                 
                                else {
                                    top.$.ligerDialog.closeWaitting();
                                    top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                                }
                            },
                            error: function () {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                            }
                        });
                    }
                })
            }
            else
                $.ligerDialog.warn('��ѡ��ģ�壡');
        }

        function sendsms() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
           // alert(JSON.stringify(rows))
            if (rows) {
                top.$.ligerDialog.open({
                    zindex: 9003,
                    title: '���Ƿ���-' + rows.title, width: 650, height: 500,

                    //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                    url: "system/sendsmsmodel.aspx?id=" + rows.id+"&name=" + encodeURI(rows.modelname), buttons: [
                        { text: '���Ͷ���', onclick: f_sendsmsOK },
                        { text: '�ر�', onclick: f_selectContactCancel }
                    ]
                });
            }
        }
        function f_sendsmsOK(item, dialog) {
            dialog.frame.f_save();

        }
        function f_selectContactCancel(item, dialog) {
            dialog.close();
            //fload();
        }
        //function prt() {
        //    var manager = $("#maingrid4").ligerGetGridManager();
        //    var rowid = checkedID.join(',');
        //    if (rowid.length > 0)
        //        ViewwStyle(rowid);
        //        //print_openWindow("crm/product/Product_QrCode_Print.aspx?id=" + rowid, "��ӡ��Ʒ", 700, 700);
        //       //window.open("Product_QrCode_Print.aspx?id=" + rowid,"_blank", 'top=0, left=0, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=n o, status=no');
        //     else
        //        $.ligerDialog.warn('��ѡ���Ʒ��');
        //}

        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
               
                top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                $.ajax({
                    url: "../../data/smsmodel.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        
                            dialog.close();
                            top.$.ligerDialog.closeWaitting();
                            f_load();
                        
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('����ʧ�ܣ�');
                    }
                });

            }
        }
        function f_load() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);

            //treemanager = $("#tree1").ligerGetTreeManager();
            //treemanager.clear();
            //treemanager.FlushData();
        }

        /*
        ����ҳ��ѡ
        ������onCheckRow��ѡ�е��м���������������isChecked�������������г�ʼ��ѡ��
        */
        var checkedID = [];
        function f_onCheckAllRow(checked) {
            for (var rowid in this.records) {
                if (checked)
                    addcheckedID(this.records[rowid]['id']);
                else
                    removecheckedID(this.records[rowid]['id']);
            }
        }
        function findcheckedID(product_id) {
            for (var i = 0; i < checkedID.length; i++) {
                if (checkedID[i] == product_id) return i;
            }
            return -1;
        }
        function addcheckedID(product_id) {
            if (findcheckedID(product_id) == -1)
                checkedID.push(product_id);
        }
        function removecheckedID(product_id) {
            var i = findcheckedID(product_id);
            if (i == -1) return;
            checkedID.splice(i, 1);
        }
        function f_isChecked(rowdata) {
            if (findcheckedID(rowdata.product_id) == -1)
                return false;
            return true;
        }
        function f_onCheckRow(checked, data) {
            if (checked) addcheckedID(data.product_id);
            else removecheckedID(data.product_id);
        }
    </script>
</head>
<body style="padding: 0px;overflow:hidden;">
    <form id="form1" onsubmit="return false">
        <div id="layout1" style="margin: -1px">
      <div position="left" title="ģ�����">
                <div id="treediv" style="width: 250px; height: 100%; margin: -1px; float: left; border: 1px solid #ccc; overflow: auto;">
                    <ul id="tree1"></ul>
                </div>
            </div>
            <div position="center">
                <div id="toolbar"></div>
                <div id="maingrid4" style="margin: -1px;"></div>
            </div>
        </div>
    </form>
</body>
</html>
