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
    public class kjlapi : System.Web.Services.WebService
    {

        BLL.CE_Para cp = new BLL.CE_Para();
        BLL.hr_employee emp = new BLL.hr_employee();
       // int emp_id = int.Parse(CoockiesID);
        //DataSet dsemp = emp.GetList("id=" + emp_id);
       // string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
        string uid = "admin";
           //dsemp.Tables[0].Rows[0]["uid"].ToString();


        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

          [WebMethod]
          public void GetMD5(string dest, string planid, string designid)
                 {

                 string[] arr = para("1", uid);
                    string appKey =arr[(int)paraenum.appKey];
                    string appSecret =arr[(int)paraenum.appSecret];
                    string userId = arr[(int)paraenum.userId];
                    string result = "";
                    if (appKey == null)
                    {
                        result= "请先配置参数！" ;
                    }
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
                        postdata.Add("apputype", "0");
                        postdata.Add("dest", dest);
                        postdata.Add("designid", designid);
                        postdata.Add("planid", planid);
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

                    
                        result = HttpHelper_GetStr(api, "POST", buffer.ToString());
                       writereturnstr( result );
                    }
              
            }


        
            //搜索户型图接口
          [WebMethod]
             public void gethxtapi(string query, string start, string cityId)
            {

                string[] arr = para("17", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                   int num = 8;
                   string result = "";
                   if (appKey == null)
                    {
                        result= "请先配置参数！" ;
                    }
                else
                {

                    // Common.PageValidate.InputText(request["designId"], 50)

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign)
                    .Append("&q=").Append(query)
                    .Append("&start=").Append(start)
                    .Append("&num=").Append(num)
                    .Append("&cityid=").Append(cityId);
                   
                    result = HttpGet(apiBuilder.ToString());
                    writereturnstr( result);
                }

            }
            //获取酷家乐城市列表
          [WebMethod]
           public void  getcitylist()
            {

                string[] arr = para("16", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                string result = "";
                if (appKey == null)
                    {
                       result= "请先配置参数！" ;
                    }
                else
                {

                     // Common.PageValidate.InputText(request["designId"], 50)

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign) ;
                
                    result = HttpGet(apiBuilder.ToString());
                  
                }
             writereturnstr(result);

            }

            //获取指定户型图的副本
          [WebMethod]
           public void getuserhxdatafb(string planid)
            {

                string[] arr = para("14", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                string result = "";
                if (appKey == null)
                    {
                        result= "请先配置参数！" ;
                    }
                else
                {
 
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                       .Append("/" + planid)
                         .Append("/copy")
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign)
                     .Append("&appuid=").Append(userId);
                  
                    result = HttpGet(apiBuilder.ToString());
                    writereturnstr( result);
                }

            }

            //获取用户下的户型图数据
          [WebMethod]
            public void  getuserhxdata(string planid,int num)
            {

                string[] arr = para("13", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                long start = 0;
                string result = "";
              if (appKey == null)
                    {
                        result= "请先配置参数！" ;
                    }
                else
                {

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                          .Append("?start=").Append(start)
                         .Append("&num=").Append(num)
                    .Append("&appkey=").Append(appKey)
                      .Append("&appuid=").Append(userId)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
       
                    result = HttpGet(apiBuilder.ToString());
                    writereturnstr(  result );
                }

            }
          //获取指定户型的基本数据
          [WebMethod]
            public void getthebasicdata(string planid)
            {

                string[] arr = para("11", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                string result = "";
                if (appKey == null)
                {
                    result= "请先配置参数！";
                }
                else
                {

                     object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("/" + planid)
                     .Append("/info")
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
                 
                    result = HttpGet(apiBuilder.ToString());
                   writereturnstr( "["+result+"]" );
                }

            }

          //更新3D渲染方案的名字put
          [WebMethod]
            public void update3dname(string newName, string designId)
            {

                string[] arr = para("9", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                string result = "";
                if (appKey == null)
                {
                    result= "请先配置参数！";
                }
                else
                {
                
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("/" + designId)
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign)
                    .Append("&name=").Append(newName); ;
                        result = HttpHelper_GetStr(apiBuilder.ToString(),"PUT",""); 
                   writereturnstr( result) ;
                }

            }
          //更新户型图名字put
          [WebMethod]
            public void updatehxtname(string newName, string planid)
            {

                string[] arr = para("15", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                string result = "";
                if (appKey == null)
                {
                    result= "请先配置参数！";
                }
                else
                {
                
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("/" + planid)
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign)
                    .Append("&name=").Append(newName); ;
                     //result = HttpPut(apiBuilder.ToString());
                    result = HttpHelper_GetStr(apiBuilder.ToString(),"PUT","");
                    if(result=="success")
                    cp.Updatekjl_api_name(planid,newName);
                    writereturnstr( result) ;
                }

            }

           //获取指定用户的3D方案列表
          [WebMethod]
           public void  get3dfalist(long start ,int num)
            {

                string[] arr = para("6", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                string result = "";
                if (appKey == null)
                {
                    result= "请先配置参数！";
                }
                else
                {
                     // Common.PageValidate.InputText(request["designId"], 50)
                  //  long start = 0; int num = 2;
                    
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    // 签名加密
                    string aa = "sdfaadsasdasd";
                    string appUid = "1";
                    string md5aa = MD5(aa).ToLower();
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("?start=").Append(start)
                    .Append("&num=").Append(num)
                    .Append("&appkey=").Append(appKey)
                    .Append("&appuid=").Append(appUid)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
                     
                    result = HttpGet(apiBuilder.ToString());
                   writereturnstr(  result) ;
                }

            }
          //获取指定方案的户型图
          [WebMethod]
           public void Gethxt(string designId)
            {

                string[] arr = para("3", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                string result = "";
                if (appKey == null)
                {
                    result= "请先配置参数！";
                }
                else
                {
                     object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    // 签名加密
                    string aa = "sdfaadsasdasd";
                    string md5aa = MD5(aa).ToLower();
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                         .Append("/"+designId)
                        .Append("/planpic")//?starttime=
                        // .Append((int.Parse(timestamp) - (300 * 24 * 3600 * 1000)).ToString())
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
                    
                    result = HttpGet(apiBuilder.ToString());
                     writereturnstr( result) ;
                }

            }
         
          //获取指定方案的渲染图列表
          [WebMethod]
           public void Getlist(string designId)
            {

                string[] arr = para("27", uid);
                    string appKey =arr[(int)paraenum.appKey];
                    string appSecret =arr[(int)paraenum.appSecret];
                    string userId = arr[(int)paraenum.userId];
                    string result = "";
                    if (appKey == null)
                    {
                        result= "请先配置参数！";
                    }
                    else
                    {
                         object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                        string timestamp = currenttimemillis.ToString(); //2分钟
                        // 签名加密
                        string aa = "sdfaadsasdasd";
                        string md5aa = MD5(aa).ToLower();
                        string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                        string api = arr[(int)paraenum.api];
                        StringBuilder apiBuilder = new StringBuilder();
                        apiBuilder.Append(api)
                             .Append("/"+designId)
                            .Append("/renderpics")//?starttime=
                           // .Append((int.Parse(timestamp) - (300 * 24 * 3600 * 1000)).ToString())
                        .Append("?appkey=").Append(appKey)
                        .Append("&timestamp=").Append(timestamp)
                        .Append("&sign=").Append(sign);
                     
                        result = HttpGet(apiBuilder.ToString());
                        writereturnstr( result) ;
                    }
               
            }


             private static string MD5(string input)
             {

                 string b = FormsAuthentication.HashPasswordForStoringInConfigFile(input, "MD5");

                 return b;
             }


             private string[] para(string id, string uid)
             {

                 string[] arr = new string[10];
                 BLL.CE_Para cp = new BLL.CE_Para();
                 BLL.sys_info si = new BLL.sys_info();
                 string host = si.GetList(" sys_key='sys_host'").Tables[0].Rows[0]["sys_value"].ToString();
                 DataSet ds = cp.GetSingleSignOnList("  a.id=" + id + " and B.uid='" + uid + "'", host);
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
            appKey,
            appSecret,
            userId,
            userName,
            email,
            phone,
            ssn,
            address,
            avatar,
            api
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



        /// <summary>
        /// 
        /// </summary>
        /// <param name="url"></param>
        /// <param name="method">"POST"/"GET"/"PUT "</param>
        /// <param name="postdatastr"></param>
        /// <returns></returns>
        private string HttpHelper_GetStr(string url, string method, string postdatastr)
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
            HttpResult result = http.GetHtml(item);
            string html = result.Html;
            return html;
        }

      
    }
}
