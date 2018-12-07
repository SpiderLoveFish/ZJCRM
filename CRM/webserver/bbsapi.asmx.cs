using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using XHD.Common;

namespace XHD.CRM.webserver
{
    /// <summary>
    /// Summary description for bbsapi
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class bbsapi : System.Web.Services.WebService
    {
        BLL.f_bbs fb = new BLL.f_bbs();
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
            DataSet ds = fb.gerPCuser(username, password );
                         if (ds.Tables[0].Rows.Count > 0)
                            {
                                if (ds.Tables[0].Rows[0]["canlogin"].ToString() == "1")
                                {
                                    if (ds.Tables[0].Rows[0]["token"].ToString() == "")
                                    {
                                        string token = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(
                                            GetTimeStamp() + ds.Tables[0].Rows[0]["uid"].ToString()
                                            , "MD5");
                                        fb.Insertuser(int.Parse(ds.Tables[0].Rows[0]["ID"].ToString()), token,url);
                                        DataSet dds = fb.geruser(token, ds.Tables[0].Rows[0]["ID"].ToString());
                                        string str = Common.DataToJson.GetJson(dds);
                                        returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":" + str + "}";

                                    }
                                    else
                                    {
                                        DataSet dds = fb.geruser(ds.Tables[0].Rows[0]["token"].ToString(), ds.Tables[0].Rows[0]["ID"].ToString());
                                        string str = Common.DataToJson.GetJson(dds);
                                        returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":" + str + "}";

                                    }
                                     string name = ds.Tables[0].Rows[0]["name"].ToString();
                                     log.Add_log(int.Parse(ds.Tables[0].Rows[0]["ID"].ToString()), name, ip, "手机端登录", "手机端登录", 0, "手机端登录", "", "");

                                }
                             else               returnstr = "{\"code\":201,\"description\":\"账号已经停用！\"}";
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
        /// 主题
        /// </summary>
        /// <param name="pagcout"></param>
        /// <param name="tab"></param>
        /// <param name="pagsize"></param>
        [WebMethod]
        public void Getf_Topic(int PageIndex, int PageSize, string strwhere)
        {
            string Total;
            DataSet ds = fb.GetDsTopic(PageIndex, PageSize, strwhere, out Total);
               
            string returnstr = "{\"code\":201,\"description\":\"没有数据！\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":{\"totalRow\":" + Total + ",\"list\":" + Common.DataToJson.GetJson(ds) + "}}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }


        [WebMethod]
        public void Getf_TopicDetail(string token,string tid)
        {
            string Total;
            DataSet ds = fb.GetDsTopicDetail(token,tid, out Total);
            string str = "";
            string returnstr = "{\"code\":201,\"description\":\"没有数据！\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds).Replace("[", "").Replace("]", "");
                DataSet dds = fb.GetDsTopicDetail_replay(token,tid);
              
                if(dds.Tables[0].Rows.Count>0)
                    str = Common.DataToJson.GetJson(dds);
                 if (str == "") str = "[]";
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":{\"collectCount\":" + Total + ",\"replies\":" + str + ",\"topic\":" + returnstr + "}}";
            }
            Context.Response.Charset = "UTF-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }
       
        /// <summary>
        /// 新建主题
        /// original_url 原创可为空
        /// </summary>
        [WebMethod]
        public void Getf_topicCreate(string token, string title, string sid, string coutent)
        {
           
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (fb.inserttopic(token, int.Parse(sid), title, coutent) > 0)
            {
                returnstr = "创建成功！";
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":\" " + returnstr + "\"}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }

        [WebMethod]
        public void Getf_topicUpdate(string token, string title, string id, string coutent)
        {

            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (fb.UpdateTopic(token, id, title, coutent) > 0)
            {
                               returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":\"修改成功！\"}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }
        // 话题置精或者取消
        [WebMethod]
        public void UpdateTopicTop(string token, string id, string status)
        {

            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (fb.UpdateTopicTop(token, id,status) > 0)
            {
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":\"修改成功！\"}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }
        // 话题置精或者取消
        [WebMethod]
        public void UpdateTopicGood(string token, string id, string status)
        {

            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (fb.UpdateTopicGood(token, id, status) > 0)
            {
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":\"修改成功！\"}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }
        // 话题删除或恢复
        [WebMethod]
        public void UpdateTopicShow_status(string token, string id, string status)
        {

            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (fb.UpdateTopicShow_status(token, id, status) > 0)
            {
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":\"修改成功！\"}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }
        // 浏览量
        [WebMethod]
        public void UpdateTopicView(string token, string id)
        {

            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (fb.UpdateTopict_view(token, id) > 0)
            {
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\":\"修改成功！\"}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }

        [WebMethod]
        public void Insertcollect(string token, string id)
        {

            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (fb.Insertcollect(token, id) > 0)
            {
                returnstr = "收藏成功！";
                returnstr = "{\"code\":200,\"description\":\"success\"}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }

        [WebMethod]
        public void Deletecollect(string token, string id)
        {

            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (fb.Deletecollect(token, id) > 0)
            {
                returnstr = "取消收藏成功！";
                returnstr = "{\"code\":200,\"description\":\"success\"}";
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write(returnstr);
            Context.Response.End();

        }


       /// <summary>
        /// 新建评论
        /// 
        /// </summary>
        [WebMethod]
        public void Getf_reply_creat(string token, string tid,string title, string content)
        {
            string strcontent = PageValidate.InputText(content, int.MaxValue);
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (fb.insertreply(token,int.Parse(tid),title,strcontent) > 0)
            {
                DataSet dds = fb.GetDsTopicDetail_replay(token, tid);

                if (dds.Tables[0].Rows.Count > 0)
                 returnstr    = Common.DataToJson.GetJson(dds);
                if (returnstr == "") returnstr = "[]";
                returnstr = "{\"code\":200,\"description\":\"success\",\"detail\": " + returnstr + "}";
            }
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
        public void Getf_section()
        {
            DataSet ds = fb.Getf_section();
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
        // 话题回复删除或恢复
        [WebMethod]
        public void Updatef_reply_delete(string token, string id, string status)
        {

            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (fb.Updatef_reply_delete(token, id, status) > 0)
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
