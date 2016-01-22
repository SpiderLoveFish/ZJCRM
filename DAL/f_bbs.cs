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

       
    }
}
