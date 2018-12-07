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
using System.Xml;
using Newtonsoft.Json;
using XHD.DBUtility;
using XHD.CRM.Data;
using System.Text;
using Newtonsoft.Json.Linq;

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
        WX wx = new WX();
      
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public string Getaccess_token()
        {
            string url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?";
            string ret = "";string retrunstr = "";
            string sql = "SELECT * FROM wx_config  WHERE ID=6 ";
            DataSet ds = DBUtility.DbHelperSQL.Query(sql);
            if (ds.Tables[0].Rows.Count > 0)
            {
                url += "corpid=" + ds.Tables[0].Rows[0]["corpid"].ToString() + "&corpsecret=" + ds.Tables[0].Rows[0]["Secret"].ToString() + "";

                ret = HttpHelper_GetStr(url, "", "GET", "");
                Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(ret); //result为上面的Json数据  
                                                                                                                    // var jobj = JSON.parse(ret);

                retrunstr = jo["access_token"].ToString();
                if (jo["errcode"].ToString() == "0" && jo["errmsg"].ToString() == "ok")
                {
                    string sqls = "SELECT * FROM wx_config  WHERE ID=6 and DATEDIFF(SECOND,DoTime,GETDATE())>=expires_in";

                    DataSet dss = DbHelperSQL.Query(sqls);
                    if (dss.Tables[0].Rows.Count > 0)
                    {
                        string sqlexec = "   update wx_config set token = '" + jo["access_token"].ToString() + "', dotime = GETDATE(),expires_in=" + jo["expires_in"].ToString() + " where id = 6 ";
                        DBUtility.DbHelperSQL.ExecuteSql(sqlexec);

                        retrunstr = dss.Tables[0].Rows[0]["Token"].ToString();
                    }
                }
            }
            return retrunstr;  
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
        public string GetAprList(string next_spnum)
        {
            IDictionary<string, string> postdata = new Dictionary<string, string>();
            postdata.Add("loginname", "spider");
            postdata.Add("pwd", "spider");
            string result = "";
            string token = wx.Getaccess_token("3");//审批
            

                string data = wx.PostProval(token, DateTime.Now.AddYears(-1), DateTime.Now, next_spnum);
                Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(data); //result为上面的Json数据  
                                                                                                                     //   JArray ja = (JArray)jo["checkindata"];
                                                                                                                     // var sb = new System.Text.StringBuilder();
            if (jo["errmsg"].Value<string>() == "ok")
            {
                result = jo["data"].ToString();
                wx.InsertWX_Proval(data);
            }
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

        [WebMethod]
        public string gettest()
        {
            string test = "";
               WX wx = new WX();
            string token = wx.Getaccess_token("1");
            //wx.GetAgens(token);
            //wx.GetDepartments(token,"");
            //wx.GetUsers(token,"1");
            //wx.GetUsers(token,);
            DataTable lsdt = wx.GetWXUserList("");
            if (lsdt == null) { }
            else
            {
                string userlist = "";
                foreach (DataRow dr in lsdt.Rows)
                {
                    userlist += "\"" + dr["userid"].ToString() + "\",";
                }
                userlist = userlist.Substring(0, userlist.Length - 1);

                string bt = "2017-08-01";

                 test= wx.PostCheckIn(token, DateTime.Parse(bt), DateTime.Parse(bt).AddMonths(1), userlist);
            }
            // test = wx.PostProval(token, DateTime.Parse("2017-7-23"), DateTime.Parse("2017-8-23"), "");
            // test = wx.PostMessage(token, "textcard", "");
            // string sql = "  SELECT TOP 10   REPLACE(REPLACE(mediaids, '[', ''), ']', '')AS media,*FROM dbo.WX_CheckIn WHERE LEN(mediaids) > 10";
            //DataTable lsdt = DbHelperSQL.Query(sql).Tables[0];
            //foreach (DataRow dr in lsdt.Rows)
            //{
            //    //string a = "WWCISP_KxkUx5iCNgv3lOgos7OoOEmhbKxpCH3piIMovv2hdiHXyCXUdqn4cgEnn7BNrO7NUTnr7NHepH0j-ytOHh2ryA";
            //    string[] str = dr["media"].ToString().Trim().Split('\"');
            //    for(int i=0;i<str.Length;i++)
            //    {
            //        if(str[i].Length>2)
            //        test = test+","+ wx.DownLoadFiles(token,str[i] );
            //    }

            //}
            return test;
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
                ContentType = "application/json",
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

      [WebMethod]
      public string test()
      {
          IDictionary<string, string> postdata = new Dictionary<string, string>();
          
          string DATA="3428C400BFB18BF4D904DB7CED8F89D4486C7412D86FC9F45BF5182228EAF6CA989B6A74F7F6BAAFF94315837E607BD70854477A653A7D3995DC7DC94B39BC24558A142190529C471D62D30348329B56F74E18CF84607BABA4981D0C692376CE44346516A79FC5FFD0A3EEFCDD291D5F47F41EA42BF7FE3F56F9C116C9E5E8A2184093CCEF6E4EA152803210C47A749AA833E8BE4587D387CE42BD6016BFF56565DBE4F4585B06219A0EEF73420E1D1492D8F586C850179A6338C26E530B42CA39FEA0C0FBF0E48F28D0624ABA66E2255E300B161144D0EC63164517479995C9F5980B3BAB83A8CF0D40B8F417123F4E421F59ED7A33CDC069D4388B6607FDE1EA3D4AF8E3EC7697A2A197EA0D48D04CA222C089B5B1D3DBD6AA213674BDE80D976DE1925CB4E88459A9046243DD317A1D1FCFD512CB15BE5F72F98103625C84C4724CCB4F567B2B602B8143B3133EA4D95580740CF79F885CF0AA9378A0E855AF6E2806F42D19D7530E733DBD28F97BA6A92AA94AC33A9210D81FED58D2A9A70772C7E685CFE30549668C0A785A7EA0D385595C6DF8B66070B22A8F0BD2BE5856F98572D05FE3FE47737AB07724EA797492D22E1C39BE3307B3B6067FC3477386B8A9772C3D2C7B441B1AA73A47C54DA6192A4140C546F1200B68F0F67D4CEC5CE444AB22B4DAFCD01A3BE30F39BBF5B0D97D97C64FFD8A351872F27F91E41706EC1838E7E48B26E93E69535730581B6FCFA3EF68273CC77D2E35A7ED40B910BF989B245E418578315A6DA5C21C3EDA1D71AA8B044D349046FA7B0C239DB871F87AD5F97AE0EB58AD59AF0B028A9B69367584B66FD11E9131985747";
          postdata.Add("DATA", DATA);
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

       
         string result = HttpHelper_GetStr("http://baidumc112.duapp.com/sql.php", null, "POST", buffer.ToString());
          return result;
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
                ContentType = "application/json",//返回类型    可选项有默认值
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
