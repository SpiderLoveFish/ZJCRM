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

namespace XHD.CRM.Data
{
    /// <summary>
    /// hr_employee_accounts 的摘要说明
    /// </summary>
    public class hr_employee_accounts : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.hr_employee_accounts bllAccounts = new BLL.hr_employee_accounts();
            Model.hr_employee_accounts model = new Model.hr_employee_accounts();

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
                model.accountType = PageValidate.InputText(request["T_accountType"], 255);
                model.account = PageValidate.InputText(request["T_account"], 255);
                model.pwd = PageValidate.InputText(request["T_pwd"], 255);
                model.bz = PageValidate.InputText(request["T_bz"], 255);
                int employeeID = int.Parse(request["employeeID"]);
                if (employeeID != 0)
                {
                    model.employeeId = employeeID;
                }
                else
                {
                    model.employeeId = emp_id;
                }           
                string id = PageValidate.InputText(request["id"], 50);
                if (!string.IsNullOrEmpty(id) && id != "null")
                {
                    DataSet ds = bllAccounts.GetList("id=" + int.Parse(id));
                    DataRow dr = ds.Tables[0].Rows[0];
                    model.ID = int.Parse(id);
                    bllAccounts.Update(model);
                }
                else
                {
                    DateTime nowtime = DateTime.Now;
                    int accountId = bllAccounts.Add(model);
                    context.Response.Write(accountId);

                }

                //Caches.hr_employee_accounts = null;
            }

            if (request["Action"] == "IsExistaddress")
            {
                string address = PageValidate.InputText(request["address"], 500);
                DataSet codeds = bllAccounts.GetList(" address='" + address + "' ");
                //and id!=" + PageValidate.InputText(request["cid"], 50) + " ");
                if (codeds.Tables[0].Rows.Count > 0)
                {
                    context.Response.Write("false:address");

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
                    sortorder = " asc";

                string sorttext = " " + sortname + " " + sortorder;
                if (string.IsNullOrEmpty(sorttext))
                    sorttext += " id asc";

                string Total;
                string serchtxt = null;

                int empid = int.Parse(request["empid"]);
                if (empid != 0)
                {
                    serchtxt += "employeeID=" + empid;
                }
                else
                {
                    serchtxt += "employeeID=" + emp_id;
                }

                DataSet ds = bllAccounts.GetList(PageSize, PageIndex, serchtxt, sorttext, out Total);

                string dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);
                context.Response.Write(dt);
            }
            if (request["Action"] == "c_count")
            {
                string serchtxt = "";
                DataSet ds = bllAccounts.GetList(serchtxt);
                context.Response.Write(ds.Tables[0].Rows.Count);
            }
            //Form JSON
            if (request["Action"] == "form")
            {
                string id = PageValidate.InputText(request["accountId"], 50);
                string dt;
                if (PageValidate.IsNumber(id))
                {
                    DataSet ds = bllAccounts.GetList("ID=" + id);
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }


                context.Response.Write(dt);
            }
            //Form JSON
            if (request["Action"] == "formsgjd")
            {
                string id = PageValidate.InputText(request["cid"], 50);
                string dt;
                if (PageValidate.IsNumber(id))
                {
                    DataSet ds = bllAccounts.GetList("id=" + id);
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }


                context.Response.Write(dt);
            }
            if (request["Action"] == "count")
            {
                string id = request["id"];
                DataSet ds = bllAccounts.GetList("id=" + int.Parse(id));

                BLL.CRM_Contact contact = new BLL.CRM_Contact();
                BLL.CRM_contract contract = new BLL.CRM_contract();
                BLL.CRM_order order = new BLL.CRM_order();
                BLL.CRM_Follow follow = new BLL.CRM_Follow();

                int contactcount = 0, contractcount = 0, followcount = 0, ordercount = 0;
                contractcount = contract.GetList(" Customer_id=" + int.Parse(id)).Tables[0].Rows.Count;
                contactcount = contact.GetList(" C_customerid=" + int.Parse(id)).Tables[0].Rows.Count;
                followcount = follow.GetList(" Customer_id=" + int.Parse(id)).Tables[0].Rows.Count;
                ordercount = order.GetList(" Customer_id=" + int.Parse(id)).Tables[0].Rows.Count;

                context.Response.Write(string.Format("{0}联系人, {2}跟进, {3}订单，{1}合同 ", contactcount, contractcount, followcount, ordercount));
            }

            if (request.Params["Action"] == "del")
            {

                    string accountID = request["accountID"];
                    string EventType = "删除员工相关账号";                
                    int success = 0, failure = 0;
                    Model.hr_employee_accounts modelAccounts = bllAccounts.GetModel(int.Parse(accountID));
                    string strAccount = modelAccounts.account;
                        //日志    
                    bool isdel = bllAccounts.Delete(int.Parse(accountID));
                            if (isdel)
                            {
                                success++;
                                int UserID = emp_id;
                                string UserName = empname;
                                string IPStreet = request.UserHostAddress;
                                int EventID = int.Parse(accountID);
                                string EventTitle = strAccount;
                                string Original_txt = null;
                                string Current_txt = null;

                                C_Sys_log log = new C_Sys_log();

                                log.Add_log(UserID, UserName, IPStreet, EventTitle, EventType, EventID, null, Original_txt, Current_txt);
                            }
                            else
                            {
                                failure++;
                            }
                        context.Response.Write(string.Format("{0}条数据成功删除，{1}条失败。|{1}", success, failure));
            }
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