<%@ Page Language="C#" AutoEventWireup="true"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../CSS/Toolbar.css" rel="stylesheet" type="text/css" />
    <link href="../CSS/core.css" rel="stylesheet" type="text/css" />

    <script src="../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerComboBox.js"></script>
    <script src="../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../lib/jquery.form.js" type="text/javascript"></script>

    <script src="../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () { 
            var strurl = "../data/hr_socialWorker.ashx?Action=grid";
                  $("#maingrid4").ligerGrid({
                columns: [
                    //{ display: 'ID', name: 'ID', type: 'int', width: 50 },
                    { display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; } },
                    {
                        display: '名字', name: 'name', width: 120, render: function (item) {
                            var html = "<a href='javascript:void(0)' onclick=view(9," + item.ID + ")>";
                            if (item.name)
                                html += item.name;
                            html += "</a>";
                            return html;
                        }
                    },
                                          { display: '电话', name: 'tel', width: 120 },
                    { display: '相识日期', name: 'EntryDate' },
                    { display: '生日', name: 'birthday' },

                    { display: '性别', name: 'sex', width: 50 },
                    //{ display: '分组', name: 'dname' },
                    //{ display: '岗位', name: 'post' },
                    { display: '类型', name: 'zhiwu' },
                    {
                        display: '可登陆', width: 50, render: function (item) {
                            var html = "<div style='margin-top:5px;'><input type='checkbox'";
                            if (item.canlogin == 1) html += "checked='checked'  ";
                            html += " disabled='disabled' /></div>";
                            return html;
                        }
                    },

                    {
                        display: '属性', name: 'status', render: function (item) {
                            var html
                            if (item.status == "员工家人") {
                                return html = "<span><div  style='background:#FFFF00'>" + item.status + "</div></span>";
                            }
                            else if (item.status == "社会人员") {
                                return html = "<span><div  style='background:#00FF00'>" + item.status + "</div></span>";
                            }
                            else if (item.status == "工人师傅") {
                                return html = "<span><div  style='background:#81C0C0'>" + item.status + "</div></span>";
                            }
                            else {
                                return html = "<span><div  style='background:#000000'>" + item.status + "</div></span>";
                            }
                        }
                    },
                    { display: '归属人', name: 'Emp_sg' },
                    { display: '创建人', name: 'create_name' }
                ],
           
                checkbox: false,
                dataAction: 'server',
                pageSize: 30,
                pageSizeOptions: [20, 30, 50, 100],
                url: strurl,
                width: '100%',
                height: '100%',
                //title: "员工列表",
                heightDiff: 0
            });
            toolbar();
        });

        function f_select() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var rows = manager.getSelectedRow();
            //alert(rows);
            return rows;
        }

        function toolbar() {            
            var items = [];
          
            if (getparastr('isvew') != "Y")  
                {
                items.push({ type: 'button', text: '新增员工', icon: '../images/icon/11.png', disable: true, click: function () { addemp() } });
                }
                items.push({ type: 'textbox', id: 'stext', text: '姓名：' });
                items.push({ type: 'button', text: '搜索', icon: '../images/search.gif', disable: true, click: function () { doserch() } });

                $("#toolbar").ligerToolBar({
                    items: items

                });  
            
                $("#stext").ligerTextBox({ width: 200, nullText: "输入姓名搜索" })
                $("#maingrid4").ligerGetGridManager().onResize();
           
        }
        //查询
        function doserch() {
            var sendtxt = "&Action=grid&rnd=" + Math.random();
            var serchtxt = $("#form1 :input").fieldSerialize() + sendtxt;
            //alert(serchtxt);           
            var manager = $("#maingrid4").ligerGetGridManager();

            manager.setURL("../data/hr_socialWorker.ashx?" + serchtxt);
            manager.loadData(true);
        }
        var activeDialog = null;
        function f_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        { text: '保存', onclick: f_save },
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ] ,zindex:9005,isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

       
        function addemp() {
            f_openWindow("hr/QuickAddEmp.aspx", "新增账号", 730, 430);
        }
    
        function f_save(item, dialog) {             
                var issave = dialog.frame.f_save();                 
                if (issave) {
                    dialog.close();
                    $.ajax({
                        url: "../data/hr_employee.ashx", type: "POST",
                        data: issave + "&PostData=[]",
                        success: function (responseText) {                            
                            f_reload();
                        },
                        error: function () {                            
                            alert('操作失败！');
                        }
                    });

                }
            
        }
        function f_reload() {
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.loadData(true);
        };
    </script>
   
</head>
<body> 

  <form id="form1" onsubmit="return false"> 
    <div>
        <div id="toolbar"></div> 
        <div id="maingrid4" style="margin:-1px; "></div>   
    </div>     
  </form>

 
</body>
</html>
