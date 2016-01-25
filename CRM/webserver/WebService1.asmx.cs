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
          XHD.CRM.Data.C_Sys_log log = new XHD.CRM.Data.C_Sys_log();
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
        [WebMethod]
         public void GetLogin(string username,string password,string ip)
        {
           // FormsAuthentication.HashPasswordForStoringInConfigFile(password, "MD5");
            password = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(password, "MD5");
                    string returnstr = "{}";
                     DataSet ds = emp.GetList(" uid='" + username + "' and pwd='" + password + "'");
                         if (ds.Tables[0].Rows.Count > 0)
                            {
                                if (ds.Tables[0].Rows[0]["canlogin"].ToString() == "1")
                                {
                                    string userid = ds.Tables[0].Rows[0]["ID"].ToString();
                                    string uid = ds.Tables[0].Rows[0]["uid"].ToString();
                                    string name = ds.Tables[0].Rows[0]["name"].ToString();
                                    returnstr = "{\"uid\":\"" + uid + "\",\"account\":\"" + userid + "\",\"password\":\"" + password + "\",\"name\":\"" + name + "\"}";
                                    log.Add_log(int.Parse(userid), name, ip, "手机端登录", "手机端登录", 0, "手机端登录", "", "");

                                }
                            }
                        
                         Context.Response.Charset = "utf-8"; //设置字符集类型  
                         Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
                         Context.Response.Write(returnstr);
                         Context.Response.End();  
                          //  return returnstr;
         
        }
        [WebMethod]
        public void GetCustomer(string where)
        {
            BLL.CRM_Customer cus = new BLL.CRM_Customer();
            DataSet ds = cus.GetList("id="+where);
            string returnstr = "{}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write("{\"Customer\":" + returnstr + "}");
            Context.Response.End();  
        }


        [WebMethod]
        public void GetCustomer(int pageIndex, int pageSize)
        {
            BLL.CRM_Customer cus = new BLL.CRM_Customer();
            DataSet ds = cus.GetPageList(pageIndex, pageSize);
            string returnstr = "{}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write("{\"Customer\":" + returnstr + "}");
            Context.Response.End();
        }


        [WebMethod]
        public void GetPoduct_Category()
        {
            BLL.CRM_product_category pc = new BLL.CRM_product_category();
            DataSet ds = pc.GetList(" 1=1 ");
            string returnstr = "{}";
            if (ds.Tables[0].Rows.Count > 0)
            {
                returnstr = Common.DataToJson.GetJson(ds);
            }
            Context.Response.Charset = "utf-8"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Context.Response.Write("{\"PoductCat\":" + returnstr + "}");
            Context.Response.End();
        }
    }
}
