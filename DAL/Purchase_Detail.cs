using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Purchase_Detail
	/// </summary>
	public partial class Purchase_Detail
	{
		public Purchase_Detail()
		{}
		#region  BasicMethod

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(string Purid)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Purchase_Detail");
			strSql.Append(" where Purid=SQL2012Purid ");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012Purid", SqlDbType.VarChar,8)			};
			parameters[0].Value = Purid;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.Purchase_Detail model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Purchase_Detail(");
			strSql.Append("Purid,material_id,material_name,specifications,model,unit,purprice,pursum,subtotal,remarks)");
			strSql.Append(" values (");
			strSql.Append("SQL2012Purid,SQL2012material_id,SQL2012material_name,SQL2012specifications,SQL2012model,SQL2012unit,SQL2012purprice,SQL2012pursum,SQL2012subtotal,SQL2012remarks)");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012Purid", SqlDbType.VarChar,8),
					new SqlParameter("SQL2012material_id", SqlDbType.VarChar,10),
					new SqlParameter("SQL2012material_name", SqlDbType.VarChar,250),
					new SqlParameter("SQL2012specifications", SqlDbType.VarChar,50),
					new SqlParameter("SQL2012model", SqlDbType.VarChar,50),
					new SqlParameter("SQL2012unit", SqlDbType.VarChar,10),
					new SqlParameter("SQL2012purprice", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012pursum", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012subtotal", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012remarks", SqlDbType.VarChar,250)};
			parameters[0].Value = model.Purid;
			parameters[1].Value = model.material_id;
			parameters[2].Value = model.material_name;
			parameters[3].Value = model.specifications;
			parameters[4].Value = model.model;
			parameters[5].Value = model.unit;
			parameters[6].Value = model.purprice;
			parameters[7].Value = model.pursum;
			parameters[8].Value = model.subtotal;
			parameters[9].Value = model.remarks;

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
		/// 更新一条数据
		/// </summary>
		public bool Update(XHD.Model.Purchase_Detail model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Purchase_Detail set ");
			strSql.Append("material_id=SQL2012material_id,");
			strSql.Append("material_name=SQL2012material_name,");
			strSql.Append("specifications=SQL2012specifications,");
			strSql.Append("model=SQL2012model,");
			strSql.Append("unit=SQL2012unit,");
			strSql.Append("purprice=SQL2012purprice,");
			strSql.Append("pursum=SQL2012pursum,");
			strSql.Append("subtotal=SQL2012subtotal,");
			strSql.Append("remarks=SQL2012remarks");
			strSql.Append(" where Purid=SQL2012Purid ");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012material_id", SqlDbType.VarChar,10),
					new SqlParameter("SQL2012material_name", SqlDbType.VarChar,250),
					new SqlParameter("SQL2012specifications", SqlDbType.VarChar,50),
					new SqlParameter("SQL2012model", SqlDbType.VarChar,50),
					new SqlParameter("SQL2012unit", SqlDbType.VarChar,10),
					new SqlParameter("SQL2012purprice", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012pursum", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012subtotal", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012remarks", SqlDbType.VarChar,250),
					new SqlParameter("SQL2012Purid", SqlDbType.VarChar,8)};
			parameters[0].Value = model.material_id;
			parameters[1].Value = model.material_name;
			parameters[2].Value = model.specifications;
			parameters[3].Value = model.model;
			parameters[4].Value = model.unit;
			parameters[5].Value = model.purprice;
			parameters[6].Value = model.pursum;
			parameters[7].Value = model.subtotal;
			parameters[8].Value = model.remarks;
			parameters[9].Value = model.Purid;

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
		public bool Delete(string Purid)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Purchase_Detail ");
			strSql.Append(" where Purid=SQL2012Purid ");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012Purid", SqlDbType.VarChar,8)			};
			parameters[0].Value = Purid;

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
		public bool DeleteList(string Puridlist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Purchase_Detail ");
			strSql.Append(" where Purid in ("+Puridlist + ")  ");
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
		public XHD.Model.Purchase_Detail GetModel(string Purid)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 Purid,material_id,material_name,specifications,model,unit,purprice,pursum,subtotal,remarks from Purchase_Detail ");
			strSql.Append(" where Purid=SQL2012Purid ");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012Purid", SqlDbType.VarChar,8)			};
			parameters[0].Value = Purid;

			XHD.Model.Purchase_Detail model=new XHD.Model.Purchase_Detail();
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
		public XHD.Model.Purchase_Detail DataRowToModel(DataRow row)
		{
			XHD.Model.Purchase_Detail model=new XHD.Model.Purchase_Detail();
			if (row != null)
			{
				if(row["Purid"]!=null)
				{
					model.Purid=row["Purid"].ToString();
				}
				if(row["material_id"]!=null)
				{
					model.material_id=row["material_id"].ToString();
				}
				if(row["material_name"]!=null)
				{
					model.material_name=row["material_name"].ToString();
				}
				if(row["specifications"]!=null)
				{
					model.specifications=row["specifications"].ToString();
				}
				if(row["model"]!=null)
				{
					model.model=row["model"].ToString();
				}
				if(row["unit"]!=null)
				{
					model.unit=row["unit"].ToString();
				}
				if(row["purprice"]!=null && row["purprice"].ToString()!="")
				{
					model.purprice=decimal.Parse(row["purprice"].ToString());
				}
				if(row["pursum"]!=null && row["pursum"].ToString()!="")
				{
					model.pursum=decimal.Parse(row["pursum"].ToString());
				}
				if(row["subtotal"]!=null && row["subtotal"].ToString()!="")
				{
					model.subtotal=decimal.Parse(row["subtotal"].ToString());
				}
				if(row["remarks"]!=null)
				{
					model.remarks=row["remarks"].ToString();
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
			strSql.Append("select Purid,material_id,material_name,specifications,model,unit,purprice,pursum,subtotal,remarks ");
			strSql.Append(" FROM Purchase_Detail ");
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
			strSql.Append(" Purid,material_id,material_name,specifications,model,unit,purprice,pursum,subtotal,remarks ");
			strSql.Append(" FROM Purchase_Detail ");
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
			strSql.Append("select count(1) FROM Purchase_Detail ");
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
				strSql.Append("order by T.Purid desc");
			}
			strSql.Append(")AS Row, T.*  from Purchase_Detail T ");
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
			parameters[0].Value = "Purchase_Detail";
			parameters[1].Value = "Purid";
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

