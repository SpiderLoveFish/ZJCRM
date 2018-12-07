using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XHD.Common;
using System.Data;
using System.Text;
using System.Xml;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using XHD.DBUtility;
using System.IO;
using System.Net;



namespace XHD.CRM.Data
{
    
    public class WX
    {
        string Tokenurl = "https://qyapi.weixin.qq.com/cgi-bin/";

        public string Getaccess_token(string id)
        {

            string    url = Tokenurl + "gettoken?";
            string ret = ""; string retrunstr = "";
            string sql = "SELECT * FROM wx_config  WHERE ID="+ id;
            DataSet ds = DBUtility.DbHelperSQL.Query(sql);
            if (ds.Tables[0].Rows.Count > 0)
            {
                url += "corpid=" + ds.Tables[0].Rows[0]["corpid"].ToString() + "&corpsecret=" + ds.Tables[0].Rows[0]["Secret"].ToString() + "";

                ret = HttpHelper_GetStr(url, "", "GET", "");
                Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(ret); //result为上面的Json数据  
                                                                                                                    // var jobj = JSON.parse(ret);

                retrunstr = jo["access_token"].ToString();
                if (jo["errcode"].ToString() == "0" && jo["errmsg"].ToString() == "ok")
                {
                    string sqls = "SELECT * FROM wx_config  WHERE ID="+ id + "   and DATEDIFF(SECOND,ISNULL(DoTime,GETDATE()),GETDATE())>=ISNULL(expires_in,0)";

                    DataSet dss = DbHelperSQL.Query(sqls);
                    if (dss.Tables[0].Rows.Count > 0)
                    {
                        string sqlexec = "   update wx_config set token = '" + jo["access_token"].ToString() + "', dotime = GETDATE(),expires_in=" + jo["expires_in"].ToString() + " where id = "+ id + " ";
                        DBUtility.DbHelperSQL.ExecuteSql(sqlexec);
                        DataSet dsss = DbHelperSQL.Query(sql);
                        retrunstr = dsss.Tables[0].Rows[0]["Token"].ToString();
                    }
                }
            }
            return retrunstr;
        }
        /// <summary>
        /// 获取单个应用
        /// </summary>
        /// <param name="agentid"></param>
        /// <param name="token"></param>
        /// <returns></returns>
        public string GetAgen(string agentid,string token)
        {
            string url = Tokenurl + "agent/get?";
            string ret = ""; string retrunstr = "";


            url += "access_token=" + token + "&agentid=" + agentid;

                ret = HttpHelper_GetStr(url, "", "GET", "");

            retrunstr = ret;
            InsertData(ret, "获取单个应用");
            return retrunstr;
        }

        /// <summary>
        /// 获取应用列表
        /// </summary>
        /// <param name="token"></param>
        /// <returns></returns>
        public string GetAgens( string token)
        {
            string url = Tokenurl + "agent/list?";
            string ret = ""; string retrunstr = "";


            url += "access_token=" + token ;

            ret = HttpHelper_GetStr(url, "", "GET", "");

            retrunstr = ret;
            InsertData(ret, "获取应用列表");
            return retrunstr;
        }


        /// <summary>
        /// 获取读取成员
        /// </summary>
        /// <param name="token"></param>
        /// <returns></returns>
        public string GetUser(string token,string userid)
        {
            string url = Tokenurl + "user/get?";
            string ret = ""; string retrunstr = "";


            url += "access_token=" + token+ "&userid="+userid;

            ret = HttpHelper_GetStr(url, "", "GET", "");

            retrunstr = ret;
            InsertData(ret,"获取成员");
            return retrunstr;
        }

        /// <summary>
        /// 获取部门列表
        /// </summary>
        /// <param name="token"></param>
        /// <returns></returns>
        public string GetDepartments(string token, string id)
        {
            string url = Tokenurl + "department/list?";
            string ret = ""; string retrunstr = "";


            url += "access_token=" + token + "&id=" + id;

            ret = HttpHelper_GetStr(url, "", "GET", "");

            retrunstr = ret;
            InsertData(ret, "获取部门列表");
            InsertDepartMent(ret);
            return retrunstr;
        }


        /// <summary>
        /// 获取读取成员(部门)
        /// </summary>
        /// <param name="token"></param>
        /// <returns></returns>
        public string GetUsers(string token, string departmentid)
        {
            string url = Tokenurl + "user/list?";//simplelist
            string ret = ""; string retrunstr = "";


            url += "access_token=" + token + "&department_id=" + departmentid+ "&fetch_child=1";

            ret = HttpHelper_GetStr(url, "", "GET", "");

            retrunstr = ret;
            InsertData(ret, "获取读取成员(部门)");
            InsertUserlist(ret);
            return retrunstr;
        }
        public string PostMessage_textcard(string token,string userlist, string title,  string content,string remarks,string moreurl)
        {
            string url = Tokenurl + "message/send?";
            string ret = ""; string retrunstr = "";//@all  UserID1|UserID2|UserID3
            string postpara = "{\"touser\" :\""+userlist+"\"," +
                " \"toparty\" : \" " + userlist + " \", " +
                " \"totag\" : \" " + userlist + " \",";
            url += "access_token=" + token;
            postpara += "  \"msgtype\" : \"textcard\", " +
                   " \"agentid\" : 8, " +
                   " \"textcard\" : { " +

                     " \"title\":\""+ title + "\", " +
                     "  \"description\":\" <div class='gray'>" + DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") +
                     "</div> <div class='normal'> "+ content +" </div><div class='highlight'>"+ remarks + "</div>\", " +
                     "  \"url\":\""+ moreurl + "\", " +
                       "  \"btntxt\":\"更多\"  " +
                     "  }  }";
            //http://mb.xczs.co/CRM/shareto/WXtest.html?test=1111 
            ret = HttpHelper_GetStr(url, "", "POST", postpara);

            retrunstr = ret;
            return retrunstr;
        }
       public string PostMessage(string token,string type,string para)
        {
            string url = Tokenurl + "message/send?";
            string ret = ""; string retrunstr = "";
            string postpara = "{\"touser\" :\"@all\"," +
                " \"toparty\" : \" @all \", " +
                " \"totag\" : \" @all \",";
               
           

            url += "access_token=" + token;
            if (type == "text")//文本消息
            {
                postpara +=  "  \"msgtype\" : \"text\", " +
                " \"agentid\" : 9, "+
                " \"text\" : { " +
                 "  \"content\" : \"测试API发送:test测试测试\" " +
                 "  }, " +
                 "  \"safe\":0 }";
            }
            else if (type == "image")//图片消息
            {
                postpara += "  \"msgtype\" : \"text\", " +
                " \"agentid\" : 9, " +
                " \"image\" : { " +
                 "  \"content\" : \"测试API发送:test测试测试\" " +
                 "  }, " +
                 "  \"safe\":0 }";
            }
            else if (type == "video")//视频消息
            { }
            else if (type == "file")//文件消息
            { }
            else if (type == "textcard")//文本卡片消息
            {
                postpara += "  \"msgtype\" : \"textcard\", " +
                   " \"agentid\" : 8, " +
                   " \"textcard\" : { " +
                     
                     " \"title\":\"预算生效通知\", " +
                     "  \"description\":\" <div class='gray'>"+DateTime.Now.ToString("yyyy-MM-dd")+"</div> <div class='normal'>您权限里有一张生效预算单，预算编号是：</div><div class='highlight'>YS-001001001,请知悉！</div>\", " +
                     "  \"url\":\"http://mb.xczs.co/CRM/shareto/WXtest.html?test=1111\", " +
                       "  \"btntxt\":\"更多\"  " +
                  
                     "  }  }";
            }
            else if (type == "news")//图文消息
            {
                postpara += "  \"msgtype\" : \"news\", " +
                " \"agentid\" : 9, " + 
                " \"news\" : { " +
                  "  \"articles\" : [{ "+
                  " \"title\":\"test品领取\", " +
                  "  \"description\":\"description\", " +
                  "  \"url\":\"url\", " +
                  "  \"picurl\":\"http://res.mail.qq.com/node/ww/wwopenmng/images/independent/doc/test_pic_msg1.png\", " +
                  "  \"btntxt\":\"picurl\", " +
                  " }]" +
                  "  }, " +
                  "  \"safe\":0 }";
            }
            else if (type == "mpnews")//图文消息（mpnews）
            { }
            ret = HttpHelper_GetStr(url, "", "POST", postpara);

            retrunstr = ret;
            return retrunstr;
        }

        /// <summary>
        /// 打卡
        /// </summary>
        /// <param name="token"></param>
        /// <param name="starttime"></param>
        /// <param name="endtime"></param>
        /// <param name="userlist"></param>
        /// <returns></returns>
        public string PostCheckIn(string token,DateTime starttime, DateTime endtime,string userlist)
        {
            string url = Tokenurl + "checkin/getcheckindata?";
            string ret = ""; string retrunstr = "";
         
            int st = DateTimeToStamp(starttime);
            int et = DateTimeToStamp(endtime);
            string postpara = "{\"opencheckindatatype\" :\"3\"," +
                " \"starttime\" : "+st+", " +
                " \"endtime\" : "+et+"," +
                "   \"useridlist\": [" + userlist + "]," +
                " }";



            url += "access_token=" + token;
             
            ret = HttpHelper_GetStr(url, "", "POST", postpara);

            retrunstr = ret;
            InsertWX_CheckIn(ret, starttime,endtime);
            return retrunstr;
        }

        /// <summary>
        /// 审批
        /// </summary>
        /// <param name="token"></param>
        /// <param name="starttime"></param>
        /// <param name="endtime"></param>
        /// <param name="userlist"></param>
        /// <returns></returns>
        public string PostProval(string token, DateTime starttime, DateTime endtime, string next_spnum)
        {
            string url = Tokenurl + "corp/getapprovaldata?";
            string ret = ""; string retrunstr = "";

            int st = DateTimeToStamp(starttime);
            int et = DateTimeToStamp(endtime);
            string postpara = "{ "+
                " \"starttime\" : " + st + ", " +
                " \"endtime\" : " + et + "," +
                "   \"next_spnum\": ," +
                " }";



            url += "access_token=" + token;

            ret = HttpHelper_GetStr(url, "", "POST", postpara);

            retrunstr = ret;
            InsertData(ret,"审批");
            //InsertWX_CheckIn(ret);
            return retrunstr;
        }

        public string DownLoadFiles(string token,string MEDIA_ID)
        {
            string file = string.Empty;
            string content = string.Empty;
            string strpath = string.Empty;
            string savepath = string.Empty;

            string url = "https://qyapi.weixin.qq.com/cgi-bin/media/get?access_token=" + token + "&media_id=" + MEDIA_ID;
            //string url = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="+token+"&media_id="+ MEDIA_ID;
            HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create(url);

            req.Method = "GET";
            using (WebResponse wr = req.GetResponse())
            {
                HttpWebResponse myResponse = (HttpWebResponse)req.GetResponse();

                strpath = myResponse.ResponseUri.ToString();
                // WriteLog("接收类别://" + myResponse.ContentType);
                System.Net.WebClient mywebclient = new System.Net.WebClient();
               
                string type = myResponse.ContentType;
                if (type == "text")
                {
                    savepath = "C:\\Temp\\WX\\text\\" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + (new Random()).Next().ToString().Substring(0, 4) + ".txt";
                }
                else if (type == "event")
                {
                    savepath = "C:\\Temp\\WX\\event\\" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + (new Random()).Next().ToString().Substring(0, 4) + ".db";
                }
                else if (type == "voice")
                {
                    savepath = "C:\\Temp\\WX\\voice\\" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + (new Random()).Next().ToString().Substring(0, 4) + ".MP4";
                }
                else if (type == "image")
                {
                    savepath = "C:\\Temp\\WX\\image\\" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + (new Random()).Next().ToString().Substring(0, 4) + ".jpg";
                }

                //WriteLog("路径://" + savepath);
                try
                {
                    mywebclient.DownloadFile(strpath, savepath);
                    file = savepath;
                }
                catch (Exception ex)
                {
                    savepath = ex.ToString();
                }

            }
            return file;


            
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="url"></param>
        /// <param name="method">"POST"/"GET"/"PUT "</param>
        /// <param name="postdatastr"></param>
        /// <returns></returns>
        private string HttpHelper_GetStr(string url, string headers, string method, string postdatastr)
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
                ContentType = "application/json",//返回类型    可选项有默认值
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
            item.Header.Add("sc_api", headers);//设置请求头信息（Header） 
            HttpResult result = http.GetHtml(item);
            string html = result.Html;
            return html;
        }

        private void InsertData(string data,string function)
        {
            string sql = "insert into WX_GetData(GetData,GetTime,GetFunction) values('" + data+"',getdate(),'"+function+"')";
            DbHelperSQL.ExecuteSql(sql);
        }

        private void InsertDepartMent(string data )
        {
            Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(data); //result为上面的Json数据  
            JArray ja = (JArray)jo["department"];
            var sb = new System.Text.StringBuilder();
            if (jo["errmsg"].Value<string>() == "ok")
            {
                sb.AppendLine("delete dbo.WX_DepartMent");
                foreach (var ja1 in ja)
                {
                    JObject o = (JObject)ja1;

                    sb.AppendLine("INSERT  INTO dbo.WX_DepartMent");
                    sb.AppendLine("        ( id, name, parentid, orderby )");
                    sb.AppendLine("VALUES  ( " + o["id"].Value<string>() + ","); // id - int
                    sb.AppendLine("          '" + o["name"].Value<string>() + "',"); // name - varchar(50)
                    sb.AppendLine("         " + o["parentid"].Value<string>() + ","); // parentid - int
                    sb.AppendLine("          " + o["order"].Value<string>() + ""); // orderby - int
                    sb.AppendLine("          )");
                    sb.AppendLine("");
                }
            }
            DbHelperSQL.ExecuteSql(sb.ToString());
        }

        private void InsertUserlist(string data)
        {
            Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(data); //result为上面的Json数据  
            JArray ja = (JArray)jo["userlist"];
            var sb = new System.Text.StringBuilder();
            if (jo["errmsg"].Value<string>() == "ok")
            {
                sb.AppendLine("delete dbo.WX_UserList");
                foreach (var ja1 in ja)
                {
                    JObject o = (JObject)ja1;

                    sb.AppendLine("INSERT INTO dbo.WX_UserList");
                    sb.AppendLine("        ( userid ,");
                    sb.AppendLine("          username ,");
                    sb.AppendLine("          department ,");
                    sb.AppendLine("          position ,");
                    sb.AppendLine("          mobile ,");
                    sb.AppendLine("          gender ,");
                    sb.AppendLine("          email ,");
                    sb.AppendLine("          isleader ,");
                    sb.AppendLine("          avatar ,");
                    sb.AppendLine("          telephone ,");
                    sb.AppendLine("          english_name ,");
                    sb.AppendLine("          status ,");
                    sb.AppendLine("          extattr");
                    sb.AppendLine("        )");
                    sb.AppendLine("VALUES  ( '"+ o["userid"].Value<string>() + "' ,"); // userid - varchar(50)
                    sb.AppendLine("          '" + o["name"].Value<string>() + "' ,"); // username - varchar(50)
                    sb.AppendLine("          '" + o["department"].ToString() + "' ,"); // department - varchar(50)
                    sb.AppendLine("          '" + o["position"].Value<string>() + "' ,"); // position - varchar(50)
                    sb.AppendLine("          '" + o["mobile"].Value<string>() + "' ,"); // mobile - varchar(20)
                    sb.AppendLine("          '" + o["gender"].Value<string>() + "' ,"); // gender - char(1)
                    sb.AppendLine("          '" + o["email"].Value<string>() + "' ,"); // email - varchar(50)
                    sb.AppendLine("          '" + o["isleader"].Value<string>() + "' ,"); // isleader - char(1)
                    sb.AppendLine("          '" + o["avatar"].Value<string>() + "' ,"); // avatar - varchar(200)
                    sb.AppendLine("          '" + o["telephone"].Value<string>() + "' ,"); // telephone - varchar(20)
                    sb.AppendLine("          '" + o["english_name"].Value<string>() + "' ,"); // english_name - varchar(20)
                    sb.AppendLine("          '" + o["status"].Value<string>() + "' ,"); // status - char(1)
                    sb.AppendLine("          '" + o["extattr"].ToString() + "'"); // extattr - varchar(200)
                    sb.AppendLine("        )");
                    sb.AppendLine("");
                }
            }
            DbHelperSQL.ExecuteSql(sb.ToString());
        }

        private void InsertWX_CheckIn(string data,DateTime dt,DateTime et)
        {
            Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(data); //result为上面的Json数据  
            JArray ja = (JArray)jo["checkindata"];
            var sb = new System.Text.StringBuilder();
            if (jo["errmsg"].Value<string>() == "ok")
            {
                sb.AppendLine("delete dbo.WX_CheckIn where checkin_time>='"+dt+ "' and checkin_time<='"+et+"'");
                foreach (var ja1 in ja)
                {
                    JObject o = (JObject)ja1;
                    sb.AppendLine("INSERT INTO dbo.WX_CheckIn");
                    sb.AppendLine("        ( userid ,");
                    sb.AppendLine("          groupname ,");
                    sb.AppendLine("          checkin_type ,");
                    sb.AppendLine("          exception_type ,");
                    sb.AppendLine("          checkin_time ,");
                    sb.AppendLine("          location_title ,");
                    sb.AppendLine("          location_detail ,");
                    sb.AppendLine("          wifiname ,");
                    sb.AppendLine("          notes ,");
                    sb.AppendLine("          wifimac ,");
                    sb.AppendLine("          mediaids,RecTime");
                    sb.AppendLine("        )");
                    sb.AppendLine("VALUES  ( '" + o["userid"].ToString() + "' ,"); // userid - varchar(50)
                    sb.AppendLine("          '" + o["groupname"].ToString() + "' ,"); // groupname - varchar(50)
                    sb.AppendLine("          '" + o["checkin_type"].ToString() + "' ,"); // checkin_type - varchar(20)
                    sb.AppendLine("          '" + o["exception_type"].ToString() + "' ,"); // exception_type - varchar(20)
                    if(o["checkin_time"].ToString()!="")
                        sb.AppendLine("          '" + StampToDateTime(o["checkin_time"].ToString()) + "' ,"); // checkin_time - datetime
                    else
                    sb.AppendLine("          '" + o["checkin_time"].ToString() + "' ,"); // checkin_time - datetime
                    sb.AppendLine("          '" + o["location_title"].ToString() + "' ,"); // location_title - varchar(20)
                    sb.AppendLine("          '" + o["location_detail"].ToString() + "' ,"); // location_detail - varchar(50)
                    sb.AppendLine("          '" + o["wifiname"].ToString() + "' ,"); // wifiname - varchar(20)
                    sb.AppendLine("          '" + o["notes"].ToString() + "' ,"); // notes - varchar(50)
                    sb.AppendLine("          '" + o["wifimac"].ToString() + "' ,"); // wifimac - varchar(20)
                    sb.AppendLine("          '" + o["mediaids"].ToString() + "',getdate()"); // mediaids - varchar(200)
                    sb.AppendLine("        )");
                    sb.AppendLine("");
                }
            }
            string a = sb.ToString();
            DbHelperSQL.ExecuteSql(a);
        }

        public void InsertWX_Proval(string data)
        {
            Newtonsoft.Json.Linq.JObject jo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(data); //result为上面的Json数据  
            JArray ja = (JArray)jo["data"];
            var sb = new System.Text.StringBuilder();
            if (jo["errmsg"].Value<string>() == "ok")
            {
                sb.AppendLine(" DELETE dbo.WX_Proval WHERE sp_num<='"+ jo["next_spnum"].ToString() + "'");
                sb.AppendLine(" DELETE dbo.WX_Proval_Detail WHERE sp_num<='" + jo["next_spnum"].ToString() + "'");

                foreach (var ja1 in ja)
                {
                    JObject o = (JObject)ja1;
                    sb.AppendLine("   ");
                    sb.AppendLine(" INSERT INTO dbo.WX_Proval  ");
                    sb.AppendLine("         ( sp_num ,  ");
                    sb.AppendLine("           spname ,  ");
                    sb.AppendLine("           apply_name ,  ");
                    sb.AppendLine("           apply_org ,  ");
                    sb.AppendLine("           approval_name ,  ");
                    sb.AppendLine("           notify_name ,  ");
                    sb.AppendLine("           sp_status ,  ");
                    sb.AppendLine("           mediaids ,  ");
                    sb.AppendLine("           apply_time ,  ");
                    sb.AppendLine("           apply_user_id ,  ");
                    sb.AppendLine("           expense ,  ");
                    sb.AppendLine("           comm  ");
                    sb.AppendLine("         )  ");
                    sb.AppendLine(" VALUES  ( '" + o["sp_num"].ToString() + "' , -- sp_num - varchar(20)  ");
                    sb.AppendLine("           '" + o["spname"].ToString() + "' , -- spname - varchar(20)  ");
                    sb.AppendLine("           '" + o["apply_name"].ToString() + "' , -- apply_name - varchar(20)  ");
                    sb.AppendLine("           '" + o["apply_org"].ToString() + "' , -- apply_org - varchar(20)  ");
                    sb.AppendLine("           '" + o["approval_name"].ToString() + "' , -- approval_name - varchar(50)  ");
                    sb.AppendLine("           '" + o["notify_name"].ToString() + "' , -- notify_name - varchar(50)  ");
                    sb.AppendLine("           '" + o["sp_status"].ToString() + "' , -- sp_status - varchar(5)  ");
                    sb.AppendLine("           '" + o["mediaids"].ToString() + "' , -- mediaids - varchar(max)  ");
                    sb.AppendLine("           '" + o["apply_time"].ToString() + "' , -- apply_time - varchar(20)  ");
                    sb.AppendLine("           '" + o["apply_user_id"].ToString() + "' , -- apply_user_id - varchar(20)  ");
                    sb.AppendLine("           '' , -- expense - varchar(max)  ");
                    sb.AppendLine("           '" + o["comm"].ToString() + "'  -- comm - varchar(max)  ");
                    sb.AppendLine("         )  ");
                    sb.AppendLine("   ");
                    string aa = ((Newtonsoft.Json.Linq.JValue)o["comm"]["apply_data"]).Value.ToString();
                    Newtonsoft.Json.Linq.JObject joo = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(aa); //result为上面的Json数据  

                    foreach (var ja4 in joo)
                    {
                        sb.AppendLine(" INSERT INTO dbo.WX_Proval_Detail  ");
                        sb.AppendLine("         ( sp_num ,  ");
                        sb.AppendLine("           item ,  ");
                        sb.AppendLine("           title ,  ");
                        sb.AppendLine("           type ,  ");
                        sb.AppendLine("           configvalue ,  ");
                        sb.AppendLine("           validate ,  ");
                        sb.AppendLine("           un_print ,  ");
                        sb.AppendLine("           value ,  ");
                        sb.AppendLine("           placeholder ,  ");
                        sb.AppendLine("           [index] ,  ");
                        sb.AppendLine("           setvalue ,  ");
                        sb.AppendLine("           warning  ");
                        sb.AppendLine("         )  ");
                        sb.AppendLine("  VALUES  ( '" + o["sp_num"].ToString() + "' , -- sp_num - varchar(20)  ");
                        sb.AppendLine("            '" + ja4.Key.ToString() + "' , -- item - varchar(50)  ");
                        sb.AppendLine("            '" + ja4.Value["title"].ToString() + "' , -- title - varchar(50)  ");
                        sb.AppendLine("            '" + ja4.Value["type"].ToString() + "' , -- type - varchar(20)  ");
                        try
                        {
                            sb.AppendLine("            '" + ja4.Value["configvalue"].ToString() + "' , -- configvalue - varchar(200)  ");
                        }
                        catch
                        {
                            sb.AppendLine("            '' , -- configvalue - varchar(200)  ");
                        }
                        try//validate
                        {
                            sb.AppendLine("            '" + ja4.Value["validate"].ToString() + "' , -- configvalue - varchar(200)  ");
                        }
                        catch
                        {
                            sb.AppendLine("            '' , -- configvalue - varchar(200)  ");
                        }
                        try//un_print
                        {
                            sb.AppendLine("            '" + ja4.Value["un_print"].ToString() + "' , -- configvalue - varchar(200)  ");
                        }
                        catch
                        {
                            sb.AppendLine("            '' , -- configvalue - varchar(200)  ");
                        }
                        try//value
                        {
                            sb.AppendLine("            '" + ja4.Value["value"].ToString() + "' , -- configvalue - varchar(200)  ");
                        }
                        catch
                        {
                            sb.AppendLine("            '' , -- configvalue - varchar(200)  ");
                        }
                        //sb.AppendLine("            '" + ja4.Value["validate"].ToString() + "' , -- validate - varchar(50)  ");
                        //sb.AppendLine("            '" + ja4.Value["un_print"].ToString() + "' , -- un_print - varchar(50)  ");
                        //sb.AppendLine("            '" + ja4.Value["value"].ToString() + "',  -- value - varchar(max)  ");
                        try//placeholder
                        {
                            sb.AppendLine("            '" + ja4.Value["placeholder"].ToString() + "' , -- configvalue - varchar(200)  ");
                        }
                        catch
                        {
                            sb.AppendLine("            '' , -- configvalue - varchar(200)  ");
                        }
                        try//index
                        {
                            sb.AppendLine("            '" + ja4.Value["index"].ToString() + "' , -- configvalue - varchar(200)  ");
                        }
                        catch
                        {
                            sb.AppendLine("            '' , -- configvalue - varchar(200)  ");
                        }
                        try//setvalue
                        {
                            sb.AppendLine("            '" + ja4.Value["setvalue"].ToString() + "' , -- configvalue - varchar(200)  ");
                        }
                        catch
                        {
                            sb.AppendLine("            '' , -- configvalue - varchar(200)  ");
                        }
                        try//warning
                        {
                            sb.AppendLine("            '" + ja4.Value["warning"].ToString() + "'    ");
                        }
                        catch
                        {
                            sb.AppendLine("            ''  -- configvalue - varchar(200)  ");
                        }
                        
                        //sb.AppendLine("           '' , -- placeholder - varchar(50)  ");
                        //sb.AppendLine("           '' , -- index - varchar(10)  ");
                        //sb.AppendLine("           '' , -- setvalue - varchar(50)  ");
                        //sb.AppendLine("           ''  -- warning - varchar(50)  ");
                        sb.AppendLine("          )  ");  
                    }
                    }
            }

            string a = sb.ToString();
            DbHelperSQL.ExecuteSql(a);
        }

        public DataTable GetWXUserList(string strwhere)
        {
            string sql = "SELECT * FROM dbo.WX_UserList  ";
            if (strwhere != "")
                sql += strwhere;

            DataSet ds = DBUtility.DbHelperSQL.Query(sql);
            if (ds.Tables[0].Rows.Count > 0)
                return ds.Tables[0];
            else return null;
        }

        // DateTime时间格式转换为Unix时间戳格式
        private int DateTimeToStamp(System.DateTime time)
        {
            System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1));
            return (int)(time - startTime).TotalSeconds;
        }
        /// <summary>
        /// 将时间戳转换为日期类型，并格式化
        /// </summary>
        /// <param name="longDateTime"></param>
        /// <returns></returns>
        private static string LongDateTimeToDateTimeString(string longDateTime)
        {
            //用来格式化long类型时间的,声明的变量
            long unixDate;
            DateTime start;
            DateTime date;
            //ENd

            unixDate = long.Parse(longDateTime);
            start = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
            date = start.AddMilliseconds(unixDate).ToLocalTime();

            return date.ToString("yyyy-MM-dd HH:mm:ss");

        }

        // 时间戳转为C#格式时间
        private DateTime StampToDateTime(string timeStamp)
        {
            DateTime dateTimeStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
            long lTime = long.Parse(timeStamp + "0000000");
            TimeSpan toNow = new TimeSpan(lTime);

            return dateTimeStart.Add(toNow);
        }
        
    }

   
}