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

            //sb.AppendLine("SELECT   * FROM");
            //sb.AppendLine("hr_employee WHERE ISNULL(isDelete,0)='0' AND uid='" + user + "' AND pwd='" + password + "' AND ISNULL(token,'')=''");
            //bool isexist = DbHelperSQL.Exists(sb.ToString(), null);
            //if (isexist)
            //{
            //    string token = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(
            //                 GetTimeStamp() + user
            //                 , "MD5").ToLower();
            //    sb.Clear();
            //    sb.AppendLine(" Update hr_employee");
            //    sb.AppendLine(" set token='" + token + "'");
            //    sb.AppendLine(" where  uid='" + user + "' AND pwd='" + password + "' AND ISNULL(token,'')=''");
            //    DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
            //}
           
            sb.Clear();
            sb.AppendLine("SELECT ID,token, token AS UserId,name AS UserName,'"+ClientId+"' as ClientId,");
            sb.AppendLine("CASE WHEN ISNULL(title,'')='' THEN '" + url + "'+'images/icons/function_icon_set/user_48.png'");
            sb.AppendLine("ELSE '" + url + "'+'images/upload/portrait/'+title  END AS Avatar,");
            sb.AppendLine("d_id AS CorpId,ISNULL(level,0) AS level FROM dbo.hr_employee");
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
                 //    log.Add_log(0, pwd, ClientId, "手机端登录", "手机端登录", 0, "手机端登录", password, "");
                 //    sb.Clear();
                 //    sb.AppendLine("IF	NOT	EXISTS(SELECT	1	FROM	dbo.APP_PushClient	WHERE	clientid=''	AND	Versions=''	AND	userid='') ");
                 //    sb.AppendLine("INSERT	INTO	dbo.APP_PushClient ");
                 //    sb.AppendLine("        ( Versions, clientid, userid ) ");
                 //    sb.AppendLine("VALUES  ( '" + version + "', -- Versions - varchar(10) ");
                 //    sb.AppendLine("          '" + ClientId + "', -- clientid - varchar(50) ");
                 //    sb.AppendLine("          '" + user + "'  -- userid - varchar(20) ");
                 //    sb.AppendLine("          ) ");
                 //    sb.AppendLine(" ");
                 //       DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
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
              sb.AppendLine("  FROM hr_employee WHERE ISNULL(isDelete,0)='0' AND token='" + token + "' ");
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
              sb.AppendLine("SELECT * FROM dbo.App_Version WHERE	Ver!='" + ver + "'  and IsLast='Y'");
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


        
       /// <summary>
       /// 客户类型
       /// </summary>
          [WebMethod]
          public void GetCustomerType(string url)
          {
               SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              sb.AppendLine(" SELECT  ");
              sb.AppendLine("   DISTINCT id as cid ,isnull(params_name,'未知') as CustomerType");
              sb.AppendLine(", CASE WHEN ISNULL(icon,'')='' THEN '" + url + "'+'images/Icon/96.png'");
              sb.AppendLine(" ELSE '" + url + "'+icon  END AS Avatar ");
              sb.AppendLine("   FROM dbo.Param_SysParam WHERE parentid=1");
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

             if (!string.IsNullOrEmpty(keyword))
             {
                 if (keyword == "fav")//收藏客户
                     sb.AppendLine("  LEFT JOIN Crm_Customer_Favorite B on B.customer_id=A.id and userid=" + ID);

             } sb.AppendLine(" where ISNULL(isDelete,0)='0' ");
             if (!string.IsNullOrEmpty(keyword))
             {
                // serchtxt += string.Format(" and ( Customer like N'%{0}%' or tel  like N'%{0}%' or Community like N'%{0}%' or address like N'%{0}%' or DesCripe like N'%{0}%' or Remarks like N'%{0}%' ) ", keyword);
             
                 if (keyword == "fav")//收藏客户
                     serchtxt += " AND B.customer_id is not null ";
                 else serchtxt += " AND CustomerType_id=" + keyword;
             }
             if (!string.IsNullOrEmpty(searchkey))
             {
                 serchtxt += string.Format(" and ( Customer like N'%{0}%' or tel  like N'%{0}%' or Community like N'%{0}%' or address like N'%{0}%' or DesCripe like N'%{0}%' or Remarks like N'%{0}%' ) ", searchkey);

             }
             //加入权限控制
             serchtxt += DataAuth(ID);
             string ordertxt = " ORDER BY a.Create_date DESC ";
             string strsql = " SELECT * FROM ( "+sb.ToString() + serchtxt + ordertxt +")AA ORDER BY header";
             DataSet ds = DbHelperSQL.Query(strsql, parameters);

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
          public void GetCustomerDetail(string id,string userid)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();

              string serchtxt = "";
              sb.AppendLine(" SELECT A.id, Serialnumber,Customer,address,tel,Create_name,CustomerType,Emp_sj AS sjs,Employee AS ywy,Emp_sg AS sgjl ");
              sb.AppendLine(" ,Case when B.customer_id is null then 0 else 1 end as isstart");
              sb.AppendLine(" FROM dbo.CRM_Customer A");
              sb.AppendLine(" LEFT JOIN Crm_Customer_Favorite B on B.customer_id=A.id AND userid="+userid);
              sb.AppendLine(" where ISNULL(isDelete,0)='0' AND a.id=" + id + "");
               

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

              if (ds == null)
              {
                  ReturnStr(false, "[]");
              }
              else
              {
                  if (ds.Tables[0].Rows.Count <= 0)
                      ReturnStr(false, "[]");
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
              sb.AppendLine("  FROM hr_employee WHERE ISNULL(isDelete,0)='0' ");
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
              //ReturnStr(false, Server.MapPath("..\\webserver\\zs.p12" )); 
              //return;
             //ApplePushService apush =new ApplePushService();
             //if (!apush.Push("3143C16EF2220D8110C6E5958AAB7490FD3905E88A1D56894C"))
             //     ReturnStr(false, "\"faile\"");
             // else
             // {

             //     ReturnStr(true, "\"success\"");
             // }
          

                  ReturnStr(true, StringToUnicodeHex("f你好!http://baidu.com?abc=123"));

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
                  sb.AppendLine("SELECT TOP	" + perindex + " * FROM dbo.v_Jifen_Kh");
                  sb.AppendLine("WHERE id >");
                  sb.AppendLine("          (");
                  sb.AppendLine("          SELECT ISNULL(MAX(id),0)");
                  sb.AppendLine("          FROM");
                  sb.AppendLine("                (");
                  sb.AppendLine("                SELECT TOP " + startindex + " id FROM v_Jifen_Kh where 1=1 " + serchtxt + " ORDER BY id");
                  sb.AppendLine("                ) A");
                  sb.AppendLine("          )");
                  sb.AppendLine(" " + serchtxt + "");
                  sb.AppendLine(" ORDER BY  ID");
              }
              else
              {
                  sb.AppendLine("SELECT TOP	" + perindex + " * FROM dbo.v_Jifen_Yg");
                  sb.AppendLine("WHERE id >");
                  sb.AppendLine("          (");
                  sb.AppendLine("          SELECT ISNULL(MAX(id),0)");
                  sb.AppendLine("          FROM");
                  sb.AppendLine("                (");
                  sb.AppendLine("                SELECT TOP " + startindex + " id FROM v_Jifen_Yg  where 1=1 " + serchtxt + "  ORDER BY id");
                  sb.AppendLine("                ) A");
                  sb.AppendLine("          )");
                  sb.AppendLine(" " + serchtxt + "");
                  sb.AppendLine(" ORDER BY  ID");
              }

              DataSet ds = DbHelperSQL.Query(sb.ToString() , parameters);

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
              DataSet ds = DbHelperSQL.Query(sb.ToString(), parameters);



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
          /// 客户收藏
          /// </summary>
          [WebMethod]
          public void UpdateScore(string sfadd, string sfkh, string id,string score,string content,string uid)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              string jlx = "0";
              if (sfadd == "Y") jlx = "0"; else jlx = "1";
              sb.AppendLine("INSERT INTO dbo.CRM_Jifen (ID,Jflx,Jf,Sfkh,Content,IsDel,InEmpID,InDate) ");
              sb.AppendLine("VALUES  ('" + id + "', ");
              sb.AppendLine("         '" + jlx + "', ");
              sb.AppendLine("         '" + score + "', ");
              sb.AppendLine("         'Y', ");
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
          public void GetBudge(string strWhere,string uid)
          {
              SqlParameter[] parameters = { };
              var sb = new System.Text.StringBuilder();
              sb.AppendLine("SELECT  B.* ,");
              sb.AppendLine("        ISNULL(b_zje, 0) AS zje ,");
              sb.AppendLine("        C.b_sj ,");
              sb.AppendLine("        C.b_sl ,");
              sb.AppendLine("        B.FJAmount AS fjfy ,");
              sb.AppendLine("        A.id AS CustomerID ,");
              sb.AppendLine("        ISNULL(C.b_zkzje, 0) zkzje ,");
              sb.AppendLine("        a.tel ,");
              sb.AppendLine("        a.Customer AS CustomerName ,");
              sb.AppendLine("        a.Emp_sg AS sgjl ,");
              sb.AppendLine("        a.address ,");
              sb.AppendLine("        cc.tel AS sjstel ,");
              sb.AppendLine("        a.gender ,");
              sb.AppendLine("        a.Emp_sj AS sjs ,");
              sb.AppendLine("        a.Employee AS ywy");
              sb.AppendLine("FROM    dbo.Budge_BasicMain B");
              sb.AppendLine("        LEFT JOIN dbo.CRM_Customer a ON B.customer_id = A.id");
              sb.AppendLine("        LEFT JOIN dbo.Budge_tax C ON B.id = C.budge_id");
              sb.AppendLine("        LEFT JOIN dbo.hr_employee CC ON a.emp_id_sj = CC.[ID]");
              sb.AppendLine("        LEFT JOIN ( SELECT  SUM(rate) AS rate ,");
              sb.AppendLine("                            budge_id");
              sb.AppendLine("                    FROM    dbo.Budge_Rate_Ver");
              sb.AppendLine("                    GROUP BY budge_id");
              sb.AppendLine("                  ) D ON B.id = D.budge_id");
              sb.AppendLine("WHERE   1 = 1  ");
              if (strWhere.Trim() != "")
              {
                  sb.AppendLine(" AND " + strWhere);
              }
              string  serchtxt  = DataAuth(uid);
              DataSet ds = DbHelperSQL.Query(sb.ToString() + serchtxt, parameters);

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
              string hj = "[]"; string detail = "[]";
              BLL.Budge_BasicMain bbb = new BLL.Budge_BasicMain();
              BLL.Budge_BasicDetail bbdetail = new BLL.Budge_BasicDetail();
              if (bid != "")
              {
                  DataSet ds = bbb.GetPrintCount(bid);
                  hj = Common.GetGridJSON.DataTableToJSON2(ds.Tables[0]);
                  string Total = ""; string serchtxt = "1=1";
                  serchtxt += " and   budge_id ='" + bid + "'";
                
                  string sorttext = "   ISNULL(OrderBy,0), ComponentName   desc";
                  DataSet dsd = bbdetail.GetBudge_BasicDetail(9999, 1, serchtxt, sorttext, out Total);
                  detail = Common.GetGridJSON.DataTableToJSON2(dsd.Tables[0]);
              }




              string str = "{\"jhdata\":" + hj + ",\"detaildata\":" + detail + "}";
                      ReturnStr(true, str);
                  
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



       


    }
}
 
