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
            if (getparastr("type") == "GJXG")
                $("#maingrid4").ligerGrid(

               {

                   columns: [
                       {
                           display: '序号', width: 30, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                           { return (page - 1) * pagesize + rowindex + 1; }
                       },

                       {
                           display: '姓名', name: 'Customer', width: 50, align: 'left', render: function (item) {
                               var html = "<a href='javascript:void(0)' onclick=view(1," + item.id + ")>";
                               if (item.Customer)
                                   html += item.Customer;
                               html += "</a>";
                               return html;
                           }
                       },
                       { display: '性别', name: 'Gender', width: 40 },
                        {
                            display: '电话', name: 'tel', align: 'left', width: 40, render: function (item) {
                                var html = "<div class='abc'>";
                                if (item.tel)
                                    html += item.tel;
                                html += "</div>";
                                return html;
                            }
                        },
                      {
                          display: '地址', name: 'address', align: 'left', width: 120, render: function (item) {
                              var html = "<div class='abc'>";
                              if (item.address)
                                  html += item.address;
                              html += "</div>";
                              return html;
                          }
                      },
                       { display: '小区', name: 'Community', width: 60 },


                       {
                           display: '客户类型', name: 'CustomerType', width: 60, align: 'right', render: function (item) {
                               return "<span><div  style='background:#" + item.setcolor + "'>" + item.CustomerType + "</div></span>";
                           }
                       },
                           {
                               display: '客户状态', name: 'industry', width: 60, align: 'right', render: function (item) {
                                   return "<span><div style='color:#" + item.indcolor + "'>" + item.industry + "</div></span>";
                               }
                           },
                                
                       //{ display: '省份', name: 'Provinces', width: 80 },
                       //{ display: '城市', name: 'City', width: 80 },
                       //{ display: '区镇', name: 'Towns', width: 80 },
                       //{ display: '楼号', name: 'BNo', width: 80 },
                       //{ display: '房号', name: 'RNo', width: 80 },

                      // { display: '部门', name: 'Department', width: 80 },
                       { display: '业务员', name: 'Employee', width: 50 },
                       { display: '设计师', name: 'Emp_sj', width: 50 },
                       { display: '施工监理', name: 'Emp_sg', width: 60 },
                        {
                            display: '当前阶段', name: 'Stage_icon', width: 60, render: function (item) {

                                var html;
                                if (item.Stage_icon == "正在施工") {
                                    html = "<div style='color:#FF0000'>";
                                    html += item.Stage_icon;
                                    html += "</div>";
                                }
                                else if (item.Stage_icon == "施工完成") {
                                    html = "<div style='color:#339900'>";
                                    html += item.Stage_icon;
                                    html += "</div>";
                                }
                                else {
                                    html = item.Stage_icon;
                                }
                                return html;
                            }
                        },
                         {
                             display: '下个阶段', name: 'Stage_icon', width: 60, render: function (item) {

                                 var html;

                                
                                 if (item.Stage_icon == "正在施工") {
                                     html = "<div style='color:#339900'>";
                                     html += "施工完成";
                                     html += "</div>";
                                 }
                                 else if (item.Stage_icon == "施工完成") {
                                     html = "<div style='color:#000'>";
                                     html += "无";
                                     html += "</div>";
                                 }
                                 else if (item.Stage_icon == "未签单") {
                                     html = "<div style='color:#FF0000'>";
                                     html += "已签单";
                                     html += "</div>";
                                 }
                                 else {
                                     html = item.Stage_icon;
                                 }
                                 return html;
                             }
                         },
                         {
                             display: '效果图', name: 'kjl', width: 60, render: function (item) {
                                 var html;

                                 if (item.kjl == "Y") {
                                     html = "<div style='color:#FF0000'>";
                                     html += "有";
                                     html += "</div>";
                                 }
                                 else  {
                                     html = "<div style='color:#000'>";
                                     html += "无";
                                     html += "</div>";
                                 }
                                 return html;
                             }
                         },

                          {
                              display: '应收金额', name: 'Order_amount', width: 80, align: 'right', render: function (item) {
                                  return "<div style='color:#135294'>" + toMoney(item.Order_amount) + "</div>";
                              }
                          },
                           {
                               display: '已收定金', name: 'dj_amount', width: 80, align: 'right', render: function (item) {
                                   return "<div style='color:#135294'>" + toMoney(item.dj_amount) + "</div>";
                               }
                           },
                             {
                                 display: '已付装修款', name: 'zx_amount', width: 80, align: 'right', render: function (item) {
                                     return "<div style='color:#135294'>" + toMoney(item.zx_amount) + "</div>";
                                 }
                             },
                               {
                                   display: '未付金额', name: 'wx_amount', width: 80, align: 'right', render: function (item) {
                                       return "<div style='color:#135294'>" + toMoney(item.Order_amount - item.dj_amount - item.zx_amount) + "</div>";
                                   }
                               },
                       { display: '性质', name: 'privatecustomer', width: 40 },






                      
                       {
                           display: '创建时间', name: 'Create_date', width: 90, render: function (item) {
                               var Create_date = formatTimebytype(item.Create_date, 'yyyy-MM-dd');
                               return Create_date;
                           }
                       }


                   ],

                   onBeforeShowData: function (grid, data) {
                       startTime = new Date();
                   },
                   //fixedCellHeight:false,
                   onSelectRow: function (data, rowindex, rowobj) {
                       var manager = $("#maingrid5").ligerGetGridManager();
                       manager.showData({ Rows: [], Total: 0 });
                       var url = "../../data/CRM_Follow.ashx?Action=grid&customer_id=" + data.id;
                       manager.GetDataByURL(url);
                   },
                   rowtype: "CustomerType",
                   dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                   url: "../../data/crm_customer.ashx?Action=grid&rnd=" + Math.random(),
                   width: '100%', height: '65%',
                   heightDiff: -1,
                   onRClickToSelect: true,
                   onContextmenu: function (parm, e) {
                       actionCustomerID = parm.data.id;
                       menu.show({ top: e.pageY, left: e.pageX });
                       return false;
                   },
                   onAfterShowData: function (grid) {
                       $("tr[rowtype='已成交']").addClass("l-treeleve1").removeClass("l-grid-row-alt");
                       var nowTime = new Date();
                       //alert('加载数据耗时：' + (nowTime - startTime));
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
                               { display: '行号', width: 50, render: function (item, i) { return i + 1; } },
                               { display: '联系人', name: 'C_name', width: 100 },
                               { display: '职业', name: 'C_position', width: 100 },
                               { display: '性别', name: 'C_sex', width: 50 },
                               //{ display: '客户姓名', name: 'C_companyname', width: 180 },
                               { display: '手机', name: 'C_mob', width: 120 },
                               { display: 'QQ', name: 'C_QQ', width: 100 },
                               { display: 'Email', name: 'C_email', width: 180 }
                               ],
                               usePager: false,
                               checkbox: false,
                               url: "../../data/CRM_Contact.ashx?Action=grid&customerid=" + r.id,
                               width: '1022px', height: '100px',
                               heightDiff: 0
                           })

                       }
                   }
               });
            else
            $("#maingrid4").ligerGrid(

                {

                columns: [
                    {
                        display: '序号', width: 30, render: function (rowData, rowindex, value, column, rowid, page, pagesize)
                        { return (page - 1) * pagesize + rowindex + 1; }
                    },
                 
                    {
                        display: '姓名', name: 'Customer', width: 50, align: 'left', render: function (item) {
                            var html = "<a href='javascript:void(0)' onclick=view(1," + item.id + ")>";
                            if (item.Customer)
                                html += item.Customer;
                            html += "</a>";
                            return html;
                        }
                    },
                    { display: '性别', name: 'Gender', width: 40 },
                     {
                         display: '电话', name: 'tel', align: 'left', width: 40, render: function (item) {
                             var html = "<div class='abc'>";
                             if (item.tel)
                                 html += item.tel;
                             html += "</div>";
                             return html;
                         }
                     },
                   {
                       display: '地址', name: 'address', align: 'left', width: 120, render: function (item) {
                           var html = "<div class='abc'>";
                           if (item.address)
                               html += item.address;
                           html += "</div>";
                           return html;
                       }
                   },
                    { display: '小区', name: 'Community', width: 60 },
                  
             
                    {
                        display: '客户类型', name: 'CustomerType', width: 60, align: 'right', render: function (item) {
                            return "<span><div  style='background:#" + item.setcolor + "'>" + item.CustomerType + "</div></span>";
                        }
                    },
                        {
                            display: '客户状态', name: 'industry', width: 60, align: 'right', render: function (item) {
                                return "<span><div style='color:#" + item.indcolor + "'>" + item.industry + "</div></span>";
                            }
                        },
                             // { display: '客户状态', name: 'industry', width: 80 },
                    { display: '预算价位', name: 'CustomerLevel', width: 60 },
                    { display: '客户来源', name: 'CustomerSource', width: 60 },
                    //{ display: '省份', name: 'Provinces', width: 80 },
                    //{ display: '城市', name: 'City', width: 80 },
                    //{ display: '区镇', name: 'Towns', width: 80 },
                    //{ display: '楼号', name: 'BNo', width: 80 },
                    //{ display: '房号', name: 'RNo', width: 80 },
                   
                   // { display: '部门', name: 'Department', width: 80 },
                    { display: '业务员', name: 'Employee', width: 50 },
                    { display: '设计师', name: 'Emp_sj', width: 50 },
                    { display: '施工监理', name: 'Emp_sg', width: 60 },
                     {
                         display: '进度', name: 'Stage_icon', width: 60, render: function (item) {

                             var html;
                             if (item.Stage_icon == "正在施工") {
                                 html = "<div style='color:#FF0000'>";
                                 html += item.Stage_icon;
                                 html += "</div>";
                             }
                             else if (item.Stage_icon == "施工完成") {
                                 html = "<div style='color:#339900'>";
                                 html += item.Stage_icon;
                                 html += "</div>";
                             }
                             else {
                                 html = item.Stage_icon;
                             }
                             return html;
                         }
                     },

                    { display: '性质', name: 'privatecustomer', width: 40 },

                   
          
         

     
                    {
                        display: '最后跟进', name: 'lastfollow', width: 90, render: function (item) {
                            var lastfollow = formatTimebytype(item.lastfollow, 'yyyy-MM-dd');
                            if (lastfollow == "1900-01-01")
                                lastfollow = "";
                            return lastfollow;
                        }
                    },
                    {
                        display: '创建时间', name: 'Create_date', width: 90, render: function (item) {
                            var Create_date = formatTimebytype(item.Create_date, 'yyyy-MM-dd');
                            return Create_date;
                        }
                    }


                ],

                onBeforeShowData: function (grid, data) {
                    startTime = new Date();
                },
                //fixedCellHeight:false,
                onSelectRow: function (data, rowindex, rowobj) {
                    var manager = $("#maingrid5").ligerGetGridManager();
                    manager.showData({ Rows: [], Total: 0 });
                    var url = "../../data/CRM_Follow.ashx?Action=grid&customer_id=" + data.id;
                    manager.GetDataByURL(url);
                },
                rowtype: "CustomerType",
                dataAction: 'server', pageSize: 30, pageSizeOptions: [20, 30, 50, 100],
                url: "../../data/crm_customer.ashx?Action=grid&rnd=" + Math.random(),
                width: '100%', height: '65%',
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                },
                onAfterShowData: function (grid) {
                    $("tr[rowtype='已成交']").addClass("l-treeleve1").removeClass("l-grid-row-alt");
                    var nowTime = new Date();
                    //alert('加载数据耗时：' + (nowTime - startTime));
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
                            { display: '行号', width: 50, render: function (item, i) { return i + 1; } },
                            { display: '联系人', name: 'C_name', width: 100 },
                            { display: '职业', name: 'C_position', width: 100 },
                            { display: '性别', name: 'C_sex', width: 50 },
                            //{ display: '客户姓名', name: 'C_companyname', width: 180 },
                            { display: '手机', name: 'C_mob', width: 120 },
                            { display: 'QQ', name: 'C_QQ', width: 100 },
                            { display: 'Email', name: 'C_email', width: 180 }
                            ],
                            usePager: false,
                            checkbox: false,
                            url: "../../data/CRM_Contact.ashx?Action=grid&customerid=" + r.id,
                            width: '1022px', height: '100px',
                            heightDiff: 0
                        })

                    }
                }
                });
            if (getparastr("type") == "GJXG")

                $("#maingrid5").ligerGrid({
                    columns: [
                            { display: '序号', width: 40, render: function (item, i) { return i + 1; } },

                            {
                                display: '交易时间', name: 'Follow_date', width: 140, render: function (item) {
                                    return formatTimebytype(item.Follow_date, 'yyyy-MM-dd hh:mm');
                                }
                            },
                            { display: '交易类别', name: 'Follow_Type', width: 60 },
                          
                            {
                                display: '交易金额', name: '', width: 100, render: function (item) {
                                    return item.employee_name;
                                }
                            },
                             {
                                 display: '凭证号', name: '', width: 100, render: function (item) {
                                     return item.employee_name;
                                 }
                             },
                               {
                                   display: '交易人', name: '', width: 80, render: function (item) {
                                       return item.employee_name;
                                   }
                               },
                              {
                                  display: '录入人', name: '', width: 80, render: function (item) {
                                      return item.employee_name;
                                  }
                              },
                              {
                                  display: '录入时间', name: '', width: 80, render: function (item) {
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
                    url: "../../data/CRM_Follow.ashx?Action=grid&customer_id=0",
                    width: '100%', height: '100%',
                    //title: "跟进信息",
                    heightDiff: -1,
                    onRClickToSelect: true,
                    onContextmenu: function (parm, e) {
                        actionCustomerID = parm.data.id;
                        menu1.show({ top: e.pageY, left: e.pageX });
                        return false;
                    }
                });
            else
            $("#maingrid5").ligerGrid({
                columns: [
                        { display: '序号', width: 40, render: function (item, i) { return i + 1; } },
                        {
                            display: '跟进内容', name: 'Follow', align: 'left', width: 400, render: function (item) {
                                var html = "<div class='abc'><a href='javascript:void(0)' onclick=view(2," + item.id + ")>";
                                if (item.Follow)
                                    html += item.Follow;
                                html += "</a></div>";
                                return html;
                            }
                        },
                        {
                            display: '跟进时间', name: 'Follow_date', width: 140, render: function (item) {
                                return formatTimebytype(item.Follow_date, 'yyyy-MM-dd hh:mm');
                            }
                        },
                        { display: '跟进方式', name: 'Follow_Type', width: 60 },
                        {
                            display: '跟进人', name: '', width: 80, render: function (item) {
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
                url: "../../data/CRM_Follow.ashx?Action=grid&customer_id=0",
                width: '100%', height: '100%',
                //title: "跟进信息",
                heightDiff: -1,
                onRClickToSelect: true,
                onContextmenu: function (parm, e) {
                    actionCustomerID = parm.data.id;
                    menu1.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });

            $("#grid").height(document.documentElement.clientHeight - $(".toolbar").height());
            $('form').ligerForm();
            toolbar();
        });
       

        var mid,mid2;
        if (getparastr("type") == "GJXG") {
            mid = 194;
            mid2 = 196;
        }
        else {
            mid = 4;
            mid2 = 6;
        }
        function toolbar() {
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid="+mid+"&rnd=" + Math.random(), function (data, textStatus) {
                //alert(data);
                var items = [];
                var arr = data.Items;
                for (var i = 0; i < arr.length; i++) {
                    arr[i].icon = "../../" + arr[i].icon;
                    items.push(arr[i]);
                }
                if (getparastr("type") == "GJXG") {
                    items.push({
                        type: 'textbox',
                        id: 'sectype',
                        name: 'sectype',
                        text: '筛选'
                    });
                    items.push({
                        type: 'textbox',
                        id: 'thtype',
                        name: 'thtype',
                        text: '阶段'
                    });
                }
                else {
                    items.push({
                        type: 'textbox',
                        id: 'stype',
                        name: 'stype',
                        text: '类型'
                    });


                    items.push({
                        type: 'textbox',
                        id: 'sbq',
                        name: 'sbq',
                        text: '标签'
                    });
                }
                items.push({
                    type: 'textbox',
                    id: 'keyword1',
                    name: 'keyword1',
                    text: ''
                });
                items.push({ line: true });
                items.push({
                    type: 'button',
                    text: '搜索',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        doserch()
                    }
                });                              
                items.push({
                    type: 'serchbtn',
                    text: '高级搜索',
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

            });
            $.getJSON("../../data/toolbar.ashx?Action=GetSys&mid=" + mid2 + "&rnd=" + Math.random(), function (data, textStatus) {
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
                menu1 = $.ligerMenu({
                    width: 120, items: getMenuItems(data)
                });
                $("#stype").ligerComboBox({
                    width: 100,
                    isMultiSelect: true,
                    url: "../../data/param_sysparam.ashx?Action=combo&parentid=1&rnd=" + Math.random()
                })
                $('#sectype').ligerComboBox({
                    width: 80,
                    isMultiSelect: true,
                    selectBoxWidth: 120,
                    selectBoxHeight: 120,
                    valueField: 'id',
                    textField: 'text',
                    treeLeafOnly: true,
                    tree: {
                        data: [
                   { text: '已付定金' },
                   { text: '未付定金' },
                   { text: '已结清' },
                   { text: '未结清' },
                   { text: '有效果图' },
                   { text: '无效果图' }
        

                        ],
                        checkbox: false
                    }
                });
                $('#thtype').ligerComboBox({
                    width: 80,
                    isMultiSelect: true,
                    selectBoxWidth: 120,
                    selectBoxHeight: 120,
                    valueField: 'id',
                    textField: 'text',
                    treeLeafOnly: true,
                    tree: {
                        data: [
                   { text: '未签单' },
                   { text: '已签单' },
                   { text: '正在施工' },
                   { text: '施工完成' }


                        ],
                        checkbox: false
                    }
                });
                $("#sbq").ligerComboBox({
                    width: 100,
                    isMultiSelect: true,
                    url: "../../data/param_sysparam.ashx?Action=combo&parentid=18&rnd=" + Math.random()
                })
                $("#keyword1").ligerTextBox({ width: 100, nullText: "输入关键词搜索" })
                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();

            });
        }
        function initSerchForm() {
           
            //var a = $('#T_City').ligerComboBox({ width: 96, emptyText: '（空）' });
            //var b = $('#T_Provinces').ligerComboBox({
            //    width: 97,

            //    url: "../../data/Param_City.ashx?Action=combo1&rnd=" + Math.random(),
            //    onSelected: function (newvalue) {
            //        $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
            //            a.setData(eval(data));
            //        });
            //    }, emptyText: '（空）'
            //});

            b = $('#T_Towns').ligerComboBox({
                width: 97,
                //url: "../../data/Param_City.ashx?Action=combo&rnd=" + Math.random(),
                onSelected: function (newvalue, newtext) {
                    if (!newvalue)
                        newvalue = -1;
                    $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        a.setData(eval(data));
                        a.selectValue(obj.Community_id);
                    });
                }, emptyText: '（空）'
            });
            c = $('#T_City').ligerComboBox({
                width: 97,
                //url: "../../data/Param_City.ashx?Action=combo&rnd=" + Math.random(),
                onSelected: function (newvalue, newtext) {
                    if (!newvalue)
                        newvalue = -1;
                    $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        b.setData(eval(data));
                        b.selectValue(obj.Towns_id);
                    });
                }, emptyText: '（空）'
            });
            d = $('#T_Provinces').ligerComboBox({
                width: 97,
                url: "../../data/Param_City.ashx?Action=combo1&rnd=" + Math.random(),
                onSelected: function (newvalue, newtext) {
                    if (!newvalue)
                        newvalue = -1;
                    $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        c.setData(eval(data));
                        c.selectValue(obj.City_id);
                    });
                }, emptyText: '（空）'
            });
            $('#customertype').ligerComboBox({ width: 97, emptyText: '（空）', url: "../../data/Param_SysParam.ashx?Action=combo&parentid=1&rnd=" + Math.random() });
            $('#WXZHT').ligerComboBox({ width: 97, emptyText: '（空）', url: "../../data/Param_SysParam.ashx?Action=combo&parentid=15&rnd=" + Math.random() });
            $('#customerlevel').ligerComboBox({ width: 96, emptyText: '（空）', url: "../../data/Param_SysParam.ashx?Action=combo&parentid=2&rnd=" + Math.random() });
            $('#cus_sourse').ligerComboBox({ width: 120, emptyText: '（空）', url: "../../data/Param_SysParam.ashx?Action=combo&parentid=3&rnd=" + Math.random() });
           // $('#T_Community').ligerComboBox({ width: 120, emptyText: '（空）', url: "../../data/Param_City.ashx?Action=getBuilding&rnd=" + Math.random() });
            var gCommunity = $('#T_Community').ligerComboBox({
                width: 120,
                //initValue: obj.Community_id,
                url: "../../data/Param_City.ashx?Action=getBuilding&rnd=" + Math.random(),
                onBeforeOpen: f_selectComm

            });
            var e = $('#employee').ligerComboBox({ width: 96, emptyText: '（空）' });
            var f = $('#department').ligerComboBox({
                width: 97,
                selectBoxWidth: 240,
                selectBoxHeight: 200,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    url: '../../data/hr_department.ashx?Action=tree&rnd=' + Math.random(),
                    idFieldName: 'id',
                    //parentIDFieldName: 'pid',
                    checkbox: false
                },
                onSelected: function (newvalue) {
                    $.get("../../data/hr_employee.ashx?Action=combo&did=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        e.setData(eval(data));
                    });
                }
            });

            var g = $('#employee_sg').ligerComboBox({ width: 96, emptyText: '（空）' });
            var h = $('#department_sg').ligerComboBox({
                width: 97,
                selectBoxWidth: 240,
                selectBoxHeight: 200,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    url: '../../data/hr_department.ashx?Action=tree&rnd=' + Math.random(),
                    idFieldName: 'id',
                    //parentIDFieldName: 'pid',
                    checkbox: false
                },
                onSelected: function (newvalue) {
                    $.get("../../data/hr_employee.ashx?Action=combo&did=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        g.setData(eval(data));
                    });
                }
            });

            var k = $('#employee_sj').ligerComboBox({ width: 96, emptyText: '（空）' });
            var l = $('#department_sj').ligerComboBox({
                width: 97,
                selectBoxWidth: 240,
                selectBoxHeight: 200,
                valueField: 'id',
                textField: 'text',
                treeLeafOnly: false,
                tree: {
                    url: '../../data/hr_department.ashx?Action=tree&rnd=' + Math.random(),
                    idFieldName: 'id',
                    //parentIDFieldName: 'pid',
                    checkbox: false
                },
                onSelected: function (newvalue) {
                    $.get("../../data/hr_employee.ashx?Action=combo&did=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                        k.setData(eval(data));
                    });
                }
            });
        }
        //楼盘
        function f_selectComm() {
            top.$.ligerDialog.open({
                zindex: 9003,
                title: '选择楼盘小区', width: 850, height: 400,

                //url: " hr/Getemp_Auth.aspx?auth=1", buttons: [
                url: "CRM/Customer/SelectCommunity.aspx", buttons: [
                    { text: '确定', onclick: f_selectCommOK },
                    { text: '取消', onclick: f_selectContactCancel }
                ]
            });
            return false;
        }
        function f_selectCommOK(item, dialog) {
            var data = dialog.frame.f_select();
            if (!data) {
                alert('请选择楼盘小区!');
                return;
            }
            filltempComm(data.id, data.Name);
            dialog.close();
        }
        function filltempComm(newvalue, text) {
            $('#T_Community_val').val(newvalue);
            $("#T_Community").val(text)
        }
        function serchpanel() {
            initSerchForm();
            if ($(".az").css("display") == "none") {
                $("#grid").css("margin-top", $(".az").height() + "px");
                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();
            }
            else {
                $("#grid").css("margin-top", "0px");
                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();
            }
            $("#company").focus();
        }
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
            manager.GetDataByURL("../../data/crm_customer.ashx?" + serchtxt);

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
                            text: '保存', onclick: function (item, dialog) {
                                f_save(item, dialog);
                            }
                        },
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function toimport() {
            var dialogOptions = {
                width: 540, height: 295, title: '客户导入', url: 'crm/customer/customer_import.aspx', buttons: [
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }

        function add() {
            f_openWindow("CRM/Customer/Customer_add.aspx", "新增客户", 660, 550);
        }

        function addContact() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("CRM/Customer/Customer_Contact_add.aspx?Customer_id=" + row.id, "新增联系人", 730, 450);
            }
            else {
                $.ligerDialog.warn('请选择要添加其他联系人的客户行！');
            }
        }

        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
               
                    f_openWindow('CRM/Customer/Customer_add.aspx?cid=' + row.id, "修改客户", 660, 550);
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        function sedit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
              
                    f_openWindow('CRM/Customer/Customer_add_GJXG.aspx?cid=' + row.id, "客户高级修改", 400, 400);
              
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }

        //提交施工
        function subconstruct() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ajax({
                    url: "../../data/CRM_CEStage.ashx", type: "POST",
                    data: { Action: "customersavecestage", id: row.id, rnd: Math.random() },
                    success: function (responseText) {
                        if (responseText == "true") {
                            top.$.ligerDialog.alert('提交成功！！！');
                            //f_reload();
                            //f_followreload();
                        }
                        else if (responseText == "false") {
                            top.$.ligerDialog.error('提交失败！');
                        }
                        
                        else if (responseText == "false:exist") {
                            top.$.ligerDialog.error('提交失败！已经存在');
                        }

                    },
                    error: function () {
                        top.$.ligerDialog.error('提交失败！');
                    }
                });
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }

        var activeDialog = null;
        function f_openWindow_view(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialog = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        function viewkjl(url, newname) {
            window.open(url + "&width=" + screen.width +
                                "&height=" + (screen.height - 70), newname,
                                "top=0,left=0,toolbar=no, menubar=no, scrollbars=yes,resizable=no,location=no,status=no,width=" +
                                screen.width + ",height=" +
                                (screen.height - 70));
        }

        function editt(){
         
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
               
                viewkjl('../../CRM/ConsExam/kjl_index.aspx?cid=' + row.id
                    + '&name=' + encodeURI('【' + row.Customer + '】' + row.address),
                    "编辑效果图");
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
           
        }
        function viewdy() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
               // viewkjl('../../CRM/ConsExam/kjl_index.aspx?cid=' + row.id+ '&name=' + encodeURI("【" + row.Customer + "】" + row.address), "【" + row.address + "】");
                f_openWindow_view('CRM/Customer/Customer_DynamicGraphics.aspx?cid=' + row.id + '&name=' + encodeURI(row.Customer)
                        + '&tel=' + row.tel
                        + '&sjs=' + encodeURI(row.Emp_sj), "【"+row.address+"】全景图库", 660, 550);
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }

        function f_selectContactCancel(item, dialog) {
            dialog.close();
            //fload();
        }
        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("确定就隐藏吗？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/CRM_Customer.ashx", type: "POST",
                            data: { Action: "AdvanceDelete", id: row.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    f_reload();
                                    f_followreload();
                                }
                                else if (responseText == "delfalse") {
                                    top.$.ligerDialog.error('权限不够，删除失败！');
                                }
                                else if (responseText == "false") {
                                    top.$.ligerDialog.error('未知错误，删除失败！');
                                }
                                else {
                                    top.$.ligerDialog.warn('此客户下含有 ' + responseText + '，删除失败！请先先将这些数据删除。');
                                }

                            },
                            error: function () {
                                top.$.ligerDialog.error('删除失败！');
                            }
                        });
                    }
                });
            }
            else {
                $.ligerDialog.warn("请选择客户");
            }
        }
        function toexport() {
            var sendtxt = "&Action=ToExcel&rnd=" + Math.random();
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
            var url = "../../data/crm_customer.ashx?" + serchtxt;

            window.open(url);
        }
        function f_save(item, dialog) {
            var issave = dialog.frame.f_save();
        
            if (issave) {
                dialog.close();

                $.ajax({
                    url: "../../data/CRM_Customer.ashx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('数据保存中,请稍候...');
                    },
                    success: function (responseText) {

                        f_reload();
                        top.flushiframegrid("tabid5");
                    },
                    error: function () {
                        top.$.ligerDialog.error('操作失败！');
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
        function follow_openWindow(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                        {
                            text: '保存', onclick: function (item, dialog) {
                                f_savefollow(item, dialog);
                            }
                        },
                        {
                            text: '关闭', onclick: function (item, dialog) {
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
                follow_openWindow("CRM/Customer/Customer_follow_add.aspx?cid=" + row.id, "新增跟进", 530, 400);
            } else {
                $.ligerDialog.warn('请选择客户！');
            }
        }
        function editfollow() {
            var manager = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                follow_openWindow('CRM/Customer/Customer_follow_add.aspx?fid=' + row.id + "&cid=" + row.Customer_id, "修改跟进", 530, 400);
            } else {
                $.ligerDialog.warn('请选择跟进！');
            }
        }
        function delfollow() {
            var manager = $("#maingrid5").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("跟进删除无法恢复，确定删除？", function (yes) {
                    if (yes) {
                        $.ajax({
                            url: "../../data/CRM_Follow.ashx", type: "POST",
                            data: { Action: "del", id: row.id, rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                    f_followreload();
                                    f_reload();
                                }
                                else {
                                    top.$.ligerDialog.error('删除失败！');
                                }

                            },
                            error: function () {
                                top.$.ligerDialog.error('删除失败！');
                            }
                        });
                    }
                })
            }
            else {
                $.ligerDialog.warn("请选择跟进");
            }
        }
        function f_savefollow(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();
                $.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/CRM_Follow.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        $.ligerDialog.closeWaitting();
                        f_followreload();
                        f_reload();
                        top.flushiframegrid("tabid6");
                    },
                    error: function () {
                        $.ligerDialog.closeWaitting();
                        $.ligerDialog.error('操作失败！');
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
            <div id="maingrid4" style="margin: -1px; min-width: 800px;"></div>
            <div id="toolbar1"></div>
            <div id="Div1" style="position: relative;">
                <div id="maingrid5" style="margin: -1px -1px;"></div>
            </div>
        </div>


    </form>
    <div class="az">
        <form id='serchform'>
            <table style='width: 960px' class="bodytable1">
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>客户姓名：</div>
                    </td>
                    <td>
                        <input type='text' id='company' name='company' ltype='text' ligerui='{width:120}' /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>客户类型：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='customertype' name='customertype' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='customerlevel' name='customerlevel' />
                        </div>
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>录入时间：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='startdate' name='startdate' ltype='date' ligerui='{width:97}' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='enddate' name='enddate' ltype='date' ligerui='{width:96}' />
                        </div>
                    </td>
                    <td>
                        <input id='keyword' name="keyword" type='text' ltype='text' ligerui='{width:196, nullText: "输入关键词搜索地址、描述、备注"}' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>所在楼盘：</div>
                    </td>
                    <td>
                        <input id='T_Community' name="T_Community" type='text' /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>所属省市：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='T_Provinces' name='T_Provinces' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='T_City' name='T_City' />
                        </div>
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>最后跟进：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='startfollow' name='startfollow' ltype='date' ligerui='{width:97}' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='endfollow' name='endfollow' ltype='date' ligerui='{width:96}' />
                        </div>
                    </td>

                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>电话：</div>
                    </td>
                    <td>
                        <input type='text' id='tel' name='tel' ltype='text' ligerui='{width:120}' />
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>所属区镇：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='T_Towns' name='T_Towns' />
                        </div>

                    </td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>业务员：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='department' name='department' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='employee' name='employee' />
                        </div>
                    </td>
                    <td>

                        <input id='Button2' type='button' value='重置' style='width: 80px; height: 24px'
                            onclick="doclear()" />
                        <input id='Button1' type='button' value='搜索' style='width: 80px; height: 24px' onclick="doserch()" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>客户来源：</div>
                    </td>
                    <td>
                        <input type='text' id='cus_sourse' name='cus_sourse' />
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>施工监理：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='department_sg' name='department_sg' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='employee_sg' name='employee_sg' />
                        </div>
                    </td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>设计师：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='department_sj' name='department_sj' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='employee_sj' name='employee_sj' />
                        </div>
                    </td>
                </tr>
                                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>微信状态：</div>
                    </td>
                    <td>
                        <input type='text' id='WXZHT' name='WXZHT' /> 
                    </td>
                                    <td>
                        <div style='width: 60px; text-align: right; float: right'>地图状态：</div>
                    </td>
                    <td>
                             <input id="t_mapstasus" name="t_mapstasus" type="text" ltype="select" ligerui="{width:196,data:[{id:'0',text:'全部'},{id:'1',text:'已标地图'},{id:'2',text:'未标地图'}]}"  /></td>
           
                     
                 
                    

                    <td>
                        <div style='width: 60px; text-align: right; float: right'></div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                           
                        </div>
                        <div style='width: 98px; float: left'>
                            
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <form id='toexcel'></form>
</body>
</html>
