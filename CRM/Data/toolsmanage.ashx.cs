using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using XHD.Common;
using System.Web.Security;
using System.Web.Script.Serialization;

namespace XHD.CRM.Data
{
    /// <summary>
    /// CRM_CEStage 的摘要说明
    /// </summary>
    public class toolsmanage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.tools_use ccpc = new BLL.tools_use();
            Model.tools_use model = new Model.tools_use();
            BLL.tools_use_mx ccpc_mx = new BLL.tools_use_mx();
            Model.tools_use_mx model_mx = new Model.tools_use_mx();
            BLL.Financial_Change_Cost ffc = new BLL.Financial_Change_Cost();

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();

            if (request["Action"] == "testmd5")
            {
                string a="sdfaadsasdasd";
                string b=MD5(a);
                context.Response.Write(b);//90d456d96750985a93508334924bb719
            }

            if (request["Action"] == "save")
            {
                model.borrowers = PageValidate.InputText(request["T_borrowers"], 100);
                model.borrowersid = StringToInt(PageValidate.InputText(request["T_borrowersid"], 50));
                model.begintime = StringToDate(PageValidate.InputText(request["T_begintime"], 100));
                model.endtime = StringToDate(PageValidate.InputText(request["T_endtime"], 100));
                model.remarks = PageValidate.InputText(request["T_remarks"], 100);
                string toolsid =PageValidate.InputText(request["T_tools"], 100);
 
                string xmid = PageValidate.InputText(request["id"], 50);
              //  model.isstatus = "Y";
                if (!string.IsNullOrEmpty(xmid) && xmid != "null")
                {
                    model.toolsid = toolsid;
                    //if (ccpc.Exists_Budge_Para_Ver(int.Parse(xmid)))
                    //{
                    //    context.Response.Write("false:exist");
                    //}
                    //else
                    {
                        model.id = StringToInt(xmid);
                        ccpc.Update(model);
                    }
                }
                else
                {
                    model.isstatus = "0";//待审核
                    toolsid = ffc.GetMaxID("Tools");
                    model.toolsid = toolsid;
                    model.dotime = DateTime.Now;
                    ccpc.Add(model);
                }

                string json = request["PostData"].ToLower();
                JavaScriptSerializer js = new JavaScriptSerializer();
                ccpc_mx.Delete(toolsid);
                PostData[] postdata;
                postdata = js.Deserialize<PostData[]>(json);
                for (int i = 0; i < postdata.Length; i++)
                {
                    model_mx.id = StringToInt(xmid);
                    model_mx.toolsid = toolsid;
                    model_mx.productid = postdata[i].productid;
                    model_mx.productname = postdata[i].productname;
                    model_mx.productnumber = postdata[i].productnumber;
                   // model_mx.remarks = postdata[i].remarks;
                    ccpc_mx.Add(model_mx);

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
                    sortorder = " ASC";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";

                if (!string.IsNullOrEmpty(request["isstatus"]))
                    serchtxt += " and isstatus ='" +  request["isstatus"]+"'" ;
                string Apr = request["Apr"];
                if (!string.IsNullOrEmpty(Apr))
                    if (Apr == "Y")
                        serchtxt += " and IsStatus='0'";
                string dt = "";

                DataSet ds = ccpc.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                 
                context.Response.Write(dt);
            }
            if (request["Action"] == "gridmx")
            {

                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " ASC";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";

                if (!string.IsNullOrEmpty(request["isstatus"]))
                    serchtxt += " and isstatus ='" + request["isstatus"] + "'";
                if (!string.IsNullOrEmpty(request["toolsid"]))
                    serchtxt += " and toolsid ='" + request["toolsid"] + "'";
                else serchtxt += " and 1=2";

                string dt = "";

                DataSet ds = ccpc_mx.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }

            if (request["Action"] == "formgrid")
            {
                //string cid = PageValidate.InputText(request["xmid"], 50);
                string dt;
                //if (PageValidate.IsNumber(cid))
                //{
                    DataSet ds = ccpc.GetList("1=1");
                if(ds==null)
                {
                    dt = "{}";
                   
                }
                else
                {
                    dt = Common.DataToJson.DataToJSON_nomal(ds);
                }

                context.Response.Write("["+dt+"]");
            }
            
            if (request["Action"] == "form")
            {
                string cid = PageValidate.InputText(request["id"], 50);
                string dt;
                if (PageValidate.IsNumber(cid))
                {
                    DataSet ds = ccpc.GetList(" id=" + cid);
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }

                context.Response.Write(dt);
            }
            if (request["Action"] == "StartStop")
            {
                string id = PageValidate.InputText(request["id"], 50);
                string SFSH = PageValidate.InputText(request["sfapr"], 50);
                //var carstatus = "Y";
                //if (SFSH == "Y") carstatus = "N";
                if (ccpc.UpdateStatus(id,SFSH))
                    context.Response.Write("true");
                else context.Response.Write("false");
            }
            //del
            if (request["Action"] == "del")
            {
                //参数安全过滤
                string c_id = PageValidate.InputText(request["id"], 50);

                //DataSet ds = ccpc.GetList(" id=" + int.Parse(c_id));
                //if (ccpc.Exists_IsUse(int.Parse(c_id)))
                //{
                //    context.Response.Write("false:exist");
                //}
                //else
                {
                    bool isdel = ccpc.Delete(int.Parse(c_id));
                    if (isdel)
                    {
                        //日志
                        string EventType = "部件删除";

                        int UserID = emp_id;
                        string UserName = empname;
                        string IPStreet = request.UserHostAddress;
                        int EventID = int.Parse(c_id);
                        string EventTitle = c_id;// ds.Tables[0].Rows[0]["id"].ToString();
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

             public class PostData
        {
            #region Model
            private int _id;
            private string _toolsid;
            private int? _productid;
            private string _productname;
            private int? _productnumber;
            private string _remarks;
            /// <summary>
            /// 
            /// </summary>
            public int id
            {
                set { _id = value; }
                get { return _id; }
            }
            /// <summary>
            /// 
            /// </summary>
            public string toolsid
            {
                set { _toolsid = value; }
                get { return _toolsid; }
            }
            /// <summary>
            /// 
            /// </summary>
            public int? productid
            {
                set { _productid = value; }
                get { return _productid; }
            }
            /// <summary>
            /// 
            /// </summary>
            public string productname
            {
                set { _productname = value; }
                get { return _productname; }
            }
            /// <summary>
            /// 
            /// </summary>
            public int? productnumber
            {
                set { _productnumber = value; }
                get { return _productnumber; }
            }
            /// <summary>
            /// 
            /// </summary>
            public string remarks
            {
                set { _remarks = value; }
                get { return _remarks; }
            }
            #endregion Model

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
        private static DateTime StringToDate(string code)
        {
            try
            {
                return DateTime.Parse(code);
            }
            catch
            {

                return DateTime.Parse("1900-01-01");
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

        private static string MD5(string input)
        {
            string b = FormsAuthentication.HashPasswordForStoringInConfigFile(input, "MD5");

            return b;
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