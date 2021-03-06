﻿using System;
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
    public class carmanage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.Car_Basic ccpc = new BLL.Car_Basic();
            Model.Car_Basic model = new Model.Car_Basic();

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
                model.cartype = PageValidate.InputText(request["T_lb"], 100);
                model.cartype_id = StringToInt(PageValidate.InputText(request["T_lb_val"], 50));
                model.carNumber = PageValidate.InputText(request["T_carNo"], 100);
                model.carFrame = PageValidate.InputText(request["T_carFrame"], 100);
                model.carbuydate = StringToDate(PageValidate.InputText(request["T_buydate"], 100));
                model.lastMOT = StringToDate(PageValidate.InputText(request["T_lastMOT"], 100));
                model.LastTimeInsured = StringToDate(PageValidate.InputText(request["T_LastTimeInsured"], 100));
                model.MOTgapYear = StringToInt(PageValidate.InputText(request["T_MOTgapYear"], 100));
                model.CurrentKM = StringToInt(PageValidate.InputText(request["T_KM"], 100));
                model.Remarks = PageValidate.InputText(request["T_remarks"], 100);
                model.leadPerson= PageValidate.InputText(request["T_lead"], 100);
                model.engine_number = PageValidate.InputText(request["T_engine_number"], 100);

                string xmid = PageValidate.InputText(request["id"], 50);

                 if (!string.IsNullOrEmpty(xmid) && xmid != "null")
                 {
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
                    
                    ccpc.Add(model);
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

                string dt = "";

                DataSet ds = ccpc.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);
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
                if(ccpc.UpdateStatus(id,"",""))
                    context.Response.Write("true");
                else context.Response.Write("false");
            }
            //del
            if (request["Action"] == "del")
            {
                //参数安全过滤
                string c_id = PageValidate.InputText(request["id"], 50);

                //DataSet ds = ccpc.GetList(" id=" + int.Parse(c_id));
                if (ccpc.Exists_IsUse(int.Parse(c_id)))
                {
                    context.Response.Write("false:exist");
                }
                else
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