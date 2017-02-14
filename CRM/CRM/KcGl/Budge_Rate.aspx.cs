using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;

namespace Budge_Rate
{
    public partial class Budge_Rate : System.Web.UI.Page
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
                        sortname = "A.ID";
                    if (string.IsNullOrEmpty(sortorder))
                        sortorder = "DESC";
                    string sorttext = sortname + " " + sortorder;
                    string serchtxt = "A.ID is not null ";
                    if (!string.IsNullOrEmpty(Request["stext"]))
                        serchtxt += "AND A.RateName LIKE ''%" + Request["stext"] + "%'' ";

                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("DECLARE @recordTotal INT ");
                    sb.AppendLine("EXEC dbo.usp_GetPagerData ");
                    sb.AppendLine("    @recordTotal OUT , -- int ");
                    //sb.AppendLine("    @viewName='Budge_Rate' , -- varchar(800) ");
                    sb.AppendLine("    @viewName='Budge_Rate A LEFT JOIN Budge_Rate_CalculationFormula B ON A.formulaId=B.id' , -- varchar(800) ");
                    //sb.AppendLine("    @fieldName='*' , -- varchar(800) ");
                    sb.AppendLine("    @fieldName='A.*,B.formula,B.bz' , -- varchar(800) ");
                    sb.AppendLine("    @keyName='A.ID' , -- varchar(200) ");
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