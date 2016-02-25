using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:budge_modelMain
	/// </summary>
	public partial class budge_modelMain
	{
		public budge_modelMain()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "budge_modelMain"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from budge_modelMain");
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
		public int Add(XHD.Model.budge_modelMain model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into budge_modelMain(");
			strSql.Append("model_id,model_name,DoPerson,DoTime,citations,Remarks)");
			strSql.Append(" values (");
			strSql.Append("@model_id,@model_name,@DoPerson,@DoTime,@citations,@Remarks)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@model_id", SqlDbType.VarChar,15),
					new SqlParameter("@model_name", SqlDbType.VarChar,250),
					new SqlParameter("@DoPerson", SqlDbType.Int,4),
					new SqlParameter("@DoTime", SqlDbType.DateTime),
					new SqlParameter("@citations", SqlDbType.Int,4),
					new SqlParameter("@Remarks", SqlDbType.VarChar,250)};
			parameters[0].Value = model.model_id;
			parameters[1].Value = model.model_name;
			parameters[2].Value = model.DoPerson;
			parameters[3].Value = model.DoTime;
			parameters[4].Value = model.citations;
			parameters[5].Value = model.Remarks;

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
		public bool Update(XHD.Model.budge_modelMain model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update budge_modelMain set ");
			strSql.Append("model_id=@model_id,");
			strSql.Append("model_name=@model_name,");
			strSql.Append("DoPerson=@DoPerson,");
			strSql.Append("DoTime=@DoTime,");
			strSql.Append("citations=@citations,");
			strSql.Append("Remarks=@Remarks");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@model_id", SqlDbType.VarChar,15),
					new SqlParameter("@model_name", SqlDbType.VarChar,250),
					new SqlParameter("@DoPerson", SqlDbType.Int,4),
					new SqlParameter("@DoTime", SqlDbType.DateTime),
					new SqlParameter("@citations", SqlDbType.Int,4),
					new SqlParameter("@Remarks", SqlDbType.VarChar,250),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.model_id;
			parameters[1].Value = model.model_name;
			parameters[2].Value = model.DoPerson;
			parameters[3].Value = model.DoTime;
			parameters[4].Value = model.citations;
			parameters[5].Value = model.Remarks;
			parameters[6].Value = model.id;

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
			strSql.Append("delete from budge_modelMain ");
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
			strSql.Append("delete from budge_modelMain ");
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
		public XHD.Model.budge_modelMain GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,model_id,model_name,DoPerson,DoTime,citations,Remarks from budge_modelMain ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.budge_modelMain model=new XHD.Model.budge_modelMain();
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
		public XHD.Model.budge_modelMain DataRowToModel(DataRow row)
		{
			XHD.Model.budge_modelMain model=new XHD.Model.budge_modelMain();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["model_id"]!=null)
				{
					model.model_id=row["model_id"].ToString();
				}
				if(row["model_name"]!=null)
				{
					model.model_name=row["model_name"].ToString();
				}
				if(row["DoPerson"]!=null && row["DoPerson"].ToString()!="")
				{
					model.DoPerson=int.Parse(row["DoPerson"].ToString());
				}
				if(row["DoTime"]!=null && row["DoTime"].ToString()!="")
				{
					model.DoTime=DateTime.Parse(row["DoTime"].ToString());
				}
				if(row["citations"]!=null && row["citations"].ToString()!="")
				{
					model.citations=int.Parse(row["citations"].ToString());
				}
				if(row["Remarks"]!=null)
				{
					model.Remarks=row["Remarks"].ToString();
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
			strSql.Append("select id,model_id,model_name,DoPerson,DoTime,citations,Remarks ");
			strSql.Append(" FROM budge_modelMain ");
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
			strSql.Append(" id,model_id,model_name,DoPerson,DoTime,citations,Remarks ");
			strSql.Append(" FROM budge_modelMain ");
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
			strSql.Append("select count(1) FROM budge_modelMain ");
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
			strSql.Append(")AS Row, T.*  from budge_modelMain T ");
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
			parameters[0].Value = "budge_modelMain";
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

