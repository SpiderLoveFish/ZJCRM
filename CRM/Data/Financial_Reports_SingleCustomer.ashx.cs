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
    public class Financial_Reports_SingleCustomer : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.Financial_Reports_SingleCustomer ffc = new BLL.Financial_Reports_SingleCustomer();
            Model.Financial_Reports_SingleCustomer model = new Model.Financial_Reports_SingleCustomer();

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
                    sortname = " a.id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;
                if (string.IsNullOrEmpty(sorttext))
                    sorttext += " ,a.id asc";

                string Total;
                
                string serchtxt = "1=1";
                //context.Response.Write(serchtxt);

                DataSet ds = ffc.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);

            }
            if (request["Action"] == "grid1")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " a.id";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " asc";

                string sorttext = " " + sortname + " " + sortorder;
                //if (string.IsNullOrEmpty(sorttext))
                //    sorttext += " ,a.id asc";

                string Total;

                string serchtxt = "1=1";
                string T_companyid = PageValidate.InputText(request["T_companyid"], 25);
                //if (!string.IsNullOrEmpty(T_companyid))
                //    serchtxt += " AND CustomerID="+T_companyid+"";
                //else serchtxt += " and 1=2";
                //if (string.IsNullOrEmpty(sortorder))
                //    sortorder = " desc";
                //context.Response.Write(serchtxt);

                DataSet ds = ffc.GetList1(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);

            }
            if (request["Action"] == "ToExcel")
            {
               

                //权限
              
                DataSet ds = ffc.ToExcel();

                HttpResponse respon = context.Response;
                respon.Charset = "utf-8";
                respon.Clear();
                string filename = "单客户利润分配报表-" + DateTime.Now.ToString("yyyyMMdd-HHmmss");
                respon.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(filename) + ".xls");
                respon.ContentEncoding = Encoding.UTF8;
                respon.ContentType = "application/octet-stream";

                string style = "<meta http-equiv=\"content-type\" content=\"application/ms-excel; charset=utf-8\"/>"
                    + "<style> .table{ font: 10pt Tahoma, Verdana; color: #000000;   }.xl65	{mso-style-parent:style0;	color:black;	font-size:9.0pt;	font-family:Tahoma, sans-serif;	mso-font-charset:0;}"
                    + ".table td{text-align:center;border:1px solid #000;} .xl69	{mso-style-parent:style0;	color:black;	font-size:9.0pt; sans-serif;	mso-font-charset:0;	border:.5pt solid windowtext;	white-space:normal;}"
                    + ".table th{ font: 10pt Tahoma, Verdana; color: #000000;  background-color: #8ECBEA;  text-align:center; padding-left:10px;}.xl68	{mso-style-parent:style0;	color:black;	font-size:9.0pt;	font-weight:700;	font-family:Tahoma, sans-serif;	mso-font-charset:0;	text-align:center;	border:.5pt solid windowtext;	background:yellow;	mso-pattern:black none;	white-space:normal;}</style>";

                respon.Write(style);

                string tb_header = "<table class='table'><tr>"
                       + "<th class=xl68>客户</th>"
                    + "<th class=xl68>财务年月</th>"
                    + "<th class=xl68>类型</th>"
                    + "<th class=xl68>摘要</th>"
                    + "<th class=xl68>价格</th>"
                    + "<th class=xl68>数量</th>"
                    + "<th class=xl68>预算数量</th>"
                    + "<th class=xl68>预算金额</th>"
                    + "<th class=xl68>收款金额</th>"
                    + "<th class=xl68>材料成本</th>"
                    + "<th class=xl68>人工成本</th>"
                    + "<th class=xl68>业务利润</th>"
                    + "<th class=xl68>施工利润</th>"
                    + "<th class=xl68>设计利润</th>"
                    + "<th class=xl68>公司利润</th>"
                    + "<th class=xl68>备注</th>"
                    + "</tr>";
                respon.Write(tb_header);

                DataTable dt = new DataTable();
                dt.TableName = "statistic";
                dt.Columns.Add("客户");
                  dt.Columns.Add("财务年月");
                   dt.Columns.Add("类型");
                   dt.Columns.Add("摘要");                    
                    dt.Columns.Add("价格");
                    dt.Columns.Add("数量");
                    dt.Columns.Add("预算数量");
                    dt.Columns.Add("预算金额");
                    dt.Columns.Add("收款金额");
                    dt.Columns.Add("材料成本");
                    dt.Columns.Add("人工成本");
                    dt.Columns.Add("业务利润");
                    dt.Columns.Add("施工利润");
                    dt.Columns.Add("设计利润");
                    dt.Columns.Add("公司利润");
                    dt.Columns.Add("备注");
              

                DataRow dr0 = null, dr1 = null;

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    dr1 = ds.Tables[0].Rows[i];
                    dr0 = dt.NewRow();
                    dr0[0] = dr1["客户"];
                    dr0[1] = dr1["财务年月"];
                    dr0[2] = dr1["类型"];
                    dr0[3] = dr1["摘要"];
                    dr0[4] = dr1["价格"];
                    dr0[5] = dr1["数量"];
                    dr0[6] = dr1["预算数量"];
                    dr0[7] = dr1["预算金额"];
                    dr0[8] = dr1["收款金额"];
                    dr0[9] = dr1["材料成本"];
                    dr0[10] = dr1["人工成本"];
                    dr0[11] = dr1["业务利润"];
                    dr0[12] = dr1["施工利润"];
                    dr0[13] = dr1["设计利润"];
                    dr0[14] = dr1["公司利润"];
                    dr0[15] = dr1["备注"];


                    dt.Rows.Add(dr0);
                }

                foreach (DataRow row in dt.Rows)
                {
                    respon.Write("<tr class=xl65>");
                    for (int i = 0; i < dt.Columns.Count; i++)
                        respon.Write("<td class=xl69 >" + row[i] + "</td>");
                    respon.Write("</tr>");
                }
                respon.Write("</table>");

                respon.Flush();
                respon.End();
            }
            //save
            if (request["Action"] == "save")
            {
                 
                string T_fylx = PageValidate.InputText(request["T_fylx"], 25);
                string T_fylx_val = PageValidate.InputText(request["T_fylx_val"], 25);

                  string T_remarks = PageValidate.InputText(request["T_remarks"], 255); //int.Parse(request["T_remarks"]);
                string cwny = "";
                string year = PageValidate.InputText(request["T_year"], 25);
                string month = PageValidate.InputText(request["T_month"], 25);
                if (year == "") year = DateTime.Now.ToString("yyyy");
                if (month == "") month = DateTime.Now.ToString("mm");
                cwny = year + int.Parse(month).ToString("00");
                StringBuilder sb = new StringBuilder();
                sb.AppendLine(" EXEC dbo.USP_Adjust_Report_Detail @cwny = '"+cwny+"', -- varchar(6)  ");
                sb.AppendLine("     @order = " + int.Parse(T_fylx_val) + " -- int  ");
                sb.AppendLine("   ");
                 

                DbHelperSQL.ExecuteSql(sb.ToString());

            }
            if (request["Action"] == "save1")
            {

                string T_fylx = PageValidate.InputText(request["T_fylx"], 25);
                string T_fylx_val = PageValidate.InputText(request["T_fylx_val"], 25);

                string T_companyid = PageValidate.InputText(request["T_companyid"], 255); //int.Parse(request["T_remarks"]);
         
                StringBuilder sb = new StringBuilder();
                sb.AppendLine(" EXEC dbo.[USP_Adjust_Report_Detail_KH]  @customerid = '" + int.Parse(T_companyid) + "', -- varchar(6)  ");
                sb.AppendLine("     @order = " + int.Parse(T_fylx_val) + " -- int  ");
                sb.AppendLine("   ");


                DbHelperSQL.ExecuteSql(sb.ToString());

            }
            //Form JSON
            if (request["Action"] == "form")
            {
                string id = PageValidate.InputText(request["fid"],50);

                DataSet ds = ffc.GetList("id= " +   id  );

                string dt = Common.DataToJson.DataToJSON(ds);

                context.Response.Write(dt);
            }
            if (request["Action"] == "combo")
            {
                BLL.Financial_Profit psp = new BLL.Financial_Profit();
                string parentid = PageValidate.InputText(request["parentid"], 50);

                DataSet ds = psp.GetList(0, " 1=1 "  , "id");

                StringBuilder str = new StringBuilder();

                str.Append("[");
                //str.Append("{id:0,text:'无'},");
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    str.Append("{id:" + ds.Tables[0].Rows[i]["id"].ToString() + ",text:'" + ds.Tables[0].Rows[i]["F_StyleName"] + "'},");
                }
                str.Replace(",", "", str.Length - 1, 1);
                str.Append("]");

                context.Response.Write(str);
            }
            if (request["Action"] == "del")
            {
                string id = PageValidate.InputText(request["fid"],50) ;
               
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