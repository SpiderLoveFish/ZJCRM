<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
     <link href="../../lib/ligerUI/skins/ext/css/ligerui-all.css" rel="stylesheet" type="text/css" />
 

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
  
        <%--<script src="../../lib/jquery.form.js" type="text/javascript"></script>--%>
    <script src="../../JS/XHD.js" type="text/javascript"></script>
      <script src="../lib/jquery.form.js" type="text/javascript"></script>

    <script type="text/javascript">
        var VER_AX_LOCALE = "1.1.15.174";//the version of the ActiveX
        var szDevIP = "VSTB065527EJTVD"; //serial ID or ip of ip camera
        var nPort = 81; //the HTTP port of ip camera, if the szDevIP is serial ID, this whill be ignore
        var szAuthAcc = "admin", szAuthPwd = "888888";//account of ip camera
        var nImgW = 420, nImgH = 340;//the window size of ip camera.
        var szDevName = "SDK网页测试";//the caption shown on the video
        var nDevType = 922;
        var bInLan = 1;//whether in LAN,1:LAN, 0：WAN

        $(function () {
            $.ajax({
                type: "GET",
                url: "../../data/Param_SysParam.ashx", /* 注意后面的名字对应CS的方法名称 */
                data: { Action: "formIPCam", CustomerID: getparastr("cid"), IPstyle: getparastr("IPstyle"), comp: getparastr("comp"), rnd: Math.random() },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var obj = eval(result);
              
                    szDevIP = obj.szDevIP;
                    szDevName = obj.address;
                    szAuthAcc = obj.szAuthAcc;
                    szAuthPwd = obj.szAuthPwd;
                    if (obj.IPstyle==1)//1位客户，0为公司内部
                    ShowDev();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("获取客户参数失败!!!" + textStatus);
                  //  top.$.ligerDialog.error('获取客户参数失败！', "", null, 9003);
                }
            });
          
        })

        function ShowDev() {
            try {
                remote.ClearDevs();
            }
            catch (exception) {
                return;
            }

            //		remote.ShowTitle = 0;
            remote.Lan = "cn";  //language cn:chinese en:english jp:japanese
            remote.ShowOSDName = 1;//whether to show ipcam caption on the video
            remote.SwitchLayout("1 x 1");
            remote.Width = nImgW;  //width of the window
            remote.Height = nImgH; //height of the window
            //AddDev4(IP Camera mode (903:M; 902:F; 901:E; 904:V; 905:A),LAN,serial ID or IP, HTTP port, display name, account,password,channel)   	
            remote.ShowToolBar = 1;//whether to show toolbar
            remote.AddDev4(nDevType, bInLan, szDevIP, nPort, szDevName, szAuthAcc, szAuthPwd, 1);
            remote.Listen = 1;//whether to play soound
            remote.TurnImg = 0;   //whether reverse video
            remote.ConnectAll();
            remote.Start();
        }

        var preActTime = 0;
        var bNeedStop = false;	
        function	StopAction()
        {
            //	alert("a");
            remote.PTZ(1,1,-1,0,0,0);
            bNeedStop = false;  
        }

        //set action and send to ipcam
        function setAction(action, time) {
            if ((action == -1) && (!bNeedStop))
                return 0;

            var now_time = new Date();
            //alert(now_time - preActTime);
            if ((preActTime > 0) && (now_time - preActTime < 300)) {
                //alert(now_time-preActTime);
                if (action == -1) {
                    //			alert(now_time-preActTime);
                    setTimeout('StopAction();', 500);
                    return 0;
                }
                else
                    return 0;
            }

            remote.PTZ(1, 1, action, time, 0, 0);
            //Set pause time  
            bNeedStop = action != -1;
            preActTime = now_time;
        }

        var bInstall, bNewest;
            bNewest = false;
            try {
                remote.ClearDevs();
                bInstall = true;

                bNewest = remote.Ver == VER_AX_LOCALE;
            }
            catch (exception) {
                bInstall = false;
            }
            document.writeln("<tr>");
            document.writeln("<td align='center'><font size='2'><br/><br/>");
            if (bInstall && !bNewest) {

            }

            document.writeln("</font>");
            document.writeln("</td>");
            document.writeln("</tr>");
       
    </script>
</head>
<body  ">
    <form id="form1" onsubmit="return false">
         <table width="100%"  border="0" align="center">
        <tr>
          <td align="center"></td>
        </tr>
        <tr>
          <td>
            <table width="800" border="0" Align="left">
              <tr>
                <td  align="center">
                  <OBJECT id="remote" name="remote" classid="clsid:1E125331-B4E3-4EE3-B3C1-24AD1A3E5DEB" WIDTH="320" HEIGHT="311">
                    <FONT COLOR=red SIZE=5>监控插件未安装，请点击<a href='http://cn-download.eyecloud.so/download/application/ipcamax.exe'>这里</a>进行下载，并安装.</FONT>
                  </OBJECT>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="285" border="0" align="center" id="tbPTZ" name="tbPTZ">
                    <tr>
                      <td width="101"><table width="55" border="0" align="center">
                          <tr>
                            <td width="31%">&nbsp;</td>
                            <td width="18%"><input type="button" name="Up" value="UP"  onMouseDown="setAction(0,31)" onMouseUp="setAction(-1,0)" onMouseOut="setAction(-1,0)""></td>
                            <td width="51%">&nbsp;</td>
                          </tr>
                          <tr>
                            <td><input type="button" name="Left" value="Left" onMouseDown="setAction(1,31)" onMouseUp="setAction(-1,0)" onMouseOut="setAction(-1,0)" ></td>
                            <td align="center" valign="middle">&nbsp;</td>
                            <td><input type="button" name="Right" value="Right" onMouseDown="setAction(2,31)" onMouseUp="setAction(-1,0)" onMouseOut="setAction(-1,0)" ></td>
                          </tr>
                          <tr>
                            <td>&nbsp;</td>
                            <td><input type="button" name="Down" value="Down" onMouseDown="setAction(3,31)" onMouseUp="setAction(-1,0)" onMouseOut="setAction(-1,0)" ></td>
                            <td>&nbsp;</td>
                          </tr>
                      </table></td>
                      <td width="167"><table width="60" border="0" align="center">
                          <tr>
                            <td><input type="button" name="Zoom-" value="Zoom+" onMouseDown="setAction(6, 31)" onMouseUp="setAction(-1, 0)" onMouseOut="setAction(-1,0)"></td>
                            <td><input type="button" name="Zoom+" value="Zoom-" onMouseDown="setAction(7, 31)" onMouseUp="setAction(-1, 0)" onMouseOut="setAction(-1,0)" ></td>
                          </tr>
                          <tr>
                            <td><input type="button" name="Focus-" onMouseDown="setAction(4, 31)" onMouseUp="setAction(-1, 0)" onMouseOut="setAction(-1,0)" value="Focus+"></td>
                            <td><input type="button" name="Focus+" onMouseDown="setAction(5, 31)" onMouseUp="setAction(-1, 0)" onMouseOut="setAction(-1,0)" value="Focus-"></td>
                          </tr>
                      </table></td>
                      <td width="10">&nbsp;</td>
                    </tr>
                </table></td>
              </tr>
            
          </table></td>
        </tr>
        <tr>
          <td align="center"></td>
        </tr>
    </table> 
    	

    </form>
   </body>
</html>
