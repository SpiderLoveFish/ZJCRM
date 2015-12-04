using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;

namespace Jifen
{
    public partial class Jifen_yg : System.Web.UI.Page
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
                        sortname = "ID";
                    if (string.IsNullOrEmpty(sortorder))
                        sortorder = "ASC";
                    string sorttext = sortname + " " + sortorder;
                    string serchtxt = "1=1 ";
                    if (!string.IsNullOrEmpty(Request["Name"]))
                        serchtxt += "AND Name LIKE ''%" + Request["Name"] + "%'' ";
                    if (!string.IsNullOrEmpty(Request["Tel"]))
                        serchtxt += "AND Tel LIKE ''%" + Request["Tel"] + "%'' ";

                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("DECLARE @recordTotal INT ");
                    sb.AppendLine("EXEC dbo.usp_GetPagerData ");
                    sb.AppendLine("    @recordTotal OUT , -- int ");
                    sb.AppendLine("    @viewName='v_Jifen_Yg' , -- varchar(800) ");
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
            else if (cmd == "grid1")
            {
                try
                {
                    string pageno = Request["page"] == null ? "1" : Request["page"];
                    string pagesize = Request["pagesize"] == null ? "30" : Request["pagesize"];
                    string sortname = Request["sortname"];
                    string sortorder = Request["sortorder"];
                    if (string.IsNullOrEmpty(sortname))
                        sortname = "InDate";
                    if (string.IsNullOrEmpty(sortorder))
                        sortorder = "DESC";
                    string sorttext = sortname + " " + sortorder;
                    string serchtxt = "ID=" + Request["rid"];

                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("DECLARE @recordTotal INT ");
                    sb.AppendLine("EXEC dbo.usp_GetPagerData ");
                    sb.AppendLine("    @recordTotal OUT , -- int ");
                    sb.AppendLine("    @viewName='v_Jifen_Yg_Mx' , -- varchar(800) ");
                    sb.AppendLine("    @fieldName='*' , -- varchar(800) ");
                    sb.AppendLine("    @keyName='JfID' , -- varchar(200) ");
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