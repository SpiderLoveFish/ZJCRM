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
    public class Financial_Labour_Cost : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.Financial_Labour_Cost ffc = new BLL.Financial_Labour_Cost();
            Model.Financial_Labour_Cost model = new Model.Financial_Labour_Cost();

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
                    serchtxt += " and (worker LIKE '%" + keyword + "%' OR F_StyleName LIKE '%" + keyword + "%' OR A.Remarks LIKE '%" + keyword + "%' ";
                    serchtxt += " OR  B.Customer LIKE '%" + keyword + "%' OR B.address LIKE '%" + keyword + "%' OR B.tel LIKE '%" + keyword + "%')";
                }

                string IsApr = request["IsApr"];
                if (string.IsNullOrEmpty(IsApr) || IsApr == null || IsApr == "null")
                {

                    serchtxt += " and IsStatus in('0','1')";
                }
                else
                {
                    if (IsApr == "Y")
                        serchtxt += " and IsStatus='1'";
                    else if (IsApr == "V")
                        serchtxt += " and 1=1 ";
                    else      if (IsApr == "FK")
                    {
                        serchtxt += " and IsStatus='Y' ";
                    }
                }
                //context.Response.Write(serchtxt);

                DataSet ds = ffc.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);

            }
            if (request["Action"] == "savedetail")
            {
                string pid = PageValidate.InputText(request["pid"], 50);
                string bjlist = PageValidate.InputText(request["bjlist"], 255);


                if (bjlist.Length > 1)
                {
                    bjlist = bjlist.Substring(1);
                    ffc.Addlist(pid, bjlist);
                    C_Sys_log clog = new C_Sys_log();
                    clog.AddOneForProduct(bjlist,"work");
                }
                else
                {
                    StringBuilder sb = new StringBuilder();
                    sb.AppendLine("  UPDATE Financial_Labour_Cost SET	ManHour=0,ManDayPrice=0	,Amount=isnull((SELECT  SUM(totalMoney) FROM dbo.Financial_Labour_Cost_Detail  ");
                    sb.AppendLine(" WHERE F_Num='" + pid + "'),0) ,TotalAmount=isnull((SELECT  SUM(totalMoney) FROM dbo.Financial_Labour_Cost_Detail  ");
                    sb.AppendLine(" WHERE F_Num='" + pid + "'),0)+AdjustAmount ");
                    sb.AppendLine(" WHERE	F_Num='" + pid + "'  ");
                    DbHelperSQL.ExecuteSql(sb.ToString());
                }

            }
            if (request["Action"] == "updatedetail")
            {
                string pid = PageValidate.InputText(request["pid"], 50);
                string mid = PageValidate.InputText(request["mid"], 50);
                decimal price = stringtodecimal(PageValidate.InputText(request["price"], 50));
                decimal editsum = stringtodecimal(PageValidate.InputText(request["editsum"], 50));
                string remarks = PageValidate.InputText(request["remaks"], 255);
                string customerid = PageValidate.InputText(request["customid"], 50);
                if (ffc.Updatedetail(pid, mid, price, editsum, remarks))
                    context.Response.Write("true");
                else
                {
                    context.Response.Write("false");
                }

            }
            //删除条件
            if (request["Action"] == "deldetail")
            {
                string bid = PageValidate.InputText(request["pid"], 50);
                string mid = PageValidate.InputText(request["mid"], 50);
                if (ffc.DeleteDetail(bid, mid))
                {

                    context.Response.Write("true");

                }
                else
                {
                    context.Response.Write("false");
                }
            }
            if (request["Action"] == "griddetail")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " material_id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;
                if (string.IsNullOrEmpty(sorttext))
                    sorttext += " ,material_id asc";
              

                string Total;

                string serchtxt = "1=1";
                string fid = PageValidate.InputText(request["fid"], 50);
                serchtxt += " and F_Num='"+fid+"'";
                DataSet ds = ffc.GetListDetail(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);

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
                string T_rperson = PageValidate.InputText(request["T_rperson"], 255);
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

                if (ck == "on")
                {
                    IsHaveDetail = "1";
                   
                        string sql = "select * from  Financial_Labour_Cost_Detail WHERE F_Num='" + id + "' ";
                        if (DbHelperSQL.Query(sql).Tables[0].Rows.Count <= 0)
                        {
                            sb.AppendLine("  UPDATE Financial_Labour_Cost SET	ManHour=0,ManDayPrice=0	,Amount=0 ,TotalAmount=AdjustAmount ");
                            sb.AppendLine(" WHERE	F_Num='" + id + "'  ");
                        }
                    

                }
                else {
 		
                     sb.AppendLine("  DELETE	 Financial_Labour_Cost_Detail WHERE F_Num='"+ id + "'  ");
                    if(dj=="0")
                    {
                        sb.AppendLine("  UPDATE Financial_Labour_Cost SET	ManHour=0,ManDayPrice=0	,Amount=0 ,TotalAmount=AdjustAmount ");
                        sb.AppendLine(" WHERE	F_Num='" + id + "'  ");

                    }

                }
                //model.cwny = cwny;
                model.IsHaveDetail = IsHaveDetail;
                model.Amount = stringtodecimal(T_je);
                model.FromWhere = "PC";
                model.F_StyleID = int.Parse( T_fylx_val);
                model.F_StyleName = T_fylx;
                model.Remarks = T_remarks;
                model.ManDayPrice = stringtodecimal(dj);
                model.ManHour= stringtodecimal(gs);
                model.AdjustAmount = stringtodecimal(tzje);
                model.TotalAmount = stringtodecimal(zje);
                model.TotalAmount = stringtodecimal(zje);
                model.CustomerID = stringtoint(kh);
                // ManDayPrice,ManHour,AdjustAmount,TotalAmount,worker
                model.worker = T_rperson;
                model.DeleteTime = DateTime.Parse(sj);

              
                if (!string.IsNullOrEmpty(id) && id != "null")
                {
                    model.IsStatus = IsStatus;
                    model.F_Num = id;
                    ffc.Update(model);
                    if (sb.ToString() != "")//删除明细
                        DbHelperSQL.ExecuteSql(sb.ToString());
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
                    string maxid = ffc.GetMaxID("Labour");
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
                sb.AppendLine(" EXEC [dbo].[Usp_Update_Cost_IsStatus] @fid = '" + id + "', -- varchar(15)  ");
                sb.AppendLine("     @style = 'Labour', -- varchar(10)  ");
                sb.AppendLine("     @IsStatus = '" + IsStatus + "' -- varchar(1)  ");
                DbHelperSQL.ExecuteSql(sb.ToString());
            }
            //修改收款状态
            if (request["Action"] == "savecost")
            {
                string IsStatus = PageValidate.InputText(request["status"], 55);
                string id = PageValidate.InputText(request["id"], 250);
                StringBuilder sb = new StringBuilder();
                sb.AppendLine(" UPDATE CRM_receive");
                sb.AppendLine("    SET	 isDelete="+IsStatus+"  ");
                sb.AppendLine("     WHERE id="+id+"  ");

                if (IsStatus == "7")
                {
                    string f_num = PageValidate.InputText(request["f_num"], 250);
                    sb.AppendLine("  UPDATE Financial_Labour_Cost  ");
                    sb.AppendLine("  SET	 receive_money =(SELECT SUM(ISNULL(Receive_amount,0)) AS Expr1 FROM CRM_receive WHERE ( ISNULL(isDelete,0)=0 and Customer_name='" + f_num + "'))  ");
                    sb.AppendLine("  WHERE F_Num='" + f_num + "' ");

                }
                if (DbHelperSQL.ExecuteSql(sb.ToString())>0)
                {
                    context.Response.Write("true");
                }
                else
                {
                    context.Response.Write("false");
                }

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