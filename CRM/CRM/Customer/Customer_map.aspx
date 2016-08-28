<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
        body, html { width: 100%; height: 100%; margin: 0; font-family: "微软雅黑"; font-family: "微软雅黑"; }
        #allmap { width: 100%; height: 100%; }
        p { margin-left: 5px; font-size: 14px; }
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=qBF1ENAhEgKANMrT9gikGXa9"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
    <link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
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
    <title>地图单击事件</title>
</head>
<body>
    <div id="toolbar"></div>
    <div id="allmap"></div>
       <div id="grid">
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
  </body>
</html>
<script type="text/javascript">
    $(function () {
        toolbar();
        resize();
        $(window).resize(function () {
            resize();
        });
       
        getPoint("");
        getCity();
    })
    // 百度地图API功能
    var map = new BMap.Map("allmap");
    var point = new BMap.Point(112.991158, 28.191666);
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    map.centerAndZoom(point, 15);

    // 添加带有定位的导航控件
    var navigationControl = new BMap.NavigationControl({
        // 靠左上角位置
        anchor: BMAP_ANCHOR_TOP_LEFT,
        // LARGE类型
        type: BMAP_NAVIGATION_CONTROL_LARGE
        // 启用显示定位
        //enableGeolocation: true
    });
    map.addControl(navigationControl);

    var mapType1 = new BMap.MapTypeControl({ mapTypes: [BMAP_NORMAL_MAP, BMAP_HYBRID_MAP] });

    var overView = new BMap.OverviewMapControl();
    var overViewOpen = new BMap.OverviewMapControl({ isOpen: true, anchor: BMAP_ANCHOR_BOTTOM_RIGHT });
    //添加地图类型和缩略图
    //map.addControl(mapType1);          //2D图，卫星图
    map.addControl(overView);          //添加默认缩略地图控件
    map.addControl(overViewOpen);      //右下角，打开



    //    var label = new BMap.Label("小黄豆软件集团"+i, { offset: new BMap.Size(20, -10) });
    //    marker.setLabel(label);
    //}
    //var city = new BMap.LocalSearch(map, {
    //    renderOptions: {
    //        map: map,
    //        autoViewport: true
    //    }

    //});

    function search(value) {
       
        //city.search(value);
        //setTimeout(function () {
        //    map.setZoom(14);
        //}, 1000)
        map.centerAndZoom(value, 12);
    }

    function initSerchForm() {
        $("#company").addClass("l-text");
        $("#tel").addClass("l-text");
     
        $('#t_mapstasus').ligerComboBox({
            width: 100,
            selectBoxWidth: 100,
            selectBoxHeight: 100,
            valueField: 'id',
            textField: 'text',
            treeLeafOnly: false,
            tree: {
                data:[{id:'0',text:'全部'},{id:'1',text:'已标地图'},{id:'2',text:'未标地图'}],
                checkbox: false
            }
        });
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
        $('#T_Community').ligerComboBox({ width: 120, emptyText: '（空）', url: "../../data/Param_City.ashx?Action=getBuilding&rnd=" + Math.random() });
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
    function serchpanel() {
        initSerchForm();
        if ($(".az").css("display") == "none") {
            $("#grid").css("margin-top", $(".az").height() + "px");
         
        }
        else {
            $("#grid").css("margin-top", "0px");
          
        }
        $("#company").focus();
    }
    function doserch() {
    
        var sendtxt = "&rnd=" + Math.random();
        var serchtxt = $("#serchform :input").fieldSerialize() + sendtxt;
         //alert(serchtxt);
        getPoint("&"+serchtxt);
    }
    function doclear() {
        //var serchtxt = $("#serchform :input").reset();
        $("#serchform").each(function () {
            this.reset();
            $(".l-selected").removeClass("l-selected");
        });
    }

    //工具条实例化
    function toolbar() {

        var items = [];
        items.push({ type: 'textbox', id: 'T_Provinces', text: '城市：' });
        items.push({ type: 'textbox', id: 'T_City' });
        items.push({ type: 'button', text: '设为默认', icon: '../../images/icon/67.png', disable: true, click: function () { defaultCity() } });

        items.push({ type: "filter", icon: '../../images/icon/51.png', title: "帮助", click: function () { help(); } })
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

        b = $('#T_City').ligerComboBox({ width: 96, emptyText: '（空）', onSelected: function (newvalue, newtext) { search(newtext); } });
        c = $('#T_Provinces').ligerComboBox({
            width: 97,
            url: "../../data/Param_City.ashx?Action=combo1&rnd=" + Math.random(),
            onSelected: function (newvalue, newtext) {
                if (!newvalue)
                    newvalue = -1;
                $.get("../../data/Param_City.ashx?Action=combo2&pid=" + newvalue + "&rnd=" + Math.random(), function (data, textStatus) {
                    b.setData(eval(data));
                });
                search(newtext);
            }, emptyText: '（空）'
        });


    }
    function resize() {
        var h = document.documentElement.clientHeight;
        $("#allmap").height(h - $("#toolbar").height());
    }

    function defaultCity() {
        var city = $("#T_City").val() || $("#T_Provinces").val() || "";
        if (!city) {
            $.ligerDialog.warn('请选择城市再设置！');
            return;
        }
         
        $.ajax({

            url: "../../data/hr_employee.ashx?Action=updateDefaultCity",
            type: "POST",
            data: { city: city },
            success: function (responseText) {
                $.ligerDialog.success('设置成功！');
            },
            error: function () {
                $.ligerDialog.error('操作失败！');
            }
        });

    }
    function getPoint(stwhere) {
        map.clearOverlays();
        $.ajax({
            url: "../../data/CRM_Customer.ashx?Action=getMapList&type=map" + stwhere,
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                var rows = data.Rows;
                var arr = new Array();
                var point = new Array(); //存放标注点经纬信息的数组
                var marker = new Array(); //存放标注点对象的数组
                var info = new Array(); //存放提示信息窗口对象的数组
                var searchInfoWindow = new Array();//存放检索信息窗口对象的数组
                for (var i = 0; i < rows.length; i++) {
                    arr = rows[i].xy.split(",")

                    if (arr.length != 2) {
                        continue;
                    }

                    var p0 = arr[0]; //
                    var p1 = arr[1]; //按照原数组的point格式将地图点坐标的经纬度分别提出来
                    point[i] = new window.BMap.Point(p0, p1); //循环生成新的地图点
                    marker[i] = new window.BMap.Marker(point[i]); //按照地图点坐标生成标记
                    map.addOverlay(marker[i]);
                    //marker[i].setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
                    //显示marker的title，marker多的话可以注释掉
                    var label = new window.BMap.Label(rows[i].address, { offset: new window.BMap.Size(20, -10) });
                   marker[i].setLabel(label);
                    // 创建信息窗口对象
                    info[i] = "<div style='margin:0;line-height:20px;padding:2px;'>" + "【地址】：" + rows[i].address + "</br> 【电话】：" + rows[i].tel + "</div>";
                    //创建百度样式检索信息窗口对象                       
                    searchInfoWindow[i] = new BMapLib.SearchInfoWindow(map, info[i], {
                        title: "【客户】" + rows[i].Customer,      //标题                        
                        panel: "panel",         //检索结果面板
                        enableAutoPan: true,     //自动平移
                        searchTypes: [
                            BMAPLIB_TAB_SEARCH,   //周边检索
                            //BMAPLIB_TAB_TO_HERE,  //到这里去
                            BMAPLIB_TAB_FROM_HERE //从这里出发
                        ]
                    });
                    //添加点击事件
                    marker[i].addEventListener("click",
                        (function (k) {
                            // js 闭包
                            return function () {
                                //将被点击marker置为中心
                                map.centerAndZoom(point[k], 16);
                                //在marker上打开检索信息窗口
                                searchInfoWindow[k].open(marker[k]);
                            }
                        })(i)
                    );
                }
            }
        });
    }

    function getCity() {
        $.get("../../data/hr_employee.ashx?Action=getDefaultCity", Math.random(), function (data) {
            if (data)
                search(data);
        })
    }

</script>
