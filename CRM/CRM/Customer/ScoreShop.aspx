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
            var strurl = "../../data/ScoreShop.ashx?Action=grid&rnd=" + Math.random();//�༭
           
            $("#maingrid4").ligerGrid({
                columns: [
                    {
                        display: '���', width: 30, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                        { return (page - 1) * pagesize + rowindex + 1; }
                    },
                 
                     { display: '����', name: 'ScoreName', width: 120 },
                    { display: '����', name: 'ScoreDescribe', width: 120 },
                    
                    
                    { display: '��Ҫ����', name: 'NeedScore', width: 80 },
                   // { display: '�ͻ�״̬', name: 'industry', width: 80 },
                    { display: '������', name: 'TotalSum', width: 80 },
                    { display: 'ʣ������', name: 'RemainSum', width: 80 } 
                ],
             
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                url: strurl,
                width: '100%', height: '65%',
                heightDiff: -1 
            });
           

            
            toolbar();
        });

        function toolbar() {
            var url="../../data/toolbar.ashx?Action=GetSys&mid=189&rnd=" + Math.random();
            
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
               
              
                $("#toolbar").ligerToolBar({
                    items: items
                });
                $("#keyword1").ligerTextBox({ width: 200, nullText: "����ؼ�������" })
                menu = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });

            });
            
               
        }
        function initSerchForm() {
          
        }
        //¥��
        
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
            manager.GetDataByURL("../../data/ScoreShop.ashx?" + serchtxt);

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
         

        function add() {
            f_openWindow("CRM/Customer/ScoreShop_add.aspx", "������Ϣ", 660, 550);
        }

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow('CRM/Customer/ScoreShop_add.aspx?cid=' + row.id, "�޸���Ϣ", 660, 550);
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }
       
        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.warn('��ʱ������ɾ����');
                //$.ajax({
                //    url: "../../data/ScoreShop.ashx", type: "POST",
                //    data: "&Action=UpdateStatus&id=" + row.id + "&isstatus=99",
                //    beforesend: function () {
                //        top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                //    },
                //    success: function (responseText) {

                //        f_reload();

                //    },
                //    error: function () {
                //        top.$.ligerDialog.error('����ʧ�ܣ�');
                //    },
                //    complete: function () {
                //        top.$.ligerDialog.closeWaitting();
                //    }
                //});
            }
            else {
                $.ligerDialog.warn('��ѡ���У�');
            }
        }
 
      function   f_save(item, dialog) {
            var issave = dialog.frame.f_save();
        
            if (issave) {
                dialog.close();

                $.ajax({
                    url: "../../data/ScoreShop.ashx", type: "POST",
                    data: issave  ,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('���ݱ�����,���Ժ�...');
                    },
                    success: function (responseText) {

                        f_reload();
                       
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
            <div id="maingrid4" style="margin: -1px;  "></div>
            <div id="toolbar1"></div>
             
        </div>


    </form>
 
    
</body>
</html>
