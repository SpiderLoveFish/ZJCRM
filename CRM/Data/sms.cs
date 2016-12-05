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
using System.Data;
using XHD.BLL;
using Newtonsoft.Json;

using Aliyun.Acs.Core;
using Aliyun.Acs.Core.Exceptions;
using Aliyun.Acs.Core.Profile;
using Aliyun.Acs.Sms.Model.V20160927;

namespace XHD.CRM.Data
{
    public class sms
    {
        BLL.Param_SysParam ps = new BLL.Param_SysParam();
        
        public sms() { }

        public string SendSMS(bool isck, string date, string content,string mobile)
        {
            string json = "";
            DataSet ds = ps.GetList_SMSConfig(0, "", "");
            if (ds == null)
            {
                json = "����������ز�����";  
            }
            if (ds.Tables[0].Rows.Count <= 0)
            {
                json = "����������ز�����";  
            }
             try
      {
          foreach (DataRow dr in ds.Tables[0].Rows)
          {
              string param = "action=send&userid=" + dr["userid"].ToString() + "&account=" + dr["account"].ToString() + "&password=" + dr["password"].ToString() + "&content=" + content + "&mobile=" + mobile + "&sendtime=";
            
           // string param = "action=send&userid=4905&account=xincheng&password=a123123&content=" + content + "&mobile=" + mobile + "&sendtime=";
            string message = "";
            if (isck)//�Ƿ�ʱ����
            {
                param = param + date; //��ʽ yyyymmddhhnnss
            }
            else
            {
                // param = param + "0";//����Ҫ��ʱ���ͣ�Ҳ��Ҫ����0
            }
            byte[] bs = Encoding.UTF8.GetBytes(param);

            HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create("http://" + dr["ip"].ToString() + "/sms.aspx");
            req.Method = "POST";
            req.ContentType = "application/x-www-form-urlencoded";
            req.ContentLength = bs.Length;

            using (Stream reqStream = req.GetRequestStream())
            {
                reqStream.Write(bs, 0, bs.Length);
            }
            using (WebResponse wr = req.GetResponse())
            {
               // StreamReader sr = new StreamReader(wr.GetResponseStream(), System.Text.Encoding.Default);
               // message = sr.ReadToEnd().Trim();
                Stream stream = wr.GetResponseStream();
                message += new StreamReader(stream, System.Text.Encoding.UTF8).ReadToEnd();//������룺utf-8 + streamreader.readtoend

            }
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(message);
            json = Newtonsoft.Json.JsonConvert.SerializeXmlNode(doc);
            ps.InsertSMSLog(json, "");
               }
          }
             catch (Exception ex) { json = ex.Message; }
 
              

            return json;
        }


        public string aliyunSendSMS(string tel,string type,string para)
        {
            string json = "";
            string strwhere = " servername='aliyun'";
            if (type != "")
                strwhere += " AND userid='"+type+"' ";
            DataSet ds = ps.GetList_SMSConfig(0, strwhere, "");
            if (ds == null)
            {
                json = "����������ز�����";
            }
            if (ds.Tables[0].Rows.Count <= 0)
            {
                json = "����������ز�����";
            }
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                IClientProfile profile = DefaultProfile.GetProfile("cn-hangzhou",dr["accessKey"].ToString() , dr["accessSecret"].ToString() );
                IAcsClient client = new DefaultAcsClient(profile);
                SingleSendSmsRequest request = new SingleSendSmsRequest();
                try
                {
                    request.SignName = dr["SignName"].ToString(); 
                    request.TemplateCode = dr["TemplateCode"].ToString();
                    request.RecNum = tel;// "���պ��룬���������Զ��ŷָ�";
                    if (para == "")
                        request.ParamString = dr["ParamString"].ToString(); //"����ģ���еı�����������Ҫת��Ϊ�ַ����������û�ÿ���������ȱ���С��15���ַ���";
                    else request.ParamString = para;
                    SingleSendSmsResponse httpResponse = client.GetAcsResponse(request);
                    json = httpResponse.HttpResponse.Status.ToString();
                }
                catch (ServerException e)
                {
                    json = "" + e.Message;
                }
                catch (ClientException e)
                {
                    json = "" + e.Message;
                }
            }
            return json;
        }
    }
}