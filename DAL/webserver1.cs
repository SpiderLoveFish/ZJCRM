using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using XHD.DBUtility;//Please add references
using System.Data.SqlClient;
using System.Data;

namespace XHD.DAL
{
    public partial class webserver1
    {

        public webserver1()
        { }

     
        //打卡
        public int HR_SignIn(int id, string localstate, string MapPosition)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("INSERT INTO dbo.HR_SignIn_Origin");
            sb.AppendLine("        ( userid ,");
            sb.AppendLine("          DoTime ,");
            sb.AppendLine("          DoPosition ,");
            sb.AppendLine("          MapPosition");
            sb.AppendLine("        )");
            sb.AppendLine("VALUES  ( " + id + " ,"); // userid - int
            sb.AppendLine("         getdate() ,"); // DoTime - datetime
            sb.AppendLine("          '" + localstate + "' ,"); // DoPosition - varchar(200)
            sb.AppendLine("          '" + MapPosition + "'"); // MapPosition - varchar(50)
            sb.AppendLine("        )"); SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
        }

           //获取打卡信息
        public DataSet Get_SignInlist(string id, int topindex)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("select top "+topindex+" *  from dbo.HR_SignIn_Origin");
            sb.AppendLine(" WHERE	DoTime>=CONVERT(VARCHAR(10),GETDATE(),120)");
            sb.AppendLine(" and userid="+id+"");
            sb.AppendLine(" ORDER BY DoTime DESC");
            return DbHelperSQL.Query(sb.ToString());
        }


        public int HR_follow(string cid, string follow, string type,string id)
        {
 
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("INSERT INTO dbo.CRM_Follow");
            sb.AppendLine("        ( Customer_id ,");
            sb.AppendLine("          Follow ,");
            sb.AppendLine("          Follow_date ,");
            sb.AppendLine("          Follow_Type_id ,");
            sb.AppendLine("          employee_id");
            sb.AppendLine("");
            sb.AppendLine("        )");
            sb.AppendLine(" VALUES( "+cid+",");
            sb.AppendLine("   '"+follow+"',getdate(),"+type+","+id+"");
            sb.AppendLine(" )");
           
            sb.AppendLine(" UPDATE A SET	Customer_name=B.Customer,");
            sb.AppendLine(" Follow_Type=C.params_name,employee_name=D.name");
            sb.AppendLine(" FROM dbo.CRM_Follow A");
            sb.AppendLine(" INNER JOIN  dbo.CRM_Customer B ON A.Customer_id=B.id");
            sb.AppendLine(" INNER JOIN (SELECT * FROM  dbo.Param_SysParam WHERE parentid=4)C");
            sb.AppendLine(" ON A.Follow_Type_id=C.id");
            sb.AppendLine(" INNER JOIN dbo.hr_employee D ON A.employee_id=D.ID");
            sb.AppendLine(" WHERE ISNULL(Customer_name,'')='' OR ISNULL(Follow_Type,'')='' OR ISNULL(employee_name,'')=''");
            SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
        }

        public DataSet GetFollow(string cid)
        {
            string sql = " SELECT * FROM dbo.CRM_Follow WHERE Customer_id=" + cid + "";
            
            return DbHelperSQL.Query(sql);
        }
        public DataSet GetCRM_Customer(string cid)
        {
            string sql = " SELECT * FROM dbo.CRM_Customer WHERE id=" + cid + "";

            return DbHelperSQL.Query(sql);
        }


        //获取App用户主要信息
        public DataSet geruser(string token)
        {
            string sql = "  SELECT * FROM dbo.f_user  where token='" + token + "'";
            return DbHelperSQL.Query(sql);
        }

        //创建一个话题
        public int inserttopic(string token,int sid,string title,string content)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("INSERT INTO dbo.f_topic");
            sb.AppendLine("        ( s_id ,");
            sb.AppendLine("          title ,");
            sb.AppendLine("          t_content ,");
            sb.AppendLine("          in_time ,");
            sb.AppendLine("          modify_time ,");
            sb.AppendLine("          last_reply_time ,");
            sb.AppendLine("          last_reply_author_id ,");
            sb.AppendLine("          t_view ,");
            sb.AppendLine("          author_id ,");
            sb.AppendLine("          reposted ,");
            sb.AppendLine("          original_url ,");
            sb.AppendLine("          t_top ,");
            sb.AppendLine("          good ,");
            sb.AppendLine("          show_status ,");
            sb.AppendLine("          reply_count");
            sb.AppendLine("        )");
            sb.AppendLine("VALUES  ( "+sid+" ,"); // s_id - int
            sb.AppendLine("          '"+title+"' ,"); // title - varchar(255)
            sb.AppendLine("          '" + content + "' ,"); // t_content - text
            sb.AppendLine("         getdate() ,"); // in_time - datetime
            sb.AppendLine("           null ,"); // modify_time - datetime
            sb.AppendLine("           null ,"); // last_reply_time - datetime
            sb.AppendLine("          '' ,"); // last_reply_author_id - varchar(32)
            sb.AppendLine("          0 ,"); // view - int
            sb.AppendLine("          '"+token+"' ,"); // author_id - varchar(32)
            sb.AppendLine("          0 ,"); // reposted - int
            sb.AppendLine("          '' ,"); // original_url - varchar(255)
            sb.AppendLine("          0 ,"); // top - int
            sb.AppendLine("          0 ,"); // good - int
            sb.AppendLine("          0 ,"); // show_status - int
            sb.AppendLine("          0"); // reply_count - int
            sb.AppendLine("        )");
            SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
        }
        //修改话题
        public int UpdateTopic(string token,string id,string title,string content)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("UPDATE  dbo.f_topic");
            sb.AppendLine("          title='"+title+"' ,");
            sb.AppendLine("          t_content='"+content+"' ,");
            sb.AppendLine("          modify_time=getdate() ");
            //sb.AppendLine("          t_top ,");
            //sb.AppendLine("          good ,");
            //sb.AppendLine("          show_status");
            sb.AppendLine("");
            sb.AppendLine("     WHERE	author_id='"+token+"' AND ID="+int.Parse(id)+"");
            SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
        }
       
        // 话题置精或者取消
        public int UpdateTopicTop(string token, string id, string status)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("UPDATE  dbo.f_topic");

            sb.AppendLine("          t_top=" + status + "");
            //sb.AppendLine("          good ,");
            //sb.AppendLine("          show_status");
            sb.AppendLine("");
            sb.AppendLine("     WHERE  ID=" + int.Parse(id) + "");
            SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
        }
        // 话题置精或者取消
        public int UpdateTopicGood(string token, string id, string status)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("UPDATE  dbo.f_topic");

            sb.AppendLine("          good=" + status + "");
        
            //sb.AppendLine("          show_status");
            sb.AppendLine("");
            sb.AppendLine("     WHERE  ID=" + int.Parse(id) + "");
            SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
        }

        // 话题删除或恢复
        public int UpdateTopicShow_status(string token, string id, string status)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("UPDATE  dbo.f_topic");

            sb.AppendLine("          show_status=" + status + "");

            //sb.AppendLine("          show_status");
            sb.AppendLine("");
            sb.AppendLine("     WHERE  ID=" + int.Parse(id) + "");
            SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
        }
        // 话题删除或恢复
        public int UpdateTopict_view(string token, string id)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("UPDATE  dbo.f_topic");

            sb.AppendLine("          t_view=t_view+1");

            //sb.AppendLine("          show_status");
            sb.AppendLine("");
            sb.AppendLine("     WHERE  ID=" + int.Parse(id) + "");
            SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
        }
    
         //创建一个回复
        public int insertreply(string token, int tid, string title, string content)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("UPDATE	f_topic");
            sb.AppendLine("SET");
            sb.AppendLine("last_reply_author_id='"+token+"'");
            sb.AppendLine(",last_reply_time=GETDATE()");
            sb.AppendLine(",reply_count=reply_count+1");
            sb.AppendLine(" where id="+tid+"");
            sb.AppendLine("INSERT dbo.f_reply");
            sb.AppendLine("        ( tid ,");
            sb.AppendLine("          t_content ,");
            sb.AppendLine("          in_time ,");
            sb.AppendLine("          author_id ,");
            sb.AppendLine("          best ,");
            sb.AppendLine("          isdelete");
            sb.AppendLine("        )");
            sb.AppendLine("VALUES  ( "+tid+" ,"); // tid -  
            sb.AppendLine("          '"+content+"' ,"); // t_content - text
            sb.AppendLine("          getdate() ,"); // in_time - datetime
            sb.AppendLine("          '"+token+"' ,"); // author_id - varchar(32)
            sb.AppendLine("          0 ,"); // best - int
            sb.AppendLine("          0"); // isdelete - int
            sb.AppendLine("        )");
            SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
        }
        //  删除或恢复
        public int Updatef_reply_delete(string token, string id, string status)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("UPDATE  dbo.f_reply");

            sb.AppendLine("          isdelete=" + status + "");

            //sb.AppendLine("          show_status");
            sb.AppendLine("");
            sb.AppendLine("     WHERE  ID=" + int.Parse(id) + "");
            SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
        }
        //  采纳
        public int Updatef_reply_best(string token, string id, string status)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("UPDATE  dbo.f_reply");

            sb.AppendLine("          best=" + status + "");

            //sb.AppendLine("          show_status");
            sb.AppendLine("");
            sb.AppendLine("     WHERE  ID=" + int.Parse(id) + "");
            SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
        }
        //收藏话题
        public int Insertcollect(string token, string tid)
          {
              var sb = new System.Text.StringBuilder();
              sb.AppendLine("INSERT INTO dbo.f_collect");
              sb.AppendLine("        ( tid, author_id, in_time )");
              sb.AppendLine("VALUES  ( '"+tid+"',"); // tid - varchar(32)
              sb.AppendLine("          '"+token+"',"); // author_id - varchar(32)
              sb.AppendLine("          getdate()"); // in_time - datetime
              sb.AppendLine("          )");
              SqlParameter[] parameters = { };
              return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
          }
        //取消收藏
        public int Deletecollect(string token, string tid)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine(" Delete dbo.f_collect");
         
            sb.AppendLine("where   ( tid='" + tid + "',"); // tid - varchar(32)
            sb.AppendLine("          author_id='" + token + "',"); // author_id - varchar(32)
          
            SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
        }

        //获取页面数据TOPIC
        public DataSet GetDsTopic(int PageIndex, int PageSize, string strWhere, out string Total)
        {
             StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  A.*,B.avatar  FROM dbo.f_topic  A INNER JOIN dbo.f_user B  ON A.author_id=B.token   ");
            strSql.Append(" ");
            strSql.Append(" WHERE A.id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM f_topic ");
            strSql.Append(" where " + strWhere + " order by in_time ) ");
            strSql1.Append(" select count(id) FROM f_topic ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by in_time" );
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet GetDsTopicDetail(string token,string tid, out string collectCount)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine(" UPDATE f_topic SET t_view=t_view+1 WHERE ID="+tid+"");
            sb.AppendLine("SELECT A.*,C.name AS sectionName,B.avatar,B.nickname FROM  dbo.f_topic A");
            sb.AppendLine("INNER JOIN dbo.f_user B ON A.author_id=B.token");
            sb.AppendLine("INNER JOIN dbo.f_section C ON A.s_id=C.id");
            sb.AppendLine(" where A.id="+tid+"");
            string sql = "  SELECT * FROM dbo.f_collect where token='" + token + "'";
            collectCount = DbHelperSQL.Query(sql).Tables[0].Rows[0][0].ToString();
         
            return DbHelperSQL.Query(sb.ToString());
        }

        public DataSet GetDsTopicDetail_replay(string token, string tid)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("SELECT * FROM dbo.f_reply WHERE	 tid=" + tid + "");
           
            return DbHelperSQL.Query(sb.ToString());
        }
    }
}
