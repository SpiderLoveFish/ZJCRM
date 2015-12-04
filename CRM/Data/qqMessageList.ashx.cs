using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using XHD.Common;

namespace XHD.CRM.Data
{
    /// <summary>
    /// qqMessageList 的摘要说明
    /// </summary>
    public class qqMessageList : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Charset = "utf-8";
            HttpRequest request = context.Request;

            qqMessage qm = new qqMessage();
            string loginStatus = string.Empty;
            string openid = string.Empty;
            string nickname = string.Empty;
            string face = string.Empty;

            try
            {
                qm = context.Session["qmmessage"] as qqMessage;
                loginStatus = qm.loginStatus;
                openid = qm.openid;
                nickname = qm.nickname;
                face = qm.face2;
            }
            catch (Exception e)
            {
                loginStatus = "0";
            }

            



            #region "loginRebind"
            if (request["Action"] == "loginRebind")
            {


                BLL.hr_employee emp = new BLL.hr_employee();
                if (loginStatus != "1")
                {
                    context.Response.Write("998");//不允许登录
                    return;
                }

                string username = PageValidate.InputText(request["username"], 255);
                string password = PageValidate.InputText(request["password"], 255);
                try
                {
                    if (!string.IsNullOrEmpty(username) && !string.IsNullOrEmpty(password))
                    {

                        DataSet ds = emp.GetList(" uid='" + username + "' and pwd='" + password + "'");
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            if (ds.Tables[0].Rows[0]["canlogin"].ToString() == "1")
                            {
                                if (ds.Tables[0].Rows[0]["QQID"].ToString() == "")
                                {
                                    //修改qq资料 获取qq头像
                                    string sqlstr = "UPDATE hr_employee SET QQID='" + openid + "',QQTX='" + face + "' WHERE uid ='" + username + "'";

                                    SqlDB.ExecuteNoneQuery(sqlstr);


                                    string userid = ds.Tables[0].Rows[0]["ID"].ToString();
                                    string name = ds.Tables[0].Rows[0]["name"].ToString();
                                    FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                                        1,
                                        username,
                                        DateTime.Now,
                                        DateTime.Now.AddMinutes(20),
                                        true,
                                        userid,
                                        "/"
                                        );
                                    var cookie = new HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(ticket));
                                    cookie.HttpOnly = true;
                                    context.Response.Cookies.Add(cookie);

                                    //FormsAuthentication.SetAuthCookie(userid, true);

                                    //日志
                                    BLL.Sys_log log = new BLL.Sys_log();
                                    Model.Sys_log modellog = new Model.Sys_log();
                                    modellog.EventType = "系统登录";

                                    modellog.EventDate = DateTime.Now;
                                    modellog.UserID = int.Parse(userid);
                                    modellog.UserName = ds.Tables[0].Rows[0]["name"].ToString();
                                    modellog.IPStreet = request.UserHostAddress;

                                    log.Add(modellog);

                                    //online
                                    BLL.Sys_online sol = new BLL.Sys_online();
                                    Model.Sys_online model = new Model.Sys_online();

                                    model.UserName = ds.Tables[0].Rows[0]["name"].ToString();
                                    model.UserID = int.Parse(ds.Tables[0].Rows[0]["id"].ToString());
                                    model.LastLogTime = DateTime.Now;
                                    DataSet ds1 = sol.GetList(" UserID=" + ds.Tables[0].Rows[0]["id"].ToString());

                                    //添加当前用户信息
                                    if (ds1.Tables[0].Rows.Count > 0)
                                    {
                                        sol.Update(model, " UserID=" + ds.Tables[0].Rows[0]["id"].ToString());
                                    }
                                    else
                                    {
                                        sol.Add(model);
                                    }
                                    //删除超时用户
                                    sol.Delete(" LastLogTime<DATEADD(MI,-1,getdate())");

                                    //验证完毕，允许登录
                                    context.Response.Write("2");
                                }
                                else
                                {
                                    //已经被绑定，不允许重复绑定
                                    context.Response.Write("5");
                                }
                            }
                            else
                            {
                                context.Response.Write("4");//不允许登录
                            }
                        }
                        else
                        {
                            context.Response.Write("1");//用户名或密码错误
                        }
                    }
                    else
                    {
                        context.Response.Write("999");//系统数据错误
                    }
                }
                catch (Exception ex)
                {
                    context.Response.Write(ex.ToString());
                }
            }
            #endregion

            if (request["Action"] == "GetUserInfoLoginType")
            {
                if (loginStatus == "0")
                    context.Response.Write("ab");
                else if (loginStatus == "1")
                {
                    DataSet dst = SqlDB.ExecuteDataSet("select '' qqid,'' qqnc,'' face ").Output1;
                    //dst.Tables[0].Rows[0]["qqid"] = qm.openid;
                    //dst.Tables[0].Rows[0]["qqnc"] = qm.nickname;
                    //dst.Tables[0].Rows[0]["face"] = qm.face2;

                    dst.Tables[0].Rows[0]["qqid"] = openid;
                    dst.Tables[0].Rows[0]["qqnc"] = nickname;
                    dst.Tables[0].Rows[0]["face"] = face;
                    string jsonstr = Common.DataToJson.DataToJSON(dst);
                    context.Response.Write(jsonstr);
                }
                else
                {
                    context.Response.Write(loginStatus);
                }
            }
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