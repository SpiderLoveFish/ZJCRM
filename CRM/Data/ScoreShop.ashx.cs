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
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using System.Security.Cryptography;

namespace XHD.CRM.Data
{
    /// <summary>
    /// CRM_Customer 的摘要说明
    /// </summary>
    public class ScoreShop : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.ScoreShop cccb = new BLL.ScoreShop();
            Model.ScoreShop model = new Model.ScoreShop();

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();
 
            //save
            if (request["Action"] == "save")
            {
                model.ScoreName = PageValidate.InputText(request["T_ScoreName"], 255);
                model.ScoreDescribe = PageValidate.InputText(request["T_ScoreDescribe"], 255);

                model.RemainSum = int.Parse( PageValidate.InputText(request["T_RemainSum"], 50));
                model.NeedScore = int.Parse(PageValidate.InputText(request["T_NeedScore"], 50));
                model.img = PageValidate.InputText(request["thumimg"], 255);
                model.thumimg = PageValidate.InputText(request["thumimg"], 255);
                model.TotalSum = int.Parse(PageValidate.InputText(request["T_TotalSum"], 50));
                model.DoTime = DateTime.Now;
                
              
                string id = PageValidate.InputText(request["id"], 50);

                //DataSet dstel = customer.GetList(" tel=");

                if (!string.IsNullOrEmpty(id) && id != "null")
                {
  
                    model.id = int.Parse(id);
                    cccb.Update(model);
                 }
                else
                {
                   
                    
                    int customerid = cccb.Add(model);

                   
                    context.Response.Write(customerid);

                }

                Caches.CRM_Customer = null;
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
                if (string.IsNullOrEmpty(sorttext))
                    sorttext += " ,id asc";

                string Total;
                string serchtxt = null;
                serchtxt = " 1=1 ";
                 
                string keyword1 = PageValidate.InputText(request["keyword1"], 500);
                if (!string.IsNullOrEmpty(keyword1) && keyword1 != "输入关键词搜索")
                {
                    serchtxt += string.Format(" and ( ScoreName like N'%{0}%' or ScoreDescribe  like N'%{0}%'  ) ", keyword1);
                }
                DataSet ds = cccb.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);
            }
           
            //Form JSON
            if (request["Action"] == "form")
            {
                string id = PageValidate.InputText(request["cid"], 50);
                string dt;
                if (PageValidate.IsNumber(id))
                {
                    DataSet ds = cccb.GetList("id=" + id  );
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }


                context.Response.Write(dt);
            }
            else if (request["Action"] == "logo")
            {
                string fileName = request["filename"];    //文件路径
                fileName = fileName.Substring(fileName.LastIndexOf('\\') + 1);
                string sExt = fileName.Substring(fileName.LastIndexOf(".")).ToLower();

                DateTime now = DateTime.Now;
                string nowfileName = "Score"+now.ToString("yyMMddHHmmss") + GetRandom(3) + sExt;

                HttpPostedFile uploadFile = request.Files[0];
                uploadFile.SaveAs(context.Server.MapPath(@"~/images/upload/temp/" + nowfileName));

                context.Response.Write("images/upload/temp/" + nowfileName);
                
            }

            

            if (request.Params["Action"] == "del")
            {
              
               
                    //DataSet ds = cccb.GetList("id in (" + idlist.Trim() + ")");

                    
                    //            bool isdel = cccb.Delete(int.Parse(cid));
                                 
                    //    context.Response.Write(string.Format("{0}条数据成功删除，{1}条失败。|{1}", success, failure));
                       
            }


          
          

  
        }
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
       
         
        /// <summary>   
        /// 将 Json 解析成 DateTable。  
        /// Json 数据格式如: 
        ///     {table:[{column1:1,column2:2,column3:3},{column1:1,column2:2,column3:3}]} /// </summary>   
        /// <param name="strJson">要解析的 Json 字符串</param>   
        /// <returns>返回 DateTable</returns>   
        public static DataTable JsonToDataTable(string strJson)
        {
            if (strJson.Length < 55) return null;
            // 取出表名   
            var rg = new Regex(@"(?<={)[^:]+(?=:\[)", RegexOptions.IgnoreCase);
            string strName = strJson;// rg.Match(strJson).Value;
            DataTable tb = null;
            
            // 去除表名   
            strJson = strJson.Substring(strJson.IndexOf("[") + 1);
            strJson = strJson.Substring(0, strJson.IndexOf("]"));
           // 去除字符串中的空格，回车，换行符，制表符
            strJson = strJson.Replace("\n", "").Replace(" ", "").Replace("\t", "").Replace("\r", "");
            // 获取数据   
            rg = new Regex(@"(?<={)[^}]+(?=})");
            MatchCollection mc = rg.Matches(strJson);
            for (int i = 0; i < mc.Count; i++)
            {
                string strRow = mc[i].Value;
                string[] strRows = strRow.Split(',');
                // 创建表   
                if (tb == null)
                {
                    tb = new DataTable();
                    tb.TableName = strName;
                    foreach (string str in strRows)
                    {
                        var dc = new DataColumn();
                        string[] strCell = str.Split(':');
                        dc.ColumnName = strCell[0].Replace("\"", "");
                        tb.Columns.Add(dc);
                    }
                    tb.AcceptChanges();
                }
                // 增加内容   
                DataRow dr = tb.NewRow();
                for (int j = 0; j < strRows.Length; j++)
                {
                    if (strRows[j].Split(':').Length > 2)
                        dr[j] = strRows[j].Split(':')[1].Replace("\"", "") + ":" + strRows[j].Split(':')[2].Replace("\"", "");
                    else dr[j] = strRows[j].Split(':')[1].Replace("\"", "");
                }
                tb.Rows.Add(dr);
                tb.AcceptChanges();
            }
            return tb;
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