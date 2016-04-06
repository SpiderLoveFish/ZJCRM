using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:MasterStock
	/// </summary>
	public partial class MasterStock
	{
		public MasterStock()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "MasterStock"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from MasterStock");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
			parameters[0].Value = id;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.MasterStock model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into MasterStock(");
			strSql.Append("id,Financial_Y_M,ProductID,BeginStock,EndStock,InStock,OutStock,Remarks)");
			strSql.Append(" values (");
			strSql.Append("@id,@Financial_Y_M,@ProductID,@BeginStock,@EndStock,@InStock,@OutStock,@Remarks)");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4),
					new SqlParameter("@Financial_Y_M", SqlDbType.VarChar,6),
					new SqlParameter("@ProductID", SqlDbType.Int,4),
					new SqlParameter("@BeginStock", SqlDbType.Decimal,9),
					new SqlParameter("@EndStock", SqlDbType.Decimal,9),
					new SqlParameter("@InStock", SqlDbType.Decimal,9),
					new SqlParameter("@OutStock", SqlDbType.Decimal,9),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50)};
			parameters[0].Value = model.id;
			parameters[1].Value = model.Financial_Y_M;
			parameters[2].Value = model.ProductID;
			parameters[3].Value = model.BeginStock;
			parameters[4].Value = model.EndStock;
			parameters[5].Value = model.InStock;
			parameters[6].Value = model.OutStock;
			parameters[7].Value = model.Remarks;

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
		public bool Update(XHD.Model.MasterStock model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update MasterStock set ");
			strSql.Append("Financial_Y_M=@Financial_Y_M,");
			strSql.Append("ProductID=@ProductID,");
			strSql.Append("BeginStock=@BeginStock,");
			strSql.Append("EndStock=@EndStock,");
			strSql.Append("InStock=@InStock,");
			strSql.Append("OutStock=@OutStock,");
			strSql.Append("Remarks=@Remarks");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@Financial_Y_M", SqlDbType.VarChar,6),
					new SqlParameter("@ProductID", SqlDbType.Int,4),
					new SqlParameter("@BeginStock", SqlDbType.Decimal,9),
					new SqlParameter("@EndStock", SqlDbType.Decimal,9),
					new SqlParameter("@InStock", SqlDbType.Decimal,9),
					new SqlParameter("@OutStock", SqlDbType.Decimal,9),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.Financial_Y_M;
			parameters[1].Value = model.ProductID;
			parameters[2].Value = model.BeginStock;
			parameters[3].Value = model.EndStock;
			parameters[4].Value = model.InStock;
			parameters[5].Value = model.OutStock;
			parameters[6].Value = model.Remarks;
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
			strSql.Append("delete from MasterStock ");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
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
			strSql.Append("delete from MasterStock ");
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
		public XHD.Model.MasterStock GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,Financial_Y_M,ProductID,BeginStock,EndStock,InStock,OutStock,Remarks from MasterStock ");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
			parameters[0].Value = id;

			XHD.Model.MasterStock model=new XHD.Model.MasterStock();
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
		public XHD.Model.MasterStock DataRowToModel(DataRow row)
		{
			XHD.Model.MasterStock model=new XHD.Model.MasterStock();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["Financial_Y_M"]!=null)
				{
					model.Financial_Y_M=row["Financial_Y_M"].ToString();
				}
				if(row["ProductID"]!=null && row["ProductID"].ToString()!="")
				{
					model.ProductID=int.Parse(row["ProductID"].ToString());
				}
				if(row["BeginStock"]!=null && row["BeginStock"].ToString()!="")
				{
					model.BeginStock=decimal.Parse(row["BeginStock"].ToString());
				}
				if(row["EndStock"]!=null && row["EndStock"].ToString()!="")
				{
					model.EndStock=decimal.Parse(row["EndStock"].ToString());
				}
				if(row["InStock"]!=null && row["InStock"].ToString()!="")
				{
					model.InStock=decimal.Parse(row["InStock"].ToString());
				}
				if(row["OutStock"]!=null && row["OutStock"].ToString()!="")
				{
					model.OutStock=decimal.Parse(row["OutStock"].ToString());
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
			strSql.Append("select id,Financial_Y_M,ProductID,BeginStock,EndStock,InStock,OutStock,Remarks ");
			strSql.Append(" FROM MasterStock ");
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
			strSql.Append(" id,Financial_Y_M,ProductID,BeginStock,EndStock,InStock,OutStock,Remarks ");
			strSql.Append(" FROM MasterStock ");
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
			strSql.Append("select count(1) FROM MasterStock ");
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
			strSql.Append(")AS Row, T.*  from MasterStock T ");
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
			parameters[0].Value = "MasterStock";
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
        public DataSet GetMasterStock(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  A.*,B.Name,C.product_name FROM  dbo.MasterStock  A");
            strSql.Append(" INNER JOIN dbo.KcGl_Jcb_Cklb B ON A.StockID=B.ID ");
            strSql.Append(" INNER JOIN dbo.CRM_product C ON A.ProductID=C.product_id ");
            strSql.Append(" WHERE  A.id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM MasterStock  ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(A.id) FROM MasterStock   A");
            strSql1.Append(" INNER JOIN dbo.KcGl_Jcb_Cklb B ON A.StockID=B.ID ");
            strSql1.Append(" INNER JOIN dbo.CRM_product C ON A.ProductID=C.product_id ");

            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }


        public DataSet GetInStock(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  B.*,C.Customer,C.tel,C.address FROM  dbo.INStock_Main  A");
            strSql.Append(" INNER JOIN  dbo.Purchase_Main B ON A.purid=B.Purid  ");
            strSql.Append(" INNER JOIN dbo.CRM_Customer C ON B.customid=C.id ");
            strSql.Append(" WHERE  A.RKID not in ( SELECT top " + (PageIndex - 1) * PageSize + " RKID FROM INStock_Main  ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(A.RKID) FROM INStock_Main   A");
            strSql1.Append(" INNER JOIN  dbo.Purchase_Main B ON A.purid=B.Purid  ");
            strSql1.Append(" INNER JOIN dbo.CRM_Customer C ON B.customid=C.id ");

            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }
        public DataSet GetOutStock(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  A.*,C.Customer,C.tel,C.address FROM  dbo.OutStock_Main  A");

            strSql.Append(" INNER JOIN dbo.CRM_Customer C ON A.CustomerID=C.id ");
            strSql.Append(" WHERE  A.CKID not in ( SELECT top " + (PageIndex - 1) * PageSize + " CKID FROM OutStock_Main  ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(A.CKID) FROM OutStock_Main   A");

            strSql1.Append(" INNER JOIN dbo.CRM_Customer C ON A.CustomerID=C.id ");

            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }
        //月结
        public int DoMonthClose()
        {
            SqlParameter[] parameters = {
				 
                                     };
          
            int rowaffected = 0;
            DbHelperSQL.RunProcedure("USP_MonthClose", parameters, out rowaffected);
            return rowaffected;
        }
		#endregion  ExtensionMethod
	}
}

