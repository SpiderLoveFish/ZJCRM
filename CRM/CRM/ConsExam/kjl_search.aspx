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
         
          var startstr = 0;

          $(function () {
              syncdata();//先同步；
              setInterval( dosearch(), 2000);
              
          })

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
          function dosearch() {
              
              ajaxhxtapi($('#T_search').val());
          }


          //创建
          function docreate(pid)
          {
            
              ajaxhxtfb(pid);
             
             
          }


          function syncdata()
          {
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

          //获取指定户型图的副本
          function ajaxhxtfb(planid) {
              $.ajax({
                  url: "../../data/SingleSignOn.ashx", type: "POST",
                  data: { Action: "getuserhxdatafb", planid: planid, rnd: Math.random() },
                  success: function (responseText) {
                      var copyid = responseText;
                    
                      if (copyid == "" || copyid == "null" || copyid == undefined || copyid=="request time out") {
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
          //搜索户型图接口
          function ajaxhxtapi(keystr) {
              $.ajax({
                  url: "../../data/CRM_Customer.ashx", type: "POST",
                  data: { Action: "gridkjl_account_list",   keystr: keystr,   rnd: Math.random() },
                  success: function (responseText) {
                      // alert(responseText);
                      var obj = eval(responseText);
                      var html = "";
                      for (var n in obj) {
                          if (obj[n] == "null" || obj[n] == null)
                              obj[n] = "";

                          var names = obj[n].name;
                          if (names.length >= 15) names = names.substr(0, 15) + '...';

                          html += ' <div class="grid_3">'+
						'<div class="box">'+
                          '<div>'+
							
                          '<img src=' + obj[n].pics + ' alt="" class="img_inner">' +
                          '<p>'+
                          '	<strong class="col2"> <font size="1">' + obj[n].name + obj[n].srcArea + '㎡</font></strong><a  style="cursor:pointer;" onclick="docreate(\'' + obj[n].obsPlanId + '\')"  class="btn">创建</a>&nbsp;' +
                          '	</p>'+	
                          '</div>'+
                          '</div>'+
                          '</div>';
                      }
                      $('#divcontent').html(html)
                  },
                  error: function () {
                      // return "";
                  }
              });
          }

          //更多
          function more()
          {
              startstr++;
              ajaxhxtapi($('#T_search').val());
          }
          //回到第一页
          function first() {
              startstr = 0;
              ajaxhxtapi($('#T_search').val());
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
							<%--<li><a   onclick="add()"  style="cursor:pointer;">全网搜索</a></li>--%>
							
					<li> 
                            				 
												<input id="T_search" style="height:30px" type="text" placeholder="关键字"/>
												
										 
                                           </li>
                                            <li><a   onclick="dosearch()"  style="cursor:pointer;">查找</a></li>  
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
					 <div id="divcontent"></div>
					<div class="clear"></div>
					<div class="grid_12">
							<a href="#" class="round"> 回到<br>顶端</a>
                        	<%--<a  onclick="more()"  class="round"> 加载更多</a>--%>
                        <%--<a  onclick="first()" class="round"> 回到第一页</a>--%>
					</div>
				</div>
			</div>
<!--==============================footer=================================-->
			
		</div>
    

</body>
</html>
