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
    public partial class Repair_Add : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {  

            var cmd = Request["cmd"];
            if (cmd == "form")
            {
                try
                {
                    DataRow[] dr = Caches.CRM_Repair.Select("RepairID=" + Request["cid"].ToString());
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
                    DataRow[] dr = Caches.CRM_Customer.Select("tel='" + Request["tel"].ToString() + "'");
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
                    var RepairID = Request["cid"];
                    string emp_name = "NoVerer";
                  
                    var userid = "0";//无需验证 只能增加
                    try
                    {
                        var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                        var ticket = FormsAuthentication.Decrypt(cookie.Value);
                        userid = ticket.UserData;
                    }
                    catch {
                        DataSet dsNV = SqlDB.ExecuteDataSet("SELECT ID FROM  dbo.hr_employee WHERE uid='" + emp_name + "'").Output1;
                        if (dsNV.Tables[0].Rows.Count > 0)
                            userid = dsNV.Tables[0].Rows[0][0].ToString();
                        else {
                            Response.Write("系统没有免验证用户权限，请联系相关人员！");
                            return;
                        }
                        
                         }
                    var Khbh = Request["Khbh"];
                    var sb = new System.Text.StringBuilder();
                    if (string.IsNullOrWhiteSpace(RepairID) || RepairID == "null")
                    {
                        if (Khbh == "")
                            Khbh = "0";
                        sb.AppendLine("INSERT INTO dbo.CRM_Repair (Sfkh,Khbh,Khmc,Khdh,Khyx,Khdz,Khxq,Khxb,Wxrq,Wxsj,PicUrl,t_content,WxlbID,Wxyy,IsDel,InEmpID,InDate) ");
                        sb.AppendLine("VALUES  ('" + Request["Sfkh"].ToString() + "', ");
                        sb.AppendLine("         '" + Khbh + "', ");
                        sb.AppendLine("         '" + Request["Khmc"] + "', ");
                        sb.AppendLine("         '" + Request["Khdh"] + "', ");
                        sb.AppendLine("         '" + Request["Khyx"] + "', ");
                        sb.AppendLine("         '" + Request["Khdz"] + "', ");
                        sb.AppendLine("         '" + Request["Khxq"] + "', ");
                        sb.AppendLine("         '" + Request["Khxb"] + "', ");
                        sb.AppendLine("         '" + Request["Wxrq"] + "', ");
                        sb.AppendLine("         '" + Request["Wxsj"] + "', ");
                        sb.AppendLine("         '" + Request["PicUrl"] + "', ");
                        sb.AppendLine("         '" + Server.HtmlEncode(Request["t_content"]) + "', ");
                        sb.AppendLine("         '" + Request["Wxlb_val"] + "', ");
                        sb.AppendLine("         '" + Request["Wxyy"] + "', ");
                        sb.AppendLine("         'N', ");
                        sb.AppendLine("         '" + userid + "', ");
                        sb.AppendLine("         GETDATE()  ");
                        sb.AppendLine("         ) ");
                        sb.AppendLine("  insert INTO NoticeAlarm (NoticeContent,remarks) values('有新消息：维修类：客户姓名：" + Request["Khmc"] + ",地址：" + Request["Khxq"] +",维修原因："+ Request["Wxyy"] + ",联系方式：" + Request["Khdh"] + "，请尽快处理！','" + userid + "') ");
                    }
                    else
                    {
                        DataRow[] dr = Caches.CRM_Repair.Select("RepairID=" + RepairID);
                        if (dr[0]["Khmc"].ToString() != Request["Khmc"])
                        {
                            sb.AppendLine("INSERT INTO dbo.Sys_log (EventType,EventID,EventTitle,Original_txt,Current_txt,UserID,UserName,IPStreet,EventDate) ");
                            sb.AppendLine("SELECT '报修信息编辑','" + RepairID + "','" + Request["Khmc"] + "','【客户名称】" + dr[0]["Khmc"].ToString() + "','【客户名称】" + Request["Khmc"] + "',ID,Name,'" + Request.UserHostAddress + "',GETDATE() ");
                            sb.AppendLine("FROM dbo.hr_employee WHERE ID='" + userid + "'");
                        }
                        if (dr[0]["Khdh"].ToString() != Request["Khdh"])
                        {
                            sb.AppendLine("INSERT INTO dbo.Sys_log (EventType,EventID,EventTitle,Original_txt,Current_txt,UserID,UserName,IPStreet,EventDate) ");
                            sb.AppendLine("SELECT '报修信息编辑','" + RepairID + "','" + Request["Khdh"] + "','【客户电话】" + dr[0]["Khdh"].ToString() + "','【客户电话】" + Request["Khdh"] + "',ID,Name,'" + Request.UserHostAddress + "',GETDATE() ");
                            sb.AppendLine("FROM dbo.hr_employee WHERE ID='" + userid + "'");
                        }
                        if (dr[0]["Khyx"].ToString() != Request["Khyx"])
                        {
                            sb.AppendLine("INSERT INTO dbo.Sys_log (EventType,EventID,EventTitle,Original_txt,Current_txt,UserID,UserName,IPStreet,EventDate) ");
                            sb.AppendLine("SELECT '报修信息编辑','" + RepairID + "','" + Request["Khyx"] + "','【客户邮箱】" + dr[0]["Khyx"].ToString() + "','【客户邮箱】" + Request["Khyx"] + "',ID,Name,'" + Request.UserHostAddress + "',GETDATE() ");
                            sb.AppendLine("FROM dbo.hr_employee WHERE ID='" + userid + "'");
                        }
                        if (dr[0]["Khdz"].ToString() != Request["Khdz"])
                        {
                            sb.AppendLine("INSERT INTO dbo.Sys_log (EventType,EventID,EventTitle,Original_txt,Current_txt,UserID,UserName,IPStreet,EventDate) ");
                            sb.AppendLine("SELECT '报修信息编辑','" + RepairID + "','" + Request["Khdz"] + "','【客户地址】" + dr[0]["Khdz"].ToString() + "','【客户地址】" + Request["Khdz"] + "',ID,Name,'" + Request.UserHostAddress + "',GETDATE() ");
                            sb.AppendLine("FROM dbo.hr_employee WHERE ID='" + userid + "'");
                        }
                        if (dr[0]["Khxq"].ToString() != Request["Khxq"])
                        {

                            sb.AppendLine("INSERT INTO dbo.Sys_log (EventType,EventID,EventTitle,Original_txt,Current_txt,UserID,UserName,IPStreet,EventDate) ");
                            sb.AppendLine("SELECT '报修信息编辑','" + RepairID + "','" + Request["Khxq"] + "','【所在小区】" + dr[0]["Khxq"].ToString() + "','【所在小区】" + Request["Khxq"] + "',ID,Name,'" + Request.UserHostAddress + "',GETDATE() ");
                            sb.AppendLine("FROM dbo.hr_employee WHERE ID='" + userid + "'");
                        }
                        sb.AppendLine("UPDATE dbo.CRM_Repair SET ");
                        sb.AppendLine("         Sfkh='" + Request["Sfkh"] + "', ");
                        sb.AppendLine("         Khbh='" + Request["Khbh"] + "',");
                        sb.AppendLine("         Khmc='" + Request["Khmc"] + "', ");
                        sb.AppendLine("         Khdh='" + Request["Khdh"] + "', ");
                        sb.AppendLine("         Khyx='" + Request["Khyx"] + "', ");
                        sb.AppendLine("         Khdz='" + Request["Khdz"] + "', ");
                        sb.AppendLine("         Khxq='" + Request["Khxq"] + "', ");
                        sb.AppendLine("         Khxb='" + Request["Khxb"] + "', ");
                        sb.AppendLine("         Wxrq='" + Request["Wxrq"] + "', ");
                        sb.AppendLine("         Wxsj='" + Request["Wxsj"] + "', ");
                        sb.AppendLine("         PicUrl='" + Request["PicUrl"] + "', ");
                        sb.AppendLine("         t_content='" + Server.HtmlEncode(Request["t_content"]) + "', ");
                        sb.AppendLine("         WxlbID='" + Request["Wxlb_val"] + "', ");
                        sb.AppendLine("         Wxyy='" + Request["Wxyy"] + "', ");
                        sb.AppendLine("         EditEmpID='" + userid + "',");
                        sb.AppendLine("         EditDate=GETDATE() ");
                        sb.AppendLine("WHERE RepairID='" + RepairID + "' ");

                    }

                    var rv = SqlDB.ExecuteNoneQuery(sb.ToString());
                    if (!rv.Result)
                        Response.Write(rv.Message);
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
            else if (cmd == "del")
            {
                try
                {
                    var RepairID = Request["cid"];
                    var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                    var ticket = FormsAuthentication.Decrypt(cookie.Value);
                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("SELECT * FROM dbo.CRM_Repair_Follow ");
                    sb.AppendLine("WHERE RepairID='" + RepairID + "' AND IsDel='N' ");
                    var rv = SqlDB.ExecuteDataTable(sb.ToString());
                    if (!rv.Result)
                        Response.Write(rv.Message);
                    else
                    {
                        if (rv.Output1.Rows.Count > 0)
                        {
                            Response.Write("此维修单有未删除的跟进，不能删除！");
                            return;
                        }
                    }

                    sb.Clear();
                    sb.AppendLine("UPDATE dbo.CRM_Repair SET ");
                    sb.AppendLine("         IsDel='Y', ");
                    sb.AppendLine("         DelEmpID='" + ticket.UserData + "',");
                    sb.AppendLine("         DelDate=GETDATE() ");
                    sb.AppendLine("WHERE RepairID='" + RepairID + "' ");

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