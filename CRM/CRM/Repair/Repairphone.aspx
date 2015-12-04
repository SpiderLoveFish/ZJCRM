<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Repairphone.aspx.cs" Inherits="XHD.CRM.CRM.Repair.Repairphone" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
     <script src="../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
   
    <script "javascript" type="text/javascript">
        function dosubmit() {
            var tel = $("#iphone").val();
            var reg = /^0?1[3|4|5|8][0-9]\d{8}$/;
            if (reg.test(tel)) {
                window.location.href = "Repair.aspx?Khbh=" + tel;
            } else {
                $("#SErrMsg").html("手机号码错误!");

            };
        }
    </script>

    
    <style>
     input[type=text], input[type=password] {
        border-color: #bbb;
        height: 38px;
        font-size: 14px;
        border-radius: 2px;
        outline: 0;
        border: #ccc 1px solid;
        padding: 0 10px;
        width: 250px;
        -webkit-transition: box-shadow .5s;
        margin-bottom: 15px;
    }

        input[type=text]:hover,  input[type=text]:focus, input[type=password]:hover,  input[type=password]:focus {
            border: 1px solid #56b4ef;
            box-shadow: inset 0 1px 3px rgba(0,0,0,.05),0 0 8px rgba(82,168,236,.6);
            -webkit-transition: box-shadow .5s;
        }
    input::-webkit-input-placeholder {
        color: #999;
        -webkit-transition: color .5s;
    }

    input:focus::-webkit-input-placeholder,  input:hover::-webkit-input-placeholder {
        color: #c2c2c2;
        -webkit-transition: color .5s;
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <input type="text"  id="iphone"   placeholder="请输入手机号码" name="iphone" />
        <input type="button" id="submit" value="提交" onclick="dosubmit()"/>
      <span id="SErrMsg" style=" color:red; "></span>
    </div>
    </form>
</body>
</html>
