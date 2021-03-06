﻿using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:InStock_Detail
	/// </summary>
	public partial class InStock_Detail
	{
		public InStock_Detail()
		{}
		#region  BasicMethod

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(string RKID,string material_id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from InStock_Detail");
			strSql.Append(" where RKID=@RKID and material_id=@material_id ");
			SqlParameter[] parameters = {
					new SqlParameter("@RKID", SqlDbType.VarChar,15),
					new SqlParameter("@material_id", SqlDbType.VarChar,15)			};
			parameters[0].Value = RKID;
			parameters[1].Value = material_id;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.InStock_Detail model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into InStock_Detail(");
			strSql.Append("RKID,material_id,material_name,specifications,model,unit,purprice,pursum,subtotal,remarks)");
			strSql.Append(" values (");
			strSql.Append("@RKID,@material_id,@material_name,@specifications,@model,@unit,@purprice,@pursum,@subtotal,@remarks)");
			SqlParameter[] parameters = {
					new SqlParameter("@RKID", SqlDbType.VarChar,15),
					new SqlParameter("@material_id", SqlDbType.VarChar,15),
					new SqlParameter("@material_name", SqlDbType.VarChar,250),
					new SqlParameter("@specifications", SqlDbType.VarChar,50),
					new SqlParameter("@model", SqlDbType.VarChar,50),
					new SqlParameter("@unit", SqlDbType.VarChar,10),
					new SqlParameter("@purprice", SqlDbType.Decimal,9),
					new SqlParameter("@pursum", SqlDbType.Decimal,9),
					new SqlParameter("@subtotal", SqlDbType.Decimal,9),
					new SqlParameter("@remarks", SqlDbType.VarChar,250)};
			parameters[0].Value = model.RKID;
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
		public bool Update(XHD.Model.InStock_Detail model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update InStock_Detail set ");
			strSql.Append("material_name=@material_name,");
			strSql.Append("specifications=@specifications,");
			strSql.Append("model=@model,");
			strSql.Append("unit=@unit,");
			strSql.Append("purprice=@purprice,");
			strSql.Append("pursum=@pursum,");
			strSql.Append("subtotal=@subtotal,");
			strSql.Append("remarks=@remarks");
			strSql.Append(" where RKID=@RKID and material_id=@material_id ");
			SqlParameter[] parameters = {
					new SqlParameter("@material_name", SqlDbType.VarChar,250),
					new SqlParameter("@specifications", SqlDbType.VarChar,50),
					new SqlParameter("@model", SqlDbType.VarChar,50),
					new SqlParameter("@unit", SqlDbType.VarChar,10),
					new SqlParameter("@purprice", SqlDbType.Decimal,9),
					new SqlParameter("@pursum", SqlDbType.Decimal,9),
					new SqlParameter("@subtotal", SqlDbType.Decimal,9),
					new SqlParameter("@remarks", SqlDbType.VarChar,250),
					new SqlParameter("@RKID", SqlDbType.VarChar,15),
					new SqlParameter("@material_id", SqlDbType.VarChar,15)};
			parameters[0].Value = model.material_name;
			parameters[1].Value = model.specifications;
			parameters[2].Value = model.model;
			parameters[3].Value = model.unit;
			parameters[4].Value = model.purprice;
			parameters[5].Value = model.pursum;
			parameters[6].Value = model.subtotal;
			parameters[7].Value = model.remarks;
			parameters[8].Value = model.RKID;
			parameters[9].Value = model.material_id;

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
		public bool Delete(string RKID,string material_id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from InStock_Detail ");
			strSql.Append(" where RKID=@RKID and material_id=@material_id ");
			SqlParameter[] parameters = {
					new SqlParameter("@RKID", SqlDbType.VarChar,15),
					new SqlParameter("@material_id", SqlDbType.VarChar,15)			};
			parameters[0].Value = RKID;
			parameters[1].Value = material_id;

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
		/// 得到一个对象实体
		/// </summary>
		public XHD.Model.InStock_Detail GetModel(string RKID,string material_id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 RKID,material_id,material_name,specifications,model,unit,purprice,pursum,subtotal,remarks from InStock_Detail ");
			strSql.Append(" where RKID=@RKID and material_id=@material_id ");
			SqlParameter[] parameters = {
					new SqlParameter("@RKID", SqlDbType.VarChar,15),
					new SqlParameter("@material_id", SqlDbType.VarChar,15)			};
			parameters[0].Value = RKID;
			parameters[1].Value = material_id;

			XHD.Model.InStock_Detail model=new XHD.Model.InStock_Detail();
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
		public XHD.Model.InStock_Detail DataRowToModel(DataRow row)
		{
			XHD.Model.InStock_Detail model=new XHD.Model.InStock_Detail();
			if (row != null)
			{
				if(row["RKID"]!=null)
				{
					model.RKID=row["RKID"].ToString();
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
			strSql.Append("select RKID,material_id,material_name,specifications,model,unit,purprice,pursum,subtotal,remarks ");
			strSql.Append(" FROM InStock_Detail ");
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
			strSql.Append(" RKID,material_id,material_name,specifications,model,unit,purprice,pursum,subtotal,remarks ");
			strSql.Append(" FROM InStock_Detail ");
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
			strSql.Append("select count(1) FROM InStock_Detail ");
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
				strSql.Append("order by T.material_id desc");
			}
			strSql.Append(")AS Row, T.*  from InStock_Detail T ");
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
			parameters[0].Value = "InStock_Detail";
			parameters[1].Value = "material_id";
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

