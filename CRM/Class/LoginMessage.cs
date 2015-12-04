using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;

namespace XHD.CRM.Class
{
    public class LoginMessage
    {
        public static bool getLoginStatus(string username, HttpContext context)
        {
            try
            {
                BLL.hr_employee emp = new BLL.hr_employee();
                DataSet ds = emp.GetList(" uid='" + username + "'");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["canlogin"].ToString() == "1")
                    {
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
                        modellog.IPStreet = context.Request.UserHostAddress;

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
                         
                    }

                }
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }


    }
}