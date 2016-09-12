using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using XHD.DBUtility;//Please add references
using System.Data.SqlClient;
using System.Data;

namespace XHD.CRM.webserver
{
    /// <summary>
    /// Summary description for AppApi
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class AppApi : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        /// <summary>
        /// 登录
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public void aa()
        {
         string token=   System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(
                                              GetTimeStamp() 
                                              //+ ds.Tables[0].Rows[0]["uid"].ToString()
                                              , "MD5");
         //UPDATE	 dbo.hr_employee  SET token= substring(sys.fn_sqlvarbasetostr(HashBytes('MD5','xczs'+uid+dname+tel)),3,32)
         var sb = new System.Text.StringBuilder();
         sb.AppendLine(" Update hr_employee");
         sb.AppendLine(" set token='" + token + "'");
         //sb.AppendLine(" where id=" + id + "");
         //SqlParameter[] parameters = { };
         //return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);

        }

        public static string GetTimeStamp()
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
            return Convert.ToInt64(ts.TotalSeconds).ToString();
        } 

         private  string ReturnStr(bool flag,string data)
         {
             string rstr="";
             if (flag)
             {
                 rstr= " {\"meta\":"+data+",\"data\":null}";
             }
             else
             {
                 rstr = " {\"meta\":null,\"data\":" + data + "}";
             }
             return rstr;
         }

    }
}
