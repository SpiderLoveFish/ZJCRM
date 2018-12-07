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
    public class CERep_Schedule : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.CERep_Schedule ccpc = new BLL.CERep_Schedule();
           //暂时用不上 
            Model.Crm_CEDetail_Version model = new Model.Crm_CEDetail_Version();

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
                string detailid = PageValidate.InputText(request["detailid"], 300);
                int pid = StringToInt(PageValidate.InputText(request["pid"], 50));
               int sid = StringToInt(PageValidate.InputText(request["sid"], 50));
               int vid = StringToInt(PageValidate.InputText(request["vid"], 50)); 
               
                string style = PageValidate.InputText(request["style"], 50);
                //model.Remarks = Common.PageValidate.InputText(request["T_remarks"], 250);
                if (detailid == "undefined"  )
                    detailid = "";



                if (style=="edit")
                {


                    ccpc.UpdateCrm_CEDetail_Version(style, sid, detailid, pid, vid);
                    

 
                }

                else if (style=="add")
                {
                    
                    ccpc.UpdateCrm_CEDetail_Version(style, sid, detailid,pid,vid);
                }
                ccpc.RunProcedureComputerSUM(sid,pid,vid);
            }
            if (request["Action"] == "getgridaaa")
            {

                string verid = request["vid"];
                string sid = request["sid"];
                string pid = request["pid"];
                string style = request["sty"];
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " StageDetailID";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";
                bool isexist = ccpc.Exists(StringToInt(sid), StringToInt(pid), StringToInt(verid));
             
                string sorttext = " " + sortname + " " + sortorder;
                string Total;
                string serchtxt = "1=1";
                //if (style=="add")
                //serchtxt += " and stageid=" + sid + " ";
                //else if (style == "edit")
                //    serchtxt += " and stageid=" + sid + "  and projectid=" + pid + " and version=" + verid + "";
               
                if(isexist)
                    serchtxt += " and stageid=" + sid + "  and projectid=" + pid + " and version=" + verid + "";
                else serchtxt += " and stageid=" + sid + " ";

                string dt = "";
                //if (style == "add")
                //{
                 if(!isexist)
                 {
                    DataSet ds = ccpc.GetListDetail(PageSize, PageIndex, serchtxt, sorttext, out Total);
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                }
                else //if (style == "edit")
                {
                    DataSet ds = ccpc.GetListCEDetail_VersionDetail(PageSize, PageIndex, serchtxt, sorttext, out Total);
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                }
                context.Response.Write(dt);
            }
            if (request["Action"] == "getprogrid")
            {
                string dt = "";
                string Total="";
                string IsPlan = request["IsPlan"]; 
                DataSet ds = ccpc.RunProcedureView_Schedule(IsPlan,out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
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
             


                string dt = "";
                BLL.CRM_CEStage cestage = new BLL.CRM_CEStage();
                DataSet ds = cestage.GetListDetail(PageSize, PageIndex, serchtxt, sorttext, out Total);
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                 
                context.Response.Write(dt);
            }

            if (request["Action"] == "getheadcol")
            {
                //string cid = PageValidate.InputText(request["cid"], 50);
                string dt;
                //if (PageValidate.IsNumber(cid))
                //{
                    DataSet ds = ccpc.GetListHeadCol("");
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], "10");
                    if (dt == "") dt = "{}";
                //}
                //else
                //{
                //    dt = "{}";
                //}

                context.Response.Write(dt);
            }

            if (request["Action"] == "form")
            {
                string cid = PageValidate.InputText(request["cid"], 50);
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
                string c_id = PageValidate.InputText(request["id"], 50);

                DataSet ds = ccpc.GetList(" id=" + int.Parse(c_id));
 
                    bool isdel = ccpc.Delete(int.Parse(c_id));
                    if (isdel)
                    {
                        //日志
                        string EventType = "施工项目删除";

                        int UserID = emp_id;
                        string UserName = empname;
                        string IPStreet = request.UserHostAddress;
                        int EventID = int.Parse(c_id);
                        string EventTitle = ds.Tables[0].Rows[0]["id"].ToString();
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
                //if (GetTasksString((int)row["id"], table).Length > 0)
                //{
                //    str.Append(",children:[");
                //    str.Append(GetTasksString((int)row["id"], table));
                //    str.Append("]},");
                //}
                //else
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
                str.Append("{id:" + (int)row["id"] + ",text:'" + (string)row["product_category"] + "',d_icon:'../../" + (string)row["product_icon"] + "'");

                //if (GetTreeString((int)row["id"], table).Length > 0)
                //{
                //    str.Append(",children:[");
                //    str.Append(GetTreeString((int)row["id"], table));
                //    str.Append("]},");
                //}
                //else
                {
                    str.Append("},");
                }
            }
            return str[str.Length - 1] == ',' ? str.ToString(0, str.Length - 1) : str.ToString();
        }

        private static bool StringToBool(string code)
        {
            try {
                return bool.Parse(code);
            }
            catch { return false; }
        }
        private static int StringToInt(string code)
        {
            try {
             return   int.Parse(code);
            }
            catch {

                return 0;
            }
        }
        private static decimal StringToDecimal(string code)
        {
            try
            {
                return decimal.Parse(code);
            }
            catch
            {

                return 0;
            }
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