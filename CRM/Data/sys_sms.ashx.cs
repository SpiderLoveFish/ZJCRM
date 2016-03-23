using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using XHD.Common;
using System.Web.Security;

namespace XHD.CRM.Data
{
    /// <summary>
    /// sys_app 的摘要说明
    /// </summary>
    public class sys_sms : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();

            if (request["Action"] == "GetMessage")
            {
                sms sms = new Data.sms();
                string mobile=dsemp.Tables[0].Rows[0]["tel"].ToString();
                string yzm= PageValidate.InputText(request["yzm"], 255);
                string mes="您好，心成装饰给您发的验证码为"+yzm+"，请勿向任何单位或个人泄露。【心成装饰】";
                string a = sms.SendSMS(false, "", mes, mobile);
                    //"{\"?xml\":{\"@version\":\"1.0\",\"@encoding\":\"utf-8\"},\"returnsms\":{\"returnstatus\":\"Success\",\"message\":\"ok\",\"remainpoint\":\"10196\",\"taskID\":\"302471\",\"successCounts\":\"1\"}}"; //
                context.Response.Write(a);
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