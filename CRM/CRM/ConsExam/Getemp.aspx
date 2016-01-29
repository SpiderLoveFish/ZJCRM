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
            var style = getparastr("style");
            var strurl = "../../data/PurchaseList.ashx?Action=allgrid";
            if (style == "ALL")//ȫ����Ʒ
                strurl = "../../data/PurchaseList.ashx?Action=allgrid";
            else if (style == "ysA")//Ԥ��A
                strurl = "../../data/PurchaseList.ashx?Action=getlist";
            else if (style == "ysB")//Ԥ��A
                strurl = "../../data/PurchaseList.ashx?Action=getlist";

           

            $("#maingrid4").ligerGrid({
                columns: [
                    //{ display: 'ID', name: 'ID', type: 'int', width: 50 },
                    { display: '���', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                     { display: '���', name: 'product_id', width: 30  },
                    { display: '����', name: 'product_name' },
                    { display: '����', name: 'specifications', width: 50 },
                    { display: '��λ', name: 'unit' },
                    { display: '�۸�', name: 'price' }
                ],
                checkbox: true,
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: strurl, 
                width: '100%',
                height: '100%',
                //title: "Ա���б�",
                heightDiff: 0,
                
                onContextmenu: function (parm, e) {
                actionCustomerID = parm.data.id;
                menu.show({ top: e.pageY, left: e.pageX });
                return false;
            }
            });

            toolbar(style);
            $("#lbtip").css("display", 'none');//��ʾ������
        });


    //���������¼�
        document.onkeyup=function(event){
            var e=event||window.event;
            var keyCode=e.keyCode||e.which;
            switch(keyCode){
                   
                case 113://F2��ݼ�
                    add();
                    break;      
                case 13://�س�
                    doserch();
                    break;
            }

        }


        function f_select() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getCheckedRows();
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
            $("#lbtip").css("display", 'inline');
            $("#lbtip").addClass("red");
            $("#lbtip").val('���ʧ��,������������������');
            setTimeout(function () {
                $("#lbtip").css("display", 'none');

            // $.ligerDialog.error("���ʧ��,��������������");
           
            }, 1000);
           
        
        }
        function initsearchfilder(style)
        {
            $('#stextlx').ligerComboBox({
                width: 97,
                selectBoxWidth: 240,
                selectBoxHeight: 200,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    url: '../../data/CRM_product_category.ashx?Action=tree&rnd=' + Math.random(),
                    idFieldName: 'id',
                    checkbox: false
                } 
            });
        }
        function add() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getCheckedRows();
            var prouductid = '';
            for (var item = 0; item < rows.length; item++)
                prouductid += ',' + rows[item].product_id;
            if (prouductid == '')
            {
                $.ligerDialog.error("������ѡ��һ����Ч�������ݣ�");
                return;
            }
            
                        $.ajax({
                            type: 'post',
                            url: "../../data/PurchaseList.ashx?Action=savelist&cid=" + getparastr("cid") + "&pid=" + prouductid + '&rdm=' + Math.random(),
                            success: function (data) {
                              
                              f_sucess();

                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                dialog.frame.f_error();
                            }
                        });
                    
        }
        function toolbar(style) {
            var items = [];

            items.push({ type: 'textbox', id: 'stext', text: '���ƣ�' });
            if (style == "ALL")
            items.push({ type: 'textbox', id: 'stextlx', text: '���ͣ�' });
            items.push({ type: 'button', text: '����', icon: '../images/search.gif', disable: true, click: function () { doserch() } });
            items.push({ type: 'textbox', id: 'lbtip', text: '' });
            $("#toolbar").ligerToolBar({
                items: items

            });

            $("#stext").ligerTextBox({ width: 200 });
            if (style == "ALL")
                initsearchfilder(style);
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=150&rnd=" + Math.random(), function (data, textStatus) {
            menu = $.ligerMenu({
                width: 120, items: getMenuItems(data)
            });
            });
          
            $("#maingrid4").ligerGetGridManager().onResize();
          
        }
        //��ѯ
        function doserch() {
            var style = getparastr("style");
            var strurl = "../../data/PurchaseList.ashx?Action=allgrid";
            if (style == "ALL")//ȫ����Ʒ
                strurl = "../../data/PurchaseList.ashx?Action=allgrid";
            else if (style == "ysA")//Ԥ��A
                strurl = "../../data/PurchaseList.ashx?Action=getlist";
            else if (style == "ysB")//Ԥ��A
                strurl = "../../data/PurchaseList.ashx?Action=getlist";
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
            <div id="toolbar"></div>
            <div id="maingrid4" style="margin: -1px;"></div>
        </div>
    </form>


</body>
</html>
