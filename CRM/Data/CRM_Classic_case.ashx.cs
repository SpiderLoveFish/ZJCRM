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
    public class CRM_Classic_case : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.Crm_Classic_case cccb = new BLL.Crm_Classic_case();
            Model.Crm_Classic_case model = new Model.Crm_Classic_case();

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
                model.c_title = PageValidate.InputText(request["T_title"], 255);
                model.Community = PageValidate.InputText(request["T_Community"], 255);
                
                model.customer_name = PageValidate.InputText(request["T_khmc"], 255);
                model.decorationtpye = PageValidate.InputText(request["T_zxfg"], 255);
                model.designer = PageValidate.InputText(request["T_sjs"], 255);
                model.housearea = PageValidate.InputText(request["T_area"], 255);
                model.housetype = PageValidate.InputText(request["T_hx"], 255);
                model.img_style = PageValidate.InputText(request["T_lx_val"], 255);
                model.IsStatus = PageValidate.InputText(request["isstatus"], 50);
                model.remarks = PageValidate.InputText(request["T_bz"], 255);
                model.thum_img = PageValidate.InputText(request["thumimg"], 255);
                model.URL = PageValidate.InputText(request["T_URL"], 255);
                try { model.customer_id = int.Parse(PageValidate.InputText(request["T_kh"], 50)); }
                catch {
                    model.customer_id = 0;
                }
              
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
                if (!string.IsNullOrEmpty(request["apr"]))
                {
                    if (request["apr"] == "Y")
                        serchtxt += " AND IsStatus IN(1) ";
                    else if (request["apr"] == "1")
                        serchtxt += " AND IsStatus IN(0,1) ";
                }
                string keyword1 = PageValidate.InputText(request["keyword1"], 500);
                if (!string.IsNullOrEmpty(keyword1) && keyword1 != "输入关键词搜索")
                {
                    serchtxt += string.Format(" and ( customer_name like N'%{0}%' or Community  like N'%{0}%' or Community like N'%{0}%' or c_title like N'%{0}%' or decorationtpye like N'%{0}%' or designer like N'%{0}%' ) ", keyword1);
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
                string nowfileName = now.ToString("yyyyMMddHHmmss") + GetRandom(6) + sExt;

                HttpPostedFile uploadFile = request.Files[0];
                uploadFile.SaveAs(context.Server.MapPath(@"~/images/upload/temp/" + nowfileName));

                context.Response.Write("images/upload/temp/" + nowfileName);
                
            }

            if (request.Params["Action"] == "UpdateStatus")
            {
                string id = PageValidate.InputText(request["id"], 50);
                string isstatus = PageValidate.InputText(request["isstatus"], 50);

                if(cccb.UpdateStatus(id, isstatus))
                    context.Response.Write("true");
                else context.Response.Write("false");
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
                            returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or a.Create_id=" + int.Parse(arr[1]) + ")";
                            break;
                        case "dep":
                            if (string.IsNullOrEmpty(arr[1]))
                                returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(uid) + " or Emp_id_sg=" + int.Parse(uid) + " or Emp_id_sj=" + int.Parse(uid) + " or a.Create_id=" + int.Parse(uid) + ")";
                            else
                                returntxt = " and ( privatecustomer='公客' or Department_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or a.Create_id=" + int.Parse(uid) + ")";
                            break;
                        case "depall":
                            BLL.hr_department dep = new BLL.hr_department();
                            DataSet ds = dep.GetAllList();
                            string deptask = GetDepTask(int.Parse(arr[1]), ds.Tables[0]);
                            string intext = arr[1] + "," + deptask;

                            returntxt = " and ( privatecustomer='公客' or a.Create_id=" + int.Parse(uid) + "  or Department_id in (" + intext.TrimEnd(',') + ") or Dpt_id_sg in (" + intext.TrimEnd(',') + ") or Dpt_id_sj in (" + intext.TrimEnd(',') + "))";
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="url"></param>
        /// <param name="method">"POST"/"GET"/"PUT "</param>
        /// <param name="postdatastr"></param>
        /// <returns></returns>
        private string HttpHelper_GetStr(string url, string method, string postdatastr)
        {
            HttpHelper http = new HttpHelper();
            HttpItem item = new HttpItem()
            {
                URL = url,
                //"http://partnertest.kujiale.com/p/openapi/login",//URL     必需项
                Method = method,//URL     可选项 默认为Get
                Timeout = 100000,//连接超时时间     可选项默认为100000
                ReadWriteTimeout = 30000,//写入Post数据超时时间     可选项默认为30000
                IsToLower = false,//得到的HTML代码是否转成小写     可选项默认转小写
                Cookie = "",//字符串Cookie     可选项
                PostEncoding = Encoding.UTF8,
                Encoding = Encoding.UTF8,//编码格式（utf-8,gb2312,gbk）  
                UserAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:18.0) Gecko/20100101 Firefox/18.0",//用户的浏览器类型，版本，操作系统     可选项有默认值
                Accept = "text/html, application/xhtml+xml, */*",//    可选项有默认值
                ContentType = "application/x-www-form-urlencoded",//返回类型    可选项有默认值
                Referer = "",//来源URL     可选项
                //Allowautoredirect = False,//是否根据３０１跳转     可选项
                //AutoRedirectCookie = False,//是否自动处理Cookie     可选项
                //CerPath = "d:\123.cer",//证书绝对路径     可选项不需要证书时可以不写这个参数
                //Connectionlimit = 1024,//最大连接数     可选项 默认为1024
                Postdata = postdatastr,
                //"appkey=hsjauejdsg&timestamp=1418635917113&appuid=1&sign=FA6A2FDAE016D16ACF6C770DE2F1E70F&appuname=测试用户&appuemail=ceshi@ceshi.com&appuphone=13233333333&appussn=&appuAddr=测试省测试市测试县测试路1号&appuavatar=http://qhyxpic.oss.kujiale.com/avatars/72.jpg", //Post数据     可选项GET时不需要写
                //ProxyIp = "192.168.1.105：2020",//代理服务器ID     可选项 不需要代理 时可以不设置这三个参数
                //ProxyPwd = "123456",//代理服务器密码     可选项
                //ProxyUserName = "administrator",//代理服务器账户名     可选项
                ResultType = ResultType.String,//返回数据类型，是Byte还是String
            };
            HttpResult result = http.GetHtml(item);
            string html = result.Html;
            return html;
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