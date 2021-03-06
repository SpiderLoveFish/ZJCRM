﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using XHD.Common;
using System.Web.Security;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
namespace XHD.CRM.Data
{
    /// <summary>
    /// CRM_Customer 的摘要说明
    /// </summary>
    public class CRM_Customer : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.CRM_Customer customer = new BLL.CRM_Customer();
            Model.CRM_Customer model = new Model.CRM_Customer();

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();

            #region 动态图
            if (request["Action"] == "savedy")
            {
                string cid = PageValidate.InputText(request["cid"], 50);
                string dyname = PageValidate.InputText(request["T_name"], 255);
                string dyurl = PageValidate.InputText(request["T_url"], 255);
                string remarks = PageValidate.InputText(request["T_remarks"], 255);
                string id = PageValidate.InputText(request["id"], 50);
               

                if (!string.IsNullOrEmpty(id) && id != "null")
                {
                  
                        if (customer.Updatedy(int.Parse(id), int.Parse(cid), dyname, dyurl, remarks))
                            context.Response.Write("true");
                        else context.Response.Write("false");
                    
                }
                else
                {
                    if (customer.Adddy(int.Parse(cid), dyname, dyurl, remarks) > 0)
                        context.Response.Write("true");
                    else context.Response.Write("false");
                }
                // context.Response.Write(ct);
            }
            if (request.Params["Action"] == "deldy")
            {
                string id = PageValidate.InputText(request["id"], 50);
                string cid = PageValidate.InputText(request["cid"], 50);
                if(customer.Deletedy(int.Parse(id), int.Parse(cid)))
                    context.Response.Write("true");
                else context.Response.Write("false");
            }
            if (request["Action"] == "griddyapi")
            {
                BLL.CE_Para cp = new  BLL.CE_Para();
               DataSet dskey=  cp.GetAPI_KEY("  AppStyle='qjxj' ");
               if (dskey.Tables[0].Rows.Count > 0)
               {
                   string apiurl = dskey.Tables[0].Rows[0]["AppUrl"].ToString();
                   string apikey = dskey.Tables[0].Rows[0]["AppKey"].ToString();
                   IDictionary<string, string> postdata = new Dictionary<string, string>();
              
                   //发送POST数据  
                   StringBuilder buffer = new StringBuilder();
                   if (!(postdata == null || postdata.Count == 0))
                   {

                       int i = 0;
                       foreach (string key in postdata.Keys)
                       {
                           if (i > 0)
                           {
                               buffer.AppendFormat("&{0}={1}", key, postdata[key]);
                           }
                           else
                           {
                               buffer.AppendFormat("{0}={1}", key, postdata[key]);
                               i++;
                           }
                       }
                   }
                   string keytel = request["keytel"];
                   //+"/key/"+keytel
                   var result = HttpHelper_GetStr(apiurl + apikey + "/key/" + keytel, "GET", buffer.ToString());
                   Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(result);
                   
                
                   DataTable dtjson = JsonToDataTable(jo["data"].ToString());

                   //int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                   //int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                   //string sortname = request["sortname"];
                   //string sortorder = request["sortorder"];

                   //if (string.IsNullOrEmpty(sortname))
                   //    sortname = " id";
                   //if (string.IsNullOrEmpty(sortorder))
                   //    sortorder = " desc";

                   //string sorttext = " " + sortname + " " + sortorder;

                   //string Total;
                   //string serchtxt = null;

                   //string cid = PageValidate.InputText(request["cid"], 50);
                   //if (!string.IsNullOrEmpty(cid) && cid != "null")
                   //{
                   //    serchtxt += " Customer_id=" + cid + " ";
                   //}


                   //DataSet ds = customer.GetListdy(PageSize, PageIndex, serchtxt, sorttext, out Total);

                   string dt = Common.GetGridJSON.DataTableToJSON1(dtjson, jo["data"]["sum"].ToString());
                   context.Response.Write(dt);
               }
                
                
            }
            if (request["Action"] == "gridkjl_account_list")
            {

                string keystr = request["keystr"];
                string islf = request["islf"];//是否量房
                string serchtxt = null;


                serchtxt += "  uid='" + uid + "' ";

                if (!string.IsNullOrEmpty(keystr))
                    serchtxt += " AND  name  LIKE '%" + keystr + "%' ";
                if (islf == "Y")
                    serchtxt += " AND  name  LIKE '%量房%'";
                else
                    serchtxt += " AND  name  not LIKE '%量房%'";

                BLL.CE_Para cp = new BLL.CE_Para();
                DataSet ds = cp.GetDS_kjl_account_list(serchtxt);

                string dt = Common.GetGridJSON.DataTableToJSON2(ds.Tables[0]);
                context.Response.Write(dt);
            }
            if (request["Action"] == "griddy")
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
                string serchtxt = null;

                string cid = PageValidate.InputText(request["cid"], 50);
                if (!string.IsNullOrEmpty(cid) && cid != "null")
                {
                    serchtxt += " Customer_id=" + cid + " ";
                }


                DataSet ds = customer.GetListdy(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);
            }

            if (request["Action"] == "formdy")
            {
                string id = PageValidate.InputText(request["id"], 50);
                string cid = PageValidate.InputText(request["cid"], 50);
                string dt;
                if (PageValidate.IsNumber(id))
                {
                    DataSet ds = customer.GetListdy("ccid=" + id + " and Customer_id="+cid);
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }


                context.Response.Write(dt);
            }

            #endregion

            //save
            if (request["Action"] == "save")
            {
                model.Customer = PageValidate.InputText(request["T_company"], 255);
                model.address = PageValidate.InputText(request["T_address"], 255);
                model.fax = PageValidate.InputText(request["T_fax"], 255);
                model.site = PageValidate.InputText(request["T_Website"], 255);

                model.tel = PageValidate.InputText(request["T_company_tel"], 255);

                string industryid = request["T_industry_val"];
                if (string.IsNullOrEmpty(industryid) || industryid == "null")
                    industryid = "0";
                model.industry_id = int.Parse(industryid);
                model.industry = PageValidate.InputText(request["T_industry"], 255);

                model.DesCripe = PageValidate.InputText(request["bq"], 255);





                string communityid = request["T_Community_val"];
                if (string.IsNullOrEmpty(communityid))
                    communityid = "0";
                model.Community_id = int.Parse(communityid);
                // 保存时候增加 省份 市 区资料 start
                //根据 Community_id 资料带出对应的资料
                DataTable dtpro = SqlDB.ExecuteDataTable("SELECT ProvincesID,Provinces,City,CityID,Towns,TownsID FROM CRM_Building a WHERE ID='" + int.Parse(communityid).ToString() + "'").Output1;

                string provincesid = dtpro.Rows[0]["ProvincesID"].ToString();
                if (string.IsNullOrEmpty(provincesid))
                    provincesid = "0";
                model.Provinces_id = int.Parse(provincesid);
                model.Provinces = PageValidate.InputText(dtpro.Rows[0]["Provinces"].ToString(), 255);//PageValidate.InputText(request["T_Provinces"], 255);


                string cityid = dtpro.Rows[0]["CityID"].ToString(); //request["T_City_val"];
                if (string.IsNullOrEmpty(cityid))
                    cityid = "0";
                model.City_id = int.Parse(cityid);
                model.City = PageValidate.InputText(dtpro.Rows[0]["City"].ToString(), 255); //PageValidate.InputText(request["T_City"], 255);

                string townsid = dtpro.Rows[0]["TownsID"].ToString(); //request["T_Towns_val"];
                if (string.IsNullOrEmpty(townsid))
                    townsid = "0";
                model.Towns_id = int.Parse(townsid);
                model.Towns = PageValidate.InputText(dtpro.Rows[0]["Towns"].ToString(), 255); //PageValidate.InputText(request["T_Towns"], 255);
                // 保存时候增加 省份 市 区资料 end

                model.Community = PageValidate.InputText(request["T_Community"], 255);

                model.Gender = PageValidate.InputText(request["T_Gender"], 50);
                model.BNo = PageValidate.InputText(request["T_BNo"], 50);
                model.RNo = PageValidate.InputText(request["T_RNo"], 50);
                model.DyNo = PageValidate.InputText(request["T_DyNo"], 50);

                string ctypeid = request["T_customertype_val"];
                if (string.IsNullOrEmpty(ctypeid))
                    ctypeid = "0";
                model.CustomerType_id = int.Parse(ctypeid);
                model.CustomerType = PageValidate.InputText(request["T_customertype"], 255);

                string clevelid = request["T_customerlevel_val"];
                if (string.IsNullOrEmpty(clevelid))
                    clevelid = "0";
                model.CustomerLevel_id = int.Parse(clevelid);
                model.CustomerLevel = PageValidate.InputText(request["T_customerlevel"], 255);

                string csourceid = request["T_CustomerSource_val"];
                if (string.IsNullOrEmpty(csourceid))
                    csourceid = "0";
                model.CustomerSource_id = int.Parse(csourceid);
                model.CustomerSource = PageValidate.InputText(request["T_CustomerSource"], 255);
                //暂时这个取消，用来做标签用
               // model.DesCripe = PageValidate.InputText(request["T_descript"], 4000);
                model.Remarks = PageValidate.InputText(request["T_remarks"], 4000);
                model.privatecustomer = PageValidate.InputText(request["T_private"], 255);

                string depid = request["T_dep_val"];
                if (string.IsNullOrEmpty(depid))
                    depid = "0";
                model.Department_id = int.Parse(depid);
                model.Department = PageValidate.InputText(request["T_dep"], 255);

                string empid = request["T_employee_val"];
                if (string.IsNullOrEmpty(empid))
                    empid = "0";
                model.Employee_id = int.Parse(empid);
                model.Employee = PageValidate.InputText(request["T_employee1"], 255);

                string  employee_hh = request["T_employee_hh_val"];
                if (string.IsNullOrEmpty(employee_hh))
                    employee_hh = "0";
                model.Emp_id_hh = int.Parse(employee_hh);
                model.Emp_hh = PageValidate.InputText(request["T_employee_hh"], 255);

                model.Jfrq = PageValidate.InputText(request["T_jfrq"], 50);
                model.Zxrq = PageValidate.InputText(request["T_zxrq"], 50);
                model.Jhrq1 = PageValidate.InputText(request["T_jhrq1"], 50);
                model.Jhrq2 = PageValidate.InputText(request["T_jhrq2"], 50);
                model.Fwyt = PageValidate.InputText(request["T_fwyt"], 50);
                model.Fwmj = PageValidate.InputText(request["T_fwmj"], 50);

                string fwhxid = request["T_fwhx_val"];
                if (string.IsNullOrEmpty(fwhxid))
                    fwhxid = "0";
                model.Fwhx_id = int.Parse(fwhxid);
                model.Fwhx = PageValidate.InputText(request["T_fwhx"], 50);

                string zxjdid = request["T_zxjd_val"];
                if (string.IsNullOrEmpty(zxjdid))
                    zxjdid = "0";
                model.Zxjd_id = int.Parse(zxjdid);
                model.Zxjd = PageValidate.InputText(request["T_zxjd"], 50);

                string zxfgid = request["T_zxfg_val"];
                if (string.IsNullOrEmpty(zxfgid))
                    zxfgid = "0";
                model.Zxfg_id = int.Parse(zxfgid);
                model.Zxfg = PageValidate.InputText(request["T_zxfg"], 50);

                string dptid_sg = request["T_dep_val_sg"];
                if (string.IsNullOrEmpty(dptid_sg))
                    dptid_sg = "0";
                model.Dpt_id_sg = int.Parse(dptid_sg);
                model.Dpt_sg = PageValidate.InputText(request["T_dep_sg"], 50);

                string empid_sg = request["T_employee_sg_val"];
                if (string.IsNullOrEmpty(empid_sg))
                    empid_sg = "0";
                model.Emp_id_sg = int.Parse(empid_sg);
                model.Emp_sg = PageValidate.InputText(request["T_employee1_sg"], 50);

                string dptid_sj = request["T_dep_val_sj"];
                if (string.IsNullOrEmpty(dptid_sj))
                    dptid_sj = "0";
                model.Dpt_id_sj = int.Parse(dptid_sj);
                model.Dpt_sj = PageValidate.InputText(request["T_dep_sj"], 50);

                string empid_sj = request["T_employee_sj_val"];
                if (string.IsNullOrEmpty(empid_sj))
                    empid_sj = "0";
                model.Emp_id_sj = int.Parse(empid_sj);
                model.Emp_sj = PageValidate.InputText(request["T_employee1_sj"], 50);
                model.xy = PageValidate.InputText(request["T_xy"], 50).Trim(' ');

                string WXZT_ID = request["T_WXZT_NAME_val"];
                if (string.IsNullOrEmpty(WXZT_ID))
                    WXZT_ID = "0";
                model.WXZT_ID = int.Parse(WXZT_ID);
                model.WXZT_NAME = PageValidate.InputText(request["T_WXZT_NAME"], 50);
                model.QQ = PageValidate.InputText(request["T_QQ"], 50).Trim(' ');
                model.JKDZ = PageValidate.InputText(request["T_JKDZ"], 50).Trim(' ');
                model.hxt = PageValidate.InputText(request["T_hxt"], 50).Trim(' ');
                model.jgqjt = PageValidate.InputText(request["T_jgqjt"], 50).Trim(' ');
                model.Jhrq2 = PageValidate.InputText(request["T_jhrq2"], 50);
                model.birthday_lunar = PageValidate.InputText(request["T_birthday_lunar"], 50);
                model.birthday = PageValidate.InputText(request["T_birthday"], 50);
                string id = PageValidate.InputText(request["id"], 50);

                //DataSet dstel = customer.GetList(" tel=");
                string type = PageValidate.InputText(request["type"], 255);
                int isDelete = 0;
                if (type == "2")//名单客户
                {  string iszz = PageValidate.InputText(request["iszz"], 255);//是否转正
                    if(iszz=="Y")
                        isDelete = 0;
                    else
                        isDelete = 2;
                    }

                else isDelete = 0;
                model.isDelete = isDelete;
                DateTime nowtime = DateTime.Now;
                model.Delete_time = nowtime;//修改日期
                if (!string.IsNullOrEmpty(id) && id != "null")
                {
                    DataSet ds = customer.GetList("id=" + int.Parse(id));
                    DataRow dr = ds.Tables[0].Rows[0];

                    model.Serialnumber = PageValidate.InputText(dr["Serialnumber"].ToString(), 255);

                    model.id = int.Parse(id);
                    customer.Update(model);
                    customer.UpdateIsDelete(int.Parse(id),   isDelete );
                    //日志
                    C_Sys_log log = new C_Sys_log();

                    int UserID = emp_id;
                    string UserName = empname;
                    string IPStreet = request.UserHostAddress;
                    string EventTitle = model.Customer;
                    string EventType = "客户修改";
                    int EventID = model.id;

                    if (dr["Customer"].ToString() != request["T_company"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "公司名", dr["Customer"].ToString(), request["T_company"].ToString());

                    if (dr["address"].ToString() != request["T_address"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "地址", dr["address"].ToString(), request["T_address"].ToString());

                    
                    
                    if (dr["industry"].ToString() != request["T_industry"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "行业", dr["industry"].ToString(), request["T_industry"].ToString());

                    
                    
                    if (dr["CustomerType"].ToString() != request["T_customertype"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "客户类型", dr["CustomerType"].ToString(), request["T_customertype"].ToString());

                    if (dr["CustomerLevel"].ToString() != request["T_customerlevel"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "客户级别", dr["CustomerLevel"].ToString(), request["T_customerlevel"].ToString());

                    if (dr["CustomerSource"].ToString() != request["T_CustomerSource"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "客户来源", dr["CustomerSource"].ToString(), request["T_CustomerSource"].ToString());
 
                    if (dr["Remarks"].ToString() != request["T_remarks"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "备注", dr["Remarks"].ToString(), request["T_remarks"].ToString());

                    if (dr["privatecustomer"].ToString() != request["T_private"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "公私", dr["privatecustomer"].ToString(), request["T_private"].ToString());

                    if (dr["Department"].ToString() != request["T_dep"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "部门", dr["Department"].ToString(), request["T_dep"].ToString());

                    if (dr["Employee"].ToString() != request["T_employee1"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "员工", dr["Employee"].ToString(), request["T_employee1"].ToString());
                }
                else
                {
                    //model.isDelete = 0;
                 
                    model.Create_date = nowtime;
                    model.Serialnumber = nowtime.AddMilliseconds(3).ToString("yyyyMMddHHmmssfff").Trim();
                    model.Create_id = emp_id;
                    model.Create_name = Common.PageValidate.InputText(empname, 255);
                    int customerid = customer.Add(model);

                    BLL.CRM_Contact contact = new BLL.CRM_Contact();
                    Model.CRM_Contact modelcontact = new Model.CRM_Contact();
                    modelcontact.isDelete = 0;
                    modelcontact.C_name = PageValidate.InputText(request["T_company"], 255);
                    modelcontact.C_sex = PageValidate.InputText(request["T_Gender"], 50) == "男" ? "先生" : "女士";
                    //modelcontact.C_name = PageValidate.InputText(request["T_customername"], 255);
                    //modelcontact.C_sex = PageValidate.InputText(request["T_sex"], 255);
                    modelcontact.C_department = PageValidate.InputText(request["T_Community"], 255);
                    modelcontact.C_position = PageValidate.InputText(request["T_industry"], 255);
                    modelcontact.C_QQ = PageValidate.InputText(request["T_qq"], 255);
                    modelcontact.C_tel = PageValidate.InputText(request["T_company_tel"], 50);
                    //modelcontact.C_tel = PageValidate.InputText(request["T_tel"], 255);
                    modelcontact.C_mob = PageValidate.InputText(request["T_company_tel"], 255);
                    modelcontact.C_email = Common.PageValidate.InputText(request["T_email"], 255);
                    modelcontact.C_customerid = customerid;
                    modelcontact.C_customername = model.Customer;
                    modelcontact.C_createId = emp_id;
                    modelcontact.C_createDate = DateTime.Now;
                    modelcontact.C_hobby = PageValidate.InputText(request["T_hobby"], 1000);
                    modelcontact.C_remarks = PageValidate.InputText(request["T_contact_remarks"], 4000);
                   // int ct = contact.Add(modelcontact);

                    context.Response.Write(customerid);

                }

                Caches.CRM_Customer = null;
            }
            //高级保存
            if (request["Action"] == "save_GJXG")
            {
                string tel = PageValidate.InputText(request["T_company_tel"], 255);
                DateTime Create_date = DateTime.Parse(PageValidate.InputText(request["T_lrrq"], 800));
                int id = int.Parse(PageValidate.InputText(request["id"], 50));
                //int id = int.Parse(id);
                customer.Update_GJXG(id,tel,Create_date);
            }
            //转正
            if (request["Action"] == "save_change")
            {
                string id = PageValidate.InputText(request["id"], 255);
                string isdelete = PageValidate.InputText(request["isdelete"], 255);
                customer.UpdateIsDelete(int.Parse(id), int.Parse(isdelete));
            }

            //订单保存
            if (request["Action"] == "saveOrder")
            {
                Model.CRM_order modelOrder = new Model.CRM_order();
                BLL.CRM_order bllOrder = new BLL.CRM_order();
                DataRow dremp = dsemp.Tables[0].Rows[0];

                modelOrder.Customer_id = int.Parse(request["T_Customer_val"]);
                modelOrder.Customer_name = PageValidate.InputText(request["T_Customer"], 255);

                modelOrder.Order_date = DateTime.Parse(request["T_date"]);
                modelOrder.pay_type_id = StrToInt(request["T_paytype_val"]);
                modelOrder.pay_type = PageValidate.InputText(request["T_paytype"], 255);
                modelOrder.Order_details = PageValidate.InputText(request["T_details"].ToString(), 4000);
                modelOrder.Order_status_id = StrToInt(request["T_status_val"]);
                modelOrder.Order_status = PageValidate.InputText(request["T_status"], 255);
                modelOrder.Order_amount = decimal.Parse(request["T_amount"]);

                modelOrder.budget_money = decimal.Parse(request["T_ysje"]);
                modelOrder.Total_Money = decimal.Parse(request["T_amount"]) + decimal.Parse(request["T_ysje"]);
                modelOrder.budget_money = decimal.Parse(request["T_ysje"]);

                modelOrder.budge_id = PageValidate.InputText(request["ysid"], 50);

                modelOrder.create_id = emp_id;
                modelOrder.create_date = DateTime.Now;

                modelOrder.C_dep_id = StrToInt(request["c_dep_val"]);
                modelOrder.C_dep_name = PageValidate.InputText(request["c_dep"], 255);
                modelOrder.C_emp_id = StrToInt(request["c_emp_val"]);
                modelOrder.C_emp_name = PageValidate.InputText(request["c_emp"], 255);

                modelOrder.F_dep_id = StrToInt(request["f_dep_val"]);
                modelOrder.F_dep_name = PageValidate.InputText(request["f_dep"], 255);
                modelOrder.F_emp_id = StrToInt(request["f_emp_val"]);
                modelOrder.F_emp_name = PageValidate.InputText(request["f_emp"], 255);

                int orderid;
                string pid = PageValidate.InputText(request["orderid"], 50);
                if (!string.IsNullOrEmpty(pid) && pid != "null")
                {
                    modelOrder.id = StrToInt(PageValidate.IsNumber(pid) ? pid : "-1");
                    DataSet ds = bllOrder.GetList("id=" + modelOrder.id);
                    DataRow dr = ds.Tables[0].Rows[0];
                    orderid = modelOrder.id;

                    bllOrder.Update(modelOrder);
                    //context.Response.Write(model.id );
                    context.Response.Write("{success:success}");

                    C_Sys_log log = new C_Sys_log();
                    int UserID = emp_id;
                    string UserName = empname;
                    string IPStreet = request.UserHostAddress;
                    string EventTitle = modelOrder.Customer_name;
                    string EventType = "订单修改";
                    int EventID = modelOrder.id;

                    if (dr["Customer_name"].ToString() != request["T_Customer"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "客户", dr["Customer_name"].ToString(), request["T_Customer"]);

                    if (dr["Order_details"].ToString() != request["T_details"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "订单详情", "原内容被修改", "原内容被修改");

                    if (dr["Order_date"].ToString() != request["T_date"].ToString() + " 0:00:00")
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "成交时间", dr["Order_date"].ToString(), request["T_date"].ToString() + " 0:00:00");

                    if (dr["Order_amount"].ToString() != request["T_amount"].Replace(",", "").Replace(".00", ""))
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "订单总额", dr["Order_amount"].ToString(), request["T_amount"].Replace(",", "").Replace(".00", ""));

                    if (dr["Order_status"].ToString() != request["T_status"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "订单状态", dr["Order_status"].ToString(), request["T_status"]);

                    if (dr["F_dep_name"].ToString() != request["f_dep"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "促成人员部门", dr["F_dep_name"].ToString(), request["f_dep"]);

                    if (dr["F_emp_name"].ToString() != request["f_emp"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "促成人员", dr["F_emp_name"].ToString(), request["f_emp"]);

                    if (dr["pay_type"].ToString() != request["T_paytype"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "支付方式", dr["pay_type"].ToString(), request["T_paytype"]);

                }
                else
                {
                    modelOrder.isDelete = 0;
                    modelOrder.Serialnumber = DateTime.Now.AddMilliseconds(3).ToString("yyyyMMddHHmmssfff").Trim();
                    //model.arrears_invoice = decimal.Parse(request["T_amount"]);
                    orderid = bllOrder.Add(modelOrder);
                    context.Response.Write("{success:success}");
                }
                //更新订单收款金额
                bllOrder.UpdateReceive(orderid.ToString());
                //更新订单发票金额
                bllOrder.UpdateInvoice(orderid.ToString());

                //string json = request["PostData"].ToLower();
                //JavaScriptSerializer js = new JavaScriptSerializer();

                //PostData[] postdata;
                //postdata = js.Deserialize<PostData[]>(json);

                //BLL.CRM_order_details cod = new BLL.CRM_order_details();
                //Model.CRM_order_details modeldel = new Model.CRM_order_details();

                //modeldel.order_id = orderid;
                //cod.Delete(" order_id=" + modeldel.order_id);
                //for (int i = 0; i < postdata.Length; i++)
                //{
                //    modeldel.product_id = postdata[i].Product_id;
                //    modeldel.product_name = postdata[i].Product_name;
                //    modeldel.quantity = postdata[i].Quantity;
                //    modeldel.unit = postdata[i].Unit;
                //    modeldel.price = postdata[i].Price;
                //    modeldel.amount = postdata[i].Amount;

                //    cod.Add(modeldel);
                //}
            }

            if (request["Action"] == "save_khjdgl")
            {
                DataRow dremp = dsemp.Tables[0].Rows[0];
                Model.CRM_receive modelReceive = new Model.CRM_receive();
                BLL.CRM_receive cci = new BLL.CRM_receive();
                string pzm= PageValidate.InputText(request["T_invoice_num"], 255);
                modelReceive.Receive_num = pzm;

                //string orderid = PageValidate.InputText(request["orderid"], 50);

                //BLL.CRM_order order = new BLL.CRM_order();
                //DataSet dsorder = order.GetList("id=" + int.Parse(orderid));

                //model.order_id = int.Parse(orderid);
                //if (dsorder.Tables[0].Rows.Count > 0)
                //{
                //    model.Customer_id = int.Parse(dsorder.Tables[0].Rows[0]["Customer_id"].ToString());
                //    model.Customer_name = PageValidate.InputText(dsorder.Tables[0].Rows[0]["Customer_name"].ToString(), 255);
                //}
                modelReceive.Customer_id = int.Parse(request["customerid"].ToString());

                //modelReceive.Customer_name = PageValidate.InputText(request["Customer_name"].ToString(), 255);
                modelReceive.C_depid = int.Parse(request["T_dep_val"].ToString());
                modelReceive.C_depname = PageValidate.InputText(request["T_dep"].ToString(), 255);
                modelReceive.C_empid = int.Parse(request["T_employee_val"].ToString());
                modelReceive.C_empname = PageValidate.InputText(request["T_employee1"].ToString(), 255);
                decimal skje= decimal.Parse(request["T_invoice_amount"]);
                modelReceive.receive_real = skje;
                DateTime sksj= DateTime.Parse(request["T_invoice_date"].ToString());
                modelReceive.Receive_date = sksj;
                modelReceive.Pay_type_id = int.Parse(request["T_invoice_type_val"].ToString());
                string fkfs= PageValidate.InputText(request["T_invoice_type"].ToString(), 255);
                modelReceive.Pay_type = fkfs;
                modelReceive.remarks = PageValidate.InputText(request["T_content"].ToString(), 12000);
                modelReceive.receive_direction_id = int.Parse(request["T_receive_direction_val"].ToString());
                string sklb = PageValidate.InputText(request["T_receive_direction"], 255);
                modelReceive.receive_direction_name = sklb;
                int i = 1; //1表示收款，-1表示退款
                if (modelReceive.receive_direction_id == -2 || modelReceive.receive_direction_id == -3)
                    i = -1;
                modelReceive.Receive_amount = i * modelReceive.receive_real;

                string cid = PageValidate.InputText(request["receiveid"], 50);
                if (!string.IsNullOrEmpty(cid) && cid != "null")
                {
                    modelReceive.id = int.Parse(PageValidate.IsNumber(cid) ? cid : "-1");

                    DataSet ds = cci.GetList(" id=" + modelReceive.id);
                    DataRow dr = ds.Tables[0].Rows[0];

                    cci.Update(modelReceive);

                    C_Sys_log log = new C_Sys_log();

                    int UserID = emp_id;
                    string UserName = empname;
                    string IPStreet = request.UserHostAddress;
                    string EventTitle = modelReceive.Receive_num;
                    string EventType = "收款修改";
                    int EventID = modelReceive.id;

                    if (dr["Receive_amount"].ToString() != request["T_invoice_amount"].Replace(",", "").Replace(".00", ""))
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "收款金额", dr["Receive_amount"].ToString(), request["T_invoice_amount"].Replace(",", "").Replace(".00", ""));

                    if (dr["Pay_type"].ToString() != request["T_invoice_type"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "付款方式", dr["Pay_type"].ToString(), request["T_invoice_type"]);

                    if (dr["receive_direction_name"].ToString() != request["T_receive_direction"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "收款类别", dr["receive_direction_name"].ToString(), request["T_receive_direction"]);

                    if (dr["Receive_num"].ToString() != request["T_invoice_num"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "凭证号码", dr["Receive_num"].ToString(), request["T_invoice_num"]);

                    if (dr["Receive_date"].ToString() != request["T_invoice_date"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "收款时间", dr["Receive_date"].ToString(), request["T_invoice_date"]);

                    if (dr["remarks"].ToString() != request["T_content"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "收款内容", "原内容被修改", "原内容被修改");

                    if (dr["C_depname"].ToString() != request["T_dep"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "收款人部门", dr["C_depname"].ToString(), request["T_dep"]);

                    if (dr["C_empname"].ToString() != request["T_employee1"])
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "收款人姓名", dr["C_empname"].ToString(), request["T_employee1"]);
                }
                else
                {
                    modelReceive.isDelete = 0;
                    modelReceive.create_id = emp_id;
                    modelReceive.create_name = dremp["name"].ToString();
                    modelReceive.create_date = DateTime.Now;

                    cci.Add(modelReceive);
                }
                try
                {
                    WX wx = new WX();
                    string token = wx.Getaccess_token("7");
                    string t_customer = PageValidate.InputText(request["T_Customer"].ToString(), 12000); ;
                    string userlist = "";
                    string SQL = "SELECT * FROM dbo.WX_UserList WHERE mobile IN(" +
                                "SELECT tel FROM dbo.hr_employee WHERE ID IN(" +
                                "SELECT empID FROM dbo.sys_role_emp WHERE RoleID IN(SELECT Role_id FROM dbo.Sys_authority WHERE	Menu_ids LIKE '%,m194%')" +
                                ")" +
                                ")";

                    //  SELECT* FROM dbo.Sys_Menu WHERE    Menu_name = '客户高级管理'
                    DataTable lsdt = DBUtility.DbHelperSQL.Query(SQL).Tables[0];
                    if (lsdt.Rows.Count > 0)
                    {
                        foreach (DataRow dr in lsdt.Rows)
                        {
                            userlist = userlist + "|" + dr["userid"].ToString();
                        }
                        if (userlist.Length > 0)
                            userlist = userlist.Substring(1, userlist.Length - 1);
                    }
                    string title_customer = "";string type = "";
                    //type = PageValidate.InputText(request["type"].ToString(), 50); ;
                    if (t_customer.Length > 0)
                        title_customer = "【"+ t_customer.Split('【')[0] + "】";
                    if ( sksj == null) sksj = DateTime.Now;
                    wx.PostMessage_textcard(token, userlist, sklb + ":￥" + skje + " \n" + t_customer
                      //, "【客户名称】:" + t_customer + "</div><div class='normal'>【付款金额】:" + skje + " </div><div class='normal'>"
                    ,"【付款方式】:" + fkfs + "</div><div class='normal'>【付款时间】:" + sksj.ToString("yyyy-MM-dd") + " </div><div class='normal'>【付款类型】:" + sklb + "</div><div class='normal'>【凭证号】:" + pzm,
                        "待确认（系统有更新）",  "http://mb.xczs.co/CRM/shareto/jifen_share.html?uid=");
                }
                catch { }
                //更新订单收款金额
                //order.UpdateReceive(orderid);
            }

            //其他联系人保存
            if (request["Action"] == "saveContact")
            {
                BLL.CRM_Contact contact = new BLL.CRM_Contact();
                Model.CRM_Contact modelContact = new Model.CRM_Contact();

                string customerid = request["T_company_val"];

                modelContact.C_customerid = int.Parse(customerid);
                modelContact.C_customername = PageValidate.InputText(request["T_company"], 250);
                modelContact.C_name =PageValidate.InputText(request["T_contact"], 250);
                modelContact.C_sex =PageValidate.InputText(request["T_sex"], 250);
                modelContact.C_birthday =PageValidate.InputText(request["T_birthday"], 250);
                modelContact.C_department =PageValidate.InputText(request["T_dep"], 250);
                modelContact.C_position =PageValidate.InputText(request["T_position"], 250);

                modelContact.C_tel =PageValidate.InputText(request["T_tel"], 250);
                modelContact.C_mob =PageValidate.InputText(request["T_mobil"], 250);
                modelContact.C_fax =PageValidate.InputText(request["T_fax"], 250);
                modelContact.C_email =PageValidate.InputText(request["T_email"], 250);
                modelContact.C_QQ =PageValidate.InputText(request["T_qq"], 250);
                modelContact.C_add =PageValidate.InputText(request["T_add"], 250);

                modelContact.C_hobby =PageValidate.InputText(request["T_hobby"], 250);
                modelContact.C_remarks =PageValidate.InputText(request["T_remarks"], 250);

                string contact_id =  PageValidate.InputText( request["contact_id"],50);
                if (!string.IsNullOrEmpty(contact_id) && contact_id != "null")
                {
                    DataSet ds = contact.GetList("id=" + int.Parse(contact_id));
                    DataRow dr = ds.Tables[0].Rows[0];

                    modelContact.id = int.Parse(contact_id);

                    contact.Update(modelContact);

                    //日志
                    C_Sys_log log = new C_Sys_log();

                    int UserID = emp_id;
                    string UserName = empname;
                    string IPStreet = request.UserHostAddress;
                    string EventTitle = modelContact.C_name; ;
                    string EventType = "联系人修改";
                    int EventID = modelContact.id;

                    if (dr["C_customername"].ToString() != request["T_company"])                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "客户姓名", dr["C_customer_name"].ToString(), request["T_company"]);
                    
                    if (dr["C_name"].ToString() != request["T_contact"])                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "联系人", dr["C_name"].ToString(), request["T_contact"]);
                    
                    if (dr["C_sex"].ToString() != request["T_sex"])                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "联系人性别", dr["C_sex"].ToString(), request["T_sex"]);
                    
                    if (dr["C_birthday"].ToString() != request["T_birthday"])                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "联系人生日", dr["C_birthday"].ToString(), request["T_birthday"]);
                    
                    if (dr["C_department"].ToString() != request["T_dep"])                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "联系人部门", dr["C_department"].ToString(), request["T_dep"]);
                    
                    if (dr["C_position"].ToString() != request["T_position"])                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "联系人职位", dr["C_position"].ToString(), request["T_position"]);
                    
                    if (dr["C_tel"].ToString() != request["T_tel"])                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "联系人电话", dr["C_tel"].ToString(), request["T_tel"]);
                    
                    if (dr["C_mob"].ToString() != request["T_mobil"])
                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "联系人手机", dr["C_mob"].ToString(), request["T_mobil"]);
                    
                    if (dr["C_fax"].ToString() != request["T_fax"])
                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "联系人传真", dr["C_fax"].ToString(), request["T_fax"]);
                    
                    if (dr["C_email"].ToString() != request["T_email"])
                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "联系人邮箱", dr["C_email"].ToString(), request["T_email"]);
                    
                    if (dr["C_QQ"].ToString() != request["T_qq"])
                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "联系人QQ", dr["C_QQ"].ToString(), request["T_qq"]);
                    
                    if (dr["C_add"].ToString() != request["T_add"])
                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "联系人地址", dr["C_add"].ToString(), request["T_add"]);
                    
                    if (dr["C_hobby"].ToString() != request["T_hobby"])
                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "联系人爱好", dr["C_hobby"].ToString(), request["T_hobby"]);
                    
                    if (dr["C_remarks"].ToString() != request["T_remarks"])
                    
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "备注", dr["C_remarks"].ToString(), request["T_remarks"]);
                    
                }
                else
                {
                    modelContact.isDelete = 0;
                    modelContact.C_createId = emp_id;
                    modelContact.C_createDate = DateTime.Now;

                    contact.Add(modelContact);
                }
            }
            if (request["Action"] == "IsExistphone")
            {
                string tel = PageValidate.InputText(request["tel"], 50);
                DataSet codeds = customer.GetList(" tel='" + tel + "' ");
                //and id!=" + PageValidate.InputText(request["cid"], 50) + " ");
                if (codeds.Tables[0].Rows.Count > 0)
                {
                    context.Response.Write("false:tel");

                }
            }
            if (request["Action"] == "IsExistaddress")
            {
                string address = PageValidate.InputText(request["address"], 500);
                DataSet codeds = customer.GetList(" address='" + address + "' ");
                //and id!=" + PageValidate.InputText(request["cid"], 50) + " ");
                if (codeds.Tables[0].Rows.Count > 0)
                {
                    context.Response.Write("false:address");

                }
            }
            //客户类型报表
            if (request["Action"] == "gridrep")
            {

                string serchtxt = "  'WHERE ISNULL(isDelete,0)=0 AND customertype<>''''  ";
                if (!string.IsNullOrEmpty(request["startfollow"]))
                    serchtxt += " and  Convert(varchar(10),log_time,120)>=''" + PageValidate.InputText(request["startfollow"], 255) + "''";

                if (!string.IsNullOrEmpty(request["endfollow"]))
                {
                    DateTime enddate = DateTime.Parse(request["endfollow"]).AddHours(23).AddMinutes(59).AddSeconds(59);
                    serchtxt += " and Convert(varchar(10),log_time,120)<=''" + enddate + "''";
                }
                string keyword = PageValidate.InputText(request["keyword1"], 500);
                if (!string.IsNullOrEmpty(keyword) && keyword != "输入关键词搜索")
                {
                    serchtxt += string.Format(" and ( Emp_sj like N'%{0}%' or Emp_sg  like N'%{0}%' or Employee like N'%{0}%'   or Customer like N'%{0}%'     ) ", keyword);
                }
                string xtype = "Employee";
                string ytype = "customertype";
                if (!string.IsNullOrEmpty(request["sectype1"]))
                {
                    xtype = PageValidate.InputText(request["sectype1"], 100);
                }
                
                serchtxt += "'";
                DataSet ds = customer.GetDSRep(xtype,ytype,serchtxt);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], ds.Tables[0].Rows.Count.ToString());
                context.Response.Write(dt);
            }
            //客户类型反
            if (request["Action"] == "gridrep_")
            {

                string serchtxt = "  'WHERE ISNULL(isDelete,0)=0 AND customertype<>''''  ";
                if (!string.IsNullOrEmpty(request["startfollow"]))
                    serchtxt += " and  Convert(varchar(10),log_time,120)>=''" + PageValidate.InputText(request["startfollow"], 255) + "''";

                if (!string.IsNullOrEmpty(request["endfollow"]))
                {
                    DateTime enddate = DateTime.Parse(request["endfollow"]).AddHours(23).AddMinutes(59).AddSeconds(59);
                    serchtxt += " and Convert(varchar(10),log_time,120)<=''" + enddate + "''";
                }
                string keyword = PageValidate.InputText(request["keyword1"], 500);
                if (!string.IsNullOrEmpty(keyword) && keyword != "输入关键词搜索")
                {
                    serchtxt += string.Format(" and ( Emp_sj like N'%{0}%' or Emp_sg  like N'%{0}%' or Employee like N'%{0}%'   or Customer like N'%{0}%'     ) ", keyword);
                }
                string ytype = "Employee";
                string xtype = "customertype";
                if (!string.IsNullOrEmpty(request["sectype1"]))
                {
                    ytype = PageValidate.InputText(request["sectype1"], 100);
                }

                serchtxt += "'";
                DataSet ds = customer.GetDSRep(xtype,ytype, serchtxt);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], ds.Tables[0].Rows.Count.ToString());
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
                if (string.IsNullOrEmpty(sorttext))
                    sorttext += " ,id asc";

                string Total;
                string serchtxt = null;
                string serchtype = request["isdel"];
                if (serchtype == "1")
                    serchtxt += " ISNULL(isDelete,0)=1 ";
                else
                {
                    if (!string.IsNullOrEmpty(request["type"]))//2位名单客户
                        serchtxt += " ISNULL(isDelete,0)=" + request["type"];
                    else
                    serchtxt += " ISNULL(isDelete,0)=0 ";
                }
              

                if (!string.IsNullOrEmpty(request["companyid"]))
                    serchtxt += " and id =" + int.Parse(request["companyid"]);

                //if (!string.IsNullOrEmpty(request["company"])&& request["company"]!="")
                //    serchtxt += " and Customer like N'%" + PageValidate.InputText(request["company"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["address"]))
                    serchtxt += " and address like N'%" + PageValidate.InputText(request["address"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["industry"]))
                    serchtxt += " and industry like N'%" + PageValidate.InputText(request["industry"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["tel"]))
                    serchtxt += " and tel like N'%" + PageValidate.InputText(request["tel"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["emp_hh"]))
                    serchtxt += " and emp_hh like N'%" + PageValidate.InputText(request["emp_hh"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["mobil"]))
                    serchtxt += " and mobil like N'%" + PageValidate.InputText(request["mobil"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["qq"]))
                    serchtxt += " and QQ like N'%" + PageValidate.InputText(request["qq"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["cus_sourse"]))
                    serchtxt += " and CustomerSource like N'%" + PageValidate.InputText(request["cus_sourse"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["WXZHT"]))
                    serchtxt += " and WXZT_NAME like N'%" + PageValidate.InputText(request["WXZHT"], 255) + "%'";
                string ck = (request["ckisgd"]);
                if (ck == "on")
                {
                    serchtxt += " and DATEDIFF(HOUR,ISNULL( lastfollow,a.Create_date),GETDATE())>c_type.followhours ";
                }
                    string keyword = PageValidate.InputText(request["keyword"], 500);
                if (!string.IsNullOrEmpty(keyword) && keyword != "输入关键词搜索地址、描述、备注")
                {
                    serchtxt += string.Format(" and ( Customer like N'%{0}%' or tel  like N'%{0}%' or Community like N'%{0}%'   or hxt like N'%{0}%' or address like N'%{0}%' or DesCripe like N'%{0}%' or Remarks like N'%{0}%' or Emp_hh like N'%{0}%' ) ", keyword);
                }
                string khtype = PageValidate.InputText(request["khtype"], 50);//客户类型
                string searchtype = PageValidate.InputText(request["searchtype"], 50);//查询类型
                if (!string.IsNullOrEmpty(khtype))
                {
                    string kh = System.Web.HttpUtility.UrlDecode(request["kh"]);   //查询类型
                    if (!string.IsNullOrEmpty(searchtype)&& searchtype=="fan")//反查
                    {
                        if (khtype == "CustomerType")
                            serchtxt += " and CustomerType='" + kh + "'";
                        string CustomerType = System.Web.HttpUtility.UrlDecode(request["CType"]);   //查询类型
                        serchtxt += " and Employee='" + CustomerType + "'";
                        if (khtype == "Employee")
                            serchtxt += " and employee='" + CustomerType + "'";
                        if (khtype == "Emp_sj")
                            serchtxt += " and Emp_sj='" + CustomerType + "'";
                        if (khtype == "Emp_sg")
                            serchtxt += " and Emp_sg='" + CustomerType + "'";
                        if (khtype == "Emp_hh")
                            serchtxt += " and Emp_hh='" + CustomerType + "'";
                    }
                    else
                    {
                        if (khtype == "Employee")
                            serchtxt += " and employee='" + kh + "'";
                        if (khtype == "Emp_sj")
                            serchtxt += " and Emp_sj='" + kh + "'";
                        if (khtype == "Emp_sg")
                            serchtxt += " and Emp_sg='" + kh + "'";
                        if (khtype == "Emp_hh")
                            serchtxt += " and Emp_hh='" + kh + "'";
                        string CustomerType = System.Web.HttpUtility.UrlDecode(request["CType"]);   //查询类型
                        serchtxt += " and CustomerType='" + CustomerType + "'";
                    }
                   
                   
                }
                string t_mapstasus = PageValidate.InputText(request["t_mapstasus"], 50);
                if (!string.IsNullOrEmpty(t_mapstasus))
                {
                    if (t_mapstasus == "已标地图")
                    serchtxt += " and isnull(xy,'')!='' ";
                    else if (t_mapstasus == "未标地图")
                        serchtxt += " and isnull(xy,'')='' ";
                }
                string keyword1 = PageValidate.InputText(request["keyword1"], 500);
                if (!string.IsNullOrEmpty(keyword1) && keyword1 != "输入关键词搜索")
                {
                    serchtxt += string.Format(" and ( Customer like N'%{0}%' or tel  like N'%{0}%' or Community like N'%{0}%'  or hxt like N'%{0}%'  or address like N'%{0}%' or DesCripe like N'%{0}%' or Remarks like N'%{0}%' or Emp_hh like N'%{0}%' ) ", keyword1);
                }
                string items = PageValidate.InputText(context.Request["stype_val"], 255);
                if (!string.IsNullOrEmpty(items) && items != "null")
                    serchtxt += string.Format(" and a.CustomerType_id in({0})", items.Replace(';', ','));

                if (!string.IsNullOrEmpty(request["customertype"]))
                    serchtxt += " and CustomerType_id = " + StrToInt(request["customertype_val"]);

                if (!string.IsNullOrEmpty(request["customerlevel"]))
                    serchtxt += " and CustomerLevel_id = " + StrToInt(request["customerlevel_val"]);

                if (!string.IsNullOrEmpty(request["sbq"]))
                {
                    string[] sbq = PageValidate.InputText(request["sbq"], 255).Split(';');
                    if (sbq.Length > 0)
                    { 
                        for(int i=0;i<sbq.Length;i++)
                        {
                        serchtxt += " and DesCripe like N'%"+sbq[i]+"%'";
                        }
                    }
                    //serchtxt += " and DesCripe like ('" + PageValidate.InputText(request["sbq"], 255).Replace(";", "','") + "')";
                }
                if (!string.IsNullOrEmpty(request["T_CustomerSource"]))
                    serchtxt += " and CustomerSource_id = " + StrToInt(request["T_CustomerSource_val"]);

                if (!string.IsNullOrEmpty(request["T_Community"]))
                    serchtxt += " and Community_id = " + StrToInt(request["T_Community_val"]);
               
                if (!string.IsNullOrEmpty(request["T_Towns"]))
                    serchtxt += " and Towns_id = " + StrToInt(request["T_Towns_val"]);

                if (!string.IsNullOrEmpty(request["T_Provinces"]))
                    serchtxt += " and Provinces_id = " + StrToInt(request["T_Provinces_val"]);

                if (!string.IsNullOrEmpty(request["T_City"]))
                    serchtxt += " and City_id = " + StrToInt(request["T_City_val"]);

                if (!string.IsNullOrEmpty(request["department"]))
                    serchtxt += " and Department_id = " + StrToInt(request["department_val"]);

                if (!string.IsNullOrEmpty(request["employee"]))
                    serchtxt += " and Employee_id = " + StrToInt(request["employee_val"]);

                if (!string.IsNullOrEmpty(request["department_sg"]))
                    serchtxt += " and Dpt_id_sg = " + StrToInt(request["department_sg_val"]);

                if (!string.IsNullOrEmpty(request["employee_sg"]))
                    serchtxt += " and Emp_id_sg = " + StrToInt(request["employee_sg_val"]);

                if (!string.IsNullOrEmpty(request["department_sj"]))
                    serchtxt += " and Dpt_id_sj = " + StrToInt(request["department_sj_val"]);

                if (!string.IsNullOrEmpty(request["employee_sj"]))
                    serchtxt += " and Emp_id_sj = " + StrToInt(request["employee_sj_val"]);

                if (!string.IsNullOrEmpty(request["startdate"]))
                    serchtxt += " and a.Create_date >= '" + PageValidate.InputText(request["startdate"], 255) + "'";

                if (!string.IsNullOrEmpty(request["enddate"]))
                {
                    DateTime enddate = DateTime.Parse(request["enddate"]).AddHours(23).AddMinutes(59).AddSeconds(59);
                    serchtxt += " and a.Create_date <= '" + enddate + "'";
                }

                if (!string.IsNullOrEmpty(request["startdate_del"]))
                    serchtxt += " and Delete_time >= '" + PageValidate.InputText(request["startdate_del"], 255) + "'";

                if (!string.IsNullOrEmpty(request["enddate_del"]))
                {
                    DateTime enddatedel = DateTime.Parse(request["enddate_del"]).AddHours(23).AddMinutes(59).AddSeconds(59);
                    serchtxt += " and Delete_time <= '" + enddatedel + "'";
                }

                if (!string.IsNullOrEmpty(request["startfollow"]))
                    serchtxt += " and lastfollow >= '" + PageValidate.InputText(request["startfollow"], 255) + "'";

                if (!string.IsNullOrEmpty(request["endfollow"]))
                {
                    DateTime enddate = DateTime.Parse(request["endfollow"]).AddHours(23).AddMinutes(59).AddSeconds(59);
                    serchtxt += " and lastfollow <= '" + enddate + "'";
                }

                if (!string.IsNullOrEmpty(request["thtype"]))
                {
                    string thtype = request["thtype"];
                    if (thtype == "未签单")
                    { serchtxt += " and ISNULL(a.site,'')=''and ISNULL(d.Stage_icon, '')='' "; }
                    else if (thtype == "签单未施工")
                        serchtxt += " and isnull(a.site,'')='1' and ISNULL(d.Stage_icon, '')='' ";
                    else if (thtype == "正在施工")
                        serchtxt += " and ISNULL(d.Stage_icon, '')='正在施工' ";
                    else if (thtype == "施工完成")
                        serchtxt += " and ISNULL(d.Stage_icon, '')='施工完成' ";
                    else
                        serchtxt += " and isnull(a.site,'')='" + thtype + "' ";
                }
                if (!string.IsNullOrEmpty(request["sectype"]))
                {
                    string sectype = request["sectype"];
                    if (sectype == "仅付定金")
                    { serchtxt += " and dj_amount>0 and isnull(zx_amount,0)=0 "; }
                    else if (sectype == "需要退款")
                        serchtxt += " and ISNULL(Order_amount,0)-ISNULL(dj_amount,0)-ISNULL(zx_amount,0)<0 ";
                    else if (sectype == "应收未收")
                        serchtxt += " and ISNULL(Order_amount,0)-ISNULL(dj_amount,0)-ISNULL(zx_amount,0)>0 ";
                    else if (sectype == "有效果图")
                        serchtxt += " and f.curstomerid is not null ";
                    else if (sectype == "无效果图")
                        serchtxt += " and f.curstomerid is  null ";
                    else
                        serchtxt += " and isnull(a.site,'')='" + sectype + "' ";               

                }
                //权限
                if (string.IsNullOrEmpty(khtype))
                {
                    serchtxt += DataAuth(emp_id.ToString());
                }
                //context.Response.Write(serchtxt);

                DataSet ds = customer.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);
            }
            if (request["Action"] == "c_count")
            {
                string serchtxt = " isDelete=0 ";

                if (!string.IsNullOrEmpty(request["T_employee1_val"]))
                    serchtxt += string.Format(" and Employee_id={0}", PageValidate.InputText(request["T_employee1_val"], 50));

                if (!string.IsNullOrEmpty(request["T_customertype"]))
                    serchtxt += " and CustomerType_id = " + int.Parse(request["T_customertype_val"]);

                if (!string.IsNullOrEmpty(request["T_customerlevel"]))
                    serchtxt += " and CustomerLevel_id = " + int.Parse(request["T_customerlevel_val"]);

                if (!string.IsNullOrEmpty(request["T_CustomerSource"]))
                    serchtxt += " and CustomerSource_id = " + int.Parse(request["T_CustomerSource_val"]);

                if (!string.IsNullOrEmpty(request["startdate"]))
                    serchtxt += " and Create_date >= '" + PageValidate.InputText(request["startdate"], 255) + "'";

                if (!string.IsNullOrEmpty(request["enddate"]))
                {
                    DateTime enddate = DateTime.Parse(request["enddate"]).AddHours(23).AddMinutes(59).AddSeconds(59);
                    serchtxt += " and Create_date <= '" + enddate + "'";
                }

                if (!string.IsNullOrEmpty(request["startfollow"]))
                    serchtxt += " and lastfollow >= '" + PageValidate.InputText(request["startfollow"], 255) + "'";

                if (!string.IsNullOrEmpty(request["endfollow"]))
                {
                    DateTime enddate = DateTime.Parse(request["endfollow"]).AddHours(23).AddMinutes(59).AddSeconds(59);
                    serchtxt += " and lastfollow <= '" + enddate + "'";
                }

                DataSet ds = customer.GetList(serchtxt);

                context.Response.Write(ds.Tables[0].Rows.Count);
            }
            //Form JSON
            if (request["Action"] == "form")
            {
                string id = PageValidate.InputText(request["cid"], 50);
                string dt;
                if (PageValidate.IsNumber(id))
                {
                    DataSet ds = customer.GetList("id=" + id + DataAuth(emp_id.ToString()));
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }


                context.Response.Write(dt);
            }
            if (request["Action"] == "formjf")
            {
                string id = PageValidate.InputText(request["cid"], 50);
                string dt;
                if (PageValidate.IsNumber(id))
                {
                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine(" SELECT sum(case jflx when '0' then Jf when '1' then -Jf end)as Jf ,ID ");
                    sb.AppendLine(" FROM dbo.CRM_Jifen ");
                    sb.AppendLine(" WHERE ID='" +id + "'");
                    sb.AppendLine("  group by ID");
                    DataSet ds = XHD.DBUtility.DbHelperSQL.Query(sb.ToString());
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }


                context.Response.Write(dt);
            }
            //Form JSON
            if (request["Action"] == "formsgjd")
            {
                string id = PageValidate.InputText(request["cid"], 50);
                string dt;
                if (PageValidate.IsNumber(id))
                {
                    DataSet ds = customer.GetList("id=" + id);
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }


                context.Response.Write(dt);
            }
            if (request["Action"] == "count")
            {
                string id = request["id"];
                DataSet ds = customer.GetList("id=" + int.Parse(id));

                BLL.CRM_Contact contact = new BLL.CRM_Contact();
                BLL.CRM_contract contract = new BLL.CRM_contract();
                BLL.CRM_order order = new BLL.CRM_order();
                BLL.CRM_Follow follow = new BLL.CRM_Follow();

                int contactcount = 0, contractcount = 0, followcount = 0, ordercount = 0;
                contractcount = contract.GetList(" Customer_id=" + int.Parse(id)).Tables[0].Rows.Count;
                contactcount = contact.GetList(" C_customerid=" + int.Parse(id)).Tables[0].Rows.Count;
                followcount = follow.GetList(" Customer_id=" + int.Parse(id)).Tables[0].Rows.Count;
                ordercount = order.GetList(" Customer_id=" + int.Parse(id)).Tables[0].Rows.Count;

                context.Response.Write(string.Format("{0}联系人, {2}跟进, {3}订单，{1}合同 ", contactcount, contractcount, followcount, ordercount));
            }
            //预删除
            if (request["Action"] == "AdvanceDelete")
            {
                string id = request["id"];

                DataSet ds = customer.GetList("id=" + int.Parse(id));

                BLL.CRM_Contact contact = new BLL.CRM_Contact();
                BLL.CRM_contract contract = new BLL.CRM_contract();
                BLL.CRM_order order = new BLL.CRM_order();
                BLL.CRM_Follow follow = new BLL.CRM_Follow();

                int contactcount = 0, contractcount = 0, followcount = 0, ordercount = 0;
                contractcount = contract.GetList(" isDelete=0 and Customer_id=" + int.Parse(id)).Tables[0].Rows.Count;
                contactcount = contact.GetList(" isDelete=0 and C_customerid=" + int.Parse(id)).Tables[0].Rows.Count;
                followcount = follow.GetList(" isDelete=0 and Customer_id=" + int.Parse(id)).Tables[0].Rows.Count;
                ordercount = order.GetList(" isDelete=0 and Customer_id=" + int.Parse(id)).Tables[0].Rows.Count;

                if (contractcount > 0 || contactcount > 0 || followcount > 0 || ordercount > 0)
                {
                    string returntxt = "";
                    if (contactcount > 0) returntxt += string.Format("{0}联系人 ", contactcount);
                    if (followcount > 0) returntxt += string.Format("{0}跟进 ", followcount);
                    if (ordercount > 0) returntxt += string.Format("{0}订单 ", ordercount);
                    if (contractcount > 0) returntxt += string.Format("{0}合同 ", contractcount);
                    context.Response.Write(returntxt);
                    return;
                }

                bool canedel = true;
                if (uid != "admin")
                {
                    Data.GetDataAuth dataauth = new Data.GetDataAuth();
                    string txt = dataauth.GetDataAuthByid("1", "Sys_del", emp_id.ToString());

                    string[] arr = txt.Split(':');
                    switch (arr[0])
                    {
                        case "none":
                            canedel = false;
                            break;
                        case "my":
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                if (ds.Tables[0].Rows[i]["Employee_id"].ToString() == arr[1])
                                    canedel = true;
                                else
                                    canedel = false;
                            }
                            break;
                        case "dep":
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                if (ds.Tables[0].Rows[i]["Department_id"].ToString() == arr[1])
                                    canedel = true;
                                else
                                    canedel = false;
                            }
                            break;
                        case "all":
                            canedel = true;
                            break;
                    }
                }
                if (canedel)
                {
                    bool isdel = customer.AdvanceDelete(int.Parse(request["id"]), 1, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                    if (isdel)
                    {
                        //日志
                        string EventType = "客户预删除";

                        int UserID = emp_id;
                        string UserName = empname;
                        string IPStreet = request.UserHostAddress;
                        int EventID = int.Parse(id);
                        string EventTitle = ds.Tables[0].Rows[0]["Customer"].ToString();
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
                else
                {
                    context.Response.Write("delfalse");
                }
            }

            if (request["Action"] == "Send_aliyunSendSMS")
            {

                string tel = PageValidate.InputText(request["tel"], int.MaxValue);
                string type = PageValidate.InputText(request["type"], 50);
                string para = request["para"] ; 
             XHD.CRM.Data.sms sms = new Data.sms();
             string aa = sms.aliyunSendSMS(tel,type,para);
             if(aa=="200")
             {
                 string sql = " INSERT INTO dbo.SMS_log" +
                            "        ( sendcontent ," +
                            "          DoTime ," +
                            "          DoPerson ," +
                            "          DoStyle ," +
                            "          smsphone ," +
                            "          smscount" +
                            "        )" +
                            " VALUES  ( '" + para + "' ,  " +
                            "          getdate() ,  " +
                            "          '"+empname+"' , " +
                            "          '群发短信' , " +
                            "          '" + tel + "' , " +
                            "          " + tel.Split(';').Length + " " +
                            "        )";
                 DBUtility.DbHelperSQL.ExecuteSql(sql);
                 context.Response.Write("true");
             }

             else context.Response.Write("false");
            }

         if (request["Action"] == "getDefaultCity")
            {
                Model.hr_employee employee = new Model.hr_employee();
                context.Response.Write(employee.default_city);
         }
            if (request["Action"] == "getMapList")
            {


                string serchtxt = " isDelete=0 and xy is not null";
                if (!string.IsNullOrEmpty(request["companyid"]))
                    serchtxt += " and id =" + int.Parse(request["companyid"]);

                if (!string.IsNullOrEmpty(request["company"]))
                    serchtxt += " and Customer like N'%" + PageValidate.InputText(request["company"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["address"]))
                    serchtxt += " and address like N'%" + PageValidate.InputText(request["address"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["industry"]))
                    serchtxt += " and industry like N'%" + PageValidate.InputText(request["industry"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["tel"]))
                    serchtxt += " and tel like N'%" + PageValidate.InputText(request["tel"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["emp_hh"]))
                    serchtxt += " and emp_hh like N'%" + PageValidate.InputText(request["emp_hh"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["mobil"]))
                    serchtxt += " and mobil like N'%" + PageValidate.InputText(request["mobil"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["qq"]))
                    serchtxt += " and QQ like N'%" + PageValidate.InputText(request["qq"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["cus_sourse"]))
                    serchtxt += " and CustomerSource like N'%" + PageValidate.InputText(request["cus_sourse"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["WXZHT"]))
                    serchtxt += " and WXZT_NAME like N'%" + PageValidate.InputText(request["WXZHT"], 255) + "%'";

                string keyword = PageValidate.InputText(request["keyword"], 500);
                if (!string.IsNullOrEmpty(keyword) && keyword != "输入关键词搜索地址、描述、备注")
                {
                    serchtxt += string.Format(" and ( Customer like N'%{0}%' or tel  like N'%{0}%' or Community like N'%{0}%' or hxt like N'%{0}%' or address like N'%{0}%' or DesCripe like N'%{0}%' or Remarks like N'%{0}%' or Emp_hh like N'%{0}%' ) ", keyword);
                }
                string t_mapstasus = PageValidate.InputText(request["t_mapstasus"], 50);
                if (!string.IsNullOrEmpty(t_mapstasus))
                {
                    if (t_mapstasus == "已标地图")
                        serchtxt += " and isnull(xy,'')!='' ";
                    else if (t_mapstasus == "未标地图")
                        serchtxt += " and isnull(xy,'')='' ";
                }
                string keyword1 = PageValidate.InputText(request["keyword1"], 500);
                if (!string.IsNullOrEmpty(keyword1) && keyword1 != "输入关键词搜索")
                {
                    serchtxt += string.Format(" and ( Customer like N'%{0}%' or tel  like N'%{0}%' or Community like N'%{0}%'  or hxt like N'%{0}%' or address like N'%{0}%' or DesCripe like N'%{0}%' or Remarks like N'%{0}%' or Emp_hh like N'%{0}%' ) ", keyword1);
                }
                if (!string.IsNullOrEmpty(request["customertype"]))
                    serchtxt += " and CustomerType_id = " + int.Parse(request["customertype_val"]);

                if (!string.IsNullOrEmpty(request["customerlevel"]))
                    serchtxt += " and CustomerLevel_id = " + int.Parse(request["customerlevel_val"]);

                if (!string.IsNullOrEmpty(request["T_CustomerSource"]))
                    serchtxt += " and CustomerSource_id = " + int.Parse(request["T_CustomerSource_val"]);

                if (!string.IsNullOrEmpty(request["T_Community"]))
                    serchtxt += " and Community_id = " + int.Parse(request["T_Community_val"]);

                if (!string.IsNullOrEmpty(request["T_Towns"]))
                    serchtxt += " and Towns_id = " + int.Parse(request["T_Towns_val"]);

                if (!string.IsNullOrEmpty(request["T_Provinces"]))
                    serchtxt += " and Provinces_id = " + int.Parse(request["T_Provinces_val"]);

                if (!string.IsNullOrEmpty(request["T_City"]))
                    serchtxt += " and City_id = " + int.Parse(request["T_City_val"]);

                if (!string.IsNullOrEmpty(request["department"]))
                    serchtxt += " and Department_id = " + int.Parse(request["department_val"]);

                if (!string.IsNullOrEmpty(request["employee"]))
                    serchtxt += " and Employee_id = " + int.Parse(request["employee_val"]);

                if (!string.IsNullOrEmpty(request["department_sg"]))
                    serchtxt += " and Dpt_id_sg = " + int.Parse(request["department_sg_val"]);

                if (!string.IsNullOrEmpty(request["employee_sg"]))
                    serchtxt += " and Emp_id_sg = " + int.Parse(request["employee_sg_val"]);

                if (!string.IsNullOrEmpty(request["department_sj"]))
                    serchtxt += " and Dpt_id_sj = " + int.Parse(request["department_sj_val"]);

                if (!string.IsNullOrEmpty(request["employee_sj"]))
                    serchtxt += " and Emp_id_sj = " + int.Parse(request["employee_sj_val"]);

                if (!string.IsNullOrEmpty(request["startdate"]))
                    serchtxt += " and a.Create_date >= '" + PageValidate.InputText(request["startdate"], 255) + "'";

                if (!string.IsNullOrEmpty(request["enddate"]))
                {
                    DateTime enddate = DateTime.Parse(request["enddate"]).AddHours(23).AddMinutes(59).AddSeconds(59);
                    serchtxt += " and a.Create_date <= '" + enddate + "'";
                }

                if (!string.IsNullOrEmpty(request["startdate_del"]))
                    serchtxt += " and Delete_time >= '" + PageValidate.InputText(request["startdate_del"], 255) + "'";

                if (!string.IsNullOrEmpty(request["enddate_del"]))
                {
                    DateTime enddatedel = DateTime.Parse(request["enddate_del"]).AddHours(23).AddMinutes(59).AddSeconds(59);
                    serchtxt += " and Delete_time <= '" + enddatedel + "'";
                }

                if (!string.IsNullOrEmpty(request["startfollow"]))
                    serchtxt += " and lastfollow >= '" + PageValidate.InputText(request["startfollow"], 255) + "'";

                if (!string.IsNullOrEmpty(request["endfollow"]))
                {
                    DateTime enddate = DateTime.Parse(request["endfollow"]).AddHours(23).AddMinutes(59).AddSeconds(59);
                    serchtxt += " and lastfollow <= '" + enddate + "'";
                }
                //权限
                //serchtxt += DataAuth();
                DataSet ds = customer.GetMapList(serchtxt);
                string dt = GetGridJSON.DataTableToJSON(ds.Tables[0]);
                if(dt=="")
                {
                    dt = "{}";
                }


                context.Response.Write(dt);
            }

            if (request["Action"] == "getBMapList")
            {


                string serchtxt = " xy is not null";
                //权限
                //serchtxt += DataAuth();
                DataSet ds = customer.GetBMapList(serchtxt);
                string dt = GetGridJSON.DataTableToJSON(ds.Tables[0]);
                if (dt == "")
                {
                    dt = "{}";
                }


                context.Response.Write(dt);
            }
            if (request["Action"] == "getGYSMapList")
            {


                string serchtxt = " xy is not null";
                //权限
                //serchtxt += DataAuth();
                DataSet ds = customer.GetGYSMapList(serchtxt);
                string dt = GetGridJSON.DataTableToJSON(ds.Tables[0]);
                if (dt == "")
                {
                    dt = "{}";
                }


                context.Response.Write(dt);
            }
            //regain            
            if (request["Action"] == "regain")
            {
                string idlist = PageValidate.InputText(request["idlist"], int.MaxValue);
                string[] arr = idlist.Split(',');

                DataSet ds = customer.GetList("id in (" + idlist.Trim() + ")");

                //日志   
                string EventType = "恢复删除客户";
                int UserID = emp_id;
                string UserName = empname;

                string IPStreet = request.UserHostAddress;
                string Original_txt = null;
                string Current_txt = null;

                int success = 0, failure = 0;   //计数
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    bool isregain = customer.AdvanceDelete(int.Parse(arr[i]), 0, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                    if (isregain)
                    {
                        C_Sys_log log = new C_Sys_log();
                        int EventID = int.Parse(ds.Tables[0].Rows[i]["id"].ToString());
                        string EventTitle = ds.Tables[0].Rows[i]["Customer"].ToString();
                        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, null, Original_txt, Current_txt);
                        success++;
                    }
                    else
                    {
                        failure++;
                    }
                }
                context.Response.Write(string.Format("{0}恢复成功,{1}失败", success, failure));

            }

            if (request.Params["Action"] == "del")
            {
                bool canDel = false;
                if (dsemp.Tables[0].Rows.Count > 0)
                {
                    if (dsemp.Tables[0].Rows[0]["uid"].ToString() == "admin")
                    {
                        canDel = true;
                    }
                    else
                    {
                        Data.GetAuthorityByUid getauth = new Data.GetAuthorityByUid();
                        string delauth = getauth.GetBtnAuthority(emp_id.ToString(), "60");
                        if (delauth == "false")
                            canDel = false;
                        else
                            canDel = true;
                    }
                }
                if (canDel)
                {
                    string idlist = PageValidate.InputText(request["idlist"], int.MaxValue);
                    string[] arr = idlist.Split(',');

                    string EventType = "彻底删除客户";

                    DataSet ds = customer.GetList("id in (" + idlist.Trim() + ")");

                    bool canedel = true;
                    if (uid != "admin")
                    {
                        Data.GetDataAuth dataauth = new Data.GetDataAuth();
                        string txt = dataauth.GetDataAuthByid("1", "Sys_del", emp_id.ToString());

                        string[] arr1 = txt.Split(':');
                        switch (arr1[0])
                        {
                            case "none":
                                canedel = false;
                                break;
                            case "my":
                                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                                {
                                    if (ds.Tables[0].Rows[i]["Employee_id"].ToString() == arr1[1])
                                        canedel = true;
                                    else
                                        canedel = false;
                                }
                                break;
                            case "dep":
                                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                                {
                                    if (ds.Tables[0].Rows[i]["Department_id"].ToString() == arr1[1])
                                        canedel = true;
                                    else
                                        canedel = false;
                                }
                                break;
                            case "all":
                                canedel = true;
                                break;
                        }
                    }
                    if (canedel)
                    {
                        BLL.CRM_Contact contact = new BLL.CRM_Contact();
                        BLL.CRM_contract contract = new BLL.CRM_contract();
                        BLL.CRM_order order = new BLL.CRM_order();
                        BLL.CRM_Follow follow = new BLL.CRM_Follow();

                        int contactcount = 0, contractcount = 0, followcount = 0, ordercount = 0, success = 0, failure = 0;

                        //日志    
                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            string cid = ds.Tables[0].Rows[i]["id"].ToString();

                            contractcount = contract.GetList(" Customer_id=" + int.Parse(cid)).Tables[0].Rows.Count;
                            contactcount = contact.GetList(" C_customerid=" + int.Parse(cid)).Tables[0].Rows.Count;
                            followcount = follow.GetList(" Customer_id=" + int.Parse(cid)).Tables[0].Rows.Count;
                            ordercount = order.GetList(" Customer_id=" + int.Parse(cid)).Tables[0].Rows.Count;

                            //context.Response.Write( string.Format("{0}联系人, {2}跟进, {3}订单，{1}合同 ", contactcount, contractcount, followcount, ordercount)+":"+(contactcount > 0 || contractcount > 0 || followcount > 0 || ordercount > 0)+" ");

                            if (contactcount > 0 || contractcount > 0 || followcount > 0 || ordercount > 0)
                            {
                                failure++;

                            }
                            else
                            {
                                bool isdel = customer.Delete(int.Parse(cid));
                                if (isdel)
                                {
                                    success++;
                                    int UserID = emp_id;
                                    string UserName = empname;
                                    string IPStreet = request.UserHostAddress;
                                    int EventID = int.Parse(cid);
                                    string EventTitle = ds.Tables[0].Rows[i]["Customer"].ToString();
                                    string Original_txt = null;
                                    string Current_txt = null;

                                    C_Sys_log log = new C_Sys_log();

                                    log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, null, Original_txt, Current_txt);
                                }
                                else
                                {
                                    failure++;
                                }
                            }
                        }
                        context.Response.Write(string.Format("{0}条数据成功删除，{1}条失败。|{1}", success, failure));
                        Caches.CRM_Customer = null;
                    }
                    else
                    {
                        context.Response.Write("delfalse");
                    }
                }
                else
                {
                    context.Response.Write("auth");
                }
            }

            //提交签单
            if (request.Params["Action"] == "subok")
            {
                string customerid = request["customerId"];
                string EventType = "提交签单";
                int success = 0, failure = 0;

                //日志    
                bool issubok = customer.subok(int.Parse(customerid));
                if (issubok)
                {
                    success++;
                    int UserID = emp_id;
                    string UserName = empname;
                    string IPStreet = request.UserHostAddress;
                    int EventID = int.Parse(customerid);
                    string EventTitle = customerid;
                    string Original_txt = null;
                    string Current_txt = null;

                    C_Sys_log log = new C_Sys_log();

                    log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, null, Original_txt, Current_txt);
                    context.Response.Write("true");
                }
                else
                {
                    failure++;
                    context.Response.Write("false");
                }
                //context.Response.Write(string.Format("{0}条数据提交签单成功，{1}条失败。|{1}", success, failure));
                Caches.CRM_Customer = null;
            }

            //validate website
            if (request["Action"] == "validate")
            {
                string company = request["T_company"];
                string customerid = request["T_cid"];
                if (string.IsNullOrEmpty(customerid) || customerid == "null")
                    customerid = "0";

                DataSet ds = customer.GetList("Customer = N'" + PageValidate.InputText(company, 255) + "' and id!=" + int.Parse(customerid));
                //context.Response.Write(" Count:" + ds.Tables[0].Rows.Count);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    //context.Response.Write("false");
                    context.Response.Write("true");
                }
                else
                {
                    context.Response.Write("true");
                }
            }

            if (request["Action"] == "Compared")
            {
                string year1 = PageValidate.InputText(request["year1"], 50);
                string year2 = PageValidate.InputText(request["year2"], 50);
                string month1 = PageValidate.InputText(request["month1"], 50);
                string month2 = PageValidate.InputText(request["month2"], 50);

                DataSet ds = customer.Compared(year1, month1, year2, month2);

                string dt = GetGridJSON.DataTableToJSON(ds.Tables[0]);
                context.Response.Write(dt);
            }

            if (request["Action"] == "Compared_type")
            {
                string year1 = PageValidate.InputText(request["year1"], 50);
                string year2 = PageValidate.InputText(request["year2"], 50);
                string month1 = PageValidate.InputText(request["month1"], 50);
                string month2 = PageValidate.InputText(request["month2"], 50);

                DataSet ds = customer.Compared_type(year1, month1, year2, month2);

                string dt = GetGridJSON.DataTableToJSON(ds.Tables[0]);
                context.Response.Write(dt);

            }

            if (request["Action"] == "Compared_level")
            {
                string year1 = PageValidate.InputText(request["year1"], 50);
                string year2 = PageValidate.InputText(request["year2"], 50);
                string month1 = PageValidate.InputText(request["month1"], 50);
                string month2 = PageValidate.InputText(request["month2"], 50);

                DataSet ds = customer.Compared_level(year1, month1, year2, month2);

                string dt = GetGridJSON.DataTableToJSON(ds.Tables[0]);
                context.Response.Write(dt);
            }

            if (request["Action"] == "Compared_source")
            {
                string year1 = PageValidate.InputText(request["year1"], 50);
                string year2 = PageValidate.InputText(request["year2"], 50);
                string month1 = PageValidate.InputText(request["month1"], 50);
                string month2 = PageValidate.InputText(request["month2"], 50);

                DataSet ds = customer.Compared_source(year1, month1, year2, month2);

                string dt = GetGridJSON.DataTableToJSON(ds.Tables[0]);
                context.Response.Write(dt);
            }

            if (request["Action"] == "Compared_empcusadd")
            {
                var idlist = PageValidate.InputText(request["idlist"].Replace(";", ",").Replace("-", "").Replace("p", ""), int.MaxValue);
                string year1 = PageValidate.InputText(request["year1"], 50);
                string year2 = PageValidate.InputText(request["year2"], 50);
                string month1 = PageValidate.InputText(request["month1"], 50);
                string month2 = PageValidate.InputText(request["month2"], 50);

                if (idlist.Length < 1)
                    idlist = "0";

                BLL.hr_post post = new BLL.hr_post();
                DataSet dspost = post.GetList("post_id in(" + idlist + ")");

                string emplist = "(";

                for (int i = 0; i < dspost.Tables[0].Rows.Count; i++)
                {
                    emplist += dspost.Tables[0].Rows[i]["emp_id"] + ",";
                }
                emplist += "0)";

                //context.Response.Write(emplist);

                DataSet ds = customer.Compared_empcusadd(year1, month1, year2, month2, emplist);

                string dt = Common.GetGridJSON.DataTableToJSON(ds.Tables[0]);
                context.Response.Write(dt);

            }

            if (request["Action"] == "emp_customer")
            {
                var idlist = PageValidate.InputText(request["idlist"].Replace(";", ",").Replace("-", "").Replace("p", ""), int.MaxValue);
                var syear = request["syear"];

                if (idlist.Length < 1)
                    idlist = "0";

                BLL.hr_post post = new BLL.hr_post();
                DataSet dspost = post.GetList("post_id in(" + idlist + ")");

                string emplist = "(";

                for (int i = 0; i < dspost.Tables[0].Rows.Count; i++)
                {
                    emplist += dspost.Tables[0].Rows[i]["emp_id"] + ",";
                }
                emplist += "0)";

                //context.Response.Write(emplist);

                DataSet ds = customer.report_empcus(int.Parse(syear), emplist);

                string dt = Common.GetGridJSON.DataTableToJSON(ds.Tables[0]);
                context.Response.Write(dt);
            }



            if (request["Action"] == "ToExcel")
            {
                string serchtxt = " isDelete=0 ";

                if (!string.IsNullOrEmpty(request["companyid"]))
                    serchtxt += " and id =" + int.Parse(request["companyid"]);

                if (!string.IsNullOrEmpty(request["company"]))
                    serchtxt += " and Customer like N'%" + PageValidate.InputText(request["company"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["address"]))
                    serchtxt += " and address like N'%" + PageValidate.InputText(request["address"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["industry"]))
                    serchtxt += " and industry like N'%" + PageValidate.InputText(request["industry"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["tel"]))
                    serchtxt += " and tel like N'%" + PageValidate.InputText(request["tel"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["emp_hh"]))
                    serchtxt += " and emp_hh like N'%" + PageValidate.InputText(request["emp_hh"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["mobil"]))
                    serchtxt += " and mobil like N'%" + PageValidate.InputText(request["mobil"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["qq"]))
                    serchtxt += " and QQ like N'%" + PageValidate.InputText(request["qq"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["website"]))
                    serchtxt += " and site like N'%" + PageValidate.InputText(request["website"], 255) + "%'";

                if (!string.IsNullOrEmpty(request["customertype"]))
                    serchtxt += " and CustomerType_id = " + int.Parse(request["customertype_val"]);

                if (!string.IsNullOrEmpty(request["customerlevel"]))
                    serchtxt += " and CustomerLevel_id = " + int.Parse(request["customerlevel_val"]);

                if (!string.IsNullOrEmpty(request["T_Provinces"]))
                    serchtxt += " and Provinces_id = " + int.Parse(request["T_Provinces_val"]);

                if (!string.IsNullOrEmpty(request["T_City"]))
                    serchtxt += " and City_id = " + int.Parse(request["T_City_val"]);

                if (!string.IsNullOrEmpty(request["department"]))
                    serchtxt += " and Department_id = " + int.Parse(request["department_val"]);

                if (!string.IsNullOrEmpty(request["employee"]))
                    serchtxt += " and Employee_id = " + int.Parse(request["employee_val"]);

                if (!string.IsNullOrEmpty(request["startdate"]))
                    serchtxt += " and Create_date >= '" + PageValidate.InputText(request["startdate"], 255) + "'";

                if (!string.IsNullOrEmpty(request["enddate"]))
                {
                    DateTime enddate = DateTime.Parse(request["enddate"]).AddHours(23).AddMinutes(59).AddSeconds(59);
                    serchtxt += " and Create_date <= '" + enddate + "'";
                }

                if (!string.IsNullOrEmpty(request["startfollow"]))
                    serchtxt += " and lastfollow >= '" + PageValidate.InputText(request["startfollow"], 255) + "'";

                if (!string.IsNullOrEmpty(request["endfollow"]))
                {
                    DateTime enddate = DateTime.Parse(request["endfollow"]).AddHours(23).AddMinutes(59).AddSeconds(59);
                    serchtxt += " and lastfollow <= '" + enddate + "'";
                }

                //权限
                serchtxt += DataAuth(emp_id.ToString());

                DataSet ds = customer.ToExcel(serchtxt);

                HttpResponse respon = context.Response;
                respon.Charset = "utf-8";
                respon.Clear();
                string filename = "客户信息表-" + DateTime.Now.ToString("yyyyMMdd-HHmmss");
                respon.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(filename) + ".xls");
                respon.ContentEncoding = Encoding.UTF8;
                respon.ContentType = "application/octet-stream";

                string style = "<meta http-equiv=\"content-type\" content=\"application/ms-excel; charset=utf-8\"/>"
                    + "<style> .table{ font: 9pt Tahoma, Verdana; color: #000000;   }"
                    + ".table td{text-align:center;border:1px solid #000;}"
                    + ".table th{ font: 9pt Tahoma, Verdana; color: #000000; font-weight: bold; background-color: #8ECBEA;  text-align:center; padding-left:10px;}</style>";

                respon.Write(style);

                string tb_header = "<table class='table'><tr>"
                    + "<th>客户</th>"
                    + "<th>地址</th>"
                    + "<th>电话</th>"
 
                    + "</tr>";
                respon.Write(tb_header);

                DataTable dt = new DataTable();
                dt.TableName = "statistic";
                dt.Columns.Add("客户");
                dt.Columns.Add("地址");
                dt.Columns.Add("电话");

                DataRow dr0 = null, dr1 = null;

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    dr1 = ds.Tables[0].Rows[i];
                    dr0 = dt.NewRow();
                    dr0[0] = dr1["客户"];
                    dr0[1] = dr1["地址"];
                    dr0[2] = dr1["电话"];
                   

                    dt.Rows.Add(dr0);
                }

                foreach (DataRow row in dt.Rows)
                {
                    respon.Write("<tr>");
                    for (int i = 0; i < dt.Columns.Count; i++)
                        respon.Write("<td>" + row[i] + "</td>");
                    respon.Write("</tr>");
                }
                respon.Write("</table>");

                respon.Flush();
                respon.End();
            }
            if (request["Action"] == "import")
            {
                string filename = PageValidate.InputText(request["file"], 50);
                string type = PageValidate.InputText(request["type"], 50);  
                string filepath = context.Server.MapPath(@"~/file/customer/" + filename);

                string myString = "Provider = Microsoft.Jet.OLEDB.4.0 ; Data Source =  " + filepath + ";Extended Properties=Excel 8.0";
                OleDbConnection oconn = new OleDbConnection(myString);
                oconn.Open();
                DataSet ds = new DataSet();
                OleDbDataAdapter oda = new OleDbDataAdapter("select * from [Sheet1$]", oconn);
                oda.Fill(ds);
                oconn.Close();
                 foreach(DataRow dw in ds.Tables[0].Rows)
                 {
                     DataSet codeds = customer.GetList(" tel='" + dw["电话"].ToString() + "' ");
                     //and id!=" + PageValidate.InputText(request["cid"], 50) + " ");
                     if (codeds.Tables[0].Rows.Count > 0)
                     {
                         context.Response.Write("电话:" + dw["电话"].ToString()+"已存在！");
                         return;
                     }
                 }

                 string dt = Common.GetGridJSON.DataTableToJSON(ds.Tables[0]);
                 context.Response.Write(dt);
               
                string connectionString = XHD.DBUtility.PubConstant.ConnectionString;
                //context.Response.Write(connectionString);
                SqlConnection conn = new SqlConnection(connectionString);
                conn.Open();
                using (SqlBulkCopy sqlBC = new SqlBulkCopy(conn))
                {
                    sqlBC.BatchSize = 1000;
                    sqlBC.BulkCopyTimeout = 3600;
                    sqlBC.NotifyAfter = 10000;

                    //sqlBC.SqlRowsCopied += new SqlRowsCopiedEventHandler(OnSqlRowsCopied); 阶段性完成事件呼叫

                    sqlBC.DestinationTableName = "dbo.CRM_Customer";

                    sqlBC.ColumnMappings.Add("客户姓名", "Customer");
                    sqlBC.ColumnMappings.Add("地址", "address");
                    sqlBC.ColumnMappings.Add("电话", "tel");
                   

                    sqlBC.WriteToServer(ds.Tables[0]);
                }
                try
                {
                    customer.ToImport(emp_id, empname, DateTime.Now,type);
                }
                catch
                {

                }
            }
            if (request["Action"] == "tt")
            {
                DataSet ds = customer.GetAllList();
                Random rd = new Random();
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    int k = rd.Next(1, 210);
                    string key = "", value = "";

                    if (k < 10)
                    {
                        key = "86";
                        value = "已成交";
                    }
                    else if (k < 30)
                    {
                        key = "77";
                        value = "感兴趣";
                    }
                    else if (k < 60)
                    {
                        key = "85";
                        value = "非常有意向";
                    }
                    else if (k < 100)
                    {
                        key = "84";
                        value = "稍有意向";
                    }
                    else if (k < 150)
                    {
                        key = "82";
                        value = "非常感兴趣";
                    }
                    else
                    {
                        key = "58";
                        value = "毫无意向";
                    }

                    StringBuilder strSql = new StringBuilder();



                    strSql.Append(string.Format(" update CRM_Customer set CustomerType_id={0},CustomerType='{1}' where id={2} ", key, value, dr["id"]));

                    XHD.DBUtility.DbHelperSQL.Query(strSql.ToString());
                    Caches.CRM_Customer = null;
                }
            }

            //全景API
            if (request["Action"] == "getqjapi")
            {
                string openid = "";
              DataSet ds=    emp.GetAllList();
                
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (dr["professional"].ToString().Length > 15)
                        openid =openid+","+ dr["professional"].ToString();
                }
                if (openid == "")
                {
                    context.Response.Write("false:没有任何有效openid");
                    return;
                }
                openid = openid.Substring(1);
                string tel = Common.PageValidate.InputText(request["tel"], 50);
                // Common.PageValidate.InputText(request["designId"], 50)
                string api = "https://www.33qjvr.com/api/case?act=casebyphone&";
                //code=13451760505&openid=5248c9be8592751a58b8eef6258e6578
                object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                string timestamp = currenttimemillis.ToString(); //2分钟

                StringBuilder apiBuilder = new StringBuilder();
                apiBuilder.Append(api)
                .Append("&code=").Append(tel)
                .Append("&openid=").Append(openid);
                string result = "";
                //var result = HttpHelper_GetStr(apiurl + apikey + "/key/" + keytel, "GET", buffer.ToString());
                result = HttpHelper_GetStr(apiBuilder.ToString(), "GET", "");
                Newtonsoft.Json.Linq.JObject joo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(result);
                Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject( "{"+joo["data"].First.Last.ToString()+"}");

               
                DataTable dtjson = JsonToDataTable(jo["project"].ToString());
                string dt = Common.GetGridJSON.DataTableToJSON1(dtjson, "99");

                context.Response.Write(dt);
            }

        }

        private int StrToInt(string str)
        {
            int a = 0;
            try {
                a = int.Parse(str);
            } catch { }

            return a;
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
                            returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or a.Create_id=" + int.Parse(arr[1]) + " or Emp_id_hh=" + int.Parse(arr[1]) + " )";
                            break;
                        case "dep":
                            if (string.IsNullOrEmpty(arr[1]))
                                returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(uid) + " or Emp_id_sg=" + int.Parse(uid) + " or Emp_id_sj=" + int.Parse(uid) + " or a.Create_id=" + int.Parse(uid) + " or Emp_id_hh=" + int.Parse(uid) + "  )";
                            else
                                returntxt = " and ( privatecustomer='公客' or Department_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or a.Create_id=" + int.Parse(uid) + " or Emp_id_hh=" + int.Parse(uid) + ")";
                            break;
                        case "depall":
                            BLL.hr_department dep = new BLL.hr_department();
                            DataSet ds = dep.GetAllList();
                            string deptask = GetDepTask(int.Parse(arr[1]), ds.Tables[0]);
                            string intext = arr[1] + "," + deptask;

                            returntxt = " and ( privatecustomer='公客' or a.Create_id=" + int.Parse(uid) + "  or Department_id in (" + intext.TrimEnd(',') + ") or Dpt_id_sg in (" + intext.TrimEnd(',') + ") or Dpt_id_sj in (" + intext.TrimEnd(',') + "))";
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="url"></param>
        /// <param name="method">"POST"/"GET"/"PUT "</param>
        /// <param name="postdatastr"></param>
        /// <returns></returns>
        private string HttpHelper_GetStr(string url, string method, string postdatastr)
        {
            HttpHelper http = new HttpHelper();
            HttpItem item = new HttpItem()
            {
                URL = url,
                //"http://partnertest.kujiale.com/p/openapi/login",//URL     必需项
                Method = method,//URL     可选项 默认为Get
                Timeout = 100000,//连接超时时间     可选项默认为100000
                ReadWriteTimeout = 30000,//写入Post数据超时时间     可选项默认为30000
                IsToLower = false,//得到的HTML代码是否转成小写     可选项默认转小写
                Cookie = "",//字符串Cookie     可选项
                PostEncoding = Encoding.UTF8,
                Encoding = Encoding.UTF8,//编码格式（utf-8,gb2312,gbk）  
                UserAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:18.0) Gecko/20100101 Firefox/18.0",//用户的浏览器类型，版本，操作系统     可选项有默认值
                Accept = "text/html, application/xhtml+xml, */*",//    可选项有默认值
                ContentType = "application/x-www-form-urlencoded",//返回类型    可选项有默认值
                Referer = "",//来源URL     可选项
                //Allowautoredirect = False,//是否根据３０１跳转     可选项
                //AutoRedirectCookie = False,//是否自动处理Cookie     可选项
                //CerPath = "d:\123.cer",//证书绝对路径     可选项不需要证书时可以不写这个参数
                //Connectionlimit = 1024,//最大连接数     可选项 默认为1024
                Postdata = postdatastr,
                //"appkey=hsjauejdsg&timestamp=1418635917113&appuid=1&sign=FA6A2FDAE016D16ACF6C770DE2F1E70F&appuname=测试用户&appuemail=ceshi@ceshi.com&appuphone=13233333333&appussn=&appuAddr=测试省测试市测试县测试路1号&appuavatar=http://qhyxpic.oss.kujiale.com/avatars/72.jpg", //Post数据     可选项GET时不需要写
                //ProxyIp = "192.168.1.105：2020",//代理服务器ID     可选项 不需要代理 时可以不设置这三个参数
                //ProxyPwd = "123456",//代理服务器密码     可选项
                //ProxyUserName = "administrator",//代理服务器账户名     可选项
                ResultType = ResultType.String,//返回数据类型，是Byte还是String
            };
            HttpResult result = http.GetHtml(item);
            string html = result.Html;
            return html;
        }

        /// <summary>   
        /// 将 Json 解析成 DateTable。  
        /// Json 数据格式如: 
        ///     {table:[{column1:1,column2:2,column3:3},{column1:1,column2:2,column3:3}]} /// </summary>   
        /// <param name="strJson">要解析的 Json 字符串</param>   
        /// <returns>返回 DateTable</returns>   
        public static DataTable JsonToDataTable(string strJson)
        {
            if (strJson.Length < 55) return null;
            // 取出表名   
            var rg = new Regex(@"(?<={)[^:]+(?=:\[)", RegexOptions.IgnoreCase);
            string strName = strJson;// rg.Match(strJson).Value;
            DataTable tb = null;
            
            // 去除表名   
            strJson = strJson.Substring(strJson.IndexOf("[") + 1);
            strJson = strJson.Substring(0, strJson.IndexOf("]"));
           // 去除字符串中的空格，回车，换行符，制表符
            strJson = strJson.Replace("\n", "").Replace(" ", "").Replace("\t", "").Replace("\r", "");
            // 获取数据   
            rg = new Regex(@"(?<={)[^}]+(?=})");
            MatchCollection mc = rg.Matches(strJson);
            for (int i = 0; i < mc.Count; i++)
            {
                string strRow = mc[i].Value;
                string[] strRows = strRow.Split(',');
                // 创建表   
                if (tb == null)
                {
                    tb = new DataTable();
                    tb.TableName = strName;
                    foreach (string str in strRows)
                    {
                        var dc = new DataColumn();
                        string[] strCell = str.Split(':');
                        dc.ColumnName = strCell[0].Replace("\"", "");
                        tb.Columns.Add(dc);
                    }
                    tb.AcceptChanges();
                }
                // 增加内容   
                DataRow dr = tb.NewRow();
                for (int j = 0; j < strRows.Length; j++)
                {
                    if (strRows[j].Split(':').Length > 2)
                        dr[j] = strRows[j].Split(':')[1].Replace("\"", "") + ":" + strRows[j].Split(':')[2].Replace("\"", "");
                    else dr[j] = strRows[j].Split(':')[1].Replace("\"", "");
                }
                tb.Rows.Add(dr);
                tb.AcceptChanges();
            }
            return tb;
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