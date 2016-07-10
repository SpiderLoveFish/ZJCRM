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
    /// public_data 的摘要说明
    /// </summary>
    public class public_data : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.public_data ccp = new BLL.public_data();
            Model.public_data model = new Model.public_data();

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
                model.create_id = emp_id;
                model.create_name = empname;
                model.create_time = DateTime.Now;

                model.category_id = int.Parse(request["T_category_val"]);
                model.category_name = PageValidate.InputText(request["T_category"], 255);
                model.title = PageValidate.InputText(request["T_title"], 255);
                model.t_content = PageValidate.InputText(request["T_content"], int.MaxValue);
                model.orderid = int.Parse(request["T_orderid"]);
                model.qxbd = PageValidate.InputText(request["T_qxbd"], 1000);
                
                string pid = PageValidate.InputText(request["pid"], 50);
                if (!string.IsNullOrEmpty(pid) && pid != "null")
                {
                    model.id = int.Parse(PageValidate.IsNumber(pid) ? pid : "-1");
                    //DataSet ds = ccp.GetList(" id=" + int.Parse(pid));
                    //DataRow dr = ds.Tables[0].Rows[0];
                    //model.create_id = int.Parse(dr["create_id"].ToString());
                    //model.create_name = dr["create_name"].ToString();
                    ccp.Update(model);
                }
                else
                {
                    model.isDelete = 0;
                    ccp.Add(model);
                }
            }

            if (request["Action"] == "grid")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " orderid";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " asc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                if (!string.IsNullOrEmpty(request["categoryid"]))
                    serchtxt += string.Format(" and category_id={0}", int.Parse(request["categoryid"]));

                if (!string.IsNullOrEmpty(request["stext"]))
                    serchtxt += " and title like N'%" + PageValidate.InputText(request["stext"], 255) + "%'";

                //权限
                DataSet ds = ccp.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);
            }
            if (request["Action"] == "form")
            {
                int pid = int.Parse(request["pid"]);
                DataSet ds = ccp.GetList(" id=" + pid);

                string dt = Common.DataToJson.DataToJSON(ds);

                context.Response.Write(dt);
            }
            //del
            if (request["Action"] == "del")
            {
                //参数安全过滤
                string c_id = PageValidate.InputText(request["id"], 50);
                DataSet ds = ccp.GetList(" id=" + int.Parse(c_id));

                bool isdel = ccp.Delete(int.Parse(c_id));
                if (isdel)
                {
                    //日志
                    string EventType = "系统帮助删除";

                    int UserID = emp_id;
                    string UserName = empname;
                    string IPStreet = request.UserHostAddress;
                    int EventID = int.Parse(c_id);
                    string EventTitle = ds.Tables[0].Rows[0]["title"].ToString();
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

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}