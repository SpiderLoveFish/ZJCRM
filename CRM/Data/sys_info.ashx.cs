using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using XHD.Common;
using System.Security.Cryptography;

namespace XHD.CRM.Data
{
    /// <summary>
    /// sys_info 的摘要说明
    /// </summary>
    public class sys_info : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.sys_info info = new BLL.sys_info();
            Model.sys_info model = new Model.sys_info();

            if (request["Action"] == "grid")
            {
                DataSet ds = info.GetAllList();
                context.Response.Write(Common.GetGridJSON.DataTableToJSON(ds.Tables[0]));
            }
            else if (request["Action"] == "getinfo")
            {
                DataSet ds = info.GetList(" id=2 or id=3");
                context.Response.Write(Common.GetGridJSON.DataTableToJSON(ds.Tables[0]));
            }
            else if (request["Action"] == "up")
            {
                model.sys_value = PageValidate.InputText(request["T_name"], int.MaxValue);
                model.id = 2;

                info.Update(model);
            }
            else if (request["Action"] == "logo")
            {
                string fileName = request["filename"];    //文件路径
                fileName = fileName.Substring(fileName.LastIndexOf('\\') + 1);
                string sExt = fileName.Substring(fileName.LastIndexOf(".")).ToLower();

                DateTime now = DateTime.Now;
                string nowfileName = now.ToString("yyyyMMddHHmmss") + GetRandom(6) + sExt;

                HttpPostedFile uploadFile = request.Files[0];
                uploadFile.SaveAs(context.Server.MapPath(@"~/images/logo/" + nowfileName));

                //context.Response.Write(nowfileName);
                model.sys_value = "images/logo/" + nowfileName;
                model.id = 3;

                info.Update(model);
            }
            
                
            else if (request["Action"] == "host")
            {
                string host = request["host"];     
                
                //context.Response.Write(nowfileName);
                model.sys_value = host;
                model.id = 6;

                info.Update(model);
            }
            else if (request["Action"] == "reg")
            {
                Common.SoftReg rg = new Common.SoftReg();
                string strPath = "xhd" + System.Web.HttpContext.Current.Request.Url.Authority;
                string MNum = rg.getMNum(strPath);
                var rv = SqlDB.ExecuteDataTable("SELECT TOP 1 RNum,30-DATEDIFF(DAY,MInDate,GETDATE()) AS sDay FROM dbo.sys_reginfo WHERE MNum='" + MNum + "'");
                if (rv.Output1.Rows.Count > 0)
                {
                    if (rv.Output1.Rows[0]["RNum"].ToString() == rg.getRNum(MNum))
                        context.Response.Write("true");
                    else
                        context.Response.Write(MNum);
                }
                else
                {
                    SqlDB.ExecuteNoneQuery("INSERT INTO dbo.sys_reginfo (MNum,MInDate) VALUES ('" + MNum + "',GETDATE())");
                    context.Response.Write(MNum);
                }
            }
        }
        #region GetRandom
        private string GetRandom(int length)
        {
            byte[] random = new Byte[length / 2];
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            rng.GetNonZeroBytes(random);

            StringBuilder sb = new StringBuilder(length);
            int i;
            for (i = 0; i < random.Length; i++)
            {
                sb.Append(String.Format("{0:X2}", random[i]));
            }
            return sb.ToString();
        }
        #endregion
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}