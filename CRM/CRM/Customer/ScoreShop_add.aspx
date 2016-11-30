<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>

    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>

    <script src="../../lib/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="../../lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/common.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script src="../../JS/Toolbar.js" type="text/javascript"></script>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ci = false;
        var thumimg = "";
        $(function () {
            

            $.metadata.setType("attr", "validate");
            XHD.validate($(form1));

            $("form").ligerForm();

           

            
               // if (getparastr("status")=="1")
                loadForm(getparastr("cid"));
            
            $("#btn_logo").click(function () {
                top.$.ligerDialog.open({
                    width: 400, height: 80, url: "CRM/Customer/Score_img_add.aspx", title: "缩略图修改", buttons: [
                        {
                            text: '提交', onclick: function (item, dialog) {
                                //dialog.frame.f_save();
                                f_save_img(item, dialog);
                                // setTimeout( loadForm(getparastr("cid")), 200);
                                
                            }
                        },
                        {
                            text: '关闭', onclick: function (item, dialog) {
                                dialog.close();
                            }
                        }
                    ]
                });
            })
        })
        function f_save_img(item, dialog) {
            thumimg = dialog.frame.f_return();
            // alert(thumimg);
            if (thumimg == "")
            {
                alert('先上传图片才能提交！');
                return;
            }
            dialog.close();
            $("#thumimg").attr("src", "../../" + thumimg);
        }

        function f_save() {
            if ($(form1).valid()) {
                var sendtxt = "&Action=save&id=" + getparastr("cid") + "&thumimg=" + thumimg;
                var a = $("form :input").fieldSerialize() + sendtxt;
                return a;
            }
            else {alert("数据不完整，请填写标题！选择类型！"); }
        }
         
        function loadForm(oaid) {
            $.ajax({
                type: "GET",
                url: "../../data/ScoreShop.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: 'form', cid: oaid, rnd: Math.random() }, /* 注意参数的格式和名称 */
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
                    for (var n in obj) {
                        if (obj[n] == "null" || obj[n] == null)
                            obj[n] = "";
                    }
                   
                    $("#T_ScoreName").val(obj.ScoreName)
                    $('#T_NeedScorer').val(obj.NeedScore);
                    $("#T_TotalSum").val(obj.TotalSum)
                    $('#T_RemainSum').val(obj.RemainSum);
                    $("#T_ScoreDescribe").val(obj.ScoreDescribe)
                    $("#thumimg").attr("src", "../../" + obj.thumimg);
                    thumimg = obj.thumimg;
                }
            });
        }

       

       
        
    </script>
</head>
<body>
    <form id="form1" onsubmit="return false">
   
        <table style="width: 550px; margin: 5px;" class='bodytable1'>
            <tr>
                <td colspan="4" class="table_title1">基本信息</td>
            </tr>
            <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">积分名称：</div>
                </td>
                <td>
                   
                        <input type="text" id="T_ScoreName" name="T_ScoreName"   ltype="text"  ligerui="{width:196}"  />
                  
                    
                </td>
                <td>
                    <div style="width: 80px; text-align: right; float: right">需要积分：</div>
                </td>
                <td>
                     <input type="text" id="T_NeedScorer" name="T_NeedScore" value="10"  ltype='spinner' ligerui="{width:180}"  validate="{required:true}" /></td>
            </tr>
             <tr>
                <td>
                    <div style="width: 80px; text-align: right; float: right">总数量：</div>
                </td>
                <td>
                    
                                   <input type="text" id="T_TotalSum" name="T_TotalSum" value="10"  ltype='spinner' ligerui="{width:180}"  validate="{required:true}" /></td>
        
                     
               
                <td>
                    <div style="width: 80px; text-align: right; float: right">剩余数量：</div>
                </td>
                <td>
                    <input type="text" id="T_RemainSum" name="T_RemainSum" value="10"  ltype='spinner' ligerui="{width:180}"  validate="{required:true}" /></td>
        
            </tr>
          
      
                
            <tr>
                <td colspan="4" class="table_title1">其他信息</td>
            </tr>
           
          
              <tr>
                <td colspan="4" class="table_title1">描述</td>
            </tr>
               <tr>
              <td colspan="4" >
                  
                   <input id="T_ScoreDescribe" name="T_ScoreDescribe" type="text" ltype="text" ligerui="{width:496}"   /></td>   
                 
            </tr>
                <tr>
                <td colspan="4" class="table_title1">缩略图</td>
            </tr>
             <tr>
                     <td  colspan="3">
                    <img id="thumimg" style="height: 144px" />
                </td>
                <td  >
                     
                    <input type="button" value="修改" style="width:80px;height:22px;" id="btn_logo"/></td>
          
            </tr>
    
         
        </table>


    </form>
</body>
</html>
