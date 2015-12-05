using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;

namespace Repair
{
    public partial class Repair : System.Web.UI.Page
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
                        sortname = " orderwc,InDate ";
                    if (string.IsNullOrEmpty(sortorder))
                        sortorder = "desc";
                    string sorttext = sortname + " " + sortorder;
                    string serchtxt = "IsDel=''N'' ";
                    if (!string.IsNullOrEmpty(Request["Khmc"]))
                        serchtxt += "AND Khmc LIKE ''%" + Request["Khmc"] + "%'' ";
                    if (!string.IsNullOrEmpty(Request["Khdh"]))
                        serchtxt += "AND Khdh LIKE ''%" + Request["Khdh"] + "%'' ";
                    if (!string.IsNullOrEmpty(Request["Khxq"]))
                        serchtxt += "AND Khxq LIKE ''%" + Request["Khxq"] + "%'' ";

                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("DECLARE @recordTotal INT ");
                    sb.AppendLine("EXEC dbo.usp_GetPagerData ");
                    sb.AppendLine("    @recordTotal OUT , -- int ");
                    sb.AppendLine("    @viewName='v_Repair' , -- varchar(800) ");
                    sb.AppendLine("    @fieldName='*' , -- varchar(800) ");
                    sb.AppendLine("    @keyName='Khbh' , -- varchar(200) ");
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
                    DataRow[] dr = Caches.CRM_Repair_Follow.Select("RepairID=" + Request["rid"] + " AND IsDel='N'");
                    string jdata = Tools.DataRowToJson(dr, Types.JosnType.Grid);
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