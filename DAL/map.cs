using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using XHD.DBUtility;//Please add references
using System.Data.SqlClient;
using System.Data;

namespace XHD.DAL
{
    public partial class map
    {
        public map()
        { }

        public DataSet GetMapList(string strWhere)
        {
            var strSql = new StringBuilder();
            strSql.Append("SELECT ");
            strSql.Append("     [id],[Customer],[address],[tel],[xy],[Department_id],[Employee_id]      ");
            strSql.Append("FROM [dbo].[CRM_Customer] ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }
        public DataSet GetGYSMapList(string strWhere)
        {
            var strSql = new StringBuilder();
            strSql.Append("SELECT ");
            strSql.Append("     [id],[Name],[address],[Gsdh],[xy]      ");
            strSql.Append("FROM [dbo].[CgGl_Gys_Main] ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet GetBMapList(string strWhere)
        {
            var strSql = new StringBuilder();
            strSql.Append("SELECT ");
            strSql.Append("     [id],[name],[sl],[xy]     ");
            strSql.Append("FROM [dbo].[V_building] ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }
    }
}
