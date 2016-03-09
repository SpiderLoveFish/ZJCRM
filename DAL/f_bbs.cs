using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using XHD.DBUtility;//Please add references
using System.Data.SqlClient;
using System.Data;

namespace XHD.DAL
{
    public partial class f_bbs
    {
      
        public f_bbs()
        { }

        public DataSet Getf_section()
        {
            var strSql = new StringBuilder();
            strSql.Append("select   *  from dbo.f_section WHERE show_status=1 ORDER BY display_index  ");
          
            return DbHelperSQL.Query(strSql.ToString());
        }
        //获取未读消息的数量
        public int getunreadcount(string taken)
        {

            var sb = new StringBuilder();
            sb.Append(" select n.id as not_read_count from notification n where n.read = 0 and n.author_id ='" + taken+"'");
            return DbHelperSQL.Query(sb.ToString()).Tables[0].Rows.Count;
        }
        //获取未读消息 
        public DataSet getunread(string taken)
        {

            string sql = "";
                  sql+= "select n.*, t.title, u.nickname from notification n " +
                "left join topic t on n.tid = t.id " +
                "left join user u on u.id = n.from_author_id " +
                "where n.read = 0 and n.author_id = '"+taken+"' order by n.in_time desc";
            return DbHelperSQL.Query(sql);
        }
         //获取已读消息 
        public DataSet getread(string taken,int pageseze)
        {

            string sql = "";
                  sql+= " select top "+pageseze+" n.*, t.title, u.nickname from notification n " +
                "left join topic t on n.tid = t.id " +
                "left join user u on u.id = n.from_author_id " +
                "where n.read = 1 and n.author_id = '"+taken+"' order by n.in_time desc ";
 
            return DbHelperSQL.Query(sql);
        }
        //将未读消息设置成已读
        public int UpdateRead(string taken)
		{
            var sb = new StringBuilder();
            sb.Append(" update notification n set n.read = 1 where n.author_id ='" + taken + "'");
            SqlParameter[] parameters = { };
           return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
            
        }
        //获取注册用户信息
        public DataSet gerPCuser(string uid, string pwd)
        {
            string sql = "SELECT * FROM dbo.hr_employee WHERE	 uid='" + uid + "' AND pwd='" + pwd + "'";
            return DbHelperSQL.Query(sql);
        }
        //新增APP用户
        public int Insertuser(int id,string token)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine(" Update hr_employee");
            sb.AppendLine(" set token='"+token+"'");
            sb.AppendLine(" where id=" + id + "");
            sb.AppendLine(" INSERT INTO dbo.f_user");
            sb.AppendLine("        ( id ,");
            sb.AppendLine("          nickname ,score , token ,avatar , mission ,");
            sb.AppendLine("		  in_time ,email , f_password , url");
            sb.AppendLine("        )");
            sb.AppendLine(" SELECT 'xczs'+uid , name ,");
            sb.AppendLine("          0 , '"+token+"' , 'images/logo/'+title , GETDATE() , GETDATE() ,");
            sb.AppendLine("          email ,'' ,'' FROM dbo.hr_employee WHERE	 ID="+id+"");
            SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
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
            sb.AppendLine(" where    tid='" + tid + "' "); // tid - varchar(32)
            sb.AppendLine("        AND  author_id='" + token + "' "); // author_id - varchar(32)
          
            SqlParameter[] parameters = { };
            return DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
        }

        //获取页面数据TOPIC
        public DataSet GetDsTopic(int PageIndex, int PageSize, string strWhere, out string Total)
        {
             StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  A.*,B.avatar,C.name as sectionName   FROM dbo.f_topic  A INNER JOIN dbo.f_user B  ON A.author_id=B.token   ");
            strSql.Append(" inner join f_section C on A.s_id=C.id");
            strSql.Append(" ");
            strSql.Append(" WHERE A.id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM f_topic ");
            strSql.Append(" where " + strWhere + " order by t_top DESC , in_time DESC   ) ");
            strSql1.Append(" select count(id) FROM f_topic ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by t_top DESC , in_time DESC ");
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
            string sql = "  SELECT count(*) FROM dbo.f_collect where author_id='" + token + "'";
            collectCount = DbHelperSQL.Query(sql).Tables[0].Rows[0][0].ToString();
         
            return DbHelperSQL.Query(sb.ToString());
        }

        public DataSet GetDsTopicDetail_replay(string token, string tid)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("SELECT * FROM dbo.f_reply A INNER JOIN f_user B ON	A.author_id=B.token where A.tid=" + tid + "");
           
            return DbHelperSQL.Query(sb.ToString());
        }
        public DataSet GetDsTopicDetail_replay_last(string token, string tid)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("SELECT top 1 * FROM dbo.f_reply A INNER JOIN f_user B ON	A.author_id=B.token where A.tid=" + tid + "");
            sb.AppendLine(" ORDER BY	 A.in_time desc ");
            return DbHelperSQL.Query(sb.ToString());
        }
    
    
    }
}
