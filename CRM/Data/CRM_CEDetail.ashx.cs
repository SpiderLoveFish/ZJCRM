using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using XHD.Common;
using System.Web.Security;
using XHD.DBUtility;
using System.Data.SqlClient;

namespace XHD.CRM.Data
{
    /// <summary>
    /// CRM_CEStage 的摘要说明
    /// </summary>
    public class CRM_CEDetail : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.Crm_CEDetail ccpc = new BLL.Crm_CEDetail();
            Model.Crm_CEDetail model = new Model.Crm_CEDetail();

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
                //string parentid = PageValidate.InputText(request["T_category_parent_val"], 50);
                //model.parentid = int.Parse(parentid);
                model.versions = StringToInt(Common.PageValidate.InputText(request["T_versions"], 50));
                model.AssTime = StringToInt(Common.PageValidate.InputText(request["T_AssTime"], 50));
                model.IsClose = StringToBool(Common.PageValidate.InputText(request["T_isclose"], 50));
                model.isChecked = StringToBool(Common.PageValidate.InputText(request["T_checked"], 50));
                model.AssDescription = Common.PageValidate.InputText(request["T_content"],  int.MaxValue);
                model.StageID = StringToInt(PageValidate.InputText(request["sid"], 50));
                model.projectid = StringToInt(PageValidate.InputText(request["pid"], 50));
                 string style = PageValidate.InputText(request["style"], 50);
                //model.Remarks = Common.PageValidate.InputText(request["T_remarks"], 250);
                if (style=="edit")
                {
                    //关键字没设置好。。。
                    int id = StringToInt(PageValidate.InputText(request["T_id"], 50));
                    model.id = id;

                    ccpc.Update(model);
                    
                }

                else if (style=="add")
                {
                    string serchtxt = "1=1";
                    serchtxt += " and      projectid=" + StringToInt(PageValidate.InputText(request["pid"], 50));
                    serchtxt += " and      StageID=" + StringToInt(PageValidate.InputText(request["sid"], 50));
                    serchtxt += " and      versions=" + StringToInt(PageValidate.InputText(request["vid"], 50));


                    DataSet dds = ccpc.GetList(serchtxt);
                    if (dds.Tables[0].Rows.Count > 0)
                    {
                        model.id =StringToInt(dds.Tables[0].Rows[0]["id"].ToString());
                        ccpc.Update(model);
                    }
                    else
                        ccpc.Add(model);
                }
            }
            //编辑状态下显示版本号
            if (request["Action"] == "combo")
            {
                string sid = PageValidate.InputText(request["sid"], 50);
                string pid = PageValidate.InputText(request["pid"], 50);
               // string parentid = PageValidate.InputText(request["parentid"], 50);

                DataSet ds = ccpc.GetList("   projectid=" + int.Parse(pid) + " and StageID=" + sid);

                StringBuilder str = new StringBuilder();

                str.Append("[");
                //str.Append("{id:0,text:'无'},");
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    str.Append("{id:" + ds.Tables[0].Rows[i]["versions"].ToString() + ",text:'" + ds.Tables[0].Rows[i]["versions"] + "'},");
                }
                str.Replace(",", "", str.Length - 1, 1);
                str.Append("]");

                context.Response.Write(str);
            }
            //专门显示下面隐藏的内容
            if (request["Action"] == "Acgrid")
            {


                string pid = request["pid"];
                
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
                serchtxt += " and      projectid=" + pid;
              


                string dt = "";

                DataSet ds = ccpc.GetListDetail(PageSize, PageIndex, serchtxt, sorttext, out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }
            if (request["Action"] == "getdetailgrid")
            {

                
                string sid = PageValidate.InputText(request["sid"],50);
                string pid = PageValidate.InputText(request["pid"],50);
                string vid = PageValidate.InputText(request["vid"], 50);
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                //int detailid = ccpc.GetMaxVerId(sid,pid,
                //    PageValidate.InputText(request["style"], 50)
                //    );

                string sorttext = " " + sortname + " " + sortorder;
                string Total;
                string serchtxt = "1=1";
                serchtxt += " and projectid=" + pid + "  AND	 StageID=" + sid;
                serchtxt += "  AND versions=" + vid;
                //  and isChecked=0 


                string dt = "";
                if (PageValidate.IsNumber(vid))
                // dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                {
                    DataSet ds = ccpc.GetListCrm_CEDetail(PageSize, PageIndex, serchtxt, sorttext, out Total);
                
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }
                context.Response.Write(dt);
            }
            if (request["Action"] == "getgrid")
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
                serchtxt += " and stage_icon!='结案' ";
                 serchtxt += " AND id NOT IN(SELECT projectid FROM	 crm_cedetail WHERE isclose=1) ";


                string dt = "";

                DataSet ds = ccpc.GetListStage(PageSize, PageIndex, serchtxt, sorttext, out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }
            if (request["Action"] == "getmaxverid")
            {
                // string dt = "";

                int detailid = ccpc.GetMaxVerId(PageValidate.InputText(request["sid"], 50),
                    PageValidate.InputText(request["pid"], 50),
                    PageValidate.InputText(request["style"], 50)
                    );
                string josnstr = "{ 'verid':" + detailid + "}";
                //{"status": 1, "sum": 9}
                context.Response.Write(josnstr);
            }
            //if (request["Action"] == "IsExistVer")
            //{
            //    // string dt = "";

            //    bool ischecked= ccpc.ExistsChecked(PageValidate.InputText(request["sid"], 50),
            //        PageValidate.InputText(request["pid"], 50),
            //        PageValidate.InputText(request["style"], 50)
            //        );
            //     if(ischecked==false)
            //    context.Response.Write("false");
            //     else context.Response.Write("true");
            //}
            if (request["Action"] == "getstage")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";
                int cid = StringToInt(request["cid"]);
                string sorttext = " " + sortname + " " + sortorder;
                string Total;
                string serchtxt = "1=1";
                serchtxt += " and stage_icon!='结案' ";
                //serchtxt += " AND id NOT IN(SELECT projectid FROM	 crm_cedetail WHERE isChecked=1 and id=" + cid + ") ";
                //还有个条件：必须上一个类别评分完毕

                string dt = "";

                DataSet ds = ccpc.GetListStage(PageSize, PageIndex, serchtxt, sorttext, out Total);
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
        /// <summary>
        /// 如果传入的是汉字，2个字为真，否为假
        /// 如果不是，则转bool，兼容0,1和多位汉字为假
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        private static bool StringToBool(string code)
        {
            try {
                if (code.Length == 2)
                    return true;
                else
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
        /// <summary>
        

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}