using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;
using XHD.Common;
using System.Web.Security;
using XHD.DBUtility;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace XHD.CRM.Data
{
    /// <summary>
    /// hr_position 的摘要说明
    /// </summary>
    public class Financial_Change_Cost : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.Financial_Change_Cost ffc = new BLL.Financial_Change_Cost();
            Model.Financial_Change_Cost model = new Model.Financial_Change_Cost();

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
                    sortname = " F_Num";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;
                if (string.IsNullOrEmpty(sorttext))
                    sorttext += " ,F_Num asc";

                string Total;
                
                string serchtxt = "1=1";
                string keyword = request["keyword1"];
                if (!string.IsNullOrEmpty(keyword) && keyword != "输入关键词搜索")
                {
                    serchtxt += " and (cwny LIKE '%" + keyword + "%' OR F_StyleName LIKE '%" + keyword+ "%' OR Remarks LIKE '%" + keyword + "%')";
                }
                      
                string IsApr =  request["IsApr"] ;
                if (string.IsNullOrEmpty(IsApr)|| IsApr==null|| IsApr=="null")
                {

                    serchtxt += " and IsStatus in('0','1')";
                }
                else
                {
                    if (IsApr == "Y")
                        serchtxt += " and IsStatus='1'";
                    else if (IsApr == "V")
                        serchtxt += " and 1=1 ";
                 }
                 
                //context.Response.Write(serchtxt);

                DataSet ds = ffc.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);

            }

            //save
            if (request["Action"] == "save")
            {

                string cwny = "";
                string year= PageValidate.InputText(request["T_year"], 25);
                string  month = PageValidate.InputText(request["T_month"], 25);
                if (year == "") year = DateTime.Now.ToString("yyyy");
                if (month == "") month = DateTime.Now.ToString("mm");
                cwny = year + int.Parse(month).ToString("00");
                string T_fylx = PageValidate.InputText(request["T_fylx"], 25);
                string T_fylx_val = PageValidate.InputText(request["T_fylx_val"], 25);
                model.Pay_type_id = int.Parse(request["T_invoice_type_val"].ToString());
                model.Pay_type = PageValidate.InputText(request["T_invoice_type"].ToString(), 255);

                string T_je = PageValidate.InputText(request["T_je"], 55);
                string T_remarks = PageValidate.InputText(request["T_remarks"], 255); //int.Parse(request["T_remarks"]);
                string T_rperson = PageValidate.InputText(request["T_rperson"], 255);

                string IsStatus = PageValidate.InputText(request["IsStatus"], 55);

                model.cwny = cwny;
                model.Amount = decimal.Parse(T_je);
                model.FromWhere = "PC";
                model.F_StyleID = int.Parse( T_fylx_val);
                model.F_StyleName = T_fylx;
                model.Remarks = T_remarks;
                model.RelevantPerson = T_rperson;
                string id = PageValidate.InputText(request["fid"], 250);

                if (!string.IsNullOrEmpty(id) && id != "null")
                {
 
                    model.IsStatus = IsStatus;
                    model.F_Num = id;
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
                    string maxid = ffc.GetMaxID("Change");
                    model.F_Num = maxid;
                    model.IsStatus = IsStatus;
                    model.CreatePerson = empname;
                    model.CreateTime = DateTime.Now;
                    ffc.Add(model);
                }
            }
            if (request["Action"] == "savestatus")
            {
                string IsStatus = PageValidate.InputText(request["IsStatus"], 55);
                string id = PageValidate.InputText(request["fid"], 250);
                StringBuilder sb = new StringBuilder();
                sb.AppendLine(" EXEC [dbo].[Usp_Update_Cost_IsStatus] @fid = '"+id+"', -- varchar(15)  ");
                sb.AppendLine("     @style = 'Change', -- varchar(10)  ");
                sb.AppendLine("     @IsStatus = '"+IsStatus+"' -- varchar(1)  ");
                DbHelperSQL.ExecuteSql(sb.ToString());
            }

            if (request["Action"] == "savesync")
            {
                WX wx = new WX();
                string token = wx.Getaccess_token("3");//审批
                string sp_num = DateTime.Now.Year + DateTime.Now.Month + "010001";
                string data = wx.PostProval(token, DateTime.Now.AddYears(-1), DateTime.Now, sp_num);//next_spnum
                Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(data); //result为上面的Json数据                                                                                                             // var sb = new System.Text.StringBuilder();
                if (jo["errmsg"].Value<string>() == "ok")
                {
                    //result = jo["data"].ToString();
                    wx.InsertWX_Proval(data);
                }
                string cwny = PageValidate.InputText(request["cwny"], 25);
                string sql = "EXEC dbo.Usp_SyncWX_Financial_Change_Cost @cwny = '"+cwny+"' ";
                DbHelperSQL.ExecuteSql(sql);
            }
                //Form JSON
                if (request["Action"] == "form")
            {
                string id = PageValidate.InputText(request["fid"],50);

                DataSet ds = ffc.GetList("F_Num='" +   id+"'" );

                string dt = Common.DataToJson.DataToJSON(ds);

                context.Response.Write(dt);
            }
           
            if (request["Action"] == "del")
            {
                string id = PageValidate.InputText(request["fid"],50) ;
                model.F_Num = id;
                model.DeleteTime = DateTime.Now;
                model.IsStatus = "N";
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