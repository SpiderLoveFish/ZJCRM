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
    public class Budge : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.Budge_BasicMain bbb = new BLL.Budge_BasicMain();
            Model.Budge_BasicMain mbb = new Model.Budge_BasicMain();
            BLL.Budge_BasicDetail bbdetail =new BLL.Budge_BasicDetail();
            BLL.budge bd = new BLL.budge();
            
            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();

            if (request["Action"] == "getmaxid")
            {
              string bid=  bbb.GetMaxId();
              string josnstr = "{ 'bid':'" + bid + "'}";
                //{"status": 1, "sum": 9}
                context.Response.Write(josnstr);
            }
            //保存总金额
            if (request["Action"] == "savetotal")
            {
                string bid = PageValidate.InputText(request["bid"], 250);
                string sl = PageValidate.InputText(request["sl"], 250);
                string zk = PageValidate.InputText(request["zk"], 250);

                string josnstr = "";
                if (bd.updatetotal(bid,StringToDecimal( sl)) > 0)
                {
                    if (bd.updateAll(bid, StringToDecimal(zk), StringToDecimal(sl)) > 0)
                    {
                        if (bd.GetTax(bid).Tables[0].Rows.Count > 0)
                            foreach (DataRow dw in bd.GetTax(bid).Tables[0].Rows)
                            {
                                josnstr = "{ 'sj':'" + dw["b_sj"].ToString() + "','zje':'" + dw["b_zje"].ToString() + "'}";
                            }
                    }
                }
                if (josnstr.Length <= 0) josnstr = "{}";
                 //{"status": 1, "sum": 9}
                context.Response.Write(josnstr);
            }
            //最后保存
            if (request["Action"] == "saveall")
            {
                string bid = PageValidate.InputText(request["T_budgeid"], 50);
                string sl = PageValidate.InputText(request["T_sl"], 50);
                string zk = PageValidate.InputText(request["T_zk"], 50);

                string bname = PageValidate.InputText(request["T_budge_name"], 250);
                string submit = PageValidate.InputText(request["style"], 50);
                if (bd.updateAll(bid, StringToDecimal(zk), StringToDecimal(sl)) > 0)
                {
                    mbb.id = bid;
                    mbb.DoTime = DateTime.Now;
                    mbb.DoPerson = emp_id;
                    mbb.BudgetName = bname;
                    bbb.Update(mbb);
                    
                    if (submit == "submit")//提交要改下状态
                    {
                        if (bbb.updatestatus(1,bid))
                            context.Response.Write("true");
                        else
                            context.Response.Write("false");
                      
                    }else
                    context.Response.Write("true");
                }
                else context.Response.Write("false");
            }
            //修改状态，退回，审核，失效
            if (request["Action"] == "saveupdatestatus")
            {
               
                string bid = PageValidate.InputText(request["bid"], 50);
                string status = PageValidate.InputText(request["status"], 50);
                if (status == "2")//审核
                {
                    string cid = PageValidate.InputText(request["cid"], 50);
                   // DataSet ds = bbb.GetList(" IsStatus=2 and customer_id='" + cid + "'");
                    //if (ds.Tables[0].Rows.Count > 0)
                    //    context.Response.Write("false:exist");
                    //else
                    //{
                        if (bbb.updatestatus(StringToInt(status), bid))
                            context.Response.Write("true");
                        else
                            context.Response.Write("false");
                   // }
                }
                else
                {
                    if (bbb.updatestatus(StringToInt(status), bid))
                        context.Response.Write("true");
                    else
                        context.Response.Write("false");
                }
                 
            }
            //是否存在这个预算的模板
             if (request["Action"] == "isexistmodelid")
            {
                string bid = PageValidate.InputText(request["bid"], 250);
                DataSet ds= bd.GetIsExistModelid(bid);
                  string josnstr = "{}";
                 string str="";
                 foreach (DataRow dw in ds.Tables[0].Rows)
                {
                    str += ";" + dw["model_id"].ToString();
                }
              if(str.Length>0)
                  josnstr = "{ 'bid':'" + str + "'}";  
                //{"status": 1, "sum": 9}
                context.Response.Write(josnstr);
            }
            

            if (request["Action"] == "saveadd")
            {
                string bid = PageValidate.InputText(request["bid"], 250);
                  //bbb.GetMaxId();
              string remarks = PageValidate.InputText(request["remark"], 250);
              string bname = PageValidate.InputText(request["bname"], 250);
              int cid = StringToInt(request["cid"]);
              mbb.customer_id = cid;
              mbb.DoTime = DateTime.Now;
              mbb.DoPerson = emp_id;
              mbb.id = bid;
              mbb.BudgetName = bname;
              mbb.IsStatus = 0;
                //防止多人操作，单据重复
            DataSet IsExist=  bbb.GetList(" id='"+bid+"'");
            if (IsExist.Tables[0].Rows.Count > 0)
                context.Response.Write("false");
            else
            {
               if(bbb.Add(mbb))
                   context.Response.Write("true");
               else context.Response.Write("false");
            }
                
            }
            if (request["Action"] == "savedetailadd")
            {       
                string bid = PageValidate.InputText(request["bid"], 50);
                string xmlist = PageValidate.InputText(request["xmlist"], 255);
                string compname = PageValidate.InputText(request["compname"], 255);
                
                if (xmlist.Length > 1) xmlist = xmlist.Substring(1);
                bbdetail.insertlist(bid, xmlist,compname);
            }
            //附加费用保存
            if (request["Action"] == "saveratelist")
            {
                string bid = PageValidate.InputText(request["bid"], 50);
                string ratelist = PageValidate.InputText(request["ratelist"], 255);

                if (ratelist.Length > 1) ratelist = ratelist.Substring(1);
                bd.insertRatelist(bid, ratelist);
            }
            //折扣价格
            if (request["Action"] == "saveupdatedisprice")
            {

                string bid = PageValidate.InputText(request["bid"], 50);
                string zk = PageValidate.InputText(request["zk"], 255);
               
                if(bbdetail.UpdateDisPrice( StringToDecimal(zk),bid))
                    context.Response.Write("true");
                else context.Response.Write("false");
            }
            //刷新价格
            if (request["Action"] == "saveupdaterefprice")
            {

                string bid = PageValidate.InputText(request["bid"], 50);
                if(bbdetail.UpdateRefreshPrice( bid))
                    context.Response.Write("true");
                else context.Response.Write("false");
            }
            if (request["Action"] == "savemodel")
            {
                string bid = PageValidate.InputText(request["bid"], 50);
                string remaks = PageValidate.InputText(request["T_remarks"], 250);
                string modelname = PageValidate.InputText(request["T_compname"], 250);
                string modelid = bd.GetMaxModelId();
                if (bd.AddModel(bid,modelid, modelname,emp_id, remaks) > 0)
                    context.Response.Write("true");
                else context.Response.Write("false");
            }
            if (request["Action"] == "savemodeltobudge")
            {
                string bid = PageValidate.InputText(request["bid"], 50);
                string modelid = PageValidate.InputText(request["modelid"], 50);
                if (bd.AddModelToBudge(bid, modelid) > 0)
                    context.Response.Write("true");
                else context.Response.Write("false");
            }

            if (request["Action"] == "copybudge")
            {
                string copyid = PageValidate.InputText(request["copyid"], 50);
                string maxid =  bbb.GetMaxId();
                if (bd.copybudge(copyid, maxid, emp_id.ToString()) > 0)
                    context.Response.Write(maxid);
                else context.Response.Write("false");
            }

            if (request["Action"] == "saveupdatesum")
            {
                decimal  sum = StringToDecimal(request["editsum"]);
                string bid=PageValidate.InputText(request["bid"], 50);
                string id = PageValidate.InputText(request["id"], 50);
                if (!string.IsNullOrEmpty(id) && id != "null")
                {
                    if (bbdetail.UpdateSum(sum,StringToInt(id),bid))
                        context.Response.Write("true");
                    else context.Response.Write("false");
                }
            }
            if (request["Action"] == "deldetail")
            {
                   string  id =  PageValidate.InputText(request["id"], 50);
                   string bid = PageValidate.InputText(request["bid"], 50);
                  if (!string.IsNullOrEmpty(id))
                  {
                      
                       
                          //暂：明细和部件
                          BLL.Budge_BasicDetail bdetail = new BLL.Budge_BasicDetail();
                          if (bdetail.Delete_id(StringToInt(id), bid))
                          context.Response.Write("true");
                           else  context.Response.Write("false");
                }
                else
                {
                    context.Response.Write("false");
                }
                  
            }
            if (request["Action"] == "delcomp")
            {
                string comp = PageValidate.InputText(request["comp"], 50);
                string bid = PageValidate.InputText(request["bid"], 50);
                if (!string.IsNullOrEmpty(comp))
                {


                    //暂：明细和部件
                    BLL.Budge_BasicDetail bdetail = new BLL.Budge_BasicDetail();
                    if (bdetail.Delete_comp(comp, bid))
                        context.Response.Write("true");
                    else context.Response.Write("false");
                }
                else
                {
                    context.Response.Write("false");
                }

            }
            //删除条件
            if (request["Action"] == "del")
            {
                  string bid = PageValidate.InputText(request["bid"], 50);
                    if(bbb.Delete(bid))
                   {
                       if(bbdetail.Delete(bid))
                        context.Response.Write("true");
                       else context.Response.Write("false");
                    }
                    else
                    {
                        context.Response.Write("false");
                    }
            }
            //删除条件
            if (request["Action"] == "delmodel")
            {
                string mid = PageValidate.InputText(request["mid"], 50);
                BLL.budge_modelMain bmm = new BLL.budge_modelMain();
                BLL.Budge_Model bm = new BLL.Budge_Model();
                if (bmm.Delete(mid))
                {
                    //暂：明细和部件
                    if(bm.Delete(mid))
                    context.Response.Write("true");
                    else context.Response.Write("false");
                }
                else
                {
                    context.Response.Write("false");
                }
            }
            if (request["Action"] == "delratever")
            {
                string id = PageValidate.InputText(request["id"], 50);
                if (!string.IsNullOrEmpty(id))
                {


                    //暂：明细和部件
                      if (bd.DeleteRateVer(StringToInt(id)))
                        context.Response.Write("true");
                    else context.Response.Write("false");
                }
                else
                {
                    context.Response.Write("false");
                }

            }
            if (request["Action"] == "form")
            {
                string bid = PageValidate.InputText(request["bid"], 50);
                string dt;
                if (bid!="")
                {
                    DataSet ds = bbb.GetList_form(" A.id='" + bid+"'");
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }

                context.Response.Write(dt);
            }

            if (request["Action"] == "formprint")
            {
                string bid = PageValidate.InputText(request["bid"], 50);
                string dt;
                if (bid != "")
                {
                    DataSet ds = bbb.GetPrintCount(bid);
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], "1");

                }
                else
                {
                    dt = "{}";
                }

                context.Response.Write(dt);
            }

            if (request["Action"] == "formmodel")
            {
                string mid = PageValidate.InputText(request["mid"], 50);
                string dt;
                if (mid != "")
                {
                    BLL.budge_modelMain bmm = new BLL.budge_modelMain();
                    DataSet ds = bmm.GetList_form("  model_id='" + mid + "'");
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
                string str_condition = PageValidate.InputText(request["str_condition"], 50);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = "  IsStatus";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " ASC";



                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                if (!string.IsNullOrEmpty(request["khstext"]))
                    serchtxt += " and Customer like N'%" + PageValidate.InputText(request["khstext"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["dzstext"]))
                    serchtxt += " and address like N'%" + PageValidate.InputText(request["dzstext"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["dhstext"]))
                    serchtxt += " and tel like N'%" + PageValidate.InputText(request["dhstext"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["sgjlstext"]))
                    serchtxt += " and sgjl like N'%" + PageValidate.InputText(request["sgjlstext"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["T_sjs"]))
                    serchtxt += " and sjs like N'%" + PageValidate.InputText(request["T_sjs"], 255) + "%'";
                if (!string.IsNullOrEmpty(request["T_ysbh"]))
                    serchtxt += " and id like N'%" + PageValidate.InputText(request["T_ysbh"], 255) + "%'";
               //订单选择
                if (!string.IsNullOrEmpty(request["cid"]))
                    serchtxt += " and customer_id =" + PageValidate.InputText(request["cid"], 255);
                if (!string.IsNullOrEmpty(request["s_khstext"]))
                {
                    serchtxt += " and (Customer like N'%" + PageValidate.InputText(request["s_khstext"], 255) + "%' OR address like N'%" + PageValidate.InputText(request["s_khstext"], 255) + "%')";
                }

                if (str_condition == "0")
                    serchtxt += " and IsStatus in(0,1)";
                else if (str_condition == "1")
                {
                    serchtxt += " and IsStatus  in(1)";
                }
                else if (str_condition == "3")
                {
                    serchtxt += " and IsStatus=3";
                }
                else  
                {
                    serchtxt += " and IsStatus not in(0)";
                }
                string dt = "";

                DataSet ds = bbb.GetBudge_BasicMain(PageSize, PageIndex, serchtxt, sorttext, out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }
            if (request["Action"] == "gridselectmodel")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];
                string txtsearch = PageValidate.InputText(request["stext"], 255);
            
                if (string.IsNullOrEmpty(sortname))
                    sortname = " id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                if (txtsearch!="")
                    serchtxt += "  AND ( model_id LIKE '%" + txtsearch + "%' OR D.Customer LIKE '%" + txtsearch + "%' OR D.tel LIKE '%" + txtsearch + "%' OR D.address LIKE '%" + txtsearch + "%') ";


                string dt = "";

                DataSet ds = bd.Getbudge_modelMain(PageSize, PageIndex, serchtxt, sorttext, out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }
            if (request["Action"] == "griddetail")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " ComponentName";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                serchtxt += " and   ComponentName like '%" + PageValidate.InputText(request["compname"], 255) + "%'";
                serchtxt += " and   budge_id ='" + PageValidate.InputText(request["bid"], 255) + "'";


                string dt = "";

                DataSet ds = bbdetail.GetBudge_BasicDetail(PageSize, PageIndex, serchtxt, sorttext, out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }

            if (request["Action"] == "griddetailmodel")
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
                serchtxt += " and   ComponentName like '%" + PageValidate.InputText(request["compname"], 255) + "%'";
                serchtxt += " and   model_id ='" + PageValidate.InputText(request["mid"], 255) + "'";


                string dt = "";
                BLL.Budge_Model bm = new BLL.Budge_Model();
                DataSet ds = bm.GetBudge_Model(PageSize, PageIndex, serchtxt, sorttext, out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }
            if (request["Action"] == "gridrate")
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
                   string bid = PageValidate.InputText(request["bid"], 50);
                string Total;
                string serchtxt = "1=1";
                serchtxt += " and budge_id='" + bid + "'";


                string dt = "";

                DataSet ds = bd.GetBudge_Rate_Ver(PageSize, PageIndex, serchtxt, sorttext, out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }
            if (request["Action"] == "gridrateselect")
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
                string bid = PageValidate.InputText(request["bid"], 50);
              //  serchtxt += " and id not in(select rateid from Budge_Rate_Ver where budge_id='"+bid+"')";

                string dt = "";

                DataSet ds = bd.GetBudge_Rate(PageSize, PageIndex, serchtxt, sorttext, out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }
            if (request["Action"] == "getcustomer")
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
                //serchtxt += " and id not in(SELECT customer_id FROM dbo.Budge_BasicMain where IsStatus=99) ";
                if (!string.IsNullOrEmpty(request["company"]))
                {
                    serchtxt += " and ( Customer like '%" + PageValidate.InputText(request["company"], 255) + "%'";
                    serchtxt += " OR address like '%" + PageValidate.InputText(request["company"], 255) + "%'";
                    serchtxt += " OR tel like '%" + PageValidate.InputText(request["company"], 255) + "%'";
                    serchtxt += " OR Emp_sg like '%" + PageValidate.InputText(request["company"], 255) + "%' )";

                }

                string dt = "";
                BLL.CRM_CEStage ccpc = new BLL.CRM_CEStage();
                DataSet ds = ccpc.GetListCustomer(PageSize, PageIndex, serchtxt, sorttext, out Total);
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);

            }
            //选择已筛选的版本部位
            if (request["Action"] == "tree")
            {
                 string serchtxt = " 1=1 ";
                 string bid = PageValidate.InputText(request["bid"], 50);
                 serchtxt += " AND budge_id='"+bid+"'"; 
                DataSet ds = bbb.GetListPara_Ver(serchtxt);
                StringBuilder str = new StringBuilder();
                str.Append("[");
                str.Append(GetTreeString(0, ds.Tables[0]));
                str.Replace(",", "", str.Length - 1, 1);
                str.Append("]");
                context.Response.Write(str);
            }
            //选择已筛选的版本部位
            if (request["Action"] == "treemodel")
            {
                string serchtxt = " 1=1 ";
                string mid = PageValidate.InputText(request["mid"], 50);
                serchtxt += " AND model_id='" + mid + "'";
                BLL.budge_modelMain bmm = new BLL.budge_modelMain();
                DataSet ds = bmm.GetListPara_model(serchtxt);
                StringBuilder str = new StringBuilder();
                str.Append("[");
                str.Append(GetTreeString(0, ds.Tables[0]));
                str.Replace(",", "", str.Length - 1, 1);
                str.Append("]");
                context.Response.Write(str);
            }
            //选择基础部位
            if (request["Action"] == "selecttree")
            {
                string serchtxt = " 1=1 ";

                DataSet ds = bbb.GetListBasicPart(serchtxt);
                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], ds.Tables[0].Rows.Count.ToString());

                context.Response.Write(dt);
           
            }
            if (request["Action"] == "savebjlist")
            {
              
                int customerid = int.Parse(request["cid"]);
                string bid = PageValidate.InputText(request["bid"], 255);
                string bjlist = PageValidate.InputText(request["bjlist"], 255);
                if (bjlist.Length > 1) bjlist = bjlist.Substring(1);
                bd.AddBJlist(customerid, bid, bjlist);
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