using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
    /// <summary>
    /// 数据访问类:CRM_CEStageDetail
    /// </summary>
    public partial class CRM_CEStageDetail
    {
        public CRM_CEStageDetail()
        { }
        #region  BasicMethod

        /// <summary>
        /// 得到最大ID
        /// </summary>
        public int GetMaxId()
        {
            return DbHelperSQL.GetMaxID("StageID", "CRM_CEStageDetail");
        }

        /// <summary>
        /// 得到最大detaolID
        /// </summary>
        public int GetMaxDetailId(string StageID)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select max(StageDetailID)+1 from CRM_CEStageDetail where StageID=" + StageID);
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
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int StageID, int StageDetailID)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from CRM_CEStageDetail");
            strSql.Append(" where StageID=@StageID and StageDetailID=@StageDetailID ");
            SqlParameter[] parameters = {
					new SqlParameter("@StageID", SqlDbType.Int,4),
					new SqlParameter("@StageDetailID", SqlDbType.Int,4)			};
            parameters[0].Value = StageID;
            parameters[1].Value = StageDetailID;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 增加一条数据
        /// </summary>
        public bool Add(XHD.Model.CRM_CEStageDetail model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into CRM_CEStageDetail(");
            strSql.Append("StageID,StageDetailID,Description,StageContent)");
            strSql.Append(" values (");
            strSql.Append("@StageID,@StageDetailID,@Description,@StageContent)");
            SqlParameter[] parameters = {
					new SqlParameter("@StageID", SqlDbType.Int,4),
					new SqlParameter("@StageDetailID", SqlDbType.Int,4),
					new SqlParameter("@Description", SqlDbType.VarChar,250),
					new SqlParameter("@StageContent", SqlDbType.NVarChar,-1)};
            parameters[0].Value = model.StageID;
            parameters[1].Value = model.StageDetailID;
            parameters[2].Value = model.Description;
            parameters[3].Value = model.StageContent;

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
        /// 更新一条数据
        /// </summary>
        public bool Update(XHD.Model.CRM_CEStageDetail model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update CRM_CEStageDetail set ");
            strSql.Append("Description=@Description,");
            strSql.Append("StageContent=@StageContent");
            strSql.Append(" where StageID=@StageID and StageDetailID=@StageDetailID ");
            SqlParameter[] parameters = {
					new SqlParameter("@Description", SqlDbType.VarChar,250),
					new SqlParameter("@StageContent", SqlDbType.NVarChar,-1),
					new SqlParameter("@StageID", SqlDbType.Int,4),
					new SqlParameter("@StageDetailID", SqlDbType.Int,4)};
            parameters[0].Value = model.Description;
            parameters[1].Value = model.StageContent;
            parameters[2].Value = model.StageID;
            parameters[3].Value = model.StageDetailID;

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
        public bool Delete(int StageID, int StageDetailID)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from CRM_CEStageDetail ");
            strSql.Append(" where StageID=@StageID and StageDetailID=@StageDetailID ");
            SqlParameter[] parameters = {
					new SqlParameter("@StageID", SqlDbType.Int,4),
					new SqlParameter("@StageDetailID", SqlDbType.Int,4)			};
            parameters[0].Value = StageID;
            parameters[1].Value = StageDetailID;

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
        /// 得到一个对象实体
        /// </summary>
        public XHD.Model.CRM_CEStageDetail GetModel(int StageID, int StageDetailID)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 StageID,StageDetailID,Description,StageContent from CRM_CEStageDetail ");
            strSql.Append(" where StageID=@StageID and StageDetailID=@StageDetailID ");
            SqlParameter[] parameters = {
					new SqlParameter("@StageID", SqlDbType.Int,4),
					new SqlParameter("@StageDetailID", SqlDbType.Int,4)			};
            parameters[0].Value = StageID;
            parameters[1].Value = StageDetailID;

            XHD.Model.CRM_CEStageDetail model = new XHD.Model.CRM_CEStageDetail();
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
        public XHD.Model.CRM_CEStageDetail DataRowToModel(DataRow row)
        {
            XHD.Model.CRM_CEStageDetail model = new XHD.Model.CRM_CEStageDetail();
            if (row != null)
            {
                if (row["StageID"] != null && row["StageID"].ToString() != "")
                {
                    model.StageID = int.Parse(row["StageID"].ToString());
                }
                if (row["StageDetailID"] != null && row["StageDetailID"].ToString() != "")
                {
                    model.StageDetailID = int.Parse(row["StageDetailID"].ToString());
                }
                if (row["Description"] != null)
                {
                    model.Description = row["Description"].ToString();
                }
                if (row["StageContent"] != null)
                {
                    model.StageContent = row["StageContent"].ToString();
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
            strSql.Append("select StageID,StageDetailID,Description,StageContent ");
            strSql.Append(" FROM CRM_CEStageDetail ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList_Main(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select StageID,StageDetailID,Description,StageContent,B.CEStage_category ");
            strSql.Append(" FROM CRM_CEStageDetail A  ");
            strSql.Append(" INNER JOIN  dbo.CRM_CEStage_category B ON A.StageID=B.id ");
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
            strSql.Append(" StageID,StageDetailID,Description,StageContent ");
            strSql.Append(" FROM CRM_CEStageDetail ");
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
            strSql.Append("select count(1) FROM CRM_CEStageDetail ");
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
                strSql.Append("order by T.StageDetailID desc");
            }
            strSql.Append(")AS Row, T.*  from CRM_CEStageDetail T ");
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
            strSql.Append(" top " + PageSize + " * FROM CRM_CEStageDetail ");
            strSql.Append(" WHERE StageDetailID not in ( SELECT top " + (PageIndex - 1) * PageSize + " StageDetailID FROM CRM_CEStageDetail ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(StageID) FROM CRM_CEStageDetail ");
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
            parameters[0].Value = "CRM_CEStageDetail";
            parameters[1].Value = "StageDetailID";
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

