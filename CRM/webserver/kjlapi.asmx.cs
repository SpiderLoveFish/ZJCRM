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
    public class kjlapi : System.Web.Services.WebService
    {

        BLL.CE_Para cp = new BLL.CE_Para();
        BLL.hr_employee emp = new BLL.hr_employee();
        BLL.WebSite_User bwu = new BLL.WebSite_User();
        Model.WebSite_User mwu = new Model.WebSite_User();
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
          public void loginwebsite(string tel, string pwd)
          {

              DataSet ds = bwu.GetList(" pwd='" +MD5( pwd) + "' and userid='" + tel + "'");

              string dt = Common.DataToJson.DataToJSON(ds);

              writereturnstr("[" + dt + "]");

          }
          [WebMethod]
          public void regebsite(string id,string tel, string pwd, string nickname, string xq,string sex)
          {
              BLL.sys_info si = new BLL.sys_info();
              string host = si.GetList(" sys_key='sys_host'").Tables[0].Rows[0]["sys_value"].ToString();
           
              mwu.tel = tel;
              mwu.pwd = pwd;
              mwu.nickname = nickname;
              mwu.sex = sex;
              mwu.kjl_login = uid + "@" + host;
              mwu.userid = tel;
              mwu.village = xq;


              mwu.status = "Y";
             

             // if (!string.IsNullOrEmpty(id) && id != "null")
              if(id=="1")
              {

                 //mwu.id = int.Parse(id);
                  if (bwu.Update(mwu))
                      writereturnstr("true");
                  else writereturnstr("false");
              }
              else
              {
                  if (bwu.ExistsTel(tel))
                  {
                      writereturnstr("false:tel");
                  }
                  else
                  {
                      if (bwu.Add(mwu) > 0)
                          writereturnstr("true");
                      else writereturnstr("false");
                  }

              }
 
          }


          [WebMethod]
          public void savekjl(string uid,string fpId, string desid, string simg, string imgtype, string img, string style, string pano, string tel, string DyGraphicsName)
          {

              int Customer_id = 0;
  
              if (fpId == "null" || fpId == null) fpId = "";
              if (desid == "null" || desid == null) desid = "";
              if (style == "Edit")
              {
                  if (cp.Updatekjl_api(desid, Customer_id, fpId, DyGraphicsName, imgtype, simg, img, pano))
                      writereturnstr("true");
                  else writereturnstr("false");

              }
              else if (style == "insert")
              {
                  if (cp.Addkjl_api(desid, Customer_id, fpId, DyGraphicsName, imgtype, simg, img, pano, uid, 0, tel))
                      writereturnstr("true");
                  else writereturnstr("false");


              }
          }
         [WebMethod]
          public void GetSMS(string mobile, string YZM)
            {

                Data.sms sms = new Data.sms();
                string mes = "您好，心成装饰给您发的验证码为" + YZM + "，请勿向任何单位或个人泄露。【心成装饰】";
                string a = sms.SendSMS(false, "", mes, mobile);
                //"{\"?xml\":{\"@version\":\"1.0\",\"@encoding\":\"utf-8\"},\"returnsms\":{\"returnstatus\":\"Success\",\"message\":\"ok\",\"remainpoint\":\"10196\",\"taskID\":\"302471\",\"successCounts\":\"1\"}}"; //
              
                writereturnstr(a);
            }

         [WebMethod]
         public void Getkjl_api(string mobile,int pageindex,int pagesize,string strwhere)
         {
             string Total;
            int PageIndex = int.Parse(pageindex == null ? "1" : pageindex.ToString());
            int PageSize = int.Parse(pagesize == null ? "10" : pagesize.ToString());
            string   serchtxt  = " remarks = '" + mobile + "'";
            if (strwhere != "")
                serchtxt += "  and DyGraphicsName like'%"+strwhere+"%'";
            string sorttext = "   DoTime desc";
            DataSet ds = cp.GetListkjl_api(PageSize, PageIndex, serchtxt, sorttext, out Total);

             string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
             writereturnstr(dt);
         }

             private static string MD5(string input)
             {

                 string b = FormsAuthentication.HashPasswordForStoringInConfigFile(input, "MD5");

                 return b;
             }
             [WebMethod]
             public void Getsyskjl(string id,string kjluid)
             {
                 string struid = uid;
                 if (!string.IsNullOrEmpty(id) && id != "null")
                 {
                     struid = kjluid;
                 }
                 string[] arr = new string[10];
                 BLL.CE_Para cp = new BLL.CE_Para();
                 BLL.sys_info si = new BLL.sys_info();
                 string host = si.GetList(" sys_key='sys_host'").Tables[0].Rows[0]["sys_value"].ToString();
                 DataSet ds = cp.GetSingleSignOnList("  a.id=" + id + " and B.uid='" + struid + "'", host);
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
                 string dt = Common.DataToJson.DataToJSON(ds);
                 writereturnstr(dt);
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
