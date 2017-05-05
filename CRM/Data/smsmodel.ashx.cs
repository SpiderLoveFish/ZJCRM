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
    /// CRM_product 的摘要说明
    /// </summary>
    public class smsmodel : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.CRM_product ccp = new BLL.CRM_product();
            Model.CRM_product model = new Model.CRM_product();

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();
            if (request["Action"] == "tree")
            {
                BLL.Param_SysParam psp = new BLL.Param_SysParam();
                string parentid = PageValidate.InputText(request["parentid"], 50);

                DataSet ds = psp.GetList(0, " parentid=" + int.Parse(parentid), "params_order");
               
                StringBuilder str = new StringBuilder();
                str.Append("[");
                str.Append(GetTreeString(int.Parse(parentid), ds.Tables[0]));
                str.Replace(",", "", str.Length - 1, 1);
                str.Append("]");
                context.Response.Write(str);
            }
            if (request["Action"] == "form")
            {
                string sql = "SELECT * FROM dbo.smsmodel WHERE isDelete!=1";
                  string strwhere = PageValidate.InputText(request["id"], 50);
                  if (strwhere != "")
                      sql += " AND id="+strwhere;
                DataSet ds = DbHelperSQL.Query(sql);

                string dt = Common.DataToJson.DataToJSON(ds);

                context.Response.Write(dt);
            }
            if (request["Action"] == "formJP")
            {
                string strwhere = PageValidate.InputText(request["id"], 50);
                string sql = "SELECT * FROM dbo.smsmodel WHERE id= "+
                "         (SELECT   SUBSTRING(params_id,0,charindex(';',params_id))    FROM  [dbo].[XM_LIST_CONFIG] WHERE XMID='" + strwhere + "'" +
                "          )";
          
               
                DataSet ds = DbHelperSQL.Query(sql);

                string dt = Common.DataToJson.DataToJSON(ds);

                context.Response.Write(dt);
            }
            if (request["Action"] == "formXM_LIST_CONFIG")
            {
                string strwhere = PageValidate.InputText(request["id"], 50);
                string sql = "SELECT  * FROM [XM_LIST_CONFIG] WHERE XMID="+strwhere;


                DataSet ds = DbHelperSQL.Query(sql);

                string dt = Common.DataToJson.DataToJSON(ds);

                context.Response.Write(dt);
            }
            if (request["Action"] == "formCRM_CE_CONFIG")
            {
                string strwhere = PageValidate.InputText(request["from"], 50);
                StringBuilder sb = new StringBuilder();
                if (strwhere != "") {
                    string[] str = strwhere.Split(',');
                    int a = 0;
                    foreach (var s in str)
                    {
                        if (a > 0)
                        sb.AppendLine(" UNION ALL ");
                        sb.AppendLine(" SELECT  * FROM CRM_CE_CONFIG WHERE id ='" + s + "'");
                        
                        a++;
                    }
                }
               // string sql = "SELECT  * FROM CRM_CE_CONFIG WHERE id IN("+strwhere+") "   ;


                DataSet ds = DbHelperSQL.Query(sb.ToString());

                string dt = Common.GetGridJSON.DataTableToJSON(ds.Tables[0]);

                context.Response.Write(dt);
            }
            if (request["Action"] == "formmx")
            {
                string strwhere = PageValidate.InputText(request["cid"], 50);
                string from = PageValidate.InputText(request["from"], 200);
                if (from == "") from = " *"; else from = from.Substring(0, from.Length - 1).Replace("0","'");
                string sql = "SELECT " + from + " FROM  " +
                                             "  (  " +
                                            "    SELECT  A.CustomerName,CustomerID, Stage_icon,ywy,B.* FROM CRM_CEStage A   " +
                                            "    INNER JOIN dbo.CRM_Customer B ON A.CustomerID=B.id    " +
                                            "    WHERE CustomerID= "+strwhere+"   " +
                                            "    )AA   ";

                DataSet ds = DbHelperSQL.Query(sql);

                string dt = Common.DataToJson.DataToJSON(ds);

                context.Response.Write(dt);
            }
            if (request["Action"] == "IsExistCode")
            {
                string id = PageValidate.InputText(request["id"], 50);
                string code = PageValidate.InputText(request["code"], 50);
                string sql = "SELECT   * FROM smsmodel WHERE SmsCode='" + code + "' AND id!=" + id;

                DataSet codeds = DbHelperSQL.Query(sql);

                 if (codeds.Tables[0].Rows.Count > 0)
                {
                    context.Response.Write("false:code");

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
                    sortorder = " desc";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
                string serchtxt = "1=1 AND  isDelete!=1 ";
                if (!string.IsNullOrEmpty(request["params_id"]))
                    serchtxt += " and params_id = " + PageValidate.InputText(request["params_id"], 50) + "";
                string keyword1 = PageValidate.InputText(request["keyword1"], 500);
                if (!string.IsNullOrEmpty(keyword1) && keyword1 != "输入关键词搜索")
                {
                    serchtxt += string.Format(" and ( SmsCode like N'%{0}%' or modelname  like N'%{0}%' or remarks like N'%{0}%' ) ", keyword1);
                }
              
                //权限


                   string dt = "";
             
                    DataSet ds = Getgrid(PageSize, PageIndex, serchtxt, sorttext, out Total);
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
              
                context.Response.Write(dt);
            }
            if (request["Action"] == "del")
            {
                string c_id = PageValidate.InputText(request["id"], 50);
                string sql="Update  dbo.smsmodel SET Delete_time=GETDATE(),isDelete=1 WHERE ID="+c_id;
               System.Data.SqlClient.SqlParameter[] parameters = { };
                int rows = DbHelperSQL.ExecuteSql(sql.ToString(), parameters);
                    if (rows > 0)
                    { 
                
                    context.Response.Write("true");
                    }
                    else
                    {
                        context.Response.Write("false");
                    }
            }


            if (request["Action"] == "save")
            {
                string name = PageValidate.InputText(request["T_name"], int.MaxValue);

                string params_id = Common.PageValidate.InputText(request["params_id"], 250);
                string T_p1 = Common.PageValidate.InputText(request["T_p1"], 250);
                string T_p2 = Common.PageValidate.InputText(request["T_p2"], 250);
                string T_p3 = Common.PageValidate.InputText(request["T_p3"], 250);
                string T_p4 = Common.PageValidate.InputText(request["T_p4"], 250);
                string T_p5 = Common.PageValidate.InputText(request["T_p5"], 250);
                string T_p6 = Common.PageValidate.InputText(request["T_p6"], 250);
                string remarks = Common.PageValidate.InputText(request["T_remarks"], 250);
                string title = Common.PageValidate.InputText(request["T_title"], 250);
                string code = Common.PageValidate.InputText(request["T_mbdm"], 250);
                string orderby = Common.PageValidate.InputText(request["T_orderby"], 250);
                  string id = PageValidate.InputText(request["id"], 50);
                  string sql = "";
                  if (!string.IsNullOrEmpty(id) && id != "null")
                  {

                      sql = "UPDATE	dbo.smsmodel " +
                              " SET modelname='" + name + "'" +
                              " ,para1='" + T_p1 + "'" +
                              " ,para2='" + T_p2 + "'" +
                              " ,para3='" + T_p3 + "'" +
                              " ,para4='" + T_p4 + "'" +
                              " ,para5='" + T_p5 + "'" +
                              " ,para6='" + T_p6 + "'" +
                              " ,remarks='" + remarks + "'" +
                              " ,title='" + title + "'" +
                              " ,SmsCode='" + code + "'" +
                              " ,orderby='" + orderby + "'" +
                              " WHERE id=" + int.Parse(id);
                      ;

                  }
                  else {
                      sql = "insert INTO dbo.smsmodel" +
                     "        ( modelname ," +
                     "          para1 ," +
                     "          para2 ," +
                     "          para3 ," +
                     "          para4 ," +
                     "          para5 ," +
                     "          para6 ," +
                     "          remarks ," +
                     "          title ," +
                     "          isDelete , " +
                     "          params_id  ,SmsCode,orderby" +
                     "        )" +
                     "  VALUES  ( '" + name + "' ,  " +
                     "         '" + T_p1 + "' , " +
                     "         '" + T_p2 + "' ,  " +
                     "          '" + T_p3 + "' ,  " +
                     "          '" + T_p4 + "' ,  " +
                     "         '" + T_p5 + "' ,  " +
                     "          '" + T_p6 + "' ,  " +
                     "         '" + remarks + "' ,  " +
                      "         '" + title + "' ,  " +
                     "          0 ," + params_id + ",'" + code + "','"+orderby+"'  " +
                     "        )";

                  }
                  System.Data.SqlClient.SqlParameter[] parameters = { };
                  object obj = DbHelperSQL.GetSingle(sql.ToString(), parameters);
                  if (obj == null)
                  {
                       context.Response.Write("true");
                    }
                    else
                    {
                        context.Response.Write("false");
                     
                  }
            }

        }
        public DataSet Getgrid(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  * FROM dbo.smsmodel  ");
            strSql.Append(" WHERE  id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM smsmodel   ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM smsmodel  ");

            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }
        private static string GetTreeString(int Id, DataTable table)
        {
            DataRow[] rows = table.Select(string.Format("parentid={0}", Id));

            if (rows.Length == 0) return string.Empty;
            StringBuilder str = new StringBuilder();

            foreach (DataRow row in rows)
            {
                str.Append("{id:" + (int)row["id"] + ",text:'" + (string)row["params_name"] + "' ");

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
     
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}