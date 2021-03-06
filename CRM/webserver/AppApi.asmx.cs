using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using XHD.DBUtility;//Please add references
using System.Data.SqlClient;
using System.Data;
using System.Text;
using XHD.BLL;
using XHD.Model;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
 
namespace XHD.CRM.webserver
{
    /// <summary>
    /// Summary description for AppApi
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class AppApi : System.Web.Services.WebService
    {
        XHD.CRM.Data.C_Sys_log log = new XHD.CRM.Data.C_Sys_log();
        webserver.RetrunStrCode rsc = new RetrunStrCode();//返回语句
     
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";

           // Customer_DynamicGraphics.aspx
        }

       
        [WebMethod]
        public void App_Trace(string html,string js ,string url ,string urldata,string returndata)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("INSERT INTO dbo.APP_Trace ");
            sb.AppendLine("        ( HTML , ");
            sb.AppendLine("          JS , ");
            sb.AppendLine("          URL , ");
            sb.AppendLine("          URLDATA , ");
            sb.AppendLine("          ReturnData , ");
            sb.AppendLine("          DoTime ");
            sb.AppendLine("        ) ");
            sb.AppendLine("VALUES  ( '"+html+"' , -- HTML - varchar(50) ");
            sb.AppendLine("          '"+js+"' , -- JS - varchar(50) ");
            sb.AppendLine("          '"+url+"' , -- URL - varchar(100) ");
            sb.AppendLine("          '"+urldata+"' , -- URLDATA - varchar(100) ");
            sb.AppendLine("          '"+returndata+"' , -- ReturnData - varchar(1000) ");
            sb.AppendLine("          getdate()  -- DoTime - datetime ");
            sb.AppendLine("        ) ");
            sb.AppendLine(" ");
         //sb.AppendLine(" where id=" + id + "");
            SqlParameter[] parameters = { };
             DbHelperSQL.ExecuteSql(sb.ToString(), parameters);

        }

        /// <summary>
        /// 登录
        /// </summary>
        /// <returns></returns>
          [WebMethod]
        public void UpdateUserClientId(string url, string user, string pwd, string ClientId,string version)
        {
            string password = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(pwd, "MD5");
            SqlParameter[] parameters = { };
            var sb = new System.Text.StringBuilder();

            sb.AppendLine("SELECT   * FROM");
            sb.AppendLine("hr_employee WHERE ISNULL(isDelete,0)='0' AND uid='" + user + "' AND pwd='" + password + "' AND ISNULL(token,'')=''");
            bool isexist = DbHelperSQL.Exists(sb.ToString(), null);
            if (isexist)
            {
                string token = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(
                             GetTimeStamp() + user
                             , "MD5").ToLower();
                sb.Clear();
                sb.AppendLine(" Update hr_employee");
                sb.AppendLine(" set token='" + token + "'");
                sb.AppendLine(" where  uid='" + user + "' AND pwd='" + password + "' AND ISNULL(token,'')=''");
                DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
            }
           
            sb.Clear();
            sb.AppendLine("SELECT ID,token, token AS UserId,name AS UserName,'"+ClientId+"' as ClientId,");
            sb.AppendLine("CASE WHEN ISNULL(title,'')='' THEN '" + url + "'+'images/icons/function_icon_set/user_48.png'");
            sb.AppendLine("ELSE '" + url + "'+'images/upload/portrait/'+title  END AS Avatar,");
            sb.AppendLine("d_id AS CorpId,ISNULL(level,0) AS level,CONVERT(VARCHAR(20),ISNULL(Delete_time,GETDATE()),120) as vertime FROM dbo.hr_employee");
            sb.AppendLine(" where ISNULL(isDelete,0)='0' AND  uid='" + user + "' AND pwd='" + password + "' ");
            DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
          
             if (ds == null)
             {
                 ReturnStr(true, "[]");
             }
                else
             {
                 if(ds.Tables[0].Rows.Count<=0)
                     ReturnStr(true, "[]");
                 else
                 {
                     log.Add_log(0, user, ClientId, "手机端登录", "手机端登录", 0, "手机端登录", password, "");
                     sb.Clear();
                     sb.AppendLine(" SELECT	1	FROM	dbo.APP_PushClient	WHERE	clientid='" + ClientId + "'	AND	Versions='" + version + "'	AND	userid='" + user + "' ");
                     bool existPushClient = DbHelperSQL.Exists(sb.ToString(), null);
                     if (!existPushClient)
                     {
                         sb.Clear();
                         sb.AppendLine("INSERT	INTO	dbo.APP_PushClient ");
                         sb.AppendLine("        ( Versions, clientid, userid ) ");
                         sb.AppendLine("VALUES  ( '" + version + "', -- Versions - varchar(10) ");
                         sb.AppendLine("          '" + ClientId + "', -- clientid - varchar(50) ");
                         sb.AppendLine("          '" + user + "'  -- userid - varchar(20) ");
                         sb.AppendLine("          ) ");
                         sb.AppendLine(" ");
                         DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
                     }
                     string str = Common.DataToJson.GetJson(ds);
                     ReturnStr(true, str);
                 }
            }
             
        }
          [WebMethod]
          public void autologin(string user, string version, string ClientId)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
                 sb.AppendLine(" SELECT	1	FROM	dbo.APP_PushClient	WHERE	clientid='" + ClientId + "'	AND	Versions='" + version + "'	AND	userid='" + user + "' ");
                     bool existPushClient = DbHelperSQL.Exists(sb.ToString(), null);
                     if (!existPushClient)
                     {
                         sb.AppendLine("INSERT	INTO	dbo.APP_PushClient ");
                         sb.AppendLine("        ( Versions, clientid, userid ) ");
                         sb.AppendLine("VALUES  ( '" + version + "', -- Versions - varchar(10) ");
                         sb.AppendLine("          '" + ClientId + "', -- clientid - varchar(50) ");
                         sb.AppendLine("          '" + user + "'  -- userid - varchar(20) ");
                         sb.AppendLine("          ) ");
                         sb.AppendLine(" ");
                         DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
                     }
                ReturnStr(true, "\"success\"");
             
          }

         [WebMethod]
          public void UpdateUserAvatar(string imgurl ,string token)
        {
             SqlParameter[] parameters = { };
            var sb = new System.Text.StringBuilder();

          
            sb.Clear();
            sb.AppendLine("UPDATE	 dbo.hr_employee SET title='"+imgurl+"' WHERE token= '" + token + "' ");
             if(DbHelperSQL.ExecuteSql(sb.ToString(), parameters)>0)
                 ReturnStr(true, "\"success\"");
             else ReturnStr(false, "\"faile\"");
                
             
        }

        /// <summary>
        /// 验证权限(利用账号时间判断)
        /// </summary>
        /// <param name="imgurl"></param>
        /// <param name="token"></param>
         [WebMethod]
          public void Verifauthority (string userid ,string rightid,string vertime)
                {
                     SqlParameter[] parameters = { };
                    var sb = new System.Text.StringBuilder();

                    sb.Clear();
                    sb.AppendLine("SELECT ID FROM dbo.App_Right_Employee WHERE	 empid="+userid+" AND app_meun_id="+rightid+" ");
                    bool isexist = DbHelperSQL.Exists(sb.ToString(), null);
                     
                    if (isexist)
                    {
                        sb.Clear();
                        sb.AppendLine("SELECT ID FROM  dbo.hr_employee WHERE CONVERT(VARCHAR(20),ISNULL(Delete_time,GETDATE()),120)='" + vertime + "' AND ISNULL(isDelete,0)=0	AND ID=" + userid + "  ");
                        bool isexistEmployee = DbHelperSQL.Exists(sb.ToString(), null);
                      if (isexistEmployee)   ReturnStr(true, "\"success\"");
                        else  ReturnStr(true, "\"noperson\"");//此人不存在，需要重新登录或修改密码
                       
                    }
                    else ReturnStr(true, "\"faile\""); //权限不存在
                
             
                }

         [WebMethod]
         public void Send_aliyunSendSMS(string tel,string type,string para)
         {
             XHD.CRM.Data.sms sms = new Data.sms();
             string aa = sms.aliyunSendSMS(tel,type,para);
             if(aa=="200")
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
                 ReturnStr(true, aa);
             }
            
             else ReturnStr(false, aa);
         }
        /// <summary>
        /// 新增试用客户
        /// </summary>
        /// <param name="title"></param>
        /// <param name="context"></param>
        /// <param name="ImageList"></param>
        /// <param name="IsHostPic"></param>
        /// <param name="type"></param>
        /// <param name="userid"></param>
        /// <param name="url"></param>
         [WebMethod]
         public void addtrialcustomer(string tel, string compname,
              string username, string userid, string pwd )
          {
               SqlParameter[] parameters = { };
               Model.hr_employee hrm = new Model.hr_employee();
                     BLL.hr_employee hrb = new BLL.hr_employee();
                     string sql = "select count(1) from hr_employee where tel='" + tel + "'";
                     if (DbHelperSQL.Exists(sql, parameters))
                     {
                         ReturnStr(true, "\"tel\"");
                         return;
                     }
                     hrm.uid = userid;
                     hrm.pwd = pwd;
                      hrm.level = "99";//试用账户
                      hrm.tel = tel;
                      hrm.name = "试用" + username;
               
                if(hrb.Add(hrm) >0)
              ReturnStr(true, "\"success\"");
               
              else ReturnStr(false, "\"faile\"");
             


          }
        

        /// <summary>
          /// 个人信息
          /// </summary>
          /// <returns></returns>
          [WebMethod]
          public void GetUserClientId(string url, string token)
          {
               SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();

              sb.AppendLine("SELECT  a.uid,a.name,a.tel,a.dname,a.zhiwu,a.email,a.Address, ");
              sb.AppendLine(" CASE WHEN ISNULL(a.title,'')='' THEN '" + url + "'+'images/icons/function_icon_set/user_48.png'");
              sb.AppendLine("ELSE '" + url + "'+'images/upload/portrait/'+a.title  END AS Avatar ");
              sb.AppendLine("   ,ISNULL(b.Jf,0)	AS	jf");
              sb.AppendLine("  FROM hr_employee a   ");
              sb.AppendLine("   LEFT	JOIN	dbo.v_Jifen_Yg	b	ON	a.ID=b.ID   ");
              sb.AppendLine("   WHERE ISNULL(a.isDelete,0)='0' AND a.token='" + token + "' ");
                      
              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

              DSToJSON(ds);

          }

        /// <summary>
        /// 个人信息
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public void GetAccountList(  string ID)
        {
            SqlParameter[] parameters = { };
            string SQL = rsc.GetAccountList(ID);
            DataSet ds = DbHelperSQL.Query(SQL, parameters);

            DSToJSON(ds);

        }

        /// <summary>
        /// 个人信息
        /// </summary>
        /// <returns></returns>
        [WebMethod]
          public void GetAppVersion(string ver )
          {
               SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              sb.AppendLine("SELECT * FROM dbo.App_Version WHERE	Ver!='" + ver + "'  and IsLast='Y' and VerStyle='iphone'");
            
              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
              if (ds == null)
              {
                  ReturnStr(false, "[{\"Ver\":\"no\"]");
              }
              else
              {
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(false, "[{\"Ver\":\"no\"]");
                  else
                  {
                      //string str = Common.DataToJson.GetJson(ds);
                      ReturnStr(true,   Common.DataToJson.GetJson(ds) );
                  }
              }
          }
        
          [WebMethod]
          public void GetAppVersions(string ver, string type)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              sb.AppendLine("SELECT * FROM dbo.App_Version WHERE	Ver!='" + ver + "'  and IsLast='Y'");
              if (type == "ipad")
                  sb.AppendLine(" and VerStyle='ipad'");
              else if (type == "iphone")
                  sb.AppendLine(" and VerStyle='iphone'");
              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
              if (ds == null)
              {
                  ReturnStr(false, "[{\"Ver\":\"no\"]");
              }
              else
              {
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(false, "[{\"Ver\":\"no\"]");
                  else
                  {
                      //string str = Common.DataToJson.GetJson(ds);
                      ReturnStr(true, Common.DataToJson.GetJson(ds));
                  }
              }
          }


          [WebMethod]
          public void GetComboxType(string parentid)
          { 
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              if (parentid == "city")
              {  sb.Clear();
              sb.AppendLine("SELECT  ID id,Name params_name FROM CRM_Building WHERE IsDel ='N' order by params_name ");
              }
              else
              {
                  sb.Clear();
                  sb.AppendLine("  SELECT id,params_name FROM dbo.Param_SysParam");
                  sb.AppendLine("  where parentid=" + int.Parse(parentid));
                  sb.AppendLine("  ORDER BY params_order");
              }
                     
                       DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

                       DSToJSON(ds);
          }
       /// <summary>
       /// 客户类型
       /// </summary>
          [WebMethod]
          public void GetCustomerType(string url)
          {
               SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              if (url == "sgjl")//监理
              {
                  sb.Clear();
                
                  sb.AppendLine(" ");
                  sb.AppendLine("SELECT	DISTINCT	Emp_id_sg	AS	cid,Emp_sg	CustomerType	 FROM dbo.CRM_Customer  a");
                  sb.AppendLine(" INNER JOIN dbo.hr_employee B ON A.Emp_id_sg=B.ID WHERE	B.status='在职'  and ISNULL(B.isDelete,0)=0  AND Emp_id_sg IS	NOT		NULL AND Emp_id_sg>0 order  by Emp_sg ");
                  sb.AppendLine(" ");
              }
              if (url == "sjs")
              {
                  sb.Clear();
                  sb.AppendLine(" ");
                  sb.AppendLine("SELECT	DISTINCT Emp_id_sj	AS	cid,Emp_sj	CustomerType	 FROM dbo.CRM_Customer a");
                  sb.AppendLine(" INNER JOIN dbo.hr_employee B ON A.Emp_id_sj=B.ID 	WHERE	B.status='在职'  and ISNULL(B.isDelete,0)=0 AND Emp_id_sj IS	NOT		NULL AND Emp_id_sj>0 order  by Emp_sj ");
                  sb.AppendLine(" ");
              }
              if (url == "ywy")
              {
                  sb.Clear();
                  sb.AppendLine(" ");
                  sb.AppendLine("SELECT	DISTINCT Create_id	AS	cid,Create_name	CustomerType	 FROM dbo.CRM_Customer a");
                  sb.AppendLine(" INNER JOIN dbo.hr_employee B ON A.Emp_id_sj=B.ID 	WHERE	B.status='在职'  and ISNULL(B.isDelete,0)=0 AND Emp_id_sj IS	NOT		NULL AND Create_id>0 order  by Create_name ");
                  sb.AppendLine(" ");
              }
              if (url == "follow_llr")//录入人
              {
                  sb.Clear();
                  sb.AppendLine(" ");
                  sb.AppendLine("SELECT	DISTINCT Create_id	AS	cid,Create_name	CustomerType	 FROM dbo.CRM_Customer a");
                  sb.AppendLine(" INNER JOIN dbo.hr_employee B ON A.Emp_id_sj=B.ID 	WHERE B.status='在职'  and	ISNULL(B.isDelete,0)=0 AND Emp_id_sj IS	NOT		NULL AND Emp_id_sj>0 order  by Emp_sj ");
                  sb.AppendLine(" ");
              }
              if (url == "jplx")//精品类型
              {
                  sb.Clear();
                  sb.AppendLine("SELECT DISTINCT employee_id,employee_name FROM  dbo.CRM_Follow WHERE employee_id>0 AND ISNULL(employee_name,'')!=''");
 
              }
 
               if (url ==  "addry")//新增业务员，等
              {
                  sb.Clear();
                  sb.AppendLine(" SELECT ID AS cid,name AS CustomerType FROM  hr_employee WHERE status='在职' ORDER BY name ");
              }
              
 
              else
              {
                  sb.AppendLine(" SELECT  ");
                  sb.AppendLine("   DISTINCT id as cid ,isnull(params_name,'未知') as CustomerType");
                  sb.AppendLine(", CASE WHEN ISNULL(icon,'')='' THEN '" + url + "'+'images/Icon/96.png'");
                  sb.AppendLine(" ELSE '" + url + "'+icon  END AS Avatar ");
                  sb.AppendLine("   FROM dbo.Param_SysParam WHERE parentid=1");
              }
                  DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

                  DSToJSON(ds);

          }

          /// <summary>
          /// 客户List
          /// </summary>
          [WebMethod]
          public void GetCustomerList(string keyword, string ID, string url, string topnumber, string searchkey )
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();

              string serchtxt = "";
              sb.AppendLine(" SELECT TOP " + topnumber + " A.id, Serialnumber,Customer,address,tel,CustomerType,Community,DesCripe,Remarks ");
              sb.AppendLine(",UPPER(dbo.chinese_firstletter(ltrim(Customer))) as header");
              sb.AppendLine(", CASE WHEN ISNULL(CustomerType_id,'')='' THEN '" + url + "'+'images/Icon/96.png'");
              sb.AppendLine("ELSE '" + url + "'+C.icon  END AS Avatar ");
             sb.AppendLine(" FROM dbo.CRM_Customer A");
             sb.AppendLine("  INNER JOIN Param_SysParam C on C.id=A.CustomerType_id and parentid=1");
             sb.AppendLine("    where   1=1");
              if (!string.IsNullOrEmpty(keyword))
             {
                 if (keyword == "search")
                 {
                     if (!string.IsNullOrEmpty(searchkey))
                     {
                         string[] str = searchkey.Split(';');
                         if (str[5] == "fav")
                         {
                            // sb.AppendLine("  LEFT JOIN Crm_Customer_Favorite B on B.customer_id=A.id and userid=" + ID);
                             sb.AppendLine("  and  A.id in (select customer_id  from  Crm_Customer_Favorite where userid=" + ID+")");

                         }
                    
                         sb.AppendLine(" and address    like    '%"+str[0]+"%' ");
                         if (str[1]!="")
                             sb.AppendLine(" and Emp_id_sg   = '" + str[1] + "' ");
                         if (str[2] != "")
                             sb.AppendLine(" and Emp_id_sj    =    '" + str[2] + "' ");
                         sb.AppendLine(" and A.CustomerType_id    like    '%" + str[3] + "%' ");
                         sb.AppendLine(" and tel    like    '%" + str[4] + "%' ");
                         sb.AppendLine(" and Customer    like    '%" + str[6] + "%' ");//姓名
                         if (str[7] != "")
                             sb.AppendLine(" and a.Create_date >= '" + str[7] + " 00:00' ");//开始时间
                         if (str[8] != "")
                             sb.AppendLine(" and a.Create_date  <=  '" + str[8] + " 23:59' ");//
                         if (str[9] != "")
                         {
                             //sb.AppendLine(" and Customer    like    '%" + str[9] + "%' ");//姓名
                             string zh = string.Format(" and ( Customer like N'%{0}%' or tel  like N'%{0}%' or Community like N'%{0}%' or address like N'%{0}%' or DesCripe like N'%{0}%' or Remarks like N'%{0}%' ) ", str[9]);
                             sb.AppendLine(zh);
                         }
                     }
                 }

             }
              sb.AppendLine(" and ISNULL(isDelete,0)='0' ");
           
             //加入权限控制
             serchtxt += DataAuth(ID);
             string ordertxt = " ORDER BY a.Create_date DESC ";
             string strsql = " SELECT * FROM ( "+sb.ToString() + serchtxt + ordertxt +")AA ORDER BY header";
             DataSet ds = DbHelperSQL.Query(strsql, parameters);
             DSToJSON(ds);

          }

          /// <summary>
          /// 客户List
          /// </summary>
          [WebMethod]
          public void GetCustomerList_Page(string keyword, string ID, string url, string index, string searchkey)
          {
              SqlParameter[] parameters = { };
              int pagesize = 20;
              int startindex = int.Parse(index) * pagesize;
              int perindex = (int.Parse(index) - 1) * pagesize;
              var sb = new System.Text.StringBuilder();
              if (index == "50")//第一种
              {
                  startindex = 50;
                  perindex = 0;
                  pagesize = 50;
              }
              string serchtxt = "";
              sb.AppendLine(" SELECT TOP " + pagesize + "  ");
              sb.AppendLine(" A.id, Serialnumber,Customer,address,tel,CustomerType,Community,DesCripe,Remarks ");
              sb.AppendLine(",UPPER(dbo.chinese_firstletter(ltrim(Customer))) as header");
              sb.AppendLine(", CASE WHEN ISNULL(CustomerType_id,'')='' THEN '" + url + "'+'images/Icon/96.png'");
              sb.AppendLine("ELSE '" + url + "'+C.icon  END AS Avatar ");
              sb.AppendLine(" FROM dbo.CRM_Customer A");
              sb.AppendLine("  INNER JOIN Param_SysParam C on C.id=A.CustomerType_id and parentid=1");
              sb.AppendLine("    where   1=1");
              var sbt = new System.Text.StringBuilder();
              if (!string.IsNullOrEmpty(keyword))
              {
                  if (keyword == "search")
                  {
                      if (!string.IsNullOrEmpty(searchkey))
                      {
                          string[] str = searchkey.Split(';');
                          if (str[5] == "fav")
                          {
                              // sb.AppendLine("  LEFT JOIN Crm_Customer_Favorite B on B.customer_id=A.id and userid=" + ID);
                              sbt.AppendLine("  and  A.id in (select customer_id  from  Crm_Customer_Favorite where userid=" + ID + ")");

                          }
                          sbt.AppendLine(" and  ISNULL(address,'')    like    '%" + str[0] + "%' ");
                          if (str[1] != "")
                              sbt.AppendLine(" and ISNULL(Emp_id_sg,'')   = '" + str[1] + "' ");
                          if (str[2] != "")
                              sbt.AppendLine(" and ISNULL(Emp_id_sj,'')     =    '" + str[2] + "' ");
                          if (str[10] != "")//业务员
                              sbt.AppendLine(" and Create_id    =    '" + str[10] + "' ");
                          sbt.AppendLine(" and A.CustomerType_id    like    '%" + str[3] + "%' ");
                          sbt.AppendLine(" and  ISNULL(tel,'')      like    '%" + str[4] + "%' ");
                          sbt.AppendLine(" and ISNULL(A.Create_name,'')    like    '%" + str[6] + "%' ");//姓名
                          if (str[7] != "")
                              sbt.AppendLine(" and a.Create_date >= '" + str[7] + " 00:00' ");//开始时间
                          if (str[8] != "")
                              sbt.AppendLine(" and a.Create_date  <=  '" + str[8] + " 23:59' ");//
                          if (str[9] != "")
                          {
                              //sb.AppendLine(" and Customer    like    '%" + str[9] + "%' ");//姓名
                              string zh = string.Format(" and ( Customer like N'%{0}%' or tel  like N'%{0}%' or Community like N'%{0}%' or address like N'%{0}%' or DesCripe like N'%{0}%' or Remarks like N'%{0}%' ) ", str[9]);
                              sbt.AppendLine(zh);
                          }
                      }
                  }

              }
              sb.AppendLine(" and ISNULL(isDelete,0)='0' ");
              serchtxt += DataAuth(ID);
              sb.AppendLine(" AND a.id>(select ISNULL(max(id),0) from (select top " + perindex + " id from CRM_Customer WHERE 1=1  ");
             
              sb.AppendLine("  " +sbt.ToString() +serchtxt + " order by id)a)");
              string ordertxt = " ORDER BY UPPER(dbo.chinese_firstletter(ltrim(Customer)))    ";
              string strsql =    sb.ToString() + sbt.ToString()+ serchtxt + ordertxt ;

              DataSet ds = DbHelperSQL.Query(strsql, parameters);

              string strcount = "  select count(1) count   FROM dbo.CRM_Customer A  INNER JOIN Param_SysParam C on C.id=A.CustomerType_id and parentid=1  where  ISNULL(isDelete,0)='0' AND 1=1 " + sbt.ToString();
              DataSet dsc = DbHelperSQL.Query(strcount + serchtxt, parameters);
              string cout=dsc.Tables[0].Rows[0][0].ToString();
              if (ds == null)
              {
                  ReturnStr(true, "[[],{\"Total\":0} ]");
              }
              else
              {
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(true, "[[],\"Total\":0]");
                  else
                  {
                      string str = Common.DataToJson.GetJson(ds);
                      ReturnStr(true, "[" + str + ",{\"Total\":" + cout + "}]");
                  }
              }

          }

          /// <summary>
          /// 新增客户
          /// </summary>
          /// <param name="id"></param>
          [WebMethod]
          public void AddCustomer( string data )
          {
              string[] str = data.Split(';');
              string sqlIsExistPhone = "SELECT 1 FROM dbo.CRM_Customer WHERE tel='" + str[2] + "'";
              SqlParameter[] parameters = { };
              if (DbHelperSQL.Exists(sqlIsExistPhone, parameters))
              { 
                 ReturnStr(false, "\"faile:phone\"");
                 return;
              }
              //khmc+';'+tel+';'+lhTitle+';'+adressTitle+';'+khlx+';'+khlxTitle+';'+ywy+';'+ywyTitle+';'+lp+';'+lpTitle+';'+hx+';'+hxTitle+';'+bzContent+';'+getUserInfo().ID;
              BLL.CRM_Customer bcp = new BLL.CRM_Customer();
              Model.CRM_Customer mcp = new Model.CRM_Customer();
              mcp.Customer=str[0];//客户名称
              mcp.tel = str[1];//电话
              mcp.address = str[2]+"栋"+str[3];//地址
           
              mcp.CustomerType_id = int.Parse(str[4]);//客户类型
              mcp.CustomerType = str[5];
              mcp.Employee_id = int.Parse(str[6]); //业务员
              mcp.Employee = str[7]; //业务员
              mcp.Community_id = int.Parse(str[8]);//楼盘
              mcp.Community = str[9];// 
              mcp.Fwhx_id = int.Parse(str[10]);//户型
              mcp.Fwhx = str[11];//户型
              mcp.privatecustomer = "私客";
              mcp.Remarks = str[12];
              //str[10]用户ID
              string sqlemplooye = "SELECT * FROM  dbo.hr_employee WHERE ID='" + str[13] + "'	";
              DataSet lsds = DbHelperSQL.Query(sqlemplooye);
              if (lsds.Tables[0].Rows.Count > 0)
              {
                  mcp.Create_id = int.Parse(str[10]);
                  mcp.Create_name = lsds.Tables[0].Rows[0]["name"].ToString();
                  mcp.Department_id = int.Parse(lsds.Tables[0].Rows[0]["d_id"].ToString());
                  mcp.Department = lsds.Tables[0].Rows[0]["dname"].ToString();  
              }
             // mcp.privatecustomer = str[11];//公私客
            
              mcp.Create_date = DateTime.Now; 
              if (bcp.Add(mcp) > 0)
              { 
                  ReturnStr(true, "\"success\"");
              }

              else ReturnStr(false, "\"faile\"");



          }

          /// <summary>
          /// 客户明细
          /// </summary>
          [WebMethod]
          public void GetCustomerDetail(string id,string userid)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();

              string serchtxt = "";
              sb.AppendLine(" SELECT A.id, Serialnumber,Customer,address,tel,Create_name,CustomerType,Emp_sj AS sjs,Employee AS ywy,Emp_sg AS sgjl ");
              sb.AppendLine(" ,Case when B.customer_id is null then 0 else 1 end as isstart");
              sb.AppendLine("  , CONVERT(VARCHAR(10),Create_date,120)	cd  ");
              sb.AppendLine(" FROM dbo.CRM_Customer A");
              sb.AppendLine(" LEFT JOIN Crm_Customer_Favorite B on B.customer_id=A.id AND userid="+userid);
              sb.AppendLine(" where ISNULL(isDelete,0)='0' AND a.id=" + id + "");
               

              DataSet ds = DbHelperSQL.Query(sb.ToString() + serchtxt, parameters);

              DSToJSON(ds);

          }
        [WebMethod]
        public void GetCustomerDetail_tel(string tel)
        {
            SqlParameter[] parameters = { };
            var sb = new System.Text.StringBuilder();

            string serchtxt = "";
            sb.AppendLine(" SELECT A.*");
            sb.AppendLine(" FROM dbo.CRM_Customer A");
            sb.AppendLine(" where ISNULL(isDelete,0)='0' AND a.tel='" + tel + "'");


            DataSet ds = DbHelperSQL.Query(sb.ToString() + serchtxt, parameters);

            DSToJSON(ds);

        }

        /// <summary>
        /// 跟进
        /// </summary>
        /// <param name="id"></param>
        [WebMethod]
          public void GetCRM_Follow(string id,string url,string nowindex)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              int startindex = int.Parse( nowindex)-10;
              int perindex =  int.Parse(nowindex);
              string serchtxt = "";
              sb.AppendLine("SELECT top " + perindex + " CONVERT(VARCHAR(16),Follow_date,120) AS Follow_date,A.id,Customer_id,Customer_name,Follow,employee_name,Follow_Type  ");
               sb.AppendLine(" ,CASE WHEN ISNULL(title,'')='' THEN '" + url + "'+'images/icons/function_icon_set/user_48.png'");
               sb.AppendLine("ELSE '" + url + "'+'images/upload/portrait/'+title  END AS Avatar ");
               sb.AppendLine(" ,(SELECT COUNT(1) FROM CRM_Follow where Customer_id=" + id + " AND ISNULL(isDelete,0)='0') AS TotalCount");
             sb.AppendLine("FROM dbo.CRM_Follow A ");
              sb.AppendLine("INNER JOIN dbo.hr_employee B ON A.employee_id=B.ID ");

              sb.AppendLine(" where ISNULL(A.isDelete,0)='0' AND A.Customer_id=" + id + "");
              sb.AppendLine(" AND  (");//因为需求是从大到小
              sb.AppendLine("A.id>=(SELECT ISNULL(min(id),0) FROM (SELECT TOP " + perindex + " id FROM ");
              sb.AppendLine(" CRM_Follow where Customer_id=" + id + " AND ISNULL(isDelete,0)='0' ORDER BY Follow_date DESC )AS T ");
              sb.AppendLine(" ) ");
              sb.AppendLine(") ");//总数应该不会超过9亿
              sb.AppendLine("AND   A.id<(SELECT ISNULL(min(id),999999999) FROM (SELECT TOP " + startindex + " id FROM ");
                sb.AppendLine(" CRM_Follow where Customer_id=" + id + " AND ISNULL(isDelete,0)='0' ORDER BY Follow_date DESC )AS T ");
                sb.AppendLine(" ) ");

              sb.AppendLine(" ORDER BY Follow_date desc");

              DataSet ds = DbHelperSQL.Query(sb.ToString() + serchtxt, parameters);

              DSToJSON(ds);

          }

          [WebMethod]
          public void GetMessage(string SelectType, string startIndex, string endIndex)
          {
              SqlParameter[] parameters = { };
              
              var sb = new System.Text.StringBuilder();
              //滚动(新闻)
              if (SelectType == "IndexMsg")
              {
                  sb.AppendLine("SELECT top " + endIndex + " id AS ID,news_title AS Title,'activity' AS ListType ");
                  sb.AppendLine(" ,create_name,create_id,news_content, img AS IsHostPic,CONVERT(varchar(16),news_time, 120)  AS ReleaseTime");
                  sb.AppendLine(" FROM dbo.public_news   ");
                  if (startIndex == "1")//列表，
                  {
                      int t = int.Parse(endIndex) - 10;
                      sb.AppendLine("   where   id  not in(select top " + t + "    id  from  public_news   ORDER	BY	news_time	DESC     )");

                  } sb.AppendLine(" ORDER	BY	news_time	DESC");
              }
              else if (SelectType == "Msgdetail")
              {
                  sb.AppendLine("SELECT  id AS ID,news_title AS Title,create_name,create_id,'activity' AS ListType ");
                  sb.AppendLine(" ,news_content, img AS IsHostPic,CONVERT(varchar(16),news_time, 120)  AS ReleaseTime");
                  sb.AppendLine(" FROM dbo.public_news   ");
                  sb.AppendLine(" where id=" + endIndex + "");
              }
              string retstr = "[";
              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
              if (ds.Tables[0].Rows.Count <= 0)
                  retstr = "[]";
              else
              {
                  string str = Common.DataToJson.GetJson(ds);
                  retstr += str;
              }
             
                //审批
              string SPstr = "[]";
              //企业公告
              string GGstr = "";
              DataSet dsGG = DbHelperSQL.Query("SELECT 1 FROM  dbo.public_news WHERE news_time>=GETDATE()-3 AND ISNULL(isDelete,0)=99", parameters);
              if (dsGG.Tables[0].Rows.Count <= 0)
                  GGstr = "[]";
              else
              {
                  string str = Common.DataToJson.GetJson(dsGG);
                  GGstr += str;
              }
              
              //调查问卷
              //string DCstr = "[]";
              sb.Clear();
               string s=  rsc.getbirstring()  ;
              string DCstr = "";
              DataSet dsDC = DbHelperSQL.Query(s + " AND ts< 7", parameters);
              if (dsDC.Tables[0].Rows.Count <= 0)
                  DCstr = "[]";
              else
              {
                  string str = Common.DataToJson.GetJson(dsDC);
                  DCstr += str;
              }
              //活动报名
              string HDstr = "[]";
              retstr += "," + SPstr + "," + GGstr + "," + DCstr + "," + HDstr+"]";
              ReturnStr(true,retstr);
          }

          /// <summary>
          /// gonggao
          /// </summary>
          /// <param name="id"></param>
          [WebMethod]
          public void AddMessage(string title, string context,
              string ImageList, string IsHostPic, string type,
              string userid,string  url
              )
          {
              SqlParameter[] parameters = { };
              string[] str = ImageList.Split(',');
              string    imglist="";
              if (str.Length > 0)
                  for (int i = 0; i < str.Length-1; i++)
                      imglist += url + "images/upload/temp/" + str[i]+"  </br>";
              var sb = new System.Text.StringBuilder();
              sb.AppendLine("INSERT	INTO	dbo.public_news ");
              sb.AppendLine("        ( news_title , ");
              sb.AppendLine("          news_content , ");
              sb.AppendLine("          create_id , ");
              sb.AppendLine("          create_name , ");
              sb.AppendLine("          dep_id , ");
              sb.AppendLine("          dep_name , ");
              sb.AppendLine("          news_time,  ");
              sb.AppendLine("          img,isDelete ");
              sb.AppendLine("        ) ");
              sb.AppendLine("VALUES  ( '"+title+"' , ");
              sb.AppendLine("          '" + imglist+context + "' ,  ");
              sb.AppendLine("          "+userid+" ,   ");
              sb.AppendLine("          '' ,  ");
              sb.AppendLine("          0 ,  ");
              sb.AppendLine("          '' ,   ");
              sb.AppendLine("          getdate(),  ");
              sb.AppendLine("          '"+IsHostPic+"',99   ");
              sb.AppendLine("        ) ");
              var RV = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
              if (RV > 0)
              {

              push("1", "  ", title, context);
              pushpad("3", "  ", title, context);
              ReturnStr(true, "\"success\"");
              }
                
              else ReturnStr(false, "\"faile\"");
             


          }

          [WebMethod]
          public void GetApp_Conifg()
          {
              SqlParameter[] parameters = { };

              var sb = new System.Text.StringBuilder();
             
              sb.AppendLine("SELECT   * FROM  dbo.App_Conifg   ");
              
              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
              DSToJSON(ds);

 
          }
          [WebMethod]
          public void GetApp_Conifg_code(string Code)
          {
              SqlParameter[] parameters = { };

              var sb = new System.Text.StringBuilder();

              sb.AppendLine("SELECT  interfaceUrl FROM  dbo.App_Conifg where code='" + Code + "'  ");

              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
                string rstr=  ds.Tables[0].Rows[0][0].ToString();
                Context.Response.Charset = "utf-8"; //设置字符集类型  
                Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
                Context.Response.Write(rstr);

                Context.Response.End();

          }
          [WebMethod]
          public void GetNoticeAlarm_Config(string style)
          {
              SqlParameter[] parameters = { };

              var sb = new System.Text.StringBuilder();

              sb.AppendLine("SELECT * FROM dbo.NoticeAlarm_Config where style='" + style + "'  ");

              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
              DSToJSON(ds);

          }


          [WebMethod]
          public void GetApp_Group(string url, string CorpID, string UserId,string GroupID)
          {
              SqlParameter[] parameters = { };

              var sb = new System.Text.StringBuilder();
              //滚动(新闻)
              sb.AppendLine(" SELECT ID,GroupID,GroupName,CorpID,UserId,ReleaseTime  ");
              sb.AppendLine(" FROM dbo.App_Group WHERE 1=1 ");
              if (UserId!="")
                  sb.AppendLine(" AND UserId='" + UserId + "'  ");// CorpID='"+CorpID+"' AND 
              if (GroupID != "")
                  sb.AppendLine("  AND GroupID='" + GroupID + "'");
              string retstr = "[";
              string mstr = "";
              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
              if (ds.Tables[0].Rows.Count <= 0)
                  mstr = "[]";
              else
              {
                  mstr = Common.DataToJson.GetJson(ds);
           
              }
              sb.Clear();
              string detailstr = "";
              sb.AppendLine("  SELECT B.ID, GroupID, A.CorpID,A.UserId, ");
              sb.AppendLine("   GroupUserID, B.name AS UserName ");
              sb.AppendLine(" ,CASE WHEN ISNULL(title,'')='' THEN '" + url + "'+'images/icons/function_icon_set/user_48.png'");
              sb.AppendLine("ELSE '" + url + "'+'images/upload/portrait/'+title  END AS Avatar ");
         
              sb.AppendLine(" FROM dbo.App_Group_Detail A");
              sb.AppendLine(" INNER JOIN dbo.hr_employee B ON A.GroupUserID=B.token ");
              sb.AppendLine(" where 1=1 ");
              if (UserId != "")
                  sb.AppendLine(" AND  A.UserId='" + UserId + "' ");//A.CorpID='" + CorpID + "' AND 
              if (GroupID != "")
                  sb.AppendLine("  AND A.GroupID='" + GroupID + "'");
              DataSet dsdetail = DbHelperSQL.Query(sb.ToString(), parameters);
              if (dsdetail.Tables[0].Rows.Count <= 0)
                  detailstr = "[]";
              else
              {
                  detailstr = Common.DataToJson.GetJson(dsdetail);
    
              }
              retstr += mstr+ "," + detailstr +  "]";
              ReturnStr(true, retstr);
          }


          [WebMethod]
          public void GetUserList(string url)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();

              sb.AppendLine("SELECT token as UserId,  uid as LoginId,name as UserName,tel,tel as Mobile ,dname as DepartmentName,zhiwu,email as Email,Address, ");
              sb.AppendLine(" CASE WHEN ISNULL(title,'')='' THEN '" + url + "'+'images/icons/function_icon_set/user_48.png'");
              sb.AppendLine("ELSE '" + url + "'+'images/upload/portrait/'+title  END AS Avatar ");
              sb.AppendLine(" ,UPPER(dbo.chinese_firstletter(ltrim(name))) as Header");
              sb.AppendLine("  FROM hr_employee WHERE ISNULL(isDelete,0)='0' ");
              sb.AppendLine(" ORDER BY UPPER(dbo.chinese_firstletter(ltrim(name)))");
              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

              DSToJSON(ds);
              

          }
         
          /// <summary>
          /// 跟进
          /// </summary>
          /// <param name="id"></param>
          [WebMethod]
          public void AddCRM_Follow(string id,string name,
              string userid,string username,string follow,
              string departid
              )
          {

              BLL.CRM_Follow bcf = new BLL.CRM_Follow();
              Model.CRM_Follow mcf = new Model.CRM_Follow();
              mcf.Customer_id = int.Parse(id);
                mcf.Customer_name=name;
                mcf.employee_id = int.Parse(userid);
                mcf.employee_name = username; 
              mcf.Follow=follow;
              mcf.department_id = int.Parse(departid);
              mcf.Follow_Type = "APP";
              mcf.Follow_date = DateTime.Now;
              mcf.isDelete = 0;
              if(bcf.Add(mcf)>0)
                  ReturnStr(true, "\"success\"");
              else ReturnStr(false, "\"faile\"");
                

          }

          [WebMethod]
          public void DeleteApp_Group(string ID)
          {
              var sb = new System.Text.StringBuilder();
              sb.AppendLine("DELETE dbo.App_Group_Detail ");
              sb.AppendLine(" WHERE GroupID=" + ID);
              sb.AppendLine("DELETE dbo.App_Group ");
              sb.AppendLine(" WHERE GroupID="+ID);
              SqlParameter[] parameters = { };
              var RV = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
              if (RV > 0)
                  ReturnStr(true, "\"success\"");
              else ReturnStr(false, "\"faile\"");
          }

          [WebMethod]
          public void AddApp_Group(string GroupID,  string GroupName,
                string UserId, string UserList 
              )
          {
              var sb = new System.Text.StringBuilder();
              sb.AppendLine("INSERT INTO dbo.App_Group ");
              sb.AppendLine("        ( GroupName , ");
              sb.AppendLine("          CorpID , ");
              sb.AppendLine("          GroupID , ");
              sb.AppendLine("          UserId , ");
              sb.AppendLine("          ReleaseTime ");
              sb.AppendLine("        ) ");
              sb.AppendLine("VALUES  ( '"+GroupName+"' ,   ");
              sb.AppendLine("          '' ,  ");
              sb.AppendLine("          '" + GroupID + "' , ");
              sb.AppendLine("          '" + UserId + "' , ");
              sb.AppendLine("          GETDATE()   ");
              sb.AppendLine("        ) ");
              sb.AppendLine(" ");
              string[] str = UserList.Split(',');
              foreach (string s in str)
              {
                  if (s.Length > 0)
                  {
                      sb.AppendLine(" INSERT INTO dbo.App_Group_Detail ");
                      sb.AppendLine("        ( GroupName , ");
                      sb.AppendLine("          CorpID , ");
                      sb.AppendLine("          UserId , ");
                      sb.AppendLine("          GroupUserID , ");
                      sb.AppendLine("          GroupID , ");
                      sb.AppendLine("          ReleaseTime ");
                      sb.AppendLine("        ) ");
                      sb.AppendLine(" VALUES  ( '" + GroupName + "' ,   ");
                      sb.AppendLine("          '' ,  ");
                      sb.AppendLine("          '" + UserId + "' ,     ");
                      sb.AppendLine("          '" + s + "' ,    ");
                      sb.AppendLine("          " + GroupID + " ,  ");
                      sb.AppendLine("         getdate() ");
                      sb.AppendLine("        ) ");
                  }

              }
              SqlParameter[] parameters = { };
            var RV = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
            if (RV > 0)
                ReturnStr(true, "\"success\"");
              else ReturnStr(false, "\"faile\"");


          }


        /// <summary>
        /// 客户收藏
        /// </summary>
          [WebMethod]
          public void UpdateCustomerFavorite(string customerid,string userid,string UStyle)
          {
              SqlParameter[] parameters = { };
              BLL.CRM_Customer cc = new BLL.CRM_Customer();
              if(UStyle=="Insert")
              {
                 

                  if (cc.AddFavorite(customerid, userid) <= 0)
                      ReturnStr(false, "\"faile\"");
                  else
                  {

                      ReturnStr(true, "\"success\"");
                  }
              }
              else if (UStyle == "Delete")
              {
                

                  if (!cc.DeleteFavorite(customerid, userid))
                      ReturnStr(false, "\"faile\"");
                  else
                  {

                      ReturnStr(true, "\"success\"");
                  }
              }

          }

          /// <summary>
          /// 客户收藏
          /// </summary>
          [WebMethod]
          public void UpdateFeedback(string contexts, string url, string name)
          {
              var sb = new System.Text.StringBuilder();
              sb.AppendLine("INSERT INTO dbo.App_Feedback ");
              sb.AppendLine("        ( contexts , ");
              sb.AppendLine("          remarks , ");
              sb.AppendLine("          DoTime , ");
              sb.AppendLine("          DoName , ");
              sb.AppendLine("          url ");
              sb.AppendLine("        ) ");
              sb.AppendLine("VALUES  ( '"+contexts+"' ,   ");
              sb.AppendLine("          '' ,  ");
              sb.AppendLine("          getdate() , ");
              sb.AppendLine("          '"+name+"' ,   ");
              sb.AppendLine("          '"+url+"'   ");
              sb.AppendLine("        ) ");
              sb.AppendLine(" ");
              SqlParameter[] parameters = { };

              var RV = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
              if (RV <= 0)
                      ReturnStr(false, "\"faile\"");
                  else
                  {

                      ReturnStr(true, "\"success\"");
                  }
              
              

          }

  /// <summary>
          /// 客户收藏
          /// </summary>
          [WebMethod]
          public void Getquertions(string ID, string strWhere, string starIndex, string endIndex, string type)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();

              //sb.AppendLine("SELECT token as UserId,  uid as LoginId,name as UserName,tel,tel as Mobile ,dname as DepartmentName,zhiwu,email as Email,Address, ");
              //sb.AppendLine(" CASE WHEN ISNULL(title,'')='' THEN '" + url + "'+'images/icons/function_icon_set/user_48.png'");
              //sb.AppendLine("ELSE '" + url + "'+'images/upload/portrait/'+title  END AS Avatar ");
              //sb.AppendLine(" ,UPPER(dbo.chinese_firstletter(ltrim(name))) as Header");
              //sb.AppendLine("  FROM hr_employee WHERE ISNULL(isDelete,0)='0' ");
              //sb.AppendLine(" ORDER BY UPPER(dbo.chinese_firstletter(ltrim(name)))");
              //DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

              //if (ds.Tables[0].Rows.Count <= 0)
              //    ReturnStr(false, "[]");
              //else
              //{
              //    string str = Common.DataToJson.GetJson(ds);
              //    ReturnStr(true, str);
              //}

              ReturnStr(true, "[[],[]]");

          }

          [WebMethod]
          public void GetNews(string nid, string strWhere, string starIndex, string endIndex, string type)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();

              //sb.AppendLine("SELECT token as UserId,  uid as LoginId,name as UserName,tel,tel as Mobile ,dname as DepartmentName,zhiwu,email as Email,Address, ");
              //sb.AppendLine(" CASE WHEN ISNULL(title,'')='' THEN '" + url + "'+'images/icons/function_icon_set/user_48.png'");
              //sb.AppendLine("ELSE '" + url + "'+'images/upload/portrait/'+title  END AS Avatar ");
              //sb.AppendLine(" ,UPPER(dbo.chinese_firstletter(ltrim(name))) as Header");
              //sb.AppendLine("  FROM hr_employee WHERE ISNULL(isDelete,0)='0' ");
              //sb.AppendLine(" ORDER BY UPPER(dbo.chinese_firstletter(ltrim(name)))");
              //DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

              //if (ds.Tables[0].Rows.Count <= 0)
              //    ReturnStr(false, "[]");
              //else
              //{
              //    string str = Common.DataToJson.GetJson(ds);
              //    ReturnStr(true, str);
              //}

              ReturnStr(true, "[[],[]]");

          }

        


          /// <summary>
          /// 客户收藏
          /// </summary>
          [WebMethod]
          public void pushapple(string deviceToken)
          {
              string aa = 
                    push("1", "  ", "测试标题", "：测试内容")  + pushpad("3", "  ", "测试标题", "：测试内容");

              ReturnStr(true, aa);

          }

          /// <summary>
          /// 积分查询
          /// </summary>
          [WebMethod]
          public void GetScore(string strwhere, string sfkh, string nowindex)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              int startindex = int.Parse(nowindex) - 10;
              int perindex = int.Parse(nowindex);
              string serchtxt = "";
              if (strwhere != "")
                  serchtxt += " AND (Name LIKE '%" + strwhere + "%' or tel LIKE '%" + strwhere + "%' )";
              if (sfkh == "Y")
              {
                  sb.AppendLine("SELECT TOP	10 * FROM dbo.v_Jifen_Kh");
                  sb.AppendLine("WHERE id >");
                  sb.AppendLine("          (");
                  sb.AppendLine("          SELECT ISNULL(MAX(id),0)");
                  sb.AppendLine("          FROM");
                  sb.AppendLine("                (");
                  sb.AppendLine("                SELECT TOP " + startindex + " id FROM v_Jifen_Kh where 1=1 " + serchtxt + " ORDER BY id");
                  sb.AppendLine("                ) A");
                  sb.AppendLine("          )");
                  sb.AppendLine(" " + serchtxt + "");
                  sb.AppendLine(" ORDER BY  id");
              }
              else
              {
                  sb.AppendLine("SELECT TOP	10 * FROM dbo.v_Jifen_Yg");
                  sb.AppendLine("WHERE id >");
                  sb.AppendLine("          (");
                  sb.AppendLine("          SELECT ISNULL(MAX(id),0)");
                  sb.AppendLine("          FROM");
                  sb.AppendLine("                (");
                  sb.AppendLine("                SELECT TOP " + startindex + " id FROM v_Jifen_Yg  where 1=1 " + serchtxt + "  ORDER BY id");
                  sb.AppendLine("                ) A");
                  sb.AppendLine("          )");
                  sb.AppendLine(" " + serchtxt + "");
                  sb.AppendLine(" ORDER BY  id");
              }

              DataSet ds = DbHelperSQL.Query(sb.ToString() , parameters);

              DSToJSON(ds);
          }

          /// <summary>
          /// 积分查询
          /// </summary>
          [WebMethod]
          public void GetScoreList(string strwhere, string sfkh, string nowindex, string type)
          {
              SqlParameter[] parameters = { };
              string sql = rsc.ListSorce(sfkh,nowindex,strwhere,type);
              DataSet ds = DbHelperSQL.Query(sql, parameters);
              DSToJSON(ds);

          }
          /// <summary>
          /// 积分查询
          /// </summary>
          [WebMethod]
          public void GetFollowList(string nowindex, string strwhere,string url,string userid)
          {
              SqlParameter[] parameters = { };
              string serchtxt = DataAuth(userid);
              string sql = rsc.GetLastListFollow(nowindex, strwhere, url, serchtxt,userid,"N");
              DataSet ds = DbHelperSQL.Query(sql, parameters);
              string strTotal = rsc.GetLastListFollow(nowindex, strwhere, url, serchtxt, userid, "Y");
              string cout = DbHelperSQL.Query(strTotal, parameters).Tables[0].Rows[0][0].ToString();
              if (ds == null)
              {
                  ReturnStr(true, "[[],{\"Total\":0} ]");
              }
              else
              {
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(true, "[[],\"Total\":0]");
                  else
                  {
                      string str = Common.DataToJson.GetJson(ds);
                      ReturnStr(true, "[" + str + ",{\"Total\":" + cout + "}]");
                  }
              }


          }

          [WebMethod]
          public void GetScoreDetail( string sfkh, string id)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();

             
               if (sfkh == "Y")
              {
                  sb.AppendLine("   SELECT * FROM dbo.v_Jifen_Kh_Mx where   1=1");
              }
              else {
                  sb.AppendLine("   SELECT * FROM dbo.v_Jifen_Yg_Mx  where   1=1");
              
              }
               if (id.Trim() != "")
               {
                   sb.AppendLine(" AND id=" + id);
               }
               sb.AppendLine(" ORDER BY InDate DESC ");
              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

              DSToJSON(ds);


          }


          /// <summary>
          /// 客户收藏
          /// </summary>
          [WebMethod]
          public void UpdateScore(string sfadd, string sfkh, string id,string score,string content,string uid)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              string jlx = "0";
              if (sfadd == "Y") jlx = "0"; else jlx = "1";
              if (int.Parse(score) < 0) score = (-int.Parse(score)).ToString();
              sb.AppendLine("INSERT INTO dbo.CRM_Jifen (ID,Jflx,Jf,Sfkh,Content,IsDel,InEmpID,InDate) ");
              sb.AppendLine("VALUES  ('" + id + "', ");
              sb.AppendLine("         '" + jlx + "', ");
              sb.AppendLine("         '" + score + "', ");
              sb.AppendLine("         '" + sfkh + "', ");
              sb.AppendLine("         '" + content + "', ");
              sb.AppendLine("         'N', ");
              sb.AppendLine("         '" + uid + "', ");
              sb.AppendLine("         GETDATE()  ");
              sb.AppendLine("         ) ");

              var RV = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
              if (RV > 0)
                  ReturnStr(true, "\"success\"");
              else ReturnStr(false, "\"faile\"");

          }

          /// <summary>
          /// 积分查询
          /// </summary>
          [WebMethod]
          public void GetBudge(string strWhere, string lx, string uid , string nowindex)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
          
              string serchtxt = DataAuth(uid);

              string sql = rsc.GetBudge(strWhere, lx, uid, nowindex, serchtxt);
              DataSet ds = DbHelperSQL.Query(sql , parameters);

              DSToJSON(ds);

          }
          /// <summary>
          /// 积分查询
          /// </summary>
          [WebMethod]
          public void GetBudgeDetail(string strWhere, string bid)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              
              if (strWhere.Trim() != "")
              {
                  sb.AppendLine(" AND " + strWhere);
              }
              string hj = "[]"; string detail = "[]"; string fjdetail = "[]";
             
              BLL.Budge_BasicDetail bbdetail = new BLL.Budge_BasicDetail();
              if (bid != "")
              {
                  sb.Clear();
                  sb.AppendLine("SELECT   JJAmount,ZCAmount,FJAmount,DiscountAmount+ FJAmount as DiscountAmount, customer_id,BudgetName,IsStatus,id");
                  sb.AppendLine(" FROM Budge_BasicMain");
                  sb.AppendLine(" WHERE id='"+bid+"'");
                  DataSet ds = DbHelperSQL.Query(sb.ToString() , parameters);
                  hj = Common.GetGridJSON.DataTableToJSON2(ds.Tables[0]);
                  string Total = ""; string serchtxt = "1=1";
                  serchtxt += " and   budge_id ='" + bid + "'";
                
                  string sorttext = "   ISNULL(OrderBy,0), ComponentName   desc";
                  DataSet dsd = bbdetail.GetBudge_BasicDetail(9999, 1, serchtxt, sorttext, out Total);
                  detail = Common.GetGridJSON.DataTableToJSON2(dsd.Tables[0]);

                  
           
                  BLL.budge bd = new budge();
                  DataSet dsfj = bd.GetBudge_Rate_Ver(9999, 1, serchtxt, "  id  ", out Total);
                  fjdetail = Common.GetGridJSON.DataTableToJSON2(dsfj.Tables[0]);
                  
              }




              string str = "{\"jhdata\":" + hj + ",\"detaildata\":" + detail + ",\"fjdata\":" + fjdetail + "}";
                      ReturnStr(true, str);
                  
          }


       
          [WebMethod]
          public void GetUserBirthday(string strWhere, string lx )
          {
              SqlParameter[] parameters = { };
 
              var sb = new System.Text.StringBuilder();
              string s = rsc.getbirstring();
              sb.AppendLine("");
              if (strWhere.Trim() != "")
              {
                  sb.AppendLine(" AND ts<"+strWhere+"");
              }
             
              sb.AppendLine("ORDER BY ts");
              DataSet ds = DbHelperSQL.Query(s+ sb.ToString() , parameters);

              if (ds == null)
              {
                  ReturnStr(true, "[]");
              }
              else
              {
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(true, "[]");
                  else
                  {
                      //if(lx=="birthday")//只能一次
                      //{
                          string Today = DateTime.Now.ToString("yyyy-MM-dd");
                          string sqlexist = " SELECT 1 FROM App_TimedTask WHERE	 id=1 AND CONVERT(VARCHAR(10),NextDoTime,120)=CONVERT(VARCHAR(10),GETDATE(),120)";
                          bool isexist = DbHelperSQL.Exists(sqlexist, null);
                            if (isexist)
                          foreach (DataRow dw in ds.Tables[0].Select(" nearbir = '" + Today + "'"))
                          {
                              string title = dw["UserName"].ToString() ;
                              string body =  dw["UserName"].ToString() + dw["age"].ToString() ;

                              push("4", " AND userid!='" + dw["uid"].ToString() + "'", title, body); pushpad("5", " AND userid!='" + dw["uid"].ToString() + "'", title, body);
                              push("1", " AND userid='" + dw["uid"].ToString() + "'", "祝你生日快乐", "今天是你" + dw["age"].ToString() + "岁生日，我们一起祝你生日快乐!"); pushpad("3", " AND userid!='" + dw["uid"].ToString() + "'", "祝你生日快乐", "今天是你" + dw["age"].ToString() + "岁生日，我们一起祝你生日快乐!");
                              //更新最后一次的时间。天数+1
                              string sqlupdate = " UPDATE App_TimedTask SET DoTime=GETDATE()+1,NextDoTime=GETDATE() WHERE id=1";
                              DbHelperSQL.ExecuteSql(sqlupdate, parameters);
                          }
                      
                      string str = Common.DataToJson.GetJson(ds);
                      ReturnStr(true, str);
                  }
              }

          }



          /// <summary>
          /// 材料
          /// </summary>
          [WebMethod]
          public void GetProduct(string strwhere,string lx,   string nowindex)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              int startindex = int.Parse(nowindex) - 10;
              int perindex = int.Parse(nowindex);
              string serchtxt = "";
              if (strwhere != "")
                  serchtxt += " AND (product_name LIKE '%" + strwhere + "%' or category_name LIKE '%" + strwhere + "%' )";
              if (lx != "")
                  serchtxt += " AND C_style LIKE '%" + lx + "%'";
              sb.AppendLine("SELECT TOP	" + perindex + " product_id,product_name,category_name,C_style,Brand,unit ");
              sb.AppendLine(" ,category_id,specifications,price,ProModel,ProSeries,Themes,C_code");
              sb.AppendLine("   FROM dbo.CRM_product");
              sb.AppendLine("WHERE product_id >");
                  sb.AppendLine("          (");
                  sb.AppendLine("          SELECT ISNULL(MAX(product_id),0)");
                  sb.AppendLine("          FROM");
                  sb.AppendLine("                (");
                  sb.AppendLine("                SELECT TOP " + startindex + " product_id FROM CRM_product where 1=1 " + serchtxt + " ORDER BY product_id");
                  sb.AppendLine("                ) A");
                  sb.AppendLine("          )");
                  sb.AppendLine(" " + serchtxt + "");
                  sb.AppendLine(" ORDER BY  product_id");
              

              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

              DSToJSON(ds);

          }

          /// <summary>
          /// 材料详情
          /// </summary>
          [WebMethod]
          public void GetProductDetail(string strwhere, string pid )
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              
              string serchtxt = "";
              if (strwhere != "")
                  serchtxt += " AND (product_name LIKE '%" + strwhere + "%' or category_name LIKE '%" + strwhere + "%' )";
              
              sb.AppendLine("SELECT   product_id,product_name,category_name,C_style,Brand,unit ");
              sb.AppendLine(" ,category_id,specifications,remarks,price,ProModel,ProSeries,Themes,C_code");
              sb.AppendLine("   ,zc_price,fc_price,rg_price");
              sb.AppendLine(" FROM dbo.CRM_product");
              sb.AppendLine("WHERE product_id= "+pid+"");
              sb.AppendLine(" " + serchtxt + "");
              sb.AppendLine(" ORDER BY  product_id");


              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

              DSToJSON(ds);

          }


          /// <summary>
          /// 更新预算状态
          /// </summary>
          [WebMethod]
          public void UpdateBudge(string selecttype, string id, string remarks, string username)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              string status = "0";
              if (selecttype == "ys_dsh") status = "2";
              else if (selecttype == "ys_dqr") status = "3";
              else if (selecttype == "NoPass") status = "0"; 
              sb.AppendLine("UPDATE	dbo.Budge_BasicMain	SET	IsStatus=" + status + "	WHERE	id='" + id + "' ");
              log.Add_Trace(id,status,remarks,username);
              var RV = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
              if (RV > 0)
                  ReturnStr(true, "\"success\"");
              else ReturnStr(false, "\"faile\"");

          }




          /// <summary>
          /// 全景图和效果图
          /// tel电话
          /// TYPE 类型
          /// cid 客户代码或desid
          /// uid 登录账号
          /// </summary>
          [WebMethod]
          public void GetQJT(string tel, string type, string cid,string uid)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              BLL.CE_Para cp = new BLL.CE_Para();
              app_kjl_api api = new app_kjl_api();

              if (type == "QJT")
              {
                
                  sb.Clear();
                  sb.AppendLine("SELECT id, DyUrl,DyGraphicsName,DoTime,Remarks,'自定义' AS lx ");
                  sb.AppendLine(" FROM dbo.Crm_Customer_DynamicGraphics ");
                  sb.AppendLine("     WHERE	Customer_id=  " + cid + "");
                  //第一部分，自定义
                  string retstr = "[";
                  DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
                  if (ds.Tables[0].Rows.Count <= 0)
                      retstr += "[]";
                  else
                  {
                      string str = Common.DataToJson.GetJson(ds);
                      retstr += str;
                  }

                  //酷家乐
                  string kjlstr = "";
             
                  string aa = api.GetKJL_QJT(tel);
                  if (aa.Length <= 0)
                      kjlstr = "[]";
                  else {
                      kjlstr += aa;
                  }

                  retstr += "," + kjlstr + "]";
                  ReturnStr(true, retstr);
              }
              else if (type == "XGT")
              {
                  
                    DataSet ds = cp.Getkjl_api_list(" curstomerid=" + cid, uid);
                    string  dt = Common.DataToJson.GetJson(ds);
                    ReturnStr(true, dt);
              }
              else if (type == "XGT3D")
              {
                  string sql = "SELECT uid FROM hr_employee	 WHERE ID= " + uid;
                  DataSet dsuid = DbHelperSQL.Query(sql, parameters);
                  string usid = dsuid.Tables[0].Rows[0][0].ToString();//用户名转为UID
                  string ds = api.Get3D_XGT_LIST(cid, usid);
                  ReturnStr(true, ds);
              }
              else if (type == "XGT3DALL")
              {
                  if (cid == "") ReturnStr(true,"[]");
                  string sql = "SELECT uid FROM hr_employee	 WHERE ID= " + uid;
                  DataSet dsuid = DbHelperSQL.Query(sql, parameters);
                  string usid = dsuid.Tables[0].Rows[0][0].ToString();//用户名转为UID
                  string ds = api.Get3D_XGT_All(cid, usid);
                  ReturnStr(true, "\""+ds+"\"");
              }
          }


        /// <summary>
          /// 案例加精列表
        /// </summary>
        /// <param name="strWhere"></param>
        /// <param name="nowindex"></param>
        /// <param name="url"></param>
          [WebMethod]
          public void GetLastListClassicCase(string strWhere,string type, string nowindex, string url)
          {

              SqlParameter[] parameters = { };
              string sql = rsc.GetLastListClassicCase(nowindex, strWhere,type, url);
              DataSet ds = DbHelperSQL.Query(sql, parameters);
              DSToJSON(ds);
          }
        /// <summary>
          /// 案例加精明细
        /// </summary>
        /// <param name="strWhere"></param>
        /// <param name="url"></param>
          [WebMethod]
          public void GetLastDetailClassicCase(string strWhere,   string url)
          {

              SqlParameter[] parameters = { };
              string sql = rsc.GetLastDetailClassicCase(strWhere, url);
              DataSet ds = DbHelperSQL.Query(sql, parameters);
              DSToJSON(ds);
          }

          /// <summary>
          /// 积分商店列表
          /// </summary>
          /// <param name="strWhere"></param>
          /// <param name="nowindex"></param>
          /// <param name="url"></param>
          [WebMethod]
          public void GetLastListScoreShop(string strWhere, string nowindex, string url)
          {

              SqlParameter[] parameters = { };
              string sql = rsc.GetLastListScoreShop(nowindex, strWhere, url);
              DataSet ds = DbHelperSQL.Query(sql, parameters);
              DSToJSON(ds);
          }
          /// <summary>
          /// 积分商店明细
          /// </summary>
          /// <param name="strWhere"></param>
          /// <param name="url"></param>
          [WebMethod]
          public void GetLastDetailScoreShop(string strWhere, string url)
          {

              SqlParameter[] parameters = { };
              string sql = rsc.GetLastDetailScoreShop(strWhere, url);
              DataSet ds = DbHelperSQL.Query(sql, parameters);
              DSToJSON(ds);
          }

          [WebMethod]
          public void GetNoticeAlarm(string strwhere, string code,string hostname)
          {

              SqlParameter[] parameters = { };
            string sql = " SELECT TOP 1 A.id,A.NoticeContent FROM dbo.NoticeAlarm A " +
                          " LEFT JOIN  dbo.NoticeAlarm_Log B ON A.id=B.NoticeID  AND HostName='" + hostname + "' " +
                          " WHERE isnull(isuse,'N')='N' and (B.id IS NULL ) " +
                          " OR (  NOTICETIME<GETDATE()) " +

                          "  update dbo.NoticeAlarm " +
                          " set noticetime=GETDATE()" +
                            " where id= (SELECT TOP 1  id  FROM dbo.NoticeAlarm   " +            
                          " WHERE isnull(isuse,'N')='N' " +
                          "     AND NOTICETIME<GETDATE() ) ";

              DataSet ds = DbHelperSQL.Query(sql, parameters);
             
              var sb = new System.Text.StringBuilder();
             
             sb.AppendLine(" INSERT INTO dbo.NoticeAlarm_Log ");
             sb.AppendLine("  ( NoticeID, HostName, DoTime ) ");
             sb.AppendLine("  SELECT TOP 1 A.id,'" + hostname + "',GETDATE() FROM dbo.NoticeAlarm A   ");
             sb.AppendLine("                LEFT JOIN  dbo.NoticeAlarm_Log B ON A.id=B.NoticeID  AND HostName='" + hostname + "' ");
             sb.AppendLine("      WHERE isnull(isuse,'N')='N' and (B.id IS NULL )");
            sb.AppendLine("    OR (  NOTICETIME<GETDATE()) ");
          
            var RV = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
             
              DSToJSON(ds);
          }

        [WebMethod]
        public void GetJPGL(string type, string strwhere)
        {
            SqlParameter[] parameters = { };
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("SELECT  ");
            if (type == "lx")
                sb.AppendLine(" DISTINCT params_id, B.params_name ");
            else sb.AppendLine("  A.* ");
            sb.AppendLine("   FROM dbo.smsmodel A");
            sb.AppendLine("  INNER JOIN  dbo.Param_SysParam B ON A.params_id=B.id ");
            if (strwhere != "")
                sb.AppendLine(strwhere);
            DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

            DSToJSON(ds);


        }


        [WebMethod]
        public void GetFinance(string type, string strwhere)
        {
            SqlParameter[] parameters = { };
            string sqlstr = rsc.GetFinance(type, strwhere);
            DataSet ds = DbHelperSQL.Query(sqlstr, parameters);

            DSToJSON(ds);


        }

        /// <summary>
        /// 项目名称
        /// </summary>
        /// <param name="type"></param>
        /// <param name="strwhere"></param>
        [WebMethod]
        public void GetXMLIST(string type, string strwhere)
        {
            BLL.CE_Para cp = new CE_Para();
            DataSet ds = cp.GetList("");

            DSToJSON(ds);


        }




        /// <summary>
        /// 增加维修记录
        /// </summary>
        /// <param name="id"></param>
        /// <param name="name"></param>
        /// <param name="userid"></param>
        /// <param name="username"></param>
        /// <param name="follow"></param>
        /// <param name="departid"></param>
        [WebMethod]
        public void AddCRM_Repair(string khbh ,string wxlbid, string wxyy,string sfkh,string wxrq,string wxsj,
         string userid,string khmc,string tel,string address
         )
        {

            StringBuilder sb = new StringBuilder();
            sb.AppendLine("             INSERT   INTO dbo.CRM_Repair  ");
            sb.AppendLine("                         ( Sfkh ,  ");
            sb.AppendLine("                           Khbh ,  ");
            sb.AppendLine("                           Khmc ,  ");
            sb.AppendLine("                           Khdh ,  ");
            sb.AppendLine("                           Khyx ,  ");
            sb.AppendLine("                           Khdz ,  ");
            sb.AppendLine("                           Khxq ,  ");
            sb.AppendLine("                           Khxb ,  ");
            sb.AppendLine("                           Wxrq ,  ");
            sb.AppendLine("                           Wxsj ,  ");
            sb.AppendLine("                           WxlbID ,  ");
            sb.AppendLine("                           Wxyy ,  ");
            sb.AppendLine("                           Clrq ,  ");
            sb.AppendLine("                           Wcrq ,  ");
            sb.AppendLine("                           Wczt ,  ");
            sb.AppendLine("                           Fzxs ,  ");
            sb.AppendLine("                           WxEmpID ,  ");
            sb.AppendLine("                           GdEmpID ,  ");
            sb.AppendLine("                           Hfxx ,  ");
            sb.AppendLine("                           Pjxx ,  ");
            sb.AppendLine("                           InEmpID ,  ");
            sb.AppendLine("                           InDate ,  ");
            sb.AppendLine("                           IsDel    ");
            sb.AppendLine(" 			            ");
            sb.AppendLine(" 			            )  ");
            sb.AppendLine("                         SELECT  '"+sfkh+"' ,  ");
            sb.AppendLine("                                 "+ khbh + " ,  ");
            sb.AppendLine("                                 '"+ khmc + "' ,  ");
            sb.AppendLine("                                 '"+tel+"' ,  ");
            sb.AppendLine("                                 '' ,  ");
            sb.AppendLine("                                 '"+ address + "' ,  ");
            sb.AppendLine("                                  '" + address + "' ,  ");
            sb.AppendLine("                                 '' ,  ");
            sb.AppendLine("                                 '"+wxrq+"' ,  ");
            sb.AppendLine("                                 '"+wxsj+"' ,  ");
            sb.AppendLine("                                 "+wxlbid+" ,  ");
            sb.AppendLine("                                 '"+wxyy+"' ,  ");
            sb.AppendLine("                                 NULL ,  ");
            sb.AppendLine("                                 NULL ,  ");
            sb.AppendLine("                                 '未处理' ,  ");
            sb.AppendLine("                                 0 ,  ");
            sb.AppendLine("                                 '' ,  ");
            sb.AppendLine("                                 '' ,  ");
            sb.AppendLine("                                 '' ,  ");
            sb.AppendLine("                                 '' ,  ");
            sb.AppendLine("                                 "+userid+" ,  ");
            sb.AppendLine("                                 GETDATE() ,  ");
            sb.AppendLine("                                 'N'  ");
            //sb.AppendLine("                         FROM    dbo.CRM_Customer where id="+ khbh + "   ");

            if (DbHelperSQL.ExecuteSql(sb.ToString())> 0)
                ReturnStr(true, "\"success\"");
            else ReturnStr(false, "\"faile\"");


        }
        /// <summary>
        /// 材料发单
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="startindex"></param>

        [WebMethod]
        public void GetCEStage(string uid, string startindex,string strwhere)
        {
            int nowindex = int.Parse(startindex) - 10;

            StringBuilder sb = new StringBuilder();
            string auth = DataAuth(uid);
            sb.AppendLine(" SELECT  top 10 * FROM (  ");
            sb.AppendLine(" SELECT  row_number() OVER (ORDER BY B.id  DESC ) n ,B.*,ISNULL(BeginDate,Jh_date) btime,A.address FROM dbo.CRM_CEStage B  ");
            sb.AppendLine(" INNER JOIN  dbo.CRM_Customer A ON	B.CustomerID=A.id  ");
            sb.AppendLine(" where 1=1 ");
            sb.AppendLine(" AND Stage_icon='正在施工' ");
            if (strwhere != "")
                sb.AppendLine(" and ( CustomerName like '%"+strwhere+ "%' or b.tel like '%" + strwhere + "%' )");
                sb.AppendLine(auth);
            sb.AppendLine(" )AA  ");
            sb.AppendLine(" WHERE n>" + nowindex);
            DataSet ds = DbHelperSQL.Query(sb.ToString());

            DSToJSON(ds);


        }

        /// <summary>
        /// 申请材料明细
        /// </summary> 
        /// <param name="strwhere"></param>
        [WebMethod]
        public void GetPurchaseList(string starIndex, string cid,string strwhere,string id,string uid)
        {
         string  sql= rsc.GetPurchaseList(starIndex, cid, strwhere,id,  uid);
            SqlParameter[] parameters = { }; 
            DataSet ds = DbHelperSQL.Query(sql, parameters);

            DSToJSON(ds);


        }

        /// <summary>
        /// 选材产品
        /// </summary>
        /// <param name="strwhere"></param>
        [WebMethod]
        public void GetSelectProduct(string strwhere)
        {
            StringBuilder sb = new StringBuilder();
            string serchtxt = "";
            sb.AppendLine(" SELECT TOP 20 * FROM	(  ");
            sb.AppendLine(" SELECT  ROW_NUMBER() OVER ( ORDER BY A.product_id DESC ) n ,  product_id,product_name,LEFT(B.C_CODE,1) header,A.specifications,A.Brand,A.ProSeries  ");
            sb.AppendLine(" ,A.c_style,A.price,AddOneStatistics  FROM dbo.CRM_product A  ");
            sb.AppendLine(" INNER JOIN CRM_product_category B ON	A.category_id=B.id  ");
            sb.AppendLine(" WHERE A.isDelete=0 AND	jbx in(3,1)   ");
                if (strwhere != "")
                    serchtxt += " AND (product_name LIKE '%" + strwhere + "%' or category_name LIKE '%" + strwhere + "%' )";

            sb.AppendLine(serchtxt);
        
            sb.AppendLine(" )AA  ");

            sb.AppendLine("  ORDER BY AA.AddOneStatistics DESC  ");

            SqlParameter[] parameters = { };
            DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

            DSToJSON(ds);


        }

        /// <summary>
        /// 新增工地选材
        /// </summary>
        /// <param name="cid"></param>
        /// <param name="pid">产品，可以逗号增加list</param>
        /// <param name="uid"></param>
        /// <param name="style">all</param>
        [WebMethod]
        public void InsertPurList(int cid, string pid, string uid, string style)
        {
            BLL.PurchaseList pl = new BLL.PurchaseList();
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT * FROM  dbo.PurchaseList WHERE CustomerID=" + cid + "  ");
            sb.AppendLine(" AND	 product_id IN(" + pid + ")  ");
            object obj = DbHelperSQL.GetSingle(sb.ToString());
            if (Convert.ToInt32(obj) > 0)
            {
                ReturnStr(false, "\"faile\"");
            }
            else
            {
                if (pl.InsertList(cid, pid, uid, "ALL") > 0)
                    ReturnStr(true, "\"success\"");
                else ReturnStr(false, "\"faile\"");
            }


        }

        /// <summary>
        /// 更新数量
        /// </summary>
        /// <param name="sum"></param>
        /// <param name="cid"></param>
        /// <param name="id"></param>
        [WebMethod]
        public void UpdatePurchaseListSum(decimal sum,string remarks,int cid, int id)
        {
           
            // ph.UpdateSUM(sum,0,cid,id);
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update PurchaseList set ");
            strSql.Append(" b1='" + remarks + "',");
            strSql.Append("AmountSum=" + sum + "");
            strSql.Append(" where id=" + id + "");
            strSql.Append(" and CustomerID=" + cid + "");
            if (DbHelperSQL.ExecuteSql(strSql.ToString())>0)
                ReturnStr(true, "\"success\"");
            else ReturnStr(false, "\"faile\"");


        }
        /// <summary>
        /// 更新状态
        /// </summary>
        /// <param name="status"></param>
        /// <param name="cid"></param>
        /// <param name="id"></param>
        [WebMethod]
        public void UpdatePurchaseListStatus(decimal sum, string remarks, int  status, int cid, int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update PurchaseList set ");
 
            strSql.Append("IsStatus=" + status + " ");
            if (status == 1)//提交
            {
                strSql.Append(" ,AmountSum=" + sum + "");
                strSql.Append(" , b1='" + remarks + "'");
            }
              
            strSql.Append(" where id=" + id + "");
            strSql.Append(" and CustomerID=" + cid + "");
            if (DbHelperSQL.ExecuteSql(strSql.ToString()) > 0)
                ReturnStr(true, "\"success\"");
            else ReturnStr(false, "\"faile\"");
          

        }
        /// <summary>
        /// 采购单
        /// </summary>
        /// <param name="nowindex"></param>
        /// <param name="strwhere"></param>
        [WebMethod]
        public void GetPurchase(string nowindex,string isnode, string strwhere)
        {
            int startindex = int.Parse(nowindex) - 10;
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT TOP "+nowindex+" * FROM	(  ");
            sb.AppendLine(" SELECT  ROW_NUMBER() OVER ( ORDER BY cgid DESC ) n ,  ");
            sb.AppendLine("         *  ");
            sb.AppendLine(" FROM  dbo.Purchase_Main A   ");
            sb.AppendLine("  INNER JOIN  dbo.V_Purchase_info B ON	 A.Purid=B.cgid  ");
            sb.AppendLine(" where 1=1");
            if (strwhere != "")
                sb.AppendLine("  and ( Purid like '%"+strwhere+ "%' OR nr like '%" + strwhere + "%')");
            sb.AppendLine(" )AA  WHERE 1=1   ");
            sb.AppendLine(" and  AA.isNode=" + isnode + "");

            sb.AppendLine(" AND	 AA.n>"+ startindex + "  ");
            //if (strwhere != "")
            //    sb.AppendLine( strwhere );

            SqlParameter[] parameters = { };
            DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

            DSToJSON(ds);


        }
        /// <summary>
        /// 采购单明细
        /// </summary>
        /// <param name="strwhere"></param>
        [WebMethod]
        public void GetPurchaseDetail( string pid, string strwhere)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("  SELECT     A.*,'【'+isnull(b.customer,'自己')+'】'+b.address customer,Emp_sg,Emp_sg,Emp_sj,isnull(c.b1,'') b1,cp.c_code FROM  dbo.Purchase_Detail A   ");
            sb.AppendLine("              LEFT JOIN CRM_CUSTOMER b on a.customer_id=b.id   ");
            sb.AppendLine("              LEFT JOIN crm_product cp on cp.product_id=a.material_id   ");
            sb.AppendLine("              LEFT JOIN (SELECT  CustomerID,product_id,MAX(b1) AS b1 FROM  dbo.PurchaseList GROUP BY CustomerID,product_id) c on a.customer_id=c.CustomerID and a.material_id=c.product_id   ");
            sb.AppendLine("  where 1=1  ");
            sb.AppendLine(" and Purid='"+pid+"'");
             
            if (strwhere != "")
                sb.AppendLine(strwhere);

            SqlParameter[] parameters = { };
            DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

            DSToJSON(ds);


        }
        /// <summary>
        /// 采购单审核，确认
        /// </summary>
        /// <param name="status"></param> 
        /// <param name="pid"></param>
        [WebMethod]
        public void UpdatePurchaseStatus(string status,   string pid)
        {
            BLL.Purchase_Main bpm = new BLL.Purchase_Main();
            BLL.Sys_log log = new BLL.Sys_log();
            // ph.UpdateSUM(sum,0,cid,id);
            if (bpm.Updatestatus(pid, status))
            {
                if (StringToDecimal(status) == 3)//当确认的时候，重新计算下                     
                {
                    if (bpm.updatetotal(pid, StringToDecimal(status)) > 0)
                    {
                        log.add_trace(pid, status, "", "app");
                        ReturnStr(true, "\"success\"");
                    }
                    else
                    {
                        ReturnStr(false, "\"faile\"");
                    }
                }
                else
                {
                    ReturnStr(true, "\"success\"");
                }
            }
                
            else ReturnStr(false, "\"faile\"");


        }


        /// <summary>
        /// DATASET 转换为JOSN发送给客户端
        /// </summary>
        /// <param name="ds"></param>
        private void DSToJSON(DataSet ds)
        {

            if (ds == null)
            {
                ReturnStr(true, "[]");
            }
            else
            {
                if (ds.Tables[0].Rows.Count <= 0)
                    ReturnStr(true, "[]");
                else
                {
                    string str = Common.DataToJson.GetJson(ds);
                    ReturnStr(true, str);
                }
            } 
        }

          /// <summary>  
          /// 将中文转化为16进制unicode字符  
          /// 注意不要用汉字的标点符号（全拼的）
          /// </summary>  
          /// <param name="str"></param>  
          /// <returns></returns>  
          public static string StringToUnicodeHex(string str)
          {
              Regex rx = new Regex("[\u4e00-\u9fa5]+");//正则表达式
              Regex rg = new Regex(@"[~!!@#\$%\^&\*\(\)\+=\|\\\}\]\{\[:;<,>\?\/""]+"); 
              string outStr = "";
              if (!string.IsNullOrEmpty(str))
              {
                  for (int i = 0; i < str.Length; i++)
                  {
                      string tempstr = str[i].ToString();
                      if (!rx.IsMatch(tempstr))
                      {

                           outStr += tempstr; 
                      }
                        
                      //将中文字符转为10进制整数，然后转为16进制unicode字符  
                      else outStr += "\\u" + ((int)str[i]).ToString("x");
                  }
              }
              return outStr;
          }  

       /// <summary>
       /// 时间戳
       /// </summary>
       /// <returns></returns>
        public static string GetTimeStamp()
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
            return Convert.ToInt64(ts.TotalSeconds).ToString();
        } 

        /// <summary>
        /// 返回JSON格式
        /// </summary>
        /// <param name="flag"></param>
        /// <param name="data"></param>
         private  void ReturnStr(bool flag,string data)
         {
             string rstr="";
             if (!flag)//StringToUnicodeHex
             {
                 rstr = " {\"meta\":" + data + ",\"data\":null}";
             }
             else
             {
                 rstr = " {\"meta\":null,\"data\":" +  (data) + "}";
             }
               ;

             Context.Response.Charset = "utf-8"; //设置字符集类型  
             Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
             Context.Response.Write(rstr);

             Context.Response.End();
         }
        /// <summary>
        /// 字符串转Unicode
        /// </summary>
        /// <param name="source">源字符串</param>
        /// <returns>Unicode编码后的字符串</returns>
        internal static string String2Unicode(string source)
        {
            var bytes = Encoding.Unicode.GetBytes(source);
            var stringBuilder = new StringBuilder();
            for (var i = 0; i < bytes.Length; i += 2)
            {
                stringBuilder.AppendFormat("\\u{0}{1}", bytes[i + 1].ToString("x").PadLeft(2, '0'), bytes[i].ToString("x").PadLeft(2, '0'));
            }
            return stringBuilder.ToString();
        }

        /// <summary>
        /// Unicode转字符串
        /// </summary>
        /// <param name="source">经过Unicode编码的字符串</param>
        /// <returns>正常字符串</returns>
        internal static string Unicode2String(string source)
        {
            return new Regex(@"\\u([0-9A-F]{4})", RegexOptions.IgnoreCase | RegexOptions.Compiled).Replace(source, x => Convert.ToChar(Convert.ToUInt16(x.Result("$1"), 16)).ToString());
        }

        /// <summary>
        /// 手机推送
        /// </summary>
        /// <param name="lx">发送类型</param>
        private string push(string lx,string ClientWhere,string Title_add,string body_add)
         {
             string SQL = "SELECT * FROM dbo.App_PushSetting  where id="+lx;
             SqlParameter[] parameters = { };
             DataSet ds = DbHelperSQL.Query(SQL, parameters);
             string HOST = ""; string APPKEY = ""; string MASTERSECRET = ""; string APPID = "";
             string iosclient = "";//苹果
             string androidclient = "";//安卓
             string Title = ""; string BODY = "";
             foreach (DataRow dw in ds.Tables[0].Rows)
             {
                 HOST = dw["HOST"].ToString();
                 APPKEY = dw["APPKEY"].ToString();
                 MASTERSECRET = dw["MASTERSECRET"].ToString();
                 APPID = dw["APPID"].ToString();
                 Title = String.Format(dw["NotyTitle"].ToString() , Title_add);
                 BODY = String.Format(dw["NotyText"].ToString(), body_add);
             }
             string sqlclient="SELECT * FROM  dbo.APP_PushClient WHERE 1=1 ";
             if(ClientWhere!="")
                 sqlclient+=ClientWhere;
              DataSet dsclient = DbHelperSQL.Query(sqlclient, parameters);
              PushMessage pm = new PushMessage();
              string iosresult = "";
              foreach (DataRow dw in dsclient.Tables[0].Select(" Versions='ios' OR Versions='ios/phone'"))
              {
               iosclient+=";"+dw["clientid"].ToString();
       
              }
              iosresult = pm.apnPush(HOST, APPKEY, MASTERSECRET, APPID, iosclient, Title, StringTruncat(BODY,50,"..."));
              string android = "";
              foreach (DataRow dw in dsclient.Tables[0].Select(" Versions='android' OR Versions='android/phone'"))
              {
                androidclient+=";"+dw["clientid"].ToString();
             // android+=  pm.PushMessageToSingle(HOST, APPKEY, MASTERSECRET, APPID, dw["clientid"].ToString());
                 }
              android += pm.PushMessageToList(HOST, APPKEY, MASTERSECRET, APPID, androidclient, Title, StringTruncat(BODY, 50, "..."));
           
              return iosresult + "<=>" + android  ;

         }
         /// <summary>
         /// PAD推送
         /// </summary>
         /// <param name="lx">发送类型</param>
         private string pushpad(string lx, string ClientWhere, string Title_add, string body_add)
         {
             string SQL = "SELECT * FROM dbo.App_PushSetting  where id=" + lx;
             SqlParameter[] parameters = { };
             DataSet ds = DbHelperSQL.Query(SQL, parameters);
             string HOST = ""; string APPKEY = ""; string MASTERSECRET = ""; string APPID = "";
             string iosclient = "";//苹果
             string androidclient = "";//安卓
             string Title = ""; string BODY = "";
             foreach (DataRow dw in ds.Tables[0].Rows)
             {
                 HOST = dw["HOST"].ToString();
                 APPKEY = dw["APPKEY"].ToString();
                 MASTERSECRET = dw["MASTERSECRET"].ToString();
                 APPID = dw["APPID"].ToString();
                 Title = String.Format(dw["NotyTitle"].ToString(), Title_add);
                 BODY = String.Format(dw["NotyText"].ToString(), body_add);
             }
             string sqlclient = "SELECT * FROM  dbo.APP_PushClient WHERE 1=1 ";
             if (ClientWhere != "")
                 sqlclient += ClientWhere;
             DataSet dsclient = DbHelperSQL.Query(sqlclient, parameters);
             PushMessage pm = new PushMessage();
           
             string iospad = "";
             foreach (DataRow dw in dsclient.Tables[0].Select(" Versions='ios/pad'"))
             {
                 iosclient += ";" + dw["clientid"].ToString();

             }
             iospad = pm.apnPush(HOST, APPKEY, MASTERSECRET, APPID, iosclient, Title, StringTruncat(BODY, 50, "..."));
             string androidpad = "";
             foreach (DataRow dw in dsclient.Tables[0].Select("   Versions='android/pad'"))
             {
                 androidclient += ";" + dw["clientid"].ToString();

             }
             androidpad = pm.PushMessageToList(HOST, APPKEY, MASTERSECRET, APPID, androidclient, Title, StringTruncat(BODY, 50, "..."));

             return   iospad  + "<=>" + androidpad;

         }


         ///   <summary> 
         ///   将指定字符串按指定长度进行截取并加上指定的后缀
         ///   </summary> 
         ///   <param   name= "oldStr "> 需要截断的字符串 </param> 
         ///   <param   name= "maxLength "> 字符串的最大长度 </param> 
         ///   <param   name= "endWith "> 超过长度的后缀 </param> 
         ///   <returns> 如果超过长度，返回截断后的新字符串加上后缀，否则，返回原字符串 </returns> 
         public static string StringTruncat(string oldStr, int maxLength, string endWith)
         {
             //判断原字符串是否为空
             if (string.IsNullOrEmpty(oldStr))
                 return oldStr + endWith;


             //返回字符串的长度必须大于1
             if (maxLength < 1)
                 return "";


             //判断原字符串是否大于最大长度
             if (oldStr.Length > maxLength)
             {
                 //截取原字符串
                 string strTmp = oldStr.Substring(0, maxLength);


                 //判断后缀是否为空
                 if (string.IsNullOrEmpty(endWith))
                     return strTmp;
                 else
                     return strTmp + endWith;
             }
             return oldStr;
         } 

        /// <summary>
        /// 客户权限
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
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
                             returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or  a.Create_id=" + int.Parse(arr[1]) + ")";
                             break;
                         case "dep":
                             if (string.IsNullOrEmpty(arr[1]))
                                 returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(uid) + " or Emp_id_sg=" + int.Parse(uid) + " or Emp_id_sj=" + int.Parse(uid) + " or  a.Create_id=" + int.Parse(uid) + ")";
                             else
                                 returntxt = " and ( privatecustomer='公客' or Department_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or  a.Create_id=" + int.Parse(uid) + ")";
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

        /// <summary>
        /// 短信模板，金牌服务
        /// </summary>
        /// <param name="url"></param>




    }
}
 
