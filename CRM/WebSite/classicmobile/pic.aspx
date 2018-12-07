<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html>
<html
<head>
    <meta charset="UTF-8">
    <title>搜索结果</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="black" name="apple-mobile-web-app-status-bar-style" />
    <meta content="telephone=no" name="format-detection" />
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="renderer" content="webkit">

   <link rel="stylesheet" href="css/amazeui.min.css" />
    <style>
        .middle-img {
            position: absolute;
            left: 259px;
            top: 0px;
            width: 40px;
        }

        .up-img {
            position: absolute;
            top: -40px;
            left: 261px;
            width: 40px;
        }

        .down-img {
            position: absolute;
            top: 40px;
            left: 257px;
            width: 40px;
        }

        .left-img {
            position: absolute;
            left: 218px;
            width: 40px;
        }

        .right-img {
            position: absolute;
            left: 300px;
            width: 40px;
        }
        @media screen and (max-width:450px) {
            .middle-img {
                position: absolute;
                left: 259px;
                top: 0px;
                width: 40px;
                display: none;
            }

            .up-img {
                position: absolute;
                top: -40px;
                left: 261px;
                width: 40px;
                display: none;
            }

            .down-img {
                position: absolute;
                top: 40px;
                left: 257px;
                width: 40px;
                display: none;
            }

            .left-img {
                position: absolute;
                left: 218px;
                width: 40px;
                display: none;
            }

            .right-img {
                position: absolute;
                left: 300px;
                width: 40px;
                display: none;
            }

            .rotate_jia{
                display: none;
            }.rotate_div{
                display: none;
            }.rotate_jian{
                display: none;
            }
        }
    </style>


</head>
<body>
<div style="width: 80%;margin:  0 auto;font-weight:bold;">
    <h3><a href="index.aspx">重新搜索 </a>搜索内容如下：</h3>
    <p id="search"> </p>

</div>
<ul data-am-widget="gallery" id="ulgallery" class="am-gallery am-avg-sm-2
  am-avg-md-3 am-avg-lg-4 am-gallery-overlay" data-am-gallery="{ pureview: true }" >
    <!--<li>
        <div class="am-gallery-item">
            <a href="images/1.jpg" class="">
                <img src="images/1.jpg"  alt="全景放样 新城域 180平 二室两厅 中式风格 18W"/>
                <h3 class="am-gallery-title"><a target="_blank" href="http://www.baidu.com" style="color:white">全景放样 新城域 180平 二室两厅 中式风格 18W</a></h3>

                <div class="am-gallery-desc">2375-09-26</div>
            </a>
        </div>
    </li>-->


</ul>

    <script src="js/jquery.min.js"></script>
    <script src="js/amazeui.js"></script>
    <script src="../../JS/XHD.js"></script>
    <script type="text/javascript">

      var search = decodeURI(getparastr("search"));
      $("#search").html(search);
        $.ajax({
            type: "GET",
            url: "../../data/website.ashx", /* 注意后面的名字对应CS的方法名称 */
 data: { Action: "classiclist", search: search, rnd: Math.random() },
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                var obj = result.Rows;
                var item = "";
                  $.each(obj, function (i, data) {

                     item = "<li> " +
                         "  <div class='am-gallery-item'>" +
                         "  <a href='../../" + data['thum_img']+ "'   />"+
                          "    <img src='../../"+data['thum_img']+"' />  <h3 class='am-gallery-title'><a target='_blank' href='" + data['URL'] + "' style='color:white'>" + data['params_name']+data['Community']+data['housetype'] +data['housearea']   + "</a></h3> " +
                         "     <div class='am-gallery-desc'>"+data['DoTime']+" +</div>" +
                         "   </a>" +
                         "  </div >" +
                         "  </li >";
                     $('#ulgallery').append(item);
                 });

                       //  alert(JSON.stringify(result));
                     },
               error: function (XMLHttpRequest, textStatus, errorThrown) {
                   alert(textStatus);
               }
           })



    </script>


</body>
</html>