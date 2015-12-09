using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using XHD.Common;
using System.Web.Security;

namespace XHD.CRM.Data
{
    /// <summary>
    /// CRM_CEStage 的摘要说明
    /// </summary>
    public class CRM_CEStageDetail : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.CRM_CEStageDetail ccpc = new BLL.CRM_CEStageDetail();
            Model.CRM_CEStageDetail model = new Model.CRM_CEStageDetail();

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
                string parentid = PageValidate.InputText(request["T_CEStage_id"], 50);
                model.StageID = int.Parse(parentid.Split('-')[0]);
                model.StageDetailID = int.Parse(PageValidate.InputText(request["T_CEStage_detail_id"], 50));
                model.Description = Common.PageValidate.InputText(request["T_CEStage_name"], 250);
                model.StageContent = PageValidate.InputText(request["T_content"], int.MaxValue);
                string id = PageValidate.InputText(request["pdetailid"], 50);
                //string pid = PageValidate.InputText(request["T_category_parent_val"], 50);
                if (!string.IsNullOrEmpty(id) && id != "null")
                {
                    //model.StageID = int.Parse(parentid);

                    //DataSet ds = ccpc.GetList(" id=" + int.Parse(parentid));
                    //DataRow dr = ds.Tables[0].Rows[0];

                    //if (int.Parse(id) == int.Parse(pid))
                    //{
                    //    context.Response.Write("false:type");
                    //}
                    //else
                    //{
                        ccpc.Update(model);


                //        //日志
                //        C_Sys_log log = new C_Sys_log();

                //        int UserID = emp_id;
                //        string UserName = empname;
                //        string IPStreet = request.UserHostAddress;
                //        string EventTitle = model.CEStageDetail_category;
                //        string EventType = "产品类别修改";
                //        int EventID = model.id;
                //        if (dr["CEStageDetail_category"].ToString() != request["T_category_name"])
                //        {
                //            log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "产品类别", dr["CEStageDetail_category"].ToString(), request["T_category_name"]);
                //        }
                //        if (dr["CEStageDetail_icon"].ToString() != request["T_category_icon"])
                //        {
                //            log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "类别图标", dr["CEStageDetail_icon"].ToString(), request["T_category_icon"]);
                //        }
                //        if (dr["parentid"].ToString() != request["T_category_parent_val"])
                //        {
                //            log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "上级类别", dr["parentid"].ToString(), request["T_category_parent_val"]);
                //        }
                     //}
               }

                else
                {
                   // model. = 0;
                    ccpc.Add(model);
                }
            }
            if (request["Action"] == "getmaxdetailid")
            {
               // string dt = "";

                int detailid = ccpc.GetMaxDetailId(PageValidate.InputText(request["pid"],50));
                string josnstr = "{ 'detailid':"+detailid+"}";
                //{"status": 1, "sum": 9}
                context.Response.Write(josnstr);
            }
            if (request["Action"] == "grid")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " StageDetailID";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";

                if (!string.IsNullOrEmpty(request["categoryid"]))
                {
                    serchtxt += "  and StageID=" + PageValidate.InputText(request["categoryid"], 50);
                    //serchtxt += " and Delete_time >= '" + PageValidate.InputText(request["startdate_del"], 50) + "'";
                }
                //if (!string.IsNullOrEmpty(request["pdetailid"]))
                //{
                //    //DateTime enddate = DateTime.Parse(request["enddate_del"]);
                //    serchtxt += " and StageDetailID=" + PageValidate.InputText(request["pdetailid"], 50);
                //        //" and StageDetailID  <= '" + enddate.AddHours(23).AddMinutes(59).AddSeconds(59) + "'";
                //}
                //权限


                string dt = "";
                //DataSet ds = ccpc.GetListByPage(PageSize, PageIndex, serchtxt, sorttext);
                    DataSet ds = ccpc.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                
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
                string cdetailid = PageValidate.InputText(request["StageDetailID"], 50);
                string cid = PageValidate.InputText(request["StageID"], 50);
                string dt;
                if (PageValidate.IsNumber(cid) && PageValidate.IsNumber(cdetailid))
                {
                    DataSet ds = ccpc.GetList_Main(" StageID=" + cid + " AND StageDetailID=" + cdetailid);
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
                string c_id = PageValidate.InputText(request["stageid"], 50);
                string c_detail_id = PageValidate.InputText(request["stagedetailid"], 50);

                 DataSet ds = ccpc.GetList(" StageID=" + int.Parse(c_id) + " AND StageDetailID=" + int.Parse(c_detail_id));

                 BLL.Crm_CEDetail CEDetail = new BLL.Crm_CEDetail();
                 if (CEDetail.GetList(" id=" + int.Parse(c_id)).Tables[0].Rows.Count > 0)
                {
                    context.Response.Write("false:CEDetail");
                }
                 
                else
                {
                    bool isdel = ccpc.Delete(int.Parse(c_id),int.Parse(c_detail_id));
                    if (isdel)
                    {
                        //日志
                        string EventType = "明细删除";

                        int UserID = emp_id;
                        string UserName = empname;
                        string IPStreet = request.UserHostAddress;
                        int EventID = int.Parse(c_id);
                        string EventTitle = ds.Tables[0].Rows[0]["Description"].ToString();
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
                str.Append("{id:" + (int)row["id"] + ",text:'" + (string)row["CEStageDetail_category"] + "',d_icon:'../../" + (string)row["CEStageDetail_icon"] + "'");

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