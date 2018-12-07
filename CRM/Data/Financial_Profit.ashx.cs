using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;
using XHD.Common;
using System.Web.Security;

namespace XHD.CRM.Data
{
    /// <summary>
    /// hr_position 的摘要说明
    /// </summary>
    public class Financial_Profit : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.Financial_Profit ffc = new BLL.Financial_Profit();
            Model.Financial_Profit model = new Model.Financial_Profit();

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
                    sortname = " id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;
                if (string.IsNullOrEmpty(sorttext))
                    sorttext += " ,id asc";

                string Total;
                
                string serchtxt = "1=1";
                //context.Response.Write(serchtxt);

                DataSet ds = ffc.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);

            }

            //save
            if (request["Action"] == "save")
            {
                 
                string T_fylx = PageValidate.InputText(request["T_fylx"], 25);
                string T_fylx_val = PageValidate.InputText(request["T_fylx_val"], 25);

                string Formula = PageValidate.InputText(request["T_gs"], 55);
                string T_remarks = PageValidate.InputText(request["T_remarks"], 255); //int.Parse(request["T_remarks"]);
                string T_company = PageValidate.InputText(request["T_company"], 255);
                string T_sjs = PageValidate.InputText(request["T_sjs"], 255);
                string T_sgjl = PageValidate.InputText(request["T_sgjl"], 255);
                string T_ywy = PageValidate.InputText(request["T_ywy"], 255);

                string T_gs_status = PageValidate.InputText(request["T_gs_status"], 20);
                string T_ywy_status = PageValidate.InputText(request["T_ywy_status"], 20);
                string T_sgjl_status = PageValidate.InputText(request["T_sgjl_status"], 20);
                string T_sjs_status = PageValidate.InputText(request["T_sjs_status"], 20);
                string T_company_status = PageValidate.InputText(request["T_company_status"], 20);

               // model.F_StyleID = int.Parse(T_fylx_val);
                model.F_StyleName = T_fylx;
                model.Remarks = T_remarks;
                model.sgjl_Profit = T_sgjl_status + "|" + T_sgjl;
                model.sjs_Profit = T_sjs_status + "|" + T_sjs;
                model.Company_Profit = T_company_status+"|"+ T_company;
                model.ywy_Profit = T_ywy_status + "|" + T_ywy;
                model.Formula = T_gs_status + "|" + Formula;


                string id = PageValidate.InputText(request["fid"], 250);

                if (!string.IsNullOrEmpty(id) && id != "null")
                {
                    model.id = int.Parse(id);
                    ffc.Update(model);
                }
                    //    model.id = int.Parse(id);
                    //    DataSet ds = zw.GetList(" id=" + int.Parse(id));
                    //    DataRow dr = ds.Tables[0].Rows[0];
                    //    zw.Update(model);

                    //    //日志
                    //    C_Sys_log log = new C_Sys_log();

                    //    int UserID = emp_id;
                    //    string UserName = empname;
                    //    string IPStreet = request.UserHostAddress;
                    //    string EventTitle = model.position_name;
                    //    string EventType = "职位修改";
                    //    int EventID = model.id;

                    //    if (dr["position_name"].ToString() != request["T_position"])
                    //    {
                    //        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "职务名称", dr["position_name"].ToString(), request["T_position"]);
                    //    }
                    //    if (dr["position_level"].ToString() != request["T_level"])
                    //    {
                    //        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "职务级别", dr["position_level"].ToString(), request["T_level"]);
                    //    }
                    //    if (dr["position_order"].ToString() != request["T_order"])
                    //    {
                    //        log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, "行号", dr["position_order"].ToString(), request["T_order"]);
                    //    }
                    //}
                     else
                {
                    
                    ffc.Add(model);
                }
            }
            //Form JSON
            if (request["Action"] == "form")
            {
                string id = PageValidate.InputText(request["fid"],50);

                DataSet ds = ffc.GetList("id= " +   id  );

                string dt = Common.DataToJson.DataToJSON(ds);

                context.Response.Write(dt);
            }
           
            if (request["Action"] == "del")
            {
                string id = PageValidate.InputText(request["fid"],50) ;
                
                if (ffc.Delete(int.Parse(id)))
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