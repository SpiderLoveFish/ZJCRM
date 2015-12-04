using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Repair
{
    public partial class Repair_Follow_Add : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var cmd = Request["cmd"];
            if (cmd == "form")
            {
                try
                {
                    DataRow[] dr = Caches.CRM_Repair_Follow.Select("FollowID=" + Request["fid"]);
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
                    var FollowID = Request["fid"];
                    var RepairID = Request["rid"];
                    string emp_name = "NoVerer";

                    var userid = "0";//无需验证 只能增加
                    try
                    {
                        var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                        var ticket = FormsAuthentication.Decrypt(cookie.Value);
                        userid = ticket.UserData;
                    }
                    catch
                    {
                        DataSet dsNV = SqlDB.ExecuteDataSet("SELECT ID FROM  dbo.hr_employee WHERE uid='" + emp_name + "'").Output1;
                        if (dsNV.Tables[0].Rows.Count > 0)
                            userid = dsNV.Tables[0].Rows[0][0].ToString();
                        else
                        {
                            Response.Write("系统没有免验证用户权限，请联系相关人员！");
                            return;
                        }
                    }
                        var sb = new System.Text.StringBuilder();
                    if (string.IsNullOrWhiteSpace(FollowID) || FollowID == "null")
                    {
                        sb.AppendLine("UPDATE dbo.CRM_Repair_Follow SET IsLastIn='N' ");
                        sb.AppendLine("WHERE RepairID='" + RepairID + "' AND ISNULL(IsLastIn,'Y')='Y' ");
                        sb.AppendLine("INSERT INTO dbo.CRM_Repair_Follow (RepairID,FollowTypeID,FollowContent,IsDel,IsLastIn,InEmpID,InDate) ");
                        sb.AppendLine("VALUES  ('" + RepairID + "', ");
                        sb.AppendLine("         '" + Request["FollowType_val"] + "', ");
                        sb.AppendLine("         '" + Request["FollowContent"] + "', ");
                        sb.AppendLine("         'N', ");
                        sb.AppendLine("         'Y', ");
                        sb.AppendLine("         '" + userid + "', ");
                        sb.AppendLine("         GETDATE()  ");
                        sb.AppendLine("         ) ");
                    }
                    else
                    {
                        sb.AppendLine("UPDATE dbo.CRM_Repair_Follow SET IsLastEdit='N' ");
                        sb.AppendLine("WHERE RepairID='" + RepairID + "' AND ISNULL(IsLastEdit,'Y')='Y' ");
                        sb.AppendLine("UPDATE dbo.CRM_Repair_Follow SET ");
                        sb.AppendLine("         RepairID='" + RepairID + "', ");
                        sb.AppendLine("         FollowTypeID='" + Request["FollowType_val"] + "',");
                        sb.AppendLine("         FollowContent='" + Request["FollowContent"] + "', ");
                        sb.AppendLine("         IsLastEdit='Y', ");
                        sb.AppendLine("         EditEmpID='" + userid + "',");
                        sb.AppendLine("         EditDate=GETDATE() ");
                        sb.AppendLine("WHERE FollowID='" + FollowID + "' ");

                    }

                    var rv = SqlDB.ExecuteNoneQuery(sb.ToString());
                    if (!rv.Result)
                        Response.Write(rv.Message);
                    Caches.CRM_Repair_Follow = null;
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
                    sb.AppendLine("SELECT * FROM dbo.CRM_Repair ");
                    sb.AppendLine("WHERE RepairID='" + Request["rid"] + "' AND Wczt='完成' ");
                    var rv = SqlDB.ExecuteDataTable(sb.ToString());
                    if (!rv.Result)
                        Response.Write(rv.Message);
                    else
                    {
                        if (rv.Output1.Rows.Count > 0)
                        {
                            Response.Write("此跟进的维修单已处理完成，不能删除！");
                            return;
                        }
                    }
                    sb.Clear();
                    sb.AppendLine("UPDATE dbo.CRM_Repair_Follow SET ");
                    sb.AppendLine("         IsDel='Y', ");
                    sb.AppendLine("         DelEmpID='" + ticket.UserData + "',");
                    sb.AppendLine("         DelDate=GETDATE() ");
                    sb.AppendLine("WHERE FollowID='" + Request["fid"] + "' ");

                    var rv1 = SqlDB.ExecuteNoneQuery(sb.ToString());
                    if (!rv1.Result)
                        Response.Write(rv1.Message);
                    Caches.CRM_Repair_Follow = null;
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