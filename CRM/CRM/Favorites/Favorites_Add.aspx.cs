using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Favorites
{
    public partial class Favorites_Add : System.Web.UI.Page
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
                    sb.AppendLine("FROM dbo.v_CRM_Favorites ");
                    sb.AppendLine("WHERE id='" + Request["cid"] + "'");
                    DataTable dt = SqlDB.ExecuteDataTable(sb.ToString()).Output1;
                    string jdata = Tools.DataTableToJson(dt, Types.JosnType.Form);
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
                    var FavoritesID = Request["cid"];
                    var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                    var ticket = FormsAuthentication.Decrypt(cookie.Value);
                    if (Request["IsShowPic"] == "")
                    {
                        Response.Write("是否显示图片为空");
                        Response.End();
                    }
                    var IsShowPic = Request["IsShowPic"] == "是" ? "Y" : "N";
                    var sb = new System.Text.StringBuilder();
                    if (string.IsNullOrWhiteSpace(FavoritesID) || FavoritesID == "null")
                    {
                        sb.AppendLine("INSERT INTO dbo.CRM_Favorites (Name,Url,Content,PicUrl,IsShowPic,CategoryID,IsPublic,OrderID,InEmpID,InDate,IsDel) ");
                        sb.AppendLine("VALUES  ('" + Request["Name"] + "', ");
                        sb.AppendLine("         '" + Request["Url"] + "', ");
                        sb.AppendLine("         '" + Request["Content"] + "', ");
                        sb.AppendLine("         '" + Request["PicUrl"] + "', ");
                        sb.AppendLine("         '" + IsShowPic + "', ");
                        sb.AppendLine("         '" + Request["Category_val"] + "', ");
                        sb.AppendLine("         'N', ");
                        sb.AppendLine("         " + Request["OrderID"] + ", ");
                        sb.AppendLine("         "+ticket.UserData+", ");
                        sb.AppendLine("         GETDATE(), ");
                        sb.AppendLine("         'N' ");
                        sb.AppendLine("         ) ");
                    }
                    else
                    {
                        sb.AppendLine("UPDATE dbo.CRM_Favorites SET ");
                        sb.AppendLine("         Name='" + Request["Name"] + "', ");
                        sb.AppendLine("         Url='" + Request["Url"] + "',");
                        sb.AppendLine("         Content='" + Request["Content"] + "', ");
                        sb.AppendLine("         PicUrl='" + Request["PicUrl"] + "', ");
                        sb.AppendLine("         IsShowPic='" + IsShowPic + "', ");
                        sb.AppendLine("         CategoryID='" + Request["Category_val"] + "', ");
                        sb.AppendLine("         OrderID='" + Request["OrderID"] + "', ");
                        sb.AppendLine("         EditEmpID='" + ticket.UserData + "',");
                        sb.AppendLine("         EditDate=GETDATE() ");
                        sb.AppendLine("WHERE ID='" + FavoritesID + "' ");

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
                    var FavoritesID = Request["cid"];
                    var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                    var ticket = FormsAuthentication.Decrypt(cookie.Value);
                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("UPDATE dbo.CRM_Favorites SET ");
                    sb.AppendLine("         IsDel='Y', ");
                    sb.AppendLine("         DelEmpID='" + ticket.UserData + "',");
                    sb.AppendLine("         DelDate=GETDATE() ");
                    sb.AppendLine("WHERE ID='" + FavoritesID + "' ");

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
            else if (cmd == "public")
            {
                try
                {
                    var FavoritesID = Request["cid"];
                    var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                    var ticket = FormsAuthentication.Decrypt(cookie.Value);
                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("UPDATE dbo.CRM_Favorites SET ");
                    sb.AppendLine("         IsPublic='Y', ");
                    sb.AppendLine("         EditEmpID='" + ticket.UserData + "',");
                    sb.AppendLine("         EditDate=GETDATE() ");
                    sb.AppendLine("WHERE ID='" + FavoritesID + "' ");

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