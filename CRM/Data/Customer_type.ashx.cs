using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;
using XHD.Common;
using System.Web.Security;
using XHD.DBUtility;

namespace XHD.CRM.Data
{
    /// <summary>
    /// hr_position 的摘要说明
    /// </summary>
    public class Customer_type : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.crm_customer_type ffc = new BLL.crm_customer_type();
            Model.crm_customer_type model = new Model.crm_customer_type();

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();

            if (request["Action"] == "grid")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " a.id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;
                if (string.IsNullOrEmpty(sorttext))
                    sorttext += " ,a.id asc";

                string Total;
                
                string serchtxt = "1=1";
                string keyword = request["keyword1"];
                if (!string.IsNullOrEmpty(keyword) && keyword != "输入关键词搜索")
                {
                    serchtxt += " and (params_name LIKE '%" + keyword + "%'  )";
                }

              
                //context.Response.Write(serchtxt);

                DataSet ds = ffc.GetListDetail(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);

            }

            //save
            if (request["Action"] == "save")
            {

                string T_remarks = PageValidate.InputText(request["T_remarks"], 255); //int.Parse(request["T_remarks"]);
               
                string typeid = PageValidate.InputText(request["typeid_val"], 55);
                model.typeid = int.Parse(typeid);
                string followhours = PageValidate.InputText(request["followhours"], 55);
                model.followhours = decimal.Parse(followhours);
                model.remarks = T_remarks;

                string id = PageValidate.InputText(request["id"], 250);
                model.createperson = empname;
                model.createtime = DateTime.Now;
                if (!string.IsNullOrEmpty(id) && id != "null")
                {
                  
                    ffc.Update(model);
                }  else
                {
    
                    ffc.Add(model);
                }
            }
             
            //Form JSON
            if (request["Action"] == "form")
            {
                string id = PageValidate.InputText(request["id"],50);

                DataSet ds = ffc.GetList(" a.id='" +   id+"'" );

                string dt = Common.DataToJson.DataToJSON(ds);

                context.Response.Write(dt);
            }
           
            if (request["Action"] == "del")
            {
                string id = PageValidate.InputText(request["id"],50) ;
                model.id =  int.Parse( id); 
                if (ffc.Update(model))
                {
                    context.Response.Write("true");
                }
                else
                    {
                        context.Response.Write("false");
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