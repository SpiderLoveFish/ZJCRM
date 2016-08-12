<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/styles.css" rel="Stylesheet" type="text/css" />
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
       <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
   <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
   
      <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
     <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
   
    <script type="text/javascript">
       
        $(function () {
            //var strurl = "../../data/Budge.ashx?Action=gridselectmodel";
            var strurl = "../../data/Budge.ashx?Action=grid&IsModel=Y";
           

            $("#maingrid4").ligerGrid({
                columns: [
                     {
                         display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                         { return (page - 1) * pagesize + rowindex + 1; }
                     },
                      { display: 'ģ����', name: 'id', width: 100, align: 'left' },
                          { display: 'ģ������', name: 'BudgetName', width: 120, align: 'left' },
                    //  { display: '����', name: 'CustomerName', width: 60, align: 'left' },





                        { display: '������', name: 'name', width: 80, align: 'left' },
                        {
                            display: '��������', name: 'DoTime', width: 100, align: 'left', render: function (item) {
                                return formatTimebytype(item.DoTime, 'yyyy-MM-dd');
                            }
                        },
                          { display: '���ô���', name: 'FromTimes', width: 100, align: 'left' },

                      //  { display: 'ԭԤ��', name: 'id', width: 80, align: 'left' },
                { display: '��ע', name: 'Remarks', width: 100, align: 'left' },
                 { display: '����', name: 'ModelStyle', width: 100, align: 'left' }

                ],

                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: strurl,//����ѡ������ 0 �༭ 1 ���
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

            toolbar();
            $("#lbtip").css("display", 'none');//��ʾ������
        });


    //���������¼�
        document.onkeyup=function(event){
            var e=event||window.event;
            var keyCode=e.keyCode||e.which;
            switch(keyCode){
                   
                case 113://F2��ݼ�
                   // add();
                    break;      
                case 13://�س�
                    doserch();
                    break;
            }

        }


        function f_selectMB() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            return rows;
            
          
        }
        function f_sucess()
        {
            $.ligerDialog.closeWaitting();
            f_load();
            $("#lbtip").css("display", 'inline');
            $("#lbtip").addClass("green");
            $("#lbtip").val('��ӳɹ�������');
            setTimeout(function () {
                $("#lbtip").css("display", 'none');
                
                // $.ligerDialog.error("���ʧ��,��������������");
              
            }, 1000);
           
        }
        function f_error() {

            $.ligerDialog.closeWaitting();
            f_load();
          
            $.ligerDialog.error("���ʧ��,���������������磺ģ���Ƿ�����ȷ��ϸ");
          
        
        }
           function toolbar() {
            var items = [];

            items.push({ type: 'textbox', id: 'stext', text: '���ƣ�' });
            items.push({ type: 'textbox', id: 'stextlx', text: '���ͣ�' });
             items.push({ type: 'button', text: '����', icon: '../images/search.gif', disable: true, click: function () { doserch() } });
            items.push({ type: 'textbox', id: 'lbtip', text: '' });
            $("#toolbar").ligerToolBar({
                items: items

            });

            $("#stext").ligerTextBox({ width: 200 });
            $('#stextlx').ligerComboBox({
                width: 97,
                selectBoxWidth: 240,
                selectBoxHeight: 200,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                     data: [                
                { text: '����ģ��' },
                { text: '�ײ�ģ��' } 
                     ],
                     checkbox: false
                }
            });
            $("#maingrid4").ligerGetGridManager().onResize();
          
           }
           //��ѯ
           function doserch() {
               var strurl = "../../data/Budge.ashx?Action=grid&IsModel=Y";

               var sendtxt = "&rnd=" + Math.random();
               var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;
               //alert(serchtxt);           
               var manager = $("#maingrid4").ligerGetGridManager();
               manager.GetDataByURL(strurl + "&" + serchtxt);
               //manager.loadData(true);
           }
          function f_load() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);

        }
      </script>

</head>
<body>

    <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar" >
                <font size="3" color="red">����ģ����Զ�����ԭ�����ݣ������������
                   </font> </div>
            <div id="maingrid4" style="margin: -1px;"></div>
        </div>
    </form>


</body>
</html>
