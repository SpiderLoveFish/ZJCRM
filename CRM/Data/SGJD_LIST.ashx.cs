using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using XHD.Common;
using System.Web.Security;
using XHD.DBUtility;

namespace XHD.CRM.Data
{
    /// <summary>
    /// CRM_CEStage 的摘要说明
    /// </summary>
    public class SGJD_LIST : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.KHJD_LIST_VIEW_LIST khjd = new BLL.KHJD_LIST_VIEW_LIST();
            Model.KHJD_LIST_VIEW_LIST khjdmodel = new Model.KHJD_LIST_VIEW_LIST();
            BLL.KHJD_LIST_VIEW_LIST_person khjdperson = new BLL.KHJD_LIST_VIEW_LIST_person();
            Model.KHJD_LIST_VIEW_LIST_person khjdpersonmodel = new Model.KHJD_LIST_VIEW_LIST_person();


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
              string CID = PageValidate.InputText(request["id"], 50);
               string Cpro = PageValidate.InputText(request["T_khxq"], 200);
                string Ccity = PageValidate.InputText(request["T_khlh"], 300);
                string JDID = PageValidate.InputText(request["T_private_Val"], 50);
                string JDMC = PageValidate.InputText(request["T_private"], 200);
                string remark = PageValidate.InputText(request["T_content"], 300);// PageValidate.InputText(request["T_Remark"], 300);
                string T_content = PageValidate.InputText(request["T_content"], 300);
                string tel = PageValidate.InputText(request["T_tel"], 50);
                string IsPlan = PageValidate.InputText(request["IsPlan"], 50);
                //string xmid =PageValidate.InputText(request["xmid"], 50);
                int maxid = khjd.GetMaxId();
                string sgxm = PageValidate.InputText(request["sgxm"], 500);
                string sgry = PageValidate.InputText(request["sgry"], int.MaxValue);
                khjdmodel.CID = CID; khjdpersonmodel.CID = CID;
                khjdmodel.Cpro = Cpro; khjdpersonmodel.JDID = StringToInt(JDID); 
                khjdmodel.Ccity = Ccity; khjdpersonmodel.LRRQ = DateTime.Now;
                khjdmodel.Cname = Ccity; khjdpersonmodel.REMARK = remark;
                khjdmodel.JDID = StringToInt(JDID); khjdpersonmodel.roleid = 0;
                khjdmodel.JDMC = JDMC; khjdpersonmodel.rolename = "";
                khjdmodel.Cmob = tel; khjdpersonmodel.status = StringToInt(JDID);
                khjdmodel.LRRQ = DateTime.Now; //khjdpersonmodel.userid = emp_id;
                khjdmodel.REMARK = remark; //khjdpersonmodel.username = empname;
                khjdmodel.IsPlan = IsPlan;
                khjdmodel.IsNew = "Y";
                khjdmodel.status = StringToInt(JDID); khjdpersonmodel.KHJDID = maxid;
                khjdmodel.CZR = empname;
                khjdmodel.KHJDID = maxid;
                DateTime sqrq = DateTime.Now;
                if (String.IsNullOrEmpty(request["T_sgrq"]))khjdmodel.SGRQ = DateTime.Now;  
                else
                { khjdmodel.SGRQ = DateTime.Parse(PageValidate.InputText(request["T_sgrq"], 50));
                    sqrq= DateTime.Parse(PageValidate.InputText(request["T_sgrq"], 50));
                }
                //为了计划全景查询，每次更新之前，先将历史记录全部改变状态N
                string sql = " UPDATE KHJD_LIST_VIEW_LIST SET	 IsNew='N' " +
                                 " WHERE CONVERT(VARCHAR(10),sgrq,120)= '" + sqrq.ToString("yyyy-MM-dd") + "'" +
                                 "  and CID='"+CID+ "' and IsPlan='"+ IsPlan + "'";
                DbHelperSQL.ExecuteSql(sql);
                //为了计划全景查询，每次更新之前，先将历史记录全部改变状态N
                khjdmodel.TQ = PageValidate.InputText(request["T_tq"], 50);
                sgxm = toString(sgxm); sgry = toString(sgry);
                if (sgry == "null") sgry = "";
                if (sgry.Length>0) sgry = sgry.Substring(0, sgry.Length - 1);
                if (sgxm.Length > 0)
                {
                    
                    string[] str = sgxm.Split(';');
                    for (int i = 0; i < str.Length; i++)
                    {
                        khjdmodel.XMID = StringToInt(str[i]);
                        khjdpersonmodel.XMID = StringToInt(str[i]);
                        khjd.Add(khjdmodel);
                        if (sgry.Length > 0)
                        {
                            string[] strs = sgry.Split(';');
                            for (int a = 0; a < strs.Length; a++)
                            {
                                string[] mxstrs = strs[a].Split(',');
                                khjdpersonmodel.userid = StringToInt(toString(mxstrs[0]));
                                khjdpersonmodel.username = toString(mxstrs[1]);
                                khjdpersonmodel.rolename = toString(mxstrs[3]);
                                //职务不确定，不好取ID，只能取描述
                                //khjdpersonmodel.roleid=mxstrs[2];
                                khjdperson.Add(khjdpersonmodel);
                            }
                        }
                    }
                }
                
                    
                khjd.UpdateData();
                 
            }
           
            if (request["Action"] == "grid")
            {
                
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " xmid";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1";
                serchtxt += DataAuth(emp_id.ToString());

                string IsPlan = PageValidate.InputText(request["IsPlan"], 50); 
                if(!string.IsNullOrEmpty(IsPlan))
                    serchtxt += "  and IsPlan = '"+ IsPlan + "'";
                string dt = "";

               // DataSet ds = jd.GetXMList(PageSize, PageIndex, serchtxt, sorttext, out Total);
                   // dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                 
                context.Response.Write(dt);
            }
            if (request["Action"] == "formgrid")
            {
                 string dt;
                  string CID = PageValidate.InputText(request["cid"], 50);
                string IsPlan = PageValidate.InputText(request["IsPlan"], 50); 
                    dt = "";
                    DataSet ds = khjd.GetLastList(" CID=" + CID+ " and IsPlan='"+ IsPlan+"'");
                    string Bdata = "{\"B\":[";
                    string Adata = "\"A\":[";
                    if (ds == null) { dt = ""; }
                    else if (ds.Tables[0].Rows.Count<= 0)
                    { dt = ""; }
                    else {
                        foreach (DataRow dr in ds.Tables[0].Rows)
                        {
                            //dt = dt + ";" + dr["XMID"].ToString();
                            Bdata += "{\"color\":\"" + dr["JDYS"].ToString() + "\",\"id\": " + decimal.Parse(dr["XMID"].ToString()) + "},";

                        }
                        foreach (DataRow dr in ds.Tables[0].Rows)
                        {
                             dt = dt + ";" + dr["XMID"].ToString();
                            
                        }
                         Adata += "{\"ids\":\"" + dt + "\"},";

                        Bdata = Bdata.ToString().TrimEnd(',');
                        Bdata += "],";
                        Adata = Adata.ToString().TrimEnd(',');
                        Adata += "]}";
                    }
                    string jdata = Bdata + Adata ;
                //if(dt.Length>0)
                //    dt = dt.Substring(0,dt.Length-1);
                   // dt = Common.DataToJson.DataToJSON(ds);
                

                context.Response.Write(jdata);
            }
            if (request["Action"] == "detailform")
            {
                string cid = PageValidate.InputText(request["cid"], 50);
                string ry = PageValidate.InputText(request["ry"], 100);
                string IsPlan = PageValidate.InputText(request["IsPlan"], 100);
                try
                {
                    ry = ry.Split('】')[1];
                }
                catch { }
                string dt;
                string strwhere = "";
                if (IsPlan == "Y") strwhere = " AND IsPlan='Y'";
                else   strwhere = " AND IsPlan='N'";
                if (PageValidate.IsNumber(cid))
                {
                    dt = "{}";
                    DataSet ds = null;
                    if(  ry=="init")
                        ds = khjd.GetDetailList("A.cid=" + cid + strwhere, "");
                    else ds = khjd.GetDetailList("A.cid=" + cid + strwhere + " AND ISNULL(B.username,'') LIKE '%" + @ry + "%'", ry);
                    dt = Common.DataToJson.GetJson(ds);
                }
                else
                {
                    dt = "{}";
                }

                context.Response.Write(dt);
            }
            if (request["Action"] == "form")
            {
                string cid = PageValidate.InputText(request["xmid"], 50);
                string dt;
                if (PageValidate.IsNumber(cid))
                {
                    dt = "{}";
                    //DataSet ds = ccpc.GetList("xmid=" + cid);
                    //dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }

                context.Response.Write(dt);
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
        public String toString(object s)
        {
            return (s == null ? "" : s.ToString());
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
                        case "none":
                            returntxt = " and 1=2 ";
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


        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}