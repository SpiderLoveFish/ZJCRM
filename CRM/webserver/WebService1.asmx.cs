using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using XHD.Common;
using XHD.DBUtility;
using System.Data;
 

namespace XHD.CRM.webserver
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {
        BLL.hr_employee emp = new BLL.hr_employee();
        BLL.f_bbs fb = new BLL.f_bbs();
        BLL.webservers1 ws = new BLL.webservers1();
        XHD.CRM.Data.C_Sys_log log = new XHD.CRM.Data.C_Sys_log();
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <param name="ip"></param>
        [WebMethod]
        public void GetLogin(string username, string password, string ip,string url)
        {
            password = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(password, "MD5");
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            DataSet ds = fb.gerPCuser(username, password);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["canlogin"].ToString() == "1")
                {
                    if (ds.Tables[0].Rows[0]["token"].ToString() == "")
                    {
                        string token = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(
                            GetTimeStamp() + ds.Tables[0].Rows[0]["uid"].ToString()
                            , "MD5");
                        fb.Insertuser(int.Parse(ds.Tables[0].Rows[0]["ID"].ToString()), token, url);
                        DataSet dds = fb.getuserdetail(token, ds.Tables[0].Rows[0]["ID"].ToString());
                        string str = Common.DataToJson.GetJson(dds);
                        returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":" + str + "}";

                    }
                    else
                    {
                        DataSet dds = fb.getuserdetail(ds.Tables[0].Rows[0]["token"].ToString(), ds.Tables[0].Rows[0]["ID"].ToString());
                        string str = Common.DataToJson.GetJson(dds);
                        returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":" + str + "}";

                    }
                    string name = ds.Tables[0].Rows[0]["name"].ToString();
                    log.Add_log(int.Parse(ds.Tables[0].Rows[0]["ID"].ToString()), name, ip, "手机端登录", "手机端登录", 0, "手机端登录", "", "");

                }
                else returnstr = "{\"code\":201,\"description\":\"账号已经停用！\"}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);

            Context.Response.End();
        }
        /// <summary>  
        /// 获取时间戳  
        /// </summary>  
        /// <returns></returns>  
        public static string GetTimeStamp()
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
            return Convert.ToInt64(ts.TotalSeconds).ToString();
        }


        /// <summary>
        /// 打卡
        /// original_url 原创可为空
        /// </summary>
        [WebMethod]
        public void InsertHR_SignIn(string id, string lc, string mapp)
        {

            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ws.HR_SignIn(int.Parse(id), lc, mapp) > 0)
            {
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":\" 打卡成功！\"}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }
        //打卡记录
        [WebMethod]
        public void GetHR_SignList(string id, string topindex)
        {
            DataSet ds = ws.Get_SignInlist(id, int.Parse(topindex));
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":" + Common.DataToJson.GetJson(ds) + "}";
            }
            else returnstr = "{\"code\":201,\"description\":\"success\",\"detail\":\"没有打卡数据\"}";
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }

        [WebMethod]
        public void GetCustomer_where(string where)
        {
            BLL.CRM_Customer cus = new BLL.CRM_Customer();
            DataSet ds = cus.GetList("id=" + where);
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":" + Common.DataToJson.GetJson(ds) + "}";
            }
            else returnstr = "{\"code\":201,\"description\":\"success\",\"detail\":\"没有数据\"}";
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();
        }

        [WebMethod]
        public void InsertCRM_Follow(string cid, string follow, string type, string id)
        {

            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ws.HR_follow(cid, follow, type, id) > 0)
            {
                DataSet dds = ws.GetFollow(cid);

                if (dds.Tables[0].Rows.Count > 0)
                    returnstr = Common.DataToJson.GetJson(dds);
                if (returnstr == "") returnstr = "[]";
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\": " + returnstr + "}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();


        }

        [WebMethod]
        public void Getf_CustomerFollow(string cid)
        {
            string Total="0";
            DataSet ds = ws.GetCRM_Customer(cid);
            string str = "";
            
            string returnstr = "{\"code\":201,\"description\":\"没有数据！\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds).Replace("[", "").Replace("]", "");
                DataSet dds = ws.GetFollow(cid);

                if (dds.Tables[0].Rows.Count > 0)
                    str = Common.DataToJson.GetJson(dds);
                Total = dds.Tables[0].Rows.Count.ToString();
                if (str == "") str = "[]";
              returnstr=  "{\"code\":200,\"description\":\"success\",\"detail\":{\"FollowCount\":" + Total + ",\"follow\":" + str + ",\"customer\":" + returnstr + "}}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }


        [WebMethod]
        public void GetCustomer_page(int pageIndex, int pageSize, string where)
        {
            BLL.CRM_Customer cus = new BLL.CRM_Customer();
            DataSet ds = cus.GetPageList(pageIndex, pageSize, where);
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":{\"totalrow\":" + ds.Tables[0].Rows.Count.ToString()+",\"list\":" + Common.DataToJson.GetJson(ds) + "}}";
            }
            else returnstr = "{\"code\":201,\"description\":\"success\",\"detail\":\"没有数据\"}";
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();
        }
                /// <summary>
        /// 人员信息
        /// 
        /// </summary>
        [WebMethod]
        public void Get_FllowType()
        {
            BLL.Param_SysParam ps = new BLL.Param_SysParam();
            DataSet ds = ps.GetList(" parentid=4");
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":" + returnstr + "}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }
        [WebMethod]
        public void Get_FllowDetail(string cid)
        {
            BLL.CRM_Customer cc = new BLL.CRM_Customer();
            string Total;
            DataSet ds = cc.GetList(" id="+cid);
            string str = "";
            string returnstr = "{\"code\":201,\"description\":\"没有数据！\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds).Replace("[", "").Replace("]", "");
                DataSet dds = ws.GetFollow(cid);
                string total = "0";
                if (dds.Tables[0].Rows.Count > 0)
                {
                    str = Common.DataToJson.GetJson(dds);
                    total = dds.Tables[0].Rows.Count.ToString();
                }
                if (str == "") str = "[]";
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":{\"collectCount\":" + total + ",\"replies\":" + str + ",\"topic\":" + returnstr + "}}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }

        [WebMethod]
        public void DeleteFollow(string id)
        {

            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ws.DeleteFollow(id) > 0)
            {
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":\"删除成功！\"}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();


        }

       
    }
}
