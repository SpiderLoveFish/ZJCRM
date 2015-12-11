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
                     { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowid + 1; } },
                      { display: '��Ŀ���', name: 'id', width: 50, align: 'left' },
                      { display: '�ͻ����', name: 'CustomerID', width: 50, align: 'left' },
                       { display: '�ͻ�����', name: 'CustomerName', width: 250, align: 'left' },
                        { display: '�ͻ��绰', name: 'tel', width: 120, align: 'left' },
                       { display: 'ʩ������', name: 'sgjl', width: 120, align: 'left' },
                         { display: 'ҵ��Ա', name: 'ywy', width: 120, align: 'left' },
                     { display: '���ʦ', name: 'sjs', width: 120, align: 'left' },
                     { display: '����ӷ�', name: 'SpecialScore', width: 120, align: 'left' },
                 { display: '���˵÷�', name: 'StageScore', width: 120, align: 'left' },
                         { display: '״̬', name: 'Stage_icon', width: 120, align: 'left' },
                 { display: '��ע', name: 'Remarks', width: 120, align: 'left' }
                    
                ],

                    
                dataAction: 'server',
                url: "../../data/CRM_CEDetail.ashx?Action=grid", pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                width: '100%',
                height: '100%',
                heightDiff: -1,
              
                onRClickToSelect: true, 
                detail: {
                    onShowDetail: function (r, p) {
                        for (var n in r) {
                            if (r[n] == null) r[n] = "";
                        }
                        var grid = document.createElement('div');
                        $(p).append(grid);
                        $(grid).css('margin', 3).ligerGrid({
                            columns: [
                                    { display: '���', width: 30, render: function (item, i) { return i + 1; } },
                                     { display: '��Ŀ���', name: 'projectid', width: 60 },
                                      { display: '��������', name: 'CEStage_category', width: 120 },
                                    { display: '�汾��', name: 'versions', width: 60 },
                                     { display: '�������', name: 'isChecked', width: 80 },
                                       { display: '�Ƿ�᰸', name: 'IsClose', width: 80 },
                                    { display: '����', name: 'AssTime', width: 60, type: 'float' }
                                    
                            ],
                            usePager: false,
                            checkbox: false,
                            url: "../../data/CRM_CEDetail.ashx?Action=Acgrid&pid=" + r.id,
                            width: '99%', height: '100',
                            heightDiff: 0
                        })
                    }
                    
                }
            });
            toolbar();
            $("#maingrid4 .l-grid-hd-cell-btn-checkbox").hide();
        });
        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=124&rnd=" + Math.random(), function (data, textStatus) {
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
            var url = "../../data/Crm_CEDetail.ashx?Action=getstage&cid=" + note.data.id + "&rnd=" + Math.random();
            manager.GetDataByURL(url);
            checkedID = [];
        }
        //��ѯ
        function doserch() {
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;

            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Crm_CEDetail.ashx?" + serchtxt);
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
            var notes = $("#tree1").ligerGetTreeManager().getSelected();

            if (notes != null && notes != undefined) {

                var manager = $("#maingrid4").ligerGetGridManager();
                var row = manager.getSelectedRow();
                if (row) {

                    f_openWindow('crm/ConsExam/CEDetail_add.aspx?style=edit&sid=' + notes.data.id + '&pid=' + row.id + '&sname=' + notes.data.text, "�޸����ְ汾", 790, 400);
                }
                else
                    $.ligerDialog.warn('��ѡ�񿼺���Ŀ��');
            }
            else {
                $.ligerDialog.warn('��ѡ�񿼺����');
            }
        }

        function add() {
           

            var notes = $("#tree1").ligerGetTreeManager().getSelected();

            if (notes != null && notes != undefined) {
               // url: "../../data/CRM_CEDetail.ashx?Action=grid", pageSize: 30,
                var manager = $("#maingrid4").ligerGetGridManager();
                var row = manager.getSelectedRow();
                if (row) {
                    f_openWindow('crm/ConsExam/CEDetail_add.aspx?style=add&sid=' + notes.data.id + '&pid=' + row.id + '&sname=' + notes.data.text, "�������ְ汾", 790, 400);
                }
                else
                    $.ligerDialog.warn('��ѡ�񿼺���Ŀ��');
                }
            else {
                $.ligerDialog.warn('��ѡ�񿼺����');
            }
        }
   
     

        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                $.ajax({
                    url: "../../data/CRM_CEDetail.ashx", type: "POST",
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
        function IsExistVer(stageid, projectid, verid) {
            //top.$.ligerDialog.error("11");
            $.ajax({
                url: "../../data/Crm_CEDetail.ashx", type: "POST", /* ע���������ֶ�ӦCS�ķ������� */
                data: { Action: 'IsExistVer', sid: stageid, pid: projectid, vid: verid, rnd: Math.random() }, /* ע������ĸ�ʽ������ */
                success: function (responseText) {
                    if (responseText == "false") {
                        return false;
                    }
                    else {
                        return true;
                    }

                },

                error: function () {
                    return false;
                }


            }
             );
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
