﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using XHD.Common;
using System.Web.Security;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using Newtonsoft.Json;

namespace XHD.CRM.webserver
{
    public class app_kjl_api
    {

        public string GetKJL_QJT(string tel)
        {
            BLL.CE_Para cp = new BLL.CE_Para();
            DataSet dskey = cp.GetAPI_KEY("  AppStyle='qjxj' ");
            var result = "";
            if (dskey.Tables[0].Rows.Count > 0)
            {
                string apiurl = dskey.Tables[0].Rows[0]["AppUrl"].ToString();
                string apikey = dskey.Tables[0].Rows[0]["AppKey"].ToString();
                IDictionary<string, string> postdata = new Dictionary<string, string>();

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
                string keytel = tel;
                //+"/key/"+keytel
                  result = HttpHelper_GetStr(apiurl + apikey + "/key/" + keytel, "GET", buffer.ToString());
              Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(result);
              try
              {
                  if (jo["status"].ToString() == "error") result = "";
                  else result = jo["data"]["pano"].ToString();
              }
              catch {
                  result = jo["data"]["pano"].ToString();
                  if (jo["data"]["pano"].ToString() == "" || jo["data"]["pano"].ToString() == "null")
                      result = "";
              }
                //{"status":"error","msg":null}

            }
            return result;
        }

        public string Get3D_XGT_LIST(string desid,string uid)
        {
            string[] arr = para("27", uid);
            string appKey = arr[(int)paraenum.appKey];
            string appSecret = arr[(int)paraenum.appSecret];
            string userId = arr[(int)paraenum.userId];
            if (appKey == null) return "";
            else
            {
                string designId = desid;
                object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                string timestamp = currenttimemillis.ToString(); //2分钟
                // 签名加密
                string aa = "sdfaadsasdasd";
                string md5aa = MD5(aa).ToLower();
                string sign = MD5(appSecret + appKey + timestamp).ToLower();
                string api = arr[(int)paraenum.api];
                StringBuilder apiBuilder = new StringBuilder();
                apiBuilder.Append(api)
                     .Append("/" + designId)
                    .Append("/renderpics")//?starttime=
                    // .Append((int.Parse(timestamp) - (300 * 24 * 3600 * 1000)).ToString())
                .Append("?appkey=").Append(appKey)
                .Append("&timestamp=").Append(timestamp)
                .Append("&sign=").Append(sign);



                string result = "";
                result = HttpGet(apiBuilder.ToString());
                return result;
            }
        }

        public string Get3D_XGT_All(string picids, string uid)
        { 
        
          string[] arr = para("10", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) return "";
                else
                {
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); ;//2分钟
                    // 签名加密
                    
                    //string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    IDictionary<string, string> postdata = new Dictionary<string, string>();
                    postdata.Add("appkey", appKey);
                    postdata.Add("timestamp", timestamp);
                    postdata.Add("picids", picids);
                    postdata.Add("override","false"); 

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
      
                    result = HttpHelper_GetStr(api, "POST", buffer.ToString());
                      return result;
                }
                  
        }

        private static string MD5(string input)
        {

            string b = FormsAuthentication.HashPasswordForStoringInConfigFile(input, "MD5");

            return b;
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


    }
}