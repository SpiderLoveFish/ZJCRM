<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>家装DIY报价单</title>

<link rel="stylesheet" type="text/css" media="screen" href="css/css-table.css" />

<script type="text/javascript" src="js/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="js/style-table.js"></script>
       <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    
   
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script>
        var jmid = "";
        var tel = "";
        var desid = "";
        $(function () {
          
            jmid = getparastr("jmid");
            tel = getparastr("tel");
            desid = getparastr("desid");
            getqrcode(document.URL)
            loadBody(jmid, tel, desid);
        });

        function getqrcode(url) {
            $.ajax({
                type: "GET",
                url: "../../data/website.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'getqrcode', url: url, rnd: Math.random() }, /* 注意参数的格式和名称 */
                success: function (result) {
                    qrcode.src = result;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                }
            })
        }

     
 
        function loadBody(jmid, tel, desid) {
            $.ajax({
                type: "GET",
                url: "../../data/website.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'griddetail', jmid: jmid, tel: tel, desid: desid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = result.Rows;
                    //  alert(JSON.stringify(result))
                    var item = ""; var cn = ""; var sum = 0;
                    var sfck = "";
                    $.each(obj, function (i, data) {

                        if (data['hj'] == null) sum = 0;
                        else sum = data['hj'];
                        var imgurl = data['largeImgUrl'];
                        if (imgurl == "") sfck = "";
                        else {
                            sfck = "查看";
                        }
                        var remarks = "";
                        if (data['remarks'] == null) remarks = "";
                        if (data['room'] != cn) {
                            //alert(JSON.stringify(data))

                            item = "<tr><th colspan='2' scope='col'><strong style='font-size:20px'>" + data['room'] + "</strong></th><th colspan='6' align='left' scope='col'>面积：<span style='color:#309'>" + toMoney(data['mj']) + "m2</span> 总价：<span style='color:#309'>¥" + data['hj'].toFixed(2) + "</span></th></tr> <tr><th scope='col'>类 别</th><th scope='col'>名称</th><th scope='col'>数量</th><th scope='col'>单位</th><th scope='col'>单价</th><th scope='col'>金额</th> <th scope='col'>图片</th> <th scope='col'>备注</th></tr>"
                                + "<tr><td>" + data['type'] + "</td><td>" + data['name'] + "</td><td>" + data['quantity'] + "</td><td>" + data['unit'] + "</td><td>" + toMoney(data['price']) + "</td><td>" + toMoney(data['price'] * data['quantity']) + "</td><td><a href='" + imgurl + "' target='_blank'>" + sfck + "<a></td><td>" + remarks + "</td></tr> ";
                        }
                        else {
                            item = "<tr><td>" + data['type'] + "</td><td>" + data['name'] + "</td><td>" + data['quantity'] + "</td><td>" + data['unit'] + "</td><td>" + toMoney(data['price']) + "</td><td>" + toMoney(data['price'] * data['quantity']) + "</td><td><a href='" + imgurl + "' target='_blank'>" + sfck + "<a></td><td>" + remarks + "</td></tr>";
                                
                        }

                        //    item = "<tr><td align='left' colspan='9' ><font size='3' ><b>&nbsp;&nbsp;" + data['room'] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(合计：" + data['hj'].toFixed(2) + ")</b></font></td></tr>"
                        //    + "<tr><td >" + data['name'] + "</td><td align='right'>" + data['price'] + "</td><td align='right'>" + toMoney(data['price']) + "</td><td align='right'>" + toMoney(data['price']) + "</td><td align='right'>" + data['price'] + "</td><td align='right'>" + toMoney(data['quantity']) + "</td> "
                        //        + " <td align='right'>" + toMoney(data['price'] * data['quantity']) + "</td><td  align=center>" + data['type'] + "</td> <td>" + data['brandName'] + "</td>"
                        //        //.replace(/\n|\r|(\r\n)|(\u0085)|(\u2028)|(\u2029)/g, "<br>")
                        //        + " </tr>";
                        //}
                        //else {
                        //    item = "<tr><td>" + data['name'] + "</td><td align='right'>" + data['price'] + "</td><td align='right'>" + toMoney(data['price']) + "</td><td align='right'>" + toMoney(data['price']) + "</td><td align='right'>" + data['price'] + "</td><td align='right'>" + toMoney(data['quantity']) + "</td> "
                        //        + " <td align='right'>" + toMoney(data['price'] * data['quantity']) + "</td><td  align=center>" + data['type'] + "</td> <td>" + data['brandName'] + "</td>"
                        //        + " </tr>";
                       // }
                        $('.table1').append(item);
                        cn = data['room'];
                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                }
            })
        }
 
  </script>
</head>

<body>

<p><img src="images/bjd.png" width="305" height="128" /><img id="qrcode" src="images/untitled.png" alt="" width="130" height="121" /></p>
    <div id="div3">
<table id="travel"  class="table1">

	
    
        
    
  
    	
        
    

</table>
        </div >
</body>
</html>