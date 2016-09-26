using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//using PushSharp.Apple;
//using PushSharp.Core;
//using PushSharp;
using System.IO; 
using System.Threading;
using Newtonsoft.Json;

namespace XHD.CRM.webserver
{
    /// <summary>
    /// 描述:苹果客户端推送类
    /// 作者:茹化肖
    /// 时间:2014年7月4日16:19:40
    /// </summary>
    public class ApplePushService
    {
        private static ApplePushService applePushService;
        private static readonly object syncObject = new object();
      //  private ApnsServiceBroker push;//创建一个推送对象
       // private List<MessageModel> messageList;//消息实体队列
        private readonly string appleCertpath = "C:\\Certificates.p12";
            //AppDomain.CurrentDomain.BaseDirectory  + "webserver\\zs.p12";
        private readonly string appleCertPwd = "spider00153";//密码
        public   ApplePushService()
        {
            //确保该对象被实例化
            //this.push = new ApnsServiceBroker();
            //this.messageList = new List<MessageModel>();
            ////关联推送状态事件
            //push.OnNotificationSent += NotificationSent;
            //push.OnChannelException += ChannelException;
            //push.OnServiceException += ServiceException;
            //push.OnNotificationFailed += NotificationFailed;
            //push.OnDeviceSubscriptionExpired += DeviceSubscriptionExpired;
            //push.OnDeviceSubscriptionChanged += DeviceSubscriptionChanged;
            //push.OnChannelCreated += ChannelCreated;
            //push.OnChannelDestroyed += ChannelDestroyed;
           

        }

        //public bool Push(string deviceToken)
        //{
        //    var appleCert = File.ReadAllBytes(appleCertpath);//将证书流式读取
        //    //var appleCert = appleCertpath.Replace('\\','\');
        //    var config = new ApnsConfiguration(ApnsConfiguration.ApnsServerEnvironment.Sandbox,
        //                appleCertpath, appleCertPwd);

        //    // Create a new broker
        //    var apnsBroker = new ApnsServiceBroker(config);

        //    // Wire up events
        //    apnsBroker.OnNotificationFailed += (notification, aggregateEx) =>
        //    {

        //        aggregateEx.Handle(ex =>
        //        {

        //            // See what kind of exception it was to further diagnose
        //            if (ex is ApnsNotificationException)
        //            {
        //                var notificationException = (ApnsNotificationException)ex;

        //                // Deal with the failed notification
        //                var apnsNotification = notificationException.Notification;
        //                var statusCode = notificationException.ErrorStatusCode;
                       
        //                // Console.WriteLine ($"Apple Notification Failed: ID={apnsNotification.Identifier}, Code={statusCode}");

        //            }
        //            else
        //            {
        //                // Inner exception might hold more useful information like an ApnsConnectionException           
                       
        //                //Console.WriteLine ($"Apple Notification Failed for some unknown reason : {ex.InnerException}");
        //            }

        //            // Mark it as handled
        //            return true;
        //        });
        //    };

        //    apnsBroker.OnNotificationSucceeded += (notification) =>
        //    {
        //        Console.WriteLine("Apple Notification Sent!");
        //    };

        //    // Start the broker
        //    apnsBroker.Start();

        //    // foreach (var deviceToken in MY_DEVICE_TOKENS) {
        //    // Queue a notification to send
        //    apnsBroker.QueueNotification(new ApnsNotification
        //    {
        //        DeviceToken = deviceToken,
        //        Payload = Newtonsoft.Json.Linq.JObject.Parse(("{\"aps\":{\"sound\":\"default\",\"badge\":\"1\",\"alert\":\"这是一条群发广告消息推送的测试消息\"}}"))
        //    });
        //    // }

        //    // Stop the broker, wait for it to finish   
        //    // This isn't done after every message, but after you're
        //    // done with the broker
        //    apnsBroker.Stop();

        //    return true;
        //}
        ////#region=====公布给外接调用的方法
        /////// <summary>
        /////// 获取对象实例
        /////// </summary>
        /////// <returns></returns>
        ////public static ApplePushService GetInstance()
        ////{
        ////    if (applePushService == null)
        ////    {
        ////        lock (syncObject)
        ////        {
        ////            if (applePushService == null)
        ////            {
        ////                applePushService = new ApplePushService();
        ////                applePushService.TherdStart();
        ////            }
        ////        }
        ////    }
        ////    return applePushService;
        ////}
        /////// <summary>
        /////// 添加需要推送的消息
        /////// </summary>
        /////// <param name="message">消息体</param>
        ////public void AddMessage(MessageModel message)
        ////{
        ////    messageList.Add(message);

        ////}
        /////// <summary>
        /////// 推送消息
        /////// </summary>
        /////// <param name="msg">消息体</param>
        /////// <param name="token">用户token</param>
        ////private void SendMessage()
        ////{
        ////    try
        ////    {
        ////        var appleCert = File.ReadAllBytes(appleCertpath);
        ////        if (appleCert.Length > 0 && appleCert != null)//证书对象不为空
        ////        {
        ////            push.RegisterAppleService(new ApplePushChannelSettings(appleCert, appleCertPwd));
        ////            while (true)
        ////            {
        ////                if (messageList.Count > 0)//如果 消息队列中的消息不为零 推送
        ////                {
        ////                    for (int i = 0; i < messageList.Count; i++)
        ////                    {
        ////                        push.QueueNotification(new AppleNotification()
        ////                                              .ForDeviceToken(messageList[i].DeviceToken)
        ////                                              .WithAlert(messageList[i].Message).WithBadge(7)
        ////                                              .WithSound("sound.caf"));
        ////                    }
        ////                    messageList.Clear();//推送成功,清除队列
        ////                }
        ////                else
        ////                {
        ////                    //队列中没有需要推送的消息,线程休眠5秒
        ////                    Thread.Sleep(5000);
        ////                }
        ////            }
        ////        }
        ////    }
        ////    catch (Exception e)
        ////    {
        ////        throw e;
        ////    }
        ////}
        /////// <summary>
        /////// 启动推送
        /////// </summary>
        ////private void TherdStart()
        ////{
        ////    Thread td = new Thread(SendMessage);
        ////    td.IsBackground = true;
        ////    td.Start();
        ////}
        ////#endregion


        ////#region=====推送状态事件

        ////static void DeviceSubscriptionChanged(object sender, string oldSubscriptionId, string newSubscriptionId, INotification notification)
        ////{
        ////    //Currently this event will only ever happen for Android GCM
        ////    //Console.WriteLine("Device Registration Changed:  Old-> " + oldSubscriptionId + "  New-> " + newSubscriptionId + " -> " + notification);
        ////}
        /////// <summary>
        /////// 推送成功
        /////// </summary>
        /////// <param name="sender"></param>
        /////// <param name="notification"></param>
        ////static void NotificationSent(object sender, INotification notification)
        ////{

        ////}
        /////// <summary>
        /////// 推送失败
        /////// </summary>
        /////// <param name="sender"></param>
        /////// <param name="notification"></param>
        /////// <param name="notificationFailureException"></param>
        ////static void NotificationFailed(object sender, INotification notification, Exception notificationFailureException)
        ////{
        ////    //Console.WriteLine("Failure: " + sender + " -> " + notificationFailureException.Message + " -> " + notification);
        ////}

        ////static void ChannelException(object sender, IPushChannel channel, Exception exception)
        ////{
        ////    //Console.WriteLine("Channel Exception: " + sender + " -> " + exception);
        ////}

        ////static void ServiceException(object sender, Exception exception)
        ////{
        ////    //Console.WriteLine("Channel Exception: " + sender + " -> " + exception);
        ////}

        ////static void DeviceSubscriptionExpired(object sender, string expiredDeviceSubscriptionId, DateTime timestamp, INotification notification)
        ////{
        ////    //Console.WriteLine("Device Subscription Expired: " + sender + " -> " + expiredDeviceSubscriptionId);
        ////}

        ////static void ChannelDestroyed(object sender)
        ////{
        ////    //Console.WriteLine("Channel Destroyed for: " + sender);
        ////}

        ////static void ChannelCreated(object sender, IPushChannel pushChannel)
        ////{
        ////    //Console.WriteLine("Channel Created for: " + sender);
        ////}
        ////#endregion
    
    
    }
}