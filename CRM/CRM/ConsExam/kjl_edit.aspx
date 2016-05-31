<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
  <%--/  <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />--%>
  <style type="text/css">
        body {padding-top:50px;}
        #content {padding:0 20px;}
        .intro {margin-top:20px; font-size:14px;}
        .ifr-steps {position:fixed; top:20px; min-width:400px;}
        .ifr-steps li {list-style-type:decimal; list-style-position:inside;}
        .sep {border-right:1px solid #999; margin:0 15px;}
        iframe {border:2px solid #666; margin-top:20px;}
        em {color:red}
    </style>
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
     <script src="../../lib/jquery.form.js" type="text/javascript"></script>
   <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/json2.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        var manager = "";
        var cid=getparastr("cid");
        $(function () {
            
            if (window.postMessage) {
                //var $log = $('.action-log');
                var logData = function (data) {

                    var datas;
                    if (data.action !== 'kjl_rendered') {
                        datas = {
                            Action: "save",
                            action: data.action,
                            type: data.type,
                            id: data[data.type + 'id']
                        };
                    } else {
                        datas = {
                            Action: "save",
                            action: data.action,
                            type: data.type,
                            id: data[data.type + 'id'],
                            imgtype: data.imgtype,
                            simg: data.simg,
                            img:data.img
                        };
                    }
                   /// alert(datas);
                    $.ajax({
                        url: "../../data/SingleSignOn.ashx", type: "POST",
                       // data: { Action: "GetMD5", dest: 0, rnd: Math.random() },
                        data: {
                            Action: "save",
                            cid:cid,
                            action: data.action,
                            type: data.type,
                            id: data[data.type + 'id'],
                        rnd: Math.random() },
                        success: function (responseText) {
                            alert(responseText);
                            if (responseText == "true") {
                                top.$.ligerDialog.closeWaitting();
                              //  f_reload();
                            }

                            else {
                                top.$.ligerDialog.closeWaitting();
                                top.$.ligerDialog.error('����ʧ��1��');
                            }
                        },
                        error: function () {
                            top.$.ligerDialog.closeWaitting();
                            top.$.ligerDialog.error('����ʧ��2��', "", null, 9003);
                        }
                    });
                    var li, d = new Date;
                    if (data.action !== 'kjl_rendered') {
                        li = '<li>action: ' + data.action + '<em>----</em>' + data.type + 'id: ' +
                                data[data.type + 'id'];
                    } else {
                        li = '<li>action: ' + data.action + '<em>----</em>' + data.type + 'id: ' +
                                data[data.type + 'id'] + '<em>----</em>��Ⱦ����: ' +
                                data.imgtype + '<em>----</em>Ԥ��ͼ:' + data.simg +
                                '<em>----</em>ԭͼ: ' + data.img;
                    }
                    $log.append(li + '<em>----</em>' + new Date().getTime() + '</li>');
                    if (data.action === 'kjl_completed') {
                        $log.append('<li><em>��ʱiframe���˳���ƣ��ⲿҳ������д��������������ùر�iframe��</em></li>');
                    }
                };
                var callback = function(ev) {
                    //console ? console.log(ev) : alert(ev.data);
                    logData(JSON.parse(ev.data));
                    if (ev.origin === 'http://www.kujiale.com' ||
                        ev.origin === 'http://yun.kujiale.com' ||
                        ev.origin === 'https://www.kujiale.com' ||
                        ev.origin === 'https://yun.kujiale.com') {
                        // handle message in ev ...
                        // var data = JSON.parse(ev.data)
                    }
                };
                if ('addEventListener' in document) {
                    window.addEventListener('message', callback, false);
                } else if ('attachEvent' in document) {
                    window.attachEvent('onmessage', callback);
                }
            } else {
                // �����֧��postMessage�� ��ʹ��ie6/7��window��������navigator����hack
                window.navigator.listenKJL = function(msg) {
                    alert(msg)
                    // var data = JSON.parse(msg)
                    logData(JSON.parse(msg));
                };
            //if (window.postMessage) {
            //    var callback = function (ev) {
            //        console ? console.log(ev) : alert(ev.data);
            //        if (ev.origin === 'http://www.kujiale.com' ||
            //            ev.origin === 'http://yun.kujiale.com' ||
            //            ev.origin === 'https://www.kujiale.com' ||
            //            ev.origin === 'https://yun.kujiale.com') {
            //            // handle message in ev ...
            //            // var data = JSON.parse(ev.data)

            //        }
            //    };
            //    if ('addEventListener' in document) {
            //        window.addEventListener('message', callback, false);
            //    } else if ('attachEvent' in document) {
            //        window.attachEvent('onmessage', callback);
            //    }
            //} else {
            //    // �����֧��postMessage�� ��ʹ��ie6/7��window��������navigator����hack
            //    window.navigator.listenKJL = function (msg) {
            //        alert(msg)
            //        // var data = JSON.parse(ev.data)
            //    };
            }

        })
            $(function () {
          
                $.ajax({
                    url: "../../data/SingleSignOn.ashx", type: "POST",
                    data: { Action: "GetMD5",dest:5, rnd: Math.random() },
                    // dataType: 'content', //�����޸�Ϊcontent   
                    success: function (responseText) {
                        // $.ligerDialog.warn(responseText);
                        //location.href = "http://www.baidu.com";
                        //alert(responseText);
                        //$.ligerDialog.warn(responseText);
                        //$.ligerDialog.warn(obj.errorMsg);
                        // $("#maingrid4").append("<lable >������룺" + obj.errorMsg + "</lable>");
                        try
                        {
                            var obj = JSON.parse(responseText);
                            if (obj.errorCode == 0)
                            {
                               // alert(obj.errorMsg);
                                $('#iframe').attr("src", obj.errorMsg);
                               // location.href = obj.errorMsg;
                            }
                            else
                                $("#maingrid4").append("<lable >����������" + obj.errorMsg + "</lable>");
                        } catch (e)
                        {
                            $("#maingrid4").append("<lable >����������" + responseText +";�ͻ��˴���"+ e.message+"</lable>");
                       
                        }
                    }
                });
                return;
 
           
            });
      
    </script>
    
</head>
<body style="padding: 0px;overflow:hidden;">

    <form id="form1" onsubmit="return false">
        <div>
            <div id="toolbar"></div>
              <div id="grid">
            <div id="maingrid4" style="margin: -1px;"></div>
                  </div>
        </div>
        <div id="content">      

        <div class="ifr-steps">
            <h3>iframe�û���Ϊ��¼</h3>
            <ol class="action-log">
            </ol>
        </div>

        <iframe id="iframe" name="demo-iframe" width="1000" height="600">
            <h2>���ǿ����װ����ƻ����޸�ҳ�棬��ǰδ��¼</h2>
        </iframe>
    </div>
      
    </form>
     

</body>
</html>
