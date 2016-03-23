using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using XHD.Common;
using System.Net;
using System.Text;
using System.IO;
using System.Xml; 

namespace XHD.CRM.Data
{
    public class sms
    {
        public sms() { }

        public string SendSMS(bool isck, string date, string content,string mobile)
        {
            string param = "action=send&userid=4905&account=xincheng&password=a123123&content=" + content + "&mobile=" + mobile + "&sendtime=";
            string message = "";
            if (isck)//是否定时发送
            {
                param = param + date; //格式 yyyymmddhhnnss
            }
            else
            {
                // param = param + "0";//不需要定时发送，也需要带上0
            }
            byte[] bs = Encoding.UTF8.GetBytes(param);

            HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create("http://118.145.18.170:8080/sms.aspx");
            req.Method = "POST";
            req.ContentType = "application/x-www-form-urlencoded";
            req.ContentLength = bs.Length;

            using (Stream reqStream = req.GetRequestStream())
            {
                reqStream.Write(bs, 0, bs.Length);
            }
            using (WebResponse wr = req.GetResponse())
            {
                StreamReader sr = new StreamReader(wr.GetResponseStream(), System.Text.Encoding.Default);
                message = sr.ReadToEnd().Trim();
            }
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(message);
            string json = Newtonsoft.Json.JsonConvert.SerializeXmlNode(doc);

            return json;
        }
    }
}