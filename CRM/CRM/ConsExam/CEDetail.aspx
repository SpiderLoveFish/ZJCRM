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
        var InitSid = 1;//��ʱĬ��ֵ
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
                  //  InitSid = onselect.id;//��ȡĬ��ֵ
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
      { display: '�ͻ�����', name: 'CustomerName', width: 80, align: 'left' },
                       { display: '�ͻ��绰', name: 'tel', width: 100, align: 'left' },
                        { display: '�ͻ���ַ', name: 'address', width: 250, align: 'left' },
                      { display: 'ʩ������', name: 'sgjl', width: 80, align: 'left' },
                        { display: 'ҵ��Ա', name: 'ywy', width: 80, align: 'left' },
                   // { display: '���ʦ', name: 'sjs', width: 120, align: 'left' },
                    { display: '���ӷ�', name: 'SpecialScore', width: 50, align: 'right' },
                {
                    display: '���˷�', name: 'StageScore', width: 50, align: 'right', render: function (item) {
                        return "<div style='color:#135294'>" + item.StageScore + "</div>";
                    }
                },
                 { display: '�ܵ÷�', name: 'sum_Score', width: 50, align: 'right' },
                 { display: '����', name: 'TotalScorce', width: 50, align: 'right' },
                 {
                     display: '�����', name: 'Scoring', width: 80, align: 'right', render: function (item) {

                         var html;
                         if (item.sum_Score / item.TotalScorce > 0.9) {
                             html = "<div style='color:#008040'>";
                             if (item.Scoring)
                                 html += item.Scoring;
                             html += "</div>";
                         }
                         else
                             if (item.sum_Score / item.TotalScorce > 0.5) {
                                 html = "<div style='color:#800040'>";
                                 if (item.Scoring)
                                     html += item.Scoring;
                                 html += "</div>";
                             }
                             else
                                 html = "<div style='color:#F00'>" + item.Scoring + "</div>";
                         return html;
                     }
                 },
                        { display: '״̬', name: 'Stage_icon', width: 80, align: 'left' },
                { display: '��ע', name: 'Remarks', width: 200, align: 'left' }

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
                                   // { display: '�汾��', name: 'versions', width: 60 },
                                    // { display: '�������', name: 'isChecked', width: 80 },
                                      // { display: '�Ƿ�᰸', name: 'IsClose', width: 80 },
                                    { display: '���˽��', name: 'AssTime', width: 60, type: 'float' },
                                     { display: '����ʱ��' + r.id, name: 'Cdate', width: 100, type: 'date' }
                                    
                            ],
                            usePager: false,
                            checkbox: false,
                            url: "../../data/CRM_CEDetail.ashx?Action=Acgrid&pid=" + r.id + "&sid=" + InitSid,
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
                items.push({
                    type: 'serchbtn',
                    text: '�߼�����',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        serchpanel();
                    }
                });
                //items.push({ type: 'textbox', id: 'khstext', text: '�ͻ���' });
                //items.push({ type: 'textbox', id: 'dzstext', text: '��ַ��' });
                //items.push({ type: 'textbox', id: 'dhstext', text: '�绰��' });
                //items.push({ type: 'textbox', id: 'sgstext', text: 'ʩ������' });
                //items.push({ type: 'textbox', id: 'ztstext', text: '״̬��' });
                //items.push({ type: 'textbox', id: 'dclbstext', text: '�����(��Χ)��' });
                //items.push({ type: 'textbox', id: 'dclestext', text: '~��' });
                //items.push({ type: 'button', text: '����', icon: '../../images/search.gif', disable: true, click: function () { doserch() } });

                $("#toolbar").ligerToolBar({
                    items: items

                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
                //$("#khstext").ligerTextBox({ width: 200 });
                //$("#dzstext").ligerTextBox({ width: 200 });
                //$("#dhstext").ligerTextBox({ width: 200 });
                //$("#sgstext").ligerTextBox({ width: 200 });
                //$("#ztstext").ligerTextBox({ width: 200 });
                //$("#dclbstext").ligerTextBox({ width: 200 });
                //$("#dclestext").ligerTextBox({ width: 200 });
                $("#maingrid4").ligerGetGridManager().onResize();
            });
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
            
        }
        function initSerchForm() {
        }


        function onSelect(note) {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.showData({ Rows: [], Total: 0 });
            InitSid = note.data.id;
            var sendtxt = "&Action=getstage&cid=" + note.data.id + "&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
            // alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            //var url = "../../data/Crm_CEDetail.ashx?Action=getstage&cid=" + note.data.id + "&rnd=" + Math.random();
         
            manager.GetDataByURL("../../data/Crm_CEDetail.ashx?" + serchtxt);
            checkedID = [];
        }
        //��ѯ
        function doserch() {
            var sendtxt = "&Action=getstage&cid="+InitSid+"&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
           // alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Crm_CEDetail.ashx?" + serchtxt);
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

                    f_openWindow('crm/ConsExam/CEDetail_add.aspx?style=edit&sid=' + notes.data.id + '&pid=' + row.id + '&sname=' + notes.data.text, "�޸Ŀ���", 790, 550);
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
                    f_openWindow('crm/ConsExam/CEDetail_add.aspx?style=add&sid=' + notes.data.id + '&pid=' + row.id + '&sname=' + notes.data.text, "��ʼ����", 790, 550);
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
        function doclear() {
            //var serchtxt = $("#serchform :input").reset();
            $("#serchform").each(function () {
                this.reset();
                $(".l-selected").removeClass("l-selected");
            });
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
       <div class="az">
        <form id='serchform'>
            <table style='width: 960px' class="bodytable1">
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�ͻ�������</div>
                    </td>
                    <td>
                        <input type='text' id='khstext' name='khstext' ltype='text' ligerui='{width:120}' /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�ͻ���ַ��</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='dzstext' name='dzstext' />
                        </div>
                    
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�ͻ��绰��</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='dhstext' name='dhstext'   ligerui='{width:97}' />
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
                        <div style='width: 60px; text-align: right; float: right'>ʩ������</div>
                    </td>
                    <td>
                        <input id='sgjlstext' name="sgjlstext" type='text' /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>״̬��</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='ztstext' name='ztstext' />
                        </div>
                         
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>����ʣ�</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='dclbstext' name='dclbstext'   ligerui='{width:97}' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='dclestext' name='dclestext'   ligerui='{width:96}' />
                        </div>
                    </td>

                </tr>
            
            </table>
        </form>
    </div>

</body>
</html>
