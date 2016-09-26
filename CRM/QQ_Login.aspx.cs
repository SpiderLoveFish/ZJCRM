using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using XHD.CRM.Class;
using Newtonsoft.Json;

namespace XHD.CRM
{
    public partial class QQ_Login_aspx : System.Web.UI.Page
    {
        //protected void Page_Load(object sender, EventArgs e)
        //{

        //}
        private readonly string client_id = Utils.GetAppSeting("qzone_AppID");
        private readonly string client_secret = Utils.GetAppSeting("qzone_AppKey");
        private readonly string redirect_uri = Utils.GetAppSeting("qzone_Redirect_uri");

        //临时变量，发送URL,接受返回结果
        private string send_url = "", rezult = "";
        //用于第三方应用防止CSRF攻击，成功授权后回调时会原样带回。
        private string state = "";
        //临时Authorization Code，官方提示10分钟过期
        private string code = "";
        //通过Authorization Code返回结果获取到的Access Token
        private string access_token = "";
        //expires_in是该Access Token的有效期，单位为秒
        private string expires_in = "";
        //通过Access Token返回来的client_id 
        private string new_client_id = "";
        //通过Access Token返回来的openid，QQ用户唯一值，可以与网站用户数据关联
        private string openid = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            DoCallback();
        }

        void DoCallback()
        {
            //取得state
            state = Utils.GetQueryString("state");

            try
            {
                if (HttpContext.Current.Session["state"] == null || HttpContext.Current.Session["state"].ToString() == "")
                {
                    HttpContext.Current.Response.Write("state未初始化");
                    HttpContext.Current.Response.End();
                }
            }
            catch
            {
                //写日志
                Logs.logSave("state未初始化");
            }

            //如果返回state与之前发出的判断正确
            if (state == HttpContext.Current.Session["state"].ToString())
            {
                //取得返回CODE
                code = Utils.GetQueryString("code");

                //写日志
                //  Logs.logSave("判断state取得吻合，返回CODE结果：" + code);

                //==============通过Authorization Code和基本资料获取Access Token=================
                send_url = "https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id=" + client_id + "&client_secret=" + client_secret + "&code=" + code + "&state=" + state + "&redirect_uri=" + Utils.UrlEncode(redirect_uri);

                //写日志
                // Logs.logSave("第二步，通过Authorization Code获取Access Token，发送URL：" + send_url);

                //发送并接受返回值
                rezult = HttpMethods.HttpGet(send_url);

                //写日志
                // Logs.logSave("取得返回结果：" + rezult);

                //如果失败
                if (rezult.Contains("error"))
                {
                    Logs.logSave("出错了：" + rezult);
                    HttpContext.Current.Response.End();
                }
                else
                {
                    //======================通过Access Token来获取用户的OpenID==============

                    string[] parm = rezult.Split('&');

                    //取得 access_token
                    access_token = parm[0].Split('=')[1];
                    //取得 过期时间
                    expires_in = parm[1].Split('=')[1];
                    //拼接url
                    send_url = "https://graph.qq.com/oauth2.0/me?access_token=" + access_token;

                    //发送并接受返回值
                    rezult = HttpMethods.HttpGet(send_url);
                    //写日志
                    //  Logs.logSave("第三步，发送 access_token：" + send_url);


                    //如果失败
                    if (rezult.Contains("error"))
                    {
                        //出错了
                        //写日志
                        Logs.logSave("出错了：" + rezult);
                        HttpContext.Current.Response.End();
                    }

                    //写日志
                    // Logs.logSave("得到返回结果：" + rezult);

                    //取得文字出现
                    int str_start = rezult.IndexOf('(') + 1;
                    int str_last = rezult.LastIndexOf(')') - 1;

                    //取得JSON字符串
                    rezult = rezult.Substring(str_start, (str_last - str_start));

                    //反序列化JSON
                    Dictionary<string, string> _dic = JsonConvert.DeserializeObject<Dictionary<string, string>>(rezult);

                    //取值
                    _dic.TryGetValue("client_id", out new_client_id);
                    _dic.TryGetValue("openid", out openid);

                    //储存获取数据用到的信息
                    HttpContext.Current.Session["access_token"] = access_token;
                    HttpContext.Current.Session["client_id"] = client_id;
                    HttpContext.Current.Session["openid"] = openid;

                    //========继续您的业务逻辑编程==========================================

                    //取到 openId
                    //openId与您系统的user数据进行关联
                    //一个openid对应一个QQ，一个openid也要对应到您系统的一个账号：QQ--OpenId--User；
                    //这个时候有两种情况：
                    //【1】您让用户绑定系统已有的用户，那么让用户输入用户名密码，找到该用户，然后绑定OpenId
                    //【2】为用户生成一个系统用户，直接绑定OpenId

                    //上面完成之后，设置用户的登录状态，完整绑定和登录


                    //=============比如：通过Access Token和OpenID来使用get_user_info方法获取用户资料====
                    send_url = "https://graph.qq.com/user/get_user_info?access_token=" + access_token + "&oauth_consumer_key=" + client_id + "&openid=" + openid;

                    //发送并接受返回值
                    rezult = HttpMethods.HttpGet(send_url);
                    //写日志
                    //  Logs.logSave("第四步，通过get_user_info方法获取数据：" + send_url);


                    //反序列化JSON
                    Dictionary<string, string> _dic2 = JsonConvert.DeserializeObject<Dictionary<string, string>>(rezult);

                    string ret = "", msg = "", nickname = "", face = "", face1 = "", face2 = "", sex = "", vip_level = "", qzone_level = "";

                    //取值
                    _dic2.TryGetValue("ret", out ret);
                    _dic2.TryGetValue("msg", out msg);

                    //如果失败
                    if (ret != "0")
                    {
                        //出错了
                        //写日志
                        Logs.logSave("出错了：" + rezult);
                        //HttpContext.Current.Response.Write(rezult);
                        HttpContext.Current.Response.End();
                    }

                    _dic2.TryGetValue("nickname", out nickname);
                    _dic2.TryGetValue("figureurl", out face);
                    _dic2.TryGetValue("figureurl_1", out face1);
                    _dic2.TryGetValue("figureurl_qq_2", out face2);
                    _dic2.TryGetValue("gender", out sex);
                    _dic2.TryGetValue("vip", out vip_level);
                    _dic2.TryGetValue("level", out qzone_level);


                    //string newline = "<br>";
                    //string str = "";
                    //str += "openid：" + openid + newline;
                    //str += "昵称：" + nickname + newline;
                    //str += "性别：" + sex + newline;
                    //str += "会员VIP等级：" + vip_level + newline;
                    //str += "空间黄钻等级：" + qzone_level + newline;
                    //str += "默认头像：" + face + newline;
                    //str += "头像1：" + face1 + newline;
                    //str += "头像2：" + face2 + newline;                   

                    BLL.hr_employee emp = new BLL.hr_employee();
                    DataTable dtQQLogin = SqlDB.ExecuteDataTable("SELECT uid FROM dbo.hr_employee WHERE QQID ='" + openid + "'").Output1;

                    qqMessage qm = new qqMessage();

                    //Caches.qqMes.openid = openid;
                    //Caches.qqMes.nickname = nickname;
                    //Caches.qqMes.sex = sex;
                    //Caches.qqMes.vip_level = vip_level;
                    //Caches.qqMes.qzone_level = qzone_level;
                    //Caches.qqMes.face = face;
                    //Caches.qqMes.face1 = face1;
                    //Caches.qqMes.face2 = face2;
                    //Caches.qqMes.loginStatus = "1";


                    qm.openid = openid;
                    qm.nickname = nickname;
                    qm.sex = sex;
                    qm.vip_level = vip_level;
                    qm.qzone_level = qzone_level;
                    qm.face = face;
                    qm.face1 = face1;
                    qm.face2 = face2;
                    qm.loginStatus = "0";
                    qm.loginStatus = "1";
                    HttpContext.Current.Session["qmmessage"] = qm;

                    if (dtQQLogin.Rows.Count == 0)
                    { 
                        Context.Response.Redirect("qq_rebind.aspx?openid=" + openid);
                    }
                    else// if (LoginMessage.getLoginStatus(dtQQLogin.Rows[0][0].ToString(), Context))
                    {
                        #region"使用QQ登录 跳转界面"
                        string username = dtQQLogin.Rows[0][0].ToString();
                        DataSet ds = emp.GetList(" uid='" + username + "'");
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            if (ds.Tables[0].Rows[0]["canlogin"].ToString() == "1")
                            {
                                Caches.qqMes.loginStatus = "1";
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
                                Page.Response.Cookies.Add(cookie);

                                //FormsAuthentication.SetAuthCookie(userid, true);

                                //日志
                                BLL.Sys_log log = new BLL.Sys_log();
                                Model.Sys_log modellog = new Model.Sys_log();
                                modellog.EventType = "系统登录";

                                modellog.EventDate = DateTime.Now;
                                modellog.UserID = int.Parse(userid);
                                modellog.UserName = ds.Tables[0].Rows[0]["name"].ToString();
                                modellog.IPStreet = Page.Request.UserHostAddress;

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
                                Context.Response.Redirect("main.aspx");
                            }

                        } 
                        //#endregion"使用QQ登录 跳转界面" 
                        Context.Response.Redirect("main.aspx");
                    } 

                        #endregion
                     
                }

            }
            else
            {
                //写日志
                Logs.logSave("state取得不匹配，返回结果：" + state);
            }

        }
    }
}