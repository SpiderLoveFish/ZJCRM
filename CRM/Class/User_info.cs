using System.Web;
using System.Web.Security;
using XHD.Model;

namespace XHD.Class
{
    public class User_info
    {
        public hr_employee GetCurrentEmpInfo(HttpContext context)
        {
            HttpCookie cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            var emp = new BLL.hr_employee();
            hr_employee empmodel = emp.GetModel(int.Parse(CoockiesID));
            return empmodel;
        }
    }
}