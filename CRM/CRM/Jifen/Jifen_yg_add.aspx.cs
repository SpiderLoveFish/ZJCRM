using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Jifen
{
    public partial class Jifen_yg_add : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var cmd = Request["cmd"];
            if (cmd == "form")
            {
                try
                {
                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("SELECT * ");
                    sb.AppendLine("FROM dbo.CRM_Jifen ");
                    sb.AppendLine("WHERE JfID='" + Request["jid"] + "'");
                    DataRow[] dr = SqlDB.ExecuteDataTable(sb.ToString()).Output1.Select("");
                    string jdata = Tools.DataRowToJson(dr, Types.JosnType.Form);
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
            else if (cmd == "search")
            {
                try
                {
                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("SELECT * ");
                    sb.AppendLine("FROM dbo.hr_employee ");
                    sb.AppendLine("WHERE id='" + Request["cid"] + "'");
                    DataRow[] dr = SqlDB.ExecuteDataTable(sb.ToString()).Output1.Select("");
                    string jdata = Tools.DataRowToJson(dr, Types.JosnType.Form);
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
            else if (cmd == "save")
            {
                try
                {
                    var JfID = Request["jid"];
                    var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                    var ticket = FormsAuthentication.Decrypt(cookie.Value);
                    var sb = new System.Text.StringBuilder();
                    if (string.IsNullOrWhiteSpace(JfID) || JfID == "null" || JfID == "0")
                    {
                        if (Request["jlx"] == "1")
                        {
                            sb.AppendLine("SELECT ISNULL(Jf,0)-" + Request["Jf"] + " AS Jf ");
                            sb.AppendLine("FROM( ");
                            sb.AppendLine("	SELECT a.ID,a.Jf1-ISNULL(b.Jf2,0) AS Jf FROM ( ");
                            sb.AppendLine("		SELECT ID,SUM(Jf) AS Jf1 FROM dbo.CRM_Jifen ");
                            sb.AppendLine("		WHERE Sfkh='N' AND Jflx=0 AND IsDel='N' AND ID='" + Request["cid"] + "' ");
                            sb.AppendLine("		GROUP BY ID) a ");
                            sb.AppendLine("	LEFT JOIN ( ");
                            sb.AppendLine("		SELECT ID,SUM(Jf) AS Jf2 FROM dbo.CRM_Jifen ");
                            sb.AppendLine("		WHERE Sfkh='N' AND Jflx=1 AND IsDel='N' AND ID='" + Request["cid"] + "' ");
                            sb.AppendLine("		GROUP BY ID) b ON a.ID=b.ID ");
                            sb.AppendLine(") a ");
                            var rv = SqlDB.ExecuteDataTable(sb.ToString());
                            if (!rv.Result)
                                Response.Write(rv.Message);
                            else
                            {
                                if (int.Parse(rv.Output1.Rows[0][0].ToString()) < 0)
                                {
                                    Response.Write("使用积分不能超过当前总积分！");
                                    return;
                                }
                            }
                            sb.Clear();
                        }
                        sb.AppendLine("INSERT INTO dbo.CRM_Jifen (ID,Jflx,Jf,Sfkh,Content,IsDel,InEmpID,InDate) ");
                        sb.AppendLine("VALUES  ('" + Request["cid"] + "', ");
                        sb.AppendLine("         '" + Request["jlx"] + "', ");
                        sb.AppendLine("         '" + Request["Jf"] + "', ");
                        sb.AppendLine("         'N', ");
                        sb.AppendLine("         '" + Request["Content"] + "', ");
                        sb.AppendLine("         'N', ");
                        sb.AppendLine("         '" + ticket.UserData + "', ");
                        sb.AppendLine("         GETDATE()  ");
                        sb.AppendLine("         ) ");
                    }
                    else
                    {
                        if (Request["jlx"] == "1")
                        {
                            sb.AppendLine("SELECT ISNULL(a.Jf,0)+b.Jf-" + Request["Jf"] + " AS Jf ");
                            sb.AppendLine("FROM( ");
                            sb.AppendLine("	SELECT a.ID,a.Jf1-ISNULL(b.Jf2,0) AS Jf FROM ( ");
                            sb.AppendLine("		SELECT ID,SUM(Jf) AS Jf1 FROM dbo.CRM_Jifen ");
                            sb.AppendLine("		WHERE Sfkh='N' AND Jflx=0 AND IsDel='N' AND ID='" + Request["cid"] + "' ");
                            sb.AppendLine("		GROUP BY ID) a ");
                            sb.AppendLine("	LEFT JOIN ( ");
                            sb.AppendLine("		SELECT ID,SUM(Jf) AS Jf2 FROM dbo.CRM_Jifen ");
                            sb.AppendLine("		WHERE Sfkh='N' AND Jflx=1 AND IsDel='N' AND ID='" + Request["cid"] + "' ");
                            sb.AppendLine("		GROUP BY ID) b ON a.ID=b.ID ");
                            sb.AppendLine(") a ");
                            sb.AppendLine("INNER JOIN dbo.CRM_Jifen b ON b.JfID='" + JfID + "' ");
                            var rv = SqlDB.ExecuteDataTable(sb.ToString());
                            if (!rv.Result)
                                Response.Write(rv.Message);
                            else
                            {
                                if (int.Parse(rv.Output1.Rows[0][0].ToString()) < 0)
                                {
                                    Response.Write("使用积分不能超过当前总积分！");
                                    return;
                                }
                            }
                            sb.Clear();
                        }
                        sb.AppendLine("UPDATE dbo.CRM_Jifen SET ");
                        sb.AppendLine("         Jf='" + Request["Jf"] + "',");
                        sb.AppendLine("         Content='" + Request["Content"] + "', ");
                        sb.AppendLine("         EditEmpID='" + ticket.UserData + "',");
                        sb.AppendLine("         EditDate=GETDATE() ");
                        sb.AppendLine("WHERE JfID='" + JfID + "' ");
                    }

                    var rv1 = SqlDB.ExecuteNoneQuery(sb.ToString());
                    if (!rv1.Result)
                        Response.Write(rv1.Message);
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
            else if (cmd == "del")
            {
                try
                {
                    var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                    var ticket = FormsAuthentication.Decrypt(cookie.Value);
                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("UPDATE dbo.CRM_Jifen SET ");
                    sb.AppendLine("         IsDel='Y', ");
                    sb.AppendLine("         DelEmpID='" + ticket.UserData + "',");
                    sb.AppendLine("         DelDate=GETDATE() ");
                    sb.AppendLine("WHERE JfID='" + Request["jid"] + "' ");

                    var rv1 = SqlDB.ExecuteNoneQuery(sb.ToString());
                    if (!rv1.Result)
                        Response.Write(rv1.Message);
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