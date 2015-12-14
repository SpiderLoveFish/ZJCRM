using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using XHD.Common;
using System.Web.Security;
using XHD.BLL;
using XHD.DAL;

namespace XHD.CRM.Data
{
    /// <summary>
    /// CRM_CEStage_category 的摘要说明
    /// </summary>
    public class CRM_CEStage_category : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.CRM_CEStage_category ccpc = new BLL.CRM_CEStage_category();
            Model.CRM_CEStage_category model = new Model.CRM_CEStage_category();

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();

            if (request["Action"] == "save")
            {
               // string parentid = PageValidate.InputText( request["T_category_parent_val"],50);
                model.parentid = 0;// int.Parse(parentid);
                model.CEStage_category = Common.PageValidate.InputText(request["T_category_name"], 250);
                model.CEStage_icon = Common.PageValidate.InputText(request["T_category_icon"], 250);
                model.TotalScorce = decimal.Parse( Common.PageValidate.InputText(request["T_category_totalscorce"], 250));

                string id = PageValidate.InputText( request["id"],50);
                string pid = "0"; //PageValidate.InputText(request["T_category_parent_val"], 50);
                if (!string.IsNullOrEmpty(id) && id != "null")
                {
                    model.id = int.Parse(id);

                    DataSet ds = ccpc.GetList(" id=" + int.Parse(id));
                    DataRow dr = ds.Tables[0].Rows[0];

                    if (int.Parse(id) == int.Parse(pid))
                    {
                        context.Response.Write("false:type");
                    }
                    else
                    {
                        ccpc.Update(model);


                        //日志
                        C_Sys_log log = new C_Sys_log();

                        int UserID = emp_id;
                        string UserName = empname;
                        string IPStreet = request.UserHostAddress;
                        string EventTitle = model.CEStage_category;
                        string EventType = "产品类别修改";
                        int EventID = model.id;
                        if (dr["CEStage_category"].ToString() != request["T_category_name"])
                        {
                            log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "产品类别", dr["CEStage_category"].ToString(), request["T_category_name"]);
                        }
                        if (dr["CEStage_icon"].ToString() != request["T_category_icon"])
                        {
                            log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "类别图标", dr["CEStage_icon"].ToString(), request["T_category_icon"]);
                        }
                        if (dr["TotalScorce"].ToString() != request["T_category_totalscorce"])
                        {
                            log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "总分", dr["TotalScorce"].ToString(), request["T_category_totalscorce"]);
                        }
                    }
                }

                else
                {
                    model.isDelete = 0;
                    ccpc.Add(model);
                }
            }

            if (request["Action"] == "grid")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                if (!string.IsNullOrEmpty(request["company"]))
                    serchtxt += " and CEStage_category like N'%" + PageValidate.InputText( request["company"],50) + "%'";

                if (!string.IsNullOrEmpty(request["startdate_del"]))
                {
                    serchtxt += " and Delete_time >= '" + PageValidate.InputText( request["startdate_del"],50) + "'";
                }
                if (!string.IsNullOrEmpty(request["enddate_del"]))
                {
                    DateTime enddate = DateTime.Parse(request["enddate_del"]);
                    serchtxt += " and Delete_time  <= '" + enddate.AddHours(23).AddMinutes(59).AddSeconds(59) + "'";
                }
                //权限
                

                string dt = "";
                if (request["grid"] == "tree")
                {
                    DataSet ds = ccpc.GetList(0, serchtxt, sorttext);
                    dt = "{Rows:[" + GetTasksString(0, ds.Tables[0]) + "]}";
                }
                else
                {  
                    DataSet ds = ccpc.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                }
                context.Response.Write(dt);
            }
            if (request["Action"] == "tree")
            {
                DataSet ds = ccpc.GetAllList();
                StringBuilder str = new StringBuilder();
                str.Append("[");
                str.Append(GetTreeString(0, ds.Tables[0]));
                str.Replace(",", "", str.Length - 1, 1);
                str.Append("]");
                context.Response.Write(str);
            }
            if (request["Action"] == "combo")
            {
                DataSet ds = ccpc.GetAllList();
                StringBuilder str = new StringBuilder();
                str.Append("[");
                str.Append("{id:0,text:'无',d_icon:''},");
                str.Append(GetTreeString(0, ds.Tables[0]));
                str.Replace(",", "", str.Length - 1, 1);
                str.Append("]");
                context.Response.Write(str);
            }
            if (request["Action"] == "form")
            {
                string cid = PageValidate.InputText(request["id"],50);
                string dt;
                if (PageValidate.IsNumber(cid))
                {
                    DataSet ds = ccpc.GetList("id=" + cid);
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }

                context.Response.Write(dt);
            }

            //del
            if (request["Action"] == "del")
            {
                //参数安全过滤
                string c_id = PageValidate.InputText( request["id"],50);

                DataSet ds = ccpc.GetList(" id=" + int.Parse(c_id));
                //xhd.BLL.CRM_CEStage CEStage = new xhd.BLL.CRM_CEStage();
                BLL.CRM_CEStageDetail CEStageDetail = new BLL.CRM_CEStageDetail();

                if (CEStageDetail.GetList(" StageID=" + int.Parse(c_id)).Tables[0].Rows.Count <= 0)
                {
                    context.Response.Write("false:CEStageDetail");
                }
                //else if(ccpc.GetList("parentid="+int.Parse(c_id)).Tables[0].Rows.Count>0){
                //    context.Response.Write("false:parent");
                //}
                else
                {
                    bool isdel = ccpc.Delete(int.Parse(c_id));
                    if (isdel)
                    {
                        //日志
                        string EventType = "类别删除";

                        int UserID = emp_id;
                        string UserName = empname;
                        string IPStreet = request.UserHostAddress;
                        int EventID = int.Parse(c_id);
                        string EventTitle = ds.Tables[0].Rows[0]["CEStage_category"].ToString();
                        string Original_txt = null;
                        string Current_txt = null;

                        C_Sys_log log = new C_Sys_log();

                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, null, Original_txt, Current_txt);

                        context.Response.Write("true");
                    }
                    else
                    {
                        context.Response.Write("false");
                    }
                }

            }           

        }
        private static string GetTasksString(int Id, DataTable table)
        {
            DataRow[] rows = table.Select("parentid=" + Id.ToString());

            if (rows.Length == 0) return string.Empty; ;
            StringBuilder str = new StringBuilder();

            foreach (DataRow row in rows)
            {
                str.Append("{");
                for (int i = 0; i < row.Table.Columns.Count; i++)
                {
                    if (i != 0) str.Append(",");
                    str.Append(row.Table.Columns[i].ColumnName);
                    str.Append(":'");
                    str.Append(row[i].ToString());
                    str.Append("'");
                }
                if (GetTasksString((int)row["id"], table).Length > 0)
                {
                    str.Append(",children:[");
                    str.Append(GetTasksString((int)row["id"], table));
                    str.Append("]},");
                }
                else
                {
                    str.Append("},");
                }
            }
            return str[str.Length - 1] == ',' ? str.ToString(0, str.Length - 1) : str.ToString();
        }
        private static string GetTreeString(int Id, DataTable table)
        {
            DataRow[] rows = table.Select(string.Format("parentid={0}", Id));

            if (rows.Length == 0) return string.Empty;
            StringBuilder str = new StringBuilder();

            foreach (DataRow row in rows)
            {
                str.Append("{id:" + (int)row["id"] + ",text:'" + (string)row["CEStage_category"] + "',d_icon:'../../" + (string)row["CEStage_icon"] + "'");

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
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}