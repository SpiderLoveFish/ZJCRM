﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
       var cityid = "166";
       var start = 0;
       var num = 20;
       var tel = "";
       $(function () {
           tel = getparastr("tel");
           document.getElementById("jmid").value = getparastr("jmid");
           //$('#id_name').html(decodeURI(getparastr("jmid")))
           cityid = getparastr("cityid");
           document.getElementById("keywords").value = getparastr("keyword");
           SiteSearch();
       });
       function viewkjl(url, newname) {
           window.open(url + "&width=" + screen.width +
                               "&height=" + (screen.height - 70), newname,
                               "top=0,left=0,toolbar=no, menubar=no, scrollbars=yes,resizable=no,location=no,status=no,width=" +
                               screen.width + ",height=" +
                               (screen.height - 70));
       }
       function SiteSearch() {
           var keyword = document.getElementById("keywords").value;
           ajaxhxtapi(keyword);
       }
     function add() {

         viewkjl('../../CRM/ConsExam/kjl_edit_bj.aspx?jmid=' + getparastr("jmid") + '&style=insert' + '&dest=4' + '&tel=' + getparastr("tel"), "新增方案");

     }
  //搜索户型图接口
     function ajaxhxtapi(keystr) {
         $.ajax({
             url: "../../data/website.ashx", type: "POST",
             data: { Action: "gethxtapi", cityid: cityid, keystr: document.getElementById("keywords").value, strstart: start, searchnum: num, rnd: Math.random() },
             success: function (responseText) {
  
                 var obj = eval(responseText);
                 var html = "";
                 $('#list').html(html)
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
                "            <p>" + formatTimebytype(obj[n].modifiedTime, 'yyyy-MM-dd') + "</p>" +
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
             url: "../../data/website.ashx", type: "POST",
             data: { Action: "getuserhxdatafb", jmid: getparastr("jmid"), planid: planid, rnd: Math.random() },
             success: function (responseText) {
                 var copyid = responseText;

                 if (copyid == "" || copyid == "null" || copyid == undefined || copyid == "request time out") {
                     alert("创建失败，请重新创建！" + copyid);
                     return;
                 }
                 viewkjl('../../CRM/ConsExam/kjl_edit_bj.aspx?jmid=' + document.getElementById("jmid").value + '&fid=' + copyid + '&style=insert' + '&dest=2' + '&tel=' + getparastr("tel"), "新增方案");

             },
             error: function () {
                 alert("创建失败");
             }
         });
     }

     
       //首页
     function first()
     {
           start = 0;
           num = 20;
         SiteSearch();
     }
       //下一页
     function next()
     {
         start = start+20;
         num =num + 20;
         SiteSearch();
     }
       //上一页
     function pre()
     {
         if (start > 0) {
             start = start - 20;
             num = num - 20;
         }
         else {
             start = 0;
             num = 20;
         }
        
         SiteSearch();
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
      
    搜索方案 
        	<input type="hidden" id = "keywords" name="keywords" value="" />
        <input type="hidden" id = "jmid" name="jmid" value="ksxczs" />
      <!--小类-->
    </p>
      &nbsp;&nbsp;
    <button class="btn-gray" onclick='first()'>首页</button>&nbsp;&nbsp;
       <button class="btn-gray" onclick='next()'>下一页</button>&nbsp;&nbsp;
       <button class="btn-gray" onclick='pre()'>上一页</button>

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