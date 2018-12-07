using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:crm_customer_type
	/// </summary>
	public partial class crm_customer_type
	{
		public crm_customer_type()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "crm_customer_type"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from crm_customer_type");
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
		public int Add(XHD.Model.crm_customer_type model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into crm_customer_type(");
			strSql.Append("typeid,followhours,remarks,createtime,createperson)");
			strSql.Append(" values (");
			strSql.Append("@typeid,@followhours,@remarks,@createtime,@createperson)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@typeid", SqlDbType.Int,4),
					new SqlParameter("@followhours", SqlDbType.Decimal,9),
					new SqlParameter("@remarks", SqlDbType.VarChar,50),
					new SqlParameter("@createtime", SqlDbType.DateTime),
					new SqlParameter("@createperson", SqlDbType.VarChar,20)};
			parameters[0].Value = model.typeid;
			parameters[1].Value = model.followhours;
			parameters[2].Value = model.remarks;
			parameters[3].Value = model.createtime;
			parameters[4].Value = model.createperson;

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
		public bool Update(XHD.Model.crm_customer_type model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update crm_customer_type set ");
			strSql.Append("typeid=@typeid,");
			strSql.Append("followhours=@followhours,");
			strSql.Append("remarks=@remarks,");
			strSql.Append("createtime=@createtime,");
			strSql.Append("createperson=@createperson");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@typeid", SqlDbType.Int,4),
					new SqlParameter("@followhours", SqlDbType.Decimal,9),
					new SqlParameter("@remarks", SqlDbType.VarChar,50),
					new SqlParameter("@createtime", SqlDbType.DateTime),
					new SqlParameter("@createperson", SqlDbType.VarChar,20),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.typeid;
			parameters[1].Value = model.followhours;
			parameters[2].Value = model.remarks;
			parameters[3].Value = model.createtime;
			parameters[4].Value = model.createperson;
			parameters[5].Value = model.id;

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
			strSql.Append("delete from crm_customer_type ");
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
			strSql.Append("delete from crm_customer_type ");
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
		public XHD.Model.crm_customer_type GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,typeid,followhours,remarks,createtime,createperson from crm_customer_type ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.crm_customer_type model=new XHD.Model.crm_customer_type();
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
		public XHD.Model.crm_customer_type DataRowToModel(DataRow row)
		{
			XHD.Model.crm_customer_type model=new XHD.Model.crm_customer_type();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["typeid"]!=null && row["typeid"].ToString()!="")
				{
					model.typeid=int.Parse(row["typeid"].ToString());
				}
				if(row["followhours"]!=null && row["followhours"].ToString()!="")
				{
					model.followhours=decimal.Parse(row["followhours"].ToString());
				}
				if(row["remarks"]!=null)
				{
					model.remarks=row["remarks"].ToString();
				}
				if(row["createtime"]!=null && row["createtime"].ToString()!="")
				{
					model.createtime=DateTime.Parse(row["createtime"].ToString());
				}
				if(row["createperson"]!=null)
				{
					model.createperson=row["createperson"].ToString();
				}
			}
			return model;
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public DataSet GetList(string strWhere)
		{
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT  A.*,B.params_name FROM dbo.crm_customer_type A  ");
            sb.AppendLine(" INNER JOIN Param_SysParam B ON	A.typeid=B.id  ");

            if (strWhere.Trim()!="")
			{
                sb.Append(" where "+strWhere);
			}
			return DbHelperSQL.Query(sb.ToString());
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
			strSql.Append(" id,typeid,followhours,remarks,createtime,createperson ");
			strSql.Append(" FROM crm_customer_type ");
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
			strSql.Append("select count(1) FROM crm_customer_type ");
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
			strSql.Append(")AS Row, T.*  from crm_customer_type T ");
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
			parameters[0].Value = "crm_customer_type";
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
            strSql.Append(" top " + PageSize + "  A.*,B.params_name FROM dbo.crm_customer_type A");
            strSql.Append(" INNER JOIN Param_SysParam B ON	A.typeid=B.id ");
            strSql.Append(" WHERE A.id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM crm_customer_type");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(a.id) FROM crm_customer_type A");
            strSql1.Append(" INNER JOIN Param_SysParam B ON	A.typeid=B.id ");

            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet GetListDetail1(int PageSize, int PageIndex, string strWhere)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT * FROM (  "); 
            sb.AppendLine(" SELECT ROW_NUMBER() OVER(ORDER BY A.Customer_id DESC) n	, a.Follow_Type, COUNT(1) AS cs,a.Customer_id ,'【'+B.Customer+'】'+B.address AS Customer  ");
            sb.AppendLine(" ,MIN(A.Follow_date) AS Follow_date ,MAX(A.Follow_date) AS Follow_date_  ");
            sb.AppendLine(" ,DATEDIFF(DAY,MAX(A.Follow_date),GETDATE()) AS ts  ");
            sb.AppendLine(" 	 FROM  dbo.CRM_Follow A  ");
            sb.AppendLine(" INNER JOIN  dbo.CRM_Customer B ON	A.Customer_id=B.id  ");
            sb.AppendLine(" WHERE  1=1   ");
            if (strWhere.Trim() != "")
            {
                sb.AppendLine(  strWhere);

            }
            sb.AppendLine(" GROUP BY '【'+B.Customer+'】'+B.address, a.Customer_id, a.Follow_Type  ");
            sb.AppendLine(" 		)pur  ");
            sb.AppendLine(" WHERE  1=1   ");
         
            sb.AppendLine("  AND n>=" + (PageIndex - 1) * PageSize + "");
            sb.AppendLine("  AND n<" + PageSize * PageIndex + "");


            

            return DbHelperSQL.Query(sb.ToString());
        }

        public DataSet GetListview(int PageSize, int PageIndex, string strWhere)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("  SELECT * FROM (    ");
            sb.AppendLine("  SELECT ROW_NUMBER() OVER(ORDER BY A.Customer_id DESC) n	,a.*    ");
            sb.AppendLine("  	 FROM  dbo.CRM_Follow A    ");
            sb.AppendLine("  INNER JOIN  dbo.CRM_Customer B ON	A.Customer_id=B.id    ");
            sb.AppendLine("  WHERE  1=1     ");
        
            if (strWhere.Trim() != "")
            {
                sb.AppendLine(strWhere);

            }
            sb.AppendLine("   		)pur    ");
            sb.AppendLine("  WHERE  1=1     ");
 

            sb.AppendLine("  AND n>=" + (PageIndex - 1) * PageSize + "");
            sb.AppendLine("  AND n<" + PageSize * PageIndex + "");




            return DbHelperSQL.Query(sb.ToString());
        }


        public DataSet GetListDetail2(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "   * FROM V_Crm_Follow_Report A"); 
            strSql.Append(" WHERE A.id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM V_Crm_Follow_Report");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(a.id) FROM V_Crm_Follow_Report A"); 

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

