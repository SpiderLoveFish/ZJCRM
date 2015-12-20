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
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>

    <script type="text/javascript">
        var manager = "";
        var treemanager;
        $(function () {
            $("#layout1").ligerLayout({ leftWidth: 200, allowLeftResize: false, allowLeftCollapse: true, space: 2, heightDiff: -1 });
            $("#tree1").ligerTree({
                url: '../../data/crm_CEStage_category.ashx?Action=tree&rnd=' + Math.random(),
                onSelect: onSelect,
                idFieldName: 'id',
                nameFieldName: 'CEStage_category',
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
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                    //{
                    //    display: '', width: 40, render: function (item) {
                    //        var html = "<a href='javascript:void(0)' onclick=view(" + item.CEStage_id + ")>��ϸ</a>"
                    //        return html;
                    //    }
                    //},
                    //{
                    //    display: '', width: 50, render: function (item) {
                    //        var html = "<a href='javascript:void(0)' onclick=QrCode(" + item.CEStage_id + ")>��ά��</a>"
                    //        return html;
                    //    }
                    //},
                    //{
                    //    display: '��ַ', width: 50, render: function (item) {
                    //        var html;
                    //        if (item.url != "" && item.url != null) {
                    //            html = "<a href='" + item.url + "' target='_blank'>";
                    //            html += "�鿴";
                    //            html += "</a>";
                    //        }
                    //        else
                    //            html = "��";
                    //        return html;
                    //    }
                    //},
                    { display: '���ͱ��', name: 'StageID', width: 120 },
                  
                     { display: '��ϸ���', name: 'StageDetailID', width: 120 },
                  
                    { display: '������ϸ����', name: 'Description', width: 300 }
                    //{ display: '�������', name: 'category_name', width: 120 },
                    //{ display: '���˹��', name: 'specifications', width: 120 },
                    //{
                    //    display: '�۸񣨣���', name: 'price', width: 120, align: 'right', render: function (item) {
                    //        return toMoney(item.price);
                    //    }
                    //},
                    //{ display: '��λ', name: 'unit', width: 40 },
                    //{ display: '��ע', name: 'remarks', width: 120 }

                ],
                dataAction: 'server',
                url: "../../data/CRM_CEStageDetail.ashx?Action=grid&categoryid=0&rnd=" + Math.random(),
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                width: '100%',
                height: '100%',
                heightDiff: -1,
                onContextmenu: function (parm, e) {
                    actionCEStage_id = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });
            toolbar();
            $("#maingrid4 .l-grid-hd-cell-btn-checkbox").hide();
        });
        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=134&rnd=" + Math.random(), function (data, textStatus) {
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
                $("#stext").ligerTextBox({ width: 200 });
                $("#maingrid4").ligerGetGridManager().onResize();
            });
        }

        function onSelect(note) {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.showData({ Rows: [], Total: 0 });
            var url = "../../data/CRM_CEStageDetail.ashx?Action=grid&categoryid=" + note.data.id + "&rnd=" + Math.random();
            manager.GetDataByURL(url);
            checkedID = [];
        }
        //��ѯ
        function doserch() {
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;

            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/CRM_CEStageDetail.ashx?" + serchtxt);
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
            var row = manager.getSelectedRow();
            if (row) {

                f_openWindow('crm/ConsExam/CEStage_Detail_add.aspx?categoryid=' + row.StageID + '&catname=' + row.Description + '&catdetailid=' + row.StageDetailID, "�޸Ŀ���", 790, 500);
            }
            else
                $.ligerDialog.warn('��ѡ�񿼺ˣ�');
        }

        function add() {
            var notes = $("#tree1").ligerGetTreeManager().getSelected();

            if (notes != null && notes != undefined) {
                f_openWindow('crm/ConsExam/CEStage_Detail_add.aspx?categoryid=' + notes.data.id+'&catname='+notes.data.text, "��������", 790, 500);
            }
            else {
                $.ligerDialog.warn('��ѡ�񿼺����');
            }
        }

        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("����ɾ�����ָܻ���ȷ��ɾ����", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/CRM_CEStageDetail.ashx", type: "POST",
                            data: { Action: "del", stageid: row.StageID, stagedetailid: row.StageDetailID, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    f_load();
                                }
                                else if (responseText == "false:CEDetail") {
                                    top.$.ligerDialog.error('�˿����º��ж�����Ϣ��������ɾ����');
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
                $.ligerDialog.warn('��ѡ�񿼺ˣ�');
        }

        
         
        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                $.ajax({
                    url: "../../data/CRM_CEStageDetail.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
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

        
    </script>
</head>
<body style="padding: 0px;overflow:hidden;">
    <form id="form1" onsubmit="return false">
        <div id="layout1" style="margin: -1px">
            <div position="left" title="�������">
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
