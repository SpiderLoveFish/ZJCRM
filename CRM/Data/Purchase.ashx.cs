using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using XHD.Common;
using System.Web.Security;
using System.Data.OleDb;
using System.Data.SqlClient;

namespace XHD.CRM.Data
{
    /// <summary>
    /// 预算管理 的摘要说明
    /// </summary>
    public class Purchase : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.Purchase_Main bpm = new BLL.Purchase_Main();
            Model.Purchase_Main mpm = new Model.Purchase_Main();
            BLL.Purchase_Detail bpd = new BLL.Purchase_Detail();
            Model.Purchase_Detail mpd = new Model.Purchase_Detail();

            
            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();

            BLL.Sys_log log = new BLL.Sys_log();

            if (request["Action"] == "getmaxid")
            {
                string bid = bpm.GetMaxPurId();
                string josnstr = "{ 'pid':'" + bid + "','cly':'" + empname + "'}";
                //{"status": 1, "sum": 9}
                context.Response.Write(josnstr);
            }
            if (request["Action"] == "form")
            {
                string pid = PageValidate.InputText(request["pid"], 50);
                string dt;
                if (pid != "")
                {
                    DataSet ds = bpm.GetListdetail(" Purid='" + pid + "'");
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }

                context.Response.Write(dt);
            }
            if (request["Action"] == "gridselectgys")
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
                serchtxt += " and IsDel='N'";


                string dt = "";

                DataSet ds = bpm.GetCgGl_Gys_Main(PageSize, PageIndex, serchtxt, sorttext, out Total);
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
                    sortname = " isNode asc";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " ,purdate DESC ";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                if (!string.IsNullOrEmpty(request["khstext"]))
                    serchtxt += " and Customer like N'%" + PageValidate.InputText(request["khstext"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["dzstext"]))
                    serchtxt += " and address like N'%" + PageValidate.InputText(request["dzstext"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["dhstext"]))
                    serchtxt += " and tel like N'%" + PageValidate.InputText(request["dhstext"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["gystext"]))
                    serchtxt += " and supplier_name  like N'%" + PageValidate.InputText(request["gystext"], 255) + "%'";
          

                string apr=PageValidate.InputText(request["Apr"], 50);
                if (apr == "Y")
                    serchtxt += " AND isNode=1";
                else if(apr=="E")
                    serchtxt += " AND isNode in(0,1)";
                else if (apr == "YY")
                    serchtxt += " AND isNode=2";

                string dt = "";

                DataSet ds = bpm.GetPurchase_Main(PageSize, PageIndex, serchtxt, sorttext, out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }
            if (request["Action"] == "griddetail")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string pid = PageValidate.InputText(request["pid"], 50);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " Purid";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                //if (string.IsNullOrEmpty(pid))
                    serchtxt += " and Purid='"+pid+"'";
 

                string dt = "";

                DataSet ds = bpd.GetPurchase_Detail(PageSize, PageIndex, serchtxt, sorttext, out Total);
                 dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }
            if (request["Action"] == "gridstock")
            {
                string dt = "{}";
                
                    DataSet ds = bpm.GetListCklb("");
                    //dt ="{Rows:"+ Common.DataToJson.GetJson(ds)+",Total:"+ds.Tables[0].Rows.Count+"}";
                    dt = Common.DataToJson.GetJson(ds);

                context.Response.Write(dt);
            }
            if (request["Action"] == "tempgrid")
            {
                BLL.PurchaseList ccp = new BLL.PurchaseList();
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = "desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";

                if (!string.IsNullOrEmpty(request["stext"]))
                    serchtxt += " and product_name like N'%" + PageValidate.InputText(request["stext"], 255) + "%'";
                //if(uid!="admin")//非管理员
                if (!string.IsNullOrEmpty(request["cid"]))
                    serchtxt += " and customerid=" + PageValidate.InputText(request["cid"], 50) + "";
                
                //权限
                DataSet ds = ccp.GetTempList(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);
            }
            if (request["Action"] == "save")
            {

                string pid = PageValidate.InputText(request["T_Pid"], 50);
                 decimal  status = StringToDecimal(PageValidate.InputText(request["status"], 50));
                 string isgd = PageValidate.InputText(request["isgd"], 50);
                    string  date = PageValidate.InputText(request["T_cgrq"], 50);
                    string remark = PageValidate.InputText(request["remark"], 255);
                    //if (isgd == "on" || isgd == "true")
                    //    isgd = "1";
                    //else isgd = "0";
                    if (bpm.updateremarks(pid, remark, date, isgd))
                if(bpm.updatetotal(pid,status)>0)
                   context.Response.Write("true");
               else
                {
                    context.Response.Write("false");
                }
            }
            if (request["Action"] == "savetemp")
            {

                string customerid = PageValidate.InputText(request["cid"], 50);
                string pid = PageValidate.InputText(request["pid"], 50);
                string supid = PageValidate.InputText(request["supid"], 50);
                string remark = PageValidate.InputText(request["remark"], 255);
                string isgd = PageValidate.InputText(request["isgd"], 50);
                if (bpm.Add(pid, supid, empname, customerid, remark, isgd))
                {
                    log.add_trace(pid,"0","保存",empname);
                    context.Response.Write("true");
                }
                else
                {
                    context.Response.Write("false");
                }
            }
            if (request["Action"] == "saveupdatestatus")
            {

                string pid = PageValidate.InputText(request["pid"], 50);
                  string status =  PageValidate.InputText(request["status"], 50) ;
                  if (bpm.Updatestatus(pid, status))
                  {
                      log.add_trace(pid, status, "", empname);
                      context.Response.Write("true");
                  }
                  else
                  {
                      context.Response.Write("false");
                  }
            }
            if (request["Action"] == "savestock")
            {

                string pid = PageValidate.InputText(request["pid"], 50);
                string stockid = PageValidate.InputText(request["stockid"], 50);
                string mid = PageValidate.InputText(request["mid"], 50);
                if (bpd.Updatestock(pid, mid, stockid))
                {
                    //log.add_trace(pid, status, "", empname);
                    context.Response.Write("true");
                }
                else
                {
                    context.Response.Write("false");
                }
            }
            if (request["Action"] == "savedetail")
            {

              
                string pid = PageValidate.InputText(request["pid"], 50);
                string bjlist = PageValidate.InputText(request["bjlist"], 255);
                 if (bjlist.Length > 1) bjlist = bjlist.Substring(1);
                 bpd.Addlist( pid, bjlist);
            }

            if (request["Action"] == "saveupdatedetail")
            {

              
                string pid = PageValidate.InputText(request["pid"], 50);
                string mid = PageValidate.InputText(request["mid"], 50);
                decimal price = StringToDecimal(PageValidate.InputText(request["price"], 50) );
                decimal editsum = StringToDecimal(PageValidate.InputText(request["editsum"], 50));
                string remarks = PageValidate.InputText(request["remaks"], 255);
                if (bpd.Updatedetail(pid, mid, price, editsum, remarks))
                    context.Response.Write("true");
                else
                {
                    context.Response.Write("false");
                }

            }
            //删除条件
            if (request["Action"] == "del")
            {
                string bid = PageValidate.InputText(request["pid"], 50);
                if (bpm.Delete(bid))
                {
                    if (bpd.Delete(bid, ""))
                    {
                        log.add_trace(bid, "99", "删除", empname);
                        context.Response.Write("true");
                    }
                    else context.Response.Write("false");
                }
                else
                {
                    context.Response.Write("false");
                }
            }
            //删除条件
            if (request["Action"] == "deldetail")
            {
                string bid = PageValidate.InputText(request["pid"], 50);
                string mid = PageValidate.InputText(request["mid"], 50);
                if (bpd.Delete(bid,mid))
                {
                     
                        context.Response.Write("true");
                    
                }
                else
                {
                    context.Response.Write("false");
                }
            }
        }

        private static string GetTreeString(int Id, DataTable table)
        {
            DataRow[] rows = table.Select(string.Format("parentid={0}", Id));

            if (rows.Length == 0) return string.Empty;
            StringBuilder str = new StringBuilder();

            foreach (DataRow row in rows)
            {
                str.Append("{id:" + (int)row["id"] + ",text:'" + (string)row["BP_Name"] + "',d_icon:''");

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
     
        public string urlstr(string url)
        {
            if (!string.IsNullOrEmpty(url))
            {
                string a = url.Replace("http://", "").Replace("ftp://", "");
                string b = a.Split('/')[0];
                string[] c = b.Split('.');
                string d = c.ToString();
                if (c.Length >= 3)
                {
                    if (c[c.Length - 2] == "com" && c[c.Length - 1] == "cn")
                        d = c[c.Length - 3] + c[c.Length - 2] + "." + c[c.Length - 1];
                    else
                        d = c[c.Length - 2] + "." + c[c.Length - 1];
                }

                return d;
            }
            else
            {
                return "";
            }
        }

        private string DataAuth(string uid)
        {
            //权限
            BLL.hr_employee emp = new BLL.hr_employee();
            DataSet dsemp = emp.GetList("ID=" + int.Parse(uid));

            string returntxt = " and 1=1";
            if (dsemp.Tables[0].Rows.Count > 0)
            {
                if (dsemp.Tables[0].Rows[0]["uid"].ToString() != "admin")
                {
                    Data.GetDataAuth dataauth = new Data.GetDataAuth();
                    string txt = dataauth.GetDataAuthByid("1", "Sys_view", uid);

                    string[] arr = txt.Split(':');

                    switch (arr[0])
                    {
                        case "none": returntxt = " and 1=2 ";
                            break;
                        case "my":
                            returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or Create_id=" + int.Parse(arr[1]) + ")";
                            break;
                        case "dep":
                            if (string.IsNullOrEmpty(arr[1]))
                                returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(uid) + " or Emp_id_sg=" + int.Parse(uid) + " or Emp_id_sj=" + int.Parse(uid) + " or Create_id=" + int.Parse(uid) + ")";
                            else
                                returntxt = " and ( privatecustomer='公客' or Department_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or Create_id=" + int.Parse(uid) + ")";
                            break;
                        case "depall":
                            BLL.hr_department dep = new BLL.hr_department();
                            DataSet ds = dep.GetAllList();
                            string deptask = GetDepTask(int.Parse(arr[1]), ds.Tables[0]);
                            string intext = arr[1] + "," + deptask;

                            returntxt = " and ( privatecustomer='公客' or Create_id=" + int.Parse(uid) + "  or Department_id in (" + intext.TrimEnd(',') + ") or Dpt_id_sg in (" + intext.TrimEnd(',') + ") or Dpt_id_sj in (" + intext.TrimEnd(',') + "))";
                            //or Create_id=32 or Department_id in (" + intext.TrimEnd(',') + " or Dpt_id_sg in (" + intext.TrimEnd(',') + " or Dpt_id_sj in (" + intext.TrimEnd(',') + ")
                            break;
                    }
                }
            }
            return returntxt;
        }
        private static string GetDepTask(int Id, DataTable table)
        {
            DataRow[] rows = table.Select("parentid=" + Id.ToString());

            if (rows.Length == 0) return string.Empty; ;
            StringBuilder str = new StringBuilder();

            foreach (DataRow row in rows)
            {
                str.Append(row["id"] + ",");
                if (GetDepTask((int)row["id"], table).Length > 0)
                    str.Append(GetDepTask((int)row["id"], table));
            }
            return str.ToString();
        }

        private static bool StringToBool(string code)
        {
            try
            {
                return bool.Parse(code);
            }
            catch { return false; }
        }
        private static int StringToInt(string code)
        {
            try
            {
                return int.Parse(code);
            }
            catch
            {

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