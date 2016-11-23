using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Text;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using XHD.DBUtility;
using XHD.CRM.webserver;

 
    public partial class push : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (txttitle.Text.Trim() == "" || txtcontent.Text.Trim() == "")
            {
                txtresult.Text = "错误，标题和内容不能为空!!!";
                return;
            }
            if (ckall.Checked) {

                txtresult.Text = pushphone("1", "", txttitle.Text, txtcontent.Text) + pushpad("3", "", txttitle.Text, txtcontent.Text); 
            
            }
            else if (ckpad.Checked)
            {

                txtresult.Text =   pushpad("3", "", txttitle.Text, txtcontent.Text);

            }
            else if (ckphone.Checked)
            {

                txtresult.Text = pushphone("1", "", txttitle.Text, txtcontent.Text);

            }
            else {
                txtresult.Text = "错误，请选一个推送目标，PHONE或PAD!!!";
            }
               
        }

        /// <summary>
        /// 手机推送
        /// </summary>
        /// <param name="lx">发送类型</param>
        private string pushphone(string lx, string ClientWhere, string Title_add, string body_add)
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
            string iosresult = "";
            foreach (DataRow dw in dsclient.Tables[0].Select(" Versions='ios' OR Versions='ios/phone'"))
            {
                iosclient += ";" + dw["clientid"].ToString();

            }
            iosresult = pm.apnPush(HOST, APPKEY, MASTERSECRET, APPID, iosclient, Title, StringTruncat(BODY, 50, "..."));
            string android = "";
            foreach (DataRow dw in dsclient.Tables[0].Select(" Versions='android' OR Versions='android/phone'"))
            {
                androidclient += ";" + dw["clientid"].ToString();

            }
            android = pm.PushMessageToList(HOST, APPKEY, MASTERSECRET, APPID, androidclient, Title, StringTruncat(BODY, 50, "..."));

            return iosresult + "<=>" + android;

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

            return iospad + "<=>" + androidpad;

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

    }
 