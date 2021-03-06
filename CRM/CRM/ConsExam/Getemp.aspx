<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
   <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/core.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/styles.css" rel="Stylesheet" type="text/css" />
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
       
        $(function () {
            var style = getparastr("style");
            var strurl = "../../data/PurchaseList.ashx?Action=allgridxc";
            if (style == "ALL")//全部产品
                strurl = "../../data/PurchaseList.ashx?Action=allgridxc";
            else if (style == "YS")//预算A
                strurl = "../../data/PurchaseList.ashx?Action=ysgrid&cid=" + getparastr("cid");
            else if (style == "ysB")//预算A
                strurl = "../../data/PurchaseList.ashx?Action=getlist&cid=" + getparastr("cid");

           

            $("#maingrid4").ligerGrid({
                columns: [
                    //{ display: 'ID', name: 'ID', type: 'int', width: 50 },
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                  { display: '材料编号', name: 'C_code', width: 80, align: 'left' },
                  { display: '材料名称', name: 'product_name', width: 100, align: 'left' },
                  { display: '材料型号', name: 'ProModel', width: 100, align: 'left' },
                  { display: '材料规格', name: 'specifications', width: 60, align: 'left' },
                    { display: '所属品牌', name: 'Brand', width: 60, align: 'left' },
                  { display: '供应商', name: 'Suppliers', width: 60, align: 'left' },
                   
                      {
                          display: '工艺说明', name: 'remarks', align: 'left', width: 250, render: function (item) {
                              var html = "<div class='abc'>";
                              if (item.remarks)
                                  html += item.remarks;
                              html += "</div>";
                              return html;
                          }
                      },
                  //{ display: '材料编号', name: 'C_code', width: 100, align: 'left' },

                  { display: '类别', name: 'category_name', width: 100, align: 'left' },
                  { display: '单位', name: 'unit', width: 40, align: 'left' },
                    { display: '数量', name: 'SUM', width: 40, align: 'left' }


                  //,
                  //{
                  //    display: '图文', width: 40, render: function (item) {
                  //        var html = "<a href='javascript:void(0)' onclick=view(" + item.product_id + ")>查看</a>"
                  //        return html;
                  //    }
                  //}
                ],
                  onAfterShowData: function (grid) {
                    $(".abc").hover(function (e) {
                        $(this).ligerTip({ content: $(this).text(), width: 300, distanceX: event.clientX - $(this).offset().left - $(this).width() + 15 });
                    }, function (e) {
                        $(this).ligerHideTip(e);
                    });
                },
                checkbox: true,

                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: strurl, 
                width: '100%',
                height: '100%',
                //title: "员工列表",
                heightDiff: 0,
                
                onContextmenu: function (parm, e) {
                actionCustomerID = parm.data.id;
                menu.show({ top: e.pageY, left: e.pageX });
                return false;
            }
            });

            toolbar(style);
            $("#lbtip").css("display", 'none');//提示先隐藏
        });


    //监听键盘事件
        document.onkeyup=function(event){
            var e=event||window.event;
            var keyCode=e.keyCode||e.which;
            switch(keyCode){
                   
                case 113://F2快捷键
                    add();
                    break;      
                case 13://回车
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
            $("#lbtip").val('添加成功！！！');
            setTimeout(function () {
                $("#lbtip").css("display", 'none');
                
                // $.ligerDialog.error("添加失败,请检查后继续操作！");
              
            }, 1000);
           
        }
        function f_error() {

            $.ligerDialog.closeWaitting();
            f_load();
            $("#lbtip").css("display", 'inline');
            $("#lbtip").addClass("red");
            $("#lbtip").val('添加失败,请检查后继续操作！！！');
            setTimeout(function () {
                $("#lbtip").css("display", 'none');

            // $.ligerDialog.error("添加失败,请检查后继续操作！");
           
            }, 1000);
           
        
        }
        function f_error1() {

            $.ligerDialog.closeWaitting();
            f_load();
            $("#lbtip").css("display", 'inline');
            $("#lbtip").addClass("red");
            $("#lbtip").val('已存在，请修改数量！');
            setTimeout(function () {
                $("#lbtip").css("display", 'none');

                // $.ligerDialog.error("添加失败,请检查后继续操作！");

            }, 1000);


        }
        function initsearchfilder(style)
        {
            $('#stextlx').ligerComboBox({
                width: 150,
                selectBoxWidth: 240,
                selectBoxHeight: 250,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    url: '../../data/CRM_product_category.ashx?Action=treeall&rnd=' + Math.random(),
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
                $.ligerDialog.error("请至少选择一个有效材料数据！");
                return;
            }
            
                        $.ajax({
                            type: 'post',
                            url: "../../data/PurchaseList.ashx?Action=savelist&style=" + getparastr("style") + "&cid=" + getparastr("cid") + "&pid=" + prouductid + '&rdm=' + Math.random(),
                            success: function (data) {
                                if (data == "false") {
                                    f_error1();
                                }
                                else {
                                    f_sucess();
                                }
                           

                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                dialog.frame.f_error();
                            }
                        });
                    
        }
        function toolbar(style) {
            var items = [];

            items.push({ type: 'textbox', id: 'stext', text: '条件一：' });
            items.push({ type: 'textbox', id: 'stextpp', text: '条件二：' });
            if (style == "ALL")
            items.push({ type: 'textbox', id: 'stextlx', text: '类型：' });
            items.push({ type: 'button', text: '搜索', icon: '../images/search.gif', disable: true, click: function () { doserch() } });
            items.push({ type: 'textbox', id: 'lbtip', text: '' });
            $("#toolbar").ligerToolBar({
                items: items

            });

            $("#stext").ligerTextBox({ width: 200 });
             $("#stextpp").ligerTextBox({ width: 100 });
            if (style == "ALL")
                initsearchfilder(style);
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=150&rnd=" + Math.random(), function (data, textStatus) {
            menu = $.ligerMenu({
                width: 120, items: getMenuItems(data)
            });
            });
          
            $("#maingrid4").ligerGetGridManager().onResize();
          
        }
        //查询
        function doserch() {
            var style = getparastr("style");
            var strurl = "../../data/PurchaseList.ashx?Action=allgridxc";
            if (style == "ALL")//全部产品
                strurl = "../../data/PurchaseList.ashx?Action=allgridxc";
            else if (style == "ysA")//预算A
                strurl = "../../data/PurchaseList.ashx?Action=getlist";
            else if (style == "ysB")//预算A
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
        function view(id) {
            var dialogOptions = {
                width: 770, height: 510, title: "材料档案图文介绍", url: '../view/product_view.aspx?pid=' + id + '&rnd=' + Math.random(), buttons: [
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
    </script>

</head>
<body>

    <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar" ></div>
            <div id="maingrid4" style="margin: -1px;"></div>
        </div>
    </form>


</body>
</html>
