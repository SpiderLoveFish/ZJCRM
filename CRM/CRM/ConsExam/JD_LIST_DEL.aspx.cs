using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;

namespace JD_LIST_DEL
{
    public partial class JD_LIST_DEL : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var cmd = Request["cmd"];
            if (cmd == "grid")
            {
                try
                {
                    string pageno = Request["page"] == null ? "1" : Request["page"];
                     string pagesize = Request["pagesize"] == null ? "30" : Request["pagesize"];
                    string sortname = Request["sortname"];
                    string sortorder = Request["sortorder"];
                    if (string.IsNullOrEmpty(sortname))
                        sortname = "LRRQ";
                    if (string.IsNullOrEmpty(sortorder))
                        sortorder = "DESC";
                    string sorttext = sortname + " " + sortorder;
                    string serchtxt = "KHJDID IS NOT NULL  ";
                    if (!string.IsNullOrEmpty(Request["stext"]))
                        serchtxt += "AND Cpro+Ccity+JDMC+XMMC+REMARK+CZR+Cmob LIKE ''%" + Request["stext"] + "%'' ";

                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("DECLARE @recordTotal INT ");
                    sb.AppendLine("EXEC dbo.usp_GetPagerData ");
                    sb.AppendLine("    @recordTotal OUT , -- int ");
                    sb.AppendLine("    @viewName='KHJD_LIST_VIEW_LIST' , -- varchar(800) ");
                    sb.AppendLine("    @fieldName='*' , -- varchar(800) ");
                    sb.AppendLine("    @keyName='ID' , -- varchar(200) ");
                    sb.AppendLine("    @pageSize='" + pagesize + "' , -- int ");
                    sb.AppendLine("    @pageNo='" + pageno + "' , -- int ");
                    sb.AppendLine("    @orderString='" + sorttext + "' , -- varchar(200) ");
                    sb.AppendLine("    @whereString='" + serchtxt + "' -- varchar(800) ");
                    sb.AppendLine("SELECT @recordTotal ");
                    DataSet ds = SqlDB.ExecuteDataSet(sb.ToString()).Output1;
                    string jdata = Tools.DataTableToJson(ds.Tables[0], int.Parse(ds.Tables[1].Rows[0][0].ToString()), Types.JosnType.Grid);
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