<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title></title>
  
<link href="../../JS/templates/main/css/style.css" rel="stylesheet" type="text/css" />
<link href="../../JS/templates/main/css/lightbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf-8" src="../../JS/templates/main/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" charset="utf-8" src="../../JS/templates/main/js/common.js"></script>
<script type="text/javascript" charset="utf-8" src="../../JS/templates/main/js/lightbox.min.js"></script>
     <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
      
        var manager = "";
        var sfqjt = "N";
        var picId = "";
        var ismy = "0";
        var html = "";
        $(function () {
            $('#txtUserName').val(decodeURI(getparastr("name")));
            $('#id_name').html(decodeURI(getparastr("cname")));
            ismy = getparastr("ismy");
           
            if (ismy == "0")//不是隐藏
                $("button.btn").each(function () {
                    $(this).hide();
                });
            ajaxhxt(getparastr("fpId"), getparastr("desid"));
          
        });


        function ajaxhxt(fid, desid) {
            // alert(desid+';'+fid)
            if (desid != "") {
                $.ajax({
                    url: "../../data/SingleSignOn.ashx", type: "POST",
                    data: { Action: "Gethxt", desid: desid, rnd: Math.random() },
                    success: function (responseText) {
                        //$('#img' + fid).attr("src", responseText);
                     
                        html += ' <li>';
                        //'<div class="type"></div>' +

                        html += ' <a href=\'' + responseText + '\'  data-lightbox="album" data-title=""> <img src=' + responseText + ' /> </a>';

                        html += '<a  class="btn2" >【户型图】' + decodeURI(getparastr("name")) + '</a>' +
                       ' </li>';
                        $('#3dlist').append(html); getlist3d(getparastr("desid"));
                    },
                    error: function () {
                        // return "";
                    }
                });
            }
            else {  //当户型图ID存在的时候
                $.ajax({
                    url: "../../data/SingleSignOn.ashx", type: "POST",
                    data: { Action: "getthebasicdata", fid: fid, rnd: Math.random() },
                    success: function (responseText) {

                        var obj = eval(responseText);
                        for (var n in obj) {
                            //$('#img' + fid).attr("src", obj[n].smallPics);
                           
                            html += ' <li>';
                            //'<div class="type"></div>' +

                            html += ' <a href=\'' + obj[n].smallPics + '\'  data-lightbox="album" data-title=""> <img src=' + obj[n].smallPics + ' /> </a>';

                            html += '<a  class="btn2" >【户型图】' + decodeURI(getparastr("name")) + '</a>' +
                           ' </li>';
                            $('#3dlist').append(html);//   getlist3d(getparastr("desid"));
                        }   
                    },
                    error: function () {
                        // return "";
                    }
                });
            }
        }
        function herf()
        {

        }
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
                 var typename = "";
             
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                     
                        if (obj[n].picType == 0)
                            typename = "普通渲染图";
                        else if (obj[n].picType == 1)
                        {
                            picId=  picId + ',' + obj[n].picId;
                            sfqjt = "Y"; typename = "全景图";
                        }
                          
                        else if (obj[n].picType == 2)
                            typename = "俯视图";
                        html += ' <li>';
                        //'<div class="type"></div>' +
                        if (obj[n].panoLink == null || obj[n].panoLink == "undefined" || obj[n].panoLink == "")
                        {
                            html += ' <a href=\'' + obj[n].img + '\'  data-lightbox="album" data-title=""> <img src=' + obj[n].img + ' /> </a>';
                              //'<a href="javascript:void(0)" onclick="view3d(\'' + obj[n].img + '\')"  style="cursor:pointer;"><img src=' + obj[n].img + ' alt=' + obj[n].panoLink + '  ></a>'
                        }
                        else
                            html += ' <a   onclick="view3d(\'' + obj[n].panoLink + '\')" > <img src=' + obj[n].img + ' /> </a>';
                                //'<a href="javascript:void(0)" onclick="view3d(\'' + obj[n].panoLink + '\')"  style="cursor:pointer;"><img src=' + obj[n].img + ' alt=' + obj[n].panoLink + '  ></a>';

                        //if (obj[n].picType == 1)
                        //{
                        //       html += '<a onclick="edit3d(\'' + obj[n].picId + '\')" class="btn">修改方案</a>' +
                        //       '<a onclick="editname3d(\'' + obj[n].picId + ' \')" class="btn">修改名称</a>' +
                        //       '<a onclick="del3d(\'' + obj[n].picId + '\')" class="btn">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;';          
                        //    }
                        html += '<a  class="btn2" >【' + typename + '】' + obj[n].roomTypeName + '</a>' +
                       ' </li>';
                    

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

        function view3d(strurl) {
            if (strurl == null || strurl == "undefined" || strurl == "") {
                alert("没有相关资料，无法查看！");
                return;
            }
            //alert(strurl);
            viewkjl('../../CRM/ConsExam/kjl_view.aspx?strurl=' + strurl, "3DLIST");

            // viewkjl(strurl, "查看3D图");
        }
        //去装修
        function edit3d() {

            viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=Edit' + '&dest=1' + '&desid=' + getparastr("desid"), "修改3D图");

        }
        //删除
        function del() {
            ajaxdelte("deleteHXT", getparastr("fpId"), getparastr("desid"));
        }
        //修改方案
        function edit() {
            viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=Edit' + '&dest=2' + "&fid=" + getparastr("fpId"), "修改方案");

        }
        //修改名称
        function editname() {
            var fpId = getparastr("fpId");
            var desid = getparastr("desid");
            var newname = $('#txtUserName').val();
            alert(newname)
            if (newname == "") { alert("请填写一个有效名称！"); return; }
            if (desid == "" || desid == null || desid == 'null' || desid == undefined)
                ajaxupdate("updatehxtname", fpId, desid, newname);//如果没有3D方案图，则更新户型图名称
            else
                ajaxupdate("update3dname", fpId, desid, newname);
        }

        function ajaxupdate(action, fpid, desid, newname) {
            $.ajax({
                url: "../../data/SingleSignOn.ashx", type: "POST",
                data: { Action: action, fid: fpid, desid: desid, T_name: newname, cid: getparastr("cid"), rnd: Math.random() },
                success: function (responseText) {
                    if (responseText == "success") {

                        alert('更新成功！');
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

        function ajaxdelte(action, fpid, desid) {
            if (desid == "" || desid == null || desid == 'null' || desid == undefined)
                action = "deleteHXT";
            else action = "delete";
            $.ajax({
                url: "../../data/SingleSignOn.ashx", type: "POST",
                data: { Action: action, fid: fpid, desid: desid, cid: getparastr("cid"), rnd: Math.random() },
                success: function (responseText) {
                    if (responseText == "success") {
                        if (fpid != "")//户型图
                            $.ajax({
                                url: "../../data/SingleSignOn.ashx", type: "POST",
                                data: { Action: "deleteAPI", fid: fpid, desid: desid, cid: getparastr("cid"), rnd: Math.random() },
                                success: function (responseText) {
                                    if (responseText == "true") {
                                        // fload();
                                        alert("删除成功");
                                        window.close();
                                    }

                                    else {
                                        alert('删除失败！' + responseText);
                                    }

                                },
                                error: function () {
                                    alert('删除失败！');
                                }
                            });

                    }

                    else {
                        alert('删除失败！' + responseText);
                    }

                },
                error: function () {
                    alert('删除失败！');
                }
            });
        }
        //全屋漫游
        function get3d()
        {
          
   
            //var desid = getparastr("desid");
            if (picId == ""  )
            {
                alert('没有全景图,生成漫游图失败！！！');
                return;
            }
            $.ajax({
                url: "../../data/SingleSignOn.ashx", type: "POST",
                data: { Action: "GETAPI", desid: picId.substr(1), rnd: Math.random() },
                success: function (responseText) {
                    var fdStart = responseText.indexOf("http://");
                  
                    if (fdStart == 0) {
                        window.open(responseText);// viewkjl(responseText, "漫游图");
                        
                    }   //ajaxhxt(obj[n].desid)
                    //return responseText;

                },
                error: function () {
                    alert(' 生成漫游图失败！！！');     return  ;
                }
            });
        }
        function viewkjl(url, newname) {
            window.open(url + "&width=" + screen.width +
                                "&height=" + (screen.height - 70), newname,
                                "top=0,left=0,toolbar=no, menubar=no, scrollbars=yes,resizable=no,location=no,status=no,width=" +
                                screen.width + ",height=" +
                                (screen.height - 70));
        }
        function herf(type) {
            if (type == 1)
                window.location.href = "/CRM/ConsExam/kjl_search_my.aspx?cid=" + getparastr("cid") + "&name=" + getparastr("cname");
            else if (type == 2)
                window.location.href = "/CRM/ConsExam/kjl_index.aspx?cid=" + getparastr("cid") + "&name=" + getparastr("cname");
        }
    </script>
</head>

<body>
<!--Header-->
<div class="header">
  <div class="header-wrap">
    <div class="section">
      <div class="left-box">
   
        <p class="nav">
           <a onclick="herf(2)" >返回户型图列表</a>
        <input id="txtUserName" name="txtUserName" type="text" class="input txt"   placeholder="" datatype="s3-50" nullmsg="请输入名称" sucmsg=" " ajaxurl="/tools/submit_ajax.ashx?action=validate_username" /> 
      <button class="btn btn-success"  onclick="editname()">修改名称</button> 
      <button class="btn btn-error" onclick="edit();">修改方案</button>
            <button class="btn btn-error" onclick="edit3d()">去装修</button>
                 <button class="btn" onclick="del()">删除方案</button>  
      
           </p>
            
      </div>
    </div>
  </div>
</div>
<!--/Header-->

<div class="section clearfix">
  
  <!--左边-->
  <div class="list-auto">
    
    <div class="meta">

      <p class="meta-info">
        <%--<span class="time">2015/4/18</span>--%>
        <span id="id_name" class="comm"></span>
  
<%--        <span class="comm">建筑面积：125㎡</span>
          <span class="comm">套内面积：98㎡</span>
        <span class="view">创建人：张君</span>--%>
         <button class="btn-gray" onclick='javascript: history.go(0)'>刷新</button>
       <button class="btn-success"  onclick="get3d()">全屋漫游</button>  
      </p>
    </div>

    
    <div class="album-list">
      <ul id="3dlist">
        
         
          
           
         <%-- <li>
        	               
          <a href="/upload/201504/18/thumb_201504181258575445.jpg" data-lightbox="album" data-title="">
            <img src="/upload/201504/18/thumb_201504181258575445.jpg" />
          </a>
            <button class="btn-gray" onclick="javascript:location.href='/index.aspx';" style="width:100%">【普通渲染图】起居室</button>
        </li>--%>
        
      </ul>
    </div>
    

    
    <!--分享-->
      <!-- JiaThis Button BEGIN --> 
  
    <!--/分享-->
    <div class="line15"></div>
    
    
    <div class="comment-box">
      <ol id="comment_list" class="comment-list"></ol>
    </div>
    <!--放置页码-->
    <div class="page-box" style="margin-left:-8px;">
      <div id="pagination" class="digg"></div>
    </div>
    <div class="line10"></div>
    <!--/放置页码-->
    <!--用户评论-->
    
  </div>
  <!--/左边-->
  
</div>


</body>
</html>