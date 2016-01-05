using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Xm_list
	/// </summary>
	public partial class Xm_list
	{
		public Xm_list()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("XMID", "Xm_list"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int XMID)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Xm_list");
			strSql.Append(" where XMID=@XMID");
			SqlParameter[] parameters = {
					new SqlParameter("@XMID", SqlDbType.Int,4)
			};
			parameters[0].Value = XMID;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(XHD.Model.Xm_list model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Xm_list(");
			strSql.Append("XMMC,XMPX,REMARK,CZR)");
			strSql.Append(" values (");
			strSql.Append("@XMMC,@XMPX,@REMARK,@CZR)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@XMMC", SqlDbType.VarChar,50),
					new SqlParameter("@XMPX", SqlDbType.Int,4),
					new SqlParameter("@REMARK", SqlDbType.VarChar,-1),
					new SqlParameter("@CZR", SqlDbType.VarChar,50)};
			parameters[0].Value = model.XMMC;
			parameters[1].Value = model.XMPX;
			parameters[2].Value = model.REMARK;
			parameters[3].Value = model.CZR;

			object obj = DbHelperSQL.GetSingle(strSql.ToString(),parameters);
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
		public bool Update(XHD.Model.Xm_list model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Xm_list set ");
			strSql.Append("XMMC=@XMMC,");
			strSql.Append("XMPX=@XMPX,");
			strSql.Append("REMARK=@REMARK,");
			strSql.Append("CZR=@CZR");
			strSql.Append(" where XMID=@XMID");
			SqlParameter[] parameters = {
					new SqlParameter("@XMMC", SqlDbType.VarChar,50),
					new SqlParameter("@XMPX", SqlDbType.Int,4),
					new SqlParameter("@REMARK", SqlDbType.VarChar,-1),
					new SqlParameter("@CZR", SqlDbType.VarChar,50),
					new SqlParameter("@XMID", SqlDbType.Int,4)};
			parameters[0].Value = model.XMMC;
			parameters[1].Value = model.XMPX;
			parameters[2].Value = model.REMARK;
			parameters[3].Value = model.CZR;
			parameters[4].Value = model.XMID;

			int rows=DbHelperSQL.ExecuteSql(strSql.ToString(),parameters);
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
		public bool Delete(int XMID)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Xm_list ");
			strSql.Append(" where XMID=@XMID");
			SqlParameter[] parameters = {
					new SqlParameter("@XMID", SqlDbType.Int,4)
			};
			parameters[0].Value = XMID;

			int rows=DbHelperSQL.ExecuteSql(strSql.ToString(),parameters);
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
		public bool DeleteList(string XMIDlist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Xm_list ");
			strSql.Append(" where XMID in ("+XMIDlist + ")  ");
			int rows=DbHelperSQL.ExecuteSql(strSql.ToString());
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
		public XHD.Model.Xm_list GetModel(int XMID)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 XMID,XMMC,XMPX,REMARK,CZR from Xm_list ");
			strSql.Append(" where XMID=@XMID");
			SqlParameter[] parameters = {
					new SqlParameter("@XMID", SqlDbType.Int,4)
			};
			parameters[0].Value = XMID;

			XHD.Model.Xm_list model=new XHD.Model.Xm_list();
			DataSet ds=DbHelperSQL.Query(strSql.ToString(),parameters);
			if(ds.Tables[0].Rows.Count>0)
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
		public XHD.Model.Xm_list DataRowToModel(DataRow row)
		{
			XHD.Model.Xm_list model=new XHD.Model.Xm_list();
			if (row != null)
			{
				if(row["XMID"]!=null && row["XMID"].ToString()!="")
				{
					model.XMID=int.Parse(row["XMID"].ToString());
				}
				if(row["XMMC"]!=null)
				{
					model.XMMC=row["XMMC"].ToString();
				}
				if(row["XMPX"]!=null && row["XMPX"].ToString()!="")
				{
					model.XMPX=int.Parse(row["XMPX"].ToString());
				}
				if(row["REMARK"]!=null)
				{
					model.REMARK=row["REMARK"].ToString();
				}
				if(row["CZR"]!=null)
				{
					model.CZR=row["CZR"].ToString();
				}
			}
			return model;
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public DataSet GetList(string strWhere)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select XMID,XMMC,XMPX,REMARK,CZR ");
			strSql.Append(" FROM Xm_list ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}
			return DbHelperSQL.Query(strSql.ToString());
		}

		/// <summary>
		/// 获得前几行数据
		/// </summary>
		public DataSet GetList(int Top,string strWhere,string filedOrder)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select ");
			if(Top>0)
			{
				strSql.Append(" top "+Top.ToString());
			}
			strSql.Append(" XMID,XMMC,XMPX,REMARK,CZR ");
			strSql.Append(" FROM Xm_list ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}
			strSql.Append(" order by " + filedOrder);
			return DbHelperSQL.Query(strSql.ToString());
		}

		/// <summary>
		/// 获取记录总数
		/// </summary>
		public int GetRecordCount(string strWhere)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) FROM Xm_list ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
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
			StringBuilder strSql=new StringBuilder();
			strSql.Append("SELECT * FROM ( ");
			strSql.Append(" SELECT ROW_NUMBER() OVER (");
			if (!string.IsNullOrEmpty(orderby.Trim()))
			{
				strSql.Append("order by T." + orderby );
			}
			else
			{
				strSql.Append("order by T.XMID desc");
			}
			strSql.Append(")AS Row, T.*  from Xm_list T ");
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
					new SqlParameter("@tblName", SqlDbType.VarChar, 255),
					new SqlParameter("@fldName", SqlDbType.VarChar, 255),
					new SqlParameter("@PageSize", SqlDbType.Int),
					new SqlParameter("@PageIndex", SqlDbType.Int),
					new SqlParameter("@IsReCount", SqlDbType.Bit),
					new SqlParameter("@OrderType", SqlDbType.Bit),
					new SqlParameter("@strWhere", SqlDbType.VarChar,1000),
					};
			parameters[0].Value = "Xm_list";
			parameters[1].Value = "XMID";
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
        public DataSet GetXMList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM Xm_list");
            strSql.Append(" WHERE xmid not in ( SELECT top " + (PageIndex - 1) * PageSize + " xmid FROM Xm_list ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(xmid) FROM Xm_list");
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

