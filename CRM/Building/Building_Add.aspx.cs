using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using XHD.Common;

namespace Building
{
    public partial class Building_Add : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var cmd = Request["cmd"];
            if (cmd == "form")
            {
                if (PageValidate.IsNumber(Request["cid"]))
                {
                    try
                    {
                        var sb = new System.Text.StringBuilder();
                        sb.AppendLine("SELECT * ");
                        sb.AppendLine("FROM dbo.CRM_Building ");
                        sb.AppendLine("WHERE ID='" + Request["cid"] + "'");
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
                else
                {
                    Response.Write("{}");
                    Response.End();
                }
            }
            else if (cmd == "save")
            {
                try
                {
                    var ID = Request["cid"];
                    var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                    var ticket = FormsAuthentication.Decrypt(cookie.Value);
                    var sb = new System.Text.StringBuilder();
                    if (string.IsNullOrWhiteSpace(ID) || ID == "null")
                    {
                        sb.AppendLine("INSERT INTO dbo.CRM_Building (Provinces,ProvincesID,City,CityID,Towns,TownsID,Name,Address,Jzlb,Rjl,Lhl,Kpsj,Wygs,Wydh,Wyf,Sldh,Kfs,Jtzk,Jj,Remark,IsDel,InEmpID,InDate,xy) ");
                        sb.AppendLine("VALUES  ('" + Request["Provinces"] + "', ");
                        sb.AppendLine("         '" + Request["Provinces_val"] + "', ");
                        sb.AppendLine("         '" + Request["City"] + "', ");
                        sb.AppendLine("         '" + Request["City_val"] + "', ");
                        sb.AppendLine("         '" + Request["Towns"] + "', ");
                        sb.AppendLine("         '" + Request["Towns_val"] + "', ");
                        sb.AppendLine("         '" + Request["Name"] + "', ");
                        sb.AppendLine("         '" + Request["Address"] + "', ");
                        sb.AppendLine("         '" + Request["Jzlb"] + "', ");
                        sb.AppendLine("         '" + Request["Rjl"] + "', ");
                        sb.AppendLine("         '" + Request["Lhl"] + "', ");
                        sb.AppendLine("         '" + Request["Kpsj"] + "', ");
                        sb.AppendLine("         '" + Request["Wygs"] + "', ");
                        sb.AppendLine("         '" + Request["Wydh"] + "', ");
                        sb.AppendLine("         '" + Request["Wyf"] + "', ");
                        sb.AppendLine("         '" + Request["Sldh"] + "', ");
                        sb.AppendLine("         '" + Request["Kfs"] + "', ");
                        sb.AppendLine("         '" + Request["Jtzk"] + "', ");
                        sb.AppendLine("         '" + Request["Jj"] + "', ");
                        sb.AppendLine("         '" + Request["Remark"] + "', ");
                        sb.AppendLine("         'N', ");
                        sb.AppendLine("         '" + ticket.UserData+ "', ");
                        sb.AppendLine("         GETDATE(),  ");
                        sb.AppendLine("         '" + Request["T_xy"] + "' ");
                        sb.AppendLine("         ) ");
                    }
                    else
                    {
                        sb.AppendLine("UPDATE dbo.CRM_Building SET ");
                        sb.AppendLine("         Provinces='" + Request["Provinces"] + "', ");
                        sb.AppendLine("         ProvincesID='" + Request["Provinces_val"] + "', ");
                        sb.AppendLine("         City='" + Request["City"] + "', ");
                        sb.AppendLine("         CityID='" + Request["City_val"] + "', ");
                        sb.AppendLine("         Towns='" + Request["Towns"] + "', ");
                        sb.AppendLine("         TownsID='" + Request["Towns_val"] + "', ");
                        sb.AppendLine("         Name='" + Request["Name"] + "', ");
                        sb.AppendLine("         Address='" + Request["Address"] + "', ");
                        sb.AppendLine("         Jzlb='" + Request["Jzlb"] + "', ");
                        sb.AppendLine("         Rjl='" + Request["Rjl"] + "', ");
                        sb.AppendLine("         Lhl='" + Request["Lhl"] + "', ");
                        sb.AppendLine("         Kpsj='" + Request["Kpsj"] + "', ");
                        sb.AppendLine("         Wygs='" + Request["Wygs"] + "', ");
                        sb.AppendLine("         Wydh='" + Request["Wydh"] + "', ");
                        sb.AppendLine("         Wyf='" + Request["Wyf"] + "', ");
                        sb.AppendLine("         Sldh='" + Request["Sldh"] + "', ");
                        sb.AppendLine("         Kfs='" + Request["Kfs"] + "', ");
                        sb.AppendLine("         Jtzk='" + Request["Jtzk"] + "', ");
                        sb.AppendLine("         Jj='" + Request["Jj"] + "', ");
                        sb.AppendLine("         Remark='" + Request["Remark"] + "', ");
                        sb.AppendLine("         xy='" + Request["T_xy"] + "', ");
                        sb.AppendLine("         EditEmpID='" + ticket.UserData + "',");
                        sb.AppendLine("         EditDate=GETDATE() ");
                        sb.AppendLine("WHERE ID='" + ID + "' ");

                    }

                    var rv = SqlDB.ExecuteNoneQuery(sb.ToString());
                    if (!rv.Result)
                        Response.Write(rv.Message);
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
                    var ID = Request["cid"];
                    var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                    var ticket = FormsAuthentication.Decrypt(cookie.Value);
                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("SELECT * FROM dbo.CRM_Customer ");
                    sb.AppendLine("WHERE Community_id=" + ID );
                    var rv = SqlDB.ExecuteDataTable(sb.ToString());
                    if (!rv.Result)
                        Response.Write(rv.Message);
                    else
                    {
                        if (rv.Output1.Rows.Count > 0)
                        {
                            Response.Write("此楼盘已被使用，不能删除！");
                            return;
                        }
                    }
                    //此楼盘中有未删除的客户，不能删除！
                    sb.Clear();
                    sb.AppendLine("UPDATE dbo.CRM_Building SET ");
                    sb.AppendLine("         IsDel='Y', ");
                    sb.AppendLine("         DelEmpID='" + ticket.UserData + "',");
                    sb.AppendLine("         DelDate=GETDATE() ");
                    sb.AppendLine("WHERE ID='" + ID + "' ");

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
        }
    }
}