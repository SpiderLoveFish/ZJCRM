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
    /// CRM_product 的摘要说明
    /// </summary>
    public class CRM_product : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.CRM_product ccp = new BLL.CRM_product();
            Model.CRM_product model = new Model.CRM_product();

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
         
                model.category_id = int.Parse(request["T_product_category_val"]);
                model.category_name = PageValidate.InputText(request["T_product_category"], 255);
                model.product_name = PageValidate.InputText(request["T_product_name"], 255);
                model.specifications = PageValidate.InputText(request["T_specifications"], 255);
                model.unit = PageValidate.InputText(request["T_product_unit"], 255);
                model.remarks = PageValidate.InputText(request["T_remarks"], 255);
                model.url = PageValidate.InputText(request["T_url"], 255);
                model.t_content = PageValidate.InputText(request["T_content"], int.MaxValue);
                model.price = decimal.Parse(request["T_price"].ToString());
                model.nbj = decimal.Parse(request["T_nbj"].ToString());
                model.xh = PageValidate.InputText(request["T_xh"], 255);
                model.xl = PageValidate.InputText(request["T_xl"], 255);
                model.gys = PageValidate.InputText(request["T_gys"], 255);
                model.zt = PageValidate.InputText(request["T_zt"], 255);
                model.pp = PageValidate.InputText(request["T_pp"], 255);
               // model.C_code = PageValidate.InputText(request["C_code"], 255);
                //---
                string c_code = "";
                try
                {
                    DataSet dscode = ccp.Get_code(int.Parse(request["T_product_category_val"]));
                    if (dscode.Tables[0].Rows.Count > 0)
                    {
                        if (dscode.Tables[0].Rows[0][1].ToString() == "")
                        {
                            if (dscode.Tables[0].Rows[0][0].ToString() != "")
                            {
                                c_code = dscode.Tables[0].Rows[0][0].ToString() + "0001";
                            }
                        }
                        else
                        {
                            //已经有的就不再改了
                            if (PageValidate.InputText(request["C_code"], 255) == "")
                            {
                                int lsh = int.Parse(dscode.Tables[0].Rows[0][1].ToString().Substring(4, 4)) + 1;
                                c_code = dscode.Tables[0].Rows[0][0].ToString() + lsh.ToString("0000");
                            }
                        }
                    }
                }
                catch { c_code = PageValidate.InputText(request["C_code"], 255); }
                //已经有的就不再改了
                if (PageValidate.InputText(request["C_code"], 255) == "")
                {
                    model.C_code = c_code;
                }

                //---
                string style = PageValidate.InputText(request["style"], 50);
                 if (!string.IsNullOrEmpty(style) && style != "null")
                 {
                     if (style == "0") model.C_style = "主材";
                     else if (style == "1") model.C_style = "基建";
                 }
                string pid = PageValidate.InputText(request["pid"], 50);
                if (!string.IsNullOrEmpty(pid) && pid != "null")
                {
                    model.product_id = int.Parse(PageValidate.IsNumber(pid) ? pid : "-1");
                    DataSet ds = ccp.GetList(" product_id=" + int.Parse(pid));
                    DataRow dr = ds.Tables[0].Rows[0];
                    ccp.Update(model);

                    //日志
                    C_Sys_log log = new C_Sys_log();

                    int UserID = emp_id;
                    string UserName = empname;
                    string IPStreet = request.UserHostAddress;
                    string EventTitle = model.product_name;
                    string EventType = "产品修改";
                    int EventID = model.product_id;
                    if (dr["category_name"].ToString() != request["T_product_category"])
                    {
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "产品类别", dr["category_name"].ToString(), request["T_product_category"]);
                    }
                    if (dr["product_name"].ToString() != request["T_product_name"])
                    {
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "产品名字", dr["product_name"].ToString(), request["T_product_name"]);
                    }
                    if (dr["specifications"].ToString() != request["T_specifications"])
                    {
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "产品规格", dr["specifications"].ToString(), request["T_specifications"]);
                    }
                    if (dr["unit"].ToString() != request["T_product_unit"])
                    {
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "单位", dr["unit"].ToString(), request["T_product_unit"]);
                    }
                    if (dr["remarks"].ToString() != request["T_remarks"])
                    {
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "备注", dr["remarks"].ToString(), request["T_remarks"]);
                    }
                    if (dr["price"].ToString() != request["T_price"])
                    {
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "价格", dr["price"].ToString(), request["T_price"]);
                    }
                    if (dr["InternalPrice"].ToString() != request["T_nbj"])
                    {
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "内部价", dr["InternalPrice"].ToString(), request["T_nbj"]);
                    }
                    if (dr["Suppliers"].ToString() != request["T_gys"])
                    {
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "供应商", dr["Suppliers"].ToString(), request["T_gys"]);
                    }
                    if (dr["ProModel"].ToString() != request["T_xh"])
                    {
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "型号", dr["ProModel"].ToString(), request["T_xh"]);
                    }
                    if (dr["ProSeries"].ToString() != request["T_xl"])
                    {
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "系列", dr["ProSeries"].ToString(), request["T_xl"]);
                    }
                    if (dr["Themes"].ToString() != request["T_zt"])
                    {
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "主题", dr["Themes"].ToString(), request["T_zt"]);
                    }
                    if (dr["Brand"].ToString() != request["T_pp"])
                    {
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "品牌", dr["Brand"].ToString(), request["T_pp"]);
                    }
                    if (dr["C_code"].ToString() != request["C_code"])
                    {
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "物料代码", dr["C_code"].ToString(), request["C_code"]);
                    }
                }
                else
                {
                    
                    model.isDelete = 0;
                    ccp.Add(model);
                    //基地选材的时候，自动增加
                    string AddType = PageValidate.InputText(request["AddType"], 50);
                    if (!string.IsNullOrEmpty(AddType) && AddType != "null")
                    {
                        if (AddType == "SelectMat")//工地选材
                        {
                            BLL.PurchaseList pl = new BLL.PurchaseList();
                            int customerid = int.Parse(request["cid"]);
                            string pro_id = ccp.GetList(" c_code='" + c_code + "'").Tables[0].Rows[0]["product_id"].ToString(); 
                            //  if (pid.Length > 1) pid = pid.Substring(1);
                            pl.InsertList(customerid, pro_id, emp_id.ToString(),"ALL");

                        }
                        else if (AddType == "Selectpur")//采购
                            {
                                BLL.Purchase_Detail pl = new BLL.Purchase_Detail();
                                string bpid = PageValidate.InputText(request["bid"], 50);
                                string pro_id = ccp.GetList(" c_code='" + c_code + "'").Tables[0].Rows[0]["product_id"].ToString();
                                //  if (pid.Length > 1) pid = pid.Substring(1);
                                pl.Addlist(bpid, pro_id);
                            }
                        else if (AddType == "Selectbudge")//预算
                        {

                            BLL.Budge_BasicDetail bbd = new BLL.Budge_BasicDetail();
                            string bbid = PageValidate.InputText(request["bid"], 50);
                            string comp = PageValidate.InputText(request["compname"], 250);  //部件
                            string pro_id = ccp.GetList(" c_code='" + c_code + "'").Tables[0].Rows[0]["product_id"].ToString();
                            //  if (pid.Length > 1) pid = pid.Substring(1);
                            bbd.insertlist(bbid, pro_id, comp);

                           

                        }
                        else if (AddType == "Selectpick")//领料
                        {
                            BLL.OutStock_Detail OSD = new BLL.OutStock_Detail();
                            string CKID = PageValidate.InputText(request["pid"], 50); 
                            string pro_id = ccp.GetList(" c_code='" + c_code + "'").Tables[0].Rows[0]["product_id"].ToString();
                            //  if (pid.Length > 1) pid = pid.Substring(1);
                            OSD.Addlist(CKID,pro_id);

                        }
                    }
                }
            }

            if (request["Action"] == "IsExistCode")
            {
                string code = PageValidate.InputText(request["C_code"], 255);
                DataSet codeds = ccp.GetList(" C_code='" + code + "' and product_id!=" + PageValidate.InputText(request["pid"], 50));
                if (codeds.Tables[0].Rows.Count > 0)
                {
                    context.Response.Write("false:code");
                   
                }
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
                int pid = int.Parse(request["pid"]);
                DataSet ds = ccp.GetList(" product_id=" + pid);

                string dt = Common.DataToJson.DataToJSON(ds);

                context.Response.Write(dt);
            }
            //del
            if (request["Action"] == "del")
            {
                //参数安全过滤
                string c_id = PageValidate.InputText(request["id"], 50);
                DataSet ds = ccp.GetList(" product_id=" + int.Parse(c_id));

                BLL.CRM_order_details ccod = new BLL.CRM_order_details();
                if (ccod.GetList("product_id=" + int.Parse(c_id)).Tables[0].Rows.Count > 0)
                {
                    //order
                    context.Response.Write("false:order");
                }
                else
                {
                    bool isdel = ccp.Delete(int.Parse(c_id));
                    if (isdel)
                    {
                        //日志
                        string EventType = "产品删除";

                        int UserID = emp_id;
                        string UserName = empname;
                        string IPStreet = request.UserHostAddress;
                        int EventID = int.Parse(c_id);
                        string EventTitle = ds.Tables[0].Rows[0]["product_name"].ToString();
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

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}