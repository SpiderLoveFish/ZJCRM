using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using XHD.Common;
using System.Web.Security;
using System.IO;
using System.Net;
using System.Net.Cache;
using System.Security.Cryptography;
using System.Data;
using System.Text;
using XHD.CRM.Data;

namespace XHD.CRM.webserver
{
    /// <summary>
    /// Summary description for kjlapi
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class testapi : System.Web.Services.WebService
    {
        string interfaceUrl = "http://expappapi.go-mobile.cn/Sc_FamilyExperience/v1.0/";

      
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public string UpdateUserClientId()
        {
            IDictionary<string, string> postdata = new Dictionary<string, string>();
            postdata.Add("loginname", "spider");
            postdata.Add("pwd", "spider");
            postdata.Add("clienid", "");
            postdata.Add("ver", "");

            //发送POST数据  
            StringBuilder buffer = new StringBuilder();
            if (!(postdata == null || postdata.Count == 0))
            {

                int i = 0;
                foreach (string key in postdata.Keys)
                {
                    if (i > 0)
                    {
                        buffer.AppendFormat("&{0}={1}", key, postdata[key]);
                    }
                    else
                    {
                        buffer.AppendFormat("{0}={1}", key, postdata[key]);
                        i++;
                    }
                }
            }

            // 设置HTTP请求的参数，等同于以query string的方式附在URL后面
            //// API地址，生产环境域名对应为www.kujiale.com
            string api = interfaceUrl + "UpdateUserClientId";

            string result = "";
            //  CookieCollection ck=new CookieCollection();
            //result = 
            //    Comm.HttpHelper.CreatePostHttpResponse(test, postdata, 100000, "",ck);

            // result = PostWebRequest(api, postdata);
            // result = HttpPost(api, buffer.ToString());
            result = HttpHelper_GetStr(api,null, "POST", buffer.ToString());
            return result;
        }
 
        [WebMethod]
        public string getdata(string idindex,string data)
        {
            data = data.Replace("{", "").Replace("}", "").Replace(" ", "").Replace("\t","") ; 
            //string[] type = data.Split(':');
            string[] sdata = data.Split(',');
            IDictionary<string, string> postdata = new Dictionary<string, string>();
            for (int i = 0; i < sdata.Length; i++)
            {
                string[] type = sdata[i].Split(':');
                postdata.Add(type[0], type[1]);
            }
            //发送POST数据  
            StringBuilder buffer = new StringBuilder();
            if (!(postdata == null || postdata.Count == 0))
            {

                int i = 0;
                foreach (string key in postdata.Keys)
                {
                    if (i > 0)
                    {
                        buffer.AppendFormat("&{0}={1}", key, postdata[key]);
                    }
                    else
                    {
                        buffer.AppendFormat("{0}={1}", key, postdata[key]);
                        i++;
                    }
                }
            }

            // 设置HTTP请求的参数，等同于以query string的方式附在URL后面
            //// API地址，生产环境域名对应为www.kujiale.com
            string api = interfaceUrl + idindex;

            string result = "";
            //  CookieCollection ck=new CookieCollection();
            //result = 
            //    Comm.HttpHelper.CreatePostHttpResponse(test, postdata, 100000, "",ck);

            // result = PostWebRequest(api, postdata);
            // result = HttpPost(api, buffer.ToString());
            DateTime dt = DateTime.Now;
            string A = ("c1234" + '/' + "982adca0-77c4-11e6-9ca1-29407e7612c2" + '/' + "Don`t Found Clientid" + '/' + Math.Round(GetTime()/1000));


            string header = base64_encode(A);
            result = HttpHelper_GetStr(api,header, "POST", buffer.ToString());
            return result;
        }
         
        private void writereturnstr(string returnstr)
        {

            Context.Response.Charset = "UTF-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
            Context.Response.Write(returnstr);
            Context.Response.End();
        }

        private string HttpDELETE(string Url)
        {
            string str = "";
            HttpWebRequest request;
            string urlPath = Url;
            int millisecond = 30000;
            WebResponse response = null;
            StreamReader reader = null;
            try
            {
                request = (HttpWebRequest)WebRequest.Create(urlPath);
                //request.Proxy = null;//关闭代理（重要）
                request.Timeout = millisecond;
                request.Method = "DELETE";
                //request.Accept = "application/json";
                //request.ContentType = "application/json";
                request.ServicePoint.Expect100Continue = false;
                response = (WebResponse)request.GetResponse();
                reader = new StreamReader(response.GetResponseStream());
                str = reader.ReadToEnd();
            }
            catch (Exception ex)
            {

                str = "";
            }
            return str;
        }

        private string HttpPut(string Url)
        {
            string result = "";
            System.Net.WebClient myClient = new System.Net.WebClient();
            // myClient.Headers.Add("U-ApiKey", key);
            myClient.Encoding = Encoding.UTF8;
            try
            {
                result = myClient.UploadString(Url, "PUT", "");
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            return result;
        }

        private string HttpGet(string Url)
        {
            HttpHelper http = new HttpHelper();
            HttpItem item = new HttpItem()
            {
                URL = Url,//URL这里都是测试     必需项
                Encoding = null,//编码格式（utf-8,gb2312,gbk）     可选项 默认类会自动识别
                //Encoding = Encoding.Default,
                Method = "GET",//URL     可选项 默认为Get
            };
            //得到HTML代码
            HttpResult result = http.GetHtml(item);
            string html = result.Html;
            return html;
        }

        public decimal GetTime()
        {
            Int64 retval = 0;
            DateTime st = new DateTime(1970, 1, 1);
            TimeSpan t = (DateTime.Now.ToUniversalTime() - st);
            retval = (Int64)(t.TotalMilliseconds + 0.5);
            return retval;
        }
        public byte csharp(int n,string str)
        {
           // string str = "ABCDEFG";
            byte[] by = System.Text.Encoding.Default.GetBytes(str);
            return by[n];
        }

      string base64_encode(string  str) {
	int c1, c2, c3;
	string base64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	int i = 0;
		int len = str.Length;
	string	strs = "";

	    while (i < len) {
	 	c1 = csharp(i++,str) & (byte)0xff;
		if (i == len) {
			strs += base64EncodeChars.CharAt(c1 >> 2);
            strs += base64EncodeChars.CharAt((c1 & 0x3) << 4);
			strs += "==";
			break;
		}
		c2 = csharp(i++,str) ;
		if (i == len) {
            strs += base64EncodeChars.CharAt(c1 >> 2);
            strs += base64EncodeChars.CharAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
            strs += base64EncodeChars.CharAt((c2 & 0xF) << 2);
			strs += "=";
			break;
		}
		c3 = csharp(i++,str) ;
        strs += base64EncodeChars.CharAt(c1 >> 2);
        strs += base64EncodeChars.CharAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
        strs += base64EncodeChars.CharAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6));
        strs += base64EncodeChars.CharAt(c3 & 0x3F);
	}
        return strs;
}


        /// <summary>
        /// 
        /// </summary>
        /// <param name="url"></param>
        /// <param name="method">"POST"/"GET"/"PUT "</param>
        /// <param name="postdatastr"></param>
        /// <returns></returns>
        private string HttpHelper_GetStr(string url,string headers, string method, string postdatastr)
        {
            HttpHelper http = new HttpHelper();
            HttpItem item = new HttpItem()
            {
                URL = url,
                //"http://partnertest.kujiale.com/p/openapi/login",//URL     必需项
                Method = method,//URL     可选项 默认为Get
                Timeout = 100000,//连接超时时间     可选项默认为100000
                ReadWriteTimeout = 30000,//写入Post数据超时时间     可选项默认为30000
                IsToLower = false,//得到的HTML代码是否转成小写     可选项默认转小写
                Cookie = "",//字符串Cookie     可选项
                PostEncoding = Encoding.UTF8,
                Encoding = Encoding.UTF8,//编码格式（utf-8,gb2312,gbk）  
                UserAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:18.0) Gecko/20100101 Firefox/18.0",//用户的浏览器类型，版本，操作系统     可选项有默认值
                Accept = "text/html, application/xhtml+xml, */*",//    可选项有默认值
                ContentType = "application/x-www-form-urlencoded",//返回类型    可选项有默认值
                Referer = "",//来源URL     可选项
                //Allowautoredirect = False,//是否根据３０１跳转     可选项
                //AutoRedirectCookie = False,//是否自动处理Cookie     可选项
                //CerPath = "d:\123.cer",//证书绝对路径     可选项不需要证书时可以不写这个参数
                //Connectionlimit = 1024,//最大连接数     可选项 默认为1024
                Postdata = postdatastr,
                //"appkey=hsjauejdsg&timestamp=1418635917113&appuid=1&sign=FA6A2FDAE016D16ACF6C770DE2F1E70F&appuname=测试用户&appuemail=ceshi@ceshi.com&appuphone=13233333333&appussn=&appuAddr=测试省测试市测试县测试路1号&appuavatar=http://qhyxpic.oss.kujiale.com/avatars/72.jpg", //Post数据     可选项GET时不需要写
                //ProxyIp = "192.168.1.105：2020",//代理服务器ID     可选项 不需要代理 时可以不设置这三个参数
                //ProxyPwd = "123456",//代理服务器密码     可选项
                //ProxyUserName = "administrator",//代理服务器账户名     可选项
                ResultType = ResultType.String,//返回数据类型，是Byte还是String
            };
            item.Header.Add("sc_api", headers);//设置请求头信息（Header） 
            HttpResult result = http.GetHtml(item);
            string html = result.Html;
            return html;
        }

      
    }
     public static class CharAtExtention{
         public static string CharAt(this string s,int index){
             if((index >= s.Length)||(index<0))
                 return "";
             return s.Substring(index,1);
         }
     }
}
