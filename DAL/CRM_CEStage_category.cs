using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
    /// <summary>
    /// 数据访问类:CRM_CEStage_category
    /// </summary>
    public partial class CRM_CEStage_category
    {
        public CRM_CEStage_category()
        { }
        #region  BasicMethod

        /// <summary>
        /// 得到最大ID
        /// </summary>
        public int GetMaxId()
        {
            return DbHelperSQL.GetMaxID("id", "CRM_CEStage_category");
        }

        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from CRM_CEStage_category");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
            parameters[0].Value = id;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(XHD.Model.CRM_CEStage_category model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into CRM_CEStage_category(");
            strSql.Append("CEStage_category,parentid,CEStage_icon,isDelete,Delete_id,Delete_time,TotalScorce)");
            strSql.Append(" values (");
            strSql.Append("@CEStage_category,@parentid,@CEStage_icon,@isDelete,@Delete_id,@Delete_time,@TotalScorce)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
					new SqlParameter("@CEStage_category", SqlDbType.VarChar,250),
					new SqlParameter("@parentid", SqlDbType.Int,4),
					new SqlParameter("@CEStage_icon", SqlDbType.VarChar,250),
					new SqlParameter("@isDelete", SqlDbType.Int,4),
					new SqlParameter("@Delete_id", SqlDbType.Int,4),
					new SqlParameter("@Delete_time", SqlDbType.DateTime),
					new SqlParameter("@TotalScorce", SqlDbType.Decimal,9)};
            parameters[0].Value = model.CEStage_category;
            parameters[1].Value = model.parentid;
            parameters[2].Value = model.CEStage_icon;
            parameters[3].Value = model.isDelete;
            parameters[4].Value = model.Delete_id;
            parameters[5].Value = model.Delete_time;
            parameters[6].Value = model.TotalScorce;

            object obj = DbHelperSQL.GetSingle(strSql.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(XHD.Model.CRM_CEStage_category model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update CRM_CEStage_category set ");
            strSql.Append("CEStage_category=@CEStage_category,");
            strSql.Append("parentid=@parentid,");
            strSql.Append("CEStage_icon=@CEStage_icon,");
            strSql.Append("isDelete=@isDelete,");
            strSql.Append("Delete_id=@Delete_id,");
            strSql.Append("Delete_time=@Delete_time,");
            strSql.Append("TotalScorce=@TotalScorce");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@CEStage_category", SqlDbType.VarChar,250),
					new SqlParameter("@parentid", SqlDbType.Int,4),
					new SqlParameter("@CEStage_icon", SqlDbType.VarChar,250),
					new SqlParameter("@isDelete", SqlDbType.Int,4),
					new SqlParameter("@Delete_id", SqlDbType.Int,4),
					new SqlParameter("@Delete_time", SqlDbType.DateTime),
					new SqlParameter("@TotalScorce", SqlDbType.Decimal,9),
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = model.CEStage_category;
            parameters[1].Value = model.parentid;
            parameters[2].Value = model.CEStage_icon;
            parameters[3].Value = model.isDelete;
            parameters[4].Value = model.Delete_id;
            parameters[5].Value = model.Delete_time;
            parameters[6].Value = model.TotalScorce;
            parameters[7].Value = model.id;

            int rows = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from CRM_CEStage_category ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
            parameters[0].Value = id;

            int rows = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /// <summary>
        /// 批量删除数据
        /// </summary>
        public bool DeleteList(string idlist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from CRM_CEStage_category ");
            strSql.Append(" where id in (" + idlist + ")  ");
            int rows = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }


        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public XHD.Model.CRM_CEStage_category GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 id,CEStage_category,parentid,CEStage_icon,isDelete,Delete_id,Delete_time,TotalScorce from CRM_CEStage_category ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
            parameters[0].Value = id;

            XHD.Model.CRM_CEStage_category model = new XHD.Model.CRM_CEStage_category();
            DataSet ds = DbHelperSQL.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                return DataRowToModel(ds.Tables[0].Rows[0]);
            }
            else
            {
                return null;
            }
        }


        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public XHD.Model.CRM_CEStage_category DataRowToModel(DataRow row)
        {
            XHD.Model.CRM_CEStage_category model = new XHD.Model.CRM_CEStage_category();
            if (row != null)
            {
                if (row["id"] != null && row["id"].ToString() != "")
                {
                    model.id = int.Parse(row["id"].ToString());
                }
                if (row["CEStage_category"] != null)
                {
                    model.CEStage_category = row["CEStage_category"].ToString();
                }
                if (row["parentid"] != null && row["parentid"].ToString() != "")
                {
                    model.parentid = int.Parse(row["parentid"].ToString());
                }
                if (row["CEStage_icon"] != null)
                {
                    model.CEStage_icon = row["CEStage_icon"].ToString();
                }
                if (row["isDelete"] != null && row["isDelete"].ToString() != "")
                {
                    model.isDelete = int.Parse(row["isDelete"].ToString());
                }
                if (row["Delete_id"] != null && row["Delete_id"].ToString() != "")
                {
                    model.Delete_id = int.Parse(row["Delete_id"].ToString());
                }
                if (row["Delete_time"] != null && row["Delete_time"].ToString() != "")
                {
                    model.Delete_time = DateTime.Parse(row["Delete_time"].ToString());
                }
                if (row["TotalScorce"] != null && row["TotalScorce"].ToString() != "")
                {
                    model.TotalScorce = decimal.Parse(row["TotalScorce"].ToString());
                }
            }
            return model;
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select id,CEStage_category,parentid,CEStage_icon,isDelete,Delete_id,Delete_time,TotalScorce ");
            strSql.Append(" FROM CRM_CEStage_category ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得前几行数据
        /// </summary>
        public DataSet GetList(int Top, string strWhere, string filedOrder)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (Top > 0)
            {
                strSql.Append(" top " + Top.ToString());
            }
            strSql.Append(" id,CEStage_category,parentid,CEStage_icon,isDelete,Delete_id,Delete_time,TotalScorce ");
            strSql.Append(" FROM CRM_CEStage_category ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获取记录总数
        /// </summary>
        public int GetRecordCount(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) FROM CRM_CEStage_category ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            object obj = DbHelperSQL.GetSingle(strSql.ToString());
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetListByPage(string strWhere, string orderby, int startIndex, int endIndex)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("SELECT * FROM ( ");
            strSql.Append(" SELECT ROW_NUMBER() OVER (");
            if (!string.IsNullOrEmpty(orderby.Trim()))
            {
                strSql.Append("order by T." + orderby);
            }
            else
            {
                strSql.Append("order by T.id desc");
            }
            strSql.Append(")AS Row, T.*  from CRM_CEStage_category T ");
            if (!string.IsNullOrEmpty(strWhere.Trim()))
            {
                strSql.Append(" WHERE " + strWhere);
            }
            strSql.Append(" ) TT");
            strSql.AppendFormat(" WHERE TT.Row between {0} and {1}", startIndex, endIndex);
            return DbHelperSQL.Query(strSql.ToString());
        }
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM CRM_CEStage_category ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM CRM_CEStage_category ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM CRM_CEStage_category ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }
    
        /*
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetList(int PageSize,int PageIndex,string strWhere)
        {
            SqlParameter[] parameters = {
                    new SqlParameter("@tblName", SqlDbType.VarChar, 255),
                    new SqlParameter("@fldName", SqlDbType.VarChar, 255),
                    new SqlParameter("@PageSize", SqlDbType.Int),
                    new SqlParameter("@PageIndex", SqlDbType.Int),
                    new SqlParameter("@IsReCount", SqlDbType.Bit),
                    new SqlParameter("@OrderType", SqlDbType.Bit),
                    new SqlParameter("@strWhere", SqlDbType.VarChar,1000),
                    };
            parameters[0].Value = "CRM_CEStage_category";
            parameters[1].Value = "id";
            parameters[2].Value = PageSize;
            parameters[3].Value = PageIndex;
            parameters[4].Value = 0;
            parameters[5].Value = 0;
            parameters[6].Value = strWhere;	
            return DbHelperSQL.RunProcedure("UP_GetRecordByPage",parameters,"ds");
        }*/

        #endregion  BasicMethod
        #region  ExtensionMethod

        #endregion  ExtensionMethod
    }
}

