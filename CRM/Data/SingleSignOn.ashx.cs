using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using System.Web.Security;
using System.IO;
using System.Net;
using System.Net.Cache;
using System.Security.Cryptography;
using XHD.Common;

namespace XHD.CRM.Data
{
    /// <summary>
    /// sys_app 的摘要说明
    /// </summary>
    /// 
    
    public class SingleSignOn : IHttpHandler
    {
         
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();

            if (request["Action"] == "GetMD5")
            {

                    string[] arr = para("1");
                    string appKey =arr[(int)paraenum.appKey];
                    string appSecret =arr[(int)paraenum.appSecret];
                    string userId = arr[(int)paraenum.userId];
                    if (appKey==null) context.Response.Write("请先配置参数！");
                     else
                        {      
                        object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                        string timestamp = currenttimemillis.ToString(); ;//2分钟
                        // 签名加密
                        string aa = "sdfaadsasdasd";
                        string md5aa = MD5(aa).ToLower();
                        string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                        IDictionary<string, string> postdata = new Dictionary<string, string>();
                        postdata.Add("appkey", appKey);
                        postdata.Add("timestamp", timestamp);
                        postdata.Add("appuid", userId);
                        postdata.Add("sign", sign);
                        postdata.Add("appuname", arr[(int)paraenum.userName]);
                        postdata.Add("appuemail", arr[(int)paraenum.email]);
                        postdata.Add("appuphone", arr[(int)paraenum.phone]);
                        postdata.Add("appussn", arr[(int)paraenum.ssn]);
                        postdata.Add("appuaddr", arr[(int)paraenum.address]);
                        postdata.Add("appuavatar", arr[(int)paraenum.avatar]);

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
                        string api = arr[(int)paraenum.api];
                        //// 构造HTTP请求
                        string test = "http://wwww.baidu.com";

                        string result = "";
                        //  CookieCollection ck=new CookieCollection();
                        //result = 
                        //    Comm.HttpHelper.CreatePostHttpResponse(test, postdata, 100000, "",ck);

                        // result = PostWebRequest(api, postdata);
                        // result = HttpPost(api, buffer.ToString());
                        result = HttpHelper_GetStr(api,"POST", buffer.ToString());
                        context.Response.Write(result);
                    }
              
            }

            if (request["Action"] == "Design3D")
            {
                
                    string[] arr = para("1");
                    string appKey =arr[(int)paraenum.appKey];
                    string appSecret =arr[(int)paraenum.appSecret];
                    string userId = arr[(int)paraenum.userId];
                    if (appKey == null) context.Response.Write("请先配置参数！");
                    else
                    {
                        string appuid = "3FO4KEAG7F9L";
                        object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                        string timestamp = currenttimemillis.ToString(); ;//2分钟
                        // 签名加密
                        string aa = "sdfaadsasdasd";
                        string md5aa = MD5(aa).ToLower();
                        string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                        IDictionary<string, string> postdata = new Dictionary<string, string>();
                        postdata.Add("appkey", appKey);
                        postdata.Add("timestamp", timestamp);
                        postdata.Add("sign", sign);
                        postdata.Add("planid", arr[(int)paraenum.userName]);
                        postdata.Add("appuid", appuid);
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

                        string api = arr[(int)paraenum.api];
                        string result = "";
                        result = HttpHelper_GetStr(api, "GET", buffer.ToString());
                        context.Response.Write(result);
                    }
               
            }


        }

         private static string MD5(string input) {

           string b  =FormsAuthentication.HashPasswordForStoringInConfigFile(input, "MD5");
          
         return b;
     }

         private string[] para(string id)
         {
             string[] arr= new string[10];
             BLL.CE_Para cp = new BLL.CE_Para();
             DataSet ds = cp.GetSingleSignOnList("  id=" + id + "");
             if (ds.Tables[0].Rows.Count > 0)
             {
                 // 分配给每个商家的唯一的appkey和appsecret
                 foreach (DataRow dr in ds.Tables[0].Rows)
                 {
                    
                     arr[0] = dr["appKey"].ToString();
                     arr[1] = dr["appSecret"].ToString();
                     // 设定API文档中提到的参数
                     arr[2] = dr["appuid"].ToString();
                     arr[3] = dr["appuname"].ToString();
                     arr[4] = dr["appuemail"].ToString();
                     arr[5] = dr["appuphone"].ToString();
                     arr[6] = dr["appussn"].ToString();
                     arr[7] = dr["appuAddr"].ToString();
                     arr[8] = dr["appuavatar"].ToString();
                     arr[9] = dr["api"].ToString();
                 }
                 
                   // DataRow[] rows = ds.Tables[0].Select("1=1");
                      //arr = rows.Select(x => x[0].ToString()).ToArray();
             }

             return arr;
         }

         protected enum paraenum
         {
                appKey ,
                appSecret,
                userId  ,
                userName ,
                email , 
                phone ,
                ssn,
                address,
                avatar,
                api
         }
         private string HttpPost(string Url, string postDataStr)
         {
             string str = string.Empty;
             try
             {
                 HttpWebRequest request = (HttpWebRequest)WebRequest.Create(Url);
                 request.Method = "POST";
                 request.ContentType = "application/x-www-form-urlencoded";
                // request.ContentType = "application/json";
                // request.ContentLength = Encoding.UTF8.GetByteCount(postDataStr);
                 //request.CookieContainer = cookie;
                 Stream myRequestStream = request.GetRequestStream();
                 StreamWriter myStreamWriter = new StreamWriter(myRequestStream, Encoding.GetEncoding("utf-8"));
                 myStreamWriter.Write(postDataStr);
                 myStreamWriter.Close();
                  
                 
                 HttpWebResponse response = (HttpWebResponse)request.GetResponse();

                 // response.Cookies = cookie.GetCookies(response.ResponseUri);
                 Stream myResponseStream = response.GetResponseStream();
                 StreamReader myStreamReader = new StreamReader(myResponseStream, Encoding.GetEncoding("utf-8"));
                 str = myStreamReader.ReadToEnd();
                 myStreamReader.Close();
                 myResponseStream.Close();
                 response.Close();
                 request.Abort();
                 request = null;
             }
             catch (Exception ex)
             {
                 str = ex.Message;
             }
             return str;
         }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="url"></param>
         /// <param name="method">"POST"/"GET"/"PUT "</param>
        /// <param name="postdatastr"></param>
        /// <returns></returns>
         private string HttpHelper_GetStr(string url,string method, string postdatastr)
         {
             HttpHelper http = new HttpHelper();
             HttpItem item = new HttpItem()
             {
                  URL =url,
                  //"http://partnertest.kujiale.com/p/openapi/login",//URL     必需项
                 Method = method,//URL     可选项 默认为Get
                 Timeout = 100000,//连接超时时间     可选项默认为100000
                 ReadWriteTimeout = 30000,//写入Post数据超时时间     可选项默认为30000
                 IsToLower = false,//得到的HTML代码是否转成小写     可选项默认转小写
                 Cookie = "",//字符串Cookie     可选项
                 UserAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:18.0) Gecko/20100101 Firefox/18.0",//用户的浏览器类型，版本，操作系统     可选项有默认值
                 Accept = "text/html, application/xhtml+xml, */*",//    可选项有默认值
                  ContentType = "application/x-www-form-urlencoded",//返回类型    可选项有默认值
                 Referer = "",//来源URL     可选项
                 //Allowautoredirect = False,//是否根据３０１跳转     可选项
                 //AutoRedirectCookie = False,//是否自动处理Cookie     可选项
                 //CerPath = "d:\123.cer",//证书绝对路径     可选项不需要证书时可以不写这个参数
                 //Connectionlimit = 1024,//最大连接数     可选项 默认为1024
                 Postdata =postdatastr,
             //"appkey=hsjauejdsg&timestamp=1418635917113&appuid=1&sign=FA6A2FDAE016D16ACF6C770DE2F1E70F&appuname=测试用户&appuemail=ceshi@ceshi.com&appuphone=13233333333&appussn=&appuAddr=测试省测试市测试县测试路1号&appuavatar=http://qhyxpic.oss.kujiale.com/avatars/72.jpg", //Post数据     可选项GET时不需要写
                 //ProxyIp = "192.168.1.105：2020",//代理服务器ID     可选项 不需要代理 时可以不设置这三个参数
                 //ProxyPwd = "123456",//代理服务器密码     可选项
                 //ProxyUserName = "administrator",//代理服务器账户名     可选项
                 ResultType = ResultType.String,//返回数据类型，是Byte还是String
             };
             HttpResult result = http.GetHtml(item);
             string html = result.Html;
             return html;
         }

      

      
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}