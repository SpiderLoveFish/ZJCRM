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
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=scRTGd7FxTc8S5I8p7OgZxyp"></script>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"> </script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <title>地图单击事件</title>
</head>
<body>
    <div id="toolbar"> </div>

   
    <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
    <div id="allmap"></div>
    <input type="hidden" id="T_xy" name="T_xy" />
</body>
</html>
<script type="text/javascript">
    var xy = getparastr("xy"), x, y;
    $(function () {
        toolbar();
        resize();
        $(window).resize(function () {
            resize();
        });
    })

    // 百度地图API功能
    var map = new BMap.Map("allmap");
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    x = 116.404, y = 39.915;

    var point = new BMap.Point(x, y)
    map.centerAndZoom(point, 8);


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
    function G(id) {
        return document.getElementById(id);
    }
    var mapType1 = new BMap.MapTypeControl({ mapTypes: [BMAP_NORMAL_MAP, BMAP_HYBRID_MAP] });

    var overView = new BMap.OverviewMapControl();
    var overViewOpen = new BMap.OverviewMapControl({ isOpen: true, anchor: BMAP_ANCHOR_BOTTOM_RIGHT });
    //添加地图类型和缩略图
    //map.addControl(mapType1);          //2D图，卫星图
    map.addControl(overView);          //添加默认缩略地图控件
    map.addControl(overViewOpen);      //右下角，打开

    if (xy) {
        arr = xy.split(',');

        if (arr != "undefined") {
            //alert();
            x = arr[0], y = arr[1];
            $("#T_xy").val(xy);

            point = new BMap.Point(x, y)
            setTimeout(function () {
                map.panTo(point);
                map.setZoom(16);
            }, 500)


            var marker = new BMap.Marker(point); // 创建点
            map.addOverlay(marker);    //增加点
        }
    }
    else {
        getCity();
    }

    function showInfo(e) {
        map.clearOverlays();
        xy = e.point.lng + ", " + e.point.lat;
        $("#T_xy").val(xy);
        var marker = new BMap.Marker(new BMap.Point(e.point.lng, e.point.lat)); // 创建点
        //marker.addEventListener("click",attribute);
        map.addOverlay(marker);    //增加点
    }
    map.addEventListener("click", showInfo);

    function search(value) {
        map.centerAndZoom(value, 12);
        var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
		{
		    "input": "suggestId"
		, "location": map
		});

        ac.addEventListener("onhighlight", function (e) {  //鼠标放在下拉列表上的事件
            var str = "";
            var _value = e.fromitem.value;
            var value = "";
            if (e.fromitem.index > -1) {
                value = _value.province + _value.city + _value.district + _value.street + _value.business;
            }
            str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;

            value = "";
            if (e.toitem.index > -1) {
                _value = e.toitem.value;
                value = _value.province + _value.city + _value.district + _value.street + _value.business;
            }
            str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
            G("searchResultPanel").innerHTML = str;
        });

        var myValue;
        ac.addEventListener("onconfirm", function (e) {    //鼠标点击下拉列表后的事件
            var _value = e.item.value;
            myValue = _value.province + _value.city + _value.district + _value.street + _value.business;
            G("searchResultPanel").innerHTML = "onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;

            setPlace();
        });

        function setPlace() {
            map.clearOverlays();    //清除地图上所有覆盖物
            function myFun() {
                var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
                map.centerAndZoom(pp, 18);
                map.addOverlay(new BMap.Marker(pp));    //添加标注
            }
            var local = new BMap.LocalSearch(map, { //智能搜索
                onSearchComplete: myFun
            });
            local.search(myValue);
        }
        // var local = new BMap.LocalSearch(map, {
        //    renderOptions: { map: map }
        // });
        // local.search("夏桥家园");
    }

    //工具条实例化
    function toolbar() {

        //alert(data);
        var items = [];

        items.push({
            type: 'textbox',
            id: 'T_Provinces',
            text: '城市：'
        });
        items.push({
            type: 'textbox',
            id: 'T_City'
        });
        items.push({
            type: 'textbox',
            id: 'suggestId'
        });
        items.push({
            type: 'text',
            text: '注意：请自行标注，然后点击保存，再点击客户信息的保存按钮。'
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
    function f_save() {
        var xy_val = $("#T_xy").val();
        if (xy_val)
            return xy_val
        else {
            alert('还未标注！')
            return false;
        }
    }
    function getCity() {
        $.get("../../data/hr_employee.ashx?Action=getDefaultCity", Math.random(), function (data) {
            if (data)
                search(data);
        })
    }
</script>
