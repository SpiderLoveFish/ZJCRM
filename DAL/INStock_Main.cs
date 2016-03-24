using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:INStock_Main
	/// </summary>
	public partial class INStock_Main
	{
		public INStock_Main()
		{}
		#region  BasicMethod

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(string RKID)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from INStock_Main");
			strSql.Append(" where RKID=@RKID ");
			SqlParameter[] parameters = {
					new SqlParameter("@RKID", SqlDbType.VarChar,15)			};
			parameters[0].Value = RKID;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.INStock_Main model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into INStock_Main(");
			strSql.Append("RKID,RKDate,FYM,GYSID,TotalAmount,PayAmount,InPerson,remarks,StockID)");
			strSql.Append(" values (");
			strSql.Append("@RKID,@RKDate,@FYM,@GYSID,@TotalAmount,@PayAmount,@InPerson,@remarks,@StockID)");
			SqlParameter[] parameters = {
					new SqlParameter("@RKID", SqlDbType.VarChar,15),
					new SqlParameter("@RKDate", SqlDbType.DateTime),
					new SqlParameter("@FYM", SqlDbType.VarChar,6),
					new SqlParameter("@GYSID", SqlDbType.Int,4),
					new SqlParameter("@TotalAmount", SqlDbType.Decimal,9),
					new SqlParameter("@PayAmount", SqlDbType.Decimal,9),
					new SqlParameter("@InPerson", SqlDbType.VarChar,20),
					new SqlParameter("@remarks", SqlDbType.VarChar,50),
					new SqlParameter("@StockID", SqlDbType.VarChar,10)};
			parameters[0].Value = model.RKID;
			parameters[1].Value = model.RKDate;
			parameters[2].Value = model.FYM;
			parameters[3].Value = model.GYSID;
			parameters[4].Value = model.TotalAmount;
			parameters[5].Value = model.PayAmount;
			parameters[6].Value = model.InPerson;
			parameters[7].Value = model.remarks;
			parameters[8].Value = model.StockID;

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
		public bool Update(XHD.Model.INStock_Main model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update INStock_Main set ");
			strSql.Append("RKDate=@RKDate,");
			strSql.Append("FYM=@FYM,");
			strSql.Append("GYSID=@GYSID,");
			strSql.Append("TotalAmount=@TotalAmount,");
			strSql.Append("PayAmount=@PayAmount,");
			strSql.Append("InPerson=@InPerson,");
			strSql.Append("remarks=@remarks,");
			strSql.Append("StockID=@StockID");
			strSql.Append(" where RKID=@RKID ");
			SqlParameter[] parameters = {
					new SqlParameter("@RKDate", SqlDbType.DateTime),
					new SqlParameter("@FYM", SqlDbType.VarChar,6),
					new SqlParameter("@GYSID", SqlDbType.Int,4),
					new SqlParameter("@TotalAmount", SqlDbType.Decimal,9),
					new SqlParameter("@PayAmount", SqlDbType.Decimal,9),
					new SqlParameter("@InPerson", SqlDbType.VarChar,20),
					new SqlParameter("@remarks", SqlDbType.VarChar,50),
					new SqlParameter("@StockID", SqlDbType.VarChar,10),
					new SqlParameter("@RKID", SqlDbType.VarChar,15)};
			parameters[0].Value = model.RKDate;
			parameters[1].Value = model.FYM;
			parameters[2].Value = model.GYSID;
			parameters[3].Value = model.TotalAmount;
			parameters[4].Value = model.PayAmount;
			parameters[5].Value = model.InPerson;
			parameters[6].Value = model.remarks;
			parameters[7].Value = model.StockID;
			parameters[8].Value = model.RKID;

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
		public bool Delete(string RKID)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from INStock_Main ");
			strSql.Append(" where RKID=@RKID ");
			SqlParameter[] parameters = {
					new SqlParameter("@RKID", SqlDbType.VarChar,15)			};
			parameters[0].Value = RKID;

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
		public bool DeleteList(string RKIDlist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from INStock_Main ");
			strSql.Append(" where RKID in ("+RKIDlist + ")  ");
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
		public XHD.Model.INStock_Main GetModel(string RKID)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 RKID,RKDate,FYM,GYSID,TotalAmount,PayAmount,InPerson,remarks,StockID from INStock_Main ");
			strSql.Append(" where RKID=@RKID ");
			SqlParameter[] parameters = {
					new SqlParameter("@RKID", SqlDbType.VarChar,15)			};
			parameters[0].Value = RKID;

			XHD.Model.INStock_Main model=new XHD.Model.INStock_Main();
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
		public XHD.Model.INStock_Main DataRowToModel(DataRow row)
		{
			XHD.Model.INStock_Main model=new XHD.Model.INStock_Main();
			if (row != null)
			{
				if(row["RKID"]!=null)
				{
					model.RKID=row["RKID"].ToString();
				}
				if(row["RKDate"]!=null && row["RKDate"].ToString()!="")
				{
					model.RKDate=DateTime.Parse(row["RKDate"].ToString());
				}
				if(row["FYM"]!=null)
				{
					model.FYM=row["FYM"].ToString();
				}
				if(row["GYSID"]!=null && row["GYSID"].ToString()!="")
				{
					model.GYSID=int.Parse(row["GYSID"].ToString());
				}
				if(row["TotalAmount"]!=null && row["TotalAmount"].ToString()!="")
				{
					model.TotalAmount=decimal.Parse(row["TotalAmount"].ToString());
				}
				if(row["PayAmount"]!=null && row["PayAmount"].ToString()!="")
				{
					model.PayAmount=decimal.Parse(row["PayAmount"].ToString());
				}
				if(row["InPerson"]!=null)
				{
					model.InPerson=row["InPerson"].ToString();
				}
				if(row["remarks"]!=null)
				{
					model.remarks=row["remarks"].ToString();
				}
				if(row["StockID"]!=null)
				{
					model.StockID=row["StockID"].ToString();
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
			strSql.Append("select RKID,RKDate,FYM,GYSID,TotalAmount,PayAmount,InPerson,remarks,StockID ");
			strSql.Append(" FROM INStock_Main ");
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
			strSql.Append(" RKID,RKDate,FYM,GYSID,TotalAmount,PayAmount,InPerson,remarks,StockID ");
			strSql.Append(" FROM INStock_Main ");
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
			strSql.Append("select count(1) FROM INStock_Main ");
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
				strSql.Append("order by T.RKID desc");
			}
			strSql.Append(")AS Row, T.*  from INStock_Main T ");
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
			parameters[0].Value = "INStock_Main";
			parameters[1].Value = "RKID";
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

