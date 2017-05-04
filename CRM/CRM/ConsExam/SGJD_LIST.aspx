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
        var manager = "";
        $(function () {
            var isview = getparastr("isview");
            var strurl = "../../data/Crm_CEStage.ashx?Action=grid1";
            if (isview == "Y")
            {
                strurl = "../../data/Crm_CEStage.ashx?Action=grid1&isview=Y";
            }
            $("#maingrid4").ligerGrid({
                columns: [
                   {
                       display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                       { return (page - 1) * pagesize + rowindex + 1; }
                   },
                    // { display: '�ͻ����', name: 'CustomerID', width: 50, align: 'left' },
                      { display: '����', name: 'CustomerName', width: 60, align: 'left' },
                       {
                           display: '�绰', name: 'tel', align: 'left', width: 40, render: function (item) {
                               var html = "<div class='abc'>";
                               if (item.tel)
                                   html += item.tel;
                               html += "</div>";
                               return html;
                           }
                       },
                        { display: '�ͻ���ַ', name: 'address', width: 150, align: 'left' },
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
                  {
                      display: 'Ҫ������', name: 'Jh_date', width: 90, align: 'left', render: function (item) {
                          return formatTimebytype(item.Jh_date, 'yyyy/MM/dd');
                      }
                  },
                                             //{
                                             //    display: '��״', name: 'Jh_date', width: 100, align: 'left', render: function (item) {
                                             //        var html;
                                             //        var myDate = new Date();
                                             //        var days = getdays(formatTimebytype(item.Jh_date, 'yyyy/MM/dd'), myDate);
                                             //        days = -days;
                                             //        if (days < 0)
                                             //            html = "<span  class='gj'> ���� " + days * -1 + " ��</span>";
                                             //        else
                                             //            html = "<span  class='blue'>ʣ�� " + days + " ��</span>";




                                             //        return html;
                                             //    }
                                             //},
                        { display: '״̬', name: 'Stage_icon', width: 80, align: 'left' },
                { display: '��ע', name: 'Remarks', width: 100, align: 'left' }

                ],
                onAfterShowData: function (grid) {
                    $(".abc").hover(function (e) {
                        $(this).ligerTip({ content: $(this).text(), width: 200, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                    }, function (e) {
                        $(this).ligerHideTip(e);
                    });
                },
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: strurl,
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
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=141&rnd=" + Math.random(), function (data, textStatus) {
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
            $("#dclbstext").addClass("l-text");
            $("#dclestext").addClass("l-text");
        }

        var activeDialogs = null;
        function f_openWindow_show(url, title, width, height) {
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
       
        var activeDialogs = null;
        function f_openWindow_view(url, title, width, height) {
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

        var activeDialogs_jpgj = null;
        function f_openWindow_jpgj(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [

                        {
                            text: '���ƹܼ�', onclick: function (item, dialog) {
                                f_jpgj(item, dialog);
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialogs_jpgj = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function add() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
              //  alert(isview);
                if (getparastr("isview") == "Y")
                    f_openWindow_view("crm/ConsExam/SGJD_LIST_add.aspx?cid=" + row.CustomerID
                   ,
                    "���ȸ���", 800, 550);
                    else
                f_openWindow("crm/ConsExam/SGJD_LIST_add.aspx?cid=" + row.CustomerID
                   ,
                    "���ȸ���", 800, 550);
            } else {
                $.ligerDialog.warn('��ѡ���У�');
            }
            //f_openWindow("crm/ConsExam/SGJD_LIST_add.aspx?id="+,
            //    "���ȸ���", 800, 600);
        }
        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow_show("crm/ConsExam/SGJD_List_View.aspx?cid=" + row.CustomerID
                    + "&khmc=" + encodeURI(row.CustomerName + "[" + row.address + "]")
                    +"&tel="+row.tel
                + "&sjzt=" + encodeURI(row.Stage_icon)
                + "&sgjl=" + encodeURI(row.sgjl)
                + "&jhdate=" + row.Jh_date
                   ,
                    "ʱ�����ѯ", 800, 550);
            } else {
                $.ligerDialog.warn('��ѡ���У�');
            }
            //f_openWindow("crm/ConsExam/SGJD_LIST_add.aspx?id="+,
            //    "���ȸ���", 800, 600);
        }
        
        function jpgj() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow_jpgj("crm/ConsExam/SGJD_LIST_add.aspx?cid=" + row.CustomerID + "&style=JPGJ"
                   ,
                    "���ƹܼ�", 800, 550);
            } else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }
        function f_jpgj(item, dialog) {
            var issave = dialog.frame.f_sgjd();
 
            if (issave) {
                dialog.close();
                var str = issave.split(";");
                top.$.ligerDialog.open({
                    zindex: 9003,
                    title: '���ƹܼ�-' + str[0], width: 650, height: 500,

                    //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                    url: "system/sendsmsmodel.aspx?id=" + str[1] + "&cid=" + str[0] + "&style=JPGJ", buttons: [
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
        
        function f_save(item, dialog) {
            
            var issave = dialog.frame.f_save();
             
            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                $.ajax({
                    url: "../../data/SGJD_LIST.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        if (responseText == "false")
                        {
                            top.$.ligerDialog.error('����ʧ��1��');
                        }
                        else
                        {                              
                            f_reload();
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.error('����ʧ�ܣ�');

                        top.$.ligerDialog.closeWaitting();
                        
                    }
                });

            }
        }
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
            
        };

        //��ѯ
        function doserch() {
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
              // alert(serchtxt);
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
    </script>
    
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
