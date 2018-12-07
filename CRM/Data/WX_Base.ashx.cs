using System;
using System.Collections.Generic;
using System.Web.Security;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using System.IO;
using XHD.Common;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;

namespace XHD.CRM.Data
{
    /// <summary>
    /// _base 的摘要说明
    /// </summary>
    public class WX_Base : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            BLL.Sys_Menu menu = new BLL.Sys_Menu();

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();

            if (request["Action"] == "grid")
            {

                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

                string IsTop = request["IsTop"];
                string userid = request["userid"];

                string bt = request["bt"];
                //string et = request["et"];
                string keyword1 = request["keyword1"];
                string serchtxt = "  ";string key = "";
                if (!string.IsNullOrEmpty(request["keyword1"]))
                {
                    if (request["keyword1"] != "输入关键词搜索")
                    {
                        key = PageValidate.InputText(request["keyword1"], 255);
                           serchtxt += " and ( a.userid like N'%" + PageValidate.InputText(request["keyword1"], 255) + "%'";
                          serchtxt += " OR username like N'%" + PageValidate.InputText(request["keyword1"], 255) + "%')";
                    }
                }
                if (!string.IsNullOrEmpty(userid))
                {
                    serchtxt += " AND a.userid='" + userid + "'";
                }
                    if (bt == ""||bt==null) bt = DateTime.Today.ToString("yyyy-MM");
                //if (et == "") et = DateTime.Today.ToString("yyyy-MM-dd");
                serchtxt += " and convert(varchar(7),checkin_time,121)='" + bt + "' ";//AND checkin_time<='" + et + "'
                string dt = "";

                DataSet ds = GetWXCheckIn(serchtxt, userid, key);
                if (IsTop == "Y")
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], ds.Tables[0].Rows.Count.ToString());
                else
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[1], ds.Tables[1].Rows.Count.ToString());
                context.Response.Write(dt);
            }
            if (request["Action"] == "sync")
            {
                string btt = request["bt"];
              //  string et = "";
                string bt = "";
                string serchtxt = " where 1=1 ";

                if (btt == "")
                {
                    bt = DateTime.Today.ToString("yyyy-MM")+"-01";
                  //  et = DateTime.Today.AddMonths(1).AddDays(-1);
                }
                else
                {
                    bt = btt + "-01";// et = btt + "-31";
 
                }
              
               // serchtxt += " and checkin_time>='"+ bt + "' AND checkin_time<='" + et + "'";
                WX wx = new WX();
                string token = wx.Getaccess_token("1");
                DataTable lsdt = wx.GetWXUserList("");
                if (lsdt == null) { }
                else
                {
                    string userlist = "";
                    foreach (DataRow dr in lsdt.Rows)
                    {
                        userlist += "\"" + dr["userid"].ToString() + "\",";
                    }
                    userlist = userlist.Substring(0, userlist.Length - 1);


                string data=    wx.PostCheckIn(token, DateTime.Parse(bt), DateTime.Parse(bt).AddMonths(1), userlist);
                    Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(data); //result为上面的Json数据  
                 //   JArray ja = (JArray)jo["checkindata"];
                   // var sb = new System.Text.StringBuilder();
                    if (jo["errmsg"].Value<string>() == "ok")
                        context.Response.Write("true");
                }
            }
          
            if (request["Action"] == "syncuserlist")
            {
                WX wx = new WX();
                string token = wx.Getaccess_token("4");

              

                string data = wx.GetUsers(token, "1");
                Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(data); //result为上面的Json数据  
                                                                                                                     //   JArray ja = (JArray)jo["checkindata"];
                                                                                                                     // var sb = new System.Text.StringBuilder();
                if (jo["errmsg"].Value<string>() == "ok")
                    context.Response.Write("true");
            }
            if (request["Action"] == "griduserlist")
            {

                int PageIndex = int.Parse(request["page"] == null ? "1" : request["page"]);
                int PageSize = int.Parse(request["pagesize"] == null ? "30" : request["pagesize"]);
                string sortname = request["sortname"];
                string sortorder = request["sortorder"];

             
                string userid = request["userid"];

                string bt = request["bt"];
                //string et = request["et"];
                string keyword1 = request["keyword1"];
                string serchtxt = "  "; string key = "";
                if (!string.IsNullOrEmpty(request["keyword1"]))
                {
                    if (request["keyword1"] != "输入关键词搜索")
                    {
                        key = PageValidate.InputText(request["keyword1"], 255);
                        serchtxt += " and ( a.userid like N'%" + PageValidate.InputText(request["keyword1"], 255) + "%'";
                        serchtxt += " OR username like N'%" + PageValidate.InputText(request["keyword1"], 255) + "%')";
                    }
                }
                if (!string.IsNullOrEmpty(userid))
                {
                    serchtxt += " AND a.userid='" + userid + "'";
                }
                   string dt = "";

                DataSet ds = GetWXUserlist(serchtxt, userid, key);
               
                    dt = Common.GetGridJSON.DataTableToJSON1(ds.Tables[0], ds.Tables[0].Rows.Count.ToString());
                   context.Response.Write(dt);
            }
        }
        public List<FileInfo> GetAllFilesInDirectory(string strDirectory)
        {
            List<FileInfo> listFiles = new List<FileInfo>();
            DirectoryInfo directory = new DirectoryInfo(strDirectory);
            DirectoryInfo[] directoryArray = directory.GetDirectories();
            FileInfo[] fileInfoArray = directory.GetFiles();
            if (fileInfoArray.Length > 0) listFiles.AddRange(fileInfoArray);
            foreach (DirectoryInfo _directoryInfo in directoryArray)
            {
                DirectoryInfo directoryA = new DirectoryInfo(_directoryInfo.FullName);
                DirectoryInfo[] directoryArrayA = directoryA.GetDirectories();
                FileInfo[] fileInfoArrayA = directoryA.GetFiles();
                if (fileInfoArrayA.Length > 0) listFiles.AddRange(fileInfoArrayA);
                GetAllFilesInDirectory(_directoryInfo.FullName);//递归遍历  
            }
            return listFiles;
        }
        private DataSet GetWXUserlist(string strwhere, string userid, string key)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("    SELECT CASE gender WHEN	 '1' THEN '男' WHEN '2' THEN '女' ELSE	 gender END	 AS	 sex, ");
            sb.AppendLine("   REPLACE(REPLACE(REPLACE(department, '[', ''), ']', ''), ' ', '') AS depart, ");
            sb.AppendLine(" * FROM dbo.WX_UserList A");
            sb.AppendLine(" LEFT JOIN dbo.hr_employee B ON	 A.mobile=B.tel");
            DataSet ds = DBUtility.DbHelperSQL.Query(sb.ToString());
            if (ds.Tables[0].Rows.Count > 0)
                return ds;
            else return null;
        }
        private DataSet GetWXCheckIn(string strwhere,string userid,string key)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("");
            sb.AppendLine("SELECT a.userid, convert(varchar(7),checkin_time,121) cwny,CONVERT(varchar(100),checkin_time, 23) rq,");
            sb.AppendLine("max(CASE checkin_type WHEN '上班打卡' THEN  CONVERT(varchar(100),checkin_time, 24) ELSE NULL end) sbdk,");
            sb.AppendLine("max(CASE checkin_type WHEN '下班打卡' THEN  CONVERT(varchar(100),checkin_time, 24) ELSE NULL end) xbdk,");
            sb.AppendLine("max(CASE checkin_type WHEN '上班打卡' THEN location_detail ELSE NULL end) sbwz,");
            sb.AppendLine("max(CASE checkin_type WHEN '下班打卡' THEN location_detail ELSE NULL end) xbwz,");
            sb.AppendLine("isnull(max(CASE checkin_type WHEN '上班打卡' THEN exception_type ELSE NULL end),'未打卡') sbzt,");
            sb.AppendLine("isnull(max(CASE checkin_type WHEN '下班打卡' THEN exception_type ELSE NULL end),'未打卡') xbzt,");
            sb.AppendLine("");
            sb.AppendLine("case when");
            sb.AppendLine(" DATENAME(dw,CONVERT(varchar(100),checkin_time, 23))='星期二' then '休息'");
            sb.AppendLine("WHEN");
            sb.AppendLine(" MIN(A.exception_type) = '请假' THEN '请假'");
            sb.AppendLine(" when");
            sb.AppendLine("max(CASE checkin_type WHEN '下班打卡' THEN exception_type ELSE NULL end) in ('','地点异常') and");
            sb.AppendLine("max(CASE checkin_type WHEN '上班打卡' THEN exception_type ELSE NULL end) in ('','地点异常')");
            sb.AppendLine("  then '正常' else '异常' end  zt,DATENAME(dw,CONVERT(varchar(100),checkin_time, 23)) week into #aa");
            sb.AppendLine("FROM WX_CheckIn A");
            sb.AppendLine("inner join wx_userlist b on a.userid=b.userid");
            sb.AppendLine("where exception_type<>'未打卡' ");// and convert(varchar(7),checkin_time,121)='2017-08'");
            if (strwhere != "")
                sb.AppendLine(strwhere);
            sb.AppendLine("GROUP BY a.userid,CONVERT(varchar(100),checkin_time, 23),convert(varchar(7),checkin_time,121)");
            sb.AppendLine("order by a.userid,CONVERT(varchar(100),checkin_time, 23)");
            sb.AppendLine("");
            sb.AppendLine("select a.userid,cwny, username,25 'ycts',isnull(b.ts,0) cqts ,25-isnull (b.ts,0) wcqts from wx_userlist a");
            sb.AppendLine("left join (");
            sb.AppendLine("select userid,COUNT(*) ts,cwny from #aa where zt='正常' group by userid,cwny) b on a.userid=b.userid");
            sb.AppendLine(" where ISNULL(cwny,'')!='' ");
            if (key != "")
                sb.AppendLine("   AND  (a.userid like '%" + key + "%' or username like '%" + key + "%' )");
            sb.AppendLine(""); //考勤明细
            sb.AppendLine("select * from #aa ");
            if (userid != "")
                sb.AppendLine(" where   userid='"+userid+"'");
            sb.AppendLine("drop table #aa");

            DataSet ds = DBUtility.DbHelperSQL.Query(sb.ToString());
            if (ds.Tables[0].Rows.Count > 0)
                return ds;
            else return null;
        }


        private static string GetTasksString(int Id, DataTable table)
        {
            DataRow[] rows = table.Select("parentid=" + Id.ToString());

            if (rows.Length == 0) return string.Empty; ;
            StringBuilder str = new StringBuilder();

            foreach (DataRow row in rows)
            {
                str.Append("{");
                for (int i = 0; i < row.Table.Columns.Count; i++)
                {
                    if (i != 0) str.Append(",");
                    str.Append("\"");
                    str.Append(row.Table.Columns[i].ColumnName);
                    str.Append("\":\"");
                    str.Append(row[i].ToString());
                    str.Append("\"");
                }
                if (GetTasksString((int)row["Menu_id"], table).Length > 0)
                {
                    str.Append(",\"children\":[");
                    str.Append(GetTasksString((int)row["Menu_id"], table));
                    str.Append("]},");
                }
                else
                {
                    str.Append("},");
                }
            }
            return str[str.Length - 1] == ',' ? str.ToString(0, str.Length - 1) : str.ToString();
        }
        private static string GetTreeString(int Id, DataTable table, int todo)
        {
            BLL.hr_post hp = new BLL.hr_post();
            BLL.Sys_online sol = new BLL.Sys_online();
            DataRow[] rows = table.Select(string.Format("parentid={0}", Id));

            if (rows.Length == 0) return string.Empty; ;
            StringBuilder str = new StringBuilder();

            foreach (DataRow row in rows)
            {
                str.Append("{id:" + (int)row["id"] + ",text:'" + (string)row["d_name"] + "',d_icon:'../" + (string)row["d_icon"] + "'");

                if (GetTreeString((int)row["id"], table, 0).Length > 0)
                {
                    str.Append(",children:[");
                    if (todo == 1)
                    {
                        DataSet dsp = hp.GetList("dep_id=" + (int)row["id"]);
                        if (dsp.Tables[0].Rows.Count > 0)
                        {
                            for (int j = 0; j < dsp.Tables[0].Rows.Count; j++)
                            {
                                if (!string.IsNullOrEmpty(dsp.Tables[0].Rows[j]["emp_name"].ToString()))
                                {
                                    DataSet dso = sol.GetList("UserID=" + dsp.Tables[0].Rows[j]["emp_id"]);
                                    string posticon = "images/icon/93.png";
                                    if (dso.Tables[0].Rows.Count > 0)
                                        posticon = "images/icon/38.png";//95

                                    str.Append("{id:'p" + dsp.Tables[0].Rows[j]["post_id"].ToString() + "',text:'" + dsp.Tables[0].Rows[j]["emp_name"] + "',d_icon:'" + posticon + "'}");
                                    str.Append(",");
                                }
                            }
                        }
                    }
                    str.Append(GetTreeString((int)row["id"], table, 1));
                    str.Append("]},");
                }
                else
                {
                    if (todo == 1)
                    {
                        DataSet dsp = hp.GetList("dep_id=" + (int)row["id"]);
                        if (dsp.Tables[0].Rows.Count > 0)
                        {
                            str.Append(",children:[");
                            for (int j = 0; j < dsp.Tables[0].Rows.Count; j++)
                            {
                                if (!string.IsNullOrEmpty(dsp.Tables[0].Rows[j]["emp_name"].ToString()))
                                {
                                    DataSet dso = sol.GetList("UserID=" + dsp.Tables[0].Rows[j]["emp_id"]);
                                    string posticon = "images/icon/93.png";
                                    if (dso.Tables[0].Rows.Count > 0)
                                        posticon = "images/icon/38.png";//95

                                    str.Append("{id:'p" + dsp.Tables[0].Rows[j]["post_id"].ToString() + "',text:'" + dsp.Tables[0].Rows[j]["emp_name"] + "',d_icon:'" + posticon + "'},");
                                    //if (j < dsp.Tables[0].Rows.Count - 1)
                                    //    str.Append(",");
                                }
                            }
                            if (str[str.Length - 1] == ',')
                                str.Remove(str.Length - 1, 1);
                            str.Append("]");
                        }
                    }
                    str.Append("},");
                }
            }
            return str[str.Length - 1] == ',' ? str.ToString(0, str.Length - 1) : str.ToString();
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