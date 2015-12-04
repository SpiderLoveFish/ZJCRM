using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using XHD.Common;

namespace Repair
{
    public partial class Repair_Process : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var cmd = Request["cmd"];
            if (cmd == "save")
            {
                try
                {
                    var RepairID = Request["cid"];
                    var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                    var ticket = FormsAuthentication.Decrypt(cookie.Value);
                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("UPDATE dbo.CRM_Repair SET ");
                    sb.AppendLine("         Clrq='" + PageValidate.InputText(Request["Clrq"], 10) + "', ");
                    if(Request["Wcrq"]=="")
                        sb.AppendLine("         Wcrq=NULL,");
                    else
                        sb.AppendLine("         Wcrq='" + PageValidate.InputText(Request["Wcrq"], 10) + "',");
                    sb.AppendLine("         Fzxs='" + Request["Fzxs"] + "', ");
                    sb.AppendLine("         Wczt='" + Request["Wczt"] + "', ");
                    sb.AppendLine("         WxEmpID='" + Request["WxEmpID"] + "', ");
                    sb.AppendLine("         GdEmpID='" + Request["GdEmpID"] + "', ");
                    sb.AppendLine("         Hfxx='" + Request["Hfxx"] + "', ");
                    sb.AppendLine("         Pjxx='" + Request["Pjxx"] + "', ");
                    sb.AppendLine("         ClEmpID='" + ticket.UserData + "',");
                    sb.AppendLine("         ClDate=GETDATE() ");
                    sb.AppendLine("WHERE RepairID='" + RepairID + "' ");

                    var rv = SqlDB.ExecuteNoneQuery(sb.ToString());
                    if (!rv.Result)
                        Response.Write(rv.Message);
                    Caches.CRM_Repair = null;
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
                finally
                {
                    Response.End();
                }
            }
        }
    }
}