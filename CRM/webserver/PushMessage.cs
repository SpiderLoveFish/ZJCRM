﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Google.ProtocolBuffers;
using com.gexin.rp.sdk.dto;
using com.igetui.api.openservice;
using com.igetui.api.openservice.igetui;
using com.igetui.api.openservice.igetui.template;
using com.igetui.api.openservice.payload;
using System.Net;

/**
 * 
 * 说明：
 *      此工程是一个测试工程，所用的相关.dll文件，都已经存在protobuffer文件里，需要加载到References里。
 *      工程中还有用到一个System.Web.Extensions文件，这个文件是用到Framework里V4.0版本的，
 *      一般路径如下：C:\Program Files\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.0，
 *      或如下路径：C:\Program Files\Reference Assemblies\Microsoft\Framework\v3.5没有的也可以在protobuffer
 *      文件夹里找到。如再有问题，请直接联系技术客服，谢谢！
 *      GetuiServerApiSDK：此.dll文件为个推C#版本的SDK文件
 *      Google.ProtocolBuffers：此.dll文件为Google的数据交换格式文件
 *  注：
 *      新增一个连接超时时间设置，通过在环境变量--用户变量中增加名为：GETUI_TIMEOUT 的变量（修改环境变量，
       电脑重启后才能生效），值则是超时时间，如不设定，则默认为20秒。
 **/

namespace XHD.CRM.webserver
{
    public class PushMessage
    {
        //参数设置 <-----参数需要重新设置----->
        //http的域名
        //private static String HOST = "http://sdk.open.api.igexin.com/apiex.htm";

        //https的域名
        //private static String HOST = "https://api.getui.com/apiex.htm";

        //定义常量, appId、appKey、masterSecret 采用本文档 "第二步 获取访问凭证 "中获得的应用配置
        //private static String APPID = "hkcz6ujRg38Wgf1wBja1x2";
        //private static String APPKEY = "zn56cobCs79kvqOlEsldo7";
        //private static String MASTERSECRET = "ozYMeIxE2w74NidyfnLti6";
        //private static String CLIENTID = "a48128de382e0b8cbb3a1dd79d02a21f";

        //private static String DeviceToken = "";  //填写IOS系统的DeviceToken

        public PushMessage()
        {
            //toList接口每个用户状态返回是否开启，可选
            //Console.OutputEncoding = Encoding.GetEncoding(936);
            Environment.SetEnvironmentVariable("needDetails", "true");

            //下为消息推送的四种方式，单独使用时，请注释掉另外三种方法

            //对单个用户的推送
            //pushMessageToApp();

            ////对指定列表用户推送
            //PushMessageToList();

            ////对指定应用群推送
            //pushMessageToApp();

            ////APN简化推送
            //apnPush();
        }

        public  string PushMessageToSingle(string HOST, string APPKEY, string MASTERSECRET, string APPID, string CLIENTID)
        {

            IGtPush push = new IGtPush(HOST, APPKEY, MASTERSECRET);

            //消息模版：TransmissionTemplate:透传模板

            TransmissionTemplate template = TransmissionTemplateDemo(APPKEY, APPID, "test测试");


            // 单推消息模型
            SingleMessage message = new SingleMessage();
            message.IsOffline = true;                         // 用户当前不在线时，是否离线存储,可选
            message.OfflineExpireTime = 1000 * 3600 * 12;            // 离线有效时间，单位为毫秒，可选
            message.Data = template;
            //判断是否客户端是否wifi环境下推送，2为4G/3G/2G，1为在WIFI环境下，0为不限制环境
            //message.PushNetWorkType = 1;  

            com.igetui.api.openservice.igetui.Target target = new com.igetui.api.openservice.igetui.Target();
            target.appId = APPID;
            target.clientId = CLIENTID;
            //target.alias = ALIAS;
            try
            {
                String pushResult = push.pushMessageToSingle(message, target);
                    return pushResult ;
            }
            catch (RequestException e)
            {
                String requestId = e.RequestId;
                //发送失败后的重发
                String pushResult = push.pushMessageToSingle(message, target, requestId);
               return  pushResult ;
            }
        }

        //PushMessageToList接口测试代码
        public string PushMessageToList(string HOST, string APPKEY, string MASTERSECRET, string APPID, string CLIENTID, string title, string body)
        {
            try
            {
                // 推送主类（方式1，不可与方式2共存）
                IGtPush push = new IGtPush(HOST, APPKEY, MASTERSECRET);
                // 推送主类（方式2，不可与方式1共存）此方式可通过获取服务端地址列表判断最快域名后进行消息推送，每10分钟检查一次最快域名
                //IGtPush push = new IGtPush("",APPKEY,MASTERSECRET);
                ListMessage message = new ListMessage();

                NotificationTemplate template = NotificationTemplateDemo(APPKEY, APPID,title,body);
                // 用户当前不在线时，是否离线存储,可选
                message.IsOffline = false;
                // 离线有效时间，单位为毫秒，可选
                message.OfflineExpireTime = 1000 * 3600 * 12;
                message.Data = template;
                 message.PushNetWorkType = 0;        //判断是否客户端是否wifi环境下推送，1为在WIFI环境下，0为不限制网络环境。
                //设置接收者
                List<com.igetui.api.openservice.igetui.Target> targetList = new List<com.igetui.api.openservice.igetui.Target>();
                string[] str = CLIENTID.Split(';');
                for (int i = 0; i < str.Length; i++)
                {
                    if (str[i].Length > 5)
                    {

                        com.igetui.api.openservice.igetui.Target target1 = new com.igetui.api.openservice.igetui.Target();
                        target1.appId = APPID;
                        target1.clientId = str[i];
                        targetList.Add(target1);
                    }
                }


                // 如需要，可以设置多个接收者
                //com.igetui.api.openservice.igetui.Target target2 = new com.igetui.api.openservice.igetui.Target();
                //target2.AppId = APPID;
                //target2.ClientId = "ddf730f6cabfa02ebabf06e0c7fc8da0";


                //targetList.Add(target2);

                String contentId = push.getContentId(message);
                String pushResult = push.pushMessageToList(contentId, targetList);
                return pushResult;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }


        //pushMessageToApp接口测试代码
        public string pushMessageToApp(string HOST, string APPKEY, string MASTERSECRET, string APPID, string CLIENTID)
        {
            // 推送主类（方式1，不可与方式2共存）
            IGtPush push = new IGtPush(HOST, APPKEY, MASTERSECRET);
            // 推送主类（方式2，不可与方式1共存）此方式可通过获取服务端地址列表判断最快域名后进行消息推送，每10分钟检查一次最快域名
            //IGtPush push = new IGtPush("",APPKEY,MASTERSECRET);

            AppMessage message = new AppMessage();

            // 设置群推接口的推送速度，单位为条/秒，仅对pushMessageToApp（对指定应用群推接口）有效
            message.Speed = 100;

            TransmissionTemplate template = TransmissionTemplateDemo(APPKEY, APPID,"");

            // 用户当前不在线时，是否离线存储,可选
            message.IsOffline = false;
            // 离线有效时间，单位为毫秒，可选  
            message.OfflineExpireTime = 1000 * 3600 * 12;
            message.Data = template;
            //message.PushNetWorkType = 0;        //判断是否客户端是否wifi环境下推送，1为在WIFI环境下，0为不限制网络环境。
            List<String> appIdList = new List<string>();
            appIdList.Add(APPID);

            //通知接收者的手机操作系统类型
            List<String> phoneTypeList = new List<string>();
            //phoneTypeList.Add("ANDROID");
            //phoneTypeList.Add("IOS");
            //通知接收者所在省份
            List<String> provinceList = new List<string>();
            //provinceList.Add("浙江");
            //provinceList.Add("上海");
            //provinceList.Add("北京");

            List<String> tagList = new List<string>();
            //tagList.Add("开心");

            message.AppIdList = appIdList;
            message.PhoneTypeList = phoneTypeList;
            message.ProvinceList = provinceList;
            message.TagList = tagList;


            String pushResult = push.pushMessageToApp(message);
           return pushResult ;
        }

         public string apnPush(string HOST, string APPKEY, string MASTERSECRET, string APPID, string DeviceToken,string title,string body)
        {
            try
            {
                //APN高级推送
                IGtPush push = new IGtPush(HOST, APPKEY, MASTERSECRET);
                APNTemplate template = new APNTemplate();
                APNPayload apnpayload = new APNPayload();
                DictionaryAlertMsg alertMsg = new DictionaryAlertMsg();
                alertMsg.Body = body;
                alertMsg.ActionLocKey = body;
                alertMsg.LocKey = body;
                alertMsg.addLocArg("addLocArg");
                alertMsg.LaunchImage = "LaunchImage";
                //IOS8.2支持字段
                alertMsg.Title = title;
                alertMsg.TitleLocKey = title;
                alertMsg.addTitleLocArg("addTitleLocArg");

                apnpayload.AlertMsg = alertMsg;
                apnpayload.Badge = 1;
                apnpayload.ContentAvailable = 1;
                apnpayload.Category = "";
                apnpayload.Sound = "";
                apnpayload.addCustomMsg("payload", "payload");
                template.setAPNInfo(apnpayload);


                /*单个用户推送接口*/
                //SingleMessage Singlemessage = new SingleMessage();
                //Singlemessage.Data = template;
                //String pushResult = push.pushAPNMessageToSingle(APPID, DeviceToken, Singlemessage);
                //Console.Out.WriteLine(pushResult);

                /*多个用户推送接口*/
                ListMessage listmessage = new ListMessage();
                listmessage.Data = template;
                String contentId = push.getAPNContentId(APPID, listmessage);
                //Console.Out.WriteLine(contentId);
                List<String> devicetokenlist = new List<string>();
                string[] str = DeviceToken.Split(';');
                for (int i = 0; i < str.Length; i++)
                {
                    if (str[i].Length >30)
                        devicetokenlist.Add(str[i]);
                }

                String ret = push.pushAPNMessageToList(APPID, contentId, devicetokenlist);
                return ret;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        //通知透传模板动作内容
     public static NotificationTemplate NotificationTemplateDemo(string APPKEY, string APPID,string TITLE,string    BODY)
        {
            NotificationTemplate template = new NotificationTemplate();
            template.AppId = APPID;
            template.AppKey = APPKEY;
            //通知栏标题
            template.Title = TITLE;
            //通知栏内容     
            template.Text = BODY;
            //通知栏显示本地图片
            template.Logo = "";
            //通知栏显示网络图标
            template.LogoURL = "";
            //应用启动类型，1：强制应用启动  2：等待应用启动
            template.TransmissionType = "1";
            //透传内容  
            template.TransmissionContent = BODY;
            //接收到消息是否响铃，true：响铃 false：不响铃   
            template.IsRing = true;
            //接收到消息是否震动，true：震动 false：不震动   
            template.IsVibrate = true;
            //接收到消息是否可清除，true：可清除 false：不可清除    
            template.IsClearable = true;
            //设置通知定时展示时间，结束时间与开始时间相差需大于6分钟，消息推送后，客户端将在指定时间差内展示消息（误差6分钟）
            //String begin = "2015-03-06 14:36:10";
            //String end = "2015-03-06 14:46:20";
            String begin = DateTime.Now.AddMinutes(-10).ToString("yyyy-MM-dd HH:mm:ss");
            String end = DateTime.Now.AddMinutes(10).ToString("yyyy-MM-dd HH:mm:ss");
          
            template.setDuration(begin, end);

            return template;
        }

        //透传模板动作内容
     public static TransmissionTemplate TransmissionTemplateDemo(string APPKEY, string APPID,string content)
        {
            TransmissionTemplate template = new TransmissionTemplate();
            template.AppId = APPID;
            template.AppKey = APPKEY;
            //应用启动类型，1：强制应用启动 2：等待应用启动
            template.TransmissionType = "1";
            //透传内容  
            template.TransmissionContent = content;
            //设置通知定时展示时间，结束时间与开始时间相差需大于6分钟，消息推送后，客户端将在指定时间差内展示消息（误差6分钟）
            String begin = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            String end = DateTime.Now.AddMinutes(6).ToString("yyyy-MM-dd HH:mm:ss");
            template.setDuration(begin, end);

            return template;
        }

        //网页模板内容
     public static LinkTemplate LinkTemplateDemo(string APPKEY, string APPID)
        {
            LinkTemplate template = new LinkTemplate();
            template.AppId = APPID;
            template.AppKey = APPKEY;
            //通知栏标题
            template.Title = "请填写通知标题";
            //通知栏内容 
            template.Text = "请填写通知内容";
            //通知栏显示本地图片 
            template.Logo = "";
            //通知栏显示网络图标，如无法读取，则显示本地默认图标，可为空
            template.LogoURL = "";
            //打开的链接地址    
            template.Url = "http://www.baidu.com";
            //接收到消息是否响铃，true：响铃 false：不响铃   
            template.IsRing = true;
            //接收到消息是否震动，true：震动 false：不震动   
            template.IsVibrate = true;
            //接收到消息是否可清除，true：可清除 false：不可清除
            template.IsClearable = true;
            return template;
        }

        //通知栏弹框下载模板
     public static NotyPopLoadTemplate NotyPopLoadTemplateDemo(string APPKEY, string APPID)
        {
            NotyPopLoadTemplate template = new NotyPopLoadTemplate();
            template.AppId = APPID;
            template.AppKey = APPKEY;
            //通知栏标题
            template.NotyTitle = "请填写通知标题";
            //通知栏内容
            template.NotyContent = "请填写通知内容";
            //通知栏显示本地图片
            template.NotyIcon = "icon.png";
            //通知栏显示网络图标
            template.LogoURL = "http://www-igexin.qiniudn.com/wp-content/uploads/2013/08/logo_getui1.png";
            //弹框显示标题
            template.PopTitle = "弹框标题";
            //弹框显示内容    
            template.PopContent = "弹框内容";
            //弹框显示图片    
            template.PopImage = "";
            //弹框左边按钮显示文本    
            template.PopButton1 = "下载";
            //弹框右边按钮显示文本    
            template.PopButton2 = "取消";
            //通知栏显示下载标题
            template.LoadTitle = "下载标题";
            //通知栏显示下载图标,可为空 
            template.LoadIcon = "file://push.png";
            //下载地址，不可为空
            template.LoadUrl = "http://www.appchina.com/market/d/425201/cop.baidu_0/com.gexin.im.apk ";
            //应用安装完成后，是否自动启动
            template.IsActived = true;
            //下载应用完成后，是否弹出安装界面，true：弹出安装界面，false：手动点击弹出安装界面 
            template.IsAutoInstall = true;
            //接收到消息是否响铃，true：响铃 false：不响铃
            template.IsBelled = true;
            //接收到消息是否震动，true：震动 false：不震动   
            template.IsVibrationed = true;
            //接收到消息是否可清除，true：可清除 false：不可清除    
            template.IsCleared = true;
            return template;
        }


    }
}
