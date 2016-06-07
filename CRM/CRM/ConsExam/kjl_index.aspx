<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
 <link href='http//fonts.googleapis.com/css?family=Economica:700' rel='stylesheet' type='text/css'>
    <link href="../../CSS/kjl/css/style.css" rel="stylesheet" />
      <script src="../../jlui3.2/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
    <script src="../../jlui3.2/lib/json2.js" type="text/javascript"></script>
 <script src="../../JS/XHD.js" type="text/javascript"></script>
     <script src="../../CSS/kjl/js/jquery.js"></script>
		<script src="../../CSS/kjl/js/jquery-migrate-1.1.1.js"></script>
		<script src="../../CSS/kjl/js/script.js"></script>
		<script src="../../CSS/kjl/js/jquery.ui.totop.js"></script>
		<script src="../../CSS/kjl/js/superfish.js"></script>
		<script src="../../CSS/kjl/js/jquery.equalheights.js"></script>
		<script src="../../CSS/kjl/js/jquery.mobilemenu.js"></script>
		<script src="../../CSS/kjl/js/jquery.easing.1.3.js"></script>
    <script type="text/javascript">
      
        var manager = "";
        $(function () {
          //  alert(decodeURI(getparastr("name")));
            $('#id_name').html(decodeURI(getparastr("name")))
            $.ajax({
                url: "../../data/SingleSignOn.ashx", type: "POST",
                data: { Action: "getlistapi", cid: getparastr("cid"), rnd: Math.random() },
                //contentType: "application/json; charset=utf-8",
                //dataType: "json",
                success: function (data) {
                    // alert(JSON.stringify(data));
                    // alert(data);
                    var obj = eval(data);
                    //alert(obj.obsDesignId + obj.obsPlan.name);
                    //names = obj.obsPlan.name
                    //fid = obj.obsPlan.obsPlanId
                    var html="";
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                       // alert(obj[n].simg);
                        //html = "" + obj[n].simg;
                        html += '<div class="p1_box left cl1">' +
                           //'<div class="type"></div>' +
                           '<a style="cursor:pointer;" onclick="list(\'' + obj[n].desid + '\')"><img src=' + obj[n].img + '  ></a>' +
                           '<a onclick="edit(\'' + obj[n].fpId + '\')" class="btn">修改方案</a>' +
                        '<a onclick="editname(\'' + obj[n].fpId + '\')" class="btn">修改名称</a>' +
                        '<a onclick="del(\'' + obj[n].fpId + '\')" class="btn">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;' +
                           '<a  class="btn2" >【户型图】<input id="' + obj[n].fpId + '" type="text" value=' + decodeURI(getparastr('name')) + '></input></a>' +
                       '</div>';
                        if (obj[0].desid != null && obj[0].desid != undefined && obj[0].desid!="")
                             getlist3d(obj[0].desid);
                    }
                    $('#idleft').html(html)
                    if(html.length>0)
                        $('#idlist').html(decodeURI(getparastr("name")) + "方案列表")
                    else $('#idlist').html("无数据，请先新增")
                    //alert(obj[n].obsPlan.obsPlanId + fid);
                    // f_save(savedata, obj[n].obsPlan.obsPlanId);
                     
                },
                error: function () {
                    alert("获取失败");
                     }
            });
        });
     
        function getlist3d(desid) {
            $.ajax({
                url: "../../data/SingleSignOn.ashx", type: "POST",
                data: { Action: "Getlist", desid: desid, rnd: Math.random() },
                //contentType: "application/json; charset=utf-8",
                //dataType: "json",
                success: function (data) {
                    // alert(JSON.stringify(data));
                    // alert(data);
                    var obj = eval(data);
                    //alert(obj.obsDesignId + obj.obsPlan.name);
                    //names = obj.obsPlan.name
                    //fid = obj.obsPlan.obsPlanId
                    var html = ""; var typename = "";
                    $('#3dlist').html(html)
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                        // alert(obj[n].simg);
                        //html = "" + obj[n].simg;
                        if (obj[n].picType == 0)
                            typename = "普通渲染图";
                        else if (obj[n].picType == 1)
                            typename = "全景图";
                        else if (obj[n].picType == 2)
                            typename = "俯视图";
                        html += '<div class="p1_box left cl1">' +
                           //'<div class="type"></div>' +
                           '<a href="javascript:void(0)" onclick="view3d(\'' + obj[n].panoLink + '\')"  style="cursor:pointer;"><img src=' + obj[n].img + ' alt=' + obj[n].panoLink + '  ></a>';
                           if (obj[n].picType == 1)
                        {
                               html += '<a onclick="edit3d(\'' + obj[n].picId + '\')" class="btn">修改方案</a>' +
                               '<a onclick="editname3d(\'' + obj[n].picId + ' \')" class="btn">修改名称</a>' +
                               '<a onclick="del3d(\'' + obj[n].picId + '\')" class="btn">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;';          
                            }
                        html +='<a  class="btn2" >【' + typename + '】<input id="' + obj[n].picId + '" type="text" value=' + obj[n].roomTypeName + '></input></a>' +
                       '</div>';

                    }
                    $('#3dlist').html(html)
                     //alert(obj[n].obsPlan.obsPlanId + fid);
                    // f_save(savedata, obj[n].obsPlan.obsPlanId);

                },
                error: function () {
                    alert('获取失败！');
                 }
            });
        }

        function ajaxdelte(action,fpid,desid)
        {
            $.ajax({
                url: "../../data/SingleSignOn.ashx", type: "POST",
                data: { Action: action, fid: fpid, desid: desid, cid: getparastr("cid"), rnd: Math.random() },
                success: function (responseText) {
                    if (responseText == "success") {
                        $.ajax({
                            url: "../../data/SingleSignOn.ashx", type: "POST",
                            data: { Action: "deleteAPI", fid: fpid, desid: desid, cid: getparastr("cid"), rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                   // fload();
                                    alert("删除成功");
                                }

                                else {
                                    alert('删除失败！' + responseText);
                                 }

                            },
                            error: function () {
                                alert('删除失败！' );
                            }
                        });

                    }

                    else {
                        alert('删除失败！' );
                    }

                },
                error: function () {
                    alert('删除失败！');
                }
            });
        }

        function ajaxupdate(action, fpid, desid,newname) {
            $.ajax({
                url: "../../data/SingleSignOn.ashx", type: "POST",
                data: { Action: action, fid: fpid, desid: desid, T_name: newname, cid: getparastr("cid"), rnd: Math.random() },
                success: function (responseText) {
                    if (responseText == "success") {
                        

                    }

                    else {
                        alert('更新失败！' + responseText);
                    }

                },
                error: function () {
                    alert('更新失败！');
                }
            });
        }

        function add()
        {
            viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=insert' + '&dest=0', "新增效果图");

        }
        function view3d(strurl)
        {
            if (strurl == null || strurl == "undefined" || strurl == "")
            {
                alert("没有全景图，无法查看！");
                return;
            }
            //alert(strurl);
            viewkjl('../../CRM/ConsExam/kjl_view.aspx?strurl=' + strurl, "查看图");

           // viewkjl(strurl, "查看3D图");
        }
        function list(desid)
        {
            getlist3d(desid)
           // alert(fpId);
        }
        function edit(fpId) {
            viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=Edit' + '&dest=2' + "&fid=" + fpId, "修改户型图");

        }
        function edit3d(desid) {

            viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=Edit' + '&dest=1' + '&desid=' + desid, "修改3D图");

        }
        function editname(fpId) {
            var newname = $('#' + fpId + '').val();
            if (newname == "") { alert("请填写一个有效名称！"); return; }
            ajaxupdate("updatehxtname",fpId,"",newname);
        }
        function editname3d(desid) {
            var newname = $('#' + desid + '').val();
            if (newname == "") { alert("请填写一个有效名称！");return}
            ajaxupdate("update3dname", "", desid, newname);
        }
        function del(fpId) {
            ajaxdelte("deleteHXT", fpId, "");
        }
        function del3d(desid) {
            ajaxdelte("delete", "", desid);
        }
        function viewkjl(url, newname) {
            window.open(url + "&width=" + screen.width +
                                "&height=" + (screen.height - 70), newname,
                                "top=0,left=0,toolbar=no, menubar=no, scrollbars=yes,resizable=no,location=no,status=no,width=" +
                                screen.width + ",height=" +
                                (screen.height - 70));
        }
        $(document).ready(function () {
            $().UItoTop({ easingType: 'easeOutQuart' });
        })
    </script>
    
</head>
<body class="page1" id="top">

 
		<div class="menu_block">
			<div class="container_12">
				<div class="grid_12">
					<nav class="horizontal-nav full-width horizontalNav-notprocessed">
						<ul class="sf-menu">
							<li class="current">
                            <a>  <span id="id_name"></span>
                                </a> 
							</li>
							<li><a onclick="add()">新增户型图</a></li>

						</ul>
					</nav>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<div class="main">
<!--==============================Content=================================-->
			<div class="content">
                <div class="ic"></div>
				<div class="container_12">
					<div id="idleft" class="grid_6">
						
             
					</div>
					<div class="grid_6">
						
				<a  class="btn3" >
                  <span id="idlist"></span> </a>
                        <div id="3dlist"></div>
						
                    
					</div>
					<div class="clear"></div>
					<div class="grid_12">
						<a href="#" class="round"> 回到<br>顶端</a>
					</div>
				</div>
			</div>
<!--==============================footer=================================-->
			
		</div>
    

</body>
</html>
