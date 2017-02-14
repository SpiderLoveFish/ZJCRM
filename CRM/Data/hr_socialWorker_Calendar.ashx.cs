using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using XHD.Common;
using System.Web.Security;

namespace XHD.CRM.Data
{
    /// <summary>
    /// hr_socialWorker_Calendar 的摘要说明
    /// </summary>
    public class hr_socialWorker_Calendar : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;

            //BLL.Personal_Calendar calendar = new BLL.Personal_Calendar();
            BLL.hr_socialWorker_Follow calendar = new BLL.hr_socialWorker_Follow();
            //Model.Personal_Calendar model = new Model.Personal_Calendar();
            Model.hr_socialWorker_Follow model = new Model.hr_socialWorker_Follow();

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            string CoockiesID = ticket.UserData;

            BLL.hr_employee emp = new BLL.hr_employee();
            int emp_id = int.Parse(CoockiesID);
            DataSet dsemp = emp.GetList("id=" + emp_id);
            string empname = dsemp.Tables[0].Rows[0]["name"].ToString();
            string uid = dsemp.Tables[0].Rows[0]["uid"].ToString();

            if (request["Action"] == "get")
            {
                int socialWorkerId = int.Parse(request["socialWorkerId"]);

                CalendarViewType viewType = (CalendarViewType)Enum.Parse(typeof(CalendarViewType), request["viewtype"]);
                string strshowday = request["showdate"];
                int clientzone = Convert.ToInt32(request["timezone"]);
                int serverzone = GetTimeZone();

                var zonediff = serverzone - clientzone;

                var format = new CalendarViewFormat(viewType, DateTime.Parse(strshowday), DayOfWeek.Monday);

                DataSet ds = calendar.GetList("Customer_id=" + socialWorkerId + " and StartTime>='" + format.StartDate.ToString("yyyy-MM-dd HH:mm:ss") + "' and EndTime<='" + format.EndDate.ToString("yyyy-MM-dd HH:mm:ss") + "'");
                //DataSet ds = calendar.GetList(" StartTime>='" + format.StartDate.ToString("yyyy-MM-dd HH:mm:ss") + "' and EndTime<='" + format.EndDate.ToString("yyyy-MM-dd HH:mm:ss") + "'");
                string dt = DataToJSON(ds);

                var data = new JsonSocialWorkerCalendarViewData(calendar.DataTableToList(ds.Tables[0]), format.StartDate, format.EndDate);
                context.Response.Write("{\"start\":\"\\/Date(" + MilliTimeStamp(format.StartDate) + ")\\/\",\"end\":\"\\/Date(" + MilliTimeStamp(format.EndDate) + ")\\/\",\"error\":null,\"issort\":true,\"events\":[" + dt + "]}");
                //context.Response.Write(dt);
            }

            //if (request["Action"] == "quickadd")
            //{
            //    int clientzone = Convert.ToInt32(request["timezone"]);
            //    int serverzone = GetTimeZone();
            //    var zonediff = serverzone - clientzone;

            //    model.Subject = PageValidate.InputText(request["CalendarTitle"], 4000);
            //    model.StartTime = DateTime.Parse(request["CalendarStartTime"]).AddHours(zonediff);
            //    model.EndTime = DateTime.Parse(request["CalendarEndTime"]).AddHours(zonediff);
            //    model.IsAllDayEvent = PageValidate.InputText(request["IsAllDayEvent"], 255) == "1" ? true : false;

            //    model.CalendarType = 1;
            //    model.InstanceType = 0;

            //    model.UPAccount = emp_id.ToString();
            //    model.UPTime = DateTime.Now;
            //    model.MasterId = clientzone;

            //    model.emp_id = emp_id;
            //    model.Category = emp_id.ToString();

            //    int n = calendar.Add(model);

            //    context.Response.Write("{\"IsSuccess\":true,\"Msg\":\"\u64cd\u4f5c\u6210\u529f!\",\"Data\":\"" + n + "\"}");
            //}
            //if (request["Action"] == "quickupdate")
            //{
            //    string Id = request["calendarId"];

            //    int clientzone = Convert.ToInt32(request["timezone"]);
            //    int serverzone = GetTimeZone();
            //    var zonediff = serverzone - clientzone;

            //    model.StartTime = DateTime.Parse(request["CalendarStartTime"]).AddHours(zonediff);
            //    model.EndTime = DateTime.Parse(request["CalendarEndTime"]).AddHours(zonediff);

            //    model.UPAccount = emp_id.ToString();
            //    model.UPTime = DateTime.Now;
            //    model.MasterId = clientzone;

            //    model.Id = int.Parse(Id);

            //    calendar.quickUpdate(model);

            //    context.Response.Write("{IsSuccess:true}");
            //}
            //if (request["Action"] == "quickdel")
            //{
            //    int id = Convert.ToInt32(request["calendarId"]);
            //    calendar.Delete(id);

            //    context.Response.Write("{IsSuccess:true}");
            //}
            if (request["Action"] == "form")
            {
                int id = Convert.ToInt32(request["calendarid"]);
                DataSet ds = calendar.GetList("Id=" + id);
                string dt = Common.DataToJson.DataToJSON(ds);
                context.Response.Write(dt);
            }
            //if (request["Action"] == "save")
            //{
            //    string Id = request["calendarid"];

            //    int clientzone = 8;
            //    int serverzone = GetTimeZone();
            //    var zonediff = serverzone - clientzone;

            //    model.StartTime = DateTime.Parse(request["T_starttime"]).AddHours(zonediff);
            //    model.EndTime = DateTime.Parse(request["T_endtime"]).AddHours(zonediff);

            //    model.Subject = Common.PageValidate.InputText(request["T_content"], 4000);

            //    model.emp_id = emp_id;
            //    model.UPAccount = emp_id.ToString();
            //    model.UPTime = DateTime.Now;
            //    model.MasterId = clientzone;
            //    model.CalendarType = 1;
            //    model.InstanceType = 0;
            //    model.IsAllDayEvent = PageValidate.InputText(request["allday"], 255) == "True" ? true : false;

            //    model.Id = int.Parse(Id);

            //    calendar.Update(model);

            //    context.Response.Write("{IsSuccess:true}");
            //}
            if (request["Action"] == "Today")
            {
                string starttime = (DateTime.Now.ToString("yyyy-MM-dd") + " 00:00:00");
                DateTime endtime = DateTime.Parse(DateTime.Now.AddDays(1).ToString("yyyy-MM-dd") + " 00:00:00");

                //DataSet ds = calendar.GetList(0, "datediff(day,[StartTime],getdate())=0 and datediff(day,[EndTime],getdate())=0 and emp_id=" + int.Parse(emp_id), "[StartTime] desc");
                //'" + DateTime.Now.ToShortDateString() + " 23:59:50' >= [StartTime] and 
                DataSet ds = calendar.GetList(7, "'" + starttime + "' <= [EndTime] and emp_id=" + emp_id, "[StartTime] ");
                context.Response.Write(GetGridJSON.DataTableToJSON(ds.Tables[0]));
            }
        }

        private static string DataToJSON(DataSet ds)
        {
            StringBuilder JsonString = new StringBuilder();
            DataTable dt = ds.Tables[0];
            if (dt != null && dt.Rows.Count > 0)
            {
                string Follow_Type = "";//其他人员日程类型
                string strColorTheme = ""; //颜色主题
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Follow_Type = dt.Rows[i]["Follow_Type"].ToString(); //日程类型

                    JsonString.Append("[");
                    JsonString.Append("\"" + (dt.Rows[i]["Id"].ToString()) + "\","); //主键
                    JsonString.Append("\"" + System.Web.HttpUtility.UrlEncode("【" + Follow_Type + "】" + (dt.Rows[i]["Subject"].ToString())) + "\","); //标题
                    JsonString.Append("\"\\/Date(" + MilliTimeStamp(DateTime.Parse(dt.Rows[i]["StartTime"].ToString())) + ")\\/\","); //开始时间
                    JsonString.Append("\"\\/Date(" + MilliTimeStamp(DateTime.Parse(dt.Rows[i]["EndTime"].ToString())) + ")\\/\","); //结束时间
                    JsonString.Append("1,"); //是否全天日程
                    JsonString.Append("" + (dt.Rows[i]["StartTime"].ToString() == dt.Rows[i]["StartTime"].ToString() ? 0 : 1) + ","); //是否跨天日程
                    JsonString.Append("0,"); //是否循环日程
                  
                    if (Follow_Type=="有空")
                        strColorTheme = "1";
                    else if (Follow_Type == "已安排本公司")
                        strColorTheme = "2";
                    else if (Follow_Type == "已安排其他公司")
                        strColorTheme = "3";
                    else if (Follow_Type == "休息不接单")
                        strColorTheme = "4";

                    JsonString.Append("" + strColorTheme + ","); //颜色主题
                    JsonString.Append("3,"); //是否有权限
                    JsonString.Append("1,\"" + dt.Rows[i]["Customer_name"] + "\",\"\""); //地点，参与人

                    if (i == dt.Rows.Count - 1)
                    {
                        JsonString.Append("]");
                    }
                    else
                    {
                        JsonString.Append("],");
                    }
                }
                return JsonString.ToString();
            }
            else
            {
                return null;
            }
        }
        private static int GetTimeZone()
        {
            DateTime now = DateTime.Now;
            var utcnow = now.ToUniversalTime();

            var sp = now - utcnow;

            return sp.Hours;
        }
        private static long MilliTimeStamp(DateTime theDate)
        {
            DateTime d1 = new DateTime(1970, 1, 1);
            DateTime d2 = theDate.ToUniversalTime();
            TimeSpan ts = new TimeSpan(d2.Ticks - d1.Ticks);
            return (long)ts.TotalMilliseconds;
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