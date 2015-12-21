using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace Web
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
             var cmd = Request["Action"];
             if (cmd == "form")
             {
                 try
                 {
                     //DataRow[] dr = Caches.CRM_Repair_Follow.Select("RepairID=" + Request["rid"] + " AND IsDel='N'");
                     //string jdata = Tools.DataRowToJson(dr, Types.JosnType.Grid);
                     string jdata = "{\"TEST1\":[{\"name\":\"自定义1\",\"x\":445,\"y\":153},{\"name\":\"自定义2\",\"x\":355,\"y\":151}],";
                     jdata += " \"TEST2\":[{\"name\":\"zz1\",\"x\":0,\"y\":1} ]}";
                     Response.ContentType = "application/json";
                     Response.Write(jdata);
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
