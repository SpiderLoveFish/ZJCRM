using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Car_Use_Log
	/// </summary>
	public partial class Car_Use_Log
	{
		public Car_Use_Log()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "Car_Use_Log"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Car_Use_Log");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(XHD.Model.Car_Use_Log model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Car_Use_Log(");
			strSql.Append("carid,carNumber,userPerson,useBeginTiime,useEndTiime,Remarks,IsStatus)");
			strSql.Append(" values (");
			strSql.Append("@carid,@carNumber,@userPerson,@useBeginTiime,@useEndTiime,@Remarks,@IsStatus)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@carid", SqlDbType.Int,4),
					new SqlParameter("@carNumber", SqlDbType.VarChar,20),
					new SqlParameter("@userPerson", SqlDbType.VarChar,20),
					new SqlParameter("@useBeginTiime", SqlDbType.DateTime),
					new SqlParameter("@useEndTiime", SqlDbType.DateTime),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
					new SqlParameter("@IsStatus", SqlDbType.Char,1)};
			parameters[0].Value = model.carid;
			parameters[1].Value = model.carNumber;
			parameters[2].Value = model.userPerson;
			parameters[3].Value = model.useBeginTiime;
			parameters[4].Value = model.useEndTiime;
			parameters[5].Value = model.Remarks;
			parameters[6].Value = model.IsStatus;

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
		public bool Update(XHD.Model.Car_Use_Log model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Car_Use_Log set ");
			strSql.Append("carid=@carid,");
			strSql.Append("carNumber=@carNumber,");
			strSql.Append("userPerson=@userPerson,");
			strSql.Append("useBeginTiime=@useBeginTiime,");
			strSql.Append("useEndTiime=@useEndTiime,");
			strSql.Append("Remarks=@Remarks,");
			strSql.Append("IsStatus=@IsStatus");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@carid", SqlDbType.Int,4),
					new SqlParameter("@carNumber", SqlDbType.VarChar,20),
					new SqlParameter("@userPerson", SqlDbType.VarChar,20),
					new SqlParameter("@useBeginTiime", SqlDbType.DateTime),
					new SqlParameter("@useEndTiime", SqlDbType.DateTime),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
					new SqlParameter("@IsStatus", SqlDbType.Char,1),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.carid;
			parameters[1].Value = model.carNumber;
			parameters[2].Value = model.userPerson;
			parameters[3].Value = model.useBeginTiime;
			parameters[4].Value = model.useEndTiime;
			parameters[5].Value = model.Remarks;
			parameters[6].Value = model.IsStatus;
			parameters[7].Value = model.id;

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
		public bool Delete(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Car_Use_Log ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

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
		public bool DeleteList(string idlist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Car_Use_Log ");
			strSql.Append(" where id in ("+idlist + ")  ");
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
		public XHD.Model.Car_Use_Log GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,carid,carNumber,userPerson,useBeginTiime,useEndTiime,Remarks,IsStatus from Car_Use_Log ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.Car_Use_Log model=new XHD.Model.Car_Use_Log();
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
		public XHD.Model.Car_Use_Log DataRowToModel(DataRow row)
		{
			XHD.Model.Car_Use_Log model=new XHD.Model.Car_Use_Log();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["carid"]!=null && row["carid"].ToString()!="")
				{
					model.carid=int.Parse(row["carid"].ToString());
				}
				if(row["carNumber"]!=null)
				{
					model.carNumber=row["carNumber"].ToString();
				}
				if(row["userPerson"]!=null)
				{
					model.userPerson=row["userPerson"].ToString();
				}
				if(row["useBeginTiime"]!=null && row["useBeginTiime"].ToString()!="")
				{
					model.useBeginTiime=DateTime.Parse(row["useBeginTiime"].ToString());
				}
				if(row["useEndTiime"]!=null && row["useEndTiime"].ToString()!="")
				{
					model.useEndTiime=DateTime.Parse(row["useEndTiime"].ToString());
				}
				if(row["Remarks"]!=null)
				{
					model.Remarks=row["Remarks"].ToString();
				}
				if(row["IsStatus"]!=null)
				{
					model.IsStatus=row["IsStatus"].ToString();
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
			strSql.Append("select id,carid,carNumber,userPerson,useBeginTiime,useEndTiime,Remarks,IsStatus ");
			strSql.Append(" FROM Car_Use_Log ");
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
			strSql.Append(" id,carid,carNumber,userPerson,useBeginTiime,useEndTiime,Remarks,IsStatus ");
			strSql.Append(" FROM Car_Use_Log ");
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
			strSql.Append("select count(1) FROM Car_Use_Log ");
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
				strSql.Append("order by T.id desc");
			}
			strSql.Append(")AS Row, T.*  from Car_Use_Log T ");
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
			parameters[0].Value = "Car_Use_Log";
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
        public DataSet GetList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM Car_Use_Log ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM Car_Use_Log ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM Car_Use_Log ");
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

