<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" type="text/css" />

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
     <script src="../../lib/jquery.form.js" type="text/javascript"></script>
   <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/json2.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        var manager = "";
        $(function () {
            $("#maingrid4").ligerGrid({
                columns: [
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowid + 1; } },
                    // { display: '���', name: 'id', width: 50, align: 'left' },
                    // { display: '�ͻ����', name: 'CustomerID', width: 50, align: 'left' },
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
                 { display: '�����', name: 'Scoring', width: 80, align: 'right',  render: function (item) {

                     var html;
                     if (item.sum_Score / item.TotalScorce >0.9) {
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
                dataAction: 'local',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/Crm_CEStage.ashx?Action=grid",
                width: '100%',
                height: '100%',
                //tree: { columnName: 'StageDescription' },
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }

            });

            

            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            toolbar();
        });
        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=135&rnd=" + Math.random(), function (data, textStatus) {
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
                $("#toolbar").ligerToolBar({
                    items: items

                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
                
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
            $("#khstext").addClass("l-text");
            $("#dzstext").addClass("l-text");
            $("#dhstext").addClass("l-text");
            $("#sgjlstext").addClass("l-text");
            $("#ztstext").ligerComboBox({ width: 100 })
            //$("#dclbstext").ligerTextBox({ width: 100 });

            $("#dclbstext").addClass("l-text");
            $("#dclestext").addClass("l-text");
     
        }

        //��ѯ
        function doserch() {
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
            //  alert(serchtxt);
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Crm_CEStage.ashx?" + serchtxt);
        }
        function doclear() {
            //var serchtxt = $("#serchform :input").reset();
            $("#serchform").each(function () {
                this.reset();
                $(".l-selected").removeClass("l-selected");
            });
        }

        var activeDialogs = null;
        function f_openWindowview(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                         
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialogs = parent.jQuery.ligerDialog.open(dialogOptions);
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
        //��ϸ
        function detail() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindowview("crm/ConsExam/CEStage_ViewDetail.aspx?pid=" + row.id
                    + "&name=" + row.CustomerName
                    + "&address=" + row.address
                    + "&sgjl=" + row.sgjl
                     + "&zf=" + row.TotalScorce
                    + "&dcl=" + row.Scoring
                    + "&df=" + row.sum_Score,
                    "��ϸ��ѯ", 700, 530);
            } else {
                $.ligerDialog.warn('��ѡ���У�');
            }
            }
        //ʩ������
        function process() {
           // f_openWindow("crm/ConsExam/CEStage_add.aspx", "�����ͻ�", 700, 330);
        }
        function add() {
            f_openWindow("crm/ConsExam/CEStage_add.aspx", "�����ͻ�", 700, 330);
        }

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                   f_openWindow("crm/ConsExam/CEStage_add.aspx?cid=" + row.id, "�޸Ŀͻ�", 700, 330);
            } else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }

        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("ɾ�����ָܻ���ȷ��ɾ����", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/Crm_CEStage.ashx", type: "POST",
                            data: { Action: "del", id: row.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    top.$.ligerDialog.closeWaitting();
                                    f_reload();
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

        function f_save(item, dialog) {
            
            var issave = dialog.frame.f_save();
          
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                $.ajax({
                    url: "../../data/CRM_CEStage.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        if (responseText == "false:type")
                        {
                            top.$.ligerDialog.error('����ʧ�ܣ�ʩ��������Ϊ�գ����ȵ��ͻ�����ά����');
                        }
                        else
                        {                              
                            f_reload();
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        
                    }
                });

            }
        }
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
            top.flushiframegrid("tabid39");
        };
    </script>
    <style type="text/css">
        .l-leaving { background: #eee; color: #999; }
    </style>

</head>
<body style="padding: 0px;overflow:hidden;">

    <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar"></div>
              <div id="grid">
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

                        <input  ltype='text' ligerui='{width:120}' type='text' id='khstext' name='khstext'  /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>��ַ��</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='dzstext' name='dzstext' ltype='text' ligerui='{width:120}'  />
                        </div>
                    
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>�绰��</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='dhstext' name='dhstext'   ltype='text' ligerui='{width:120}'  />
                        </div>
                       
                    </td>
                    <td>
                          <input id='Button1' type='button' value='����' style='width: 80px; height: 24px' onclick="doserch()" />
                  
                        <input id='Button2' type='button' value='����' style='width: 80px; height: 24px'
                            onclick="doclear()" />
                        </td> 
                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>ʩ������</div>
                    </td>
                    <td>
                        <input id='sgjlstext' name="sgjlstext" type='text'  ltype='text' ligerui='{width:120}' /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right' >״̬��</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='ztstext' name='ztstext'  ltype='text' ligerui="{width:196,data:[{id:'����ʩ��',text:'����ʩ��'},{id:'ʩ�����',text:'ʩ�����'}]}" validate="{required:false}" />
                        </div>
                         
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>����ʣ�</div>
                    </td>
                    <td>
                        <div style='width: 300px; float: left'>
                            <input type='text' id='dclbstext' name='dclbstext'    ltype='text'  ligerui="{width:50}" />
                    
                         -->
                   
                            <input type='text' id='dclestext' name='dclestext'    ltype='text' ligerui="{width:50}"  />
                        </div>
                    </td>

                </tr>
            
            </table>
        </form>
    </div>


</body>
</html>
