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
    public class CE_Para : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.CE_Para ccpc = new BLL.CE_Para();
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
                string name = PageValidate.InputText(request["T_name"], 300);
                int px = StringToInt(PageValidate.InputText(request["T_px"], 50));
                string remarks = PageValidate.InputText(request["T_remarks"], 50);
                string color = PageValidate.InputText(request["T_color"], 50); 
                string id =  PageValidate.InputText(request["id"], 50) ;
                if (!string.IsNullOrEmpty(id) && id != "null")
                {
                    if(ccpc.Update(StringToInt(id),name,px,color.Replace("#",""),remarks))
                    context.Response.Write("{success:success}");
                    else
                        context.Response.Write("{false:false}");
                   

                }
                else
                {
                    int s = ccpc.Add(name, px, color.Replace("#", ""), remarks);
                    if(s==0)
                        context.Response.Write("{flase:flase}");
                        else
                    context.Response.Write("{success:success}");

                }
                 
            }
           
            if (request["Action"] == "grid")
            {
                
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " JDID";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
             


                string dt = "";
                
                DataSet ds = ccpc.GetListDetail(PageSize, PageIndex, serchtxt, sorttext, out Total);
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                 
                context.Response.Write(dt);
            }

            if (request["Action"] == "combojd")
            {
                DataSet ds = ccpc.GetList("  1=1");

                StringBuilder str = new StringBuilder();

                str.Append("[");
                //str.Append("{id:0,text:'无'},");
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    str.Append("{id:" + ds.Tables[0].Rows[i]["JDID"].ToString() + ",text:'" + ds.Tables[0].Rows[i]["JDMC"] + "',jdys:'" + ds.Tables[0].Rows[i]["JDYS"] + "'},");
                }
                str.Replace(",", "", str.Length - 1, 1);
                str.Append("]");

                context.Response.Write(str);
            }
            if (request["Action"] == "com_CRM_CE_CONFIG")
            {


                string STRWHERE = request["strwhere"];
                string where = "1=1";
                if (STRWHERE != "") where += " AND C_style='" + STRWHERE + "'";
                DataSet ds = ccpc.CRM_CE_CONFIG(where);


                StringBuilder str = new StringBuilder();

                str.Append("[");
                //str.Append("{id:0,text:'无'},");
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    str.Append("{id:" + ds.Tables[0].Rows[i]["ID"].ToString() + ",text:'" + ds.Tables[0].Rows[i]["C_Name"] + "',C_Value:'" + ds.Tables[0].Rows[i]["C_Value"] + "'},");
                }
                str.Replace(",", "", str.Length - 1, 1);
                str.Append("]");

                context.Response.Write(str);
            }
            if (request["Action"] == "form")
            {
                string cid = PageValidate.InputText(request["cid"], 50);
                string dt;
                if (PageValidate.IsNumber(cid))
                {
                    DataSet ds = ccpc.GetList("JDID=" + cid);
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

                DataSet ds = ccpc.GetList(" JDID=" + int.Parse(c_id));
                        BLL.KHJD_LIST_VIEW_LIST khjd = new BLL.KHJD_LIST_VIEW_LIST();
                       DataSet dskhjd= khjd.GetList(" JDID="+int.Parse(c_id));
                       if (dskhjd.Tables[0].Rows.Count > 0)
                           context.Response.Write("false:false");
                       else
                       {
                           bool isdel = ccpc.Delete(int.Parse(c_id));
                           if (isdel)
                           {

                               //日志
                               string EventType = "施工状态";

                               int UserID = emp_id;
                               string UserName = empname;
                               string IPStreet = request.UserHostAddress;
                               int EventID = int.Parse(c_id);
                               string EventTitle = ds.Tables[0].Rows[0]["JDID"].ToString();
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