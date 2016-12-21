<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>【张伟】新城域22幢15列表</title>
<meta name="keywords" content="空间设计,家饰装修,户型" />
<meta name="description" content="收集各种家居设计图集" />
<link href="../../JS/templates/main/css/pagination.css" rel="stylesheet" />
<link href="../../JS/templates/main/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf-8" src="../../JS/templates/main/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" charset="utf-8" src="../../JS/templates/main/js/common.js"></script>
     <script src="../../JS/XHD.js" type="text/javascript"></script>
 <script type="text/javascript">
      
     var manager = "";
  
     $(function () {
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
                 var html = ""; var hxturl = "";

                 for (var n in obj) {
                     if (obj[n] == "null" || obj[n] == null)
                         obj[n] = "";
                     // alert(obj[n].simg);
                     //html = "" + obj[n].simg;
                     ajaxhxt(obj[n].fpId, obj[n].desid)
                     //  alert(hxturl);
                     html += '<li> <a id=a' + obj[n].desid + '  onclick="list(\'' + obj[n].desid + '\',\'' + obj[n].fpId + '\')" >' +
                        '';
                     if (obj[n].ismy == 1)//如果是本人的，则显示操作，否则不显示
                     {
                        

                     }
                     html += '<span class="abs-bg"></span>' + 
                            ' <span class="txt1">'+ obj[n].DyGraphicsName + '</span>'+
                            ' <span class="txt2">'+
                            '<p>' + formatTimebytype(obj[n].dotime, 'yyyy-MM-dd') + '</p>' +
                            '</span>'+
                            ' <img id=img' + obj[n].fpId + ' src=#  />' +
                            '</a>'+
                            '</li>';
                    
                 }
                 $('#idleft').html(html)
                 //if (html.length > 0)
                 //    $('#idlist').html(obj[0].DyGraphicsName + "方案列表")
                 //else $('#idlist').html("无数据，请先新增")
                 //alert(obj[n].obsPlan.obsPlanId + fid);
                 // f_save(savedata, obj[n].obsPlan.obsPlanId);

             },
             error: function () {
                 alert("获取失败");
             }
         });

         function ajaxhxt(fid, desid) {
             $.ajax({
                 url: "../../data/SingleSignOn.ashx", type: "POST",
                 data: { Action: "Gethxt", desid: desid, rnd: Math.random() },
                 success: function (responseText) {
                     //  alert(responseText);
                     $('#img' + fid).attr("src", responseText);
                     //ajaxhxt(obj[n].desid)
                     //return responseText;

                 },
                 error: function () {
                     // return "";
                 }
             });
         }

     });

     function list(desid, fpId) {
         // getlist3d(desid)
         viewkjl('../../CRM/ConsExam/kjl_index_3DLIST.aspx?desid=' + desid + '&fpId=' + fpId + '&cid=' + getparastr("cid") + "&name=" + getparastr("name"), "查看");
         //$('div[name^=div]').each(function () {
         //$("div[id]").each(function () {

         //    $(this).removeClass("cl2");
         //    $(this).addClass("cl1");

         //});
         //$('#div' + desid + '').removeClass("cl1");
         //$('#div' + desid + '').addClass("cl2");

         // alert(fpId);
     }
     function add() {

         viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=insert' + '&dest=4', "新增方案");

     }
     function viewkjl(url, newname) {
         window.open(url + "&width=" + screen.width +
                             "&height=" + (screen.height - 70), newname,
                             "top=0,left=0,toolbar=no, menubar=no, scrollbars=yes,resizable=no,location=no,status=no,width=" +
                             screen.width + ",height=" +
                             (screen.height - 70));
     }
     function herf(type)
     {
         if (type==1)
             window.location.href = "/CRM/ConsExam/kjl_search_my.aspx?cid=" + getparastr("cid") + "&name=" + getparastr("name");
         else if (type == 2)
             window.location.href = "/CRM/ConsExam/kjl_search_lf.aspx?cid=" + getparastr("cid") + "&name=" + getparastr("name");
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
          <a onclick="add()">新增方案</a>
          <a onclick="herf(1)"  >我的方案中搜索</a>
          <a onclick="herf(2)" >我的量房中搜索</a>
        </p>
      </div>
     
     
    </div>
  </div>
</div>
<!--/Header-->

<div class="section clearfix">
  
  <div class="ntitle">
    <h2>
      <a  id="id_name"  > <em></em></a>
    </h2>
    <p>
      <!--小类-->
      
    方案列表&nbsp;&nbsp;(点击下列户型图可编辑)  <button class="btn-gray" onclick='javascript: history.go(0)'>刷新</button>
      
      <!--小类-->
    </p>
    
   
  </div>
  
  <div class="wrapper auto clearfix">
    <ul  id="idleft" class="img-list high ilist">
      <!--取得一个分页DataTable-->
      
      
      
      
    <%-- <li>
        <a title="清新有活力的公寓设计 用色彩焕然一新" href="/photo_show.aspx?id=43">
          <span class="abs-bg"></span>
          <span class="txt1">中海独墅9栋90.00㎡225、226栋A</span>
          <span class="txt2">
            <!--<i>阅读：4次</i>-->
            <p>2016-10-10</p>
          </span>
          <img src="/upload/201504/18/thumb_201504181258575445.jpg" />
        </a>
      </li>
      --%>
      
    </ul>
    <!--页码列表-->
    <div class="page-box">
      <div class="digg"></div>
    </div>
    <!--/页码列表-->
  </div>
</div>

</body>
</html>