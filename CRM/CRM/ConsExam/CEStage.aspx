﻿<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
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
    <style type="text/css">
       .gj
       {font-size: 14px;color:red;margin: 10px 5px 0 0;text-align: right;
       }
       .blue
       {font-size: 14px;color:blue;margin: 10px 5px 0 0;text-align: right;
       }
       </style>
    <script type="text/javascript">
        var manager = "";
        var szDevIP = "";
        var type = ""; var follow_type = "sg";
        var cid = "";
        $(function () {
          
            type = getparastr("type");
           //工地管理
            var strurl = "../../data/Crm_CEStage.ashx?Action=grid&status=0";
            //售后管理
            if (type == "1") {
                strurl = "../../data/Crm_CEStage.ashx?Action=grid&status=1";
                follow_type = "sh";
            }
            //全部
            if (type == "all") {
                strurl = "../../data/Crm_CEStage.ashx?Action=grid";
                //document.getElementById("status1").style.display = "block";
                //document.getElementById("status").style.display = "block";
            }
            else {

                document.getElementById("status").style.display = "none";
                document.getElementById("status1").style.display = "none";
            }
           // alert(strurl)
            if (type == "1") {
                $("#maingrid4").ligerGrid({
                    columns: [
                        {
                            display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; }
                        },
                        // { display: '客户编号', name: 'CustomerID', width: 50, align: 'left' },
                        {
                            display: '客户姓名', name: 'CustomerName', width: 80, render: function (item) {
                                var html = "<a href='javascript:void(0)' onclick=view(1," + item.CustomerID + ")>";
                                if (item.CustomerName)
                                    html += item.CustomerName;
                                html += "</a>";
                                return html;
                            }
                        },
                        //{ display: '姓名', name: 'CustomerName', width: 60, align: 'left' },
                        {
                            display: '电话', name: 'tel', align: 'left', width: 40, render: function (item) {
                                var html = "<div class='abc'>";
                                if (item.tel)
                                    html += item.tel;
                                html += "</div>";
                                return html;
                            }
                        },
                        { display: '客户地址', name: 'address', width: 150, align: 'left' },
                        { display: '施工监理', name: 'sgjl', width: 80, align: 'left' },
                        { display: '业务员', name: 'ywy', width: 80, align: 'left' },
                        // { display: '设计师', name: 'sjs', width: 120, align: 'left' },
                      //  { display: '附加分', name: 'SpecialScore', width: 50, align: 'right' },
                       // {
                        //    display: '考核分', name: 'StageScore', width: 50, align: 'right', render: function (item) {
                        //        return "<div style='color:#135294'>" + item.StageScore + "</div>";
                       //     }
                      //  },



                       // { display: '总得分', name: 'sum_Score', width: 50, align: 'right' },
                       // { display: '满分', name: 'TotalScorce', width: 50, align: 'right' },
                       // {
                         //   display: '达成率', name: 'Scoring', width: 80, align: 'right', render: function (item) {

                        //        var html;
                        //        if (item.sum_Score / item.TotalScorce > 0.9) {
                        //            html = "<div style='color:#008040'>";
                        //            if (item.Scoring)
                        //                html += item.Scoring;
                        //            html += "</div>";
                        //        }
                        //        else
                        //            if (item.sum_Score / item.TotalScorce > 0.5) {
                        //                html = "<div style='color:#800040'>";
                        //                if (item.Scoring)
                        //                    html += item.Scoring;
                        //                html += "</div>";
                        //            }
                        //            else
                        //                html = "<div style='color:#F00'>" + item.Scoring + "</div>";
                        //        return html;
                        //    }
                        //},
                        {
                            display: '要求日期', name: 'Jh_date', width: 90, align: 'left', render: function (item) {
                                return formatTimebytype(item.Jh_date, 'yyyy/MM/dd');
                            }
                        },
                        {
                            display: '竣工日期', name: 'EndDate', width: 90, align: 'left', render: function (item) {
                                return formatTimebytype(item.EndDate, 'yyyy/MM/dd');
                            }
                        },

                        //{
                        //    display: '现状', name: 'Jh_date', width: 100, align: 'left', render: function (item) {
                        //        var html;
                        //        var myDate = new Date();
                        //        var days = getdays(formatTimebytype(item.Jh_date, 'yyyy/MM/dd'), myDate);
                        //        days = -days;
                        //        if (days < 0)
                        //            html = "<span  class='gj'> 拖期 " + days * -1 + " 天</span>";
                        //        else
                        //            html = "<span  class='blue'>剩余 " + days + " 天</span>";




                        //        return html;
                        //    }
                        //},
                        { display: '状态', name: 'Stage_icon', width: 80, align: 'left' },
                        //{
                        //    display: '摄像头', name: 'CompName', width: 80, align: 'left', render: function (item) {

                        //        var html;
                        //        if (item.CompName == "无") {

                        //            html = item.CompName;
                        //        }
                        //        else {
                        //            html = "<div style='color:#FF0000 '>";
                        //            if (item.Scoring)
                        //                html += '有-' + item.CompName;
                        //            html += "</div>";
                        //        }

                        //        return html;
                        //    }
                        //},
                        { display: '备注', name: 'Remarks', width: 100, align: 'left' }

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
                    width: '100%', height: '65%',
                    //tree: { columnName: 'StageDescription' },
                    heightDiff: -1,
                    onRClickToSelect: true,
                    onContextmenu: function (parm, e) {
                        actionCustomerID = parm.data.id;
                        menu.show({ top: e.pageY, left: e.pageX });
                        return false;
                    },
                    onSelectRow: function (data, rowindex, rowobj) {
                        var manager = $("#maingrid5").ligerGetGridManager();
                        manager.showData({ Rows: [], Total: 0 });
                        var url = "../../data/CRM_Follow.ashx?Action=grid&customer_id=" + data.CustomerID + "&sectype1=" + follow_type;
                        manager.GetDataByURL(url);
                    }

                });
            }
            else {  $("#maingrid4").ligerGrid({
                    columns: [
                        {
                            display: '序号', width: 50, render: function (rowData, rowindex, value, column, rowid, page, pagesize) { return (page - 1) * pagesize + rowindex + 1; }
                        },
                        // { display: '客户编号', name: 'CustomerID', width: 50, align: 'left' },
                        {
                            display: '客户姓名', name: 'CustomerName', width: 80, render: function (item) {
                                var html = "<a href='javascript:void(0)' onclick=view(1," + item.CustomerID + ")>";
                                if (item.CustomerName)
                                    html += item.CustomerName;
                                html += "</a>";
                                return html;
                            }
                        },
                        //{ display: '姓名', name: 'CustomerName', width: 60, align: 'left' },
                        {
                            display: '电话', name: 'tel', align: 'left', width: 40, render: function (item) {
                                var html = "<div class='abc'>";
                                if (item.tel)
                                    html += item.tel;
                                html += "</div>";
                                return html;
                            }
                        },
                        { display: '客户地址', name: 'address', width: 150, align: 'left' },
                        { display: '施工监理', name: 'sgjl', width: 80, align: 'left' },
                        { display: '业务员', name: 'ywy', width: 80, align: 'left' },
                        {
                         display: '公司收款￥', name: 'CollectedAmount', width: 100, align: 'right', render: function (item) {
                             return "<div style='color:#135294'>" + toMoney(item.CollectedAmount) + "</div>";
                         }
                        },
                         {
                         display: '材料成本￥', name: 'MaterialCost', width: 100, align: 'right', render: function (item) {
                             return "<div style='color:#135294'>" + toMoney(item.MaterialCost) + "</div>";
                         }
                        },
                          {
                         display: '人工成本￥', name: 'LabourCost', width: 100, align: 'right', render: function (item) {
                             return "<div style='color:#135294'>" + toMoney(item.LabourCost) + "</div>";
                         }
                        },
                           {
                         display: '施工利润￥', name: 'ConstructionProfit', width: 100, align: 'right', render: function (item) {
                             return "<div style='color:#135294'>" + toMoney(item.ConstructionProfit) + "</div>";
                         }
                     },
                        // { display: '设计师', name: 'sjs', width: 120, align: 'left' },
                       
                        {
                            display: '要求日期', name: 'Jh_date', width: 90, align: 'left', render: function (item) {
                                return formatTimebytype(item.Jh_date, 'yyyy/MM/dd');
                            }
                        },
                        {
                            display: '竣工日期', name: 'EndDate', width: 90, align: 'left', render: function (item) {
                                return formatTimebytype(item.EndDate, 'yyyy/MM/dd');
                            }
                        },

                        {
                            display: '现状', name: 'Jh_date', width: 100, align: 'left', render: function (item) {
                                var html;
                                var myDate = new Date();
                                var days = getdays(formatTimebytype(item.Jh_date, 'yyyy/MM/dd'), myDate);
                                days = -days;
                                if (days < 0)
                                    html = "<span  class='gj'> 拖期 " + days * -1 + " 天</span>";
                                else
                                    html = "<span  class='blue'>剩余 " + days + " 天</span>";




                                return html;
                            }
                        },
                        //{ display: '状态', name: 'Stage_icon', width: 80, align: 'left' },
                        //{
                        //    display: '摄像头', name: 'CompName', width: 80, align: 'left', render: function (item) {

                        //        var html;
                        //        if (item.CompName == "无") {

                        //            html = item.CompName;
                        //        }
                        //        else {
                        //            html = "<div style='color:#FF0000 '>";
                        //            if (item.Scoring)
                        //                html += '有-' + item.CompName;
                        //            html += "</div>";
                        //        }

                        //        return html;
                        //    }
                        //},
                         { display: '附加分', name: 'SpecialScore', width: 50, align: 'right' },
                        {
                            display: '考核分', name: 'StageScore', width: 50, align: 'right', render: function (item) {
                                return "<div style='color:#135294'>" + item.StageScore + "</div>";
                            }
                        },



                        { display: '总得分', name: 'sum_Score', width: 50, align: 'right' },
                        { display: '满分', name: 'TotalScorce', width: 50, align: 'right' },
                        {
                            display: '达成率', name: 'Scoring', width: 80, align: 'right', render: function (item) {

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
                        { display: '备注', name: 'Remarks', width: 100, align: 'left' }

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
                    width: '100%', height: '65%',
                    //tree: { columnName: 'StageDescription' },
                    heightDiff: -1,
                    onRClickToSelect: true,
                    onContextmenu: function (parm, e) {
                        actionCustomerID = parm.data.id;
                        menu.show({ top: e.pageY, left: e.pageX });
                        return false;
                    },
                    onSelectRow: function (data, rowindex, rowobj) {
                        var manager = $("#maingrid5").ligerGetGridManager();
                        manager.showData({ Rows: [], Total: 0 });
                         cid = data.CustomerID;
                        var url = "../../data/CRM_Follow.ashx?Action=grid&customer_id=" + data.CustomerID + "&sectype1=" + follow_type;
                        manager.GetDataByURL(url);
                    }

                });}
            $("#maingrid5").ligerGrid({
                columns: [
                        { display: '序号', width: 40, render: function (item, i) { return i + 1; } },

                         {
                             display: '来源', name: 'lx', width: 60, render: function (item) {
                                 var html;
                                 if (item.lx == "客户") {
                                     html = "<div style='color:#339900'>";
                                     html += item.lx;
                                     html += "</div>";
                                 }
                                 else if (item.lx == "售后") {
                                     html = "<div style='color:#FF0000'>";
                                     html += item.lx;
                                     html += "</div>";
                                 }
                                 else if (item.lx == "维修") {
                                     html = "<div style='color:#CC0000'>";
                                     html += item.lx;
                                     html += "</div>";
                                 }
                               
                                 else {
                                     html = item.lx;
                                 }
                                 return html;
                             }
                         },
                        {
                            display: '跟进内容', name: 'Follow', align: 'left', width: 400, render: function (item) {
                                var html = "<div class='abc'><a href='javascript:void(0)' onclick=view(12," + item.id + ")>";
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
                url: "../../data/CRM_Follow.ashx?Action=grid&customer_id=0" + "&sectype1=" + follow_type,
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


            initLayout();
            $(window).resize(function () {
                initLayout();
            });
            $("#grid").height(document.documentElement.clientHeight - $(".toolbar").height());
            $('form').ligerForm();
            toolbar();
        });

        function getdays(dtbegin, dtend) {
            var ts = parseInt(new Date(dtend).getTime() - new Date(dtbegin).getTime());
            var days = Math.floor(ts / (24 * 3600 * 1000))
            return days;
        }

        function toolbar() {
            //工地管理
            var strurl ="../../data/toolbar.ashx?Action=GetSys&mid=135&rnd=" + Math.random();
            //售后管理
            if (type == "1") strurl = "../../data/toolbar.ashx?Action=GetSys&mid=192&rnd=" + Math.random();
            //全部
            if (type == "all") {
                strurl = "../../data/toolbar.ashx?Action=GetSys&mid=193&rnd=" + Math.random();
            }
         
                $.getJSON(strurl, function (data, textStatus) {
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
                    text: ''
                });
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

                var items1 = [];
                items1.push({ line: true });
                items1.push({
                    type: 'textbox',
                    id: 'sectype1',
                    name: 'sectype1',
                    text: '筛选'
                });
                items1.push({
                    type: 'textbox',
                    id: 'T_smart',
                    name: 'T_smart',
                    text: ''
                });
                items1.push({
                    type: 'button',
                    text: '搜索',
                    icon: '../../images/search.gif',
                    disable: true,
                    click: function () {
                        doserch1()
                    }
                }); 
                $("#toolbar1").ligerToolBar({
                    items: items1
                });
               var a= $('#sectype1').ligerComboBox({
                    width: 180,
                    isMultiSelect: true,
                    selectBoxWidth: 200,
                    selectBoxHeight: 100,
                    valueField: 'id',
                    textField: 'text',
                    treeLeafOnly: true,
                    tree: {
                        data: [
                            { id: '', text: '全部' },
                            { id: 'kh', text: '客户' },
                            { id: 'sg', text: '施工' },
                            { id: 'wx', text: '维修' },
                            { id: 'sh', text: '售后' } 


                        ],
                        checkbox: false
                    }
                });
               if (type == "1")
                   a.selectValue("sh");
               else 
                   a.selectValue("sg");
                $("#keyword1").ligerTextBox({ width: 200, nullText: "" })
                $("#T_smart").ligerTextBox({ width: 100, nullText: "" })
                $("#maingrid4").ligerGetGridManager().onResize();
                $("#maingrid5").ligerGetGridManager().onResize();
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

        //查询
        function doserch() {
            

            var sendtxt = "&Action=grid&rnd=" + Math.random();
            if (getparastr("type") == "all")
            {
               
            }
           else if (getparastr("type") == "1") {
                sendtxt = sendtxt + "&status=1"
            }
            else sendtxt = sendtxt + "&status=0"
            var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;

            serchtxt = serchtxt + "&" + $("#form1 :input").fieldSerialize();
             //alert(serchtxt);
           
            var manager = $("#maingrid4").ligerGetGridManager();
            manager.GetDataByURL("../../data/Crm_CEStage.ashx?" + serchtxt);

           

        }
        //全景
        function viewdy() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                // viewkjl('../../CRM/ConsExam/kjl_index.aspx?cid=' + row.id+ '&name=' + encodeURI("【" + row.Customer + "】" + row.address), "【" + row.address + "】");
                f_openWindowview('CRM/Customer/Customer_DynamicGraphics.aspx?cid=' + row.CustomerID + '&name=' + encodeURI(row.CustomerName)
                    + '&tel=' + row.tel + "&sjs=" + encodeURI(row.sgjl), "【" + row.address + "】全景图库", 660, 550);
            }
            else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        //查询
        function doserch1() {
            var sendtxt = "&Action=grid&customer_id=" + cid+"&rnd=" + Math.random();
            var serchtxt1 = $("#toolbar1 :input").fieldSerialize() + sendtxt;
            var manager5 = $("#maingrid5").ligerGetGridManager();
            manager5.GetDataByURL("../../data/CRM_Follow.ashx?" + serchtxt1);
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
                            text: '关闭', onclick: function (item, dialog) {
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
        //工程跟进
        function gcgj() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                follow_openWindow("CRM/ConsExam/CEStage_follow_add.aspx?cid=" + row.CustomerID+"&cestageid="+row.id, "新增跟进", 530, 400);
            } else {
                $.ligerDialog.warn('请选择客户！');
            }
        }
        //报修
        function repair() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow_repair("CRM/Repair/Repair_add.aspx?tel="+row.tel, "报修登记", 850, 590);

            } else {
                $.ligerDialog.warn('请选择客户！');
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
                    },
                    error: function () {
                        $.ligerDialog.closeWaitting();
                        $.ligerDialog.error('操作失败！');
                    }
                });

            }
        }

        //查看跟进
        function ckgj() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindowview("CRM/ConsExam/CEStage_follow.aspx?cid=" + row.CustomerID + "&cestageid=" + row.id, "新增跟进", 867, 600);
            } else {
                $.ligerDialog.warn('请选择客户！');
            }
        }
        //明细
        function detail() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindowview("crm/ConsExam/CEStage_ViewDetail.aspx?pid=" + row.id
                    + "&name=" + encodeURI(row.CustomerName)
                    + "&address=" + encodeURI(row.address)
                    + "&sgjl=" + encodeURI(row.sgjl)
                     + "&zf=" + row.TotalScorce
                    + "&dcl=" + row.Scoring
                    + "&df=" + row.sum_Score,
                    "明细查询", 700, 530);
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        //施工进度
        function process() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindowview("crm/ConsExam/SGJD_List_View.aspx?cid=" + row.CustomerID
                    + "&khmc=" + encodeURI(row.CustomerName + "[" + row.address + "]")
                    + "&tel=" + row.tel
                + "&sjzt=" + encodeURI(row.Stage_icon)
                + "&sgjl=" + encodeURI(row.sgjl)
                + "&jhdate=" + row.Jh_date
                   ,
                    "时间轴查询", 800, 550);
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        function purdetail() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindowview("crm/purchase/PurchaseMain_View.aspx?cid=" + row.CustomerID,
                   row.Customer + '【' + row.address + '】-材料使用明细', 1000, 600);
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }
        //退回
        function ret() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ajax({
                    url: "../../data/Crm_CEStage.ashx", type: "POST",
                    data: { Action: "UpdateStatus", id: row.id, status: 0, rnd: Math.random() },
                    success: function (responseText) {
                        if (responseText == "true") {
                            top.$.ligerDialog.closeWaitting();
                            f_reload();
                        }

                        else {
                            top.$.ligerDialog.closeWaitting();
                            top.$.ligerDialog.error('退回失败！');
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('退回失败！', "", null, 9003);
                    }
                });
            } else {
                $.ligerDialog.warn('请选择行！');
            }
            //f_openWindow("crm/ConsExam/CEStage_add.aspx", "新增客户", 700, 330);
        }
        var activeDialog_repair = null;
        function f_openWindow_repair(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: '保存', onclick: function (item, dialog) {
                            f_save_repair(item, dialog);
                        }
                    },
                    {
                        text: '关闭', onclick: function (item, dialog) {
                            dialog.close();
                        }
                    }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };

            activeDialog_repair = parent.jQuery.ligerDialog.open(dialogOptions);

        }
        var activeDialogSg = null;
        function f_openWindow_construct(url, title, width, height) {
            var dialogOptions = {
                width: width, height: height, title: title, url: url, buttons: [
                    {
                        text: '提交', onclick: function (item, dialog) {
                            f_save_construct(item, dialog);
                        }
                    },
                    {
                        text: '关闭', onclick: function (item, dialog) {
                            dialog.close();
                        }
                    }
                ], isResize: true, showToggle: true, timeParmName: 'a'
            };
            activeDialogSg = parent.jQuery.ligerDialog.open(dialogOptions);
        }
        function f_save_construct(item, dialog) {
            var issave = dialog.frame.f_save();
            //alert(issave);
            if (issave) {
                dialog.close();
                $.ajax({
                    url: "../../data/Crm_CEStage.ashx", type: "POST",
                    data: issave +"&status=1",
                    //{ Action: "UpdateStatus", id: row.id, status: 1, rnd: Math.random() },
                    success: function (responseText) {
                        if (responseText == "true") {
                            top.$.ligerDialog.closeWaitting();
                            f_reload();
                        }

                        else {
                            top.$.ligerDialog.closeWaitting();
                            top.$.ligerDialog.error('提交失败！');
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();
                        top.$.ligerDialog.error('提交失败！', "", null, 9003);
                    }
                });

            }
        }
        //提交竣工
        function add() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                if (row.sgjl == '' || row.sgjl == undefined)
                {
                    $.ligerDialog.warn('提交数据时候，施工监理不能为空！');
                    return;
                }
                f_openWindow_construct("crm/Customer/Customer_EndDate.aspx?id=" + row.id,"竣工日期",500,200)
             } else {
                $.ligerDialog.warn('请选择行！');
            }
            //f_openWindow("crm/ConsExam/CEStage_add.aspx", "新增客户", 700, 330);
        }
        //千里眼
        function ipcam() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindowview("crm/IPCam/view.aspx?cid=" + row.CustomerID + "&IPstyle=1", row.address+"监控画面", 900, 600);
            } else {
                $.ligerDialog.warn('请选择客户！');
            }
        }
        function edit() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                f_openWindow("crm/ConsExam/CEStage_add.aspx?cid=" + row.id, "修改客户", 700, 330);
            } else {
                $.ligerDialog.warn('请选择行！');
            }
        }

        function del() {
            var manager = $("#maingrid4").ligerGetGridManager();
            var row = manager.getSelectedRow();
            if (row) {
                $.ligerDialog.confirm("删除不能恢复，确定删除？", function (yes) {
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
                                    top.$.ligerDialog.error('删除失败！');
                                }
                            },
                            error: function () {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('删除失败！', "", null, 9003);
                            }
                        });
                    }
                })
            } else {
                $.ligerDialog.warn("请选择类别！");
            }
        }

        function f_save(item, dialog) {

            var issave = dialog.frame.f_save();

            if (issave) {
                dialog.close();
                top.$.ligerDialog.waitting('数据保存中,请稍候...');
                $.ajax({
                    url: "../../data/CRM_CEStage.ashx", type: "POST",
                    data: issave,
                    success: function (responseText) {
                        top.$.ligerDialog.closeWaitting();
                        if (responseText == "false:type") {
                            top.$.ligerDialog.error('操作失败，施工监理不能为空，请先到客户档案维护！');
                        }
                        else {
                            f_reload();
                        }
                    },
                    error: function () {
                        top.$.ligerDialog.closeWaitting();

                    }
                });

            }
        }

        function f_save_repair(item, dialog) {
            var issave = dialog.frame.f_save();
            if (issave) {
                dialog.close();

                $.ajax({
                    url: "../../CRM/Repair/Repair_Add.aspx", type: "POST",
                    data: issave,
                    beforesend: function () {
                        top.$.ligerDialog.waitting('数据保存中,请稍候...');
                    },
                    success: function (data) {
                        f_reload();
                        //f_followreload();
                        if (data == "")
                            top.$.ligerDialog.success('操作成功！');
                        else
                            top.$.ligerDialog.error('操作失败，错误信息：' + data);
                    },
                    error: function (ex) {
                        top.$.ligerDialog.error('操作失败，错误信息：' + ex.responseText);
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
            top.flushiframegrid("tabid39");
        };
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

                        <input  ltype='text' ligerui='{width:120}' type='text' id='khstext' name='khstext'  /></td>

                    <td>
                        <div style='width: 60px; text-align: right; float: right'>地址：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='dzstext' name='dzstext' ltype='text' ligerui='{width:120}'  />
                        </div>
                    
                    </td>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>电话：</div>
                    </td>
                    <td>
                        <div style='width: 100px; float: left'>
                            <input type='text' id='dhstext' name='dhstext'   ltype='text' ligerui='{width:120}'  />
                        </div>
                       
                    </td>
                    <td>
                          <input id='Button1' type='button' value='搜索' style='width: 80px; height: 24px' onclick="doserch()" />
                  
                        <input id='Button2' type='button' value='重置' style='width: 80px; height: 24px'
                            onclick="doclear()" />
                        </td> 
                </tr>
                <tr>
                    <td>
                        <div style='width: 60px; text-align: right; float: right'>施工监理：</div>
                    </td>
                    <td>
                        <input id='sgjlstext' name="sgjlstext" type='text'  ltype='text' ligerui='{width:120}' /></td>

                    <td id="status">
                        <div style='width: 60px; text-align: right; float: right' >状态：</div>
                    </td>
                    <td id="status1">
                        <div style='width: 100px; float: left'>
                            <input type='text' id='ztstext' name='ztstext'  ltype='text' ligerui="{width:196,data:[{id:'正在施工',text:'正在施工'},{id:'施工完成',text:'施工完成'}]}" validate="{required:false}" />
                        </div>
                         
                    </td>
                    <%--<td>
                        <div style='width: 60px; text-align: right; float: right'>达成率：</div>
                    </td>
                    <td>
                        <div style='width: 300px; float: left'>
                            <input type='text' id='dclbstext' name='dclbstext'    ltype='text'  ligerui="{width:50}" />
                    
                   
                   
                            <input type='text' id='dclestext' name='dclestext'    ltype='text' ligerui="{width:50}"  />
                        </div>
                    </td>--%>
                     <td style='width: 82px;'>
                        <div style='width: 80px; text-align: right; float: right'>竣工日期：</div>
                    </td>
                    <td style='width: 222px;'>
                <div style='width: 100px; float: left'>
                            <input type='text' id='startdate' name='startdate' ltype='date' ligerui='{width:97}' />
                        </div>
                        <div style='width: 98px; float: left'>
                            <input type='text' id='enddate' name='enddate' ltype='date' ligerui='{width:96}' />
                        </div>
                    </td>
                </tr>
               <tr>
                   
                    <td style='width: 62px;'>
                        <div style='width: 60px; text-align: right; float: right'>售后期：</div>
                    </td>
                    <td style='width: 222px;'>
                      <div style="width: 67px; float: left">
                            <input type="text" id="T_shq" name="T_shq" style="width: 66px" 
                                ltype="select" ligerui="{width:66,data:[{id:'1',text:'1年'},{id:'2',text:'2年'},{id:'5',text:'5年'},{id:'0',text:'超过5年'}]}"  />
                        </div>
                    </td>
                      <td style='width: 62px;'>
                        <div style='width: 60px; text-align: right; float: right'>状态：</div>
                    </td>
                    <td style='width: 222px;'>
                      <div style="width: 67px; float: left">
                            <input type="text" id="T_status" name="T_status" style="width: 66px" 
                                ltype="select" ligerui="{width:66,data:[{id:'1',text:'正常'},{id:'2',text:'售后中'}]}"  />
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>


</body>
</html>
