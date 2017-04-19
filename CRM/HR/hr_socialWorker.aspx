<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="ie=8" />
    <link href="../CSS/input.css" rel="stylesheet" />
    <link href="../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />  

    <script src="../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>

    <script src="../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
    <script src="../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("#maingrid4").ligerGrid({
                columns: [
                    //{ display: 'ID', name: 'ID', type: 'int', width: 50 },
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                    {
                        display: '����', name: 'name', width: 120, render: function (item) {
                            var html = "<a href='javascript:void(0)' onclick=view(9," + item.ID + ")>";
                            if (item.name)
                                html += item.name;
                            html += "</a>";
                            return html;
                        }
                    },
                    { display: '��ʶ����', name: 'EntryDate' },
                    { display: '����', name: 'birthday' },
                    { display: '�Ա�', name: 'sex', width: 50 },
                    //{ display: '����', name: 'dname' },
                    //{ display: '��λ', name: 'post' },
                    { display: '����', name: 'zhiwu' },
                    {
                        display: '�ɵ�½', width: 50, render: function (item) {
                            var html = "<div style='margin-top:5px;'><input type='checkbox'";
                            if (item.canlogin == 1) html += "checked='checked'  ";
                            html += " disabled='disabled' /></div>";
                            return html;
                        }
                    },
   
                    {
                        display: '����', name: 'status', render: function (item) {
                            var html
                            if (item.status == "Ա������") {
                                return html = "<span><div  style='background:#FFFF00'>" + item.status + "</div></span>";
                            }
                            else if (item.status == "�����Ա") {
                                return html = "<span><div  style='background:#00FF00'>" + item.status + "</div></span>";
                            }
                            else {
                                return html = "<span><div  style='background:#000000'>" + item.status + "</div></span>";
                            }
                        }
                    }
                ],
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: "../data/hr_socialWorker.ashx?Action=grid",
                width: '100%', height: '65%',
                //title: "Ա���б�",
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                },
                onDblClickRow: function (data, rowindex, rowobj) {
                    edit();
                },
                rowtype: "status",
                onAfterShowData: function (grid) {
                    $("tr[rowtype='������']").addClass("l-leaving").removeClass("l-grid-row-alt");
                },
                detail: {
                    onShowDetail: function (r, p) {
                        for (var n in r) {
                            if (r[n] == null) r[n] = "";
                        }
                        var grid = document.createElement('div');
                        $(p).append(grid);
                        $(grid).css('margin', 3).ligerGrid({
                            columns: [
                              //{ display: 'ID', name: 'RoleID', type: 'int', width: 50 },
                              { display: '���', width: 50, render: function (item, i) { return i + 1; } },
                              { display: '��ɫ��', name: 'RoleName',width:300 },
                              { display: '��ɫ����', name: 'RoleDscript', width: 450 },
                              { display: '����', name: 'RoleSort', width: 50 }
                            ],
                            title:'ӵ�н�ɫ',
                            usePager: false,
                            url: "../data/hr_socialWorker.ashx?Action=getRole&empid=" + r.ID,
                             height: '100px',
                            heightDiff: 0
                        })

                    }
                },
                onSelectRow: function (data, rowindex, rowobj) {
                    var manager = $("#maingrid5").ligerGetGridManager();
                    manager.showData({ Rows: [], Total: 0 });
                    var url = "../../data/hr_socialWorker_Follow.ashx?Action=grid&customer_id=" + data.ID;
                    manager.GetDataByURL(url);
                }

            });

            $("#maingrid5").ligerGrid({
                columns: [
                        { display: '���', width: 40, render: function (item, i) { return i + 1; } },
                        {
                            display: '��������', name: 'Follow', align: 'left', width: 200, render: function (item) {
                                var html = "<div class='abc'><a href='javascript:void(0)' onclick=view(10," + item.id + ")>";
                                if (item.Follow)
                                    html += item.Follow;
                                html += "</a></div>";
                                return html;
                            }
                        },
                        {
                            display: '����ʱ��', name: 'Follow_date', width: 140, render: function (item) {
                                return formatTimebytype(item.Follow_date, 'yyyy-MM-dd hh:mm');
                            }
                        },
                        {
                            display: '��������', name: 'Follow_Type', width: 100, render: function (item) {
                                return "<span><div  style='background:#" + item.setcolor + "'>" + item.Follow_Type + "</div></span>";
                            }
                        },
                         {
                             display: '��ؿ�ʼʱ��', name: 'StartTime', width: 100, render: function (item) {
                                 return formatTimebytype(item.StartTime, 'yyyy-MM-dd');
                             }
                         },
                          {
                              display: '��ؽ���ʱ��', name: 'EndTime', width: 100, render: function (item) {
                                  return formatTimebytype(item.EndTime, 'yyyy-MM-dd');
                              }
                          },
                        {
                            display: '������', name: '', width: 80, render: function (item) {
                                return item.employee_name;
                            }
                        }
                ],
                onAfterShowData: function (grid) {
                    $(".abc").hover(function (e) {
                        $(this).ligerTip({ content: $(this).text(), width: 200, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                    }, function (e) {
                        $(this).ligerHideTip(e);
                    });
                },
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                //checkbox:true,
                url: "../../data/hr_socialWorker_Follow.ashx?Action=grid&customer_id=0",
                width: '100%', height: '100%',
                //title: "������Ϣ",
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu1.show({ top: e.pageY, left: e.pageX });
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
            $.getJSON("../data/toolbar.ashx?Action=GetSys&mid=195&rnd=" + Math.random(), function (data, textStatus) {
                //alert(textStatus);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../" + arr[i].icon;
                    items.push(arr[i]);
                }
                items.push({ type: 'textbox', id: 'stext', text: '������' });
                items.push({ type: 'button', text: '����', icon: '../images/search.gif', disable: true, click: function () { doserch() } });

                $("#toolbar").ligerToolBar({
                    items: items

                });
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });

                $("#stext").ligerTextBox({ width: 200, nullText: "������������" })
                $("#maingrid4").ligerGetGridManager().onResize();
            });

            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=198&rnd=" + Math.random(), function (data, textStatus) {
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
                $("#maingrid5").ligerGetGridManager().onResize();
            });
        }
        //��ѯ
        function doserch() {
            //alert("doserch...");
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;
            //alert("serchtxt:"+serchtxt);           
            var manager = $("#maingrid4").ligerGetGridManager();

            manager.GetDataByURL("../data/hr_socialWorker.ashx?" + serchtxt);
        }

        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        //{
                        //    text: '����', onclick: function (item, dialog) {
                        //        f_save(item, dialog);
                        //    }
                        //},
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function add() {
            f_openWindow("hr/hr_socialWorker_add.aspx", "������Ա", 730, 360);
        }

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('hr/hr_socialWorker_add.aspx?empid=' + row.ID, "�޸���Ա��Ϣ", 730, 360);
            } else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }

        function viewCalendar() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('HR/hr_socialWorker_Calendar.aspx?socialWorkerId=' + row.ID, "�鿴�ճ̰���", 1200, 600);
            } else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }

        function authorized() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                top.$.ligerDialog.open({
                    width: 800, height: 500, showToggle: true, url: 'hr/Sys_Role_authorized.aspx?Role_id=' + row.ID, title: "��Ȩ", buttons: [
                        {
                            text: '����', onclick: function (item, dialog) {
                                dialog.frame.f_save();
                            }
                        },
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                    ]
                });
            }
            else {
                $.ligerDialog.warn("��ѡ����");
            }

        }

        function kjl()
        {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                top.$.ligerDialog.waitting();
                $.ajax({
                    url: "../data/website.ashx", type: "POST",
                    data: { Action: "getuserhxdata_tongbu", struid: row.uid, num: 999, rnd: Math.random() },
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        if (responseText == "true") {
                           
                        }
                        $.ajax({
                            url: "../data/website.ashx", type: "POST",
                            data: { Action: "get3dlist_tongbu", struid: row.uid, num: 999, rnd: Math.random() },
                            success: function (responseText) {
                                top.$.ligerDialog.closeWaitting();
                                if (responseText == "true") {
                           
                                }
                        

                            }, error: function () {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('ͬ��ʧ�ܣ�', "", null, 9003);
                            }
                        });

                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('ͬ��ʧ�ܣ�', "", null, 9003);
                    }
                });
            }
        }

        function save_cpwd(item, dialog)
        {
            var postdata = dialog.frame.f_save();
            if (postdata)
            $.ajax({
                url: "../data/hr_socialWorker.ashx", type: "POST",
                data: postdata,
                success: function (responseText) {
                    dialog.close();
                    alert('�޸ĳɹ�!')
                },
                error: function () {
                    alert('�޸�ʧ��!');
                }
            });
        }

        function changepwd() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            //alert(row.uid);
            if (row) {
                top.$.ligerDialog.open(
                    {
                        url: 'hr/hr_socialWorker_changpwd.aspx?empid=' + row.ID,
                        title: "�޸�����",
                        width: 400,
                        height: 200,
                        buttons:
                            [
                                {
                                    text: '����', onclick: function (item, dialog) {
                                        save_cpwd(item, dialog); 
                                    }
                                },
                                {
                                    text: '�ر�', onclick: function (item, dialog) {
                                        dialog.close();
                                    }
                                }
                            ]
                    }
                );
            }
            else {
                top.$.ligerDialog.error('��ѡ����!');
            }
        }

        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("��Աɾ�����Ӧ��Ա����ϵҲ��һͬɾ����\n��ȷ��Ҫɾ����", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../data/hr_socialWorker.ashx", type: "POST",
                            data: { Action: "del", id: row.ID, rnd: Math.random() },
                            success: function (responseText) {
                                top.$.ligerDialog.closeWaitting();
                                if (responseText == "true") {
                                    f_reload();
                                }
                                else if (responseText == "false:customer") {
                                    top.$.ligerDialog.error('ɾ��ʧ�ܣ���Ա���º��пͻ���Ϣ���볹��ɾ��֮���ٲ�����', "ɾ��ʧ�ܣ�", null, 9003);
                                }
                                else {
                                    top.$.ligerDialog.error('ɾ��ʧ�ܣ�', "", null, 9003);
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
                $.ligerDialog.warn("��ѡ��Ա��");
            }
        }
        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
            //alert("issave:" + issave);
                //var postnum = dialog.frame.f_postnum();
                //var postdata = dialog.frame.f_postdata();
                if (issave) {
                    dialog.close();
                    //alert("123456...");
                    $.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                    $.ajax({
                        url: "../data/hr_socialWorker.ashx", type: "POST",
                        data: issave ,
                        success: function (responseText) {
                            $.ligerDialog.closeWaitting();
                            f_reload();
                        },
                        error: function () {
                            $.ligerDialog.closeWaitting();
                            $.ligerDialog.error('����ʧ�ܣ�');
                        }
                    });

                }
        }
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        };

        //follow
        function follow_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '����', onclick: function (item, dialog) {
                                f_savefollow(item, dialog);
                            }
                        },
                        {
                            text: '�ر�', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'b'
            };
            activeDialog1 = top.jQuery.ligerDialog.open(dialogOptions);
        }
        function addfollow() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                follow_openWindow("HR/hr_socialWorker_Follow_add.aspx?cid=" + row.ID, "��������", 530, 400);
            } else {
                $.ligerDialog.warn('��ѡ����Ա���ڵ��У�');
            }
        }
        function editfollow() {
            var manager = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                follow_openWindow('HR/hr_socialWorker_Follow_add.aspx?fid=' + row.id + "&cid=" + row.Customer_id, "�޸ĸ���", 530, 400);
            } else {
                $.ligerDialog.warn('��ѡ�������');
            }
        }
        function delfollow() {
            var manager = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("����ɾ���޷��ָ���ȷ��ɾ����", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/hr_socialWorker_Follow.ashx", type: "POST",
                            data: { Action: "del", id: row.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    f_followreload();
                                    f_reload();
                                }
                                else {
                                    top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                                }

                            },
                            error: function () {
                                top.$.ligerDialog.error('ɾ��ʧ�ܣ�');
                            }
                        });
                    }
                })
            }
            else {
                $.ligerDialog.warn("��ѡ�����");
            }
        }
        function f_savefollow(item, dialog) {
            var issave = dialog.frame.f_save();
            //alter("issave:" + issave);
            if (issave) {
                dialog.close();
                $.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                $.ajax({
                    url: "../../data/hr_socialWorker_Follow.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        $.ligerDialog.closeWaitting();
                        f_followreload();
                        f_reload();
                        top.flushiframegrid("tabid6");
                    },
                    error: function () {
                        $.ligerDialog.closeWaitting();
                        $.ligerDialog.error('����ʧ�ܣ�');
                    }
                });

            }
        }
        function f_followreload() {
            var manager = $("#maingrid5").ligerGetGridManager();
            manager.loadData(true);
            top.flushiframegrid("tabid6");
        };

    </script>
    <style type="text/css">
        .l-leaving { background: #eee; color: #999; }
    </style>

</head>
<body>

    <form id="form1" onsubmit="return false">
        <div id="toolbar"></div>

        <div>
            <div id="maingrid4"  style="margin: -1px; min-width: 800px;"></div>

            <div id="toolbar1"></div>
            <div id="Div1" style="position: relative;">
                <div id="maingrid5" style="margin: -1px -1px;"></div>
            </div>
        </div>
    </form>


</body>
</html>