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
              dosearch(); 
          })

          function add() {
           
              viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=insert' + '&dest=4', "��������");

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


          //����
          function docreate(pid)
          {
            
              ajaxhxtfb(pid);
             
             
          }


          //��ȡָ������ͼ�ĸ���
          function ajaxhxtfb(planid) {
              $.ajax({
                  url: "../../data/SingleSignOn.ashx", type: "POST",
                  data: { Action: "getuserhxdatafb", planid: planid, rnd: Math.random() },
                  success: function (responseText) {
                      var copyid = responseText;
                    
                      if (copyid == "" || copyid == "null" || copyid == undefined || copyid=="request time out") {
                          alert("����ʧ�ܣ������´�����" + copyid);
                          return;
                      }
                      viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&fid=' + copyid + '&style=insert' + '&dest=2', "��������");
 
                  },
                  error: function () {
                      alert("����ʧ��");
                  }
              });
          }
          //��������ͼ�ӿ�
          function ajaxhxtapi(keystr) {
              $.ajax({
                  url: "../../data/SingleSignOn.ashx", type: "POST",
                  data: { Action: "gethxtapi", cityid: 175, keystr: keystr, strstart: startstr, rnd: Math.random() },
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
                          '	<strong class="col2">' + obj[n].commName + obj[n].srcArea+'�O</strong><a  style="cursor:pointer;" onclick="docreate(\'' + obj[n].obsPlanId + '\')"  class="btn">����</a>&nbsp;' +
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

          //����
          function more()
          {
              startstr++;
              ajaxhxtapi($('#T_search').val());
          }
          //�ص���һҳ
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
							<li><a   onclick="add()"  style="cursor:pointer;">�Լ���</a></li>
							
					<li> 
                            				 
												<input id="T_search" type="text" placeholder="С������"/>
												
										 
                                           </li>
                                            <li><a   onclick="dosearch()"  style="cursor:pointer;">����</a></li>  
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
						
                        	<a  onclick="more()"  class="round"> ���ظ���</a>
                        <a  onclick="first()" class="round"> �ص���һҳ</a>
					</div>
				</div>
			</div>
<!--==============================footer=================================-->
			
		</div>
    

</body>
</html>
