using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using XHD.Common;

namespace Sgry
{
    public partial class Sgry_Rq : System.Web.UI.Page
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
                        sb.AppendLine("FROM dbo.Sgry_Main ");
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
                    sb.AppendLine("SELECT * FROM dbo.Sgry_Main ");
                    sb.AppendLine("WHERE  IsDel='N' AND dh='" + Request["dh"] + "' and id <>ISNULL("+ID+",0)");
                    var rv = SqlDB.ExecuteDataTable(sb.ToString());
                    if (!rv.Result)
                    {
                        Response.Write(rv.Message+"失败！"); return;
                    }
                    else
                    {
                        if (rv.Output1.Rows.Count > 0)
                        {
                            Response.Write("此号码已存在，不能重复添加！");
                            return;
                        }
                    }
                    sb.Clear();
                    if (string.IsNullOrWhiteSpace(ID) || ID == "null")

                    {

                        sb.AppendLine("INSERT INTO dbo.Sgry_Main (Provinces,ProvincesID,City,CityID,Towns,TownsID,Name,Address,dh,Sex,gz,gzid,BNL,Bdate,lxr,lxrdh,gzjs,Remark,IsDel,InEmpID,InDate) ");
                        sb.AppendLine("VALUES  ('" + Request["Provinces"] + "', ");
                        sb.AppendLine("         '" + Request["Provinces_val"] + "', ");
                        sb.AppendLine("         '" + Request["City"] + "', ");
                        sb.AppendLine("         '" + Request["City_val"] + "', ");
                        sb.AppendLine("         '" + Request["Towns"] + "', ");
                        sb.AppendLine("         '" + Request["Towns_val"] + "', ");
                        sb.AppendLine("         '" + Request["Name"] + "', ");
                        sb.AppendLine("         '" + Request["Address"] + "', ");
                        sb.AppendLine("         '" + Request["dh"] + "', ");
                        sb.AppendLine("         '" + Request["Sex"] + "', ");
                        sb.AppendLine("         '" + Request["gz"] + "', ");
                        sb.AppendLine("         '" + Request["gz_val"] + "', ");
                        sb.AppendLine("         '" + Request["BNL"] + "', ");
                        sb.AppendLine("   dateadd(year,-" + Request["BNL"] + ",getdate()),");
                        sb.AppendLine("         '" + Request["lxr"] + "', ");
                        sb.AppendLine("         '" + Request["lxrdh"] + "', ");
                        sb.AppendLine("         '" + Request["Gzjs"] + "', ");
                        sb.AppendLine("         '" + Request["Remark"] + "', ");
                        sb.AppendLine("         'N', ");
                        sb.AppendLine("         '" + ticket.UserData+ "', ");
                        sb.AppendLine("         GETDATE() ");
                       
                        sb.AppendLine("         ) ");
                    }
                    else
                    {
                        sb.AppendLine("UPDATE dbo.Sgry_Main SET ");
                        sb.AppendLine("         Provinces='" + Request["Provinces"] + "', ");
                        sb.AppendLine("         ProvincesID='" + Request["Provinces_val"] + "', ");
                        sb.AppendLine("         City='" + Request["City"] + "', ");
                        sb.AppendLine("         CityID='" + Request["City_val"] + "', ");
                        sb.AppendLine("         Towns='" + Request["Towns"] + "', ");
                        sb.AppendLine("         TownsID='" + Request["Towns_val"] + "', ");
                        sb.AppendLine("         Name='" + Request["Name"] + "', ");
                        sb.AppendLine("         Address='" + Request["Address"] + "', ");
                        sb.AppendLine("         dh='" + Request["dh"] + "', ");
                        sb.AppendLine("         Sex='" + Request["Sex"] + "', ");
                        sb.AppendLine("         Gz='" + Request["gz"] + "', ");
                        sb.AppendLine("         Gzid='" + Request["gz_val"] + "', ");
                        sb.AppendLine("         lxr='" + Request["lxr"] + "', ");
                        sb.AppendLine("         lxrdh='" + Request["lxrdh"] + "', ");
                        sb.AppendLine("         Gzjs='" + Request["Gzjs"] + "', ");
                        sb.AppendLine("         Remark='" + Request["Remark"] + "', ");
                        sb.AppendLine("         BNL='" + Request["BNL"] + "', ");
                        sb.AppendLine("         Bdate=dateadd(year,-" + Request["BNL"] + ",getdate()),");
                        sb.AppendLine("         EditEmpID='" + ticket.UserData + "',");
                        sb.AppendLine("         EditDate=GETDATE() ");
                        sb.AppendLine("WHERE ID='" + ID + "' ");

                    }
                     var rvs = SqlDB.ExecuteNoneQuery(sb.ToString(),null);
                  
                    if (!rvs.Result)
                        Response.Write(rvs.Message);
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
                    sb.AppendLine("SELECT * FROM dbo.Sgry_Main ");
                    sb.AppendLine("WHERE ID='" + ID + "' AND IsDel='Y' ");
                    var rv = SqlDB.ExecuteDataTable(sb.ToString());
                    if (!rv.Result)
                        Response.Write(rv.Message);
                    else
                    {
                        if (rv.Output1.Rows.Count > 0)
                        {
                            Response.Write("不能重复删除！");
                            return;
                        }
                    }
                    //此楼盘中有未删除的客户，不能删除！
                    sb.Clear();
                    sb.AppendLine("UPDATE dbo.Sgry_Main SET ");
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