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
                    var html = ""; var hxturl = "";
                    
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                       // alert(obj[n].simg);
                        //html = "" + obj[n].simg;
                        ajaxhxt(obj[n].fpId, obj[n].desid)
                      //  alert(hxturl);
                        html += '<div id=div' + obj[n].desid + ' class="p1_box left cl1">' +
                           //'<div class="type"></div>' +
                           '                         <table width=100% border="0"><tr><td width="9%"><strong>����</strong>��</td><td width="45%"><span id=td' + obj[n].desid + '>' + obj[n].DyGraphicsName + '</span></td><td width="16%" align="right"><strong>����ʱ�䣺</strong></td><td width="30%">' + formatTimebytype(obj[n].dotime, 'yyyy-MM-dd') + '</td></tr></table>' +
                           '<a  href="javascript:window.scrollTo( 0, 0 );"style="cursor:pointer;" onclick="list(\'' + obj[n].desid + '\')" ><img id=img' + obj[n].fpId + ' src=#  ></a>';
                        if (obj[n].ismy == 1)//����Ǳ��˵ģ�����ʾ������������ʾ
                        {
                            html += '<a onclick="edit(\'' + obj[n].fpId + '\')" class="btn">�޸ķ���</a>' +
                           '<a onclick="edit3d(\'' + obj[n].desid + '\')" class="btn">ȥװ��</a>' +

                        '<a onclick="del(\'' + obj[n].fpId + '\',\'' + obj[n].desid + '\')" class="btn">ɾ��</a>&nbsp;&nbsp;&nbsp;&nbsp;'+
                            '<a onclick="editname(\'' + obj[n].fpId + '\',\'' + obj[n].desid + '\')" class="btn">����</a>&nbsp;';
                             
                        }
                        html +=  '<a  class="btn2" ><label class="name"><input id="' + obj[n].fpId + '"  ltype="text"type="text" value=' + obj[n].DyGraphicsName + '></input></label></a>' +
                           
                       '</div>';
                        if (obj[0].desid != null && obj[0].desid != undefined && obj[0].desid!="")
                             getlist3d(obj[0].desid);
                    }
                    $('#idleft').html(html)
                    if(html.length>0)
                        $('#idlist').html( obj[0].DyGraphicsName + "�����б�")
                    else $('#idlist').html("�����ݣ���������")
                    //alert(obj[n].obsPlan.obsPlanId + fid);
                    // f_save(savedata, obj[n].obsPlan.obsPlanId);
                     
                },
                error: function () {
                    alert("��ȡʧ��");
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
                            typename = "��ͨ��Ⱦͼ";
                        else if (obj[n].picType == 1)
                            typename = "ȫ��ͼ";
                        else if (obj[n].picType == 2)
                            typename = "����ͼ";
                        html += '<div class="p1_box left cl1">';
                        //'<div class="type"></div>' +
                        if (obj[n].panoLink == null || obj[n].panoLink == "undefined" || obj[n].panoLink == "")
                        { html += '<a href="javascript:void(0)" onclick="view3d(\'' + obj[n].img + '\')"  style="cursor:pointer;"><img src=' + obj[n].img + ' alt=' + obj[n].panoLink + '  ></a>' }
                        else
                        html += '<a href="javascript:void(0)" onclick="view3d(\'' + obj[n].panoLink + '\')"  style="cursor:pointer;"><img src=' + obj[n].img + ' alt=' + obj[n].panoLink + '  ></a>';

                        //if (obj[n].picType == 1)
                        //{
                        //       html += '<a onclick="edit3d(\'' + obj[n].picId + '\')" class="btn">�޸ķ���</a>' +
                        //       '<a onclick="editname3d(\'' + obj[n].picId + ' \')" class="btn">�޸�����</a>' +
                        //       '<a onclick="del3d(\'' + obj[n].picId + '\')" class="btn">ɾ��</a>&nbsp;&nbsp;&nbsp;&nbsp;';          
                        //    }
                        html +='<a  class="btn2" >��' + typename + '��'+ obj[n].roomTypeName +'</a>'+
                       '</div>';
                        if (html.length > 0)
                            $('#idlist').html($('#td' + desid).html() + "�����б�")
                        else $('#idlist').html("�����ݣ���������")

                    }
                    $('#3dlist').html(html)
                     //alert(obj[n].obsPlan.obsPlanId + fid);
                    // f_save(savedata, obj[n].obsPlan.obsPlanId);

                },
                error: function () {
                    alert('��ȡʧ�ܣ�');
                 }
            });
        }

        function ajaxdelte(action,fpid,desid)
        {
            if (desid == "" || desid == null || desid == 'null' || desid == undefined)
                action = "deleteHXT";
            else action = "delete";
            $.ajax({
                url: "../../data/SingleSignOn.ashx", type: "POST",
                data: { Action: action, fid: fpid, desid: desid, cid: getparastr("cid"), rnd: Math.random() },
                success: function (responseText) { 
                    if (responseText == "success") {
                        if (fpid != "")//����ͼ
                        $.ajax({
                            url: "../../data/SingleSignOn.ashx", type: "POST",
                            data: { Action: "deleteAPI", fid: fpid, desid: desid, cid: getparastr("cid"), rnd: Math.random() },
                            success: function (responseText) {
                                if (responseText == "true") {
                                   // fload();
                                    alert("ɾ���ɹ�");
                                }

                                else {
                                    alert('ɾ��ʧ�ܣ�' + responseText);
                                 }

                            },
                            error: function () {
                                alert('ɾ��ʧ�ܣ�' );
                            }
                        });

                    }

                    else {
                        alert('ɾ��ʧ�ܣ�' + responseText);
                    }

                },
                error: function () {
                    alert('ɾ��ʧ�ܣ�');
                }
            });
        }

        function ajaxupdate(action, fpid, desid,newname) {
            $.ajax({
                url: "../../data/SingleSignOn.ashx", type: "POST",
                data: { Action: action, fid: fpid, desid: desid, T_name: newname, cid: getparastr("cid"), rnd: Math.random() },
                success: function (responseText) {
                    if (responseText == "success") {
                        
                        alert('���³ɹ���');
                    }

                    else {
                        alert('����ʧ�ܣ�' + responseText);
                    }

                },
                error: function () {
                    alert('����ʧ�ܣ�');
                }
            });
        }

        function ajaxhxt( fid, desid) {
            $.ajax({
                url: "../../data/SingleSignOn.ashx", type: "POST",
                data: { Action: "Gethxt",  desid: desid, rnd: Math.random() },
                success: function (responseText) {
                    //  alert(responseText);
                    $('#img' + fid).attr("src",responseText);
                    //ajaxhxt(obj[n].desid)
                    //return responseText;

                },
                error: function () {
                   // return "";
                }
            });
        }
     

        function add()
        {
            
            viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=insert' + '&dest=4', "��������");

        }

        function add_lf() {

            viewkjl('../../CRM/ConsExam/kjl_search.aspx?cid=' + getparastr("cid") + '&style=insert' + '&dest=4', "��������");

        }
        function view3d(strurl)
        {
            if (strurl == null || strurl == "undefined" || strurl == "")
            {
                alert("û��������ϣ��޷��鿴��");
                return;
            }
            //alert(strurl);
            viewkjl('../../CRM/ConsExam/kjl_view.aspx?strurl=' + strurl, "3DLIST");

           // viewkjl(strurl, "�鿴3Dͼ");
        }
        function list(desid)
        {
            getlist3d(desid)
           
            //$('div[name^=div]').each(function () {
            $("div[id]").each(function () {
           
                $(this).removeClass("cl2");
                $(this).addClass("cl1");
                
            });
            $('#div' + desid + '').removeClass("cl1");
            $('#div' + desid + '').addClass("cl2");
 
           // alert(fpId);
        }
        function edit(fpId) {
            viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=Edit' + '&dest=2' + "&fid=" + fpId, "�޸ķ���");

        }
        function edit3d(desid) {

            viewkjl('../../CRM/ConsExam/kjl_edit.aspx?cid=' + getparastr("cid") + '&style=Edit' + '&dest=1' + '&desid=' + desid, "�޸�3Dͼ");

        }
        function editname(fpId,desid) {
            var newname = $('#' + fpId + '').val();
            if (newname == "") { alert("����дһ����Ч���ƣ�"); return; }
            if (desid == "" || desid == null || desid == 'null' || desid==undefined)
                ajaxupdate("updatehxtname", fpId, desid, newname);//���û��3D����ͼ������»���ͼ����
            else 
                ajaxupdate("update3dname", fpId, desid, newname);
        }
        function editname3d(desid) {
            var newname = $('#' + desid + '').val();
            if (newname == "") { alert("����дһ����Ч���ƣ�");return}
            ajaxupdate("update3dname", "", desid, newname);
        }
        function del(fpId,desid) {
            ajaxdelte("deleteHXT", fpId, desid);
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
                              <li><input name='sx' type='button' onclick='javascript: history.go(0)' value='ˢ��' /></li>
							<li class="current">
                            <a>  <span id="id_name"></span>
                                </a> 
							</li>
							<li><a onclick="add()">����</a></li>
                            <li><a onclick="add_lf()">����</a></li>
                          

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
						<a href="#" class="round"> �ص�<br>����</a>
					</div>
				</div>
			</div>
<!--==============================footer=================================-->
			
		</div>
    

</body>
</html>
