using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using XHD.Common;
using System.Web.Security;
using System.Data.OleDb;
using System.Data.SqlClient;

namespace XHD.CRM.Data
{
    /// <summary>
    /// 预算管理 的摘要说明
    /// </summary>
    public class Purchase_CGLY : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.Purchase_CGLY bpm = new BLL.Purchase_CGLY();
            Model.Purchase_CGLY mpm = new Model.Purchase_CGLY();
            BLL.Purchase_CGLY_Detail bpd = new BLL.Purchase_CGLY_Detail();
            Model.Purchase_CGLY_Detail mpd = new Model.Purchase_CGLY_Detail();

            
            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();

            BLL.Sys_log log = new BLL.Sys_log();

            if (request["Action"] == "getmaxid")
            {
                BLL.Financial_Labour_Cost flc = new BLL.Financial_Labour_Cost();
                string bid = flc.GetMaxID("Purchase") ;
                string josnstr = "{ 'pid':'" + bid + "','cly':'" + empname + "'}";
                //{"status": 1, "sum": 9}
                context.Response.Write(josnstr);
            }
            if (request["Action"] == "form")
            {
                string pid = PageValidate.InputText(request["pid"], 50);
                string dt;
                if (pid != "")
                {
                    DataSet ds = bpm.GetListdetail(" Purid='" + pid + "'");
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }

                context.Response.Write(dt);
            }
            if (request["Action"] == "formmain")
            {
                string pid = PageValidate.InputText(request["pid"], 50);
                string dt;
                if (pid != "")
                {
                    DataSet ds = bpm.GetList_main(" Purid='" + pid + "'");
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }

                context.Response.Write(dt);
            }
            if (request["Action"] == "gridselectgys")
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
                string serchtxt = "1=1";
                serchtxt += " and IsDel='N'";
                if (!string.IsNullOrEmpty(request["company"]))
                    serchtxt += " and (Name  like N'%" + PageValidate.InputText(request["company"], 255) + "%' "
                        + " OR    Address  like N'%" + PageValidate.InputText(request["company"], 255) + "%' "
                        + " OR Zyyw  like N'%" + PageValidate.InputText(request["company"], 255) + "%')";
                 


                string dt = "";

                DataSet ds = bpm.GetCgGl_Gys_Main(PageSize, PageIndex, serchtxt, sorttext, out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }
            if (request["Action"] == "grid")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
 
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " isNode asc";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " ,purdate DESC ";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                if (!string.IsNullOrEmpty(request["khstext"]))
                    serchtxt += " and nr like '%" + PageValidate.InputText(request["khstext"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["dzstext"]))
                    serchtxt += " and sg like '%" + PageValidate.InputText(request["dzstext"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["dhstext"]))
                    serchtxt += " and Purid like '%" + PageValidate.InputText(request["dhstext"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["gystext"]))
                    serchtxt += " and supplier_name  like '%" + PageValidate.InputText(request["gystext"], 255) + "%'";
          

                string apr=PageValidate.InputText(request["Apr"], 50);
                if (apr == "Y")
                    serchtxt += " AND isNode=1";
                else if(apr=="E")
                    serchtxt += " AND isNode in(0,1)";
                else if (apr == "YY")
                    serchtxt += " AND isNode=2";
                else if (apr == "YYY")
                    serchtxt += " AND isNode=3";
                else if (apr == "view")
                    serchtxt += " AND isNode in(4,3)";

                string issar = request["issarr"];
                if (issar == "1")
                {
                    serchtxt += " and isnull( arrears_money,0)>0";
                }
                //权限控制只可以由明细客户对应的施工监理，单子的材料员，制单员以及admin才可以查看和处理对应的采购单
                if(uid!="admin")
                serchtxt += " and ((materialman='"+empname+ "' OR sg like '%"+empname+ "%') or (SELECT COUNT(1) FROM  dbo.sys_role_emp WHERE RoleID IN ( SELECT Role_id FROM  dbo.Sys_data_authority WHERE Sys_view=4 AND Sys_option='客户管理') AND empID="+emp_id+")>0)";

                string dt = "";

                DataSet ds = bpm.GetPurchase_CGLY(PageSize, PageIndex, serchtxt, sorttext, out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }
            if (request["Action"] == "griddetail")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "1000" : request["pagesize"]);
                string pid = PageValidate.InputText(request["pid"], 50);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " b.customer";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                //if (string.IsNullOrEmpty(pid))
                    serchtxt += " and Purid='"+pid+"'";
 

                string dt = "";

                DataSet ds = bpd.GetPurchase_CGLY_Detail(PageSize, PageIndex, serchtxt, sorttext, out Total);
                 dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }
            if (request["Action"] == "gridview")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string cid = PageValidate.InputText(request["cid"], 50);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " Purid";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                //if (string.IsNullOrEmpty(pid))
                serchtxt += " and Customer_id='" + cid + "'";
                string isNode = PageValidate.InputText(request["sectype_val"], 50);
                if (!string.IsNullOrEmpty(isNode))
                    serchtxt += " and isNode='" + isNode + "'";
                string strwhere = PageValidate.InputText(request["strwhere"], 50);
                if (!string.IsNullOrEmpty(strwhere))
                    serchtxt += " and product_name like '%" + strwhere + "%'";


                string dt = "";

                DataSet ds = bpd.GetPur_ViewList(PageSize, PageIndex, serchtxt);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], "999");

                context.Response.Write(dt);
            }
            if (request["Action"] == "gridspview")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string cid = PageValidate.InputText(request["cid"], 50);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " Purid";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                //if (string.IsNullOrEmpty(pid))
                //serchtxt += " and Customer_id='" + cid + "'";
                string starttime = PageValidate.InputText(request["starttime"], 50);

                string endtime = PageValidate.InputText(request["endtime"], 50);
                //string ID = PageValidate.InputText(request["stext_val"], 50);
                //if (!string.IsNullOrEmpty(ID))
                //    serchtxt += " and ID='" + ID + "'";
                string isNode = PageValidate.InputText(request["sectype_val"], 50);
                if (!string.IsNullOrEmpty(isNode))
                    serchtxt += " and isNode='" + isNode + "'";
                string strwhere = PageValidate.InputText(request["strwhere"], 50);
                if (!string.IsNullOrEmpty(strwhere))
                    serchtxt += " and product_name like '%" + strwhere + "%'";
                string dt = "";

                DataSet ds = bpd.GetSuppPur_ViewList(PageSize, PageIndex, serchtxt,starttime,endtime);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], "999");

                context.Response.Write(dt);
            }
            if (request["Action"] == "gridspdetail")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string cid = PageValidate.InputText(request["cid"], 50);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " Purid";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                //if (string.IsNullOrEmpty(pid))
                //serchtxt += " and Customer_id='" + cid + "'";
                string starttime = PageValidate.InputText(request["starttime"], 50);

                string endtime = PageValidate.InputText(request["endtime"], 50);
                string ID = PageValidate.InputText(request["sid"], 50);
                if (!string.IsNullOrEmpty(ID))
                    serchtxt += " and supplier_id='" + ID + "'";
                string pid = PageValidate.InputText(request["pid"], 50);
                if (!string.IsNullOrEmpty(pid))
                    serchtxt += " and product_id='" + pid + "'";
                string isnode = PageValidate.InputText(request["isnode"], 50);
                if (!string.IsNullOrEmpty(isnode))
                    serchtxt += " and isNode='" + isnode + "'";

                string dt = "";

                DataSet ds = bpd.GetSuppPur_DetailList(PageSize, PageIndex, serchtxt, starttime, endtime);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], "999");

                context.Response.Write(dt);
            }
            if (request["Action"] == "gridstock")
            {
                string dt = "{}";
                
                    DataSet ds = bpm.GetListCklb("");
                    //dt ="{Rows:"+ Common.DataToJson.GetJson(ds)+",Total:"+ds.Tables[0].Rows.Count+"}";
                    dt = Common.DataToJson.GetJson(ds);

                context.Response.Write(dt);
            }
            if (request["Action"] == "tempgrid")
            {
                BLL.PurchaseList ccp = new BLL.PurchaseList();
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = "desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";

                if (!string.IsNullOrEmpty(request["stext"]))
                    serchtxt += " and product_name like N'%" + PageValidate.InputText(request["stext"], 255) + "%'";
                //if(uid!="admin")//非管理员
                if (!string.IsNullOrEmpty(request["cid"]))
                    serchtxt += " and customerid=" + PageValidate.InputText(request["cid"], 50) + "";
                
                //权限
                DataSet ds = ccp.GetTempList(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);
            }
            if (request["Action"] == "save")
            {

                string pid = PageValidate.InputText(request["T_Pid"], 50);
                 decimal  status = StringToDecimal(PageValidate.InputText(request["status"], 50));
                 string isgd = PageValidate.InputText(request["isgd"], 50);
                    string  date = PageValidate.InputText(request["T_cgrq"], 50);
                    string remark = PageValidate.InputText(request["remark"], 255);
                    //if (isgd == "on" || isgd == "true")
                    //    isgd = "1";
                    //else isgd = "0";
                    if (bpm.updateremarks(pid, remark, date, isgd))
                if(bpm.updatetotal(pid,status)>0)
                   context.Response.Write("true");
               else
                {
                    context.Response.Write("false");
                }
            }
            if (request["Action"] == "savetemp")
            {

                string customerid =  PageValidate.InputText(request["cid"], 50);
                string pid = PageValidate.InputText(request["pid"], 50);
                string supid = PageValidate.InputText(request["supid"], 50);
                string remark = PageValidate.InputText(request["remark"], 255);
                string isgd = PageValidate.InputText(request["isgd"], 50);
                string purstyle = PageValidate.InputText(request["purstyle"], 50);
                string did = "0";
                string dname = "";
                if (purstyle=="ypcg")//公司用品采购
                {
                      did = StringToInt( PageValidate.InputText(request["T_companyid"], 50)).ToString();
                      dname = PageValidate.InputText(request["T_companyname"], 50);
                }
               
        
                string cglx = PageValidate.InputText(request["T_cglx"], 50); 
                if (bpm.Add(pid, supid, empname, customerid, remark, isgd,did,dname,purstyle,cglx))
                {
                    log.add_trace(pid,"0","保存",empname);
                    context.Response.Write("true");
                }
                else
                {
                    context.Response.Write("false");
                }
            }
            if (request["Action"] == "saveupdatestatus")
            {

                string pid = PageValidate.InputText(request["pid"], 50);
                  string status =  PageValidate.InputText(request["status"], 50) ;
                  if (bpm.Updatestatus(pid, status))
                  {
                      if (StringToDecimal(status) == 3)//当确认的时候，重新计算下                     
                      {
                          if (bpm.updatetotal(pid, StringToDecimal(status)) > 0)
                          {
                              log.add_trace(pid, status, "", empname);
                              context.Response.Write("true");
                          }
                          else
                          {
                              context.Response.Write("false");
                          }
                      }
                      else
                      {
                          context.Response.Write("true");
                      }
                  }
                  else
                  {
                      context.Response.Write("false");
                  }
            }
            if (request["Action"] == "savestock")
            {

                string pid = PageValidate.InputText(request["pid"], 50);
                string stockid = PageValidate.InputText(request["stockid"], 50);
                string mid = PageValidate.InputText(request["mid"], 50);
                if (bpd.Updatestock(pid, mid, stockid))
                {
                    //log.add_trace(pid, status, "", empname);
                    context.Response.Write("true");
                }
                else
                {
                    context.Response.Write("false");
                }
            }
            //更新，是否核定状态
            if (request["Action"] == "updatesfky")
            {

                string pid = PageValidate.InputText(request["pid"], 50);
                string cid = PageValidate.InputText(request["cid"], 50);
                string status = PageValidate.InputText(request["status"], 50);
                string purid = PageValidate.InputText(request["purid"], 50);
                string sqls = "  UPDATE Purchase_Detail SET ischeck="+status+" WHERE Purid='"+purid+"' AND material_id='"+pid+"' AND Customer_id='"+cid+"'";

                if (DBUtility.DbHelperSQL.ExecuteSql(sqls)>0)
                {
                    //log.add_trace(pid, status, "", empname);
                    context.Response.Write("true");
                }
                else
                {
                    context.Response.Write("false");
                }
            }
            //更新内部价格
            if (request["Action"] == "updateprice")
            {

                string pid = PageValidate.InputText(request["pid"], 50);
              
                string price = PageValidate.InputText(request["price"], 50);
                string sqls = "  UPDATE dbo.CRM_product SET InternalPrice="+price+"  WHERE product_id='"+pid+"'";

                if (DBUtility.DbHelperSQL.ExecuteSql(sqls) > 0)
                {
                    //log.add_trace(pid, status, "", empname);
                    context.Response.Write("true");
                }
                else
                {
                    context.Response.Write("false");
                }
            }
            if (request["Action"] == "savedetail")
            {

              
                string pid = PageValidate.InputText(request["pid"], 50);
                string bjlist = PageValidate.InputText(request["bjlist"], 255);
                string isauto = PageValidate.InputText(request["isauto"], 50);
                
                if (bjlist.Length > 1) bjlist = bjlist.Substring(1);
                 bpd.Addlist( pid, bjlist,isauto);
                C_Sys_log clog = new C_Sys_log();
                clog.AddOneForProduct(bjlist, "pur_qty");
                 string sqls = "  UPDATE PurchaseList  SET IsStatus=7   WHERE id in (" + bjlist + ") EXEC [USP_ComputerPurScore]'"+ pid+"',0 ";
                if (DBUtility.DbHelperSQL.ExecuteSql(sqls) > 0)
                {
                    context.Response.Write("true");
                }
                else
                {
                    context.Response.Write("false");
                }
            }

            if (request["Action"] == "saveupdatedetail")
            {

              
                string pid = PageValidate.InputText(request["pid"], 50);
                string mid = PageValidate.InputText(request["mid"], 50);
                decimal price = StringToDecimal(PageValidate.InputText(request["price"], 50) );
                decimal editsum = StringToDecimal(PageValidate.InputText(request["editsum"], 50));
                string remarks = PageValidate.InputText(request["remaks"], 255);
                string customerid = PageValidate.InputText(request["customid"], 50);
                if (bpd.Updatedetail(pid, mid, price, editsum, remarks, customerid))
                    context.Response.Write("true");
                else
                {
                    context.Response.Write("false");
                }

            }
            //删除条件
            if (request["Action"] == "del")
            {
                string bid = PageValidate.InputText(request["pid"], 50);
                if (bpm.Delete(bid))
                {
                    if (bpd.Delete(bid, ""))
                    {
                        log.add_trace(bid, "99", "删除", empname);
                        context.Response.Write("true");
                    }
                    else context.Response.Write("false");
                }
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
                if (bpd.Delete(bid,mid))
                {
                     
                        context.Response.Write("true");
                    
                }
                else
                {
                    context.Response.Write("false");
                }
            }
        }

        private static string GetTreeString(int Id, DataTable table)
        {
            DataRow[] rows = table.Select(string.Format("parentid={0}", Id));

            if (rows.Length == 0) return string.Empty;
            StringBuilder str = new StringBuilder();

            foreach (DataRow row in rows)
            {
                str.Append("{id:" + (int)row["id"] + ",text:'" + (string)row["BP_Name"] + "',d_icon:''");

                if (GetTreeString((int)row["id"], table).Length > 0)
                {
                    str.Append(",children:[");
                    str.Append(GetTreeString((int)row["id"], table));
                    str.Append("]},");
                }
                else
                {
                    str.Append("},");
                }
            }
            return str[str.Length - 1] == ',' ? str.ToString(0, str.Length - 1) : str.ToString();
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
                            returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or Create_id=" + int.Parse(arr[1]) + ")";
                            break;
                        case "dep":
                            if (string.IsNullOrEmpty(arr[1]))
                                returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(uid) + " or Emp_id_sg=" + int.Parse(uid) + " or Emp_id_sj=" + int.Parse(uid) + " or Create_id=" + int.Parse(uid) + ")";
                            else
                                returntxt = " and ( privatecustomer='公客' or Department_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or Create_id=" + int.Parse(uid) + ")";
                            break;
                        case "depall":
                            BLL.hr_department dep = new BLL.hr_department();
                            DataSet ds = dep.GetAllList();
                            string deptask = GetDepTask(int.Parse(arr[1]), ds.Tables[0]);
                            string intext = arr[1] + "," + deptask;

                            returntxt = " and ( privatecustomer='公客' or Create_id=" + int.Parse(uid) + "  or Department_id in (" + intext.TrimEnd(',') + ") or Dpt_id_sg in (" + intext.TrimEnd(',') + ") or Dpt_id_sj in (" + intext.TrimEnd(',') + "))";
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

        private static bool StringToBool(string code)
        {
            try
            {
                return bool.Parse(code);
            }
            catch { return false; }
        }
        private static int StringToInt(string code)
        {
            try
            {
                return int.Parse(code);
            }
            catch
            {

                return 0;
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

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}