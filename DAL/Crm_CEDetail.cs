﻿using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
    /// <summary>
    /// 数据访问类:Crm_CEDetail
    /// </summary>
    public partial class Crm_CEDetail
    {
        public Crm_CEDetail()
        { }
        #region  BasicMethod

         
        /// <summary>
        /// 得到最大GetMaxVerId
        /// </summary>
        public int GetMaxVerId(string StageID,string pid,string style)
        {   
            StringBuilder strSql = new StringBuilder();
            if (style=="add")
            strSql.Append("select max(versions)+1 from crm_cedetail where stageid=" + StageID+" and projectid="+pid);
            else if (style == "edit")
            strSql.Append("select max(versions) from crm_cedetail where stageid=" + StageID + " and projectid=" + pid);
            
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
        /// 增加一条数据
        /// </summary>
        public int Add(XHD.Model.Crm_CEDetail model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into Crm_CEDetail(");
            strSql.Append("projectid,versions,StageID,AssTime,isChecked,AssDescription,IsClose)");
            strSql.Append(" values (");
            strSql.Append("SQL2012projectid,SQL2012versions,SQL2012StageID,SQL2012AssTime,SQL2012isChecked,SQL2012AssDescription,SQL2012IsClose)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
					new SqlParameter("SQL2012projectid", SqlDbType.Int,4),
					new SqlParameter("SQL2012versions", SqlDbType.Int,4),
					new SqlParameter("SQL2012StageID", SqlDbType.Int,4),
					new SqlParameter("SQL2012AssTime", SqlDbType.Int,4),
					new SqlParameter("SQL2012isChecked", SqlDbType.Bit,1),
					new SqlParameter("SQL2012AssDescription", SqlDbType.VarChar,-1),
					new SqlParameter("SQL2012IsClose", SqlDbType.Bit,1)};
            parameters[0].Value = model.projectid;
            parameters[1].Value = model.versions;
            parameters[2].Value = model.StageID;
            parameters[3].Value = model.AssTime;
            parameters[4].Value = model.isChecked;
            parameters[5].Value = model.AssDescription;
            parameters[6].Value = model.IsClose;

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
        public bool Update(XHD.Model.Crm_CEDetail model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update Crm_CEDetail set ");
            strSql.Append("projectid=SQL2012projectid,");
            strSql.Append("versions=SQL2012versions,");
            strSql.Append("StageID=SQL2012StageID,");
            strSql.Append("AssTime=SQL2012AssTime,");
            strSql.Append("isChecked=SQL2012isChecked,");
            strSql.Append("AssDescription=SQL2012AssDescription,");
            strSql.Append("IsClose=SQL2012IsClose");
            strSql.Append(" where id=SQL2012id");
            SqlParameter[] parameters = {
					new SqlParameter("SQL2012projectid", SqlDbType.Int,4),
					new SqlParameter("SQL2012versions", SqlDbType.Int,4),
					new SqlParameter("SQL2012StageID", SqlDbType.Int,4),
					new SqlParameter("SQL2012AssTime", SqlDbType.Int,4),
					new SqlParameter("SQL2012isChecked", SqlDbType.Bit,1),
					new SqlParameter("SQL2012AssDescription", SqlDbType.VarChar,-1),
					new SqlParameter("SQL2012IsClose", SqlDbType.Bit,1),
					new SqlParameter("SQL2012id", SqlDbType.Int,4)};
            parameters[0].Value = model.projectid;
            parameters[1].Value = model.versions;
            parameters[2].Value = model.StageID;
            parameters[3].Value = model.AssTime;
            parameters[4].Value = model.isChecked;
            parameters[5].Value = model.AssDescription;
            parameters[6].Value = model.IsClose;
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
            strSql.Append("delete from Crm_CEDetail ");
            strSql.Append(" where id=SQL2012id");
            SqlParameter[] parameters = {
					new SqlParameter("SQL2012id", SqlDbType.Int,4)
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
            strSql.Append("delete from Crm_CEDetail ");
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
        public XHD.Model.Crm_CEDetail GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 id,projectid,versions,StageID,AssTime,isChecked,AssDescription,IsClose from Crm_CEDetail ");
            strSql.Append(" where id=SQL2012id");
            SqlParameter[] parameters = {
					new SqlParameter("SQL2012id", SqlDbType.Int,4)
			};
            parameters[0].Value = id;

            XHD.Model.Crm_CEDetail model = new XHD.Model.Crm_CEDetail();
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
        public XHD.Model.Crm_CEDetail DataRowToModel(DataRow row)
        {
            XHD.Model.Crm_CEDetail model = new XHD.Model.Crm_CEDetail();
            if (row != null)
            {
                if (row["id"] != null && row["id"].ToString() != "")
                {
                    model.id = int.Parse(row["id"].ToString());
                }
                if (row["projectid"] != null && row["projectid"].ToString() != "")
                {
                    model.projectid = int.Parse(row["projectid"].ToString());
                }
                if (row["versions"] != null && row["versions"].ToString() != "")
                {
                    model.versions = int.Parse(row["versions"].ToString());
                }
                if (row["StageID"] != null && row["StageID"].ToString() != "")
                {
                    model.StageID = int.Parse(row["StageID"].ToString());
                }
                if (row["AssTime"] != null && row["AssTime"].ToString() != "")
                {
                    model.AssTime = int.Parse(row["AssTime"].ToString());
                }
                if (row["isChecked"] != null && row["isChecked"].ToString() != "")
                {
                    if ((row["isChecked"].ToString() == "1") || (row["isChecked"].ToString().ToLower() == "true"))
                    {
                        model.isChecked = true;
                    }
                    else
                    {
                        model.isChecked = false;
                    }
                }
                if (row["AssDescription"] != null)
                {
                    model.AssDescription = row["AssDescription"].ToString();
                }
                if (row["IsClose"] != null && row["IsClose"].ToString() != "")
                {
                    if ((row["IsClose"].ToString() == "1") || (row["IsClose"].ToString().ToLower() == "true"))
                    {
                        model.IsClose = true;
                    }
                    else
                    {
                        model.IsClose = false;
                    }
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
            strSql.Append("select id,projectid,versions,StageID,AssTime,isChecked,AssDescription,IsClose ");
            strSql.Append(" FROM Crm_CEDetail ");
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
            strSql.Append(" id,projectid,versions,StageID,AssTime,isChecked,AssDescription,IsClose ");
            strSql.Append(" FROM Crm_CEDetail ");
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
            strSql.Append("select count(1) FROM Crm_CEDetail ");
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
            strSql.Append(")AS Row, T.*  from Crm_CEDetail T ");
            if (!string.IsNullOrEmpty(strWhere.Trim()))
            {
                strSql.Append(" WHERE " + strWhere);
            }
            strSql.Append(" ) TT");
            strSql.AppendFormat(" WHERE TT.Row between {0} and {1}", startIndex, endIndex);
            return DbHelperSQL.Query(strSql.ToString());
        }

        /*
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetList(int PageSize,int PageIndex,string strWhere)
        {
            SqlParameter[] parameters = {
                    new SqlParameter("SQL2012tblName", SqlDbType.VarChar, 255),
                    new SqlParameter("SQL2012fldName", SqlDbType.VarChar, 255),
                    new SqlParameter("SQL2012PageSize", SqlDbType.Int),
                    new SqlParameter("SQL2012PageIndex", SqlDbType.Int),
                    new SqlParameter("SQL2012IsReCount", SqlDbType.Bit),
                    new SqlParameter("SQL2012OrderType", SqlDbType.Bit),
                    new SqlParameter("SQL2012strWhere", SqlDbType.VarChar,1000),
                    };
            parameters[0].Value = "Crm_CEDetail";
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
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetListDetail(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM Crm_CEDetail ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM Crm_CEDetail ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM Crm_CEDetail ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 分页获取未结案数据列表
        /// </summary>
        public DataSet GetListStage(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM CRM_CEStage ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM CRM_CEStage ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM CRM_CEStage ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }

        
        #endregion  ExtensionMethod
    }
}
