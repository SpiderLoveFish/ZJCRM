using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using XHD.Common;
using System.Web.Security;
using XHD.DBUtility;

namespace XHD.CRM.Data
{
    /// <summary>
    /// CRM_product 的摘要说明
    /// </summary>
    public class PurchaseList : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.PurchaseList ccp = new BLL.PurchaseList();
            Model.PurchaseList model = new Model.PurchaseList();

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();

            if (request["Action"] == "savelist")
            {
                int customerid = int.Parse(request["cid"]);
                string pid = PageValidate.InputText(request["pid"], 255);
                string style = PageValidate.InputText(request["style"], 255);
                if (pid.Length > 1) pid = pid.Substring(1);

                StringBuilder sb = new StringBuilder();
                sb.AppendLine(" SELECT * FROM  dbo.PurchaseList WHERE CustomerID="+ customerid + "  ");
                sb.AppendLine(" AND	 product_id IN("+ pid + ")  ");
                object obj = DbHelperSQL.GetSingle(sb.ToString());
                if (Convert.ToInt32(obj) > 0)
                {
                    context.Response.Write("false");
                }
                else
                ccp.InsertList(customerid, pid, emp_id.ToString(),style);
            }
            if (request["Action"] == "save")
            {

                decimal AmountSum = decimal.Parse(request["editsum"]);
               int CustomerID = int.Parse(request["cid"]);
               // model.DoPerson = emp_id;
                model.DoTime = DateTime.Now;
                model.IsStatus = 0;
                //model.category_id = int.Parse(request["T_product_category_val"]);
              string id = PageValidate.InputText(request["id"], 50);
              if (!string.IsNullOrEmpty(id) && id != "null")
              {
                  if(ccp.UpdateSUM( AmountSum, emp_id, CustomerID,int.Parse(id)))
                      context.Response.Write("true");
                  else context.Response.Write("false");
              }
            }

            if (request["Action"] == "updatestatus")
            {

                int isstatus = int.Parse(request["isstatus"]);
                int CustomerID = int.Parse(request["cid"]);
                // model.DoPerson = emp_id;
                model.DoTime = DateTime.Now;
                model.IsStatus = 0;
                //model.category_id = int.Parse(request["T_product_category_val"]);
                string id = PageValidate.InputText(request["id"], 50);
                if (!string.IsNullOrEmpty(id) && id != "null")
                {
                    if (ccp.UpdateZT(isstatus, emp_id, CustomerID, int.Parse(id)))
                        context.Response.Write("true");
                    else context.Response.Write("flase");
                }
            }
            if (request["Action"] == "updateremarks")
            {

             
                int CustomerID = int.Parse(request["cid"]);
                string id = PageValidate.InputText(request["id"], 50);
                string SupplierName = PageValidate.InputText(request["T_gys"], 250);
               string t_content = PageValidate.InputText(request["T_content"], int.MaxValue);
                DateTime RequestDate = DateTime.Parse( PageValidate.InputText(request["RequestDate"], 50));
                string Sender = PageValidate.InputText(request["Sender"], 250);
                string ShippingMethod = PageValidate.InputText(request["ShippingMethod"], 50);
                string Receiver = PageValidate.InputText(request["Receiver"], 50);
                string b1 = PageValidate.InputText(request["b1"], 50); ;
                string b2 = PageValidate.InputText(request["b2"], 50); ;
                string b3 = PageValidate.InputText(request["b3"], 50); ;
                if (!string.IsNullOrEmpty(id) && id != "null")
                {
                    if (ccp.UpdateRemarks(SupplierName, t_content, CustomerID, int.Parse(id)
                        , RequestDate, Sender, ShippingMethod, Receiver, b1, b2, b3))
                        context.Response.Write("true");
                    else context.Response.Write("flase");
                }
            }

            if (request["Action"] == "allgrid")
            {
                BLL.CRM_product cp = new BLL.CRM_product();
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " category_id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = "desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1 and jbx in (1,2)";

                if (!string.IsNullOrEmpty(request["stext"]))
                {
                    serchtxt += " and (product_name like N'%" + PageValidate.InputText(request["stext"], 255) + "%' OR " +
                        " ProModel like N'%" + PageValidate.InputText(request["stext"], 255) + "%' OR " +
                          " ProSeries like N'%" + PageValidate.InputText(request["stext"], 255) + "%' OR " +
                           " Brand like N'%" + PageValidate.InputText(request["stext"], 255) + "%' OR " +
                              " b.C_code like N'%" + PageValidate.InputText(request["stext"], 255) + "%' )";
                        }
                    if (!string.IsNullOrEmpty(request["stextlx"]))
                {
                    if (request["stextlx"]!="全部")
                    serchtxt += " and b.product_category like N'%" + PageValidate.InputText(request["stextlx"], 255) + "%'";

                }
                if (!string.IsNullOrEmpty(request["stextpp"]))
                {
                    serchtxt += " and (product_name like N'%" + PageValidate.InputText(request["stextpp"], 255) + "%' OR " +
                        " ProModel like N'%" + PageValidate.InputText(request["stextpp"], 255) + "%' OR " +
                          " category_name like N'%" + PageValidate.InputText(request["stextpp"], 255) + "%' OR " +
                          " ProSeries like N'%" + PageValidate.InputText(request["stextpp"], 255) + "%' OR " +
                           " Brand like N'%" + PageValidate.InputText(request["stextpp"], 255) + "%' OR " +
                              " b.C_code like N'%" + PageValidate.InputText(request["stextpp"], 255) + "%' )";
                }

                serchtxt += " AND ISNULL(status,'')  NOT  LIKE '%Temp%' ";
                //权限
                DataSet ds = cp.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);
                 
                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);
            }
            if (request["Action"] == "allgridxc")
            {
                BLL.CRM_product cp = new BLL.CRM_product();
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " category_id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = "desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1 and jbx in (1,3)";

                if (!string.IsNullOrEmpty(request["stext"]))
                {
                    serchtxt += " and (product_name like N'%" + PageValidate.InputText(request["stext"], 255) + "%' OR " +
                        " ProModel like N'%" + PageValidate.InputText(request["stext"], 255) + "%' OR " +
                          " ProSeries like N'%" + PageValidate.InputText(request["stext"], 255) + "%' OR " +
                           " Brand like N'%" + PageValidate.InputText(request["stext"], 255) + "%' OR " +
                              " b.C_code like N'%" + PageValidate.InputText(request["stext"], 255) + "%' )";
                }
                if (!string.IsNullOrEmpty(request["stextlx"]))
                {
                    if (request["stextlx"] != "全部")
                        serchtxt += " and b.product_category like N'%" + PageValidate.InputText(request["stextlx"], 255) + "%'";

                }
                if (!string.IsNullOrEmpty(request["stextpp"]))
                {
                    serchtxt += " and (product_name like N'%" + PageValidate.InputText(request["stextpp"], 255) + "%' OR " +
                        " ProModel like N'%" + PageValidate.InputText(request["stextpp"], 255) + "%' OR " +
                         " b.c_code like N'%" + PageValidate.InputText(request["stextpp"], 255) + "%' OR " +
                           " b.product_category like N'%" + PageValidate.InputText(request["stextpp"], 255) + "%' OR " +
                          " ProSeries like N'%" + PageValidate.InputText(request["stextpp"], 255) + "%' OR " +
                           " Brand like N'%" + PageValidate.InputText(request["stextpp"], 255) + "%' OR " +
                              " b.C_code like N'%" + PageValidate.InputText(request["stextpp"], 255) + "%' )";
                }

                serchtxt += " AND ISNULL(status,'')  NOT  LIKE '%Temp%' ";
                //权限
                DataSet ds = cp.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);
            }

            if (request["Action"] == "ysgrid")
            {
                BLL.CRM_product cp = new BLL.CRM_product();
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " category_id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = "desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = " IsStatus=3 ";//必须生效
                if (!string.IsNullOrEmpty(request["cid"]))
                    serchtxt += " and customer_id='" + PageValidate.InputText(request["cid"], 50) + "'";
            

                if (!string.IsNullOrEmpty(request["stext"]))
                    serchtxt += " and product_name like N'%" + PageValidate.InputText(request["stext"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["stextlx"]))
                {
                    if (request["stextlx"] != "全部")
                        serchtxt += " and category_name like N'%" + PageValidate.InputText(request["stextlx"], 255) + "%'";

                }
                //权限
                DataSet ds = ccp.GetysList(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);
            }
            if (request["Action"] == "RefMaterialsListgrid")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string serchtxt = " 1=1 ";
                string sortorder = request["sortorder"];
                string sortname = request["sortname"];
                if (string.IsNullOrEmpty(sortname))
                    sortname = " Suppliers";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = "desc";

                string sorttext = "  " + sortname + " " + sortorder;
                if (!string.IsNullOrEmpty(request["stext"]))
                {
                    serchtxt += " and (product_name like N'%" + PageValidate.InputText(request["stext"], 255) + "%'" +
                        " or address  like N'%" + PageValidate.InputText(request["stext"], 255) + "%'" +
                 "  or Customer  like N'%" + PageValidate.InputText(request["stext"], 255) + "%'" +
                  " or category_name like N'%" + PageValidate.InputText(request["stext"], 255) + "%' " +
                 " or Suppliers like N'%" + PageValidate.InputText(request["stext"], 255) + "%' " +
                  " or name like N'%" + PageValidate.InputText(request["stext"], 255) + "%' " +
                  "  or  tel  like N'%" + PageValidate.InputText(request["stext"], 255) + "%' )";
                }
                if (!string.IsNullOrEmpty(request["stextb"]))
                {
                    serchtxt += " and (product_name like N'%" + PageValidate.InputText(request["stextb"], 255) + "%'" +
                        " or address  like N'%" + PageValidate.InputText(request["stextb"], 255) + "%'" +
                 "  or Customer  like N'%" + PageValidate.InputText(request["stextb"], 255) + "%'" +
                  " or category_name like N'%" + PageValidate.InputText(request["stextb"], 255) + "%' " +
                 " or Suppliers like N'%" + PageValidate.InputText(request["stextb"], 255) + "%' " +
                   " or name like N'%" + PageValidate.InputText(request["stextb"], 255) + "%' " +
                  "  or  tel  like N'%" + PageValidate.InputText(request["stextb"], 255) + "%' )";
                }
                if (!string.IsNullOrEmpty(request["stextc"]))
                {
                    serchtxt += " and (product_name like N'%" + PageValidate.InputText(request["stextc"], 255) + "%'" +
                        " or address  like N'%" + PageValidate.InputText(request["stextc"], 255) + "%'" +
                 "  or Customer  like N'%" + PageValidate.InputText(request["stextc"], 255) + "%'" +
                 " or category_name like N'%" + PageValidate.InputText(request["stextc"], 255) + "%' " +
                  " or Suppliers like N'%" + PageValidate.InputText(request["stextc"], 255) + "%' " +
                    " or name like N'%" + PageValidate.InputText(request["stextc"], 255) + "%' " +
                  "  or  tel  like N'%" + PageValidate.InputText(request["stextc"], 255) + "%' )";
                }
                if (!string.IsNullOrEmpty(request["bgtxt"]))
                {
                    serchtxt += " and DoTime >= '" + PageValidate.InputText(request["bgtxt"], 255) + "'";

                }
                if (!string.IsNullOrEmpty(request["endtxt"]))
                {
                    serchtxt += " and DoTime <= '" + PageValidate.InputText(request["endtxt"], 255) + "'";

                }
                string sectype = PageValidate.InputText(context.Request["sectype_val"], 50);
                if (!string.IsNullOrEmpty(sectype) && sectype != "null" && sectype != "99")
                    serchtxt += string.Format(" and  Isstatus IN({0})", sectype.Replace(';', ','));

               // serchtxt += " and DoPerson='" + emp_id + "'";
                //权限
                DataSet ds = ccp.GetRefMaterialsList(PageSize, PageIndex, serchtxt, sorttext);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], ds.Tables[0].Rows.Count.ToString());
                context.Response.Write(dt);
            }
            if (request["Action"] == "tempgrid")
            {
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
                //serchtxt += " and DoPerson='"+emp_id+"'";
                //权限
                DataSet ds = ccp.GetTempList(PageSize, PageIndex, serchtxt, sorttext, out Total);
             
                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);
            }
            if (request["Action"] == "grid")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " category_id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = "desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                if (!string.IsNullOrEmpty(request["categoryid"]))
                    serchtxt += string.Format(" and category_id={0}", int.Parse(request["categoryid"]));

                if (!string.IsNullOrEmpty(request["stext"]))
                    serchtxt += " and product_name like N'%" + PageValidate.InputText(request["stext"], 255) + "%'";

                //权限
                DataSet ds = ccp.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);
                if (!string.IsNullOrEmpty(request["type"]))
                    ds.Tables[0].Columns.Remove("t_content");
                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);
            }
            if (request["Action"] == "form")
            {
                int id = int.Parse(request["id"]);
                DataSet ds = ccp.GetList(" id=" + id);

                string dt = Common.DataToJson.DataToJSON(ds);

                context.Response.Write(dt);
            }
            //del
            if (request["Action"] == "del")
            {
                //参数安全过滤
                string c_id = PageValidate.InputText(request["id"], 50);
                DataSet ds = ccp.GetList(" id=" + int.Parse(c_id) + " and DoPerson='"+emp_id.ToString()+"'");
                // 当非编辑状态的时候
                if (ccp.GetList(" id=" + int.Parse(c_id) + " and IsStatus!=0").Tables[0].Rows.Count > 0)
                {
                    //order
                    context.Response.Write("false:order");
                }
                else
                {
                    bool isdel = ccp.Delete(int.Parse(c_id));
                    if (isdel)
                    {
                         
                        context.Response.Write("true");

                    }
                    else
                    {
                        context.Response.Write("false");
                    }
                }
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