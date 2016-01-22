using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;

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
       
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        /// <summary>
        /// 模块
        /// </summary>
        [WebMethod]
        public void Getf_section()
        {
            DataSet ds = fb.Getf_section();
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write("{\"code\":200,\"description\":\"success\",\"detail\":" + returnstr + "}");
            Context.Response.End(); 
            
        }
        /// <summary>
        /// 主题
        /// </summary>
        /// <param name="pagcout"></param>
        /// <param name="tab"></param>
        /// <param name="pagsize"></param>
        [WebMethod]
        public void Getf_index(int pagcout,string tab,int pagsize)
        {
            DataSet ds = fb.Getf_section();
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write("{\"code\":200,\"description\":\"success\",\"detail\":" + returnstr + "}");
            Context.Response.End();

        }
        /// <summary>
        /// 主题详情
        /// </summary>
        [WebMethod]
        public void Getf_topic()
        {
            DataSet ds = fb.Getf_section();
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write("{\"code\":200,\"description\":\"success\",\"detail\":" + returnstr + "}");
            Context.Response.End();

        }
        /// <summary>
        /// 新建主题
        /// original_url 原创可为空
        /// </summary>
        [WebMethod]
        public void Getf_topicCreate(string token, string title, string sid, string coutent, string original_url)
        {
            DataSet ds = fb.Getf_section();
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write("{\"code\":200,\"description\":\"success\",\"detail\":" + returnstr + "}");
            Context.Response.End();

        }

        /// <summary>
        /// 收藏
        /// original_url 收藏主题
        /// </summary>
        [WebMethod]
        public void Getf_collect(string token, string tid)
        {
            DataSet ds = fb.Getf_section();
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write("{\"code\":200,\"description\":\"success\",\"detail\":" + returnstr + "}");
            Context.Response.End();

        }
        /// <summary>
        /// 取消收藏
        /// 
        /// </summary>
        [WebMethod]
        public void Getf_collect_delete(string token, string tid)
        {
            DataSet ds = fb.Getf_section();
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write("{\"code\":200,\"description\":\"success\",\"detail\":null}");
            Context.Response.End();

        }
        /// <summary>
        /// 新建评论
        /// 
        /// </summary>
        [WebMethod]
        public void Getf_reply_creat(string token, string tid, string content)
        {
            DataSet ds = fb.Getf_section();
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write("{\"code\":200,\"description\":\"success\",\"detail\":" + returnstr + "}");
            Context.Response.End();

        }

        /// <summary>
        /// 人员信息
        /// 
        /// </summary>
        [WebMethod]
        public void Getf_user(string token)
        {
            DataSet ds = fb.Getf_section();
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write("{\"code\":200,\"description\":\"success\",\"detail\":" + returnstr + "}");
            Context.Response.End();

        }


        /// <summary>
        /// 未读消息
        ///   {
        //    "code": "200",
        //    "description": "success",
        //    "detail": 3
        //}
        /// </summary>
        [WebMethod]
        public void Getf_notf_countnotread(string token)
        {
            DataSet ds = fb.Getf_section();
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write("{\"code\":200,\"description\":\"success\",\"detail\":" + returnstr + "}");
            Context.Response.End();

        }

        [WebMethod]
        public void Getf_notification(string token)
        {
            DataSet ds = fb.Getf_section();
            string returnstr = "{\"code\":0,\"description\":\"faile\"}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write("{\"code\":200,\"description\":\"success\",\"detail\":" + returnstr + "}");
            Context.Response.End();

        }
    }
}
