<%@ Page Language="C#" AutoEventWireup="true" %>
 <!DOCTYPE html>
<html
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1,maximum-scale=1, minimum-scale=1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>form</title>
	<style>
		img {
			border: 0;
		}

		body {
			background: #f7f7f7;
			color: #666;
			font: 12px/150% Arial,Verdana, "microsoft yahei";
		}

		html, body, div, dl, dt, dd, ol, ul, li, h1, h2, h3, h4, h5, h6, p, blockquote, pre, button, fieldset, form, input, legend, textarea, th, td {
			margin: 0;
			padding: 0;
		}

		article,aside,details,figcaption,figure,footer,header,main,menu,nav,section,summary {
			display: block;
			margin: 0;
			padding: 0;
		}

		audio,canvas,progress,video {
			display: inline-block;
			vertical-align: baseline;
		}

		a {
			text-decoration: none;
			color: #08acee;
		}

		a:active,a:hover {
			outline: 0;
		}

		button {
			outline: 0;
		}

		mark {
			color: #000;
			background: #ff0;
		}

		small {
			font-size: 80%;
		}

		img {
			border: 0;
		}

		button,input,optgroup,select,textarea {
			margin: 0;
			font: inherit;
			color: inherit;
			outline: none;
		}

		li {
			list-style: none;
		}

		i {
			font-style: normal;
		}

		a {
			color: #666;
		}

		a:hover {
			color: #eee;
		}

		em {
			font-style: normal;
		}

		h2, h3 {
			font-family: "microsoft yahei";
			font-weight: 100;
		}



		/* ------------------- */
		::-moz-placeholder {
			color: #9fa3a7;
		}

		::-webkit-input-placeholder {
			color: #9fa3a7;
		}

		:-ms-input-placeholder {
			color: #9fa3a7;
		}


		.pc-kk-form{
			padding:15px 20px;
		}
		.pc-kk-form-list{
			background:#fff;
			border:1px solid #e5e5e5;
			border-radius:5px;
			height:44px;
			line-height:44px;
			margin-bottom:10px;
		}
		.pc-kk-form-list input{
			width:100%;
			border:none;
			background:none;
			color:#9fa3a7;
			font-size:14px;
			height: 36px;
			padding: 4px 10px;
		}
		.pc-kk-form-list textarea{
			background:none;
			border:none;
			height:60px;
			padding:10px;
			resize:none;
			width:94%;
			line-height:22px;
			color:#9fa3a7;
			font-size:14px;
		}
		.nice-select{
			position: relative;
			background: #fff url(images/a2.jpg) no-repeat right center;
			background-size:18px;
			width:47%;
			float:left;
			border:1px solid #e5e5e5;
			border-radius:5px;
			height:44px;
			line-height:44px;
		}

		.nice-select ul{
			width: 100%;
			display: none;
			position: absolute;
			left: -1px;
			top: 44px;
			overflow: hidden;
			background-color: #fff;
			max-height: 150px;
			overflow-y: auto;
			border: 1px solid #b9bcbf;
			z-index: 9999;
			border-radius:5px;

		}
		.nice-select ul li{
			padding-left:10px;
		}
		.nice-select ul li:hover{
			background:#f8f4f4;
		}
		.pc-kk-form-list-clear{
			background:none;
			border:none;
		}
		.pc-kk-form-btn button{
			background:#ec5224;
			color:#fff;
			border:none;
			width:100%;
			height:50px;
			line-height:50px;
			font-size:16px;
			border-radius:50px;
		}

.aixuexi{

width:50%;
height:100%;
border:1px  ;


}

.aixuexi img{width:100%;height:100%;   top: 50%;
        left: 50%;
        margin-top: 25px; /* 高度的一半 */
        margin-left: 50%; /* 宽度的一半 */
}














	</style>
</head>
<body>
<div style="align: center" class="aixuexi">

<img src="http://ksxc.33erp.com/images/logo/201505231548351C5EC2.png"/>

</div>



	<div class="pc-kk-form">
      
            <div class="pc-kk-form-list pc-kk-form-list-clear">
                <div class="nice-select" name="nice-select" style="width:100%">
                    <input id="allx" type="text" value="案例类型" readonly>
                    <ul class="ulallx"></ul>
                </div>
            </div>
            <div class="pc-kk-form-list">
                <input id="lp" type="text" placeholder="楼盘">
            </div>


            <div class="pc-kk-form-list">
                <input id="qsmj" type="tel" placeholder="起始面积">
            </div>
            <div class="pc-kk-form-list">
                <input id="jzmj" type="tel" placeholder="截止面积">
            </div>
            <div class="pc-kk-form-list">
                <input id="albt" type="text" placeholder="案例标题">
            </div>
            <div class="pc-kk-form-list">
                <input id="hx" type="text" placeholder="户型">
            </div>
            <div class="pc-kk-form-list pc-kk-form-list-clear">
                <div class="nice-select" name="nice-select">
                    <input id="zxfg" type="text" value="装修风格" readonly>
                    <ul  class="ulzxfg">
                      
                    </ul>

                </div>
                <div class="nice-select" name="nice-select" style="float:right">
                    <input id="sjs" type="text" value="设计师" readonly>
                    <ul class="ulsjs">
                        <!--<li data-value="male">张君</li>
                    <li data-value="female">尹先山</li>-->
                    </ul>

                </div>
            </div>


            <div class="pc-kk-form-btn">
                <button   onclick="subm()"> 搜&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;索 </button>
            </div>
       
	</div>


	<script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/classes.js"></script>
	<script>


        function subm() {
        //案例类型
            var allx = $("#allx").val().replace("案例类型","");    
        //楼盘
            var lp = $("#lp").val().replace("楼盘","");    
        //起始面积
            var qsmj = $("#qsmj").val().replace("起始面积","");    
        //截至面积
            var jzmj = $("#jzmj").val().replace("截至面积","");    
        //案例标题
            var albt = $("#albt").val().replace("案例标题","");    
        //户型
            var hx = $("#hx").val().replace("户型","");    
        //装修风格
            var zxfg = $("#zxfg").val().replace("装修风格","");    
        //设计师
            var sjs = $("#sjs").val().replace("设计师","");    

            var search = allx + ';' + lp + ';' + qsmj + ';' + jzmj + ';' + albt + ';' + hx + ';' + zxfg + ';' + sjs;
           
         var url="../classicmobile/pic.aspx?1=1&search=" + encodeURI(search);
          location.href=url; 
        //document.form1.action =  url;
        //document.form1.submit();
        //alert(url);

        }


        $('[name="nice-select"]').click(function(e){

            $('[name="nice-select"]').find('ul').hide();

            $(this).find('ul').show();

            e.stopPropagation();

        });
        $('[name="nice-select"]').on("hover", "li", function () {
        //$('[name="nice-select"] li').hover(function(e){

            $(this).toggleClass('on');

             e.stopPropagation();

        });
        $('[name="nice-select"]').on("click",  "li",  function ()  {
        var val = $(this).text();

            $(this).parents('[name="nice-select"]').find('input').val(val);

            $('[name="nice-select"] ul').hide();

            e.stopPropagation();
        });

        //$('[name="nice-select"] li').click(function(e){

        //    var val = $(this).text();

        //    $(this).parents('[name="nice-select"]').find('input').val(val);

        //    $('[name="nice-select"] ul').hide();

        //    e.stopPropagation();

        //});

        $(document).click(function(){

            $('[name="nice-select"] ul').hide();

        });

	</script>

</body>
</html>