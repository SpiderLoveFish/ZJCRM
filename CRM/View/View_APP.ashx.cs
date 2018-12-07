using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using XHD.DBUtility;//Please add references
using System.Data.SqlClient;
using XHD.Common;

namespace XHD.CRM.View
{
    /// <summary>
    /// Summary description for View_APP
    /// </summary>
    public class View_APP : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
               HttpRequest request = context.Request;
               if (request["Action"] == "viewproduct")
               {
                   BLL.CRM_product ccp = new BLL.CRM_product();
                   int pid = int.Parse(request["pid"]);
                   DataSet ds = ccp.GetList(" product_id=" + pid);

                   string dt = Common.DataToJson.DataToJSON(ds);

                   context.Response.Write(dt);
               }
               if (request["Action"] == "viewscore")
               {
                   SqlParameter[] parameters = { };
                   var sb = new System.Text.StringBuilder();
                   string uid = PageValidate.InputText(request["uid"], 50);
                   string sfkh = PageValidate.InputText(request["sfkh"], 50);
                   if (sfkh == "Y")
                   {
                       sb.AppendLine("   SELECT TOP 1 A.*,B.*,c.jf as zjf FROM dbo.v_Jifen_Kh_Mx  A  ");
                    sb.AppendLine(" INNER JOIN  dbo.v_Jifen_Kh c ON A.ID=c.id   ");
                    sb.AppendLine(" INNER JOIN  dbo.CRM_Customer B ON A.ID=B.id   ");
                         sb.AppendLine("    where   1=1");
                   }
                   else
                   {
                       sb.AppendLine("   SELECT TOP 1  A.*,B.*,c.jf as zjf FROM dbo.v_Jifen_Yg_Mx  A  ");
                    sb.AppendLine(" INNER JOIN  dbo.v_Jifen_Yg c ON A.ID=c.id   ");
                    sb.AppendLine(" INNER JOIN  dbo.hr_employee B ON A.ID=B.id   ");
                       sb.AppendLine("    where   1=1");
                      
                   }
                   if (uid.Trim() != "")
                   {
                       sb.AppendLine(" AND A.ID=" + uid);
                   }
                   sb.AppendLine(" ORDER BY InDate DESC ");
                   DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
                   string dt = Common.DataToJson.DataToJSON(ds);

                   context.Response.Write(dt);
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