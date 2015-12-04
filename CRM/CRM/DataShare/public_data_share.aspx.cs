using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace XHD.CRM.CRM.DataShare
{
    public partial class public_data_share : System.Web.UI.Page
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
                        sortname = "orderid";
                    if (string.IsNullOrEmpty(sortorder))
                        sortorder = "asc";
                    string sorttext = sortname + " " + sortorder;
                    string serchtxt = "1=1 ";
                    if (!string.IsNullOrEmpty(Request["categoryid"]))
                        serchtxt += "AND category_id LIKE ''%" + Request["categoryid"] + "%'' ";
                    if (!string.IsNullOrEmpty(Request["stext"]))
                        serchtxt += "AND title LIKE ''%" + Request["stext"] + "%'' ";

                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("DECLARE @recordTotal INT ");
                    sb.AppendLine("EXEC dbo.usp_GetPagerData ");
                    sb.AppendLine("    @recordTotal OUT , -- int ");
                    sb.AppendLine("    @viewName='V_public_data' , -- varchar(800) ");
                    sb.AppendLine("    @fieldName='*' , -- varchar(800) ");
                    sb.AppendLine("    @keyName='id' , -- varchar(200) ");
                    sb.AppendLine("    @pageSize='" + pagesize + "' , -- int ");
                    sb.AppendLine("    @pageNo='" + pageno + "' , -- int ");
                    sb.AppendLine("    @orderString='" + sorttext + "' , -- varchar(200) ");
                    sb.AppendLine("    @whereString='" + serchtxt + "' -- varchar(800) ");
                    sb.AppendLine("SELECT @recordTotal ");
                    DataSet ds = SqlDB.ExecuteDataSet(sb.ToString()).Output1;
                    //string jdata = Tools.DataTableToJson(ds.Tables[0], int.Parse(ds.Tables[1].Rows[0][0].ToString()), Types.JosnType.Grid);
                    string jdata = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], ds.Tables[1].Rows[0][0].ToString());
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
            else if (cmd == "tree")
            {
                try
                {
                    StringBuilder sb = new StringBuilder();
                    sb.AppendLine("SELECT * FROM dbo.V_public_data_category");
                    DataTable dt = SqlDB.ExecuteDataTable(sb.ToString()).Output1;
                    StringBuilder jdata = new StringBuilder();
                    jdata.Append("[");
                    jdata.Append(GetTreeString(0, dt));
                    jdata.Replace(",", "", jdata.Length - 1, 1);
                    jdata.Append("]");
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
            else if (cmd == "form")
            {
                try
                {
                    StringBuilder sb = new StringBuilder();
                    sb.AppendLine("SELECT *,REPLACE(t_content,'../../../','http://gl.xczs.com/') AS t_content_ ");
                    sb.AppendLine("FROM dbo.V_public_data ");
                    sb.AppendLine("WHERE id='" + Request["pid"] + "'");
                    DataTable dt = SqlDB.ExecuteDataTable(sb.ToString()).Output1;
                    //string jdata = Tools.DataTableToJson(dt, Types.JosnType.Form);
                    string jdata = Common.GetGridJSON.DataTableToJSON(dt);
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

        private static string GetTreeString(int Id, DataTable table)
        {
            DataRow[] rows = table.Select(string.Format("parentid={0}", Id));

            if (rows.Length == 0) return string.Empty; ;
            StringBuilder str = new StringBuilder();

            foreach (DataRow row in rows)
            {
                str.Append("{id:" + (int)row["id"] + ",text:'" + (string)row["category"] + "',d_icon:'../../" + (string)row["icon"] + "'");

                if (GetTreeString((int)row["id"], table).Length > 0)
                {
                    str.Append(",children:[");
                    str.Append(GetTreeString((int)row["id"], table));
                    str.Append("]},");
                }
                else
                {
                    str.Append("},");
                }
            }
            return str[str.Length - 1] == ',' ? str.ToString(0, str.Length - 1) : str.ToString();
        }
    }
}