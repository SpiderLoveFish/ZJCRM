<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title> </title>
 
    <link href="../../JS/templates/main/css/style.css" rel="stylesheet" type="text/css" />
<link href="../../JS/templates/main/css/pagination.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf-8" src="../../JS/templates/main/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" charset="utf-8" src="../../JS/templates/main/js/common.js"></script>
<script type="text/javascript" charset="utf-8" src="../../JS/templates/main/js/lightbox.min.js"></script>
     <script src="../../JS/XHD.js" type="text/javascript"></script>

   <script type="text/javascript">
       $(function () {
           $('#id_name').html(decodeURI(getparastr("name")))
       });
       function viewkjl(url, newname) {
           window.open(url + "&width=" + screen.width +
                               "&height=" + (screen.height - 70), newname,
                               "top=0,left=0,toolbar=no, menubar=no, scrollbars=yes,resizable=no,location=no,status=no,width=" +
                               screen.width + ",height=" +
                               (screen.height - 70));
       }
       function SiteSearch() {
           var keyword = $('#keywords').val()
           ajaxhxtapi(keyword);
       }
     function add() {

         viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=insert' + '&dest=4', "新增方案");

     }
     function syncdata() {
         //  alert(getCookie("xhdcrm_uid"));
         if (getCookie("xhdcrm_uid") && getCookie("xhdcrm_uid") != null)
             $.ajax({
                 url: "../../data/website.ashx", type: "POST",
                 data: { Action: "getuserhxdata_tongbu", struid: getCookie("xhdcrm_uid"), num: 999, rnd: Math.random() },
                 success: function (responseText) {

                     if (responseText == "true") {

                     }
                     $.ajax({
                         url: "../../data/website.ashx", type: "POST",
                         data: { Action: "get3dlist_tongbu", struid: getCookie("xhdcrm_uid"), num: 999, rnd: Math.random() },
                         success: function (responseText) {

                             if (responseText == "true") {
                                 alert('同步成功！');
                             }


                         }, error: function () {

                             alert('同步失败！');
                         }
                     });

                 },
                 error: function () {
                     alert('同步失败！');
                 }
             });
     }
     //搜索户型图接口
     function ajaxhxtapi(keystr) {
         $.ajax({
             url: "../../data/CRM_Customer.ashx", type: "POST",
             data: { Action: "gridkjl_account_list",islf:"N", keystr: keystr, rnd: Math.random() },
             success: function (responseText) {
 
                 var obj = eval(responseText);
                 var html = "";
                 for (var n in obj) {
                     if (obj[n] == "null" || obj[n] == null)
                         obj[n] = "";

                     var names = obj[n].name;
                     if (names.length >= 15) names = names.substr(0, 15) + '...';

                     html +=
                         "  <li>" +
                             "        <a   onclick=docreate(\"" + obj[n].obsPlanId + "\")>" +
                "          <span class='abs-bg'></span>" +
                "          <span class='txt1'>" + obj[n].name + obj[n].srcArea + "㎡</span>" +
                "          <span class='txt2'>" +
                "            <p>2015-04-18</p>" +
                "          </span>" +
                "          <img src=" + obj[n].pics + " />" +
                "        </a>" +
                "      </li>";
                 }
                   
                     $('#list').html(html)
             },
             error: function () {
                 // return "";
             }
         });
     }

     //创建
     function docreate(pid) {

         ajaxhxtfb(pid);


     }
     //获取指定户型图的副本
     function ajaxhxtfb(planid) {
         $.ajax({
             url: "../../data/SingleSignOn.ashx", type: "POST",
             data: { Action: "getuserhxdatafb", planid: planid, rnd: Math.random() },
             success: function (responseText) {
                 var copyid = responseText;

                 if (copyid == "" || copyid == "null" || copyid == undefined || copyid == "request time out") {
                     alert("创建失败，请重新创建！" + copyid);
                     return;
                 }
                 viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&fid=' + copyid + '&style=insert' + '&dest=2', "新增方案");

             },
             error: function () {
                 alert("创建失败");
             }
         });
     }

     function list(desid, fpId) {
         // getlist3d(desid)

         viewkjl('../../CRM/ConsExam/kjl_index_3DLIST.aspx?desid=' + desid + '&fpId=' + fpId + '&cid=' + getparastr("cid") + "&name=" + getparastr("name"), "查看");
     }
     function herf(type) {
         if (type == 1)
             window.location.href = "/CRM/ConsExam/kjl_search_my.aspx?cid=" + getparastr("cid") + "&name=" + getparastr("name");
         else if (type == 2)
             window.location.href = "/CRM/ConsExam/kjl_index.aspx?cid=" + getparastr("cid") + "&name=" + getparastr("name");
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
   <a onclick="herf(2)"  >返回户型图列表</a>
     <a onclick="add()">新增方案</a>
   
        </p>
      </div>
      <div class="search">
        <input id="keywords" name="keywords" class="input" type="text" onkeydown="if(event.keyCode==13){SiteSearch('/search.aspx', '#keywords');return false};" placeholder="输入回车搜索" x-webkit-speech="" />
        <input class="submit" type="submit" onclick="SiteSearch();" value="搜索" />
      </div>
     
    </div>
  </div>
</div>
<!--/Header-->

<div class="section clearfix">
  
  <div class="ntitle">
    <h2>
      <a  id="id_name" > <em></em></a>
    </h2>
    <p>
      <!--小类-->
      
    我的量房方案&nbsp;&nbsp;(在上方进行搜索，点击结果中的户型图创建)&nbsp;&nbsp;<button class="btn-gray" onclick='syncdata()'>更新</button>
      
      <!--小类-->
    </p>
    
  </div>
  
  <div class="wrapper auto clearfix">
    <ul id="list" class="img-list high ilist">
      <!--取得一个分页DataTable-->
     
      
         
       
      
     <%-- <li>
        <a title="现代简约 明亮的外表卧室卧室背景墙、吊顶黄色" href="/photo_show.aspx?id=37">
          <span class="abs-bg"></span>
          <span class="txt1">现代简约 明亮的外表卧室卧室背景墙、吊顶黄色</span>
          <span class="txt2">
            <p>2015-04-18</p>
          </span>
          <img src="/upload/201504/18/thumb_201504181230434303.jpg" />
        </a>
      </li>--%>
      
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