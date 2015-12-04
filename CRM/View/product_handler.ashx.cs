using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace XHD.CRM.View
{
    /// <summary>
    /// product_handler 的摘要说明
    /// </summary>
    public class product_handler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;
            BLL.CRM_product ccp = new BLL.CRM_product();
            if (request["Action"] == "form")
            {
                int pid = int.Parse(request["pid"]);
                DataSet ds = ccp.GetList(" product_id=" + pid);

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