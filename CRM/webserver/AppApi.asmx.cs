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
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
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
            sb.AppendLine("hr_employee WHERE ISNULL(isDelete,0)='' AND uid='" + user + "' AND pwd='" + password + "' AND ISNULL(token,'')=''");
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
            sb.AppendLine("d_id AS CorpId,ISNULL(level,0) AS level FROM dbo.hr_employee");
            sb.AppendLine(" where ISNULL(isDelete,0)='' AND  uid='" + user + "' AND pwd='" + password + "' ");
            DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
          
             if (ds == null)
             {
                 ReturnStr(false, "账号密码错误，或者账号不存在，或者账号已经停用！");
             }
                else
             {
                 if(ds.Tables[0].Rows.Count<=0)
                     ReturnStr(false, "账号密码错误，或者账号不存在，或者账号已经停用！");
                 else
                 {
                     log.Add_log(0, pwd, ClientId, "手机端登录", "手机端登录", 0, "手机端登录", password, "");
               
                     string str = Common.DataToJson.GetJson(ds);
                     ReturnStr(true, str);
                 }
            }
             
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
          /// 个人信息
          /// </summary>
          /// <returns></returns>
          [WebMethod]
          public void GetUserClientId(string url, string token)
          {
               SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();

              sb.AppendLine("SELECT  uid,name,tel,dname,zhiwu,email,Address, ");
              sb.AppendLine(" CASE WHEN ISNULL(title,'')='' THEN '" + url + "'+'images/icons/function_icon_set/user_48.png'");
              sb.AppendLine("ELSE '" + url + "'+'images/upload/portrait/'+title  END AS Avatar ");
              sb.AppendLine("  FROM hr_employee WHERE ISNULL(isDelete,0)='' AND token='" + token + "' ");
                        DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

              if (ds == null)
              {
                  ReturnStr(false, "账号停用！");
              }
              else
              {
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(false, "账号停用！");
                  else
                  {
                      string str = Common.DataToJson.GetJson(ds);
                      ReturnStr(true, str);
                      }
              }

          }
            /// <summary>
          /// 个人信息
          /// </summary>
          /// <returns></returns>
          [WebMethod]
          public void GetAppVersion(string ver)
          {
               SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              sb.AppendLine("SELECT * FROM dbo.App_Version WHERE	Ver!='" + ver + "'");
              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
              if (ds == null)
              {
                  ReturnStr(true, " \"no\"");
              }
              else
              {
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(true," \"no\"");
                  else
                  {
                      //string str = Common.DataToJson.GetJson(ds);
                      ReturnStr(true, "\""+ds.Tables[0].Rows[0][1].ToString()+"\"");
                  }
              }
          }


        
       /// <summary>
       /// 客户类型
       /// </summary>
          [WebMethod]
          public void GetCustomerType(string url)
          {
               SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();


              sb.AppendLine(" SELECT DISTINCT CustomerType_id as cid ,isnull(CustomerType,'未知') as CustomerType");
              sb.AppendLine(", CASE WHEN ISNULL(CustomerType_id,'')='' THEN '" + url + "'+'images/Icon/96.png'");
              sb.AppendLine(" ELSE '" + url + "'+'images/Icon/'+ CONVERT(VARCHAR(5),CustomerType_id) +'.png'  END AS Avatar ");
              sb.AppendLine("    FROM  CRM_Customer WHERE ISNULL(isDelete,0)=''");
              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);

              if (ds == null)
              {
                  ReturnStr(false, "无类型！");
              }
              else
              {
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(false, "无类型！");
                  else
                  {
                      string str = Common.DataToJson.GetJson(ds);
                      ReturnStr(true, str);
                     }
              }

          }

          /// <summary>
          /// 客户List
          /// </summary>
          [WebMethod]
          public void GetCustomerList(string keyword, string ID, string url, string topnumber, string searchkey)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();

              string serchtxt = "";
              sb.AppendLine(" SELECT TOP " + topnumber + " id, Serialnumber,Customer,address,tel,CustomerType,Community,DesCripe,Remarks ");
              sb.AppendLine(",UPPER(dbo.chinese_firstletter(ltrim(Customer))) as header");
              sb.AppendLine(", CASE WHEN ISNULL(CustomerType_id,'')='' THEN '" + url + "'+'images/Icon/96.png'");
              sb.AppendLine("ELSE '" + url + "'+'images/Icon/'+ CONVERT(VARCHAR(5),CustomerType_id) +'.png'  END AS Avatar ");
             sb.AppendLine(" FROM dbo.CRM_Customer");
             sb.AppendLine(" where ISNULL(isDelete,0)='' ");
             if (!string.IsNullOrEmpty(keyword))
             {
                // serchtxt += string.Format(" and ( Customer like N'%{0}%' or tel  like N'%{0}%' or Community like N'%{0}%' or address like N'%{0}%' or DesCripe like N'%{0}%' or Remarks like N'%{0}%' ) ", keyword);
                 serchtxt += " AND CustomerType_id="+keyword;
             }
             if (!string.IsNullOrEmpty(searchkey))
             {
                 serchtxt += string.Format(" and ( Customer like N'%{0}%' or tel  like N'%{0}%' or Community like N'%{0}%' or address like N'%{0}%' or DesCripe like N'%{0}%' or Remarks like N'%{0}%' ) ", searchkey);

             }
             //加入权限控制
             serchtxt += DataAuth(ID);
             string ordertxt = " ORDER BY Create_date DESC ";
             string strsql = " SELECT * FROM ( "+sb.ToString() + serchtxt + ordertxt +")AA ORDER BY header";
             DataSet ds = DbHelperSQL.Query(strsql, parameters);

              if (ds == null)
              {
                  ReturnStr(false, "无数据！");
              }
              else
              {
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(false, "无数据！");
                  else
                  {
                      string str = Common.DataToJson.GetJson(ds);
                      ReturnStr(true, str);
                  }
              }

          }

          /// <summary>
          /// 客户List
          /// </summary>
          [WebMethod]
          public void GetCustomerList_Page(string keyword,string typeid, string ID, string url,string index)
          {
              SqlParameter[] parameters = { };
              int startindex= int.Parse(index)*20;
              int perindex =(int.Parse(index)-1)*20;
              string sql = " SELECT TOP " + startindex + "  " +
                            " id, Serialnumber,Customer,address,tel,CustomerType,Community,DesCripe,Remarks " +
                            //"--,UPPER(dbo.chinese_firstletter(ltrim(Customer))) as header" +
                            " , CASE WHEN ISNULL(CustomerType_id,'')='' THEN '"+url+"'+'images/Icon/96.png'" +
                            " ELSE '" + url + "'+'images/Icon/'+ CONVERT(VARCHAR(5),CustomerType_id) +'.png'  END AS Avatar " +
                            "  FROM" +
                            " CRM_Customer " +
                            " WHERE (" +
                            " id>(SELECT ISNULL(MAX(id),0) FROM (SELECT TOP " + perindex + " id FROM" +
                            " CRM_Customer ORDER BY id)AS T" +
                            " )" +
                            " )  " ;

              string serchtxt = "";
              if (!string.IsNullOrEmpty(keyword))
              {
                  serchtxt += string.Format(" AND ( Customer like N'%{0}%' or tel  like N'%{0}%' or Community like N'%{0}%' or address like N'%{0}%' or DesCripe like N'%{0}%' or Remarks like N'%{0}%' ) ", keyword);
                  //serchtxt += " WHERE CustomerType_id=" + keyword;
              }
              if (!string.IsNullOrEmpty(typeid))
              {
                  //serchtxt += string.Format(" and ( Customer like N'%{0}%' or tel  like N'%{0}%' or Community like N'%{0}%' or address like N'%{0}%' or DesCripe like N'%{0}%' or Remarks like N'%{0}%' ) ", keyword);
                  serchtxt += " AND CustomerType_id=" + typeid;
              }
              
              //加入权限控制
              serchtxt += DataAuth(ID);
              string ordertxt = "ORDER BY id";
                  //" ORDER BY dbo.chinese_firstletter(ltrim(Customer))";
              DataSet ds = DbHelperSQL.Query(sql + serchtxt + ordertxt, parameters);

              if (ds == null)
              {
                  ReturnStr(false, "无数据！");
              }
              else
              {
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(false, "无数据！");
                  else
                  {
                      string str = Common.DataToJson.GetJson(ds);
                      ReturnStr(true, str);
                  }
              }

          }
         

          /// <summary>
          /// 客户明细
          /// </summary>
          [WebMethod]
          public void GetCustomerDetail(string id)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();

              string serchtxt = "";
              sb.AppendLine(" SELECT id, Serialnumber,Customer,address,tel,Create_name,CustomerType,Emp_sj AS sjs,Employee AS ywy,Emp_sg AS sgjl ");
              sb.AppendLine(" FROM dbo.CRM_Customer");
              sb.AppendLine(" where ISNULL(isDelete,0)='' AND id=" + id + "");
               

              DataSet ds = DbHelperSQL.Query(sb.ToString() + serchtxt, parameters);

              if (ds == null)
              {
                  ReturnStr(false, "无数据！");
              }
              else
              {
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(false, "无数据！");
                  else
                  {
                      string str = Common.DataToJson.GetJson(ds);
                      ReturnStr(true, str);
                  }
              }

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
              sb.AppendLine("SELECT top " + perindex + " CONVERT(VARCHAR(16),Follow_date,120) AS Follow_date,A.id,Customer_id,Customer_name,Follow,employee_name,Follow_Type,Follow_Type  ");
               sb.AppendLine(" ,CASE WHEN ISNULL(title,'')='' THEN '" + url + "'+'images/icons/function_icon_set/user_48.png'");
               sb.AppendLine("ELSE '" + url + "'+'images/upload/portrait/'+title  END AS Avatar ");
               sb.AppendLine(" ,(SELECT COUNT(1) FROM CRM_Follow where Customer_id=" + id + ") AS TotalCount");
             sb.AppendLine("FROM dbo.CRM_Follow A ");
              sb.AppendLine("INNER JOIN dbo.hr_employee B ON A.employee_id=B.ID ");

              sb.AppendLine(" where ISNULL(A.isDelete,0)='' AND A.Customer_id=" + id + "");
              sb.AppendLine(" AND  (");
                            sb.AppendLine("A.id>(SELECT ISNULL(MAX(id),0) FROM (SELECT TOP " + perindex + " id FROM");
                            sb.AppendLine(" CRM_Follow ORDER BY id)AS T");
                            sb.AppendLine(" )");
                          sb.AppendLine(")  ");
              sb.AppendLine(" ORDER BY Follow_date desc");

              DataSet ds = DbHelperSQL.Query(sb.ToString() + serchtxt, parameters);

              if (ds == null)
              {
                  ReturnStr(false, "\"无数据！\"");
              }
              else
              {
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(false, "\"无数据！\"");
                  else
                  {
                      string str = Common.DataToJson.GetJson(ds);
                      ReturnStr(true, str);
                  }
              }

          }

          [WebMethod]
          public void GetMessage(string SelectType, string startIndex, string endIndex)
          {
              SqlParameter[] parameters = { };
              
              var sb = new System.Text.StringBuilder();
              //滚动(新闻)
                sb.AppendLine("SELECT top 5 id AS ID,news_title AS Title,'activity' AS ListType ");
                sb.AppendLine(" , img AS IsHostPic,CONVERT(varchar(16),news_time, 120)  AS ReleaseTime");
                sb.AppendLine(" FROM dbo.public_news   ");
                sb.AppendLine(" ");
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
              string GGstr = "[]";
              //调查问卷
              string DCstr = "[]";
              //活动报名
              string HDstr = "[]";
              retstr += "," + SPstr + "," + GGstr + "," + DCstr + "," + HDstr+"]";
              ReturnStr(true,retstr);
          }

          [WebMethod]
          public void GetApp_Conifg()
          {
              SqlParameter[] parameters = { };

              var sb = new System.Text.StringBuilder();
             
              sb.AppendLine("SELECT   * FROM  dbo.App_Conifg   ");
              
              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
              if (ds.Tables[0].Rows.Count <= 0)
                  ReturnStr(false, "\"无数据！\"");
              else
              {
                  string str = Common.DataToJson.GetJson(ds);
                  ReturnStr(true, str);
              }

 
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
              sb.AppendLine("  FROM hr_employee WHERE ISNULL(isDelete,0)='' ");
              sb.AppendLine(" ORDER BY UPPER(dbo.chinese_firstletter(ltrim(name)))");
              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);
 
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(false, "[]");
                  else
                  {
                      string str = Common.DataToJson.GetJson(ds);
                      ReturnStr(true, str);
                  }
              

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
             if (!flag)
             {
                 rstr= " {\"meta\":"+data+",\"data\":null}";
             }
             else
             {
                 rstr = " {\"meta\":null,\"data\":" + data + "}";
             }
               ;

             Context.Response.Charset = "utf-8"; //设置字符集类型  
             Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
             Context.Response.Write(rstr);

             Context.Response.End();
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
                             returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or  Create_id=" + int.Parse(arr[1]) + ")";
                             break;
                         case "dep":
                             if (string.IsNullOrEmpty(arr[1]))
                                 returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(uid) + " or Emp_id_sg=" + int.Parse(uid) + " or Emp_id_sj=" + int.Parse(uid) + " or  Create_id=" + int.Parse(uid) + ")";
                             else
                                 returntxt = " and ( privatecustomer='公客' or Department_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or  Create_id=" + int.Parse(uid) + ")";
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


    }
}
