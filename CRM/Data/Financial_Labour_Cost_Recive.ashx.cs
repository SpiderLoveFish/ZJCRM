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
    public class Financial_Labour_Cost_Recive : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.Financial_Labour_Cost_Recive ffc = new BLL.Financial_Labour_Cost_Recive();
            Model.Financial_Labour_Cost_Recive model = new Model.Financial_Labour_Cost_Recive();

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
                    sortname = " rowId";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = "";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = " ISNULL(Customer_name,'')!=''";
                //string order_id = request["orderid"];
                //if (!string.IsNullOrEmpty(order_id) && order_id != "null")
                //    serchtxt += " and orderid=" + int.Parse(order_id);

                string F_Num = request["F_Num"];
                if (!string.IsNullOrEmpty(F_Num) && F_Num != "null")
                    serchtxt += " and Customer_name='" + F_Num + "'";

                if (!string.IsNullOrEmpty(request["company"]))
                    serchtxt += " and Customer_name like N'%" + PageValidate.InputText(request["company"], 250) + "%'";

                if (!string.IsNullOrEmpty(request["receive_num"]))
                    serchtxt += " and Receive_num+remarks like N'%" + PageValidate.InputText(request["receive_num"], 50) + "%'";

                if (!string.IsNullOrEmpty(request["pay_type"]))
                    serchtxt += " and Pay_type_id =" + int.Parse(request["pay_type_val"]);

                //if (!string.IsNullOrEmpty(request["department"]))
                //    serchtxt += " and C_depid =" + int.Parse(request["department_val"]);

                //if (!string.IsNullOrEmpty(request["employee"]))
                //    serchtxt += " and C_empid =" + int.Parse(request["employee_val"]);

                if (!string.IsNullOrEmpty(request["startdate"]))
                    serchtxt += " and Receive_date >= '" + PageValidate.InputText(request["startdate"], 50) + "'";

                if (!string.IsNullOrEmpty(request["enddate"]))
                {
                    DateTime enddate = DateTime.Parse(request["enddate"]);
                    serchtxt += " and Receive_date  <= '" + enddate + "'";
                }
                if (!string.IsNullOrEmpty(request["startdate_del"]))
                {
                    serchtxt += " and Delete_time >= '" + PageValidate.InputText(request["startdate_del"], 50) + "'";
                }
                if (!string.IsNullOrEmpty(request["enddate_del"]))
                {
                    DateTime enddate = DateTime.Parse(request["enddate_del"]).AddHours(23).AddMinutes(59).AddSeconds(59);
                    serchtxt += " and Delete_time  <= '" + enddate + "'";
                }


                //权限
                DataSet ds = ffc.GetList_F_l_C_R(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);
            }


            if (request["Action"] == "save_khjdgl")
            {
                Model.CRM_receive model_receive = new Model.CRM_receive();
                DataRow dremp = dsemp.Tables[0].Rows[0];

                model_receive.Receive_num = PageValidate.InputText(request["T_invoice_num"], 255);

                //string orderid = PageValidate.InputText(request["orderid"], 50);
                BLL.CRM_receive cci = new BLL.CRM_receive();

                string F_Num = PageValidate.InputText(request["F_Num"].ToString(), 255);
                model_receive.Customer_id = int.Parse(request["T_Customer_val"].ToString());
                model_receive.Customer_name = F_Num;
                model_receive.remarks = PageValidate.InputText(request["T_content"].ToString(), 12000);
                model_receive.receive_direction_id = int.Parse(request["T_receive_direction_val"].ToString());
                model_receive.receive_direction_name = PageValidate.InputText(request["T_receive_direction"], 255);
                int i = 1; //1表示收款，-1表示退款
                if (model_receive.receive_direction_id == -1 )
                    i = -1;
                model_receive.C_depid = int.Parse(request["T_dep_val"].ToString());
                model_receive.C_depname = PageValidate.InputText(request["T_dep"].ToString(), 255);
                model_receive.C_empid = int.Parse(request["T_employee_val"].ToString());
                model_receive.C_empname = PageValidate.InputText(request["T_employee1"].ToString(), 255);

                model_receive.receive_real = decimal.Parse(request["T_invoice_amount"]);
                model_receive.Receive_date = DateTime.Parse(request["T_invoice_date"].ToString());
                model_receive.Pay_type_id = int.Parse(request["T_invoice_type_val"].ToString());
                model_receive.Pay_type = PageValidate.InputText(request["T_invoice_type"].ToString(), 255);
                model_receive.remarks = PageValidate.InputText(request["T_content"].ToString(), 12000);
                model_receive.receive_direction_id = int.Parse(request["T_receive_direction_val"].ToString());
                model_receive.receive_direction_name = PageValidate.InputText(request["T_receive_direction"], 255);
                model_receive.Receive_amount = i * model_receive.receive_real;

                string cid = PageValidate.InputText(request["receiveid"], 50);
                if (!string.IsNullOrEmpty(cid) && cid != "null")
                {
                    model_receive.id = int.Parse(PageValidate.IsNumber(cid) ? cid : "-1");

                    DataSet ds = cci.GetList(" id=" + model.id);
                    DataRow dr = ds.Tables[0].Rows[0];

                    cci.Update(model_receive);

                    C_Sys_log log = new C_Sys_log();
                     }
                else
                {
                    model_receive.isDelete = 0;
                    model_receive.create_id = emp_id;
                    model_receive.create_name = dremp["name"].ToString();
                    model_receive.create_date = DateTime.Now;

                    cci.Add(model_receive);
                }
                //更新订单收款金额
                ffc.UpdateReceive(F_Num);
            }


            //save
            if (request["Action"] == "save")
            {

                 
                string T_fylx = PageValidate.InputText(request["T_fylx"], 25);
                string T_fylx_val = PageValidate.InputText(request["T_fylx_val"], 25);
                model.Pay_type_id = int.Parse(request["T_invoice_type_val"].ToString());
                model.Pay_type = PageValidate.InputText(request["T_invoice_type"].ToString(), 255);

                string T_je = PageValidate.InputText(request["T_je"], 55);
                string T_remarks = PageValidate.InputText(request["T_remarks"], 255); //int.Parse(request["T_remarks"]);
                string T_rperson = PageValidate.InputText(request["T_person"], 255);
                string dj = PageValidate.InputText(request["T_dj"], 55);
                string zje = PageValidate.InputText(request["T_zje"], 55);
                string gs = PageValidate.InputText(request["T_gs"], 55);
                string tzje = PageValidate.InputText(request["T_tzje"], 55);
                string sj = PageValidate.InputText(request["T_sj"], 55);
                string kh = PageValidate.InputText(request["T_companyid"], 55);
                string IsStatus = PageValidate.InputText(request["IsStatus"], 5);
                string ck = (request["ck"]);
                string IsHaveDetail = "0";
                 StringBuilder sb = new StringBuilder();
                string id = PageValidate.InputText(request["fid"], 250);
                model.Order_status_id = stringtoint(request["T_status_val"]);
                model.Order_status = PageValidate.InputText(request["T_status"], 255);
                model.F_Num = id;
                model.Serialnumber = DateTime.Now.AddMilliseconds(3).ToString("yyyyMMddHHmmssfff").Trim();
                //if (ck == "on")
                //{
                //    IsHaveDetail = "1";

                //        string sql = "select * from  Financial_Labour_Cost_Detail WHERE F_Num='" + id + "' ";
                //        if (DbHelperSQL.Query(sql).Tables[0].Rows.Count <= 0)
                //        {
                //            sb.AppendLine("  UPDATE Financial_Labour_Cost SET	ManHour=0,ManDayPrice=0	,Amount=0 ,TotalAmount=AdjustAmount ");
                //            sb.AppendLine(" WHERE	F_Num='" + id + "'  ");
                //        }


                //}
                //else {

                //     sb.AppendLine("  DELETE	 Financial_Labour_Cost_Detail WHERE F_Num='"+ id + "'  ");
                //    if(dj=="0")
                //    {
                //        sb.AppendLine("  UPDATE Financial_Labour_Cost SET	ManHour=0,ManDayPrice=0	,Amount=0 ,TotalAmount=AdjustAmount ");
                //        sb.AppendLine(" WHERE	F_Num='" + id + "'  ");

                //    }

                //}
                //model.cwny = cwny;
                model.IsHaveDetail = IsHaveDetail;
              //  model.Amount = stringtodecimal(T_je);
                model.FromWhere = "PC";
                model.F_StyleID = int.Parse( T_fylx_val);
                model.F_StyleName = T_fylx;
                model.Remarks = T_remarks;
              
                //model.ManDayPrice = stringtodecimal(dj);
                // model.ManHour= stringtodecimal(gs);
                // model.AdjustAmount = stringtodecimal(tzje); 
                model.TotalAmount = stringtodecimal(zje);
                model.CustomerID = stringtoint(kh);
                // ManDayPrice,ManHour,AdjustAmount,TotalAmount,worker
                model.worker = T_rperson;
                model.DeleteTime = DateTime.Parse(sj);
                int orderid = 0;
              
                //if (!string.IsNullOrEmpty(id) && id != "null")
                //{
                //    model.IsStatus = IsStatus;
                //    model.F_Num = id;
                //    ffc.Update(model);
                //    if (sb.ToString() != "")//删除明细
                //        DbHelperSQL.ExecuteSql(sb.ToString());
                //}
                   
                //     else
                //{
                   // string maxid = ffc.GetMaxID("Labour");
                    //model.F_Num = maxid;
                    model.IsStatus = IsStatus;
                    model.CreatePerson = empname;
                    model.CreateTime = DateTime.Now;
                    orderid= ffc.Add(model);
                    
                //}
                ffc.UpdateInvoice(id.ToString());
                ffc.UpdateReceive(id.ToString());

            }
            if (request["Action"] == "savestatus")
            {
                string IsStatus = PageValidate.InputText(request["IsStatus"], 55);
                string id = PageValidate.InputText(request["fid"], 250);
                StringBuilder sb = new StringBuilder();
                sb.AppendLine(" EXEC [dbo].[Usp_Update_Cost_IsStatus] @fid = '" + id + "', -- varchar(15)  ");
                sb.AppendLine("     @style = 'Labour', -- varchar(10)  ");
                sb.AppendLine("     @IsStatus = '" + IsStatus + "' -- varchar(1)  ");
                DbHelperSQL.ExecuteSql(sb.ToString());
            }
            //Form JSON
            if (request["Action"] == "form")
            {
              string  serchtxt = "";
                string id = request["id"];
                if (!string.IsNullOrEmpty(id) && id != "null")
                    serchtxt += "   id=" + int.Parse(id);

                string fid = PageValidate.InputText(request["fid"],50);
                if (!string.IsNullOrEmpty(fid) && fid != "null")
                    serchtxt += " F_Num='" + fid + "'";
                DataSet ds = ffc.GetList(serchtxt);

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
        private int stringtoint(string str)
        {
            int i = 0;
            try { i = int.Parse(str); }
            catch { }
            return i;
        }
        private decimal stringtodecimal(string str)
        {
            decimal i = 0;
            try { i = decimal.Parse(str); }
            catch { }
            return i;
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