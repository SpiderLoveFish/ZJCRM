using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using System.Web.Security;
using System.IO;
using System.Net;
using System.Net.Cache;
using System.Security.Cryptography;
using XHD.Common;

namespace XHD.CRM.Data
{
    /// <summary>
    /// sys_app 的摘要说明
    /// </summary>
    /// 

    public class website : IHttpHandler
    {
         
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            //var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            //var ticket = FormsAuthentication.Decrypt(cookie.Value);
            //string CoockiesID = ticket.UserData;
              BLL.CE_Para cp = new BLL.CE_Para();
              BLL.WebSite_User bwu = new BLL.WebSite_User();
              Model.WebSite_User mwu = new Model.WebSite_User();
            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = 1;
            //DataSet dsemp = emp.GetList("id=" + emp_id);
            //string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = "admin";
            BLL.sys_info si = new BLL.sys_info();
            string host = "";
            //try
            //{
            //     host = si.GetList(" sys_key='sys_host'").Tables[0].Rows[0]["sys_value"].ToString();
            //}
            //catch { } //dsemp.Tables[0].Rows[0]["uid"].ToString();
            if (request["Action"] == "updatepwd")
            {
                string zhm = PageValidate.InputText(request["zhm"], 255);
                string tel = PageValidate.InputText(request["tel"], 255);
                string newpwd = FormsAuthentication.HashPasswordForStoringInConfigFile(request["T_newpwd"], "MD5");
                string sql = "update	 hr_employee set pwd='"+ newpwd + "' where uid='"+ zhm + "' and tel='"+tel+"'";
               
                if(DBUtility.DbHelperSQL.ExecuteSql(sql)>0)
                    context.Response.Write("true");
                else context.Response.Write("false");

            }

            //combo案例类型
            if (request["Action"] == "combo_para")
            {
                string parentid = PageValidate.InputText(request["parentid"], 50);
                BLL.Param_SysParam psp = new BLL.Param_SysParam();
                DataSet ds = psp.GetList(0, " parentid=" + int.Parse(parentid), "params_order");

                StringBuilder str = new StringBuilder();

                str.Append("[");
                //str.Append("{id:0,text:'无'},");
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    str.Append("{id:" + ds.Tables[0].Rows[i]["id"].ToString() + ",text:'" + ds.Tables[0].Rows[i]["params_name"] + "'},");
                }
                str.Replace(",", "", str.Length - 1, 1);
                str.Append("]");

                context.Response.Write(str);
            }
            //combo
            if (request["Action"] == "combo_person")
            {
                string serchtxt = " 1=1 ";

                string did = request["did"];
                if (!string.IsNullOrEmpty(did) && did != null && did != "null")
                    serchtxt += " and d_id=" + int.Parse(did);
                  serchtxt += " and uid!='admin' and uid!='NoVerer' ";
                string authtxt = request["auth"];
                if (authtxt == "1")
                {
                    Data.GetDataAuth dataauth = new Data.GetDataAuth();
                    string txt = dataauth.GetDataAuthByid("1", "Sys_add", emp_id.ToString());
                    string[] arr = txt.Split(':');
                    switch (arr[0])
                    {
                        case "my":
                            serchtxt += " and ID=" + emp_id;
                            break;
                    }
                }

                DataSet ds = emp.GetList(serchtxt);

                StringBuilder str = new StringBuilder();

                str.Append("[");
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    str.Append("{id:" + ds.Tables[0].Rows[i]["id"].ToString() + ",text:'" + ds.Tables[0].Rows[i]["name"] + "'},");
                }
                str.Replace(",", "", str.Length - 1, 1);
                str.Append("]");

                context.Response.Write(str);

            }
            if (request["Action"] == "classiclist")
            {
                StringBuilder sb = new StringBuilder();
                sb.AppendLine(" SELECT * FROM dbo.Crm_Classic_case  A");

                sb.AppendLine(" INNER JOIN Param_SysParam B ON	A.img_style=B.id  ");
                sb.AppendLine("  where 1=1 ");

                  string search = PageValidate.InputText(request["search"], 500);
                if (!string.IsNullOrEmpty(search))
                {
                    string[] s = search.Split(';');

                    //案例类型
                    if (!string.IsNullOrEmpty(s[0]))
                    {
                        sb.AppendLine(" AND  B.params_name like '%" + s[0] + "%'");
                    }
                    //楼盘
                    if (!string.IsNullOrEmpty(s[1]))
                    {
                        sb.AppendLine(" AND  Community like '%"+ s[1] + "%'");
                    }
                    //其实面积

                    if (!string.IsNullOrEmpty(s[2]))
                    {
                        sb.AppendLine(" AND  housearea >='" + s[2] + "'");
                    }
                    //截至面积
                         if (!string.IsNullOrEmpty(s[3]))
                    {
                        sb.AppendLine(" AND  housearea <='" + s[3] + "'");
                    }
                    //案例标题
                     if (!string.IsNullOrEmpty(s[4]))
                    {
                        sb.AppendLine(" AND  c_title like '%"+ s[4] + "%'");
                    }
                    //户型
                    if (!string.IsNullOrEmpty(s[5]))
                    {
                        sb.AppendLine(" AND  housetype like '%" + s[5] + "%'");
                    }
                    //装修风格
                    if (!string.IsNullOrEmpty(s[6]))
                    {
                        sb.AppendLine(" AND  decorationtpye like '%" + s[6] + "%'");
                    }
                    //设计师
                    if (!string.IsNullOrEmpty(s[7]))
                    {
                        sb.AppendLine(" AND  designer like '%" + s[7] + "%'");
                    }

                    
                }
                DataSet ds = DBUtility.DbHelperSQL.Query(sb.ToString());
                string dt = Common.GetGridJSON.DataTableToJSON(ds.Tables[0]);
                context.Response.Write(dt);
            }


            if (request["Action"] == "selecttel")
            {
                string zhm = PageValidate.InputText(request["zhm"], 255);
                string sql = "select tel	 from hr_employee where uid='"+ zhm + "'";
                DataSet ds = DBUtility.DbHelperSQL.Query(sql);
                string tel = "";
                if (ds.Tables[0].Rows.Count > 0)
                    tel= ds.Tables[0].Rows[0][0].ToString();
                context.Response.Write(tel);
            }
            if (request["Action"] == "Send_aliyunSendSMS")
            {

                string tel = PageValidate.InputText(request["tel"], int.MaxValue);
                string type = PageValidate.InputText(request["type"], 50);
                string para = request["para"];
                if (tel == ""|| tel == null)
                {
                   string struid = PageValidate.InputText(request["uid"], 50);
                    string sql = "SELECT tel FROM dbo.hr_employee WHERE uid='"+ struid + "'";
                    tel = DBUtility.DbHelperSQL.Query(sql).Tables[0].Rows[0][0].ToString();
                }
                XHD.CRM.Data.sms sms = new Data.sms();
                string aa = sms.aliyunSendSMS(tel, type, para);
                if (aa == "OK")
                {
                    string sql = " INSERT INTO dbo.SMS_log" +
                               "        ( sendcontent ," +
                               "          DoTime ," +
                               "          DoPerson ," +
                               "          DoStyle ," +
                               "          smsphone ," +
                               "          smscount" +
                               "        )" +
                               " VALUES  ( '" + para + "' ,  " +
                               "          getdate() ,  " +
                               "          ' ' , " +
                               "          '修改密码' , " +
                               "          '" + tel + "' , " +
                               "          " + tel.Split(';').Length + " " +
                               "        )";
                    DBUtility.DbHelperSQL.ExecuteSql(sql);
                    context.Response.Write("true");
                }

                else context.Response.Write("false");
            }
            if (request["Action"] == "test")
            {
                string fpId = "3FO4J1G598MG";
                string desid = "3FO4JFXBLNIA";
                string uuid = "ksxczs";
                string tel ="15906266305";
                string[] arr_rooom = para("4", uid);
                    string appKey = arr_rooom[(int)paraenum.appKey];
                    string appSecret = arr_rooom[(int)paraenum.appSecret];
                    string userId = uuid + "@xczs.com";
                    if (uuid == "")
                        userId = arr_rooom[(int)paraenum.userId];
                    if (appKey == null) context.Response.Write("请先配置参数！");
                    else
                    {

                        string planid = fpId;
                        // Common.PageValidate.InputText(request["designId"], 50)

                        object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                        string timestamp = currenttimemillis.ToString(); //2分钟
                        string sign = MD5(appSecret + appKey + timestamp).ToLower();
                        string api = arr_rooom[(int)paraenum.api];
                        StringBuilder apiBuilder = new StringBuilder();
                        apiBuilder.Append(api)
                             .Append("/" + desid)
                            .Append("/itemlist")//?starttime=
                            // .Append((int.Parse(timestamp) - (300 * 24 * 3600 * 1000)).ToString())
                             .Append("?start=").Append("0")
                            .Append("&num=").Append("999")
                            .Append("&appkey=").Append(appKey)
                        .Append("&timestamp=").Append(timestamp)
                        .Append("&sign=").Append(sign);
                        string result = "";
                        result = HttpGet(apiBuilder.ToString());
                        cp.Addkjl_api_list(uid, tel, fpId, desid, 0, userId, result, "");
                    }
                
            }
            
            if (request["Action"] == "savebj")
            {
                //唯一可能，2个FID全部为空，只有3D
               // int Customer_id = int.Parse(request["cid"]);
                  string tel = Common.PageValidate.InputText(request["tel"], 50);  
                string uuid = Common.PageValidate.InputText(request["jmid"], 50);
                if (uuid != "") uid = uuid;//主要是报价防止没有数据
                string fpId = PageValidate.InputText(request["fid"], 50);
                string desid = PageValidate.InputText(request["desid"], 50);
                string imgtype = PageValidate.InputText(request["imgtype"], 255);
                string simg = PageValidate.InputText(request["simg"], 255);
                string img = PageValidate.InputText(request["img"], 255);
                string style = PageValidate.InputText(request["style"], 255);
                string pano = PageValidate.InputText(request["pano"], 255);
                string DyGraphicsName = PageValidate.InputText(request["name"], 255);
                if (fpId == "null" || fpId == null) fpId = "";
                if (desid == "null" || desid == null) desid = "";
                if (style == "Edit")
                {
                    if (cp.Updatekjl_api(desid, 0, fpId, DyGraphicsName, imgtype, simg, img, pano))
                    {
                        context.Response.Write("true");
                    }
                    else context.Response.Write("false");

                }
                else if (style == "insert")
                {
                    if (cp.Addkjl_api(desid, 0, fpId, DyGraphicsName, imgtype, simg, img, pano, uid, emp_id,tel))
                    {
                        context.Response.Write("true");
                    }
                    else context.Response.Write("false");


                }
                if (desid != "")
                {
                    //装修清单
                    string[] arr = para("4", uid);
                    string appKey = arr[(int)paraenum.appKey];
                    string appSecret = arr[(int)paraenum.appSecret];
                    string userId = uuid + "@xczs.com";
                    if (uuid == "")
                        userId = arr[(int)paraenum.userId];
                    if (appKey == null) context.Response.Write("请先配置参数！");
                    else
                    {

                        // Common.PageValidate.InputText(request["designId"], 50)
                        int start = 0; int num = 999;
                        //int.Parse(Common.PageValidate.InputText(request["start"], 50));
                        object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                        string timestamp = currenttimemillis.ToString(); //2分钟
                        // 签名加密
                        string aa = "sdfaadsasdasd";
                        string md5aa = MD5(aa).ToLower();
                        string sign = MD5(appSecret + appKey + timestamp).ToLower();
                        string api = arr[(int)paraenum.api];
                        StringBuilder apiBuilder = new StringBuilder();
                        apiBuilder.Append(api)
                             .Append("/" + desid)
                            .Append("/itemlist")//?starttime=
                            // .Append((int.Parse(timestamp) - (300 * 24 * 3600 * 1000)).ToString())
                             .Append("?start=").Append(start)
                            .Append("&num=").Append(num)
                            .Append("&appkey=").Append(appKey)
                        .Append("&timestamp=").Append(timestamp)
                        .Append("&sign=").Append(sign);



                        string result = "";
                        result = HttpGet(apiBuilder.ToString());
                        // context.Response.Write(result);
                        cp.Addkjl_api_list(uid, tel, fpId, desid, 0, userId, result, "");
                    }

                    //房间数据
                    string[] arr_rooom = para("12", uid);

                    if (appKey == null) context.Response.Write("请先配置参数！");
                    else
                    {

                        string planid = fpId;
                        // Common.PageValidate.InputText(request["designId"], 50)

                        object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                        string timestamp = currenttimemillis.ToString(); //2分钟
                        string sign = MD5(appSecret + appKey + timestamp).ToLower();
                        string api = arr_rooom[(int)paraenum.api];
                        StringBuilder apiBuilder = new StringBuilder();
                        apiBuilder.Append(api)
                        .Append("/" + planid + "/roominfo")
                        .Append("?appkey=").Append(appKey)
                        .Append("&timestamp=").Append(timestamp)
                        .Append("&sign=").Append(sign);
                        string result = "";
                        result = HttpGet(apiBuilder.ToString());
                        cp.Addkjl_api_roomlist(uid, tel,fpId, desid, userId, result, "");
                        // context.Response.Write(result);
                    }
                }
            }
            if (request["Action"] == "griddetail")
            {
                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "999" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                if (string.IsNullOrEmpty(sortname))
                    sortname = " ISNULL(BPOrderby,0) ,ComponentName,ISNULL(OrderBy, 0)   ";
                if (string.IsNullOrEmpty(sortorder))
                    sortorder = " ASC";

                string sorttext = " " + sortname + " " + sortorder;

                string Total;
              
                string dt = "";
                string tel = request["tel"];
                string jmid = request["jmid"];
                string desid = request["desid"];
                DataSet ds = cp.GetDS_kjl_api_list("  a.tel='" + tel + "' AND a.desid='" + desid + "'");
                Total = ds.Tables[0].Rows.Count.ToString();
                dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], Total);

                context.Response.Write(dt);
            }
            if (request["Action"] == "getqrcode")
            {
                string url = PageValidate.InputText(request["url"], 250);
                string ImageUrl = "../../View/QrCodeHandler.ashx?e=M&q=Two&s=8&t=" + HttpUtility.UrlEncode(url);
                context.Response.Write(ImageUrl);
            }
            if (request["Action"] == "SaveCustomer")
            {
                
                string tel = PageValidate.InputText(request["tel"], 50);
                string c = PageValidate.InputText(request["c"], 50);
                 string customer = PageValidate.InputText(request["custmer"], 50);
                Model.CRM_Customer mcc = new Model.CRM_Customer();
                BLL.CRM_Customer bcc = new BLL.CRM_Customer();
               DataSet isexistphone=  bcc.GetList(" tel='" + tel + "' ");
                //and id!=" + PageValidate.InputText(request["cid"], 50) + " ");
               if (isexistphone.Tables[0].Rows.Count > 0)
                {
                    context.Response.Write("true");  

                }else
               {
                   mcc.tel = tel;
                   mcc.Customer = "1分钟用户-" + c;
                   mcc.fax = "1";//登录次数
                   mcc.site = customer;//客户编号
                   if (bcc.Add(mcc) > 0)
                       context.Response.Write("true");
                   else context.Response.Write("false");
               }
                
            }
            if (request["Action"] == "login")
            {
                string tel = PageValidate.InputText(request["uid"], 50);
               string  pwd = PageValidate.InputText(request["pwd"], 50);
               DataSet ds = bwu.GetList(" pwd='" + pwd + "' and userid='" + tel + "'");
                
                string dt = Common.DataToJson.DataToJSON(ds);

                context.Response.Write("["+dt+"]");
            }

            if (request["Action"] == "reg")
            {
                string tel=PageValidate.InputText(request["tel"], 50);
                mwu.tel = tel;
                mwu.pwd = PageValidate.InputText(request["pwd"], 50);
                mwu.nickname = PageValidate.InputText(request["nickname"], 50);
                mwu.sex = PageValidate.InputText(request["sex"], 50);
                mwu.kjl_login = uid + "@" + host;
                mwu.userid = PageValidate.InputText(request["tel"], 50);
                mwu.village = PageValidate.InputText(request["xq"], 50);

              
                mwu.status = "Y";
                string id = PageValidate.InputText(request["id"], 50);


                if (!string.IsNullOrEmpty(id) && id != "null")
                {

                    mwu.id = int.Parse(id);
                    if(bwu.Update(mwu))
                        context.Response.Write("true");
                    else context.Response.Write("false");
                }
                else
                {
                    if (bwu.ExistsTel(tel))
                    {
                        context.Response.Write("false:tel");
                    }
                    else
                    {
                        if (bwu.Add(mwu) > 0)
                            context.Response.Write("true");
                        else context.Response.Write("false");
                    }

                }
            }
            if (request["Action"] == "aliyunSendSMS")
            {
                XHD.CRM.Data.sms sms = new Data.sms();
                string tel = PageValidate.InputText(request["tel"], 50);
                string type = "2";//SMS_Config
                string para = PageValidate.InputText(request["yzm"], 50);
                string a = " {'code':'" + para + "'}";
                string aa = sms.aliyunSendSMS(tel, type, a);
                if (aa == "200")
                {

                //if (type == "3")//
                //{
                //    Model.hr_employee hrm = new Model.hr_employee();
                //    BLL.hr_employee hrb = new BLL.hr_employee();
                // Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(para);
                // string password = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(jo["passw"].ToString(), "MD5");

                // hrm.uid = jo["userid"].ToString();
                // hrm.pwd = password;
                // hrm.level = "99";//试用账户
                // hrm.tel = jo["userid"].ToString();
                // hrm.name = "试用" + jo["passw"].ToString();
                // hrb.DeleteUID(jo["userid"].ToString());
                // hrb.Add(hrm);
                //}
                    context.Response.Write(aa);
            }

                else context.Response.Write(aa);
        }
            if (request["Action"] == "GetMessage")
            {
                sms sms = new Data.sms();
                string mobile = PageValidate.InputText(request["tel"], 50);
                string yzm = PageValidate.InputText(request["yzm"], 255);
                string mes = "您好，心成装饰给您发的验证码为" + yzm + "，请勿向任何单位或个人泄露。【心成装饰】";
                string a = sms.SendSMS(false, "", mes, mobile);
                //"{\"?xml\":{\"@version\":\"1.0\",\"@encoding\":\"utf-8\"},\"returnsms\":{\"returnstatus\":\"Success\",\"message\":\"ok\",\"remainpoint\":\"10196\",\"taskID\":\"302471\",\"successCounts\":\"1\"}}"; //
                context.Response.Write(a);
            }

            if (request["Action"] == "save")
            {
              //唯一可能，2个FID全部为空，只有3D
                 int Customer_id = 0;
                string fpId = PageValidate.InputText(request["fid"], 50);
                string desid = PageValidate.InputText(request["desid"], 50);
                string imgtype = PageValidate.InputText(request["imgtype"], 255);
                string simg = PageValidate.InputText(request["simg"], 255);
                string img = PageValidate.InputText(request["img"], 255);
                string style = PageValidate.InputText(request["style"], 255);
                string pano = PageValidate.InputText(request["pano"], 255);
                string remarks = PageValidate.InputText(request["tel"], 50);
                string DyGraphicsName = PageValidate.InputText(request["name"], 255);
                if (fpId == "null" || fpId == null) fpId = "";
                if (desid == "null" || desid == null) desid = "";
                if (style == "Edit")
                {
                    if(cp.Updatekjl_api(desid, Customer_id, fpId,DyGraphicsName, imgtype, simg, img, pano))
                        context.Response.Write("true");
                    else context.Response.Write("false");

                }
                else if (style == "insert")
                {
                    if(cp.Addkjl_api(desid, Customer_id, fpId,DyGraphicsName, imgtype, simg, img, pano,uid,emp_id,remarks))
                        context.Response.Write("true");
                    else context.Response.Write("false");


                }
            }


            if (request["Action"] == "getlistapi")
            {
                string id = PageValidate.InputText(request["cid"], 50);
                string dt;
                if (PageValidate.IsNumber(id))
                {
                    DataSet ds = cp.Getkjl_api_list(" curstomerid=" +int.Parse( id),uid);
                    dt = Common.DataToJson.DataToJSON(ds);
                }
                else
                {
                    dt = "{}";
                }


                context.Response.Write("[" + dt + "]");
            }


            if (request["Action"] == "deleteAPI")
            {
                int Customer_id = int.Parse(request["cid"]);
                string fpId = PageValidate.InputText(request["fid"], 50);
                string desid = PageValidate.InputText(request["desid"], 50);
                if (cp.deletekjl_api(desid, Customer_id, fpId))
                       context.Response.Write("true");
                    else context.Response.Write("false");
            }
            /*单点登录 
             * dest
            0	单点登录之后会跳转到户型的创建页面，可以体验整个酷家乐的工具流程
            1	必须和参数designid一起使用，单点登录成功之后会跳转到该指定3D方案的编辑页面（designid必须为该appuid下的）
            2	必须和参数planid一起使用，单点登录成功之后会跳转到该指定户型图的编辑页面（plainid必须为该appuid下的）
            3	到虚拟体验馆的前端展示馆
            4	直接进入画户型flash工具中
            5	对于具有虚拟体验馆后台管理权限的商家B类用户有意义，进入到酷家乐虚拟体验馆后台管理页面（只有当apputype=0时才可到该页面）
                        */
            if (request["Action"] == "GetMD5")
            {
                string uuid = Common.PageValidate.InputText(request["jmid"], 50);
                if (uuid != "") uid = uuid;//主要是报价防止没有数据
                string[] arr = para("1", uid);
                    string appKey =arr[(int)paraenum.appKey];
                    string appSecret =arr[(int)paraenum.appSecret];
                    string userId = uuid + "@xczs.com";
                    if (uuid == "")
                        userId = arr[(int)paraenum.userId];
                    string dest = Common.PageValidate.InputText(request["dest"], 50);
                    string planid = Common.PageValidate.InputText(request["fid"], 50);
                    string designid = Common.PageValidate.InputText(request["desid"], 50);
                //int.Parse(Common.PageValidate.InputText(request["T_companyid"], 50));
                    if (appKey==null) context.Response.Write("请先配置参数！");
                     else
                        {      
                        object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                        string timestamp = currenttimemillis.ToString(); ;//2分钟
                        // 签名加密
                        string aa = "sdfaadsasdasd";
                        string md5aa = MD5(aa).ToLower();
                        string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                        IDictionary<string, string> postdata = new Dictionary<string, string>();
                        postdata.Add("appkey", appKey);
                        postdata.Add("timestamp", timestamp);
                        postdata.Add("appuid", userId);
                        postdata.Add("sign", sign);
                        postdata.Add("appuname", arr[(int)paraenum.userName]);
                        postdata.Add("appuemail", arr[(int)paraenum.email]);
                        postdata.Add("appuphone", arr[(int)paraenum.phone]);
                        postdata.Add("appussn", arr[(int)paraenum.ssn]);
                        postdata.Add("appuaddr", arr[(int)paraenum.address]);
                        postdata.Add("appuavatar", arr[(int)paraenum.avatar]);
                        postdata.Add("apputype", "0");
                        postdata.Add("dest", dest);
                        postdata.Add("designid", designid);
                        postdata.Add("planid", planid);
                        //发送POST数据  
                        StringBuilder buffer = new StringBuilder();
                        if (!(postdata == null || postdata.Count == 0))
                        {

                            int i = 0;
                            foreach (string key in postdata.Keys)
                            {
                                if (i > 0)
                                {
                                    buffer.AppendFormat("&{0}={1}", key, postdata[key]);
                                }
                                else
                                {
                                    buffer.AppendFormat("{0}={1}", key, postdata[key]);
                                    i++;
                                }
                            }
                        }

                        // 设置HTTP请求的参数，等同于以query string的方式附在URL后面
                        //// API地址，生产环境域名对应为www.kujiale.com
                        string api = arr[(int)paraenum.api];
                        //// 构造HTTP请求
                        string test = "http://wwww.baidu.com";

                        string result = "";
                        //  CookieCollection ck=new CookieCollection();
                        //result = 
                        //    Comm.HttpHelper.CreatePostHttpResponse(test, postdata, 100000, "",ck);

                        // result = PostWebRequest(api, postdata);
                        // result = HttpPost(api, buffer.ToString());
                        result = HttpHelper_GetStr(api,"POST", buffer.ToString());
                        context.Response.Write(result);
                    }
              
            }
            //绑定账号
            if (request["Action"] == "bind")
            {

 
              string str_uid = Common.PageValidate.InputText(request["uid"], 50);
              string bindid = Common.PageValidate.InputText(request["bindid"], 50);
      
                string[] arr = para("29", str_uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                 if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); ;//2分钟
                    // 签名加密
                    string aa = "sdfaadsasdasd";
                    string md5aa = MD5(aa).ToLower();
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    IDictionary<string, string> postdata = new Dictionary<string, string>();
                    postdata.Add("appkey", appKey);
                    postdata.Add("timestamp", timestamp);
                    postdata.Add("appuid", userId);
                    postdata.Add("sign", sign);
                    postdata.Add("email", bindid);
                 
                    //发送POST数据  
                    StringBuilder buffer = new StringBuilder();
                    if (!(postdata == null || postdata.Count == 0))
                    {

                        int i = 0;
                        foreach (string key in postdata.Keys)
                        {
                            if (i > 0)
                            {
                                buffer.AppendFormat("&{0}={1}", key, postdata[key]);
                            }
                            else
                            {
                                buffer.AppendFormat("{0}={1}", key, postdata[key]);
                                i++;
                            }
                        }
                    }
                     string api = arr[(int)paraenum.api];
       
                    string result = "";
                   result = HttpHelper_GetStr(api, "POST", buffer.ToString());
                    context.Response.Write(result);
                    if (result == "success")
                    {
                        BLL.hr_employee hr = new BLL.hr_employee();
                        Model.hr_employee mhr = new Model.hr_employee();
                        mhr.ID = int.Parse(Common.PageValidate.InputText(request["id"], 50));
                        mhr.uid=str_uid;
                        mhr.professional=bindid;
                        hr.UpdateKJL(mhr);
                    }
                }

            }
            //取消收藏模型的接口DELETE


            //收藏模型的接口
            if (request["Action"] == "Getmodelcollent")
            {

                string[] arr = para("21", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                string modelId = "3FO4K4VXK10P";
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); ;//2分钟
                    // 签名加密
                    string aa = "sdfaadsasdasd";
                    string md5aa = MD5(aa).ToLower();
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    IDictionary<string, string> postdata = new Dictionary<string, string>();
                    postdata.Add("appkey", appKey);
                    postdata.Add("timestamp", timestamp);
                    postdata.Add("appuid", userId);
                    postdata.Add("sign", sign);
                    postdata.Add("bid", modelId);
                

                    //发送POST数据  
                    StringBuilder buffer = new StringBuilder();
                    if (!(postdata == null || postdata.Count == 0))
                    {

                        int i = 0;
                        foreach (string key in postdata.Keys)
                        {
                            if (i > 0)
                            {
                                buffer.AppendFormat("&{0}={1}", key, postdata[key]);
                            }
                            else
                            {
                                buffer.AppendFormat("{0}={1}", key, postdata[key]);
                                i++;
                            }
                        }
                    }

                    // 设置HTTP请求的参数，等同于以query string的方式附在URL后面
                    //// API地址，生产环境域名对应为www.kujiale.com
                    string api = arr[(int)paraenum.api];
                    //// 构造HTTP请求
                    string test = "http://wwww.baidu.com";

                    string result = "";
                 result = HttpHelper_GetStr(api, "POST", buffer.ToString());
                    context.Response.Write(result);
                }

            }
            //根据模型分类获取模型列表
            if (request["Action"] == "getmodellist")
            {

                string[] arr = para("20", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                 String catId = "5518c22f0cf26b08f58f70b7";
                 long start = 0L; int num = 5;
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {

                    // Common.PageValidate.InputText(request["designId"], 50)

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("?catid=").Append(catId)
                    .Append("&appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign)
                      .Append("&start=").Append(start)
                     .Append("&num=").Append(num);
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }

            //获取模型分类
            if (request["Action"] == "getmodelstyle")
            {

                string[] arr = para("19", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                string planid = "1";
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {

                    // Common.PageValidate.InputText(request["designId"], 50)

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("/cats")
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign)

                                    ;
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }

            //获取户型评测结果
            if (request["Action"] == "getresult")
            {

                string[] arr = para("18", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                string planid = "1";
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {

                    // Common.PageValidate.InputText(request["designId"], 50)

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("/" + planid + "/evaluation")
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign)

                                    ;
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }

            //搜索户型图接口
            if (request["Action"] == "gethxtapi")
            {
                string suid = Common.PageValidate.InputText(request["uid"], 250);
                if (suid != "")
                    uid = suid;
                string[] arr = para("17", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                string query = Common.PageValidate.InputText(request["keystr"], 250);
                long start = long.Parse(Common.PageValidate.InputText(request["strstart"], 50));
                int num = int.Parse(Common.PageValidate.InputText(request["searchnum"], 50)); 
             
                long cityId = long.Parse(Common.PageValidate.InputText(request["cityid"], 50));
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {

                    // Common.PageValidate.InputText(request["designId"], 50)

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign)
                    .Append("&q=").Append(query)
                    .Append("&start=").Append(start)
                    .Append("&num=").Append(num)
                    .Append("&cityid=").Append(cityId)
                                    ;
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }
            //获取酷家乐城市列表
            if (request["Action"] == "getcitylist")
            {

                string[] arr = para("16", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];

                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {

                     // Common.PageValidate.InputText(request["designId"], 50)

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign) ;
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }

            //获取指定户型图的副本
            if (request["Action"] == "getuserhxdatafb")
            {
                string uuid = Common.PageValidate.InputText(request["jmid"], 50);
                if (uuid != "") uid = uuid;//主要是报价防止没有数据
                string[] arr = para("14", uuid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = uuid + "@xczs.com";
                if(uuid=="")
                    userId=arr[(int)paraenum.userId];
 
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {

                    string planid = Common.PageValidate.InputText(request["planid"], 50);

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                       .Append("/" + planid)
                         .Append("/copy")
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign)
                     .Append("&appuid=").Append(userId);
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }

            //获取用户下的户型图数据
            if (request["Action"] == "getuserhxdata")
            {

                string[] arr = para("13", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                long start = 0; int num = 2;
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {

                    string planid =  Common.PageValidate.InputText(request["fid"], 50);
                    num = int.Parse(Common.PageValidate.InputText(request["num"], 50));
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                          .Append("?start=").Append(start)
                         .Append("&num=").Append(num)
                    .Append("&appkey=").Append(appKey)
                      .Append("&appuid=").Append(userId)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }
            //获取用户下的户型图数据 同步
            if (request["Action"] == "getuserhxdata_tongbu")
            {
                string struid = Common.PageValidate.InputText(request["struid"], 50);

                string[] arr = para("13", struid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                long start = 0; int num = 2;
                string strnum = Common.PageValidate.InputText(request["num"], 50);
                num = int.Parse(strnum);
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {

                    string planid = Common.PageValidate.InputText(request["fid"], 50);
                    num = int.Parse(Common.PageValidate.InputText(request["num"], 50));
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                          .Append("?start=").Append(start)
                         .Append("&num=").Append(num)
                    .Append("&appkey=").Append(appKey)
                      .Append("&appuid=").Append(userId)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    if (result != "request time out")
                    {
                        cp.Addkjl_list_text(struid, 1, userId, result, "");
                        cp.Addkjl_account_list(struid, 1, userId, result, "");
                        context.Response.Write("true");
                    }
                }

            }
            //删除户型图
            if (request["Action"] == "delethxt")
            {

                string[] arr = para("28", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {

                    string planid = "3FO4K5M8YDHR";
                    // Common.PageValidate.InputText(request["designId"], 50)

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("/" + planid + "/roominfo")
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }
            //获取指定户型图的房间数据
            if (request["Action"] == "getroomdata")
            {

                string[] arr = para("12", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {

                    string planid = "3FO4K5M8YDHR";
                    // Common.PageValidate.InputText(request["designId"], 50)

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("/" + planid + "/roominfo")
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }
            //获取指定户型的基本数据
            if (request["Action"] == "getthebasicdata")
            {
                string uuid = Common.PageValidate.InputText(request["jmid"], 50);
                if (uuid != "") uid = uuid;//主要是报价防止没有数据

                string[] arr = para("11", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = uuid + "@xczs.com";
                if (uuid == "")
                    userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {

                    string planid = Common.PageValidate.InputText(request["fid"], 50);

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("/" + planid)
                     .Append("/info")
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write("["+result+"]");
                }

            }
            // 全屋漫游图生成接口(tongbu 同步)
            if (request["Action"] == "GETAPI_tongbu")
            {
                string struid = Common.PageValidate.InputText(request["struid"], 50);

                string[] arr = para("10", struid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); ;//2分钟
                    // 签名加密
                    string picid = Common.PageValidate.InputText(request["picid"], 50);

                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    IDictionary<string, string> postdata = new Dictionary<string, string>();
                    postdata.Add("appkey", appKey);
                    postdata.Add("timestamp", timestamp); 
                    postdata.Add("sign", sign);
                    postdata.Add("picids", picid);
                    postdata.Add("override", "true"); 

                    //发送POST数据  
                    StringBuilder buffer = new StringBuilder();
                    if (!(postdata == null || postdata.Count == 0))
                    {

                        int i = 0;
                        foreach (string key in postdata.Keys)
                        {
                            if (i > 0)
                            {
                                buffer.AppendFormat("&{0}={1}", key, postdata[key]);
                            }
                            else
                            {
                                buffer.AppendFormat("{0}={1}", key, postdata[key]);
                                i++;
                            }
                        }
                    }

                    // 设置HTTP请求的参数，等同于以query string的方式附在URL后面
                    //// API地址，生产环境域名对应为www.kujiale.com
                    string api = arr[(int)paraenum.api];
                    //// 构造HTTP请求
               
                    string result = "";

                    result = HttpHelper_GetStr(api, "POST", buffer.ToString());

                    if (result != "request time out")
                    {
                        cp.Addkjl_list_text(struid, 3, userId, result, picid);
                        context.Response.Write("true");
                    }
                }

            }
           // 全屋漫游图生成接口(未完成)
            if (request["Action"] == "GETAPI")
            {

                string[] arr = para("10", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); ;//2分钟
                    // 签名加密
                    string picid = Common.PageValidate.InputText(request["picid"], 50);

                    string sign = MD5(appSecret + appKey + timestamp).ToLower();
                    IDictionary<string, string> postdata = new Dictionary<string, string>();
                    postdata.Add("appkey", appKey);
                    postdata.Add("timestamp", timestamp);
                    postdata.Add("sign", sign);
                    postdata.Add("picids", picid);
                    postdata.Add("override", "true"); 


                    //发送POST数据  
                    StringBuilder buffer = new StringBuilder();
                    if (!(postdata == null || postdata.Count == 0))
                    {

                        int i = 0;
                        foreach (string key in postdata.Keys)
                        {
                            if (i > 0)
                            {
                                buffer.AppendFormat("&{0}={1}", key, postdata[key]);
                            }
                            else
                            {
                                buffer.AppendFormat("{0}={1}", key, postdata[key]);
                                i++;
                            }
                        }
                    }

                    // 设置HTTP请求的参数，等同于以query string的方式附在URL后面
                    //// API地址，生产环境域名对应为www.kujiale.com
                    string api = arr[(int)paraenum.api];
                    //// 构造HTTP请求
                    string test = "http://wwww.baidu.com";

                    string result = "";
      
                    result = HttpHelper_GetStr(api, "POST", buffer.ToString());
                    context.Response.Write(result);
                }

            }
            //更新3D渲染方案的名字put
            if (request["Action"] == "update3dname")
            {

                string[] arr = para("9", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    //string newName = "方案新名字";
                    string newName = PageValidate.InputText(request["T_name"], 255);

                    string designId = Common.PageValidate.InputText(request["desid"], 50);

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("/" + designId)
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign)
                    .Append("&name=").Append(newName); ;
                    string result = "";
                    //result = HttpPut(apiBuilder.ToString());
                    result = HttpHelper_GetStr(apiBuilder.ToString(),"PUT",""); 
                    context.Response.Write(result);
                }

            }
            //更新户型图名字put
            if (request["Action"] == "updatehxtname")
            {

                string[] arr = para("15", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    string newName =  PageValidate.InputText(request["T_name"], 255);

                    string planid = Common.PageValidate.InputText(request["fid"], 50);

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("/" + planid)
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign)
                    .Append("&name=").Append(newName); ;
                    string result = "";
                    //result = HttpPut(apiBuilder.ToString());
                    result = HttpHelper_GetStr(apiBuilder.ToString(),"PUT","");
                    if(result=="success")
                    cp.Updatekjl_api_name(planid,newName);
                    context.Response.Write(result);
                }

            }
            //获取指定3D渲染方案的基本数据
            if (request["Action"] == "get3dfabasicdata")
            {
                string uuid = Common.PageValidate.InputText(request["jmid"], 50);
                if (uuid != "") uid = uuid;//主要是报价防止没有数据
                string[] arr = para("8", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    string appuid = "1";
                    string designId = Common.PageValidate.InputText(request["desid"], 50);

                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("/"+designId)
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign) ;
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write("["+result+"]");
                }

            }
            //获取指定3D渲染方案的副本
            if (request["Action"] == "get3dfafb")
            {

                string[] arr = para("7", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    string appuid = "1";
                    string designId = "3FO4K5M8YDHR";
                    // Common.PageValidate.InputText(request["designId"], 50)
                    
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("/copy")
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign)
                    .Append("&appuid=").Append(appuid);
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }
            //获取指定用户的3D方案列表
            if (request["Action"] == "get3dfalist")
            {

                string[] arr = para("6", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                     // Common.PageValidate.InputText(request["designId"], 50)
                    long start = 0; int num = 2;
                    
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    // 签名加密
                    string aa = "sdfaadsasdasd";
                    string appUid = "1";
                    string md5aa = MD5(aa).ToLower();
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("?start=").Append(start)
                    .Append("&num=").Append(num)
                    .Append("&appkey=").Append(appKey)
                    .Append("&appuid=").Append(appUid)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }


            //获取指定用户的3D方案列表,tongbu同步
            if (request["Action"] == "get3dlist_tongbu")
            {

                string struid = Common.PageValidate.InputText(request["struid"], 50);
                string[] arr = para("6", struid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    // Common.PageValidate.InputText(request["designId"], 50)
                    long start = 0; int num = 100;
                    string strnum = Common.PageValidate.InputText(request["num"], 50);
                    num = int.Parse(strnum);
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    // 签名加密
                     
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("?start=").Append(start)
                    .Append("&num=").Append(num)
                    .Append("&appkey=").Append(appKey)
                    .Append("&appuid=").Append(userId)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                   
                    if (result != "request time out")
                    {
                        cp.Addkjl_list_text(struid, 0, userId, result, "");
                        context.Response.Write("true");
                    }
                }

            }
            //删除方案
            if (request["Action"] == "delete")
            {

                string[] arr = para("5", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    string designId = Common.PageValidate.InputText(request["desid"], 50);
                  object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    // 签名加密
                    string aa = "sdfaadsasdasd";
                    string md5aa = MD5(aa).ToLower();
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                         .Append("/"+designId)
                        .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
                    string result = "";
                    result = HttpDELETE(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }
            //删除方案
            if (request["Action"] == "deleteHXT")
            {

                string[] arr = para("28", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    string planid = Common.PageValidate.InputText(request["fid"], 50);
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    // 签名加密
                    string aa = "sdfaadsasdasd";
                    string md5aa = MD5(aa).ToLower();
                    string sign = MD5(appSecret + appKey + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                         .Append("/" + planid)
                        .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
                    string result = "";
                    result = HttpDELETE(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }
            //获取指定方案的装修清单
            if (request["Action"] == "Getzxlist")
            {

                string[] arr = para("4", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    string designId = "3FO4JGPB07QO";
                    // Common.PageValidate.InputText(request["designId"], 50)
                    int start = 0; int num = 999;
                    //int.Parse(Common.PageValidate.InputText(request["start"], 50));
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    // 签名加密
                    string aa = "sdfaadsasdasd";
                    string md5aa = MD5(aa).ToLower();
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                         .Append("/"+designId)
                        .Append("/itemlist")//?starttime=
                        // .Append((int.Parse(timestamp) - (300 * 24 * 3600 * 1000)).ToString())
                         .Append("?start=").Append(start)
                        .Append("&num=").Append(num)
                        .Append("&appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);



                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }
            //获取指定方案的户型图
            if (request["Action"] == "Gethxt")
            {

                string[] arr = para("3", uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    string designId = Common.PageValidate.InputText(request["desid"], 50);
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); //2分钟
                    // 签名加密
                    string aa = "sdfaadsasdasd";
                    string md5aa = MD5(aa).ToLower();
                    string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                         .Append("/"+designId)
                        .Append("/planpic")//?starttime=
                        // .Append((int.Parse(timestamp) - (300 * 24 * 3600 * 1000)).ToString())
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign);
                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                     context.Response.Write(result);
                }

            }
            //获取指定方案的渲染图列表
            if (request["Action"] == "Getlist")
            {

                string[] arr = para("27", uid);
                    string appKey =arr[(int)paraenum.appKey];
                    string appSecret =arr[(int)paraenum.appSecret];
                    string userId = arr[(int)paraenum.userId];
                    if (appKey == null) context.Response.Write("请先配置参数！");
                    else
                    {
                        string designId = Common.PageValidate.InputText(request["desid"], 50);
                        object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                        string timestamp = currenttimemillis.ToString(); //2分钟
                        // 签名加密
                        string aa = "sdfaadsasdasd";
                        string md5aa = MD5(aa).ToLower();
                        string sign = MD5(appSecret + appKey  + timestamp).ToLower();
                        string api = arr[(int)paraenum.api];
                        StringBuilder apiBuilder = new StringBuilder();
                        apiBuilder.Append(api)
                             .Append("/"+designId)
                            .Append("/renderpics")//?starttime=
                           // .Append((int.Parse(timestamp) - (300 * 24 * 3600 * 1000)).ToString())
                        .Append("?appkey=").Append(appKey)
                        .Append("&timestamp=").Append(timestamp)
                        .Append("&sign=").Append(sign);
                    

                      
                        string result = "";
                        result = HttpGet(apiBuilder.ToString());
                        context.Response.Write(result);
                    }
               
            }
            //由户型图生成一个3D方案
            if (request["Action"] == "Design3D")
            {

                string[] arr = para("2",uid);
                string appKey = arr[(int)paraenum.appKey];
                string appSecret = arr[(int)paraenum.appSecret];
                string userId = arr[(int)paraenum.userId];
                if (appKey == null) context.Response.Write("请先配置参数！");
                else
                {
                    string planId = "3FO4KE2R8QD8";
                    // Common.PageValidate.InputText(request["planId"], 50)
                    object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                    string timestamp = currenttimemillis.ToString(); ;//2分钟
                    // 签名加密
                    string aa = "sdfaadsasdasd";
                    string md5aa = MD5(aa).ToLower();
                    string sign = MD5(appSecret + appKey + userId + timestamp).ToLower();
                    string api = arr[(int)paraenum.api];
                    StringBuilder apiBuilder = new StringBuilder();
                    apiBuilder.Append(api)
                    .Append("?appkey=").Append(appKey)
                    .Append("&timestamp=").Append(timestamp)
                    .Append("&sign=").Append(sign)
                    .Append("&planid=").Append(planId)
                    .Append("&appuid=").Append(userId);



                    string result = "";
                    result = HttpGet(apiBuilder.ToString());
                    context.Response.Write(result);
                }

            }

            //全景API
            if (request["Action"] == "getqjapi")
            {
                string openid = "5248c9be8592751a58b8eef6258e6578";

                string tel = Common.PageValidate.InputText(request["tel"], 50);
                // Common.PageValidate.InputText(request["designId"], 50)
                string api = "https://www.33qjvr.com/api/case?act=casebyphone&";
                //code=13451760505&openid=5248c9be8592751a58b8eef6258e6578
                object currenttimemillis = (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
                string timestamp = currenttimemillis.ToString(); //2分钟

                StringBuilder apiBuilder = new StringBuilder();
                apiBuilder.Append(api)
                .Append("&code=").Append(tel)
                .Append("&openid=").Append(openid);
                string result = "";
                result = HttpGet(apiBuilder.ToString());
                context.Response.Write(result);
            }

        }

         private static string MD5(string input) {

           string b  =FormsAuthentication.HashPasswordForStoringInConfigFile(input, "MD5");
          
         return b;
     }

         private string[] para(string id,string uid)
         {
            
             string[] arr= new string[10];
             BLL.CE_Para cp = new BLL.CE_Para();
             BLL.sys_info si = new BLL.sys_info();
             string host = si.GetList(" sys_key='sys_host'").Tables[0].Rows[0]["sys_value"].ToString();
           
             DataSet ds = cp.GetSingleSignOnList("  a.id=" + id + " and B.uid='" + uid + "'", host);
             if (ds.Tables[0].Rows.Count > 0)
             {
                 // 分配给每个商家的唯一的appkey和appsecret
                 foreach (DataRow dr in ds.Tables[0].Rows)
                 {
                    
                     arr[0] = dr["appKey"].ToString();
                     arr[1] = dr["appSecret"].ToString();
                     // 设定API文档中提到的参数
                     arr[2] = dr["appuid"].ToString();
                     arr[3] = dr["appuname"].ToString();
                     arr[4] = dr["appuemail"].ToString();
                     arr[5] = dr["appuphone"].ToString();
                     arr[6] = dr["appussn"].ToString();
                     arr[7] = dr["appuAddr"].ToString();
                     arr[8] = dr["appuavatar"].ToString();
                     arr[9] = dr["api"].ToString();
                 }
                 
                   // DataRow[] rows = ds.Tables[0].Select("1=1");
                      //arr = rows.Select(x => x[0].ToString()).ToArray();
             }

             return arr;
         }


         private string[] para_spec(string id, string uid)
         {

             string[] arr = new string[10];
             BLL.CE_Para cp = new BLL.CE_Para();
             BLL.sys_info si = new BLL.sys_info();
             string host = si.GetList(" sys_key='sys_host'").Tables[0].Rows[0]["sys_value"].ToString();

             DataSet ds = cp.GetSingleSignOnList("  a.id=" + id + " and B.uid='" + uid + "'", host);
             if (ds.Tables[0].Rows.Count > 0)
             {
                 // 分配给每个商家的唯一的appkey和appsecret
                 foreach (DataRow dr in ds.Tables[0].Rows)
                 {

                     arr[0] = dr["appKey"].ToString();
                     arr[1] = dr["appSecret"].ToString();
                     // 设定API文档中提到的参数
                     arr[2] = dr["appuid"].ToString();
                     arr[3] = dr["appuname"].ToString();
                     arr[4] = dr["appuemail"].ToString();
                     arr[5] = dr["appuphone"].ToString();
                     arr[6] = dr["appussn"].ToString();
                     arr[7] = dr["appuAddr"].ToString();
                     arr[8] = dr["appuavatar"].ToString();
                     arr[9] = dr["api"].ToString();
                 }

                 // DataRow[] rows = ds.Tables[0].Select("1=1");
                 //arr = rows.Select(x => x[0].ToString()).ToArray();
             }

             return arr;
         }


         protected enum paraenum
         {
                appKey ,
                appSecret,
                userId  ,
                userName ,
                email , 
                phone ,
                ssn,
                address,
                avatar,
                api
         }

         private string HttpDELETE(string Url)
         {
             string str="";
             HttpWebRequest request;
             string urlPath = Url;
             int millisecond = 30000;
             WebResponse response = null;
             StreamReader reader = null;
             try
             {
                 request = (HttpWebRequest)WebRequest.Create(urlPath);
                 //request.Proxy = null;//关闭代理（重要）
                 request.Timeout = millisecond;
                 request.Method = "DELETE";
                 //request.Accept = "application/json";
                 //request.ContentType = "application/json";
                 request.ServicePoint.Expect100Continue = false;
                 response = (WebResponse)request.GetResponse();
                 reader = new StreamReader(response.GetResponseStream());
                 str = reader.ReadToEnd();
             }
             catch (Exception ex)
             {
                 
                 str = "";
             }
             return str;
         }

         private string HttpPut(string Url)
         {
             string result = "";
             System.Net.WebClient myClient = new System.Net.WebClient();
            // myClient.Headers.Add("U-ApiKey", key);
             myClient.Encoding = Encoding.UTF8;
             try
             {
                 result = myClient.UploadString(Url, "PUT", "");
             }
             catch (Exception ex)
             {
                 result = ex.Message;
             }
             return result;
         }

         private string HttpGet(string Url)
         {
             HttpHelper http = new HttpHelper();
             HttpItem item = new HttpItem()
             {
                 URL = Url,//URL这里都是测试     必需项
                 Encoding = null,//编码格式（utf-8,gb2312,gbk）     可选项 默认类会自动识别
                 //Encoding = Encoding.Default,
                 Method = "GET",//URL     可选项 默认为Get
             };
             //得到HTML代码
             HttpResult result = http.GetHtml(item);
             string html = result.Html;
             return html;
         }

   

        /// <summary>
        /// 
        /// </summary>
        /// <param name="url"></param>
         /// <param name="method">"POST"/"GET"/"PUT "</param>
        /// <param name="postdatastr"></param>
        /// <returns></returns>
         private string HttpHelper_GetStr(string url,string method, string postdatastr)
         {
             HttpHelper http = new HttpHelper();
             HttpItem item = new HttpItem()
             {
                  URL =url,
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
                 Postdata =postdatastr,
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

      

      
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}