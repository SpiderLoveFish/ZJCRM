using System;
using System.Collections.Generic;
using System.Web.Security;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using System.IO;
using XHD.Common;
using XHD.DBUtility;

namespace XHD.CRM.Data
{
    /// <summary>
    /// _base 的摘要说明
    /// </summary>
    public class CKKW : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.KcGl_Jcb_Cklb_KW ccpc = new BLL.KcGl_Jcb_Cklb_KW();
            Model.KcGl_Jcb_Cklb_KW model = new Model.KcGl_Jcb_Cklb_KW();

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();

            if (request["Action"] == "combo")
            {
                string type = PageValidate.InputText(request["type"], 50);
                DataSet ds = GetList(type);

                StringBuilder str = new StringBuilder();

                str.Append("[");
              
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    str.Append("{id:'" + ds.Tables[0].Rows[i]["ID"].ToString() + "',text:'" + ds.Tables[0].Rows[i]["Name"] + "'},");
                }
                str.Replace(",", "", str.Length - 1, 1);
                str.Append("]");

                context.Response.Write(str);
            }
             if (request["Action"] == "save")
            {
                string parentid = PageValidate.InputText( request["T_category_parent_val"],50);
                model.CklbID = int.Parse(parentid);
                model.KWID = Common.PageValidate.InputText(request["T_KW_name"], 250);
                model.Name = Common.PageValidate.InputText(request["T_Name"], 250);
                model.Remark = Common.PageValidate.InputText(request["T_Remark"], 250);
               
                string id = PageValidate.InputText( request["id"],50);
                string pid = PageValidate.InputText( request["T_category_parent_val"],50);
                if (!string.IsNullOrEmpty(id) && id != "null")
                {
                    model.CklbID = int.Parse(pid);
                    model.KWID = id;
                    model.EditDate = DateTime.Now;
                    model.EditEmpID = emp_id;
                     ccpc.Update(model);
                    
                }
                else
                {
                    model.InEmpID = emp_id;
                    model.InDate = DateTime.Now;
                    model.IsDel = "N";
                    ccpc.Add(model);
                }
            }
            if (request["Action"] == "form")
            {
                string kwid = PageValidate.InputText(request["id"], 50);
                string ckid = PageValidate.InputText(request["ckid"], 50);
                string dt;
                if (!string.IsNullOrEmpty(kwid))
                {
                    DataSet ds = ccpc.GetList(" KWID='" + kwid + "' and CklbID="+ckid);
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }

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
                string serchtxt = "1=1 AND IsDel='N'";
                //if (!string.IsNullOrEmpty(request["company"]))
                //    serchtxt += " and CKNAME like N'%" + PageValidate.InputText(request["company"], 50) + "%'";

                //if (!string.IsNullOrEmpty(request["startdate_del"]))
                //{
                //    serchtxt += " and Delete_time >= '" + PageValidate.InputText(request["startdate_del"], 50) + "'";
                //}
                //if (!string.IsNullOrEmpty(request["enddate_del"]))
                //{
                //    DateTime enddate = DateTime.Parse(request["enddate_del"]);
                //    serchtxt += " and Delete_time  <= '" + enddate.AddHours(23).AddMinutes(59).AddSeconds(59) + "'";
                //}
                //权限


                string dt = "";
                
                    DataSet ds = ccpc.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                
                context.Response.Write(dt);
            }
            if (request["Action"] == "del")
            {
                //参数安全过滤
                string KWID = PageValidate.InputText(request["id"], 50);
                string CKID = PageValidate.InputText(request["ckid"], 50);
          
                bool isdel = ccpc.UpdateDel(KWID, int.Parse(CKID), "Y");
                    if (isdel)
                    { context.Response.Write("true"); }
                    else
                    {
                        context.Response.Write("false");
                    }
            }
        }

        public DataSet GetList(string type)
        {
            StringBuilder strSql = new StringBuilder();
            if (type=="CK")
                strSql.Append("SELECT   * FROM KcGl_Jcb_Cklb	WHERE ISNULL(IsDel,'N')='N' ");
             else
                strSql.Append("SELECT   KWID AS ID,* FROM [dbo].[KcGl_Jcb_Cklb_KW]	WHERE ISNULL(IsDel,'N')='N' AND CklbID=" + type);
            return DbHelperSQL.Query(strSql.ToString());
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