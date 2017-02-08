
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>客户自助报价</title>
</head>

<body>
<SCRIPT src="http://www.ksxczs.com/statics/js/xczs/js/jquery-1.8.2.min.js" type="text/javascript"></SCRIPT>
 
<SCRIPT src="http://www.ksxczs.com/statics/js/xczs/js/lazyload-min.js"></SCRIPT>
<SCRIPT type="text/javascript">

             LazyLoad.css(["http://www.ksxczs.com/statics/css/xczs/css/cityStyle.css"], function () {
                LazyLoad.js(["http://www.ksxczs.com/statics/js/xczs/js/cityScript.js"], function () {
                    var test = new citySelector.cityInit("inputcity");
                   });
            });


       
        
        
        </SCRIPT>
<style type="text/css">
*{margin:0;padding:0;list-style-type:none;}

.formbox{text-align:center;width:100%;margin:0 auto;height:351px;margin-top:0px;background-image:url('bj_files/bg.png');background-repeat:no-repeat;border-top:1px solid black;border-bottom:1px solid black;}
.formbox .con{text-align:center;height:340px;width:304px;float:right;border:1px solid black}
.coolbg{
	font-size:18px;
	line-height:30px;
	background-color:rgb(10,114,189);
	border:1px solid #bdc5ca;
	height:45px;
	width:100%;
	color:rgb(255,255,255);
	margin:0 auto;
}
td{padding:7px 10px;text-align:right;}
</style>


<div  style='position:fixed; z-index:999; top:0;' class="formbox">
        
	<div class="con">
		<img src="bj_files/yy_top.png">
		<form action="#" method="post"  name="form_book" onSubmit="return cheackbook();" enctype="multipart/form-data">
			<input type="hidden" name="action" value="post" />
			<input type="hidden" name="diyid" value="1" />
			<input type="hidden" name="do" value="2" />
			<table width="101%" cellpadding="0" cellspacing="1" style="width:100%;">
				<tr>
					<td width="60px">地&nbsp;&nbsp;区</td>
					<td > <INPUT id="inputcity" style="width: 95%; border:1px  solid rgb(191, 209, 245); padding:4px; font-size:14px;" type="text" readonly value="苏州"> 
     <INPUT name="cityid" id="cityid" type="hidden" value="166"> 
					</td>
				</tr>
				<tr>
					<td>姓&nbsp;&nbsp;名</td>
					<td style="text-align:left;"><input type='text' name='age' id='age'  style="width:35%;  border:1px  solid rgb(191, 209, 245); padding:4px; font-size:14px;"   value='' /> 
					
					性别<input type='radio' name='sex' class='np' value='男' checked>男  <input type='radio' name='sex' class='np' value='女'>女 </td>
				</tr>
				<tr>
					<td>住&nbsp;&nbsp;址</td>
					<td><input type='text' name='dushu' id='dushu' style="width:95%;  border:1px  solid rgb(191, 209, 245); padding:4px; font-size:14px;"   value=''  />
					</td>
				</tr>
				<tr>
					<td>电&nbsp;&nbsp;话</td>
					<td><input type='text' name='dianhua' id='dianhua' style="width:95%; border:1px  solid rgb(191, 209, 245); padding:4px; font-size:14px;"  value='' />
					</td>
				</tr>
				<tr>
					<td>面&nbsp;&nbsp;积</td>
					<td style="text-align:left;"><input type='text' name='hx' id='hx' style="width:95%; border:1px  solid rgb(191, 209, 245); padding:4px; font-size:14px;"   value='' /></td>
				</tr>
                
				<tr>
					<td align="right" valign="top"></td>
					<td>
					<script type="text/javascript">
					
					window.onload = function(){
					
					var nowDate = new Date();
					
					var str = nowDate.getFullYear()+"-"+(nowDate.getMonth() + 1)+"-"+nowDate.getDate()+" "+nowDate.getHours()+":"+nowDate.getMinutes()+":"+nowDate.getSeconds();
					
					document.getElementById("mytime").value=str;
					
					}
					</script>
					</td>
				</tr>
				<tr>
					<td align="right" valign="top"></td>
					<td><input type='hidden' name='laiyuan' id='laiyuan' style='width:250px'   value='#' />
					</td>
				</tr>
				</table>
				<input type="submit" name="submit" value="开始报价" class='coolbg'  style="cursor:pointer" />&nbsp;
		</form>
	</div>
</div>

</body>
</html>
