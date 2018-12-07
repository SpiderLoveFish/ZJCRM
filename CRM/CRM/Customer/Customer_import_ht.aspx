<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/input.css" rel="stylesheet" />
    <meta http-equiv="X-UA-Compatible" content="ie=8 chrome=1" />
    <script src="../../lib/jquery/jquery-1.5.2.min.js" type="text/javascript"></script> 
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>  
    <script src="../../JS/XHD.js" type="text/javascript"></script>
    <script src="../../lib/jquery.form.js" type="text/javascript"></script>
    <script type="text/javascript">
        
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 502px; margin: 5px;" class='bodytable1'>
            <tr>
                <td class="table_title1">操作方法：</td>
            </tr>
            <tr>
                <td >
                    1、下载模板：<a href="../../file/ht.docx">合同模板下载</a><br />
                    2、根据模板格式认真填写，请不要修改模板结构及模板文件名称，填写完整。<br /> 
                    3、如果错误，请联系官方技术人员。<br />
                    </td>
            </tr>
           <%-- <tr>
                <td class="table_title1">操作：</td>
            </tr>--%>
          <%--  <tr>
                <td >
                    <input name="upload" type="file" id="upload" onchange="checkpath()" style="width: 250px; height: 21px;" runat="server" /> 
                     <input type="button" id="btn_up" value="上传并导入" style="width: 80px; height: 21px;" disabled="disabled" onclick="update()"/>
                </td>
            </tr>--%>
            </table>


    </form>
</body>
</html>
