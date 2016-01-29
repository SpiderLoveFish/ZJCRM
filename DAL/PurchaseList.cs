using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:PurchaseList
	/// </summary>
	public partial class PurchaseList
	{
		public PurchaseList()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "PurchaseList"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from PurchaseList");
			strSql.Append(" where id=SQL2012id");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(XHD.Model.PurchaseList model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into PurchaseList(");
			strSql.Append("CustomerID,category_id,product_id,DoTime,DoPerson,IsStatus,Price,AmountSum)");
			strSql.Append(" values (");
			strSql.Append("SQL2012CustomerID,SQL2012category_id,SQL2012product_id,SQL2012DoTime,SQL2012DoPerson,SQL2012IsStatus,SQL2012Price,SQL2012AmountSum)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012CustomerID", SqlDbType.Int,4),
					new SqlParameter("SQL2012category_id", SqlDbType.Int,4),
					new SqlParameter("SQL2012product_id", SqlDbType.Int,4),
					new SqlParameter("SQL2012DoTime", SqlDbType.DateTime),
					new SqlParameter("SQL2012DoPerson", SqlDbType.VarChar,20),
					new SqlParameter("SQL2012IsStatus", SqlDbType.Int,4),
					new SqlParameter("SQL2012Price", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012AmountSum", SqlDbType.Decimal,9)};
			parameters[0].Value = model.CustomerID;
			parameters[1].Value = model.category_id;
			parameters[2].Value = model.product_id;
			parameters[3].Value = model.DoTime;
			parameters[4].Value = model.DoPerson;
			parameters[5].Value = model.IsStatus;
			parameters[6].Value = model.Price;
			parameters[7].Value = model.AmountSum;

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
		public bool Update(XHD.Model.PurchaseList model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update PurchaseList set ");
			strSql.Append("CustomerID=SQL2012CustomerID,");
			strSql.Append("category_id=SQL2012category_id,");
			strSql.Append("product_id=SQL2012product_id,");
			strSql.Append("DoTime=SQL2012DoTime,");
			strSql.Append("DoPerson=SQL2012DoPerson,");
			strSql.Append("IsStatus=SQL2012IsStatus,");
			strSql.Append("Price=SQL2012Price,");
			strSql.Append("AmountSum=SQL2012AmountSum");
			strSql.Append(" where id=SQL2012id");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012CustomerID", SqlDbType.Int,4),
					new SqlParameter("SQL2012category_id", SqlDbType.Int,4),
					new SqlParameter("SQL2012product_id", SqlDbType.Int,4),
					new SqlParameter("SQL2012DoTime", SqlDbType.DateTime),
					new SqlParameter("SQL2012DoPerson", SqlDbType.VarChar,20),
					new SqlParameter("SQL2012IsStatus", SqlDbType.Int,4),
					new SqlParameter("SQL2012Price", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012AmountSum", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012id", SqlDbType.Int,4)};
			parameters[0].Value = model.CustomerID;
			parameters[1].Value = model.category_id;
			parameters[2].Value = model.product_id;
			parameters[3].Value = model.DoTime;
			parameters[4].Value = model.DoPerson;
			parameters[5].Value = model.IsStatus;
			parameters[6].Value = model.Price;
			parameters[7].Value = model.AmountSum;
			parameters[8].Value = model.id;

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
        /// 更新状态和数量
        /// </summary>
        /// <param name="status"></param>
        /// <param name="sum"></param>
        /// <param name="empid"></param>
        /// <param name="cid"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public bool UpdateZT_SUM(int status, decimal sum, int empid, int cid, int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update PurchaseList set ");
            strSql.Append("IsStatus="+status+",");
            strSql.Append("AmountSum="+sum+"");
            strSql.Append(" where id="+id+"");
            strSql.Append(" and CustomerID=" + cid + "");
            strSql.Append(" and DoPerson=" + empid + "");
            SqlParameter[] parameters = { };
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
        /// 多个选择插入数据
        /// </summary>
        /// <param name="cid"></param>
        /// <param name="pid"></param>
        /// <returns></returns>
        public int InsertList(int cid, string pid, string emp_id)
        {
            string strsql = " INSERT INTO dbo.PurchaseList "+
                            " ( CustomerID ,  category_id ,  product_id ,DoTime , DoPerson , IsStatus , Price , AmountSum ) "+
                            " SELECT " + cid + ",category_id,product_id,GETDATE(),'" + emp_id + "',0,0,0 " +
                             " FROM CRM_product WHERE product_id IN("+pid+")";
            SqlParameter[] parameters = { };
            object obj = DbHelperSQL.GetSingle(strsql, parameters);
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
		/// 删除一条数据
		/// </summary>
		public bool Delete(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from PurchaseList ");
			strSql.Append(" where id="+id+"");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012id", SqlDbType.Int,4)
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
			strSql.Append("delete from PurchaseList ");
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
		public XHD.Model.PurchaseList GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,CustomerID,category_id,product_id,DoTime,DoPerson,IsStatus,Price,AmountSum from PurchaseList ");
			strSql.Append(" where id=SQL2012id");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.PurchaseList model=new XHD.Model.PurchaseList();
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
		public XHD.Model.PurchaseList DataRowToModel(DataRow row)
		{
			XHD.Model.PurchaseList model=new XHD.Model.PurchaseList();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["CustomerID"]!=null && row["CustomerID"].ToString()!="")
				{
					model.CustomerID=int.Parse(row["CustomerID"].ToString());
				}
				if(row["category_id"]!=null && row["category_id"].ToString()!="")
				{
					model.category_id=int.Parse(row["category_id"].ToString());
				}
				if(row["product_id"]!=null && row["product_id"].ToString()!="")
				{
					model.product_id=int.Parse(row["product_id"].ToString());
				}
				if(row["DoTime"]!=null && row["DoTime"].ToString()!="")
				{
					model.DoTime=DateTime.Parse(row["DoTime"].ToString());
				}
				if(row["DoPerson"]!=null)
				{
					model.DoPerson=row["DoPerson"].ToString();
				}
				if(row["IsStatus"]!=null && row["IsStatus"].ToString()!="")
				{
					model.IsStatus=int.Parse(row["IsStatus"].ToString());
				}
				if(row["Price"]!=null && row["Price"].ToString()!="")
				{
					model.Price=decimal.Parse(row["Price"].ToString());
				}
				if(row["AmountSum"]!=null && row["AmountSum"].ToString()!="")
				{
					model.AmountSum=decimal.Parse(row["AmountSum"].ToString());
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
			strSql.Append("select id,CustomerID,category_id,product_id,DoTime,DoPerson,IsStatus,Price,AmountSum ");
			strSql.Append(" FROM PurchaseList ");
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
			strSql.Append(" id,CustomerID,category_id,product_id,DoTime,DoPerson,IsStatus,Price,AmountSum ");
			strSql.Append(" FROM PurchaseList ");
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
			strSql.Append("select count(1) FROM PurchaseList ");
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
			strSql.Append(")AS Row, T.*  from PurchaseList T ");
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
			parameters[0].Value = "PurchaseList";
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
        public DataSet GetList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM PurchaseList ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM PurchaseList ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(ID) FROM PurchaseList ");
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
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetTempList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM (SELECT A.*,B.product_name,B.category_name ");
             strSql.Append(" ,specifications,unit ");
              strSql.Append(" FROM dbo.PurchaseList A ");
             strSql.Append(" INNER JOIN dbo.CRM_product B ON  ");
             strSql.Append(" A.product_id=B.product_id AND A.category_id=B.category_id ");
             strSql.Append(" )PurchaseList ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM PurchaseList ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(ID) FROM PurchaseList ");
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

