using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Financial_Profit
	/// </summary>
	public partial class Financial_Profit
	{
		public Financial_Profit()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "Financial_Profit"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Financial_Profit");
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
		public int Add(XHD.Model.Financial_Profit model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Financial_Profit(");
			strSql.Append("F_StyleID,F_StyleName,Formula,Company_Profit,sjs_Profit,sgjl_Profit,ywy_Profit,F1_Profit,F2_Profit,F3_Profit,Remarks)");
			strSql.Append(" values (");
			strSql.Append("@F_StyleID,@F_StyleName,@Formula,@Company_Profit,@sjs_Profit,@sgjl_Profit,@ywy_Profit,@F1_Profit,@F2_Profit,@F3_Profit,@Remarks)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@F_StyleID", SqlDbType.Int,4),
					new SqlParameter("@F_StyleName", SqlDbType.VarChar,50),
					new SqlParameter("@Formula", SqlDbType.VarChar,50),
					new SqlParameter("@Company_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@sjs_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@sgjl_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@ywy_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@F1_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@F2_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@F3_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50)};
			parameters[0].Value = model.F_StyleID;
			parameters[1].Value = model.F_StyleName;
			parameters[2].Value = model.Formula;
			parameters[3].Value = model.Company_Profit;
			parameters[4].Value = model.sjs_Profit;
			parameters[5].Value = model.sgjl_Profit;
			parameters[6].Value = model.ywy_Profit;
			parameters[7].Value = model.F1_Profit;
			parameters[8].Value = model.F2_Profit;
			parameters[9].Value = model.F3_Profit;
			parameters[10].Value = model.Remarks;

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
		public bool Update(XHD.Model.Financial_Profit model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Financial_Profit set ");
			strSql.Append("F_StyleID=@F_StyleID,");
			strSql.Append("F_StyleName=@F_StyleName,");
			strSql.Append("Formula=@Formula,");
			strSql.Append("Company_Profit=@Company_Profit,");
			strSql.Append("sjs_Profit=@sjs_Profit,");
			strSql.Append("sgjl_Profit=@sgjl_Profit,");
			strSql.Append("ywy_Profit=@ywy_Profit,");
			strSql.Append("F1_Profit=@F1_Profit,");
			strSql.Append("F2_Profit=@F2_Profit,");
			strSql.Append("F3_Profit=@F3_Profit,");
			strSql.Append("Remarks=@Remarks");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@F_StyleID", SqlDbType.Int,4),
					new SqlParameter("@F_StyleName", SqlDbType.VarChar,50),
					new SqlParameter("@Formula", SqlDbType.VarChar,50),
					new SqlParameter("@Company_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@sjs_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@sgjl_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@ywy_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@F1_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@F2_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@F3_Profit", SqlDbType.VarChar,50),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.F_StyleID;
			parameters[1].Value = model.F_StyleName;
			parameters[2].Value = model.Formula;
			parameters[3].Value = model.Company_Profit;
			parameters[4].Value = model.sjs_Profit;
			parameters[5].Value = model.sgjl_Profit;
			parameters[6].Value = model.ywy_Profit;
			parameters[7].Value = model.F1_Profit;
			parameters[8].Value = model.F2_Profit;
			parameters[9].Value = model.F3_Profit;
			parameters[10].Value = model.Remarks;
			parameters[11].Value = model.id;

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
			strSql.Append("delete from Financial_Profit ");
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
			strSql.Append("delete from Financial_Profit ");
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
		public XHD.Model.Financial_Profit GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,F_StyleID,F_StyleName,Formula,Company_Profit,sjs_Profit,sgjl_Profit,ywy_Profit,F1_Profit,F2_Profit,F3_Profit,Remarks from Financial_Profit ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.Financial_Profit model=new XHD.Model.Financial_Profit();
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
		public XHD.Model.Financial_Profit DataRowToModel(DataRow row)
		{
			XHD.Model.Financial_Profit model=new XHD.Model.Financial_Profit();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["F_StyleID"]!=null && row["F_StyleID"].ToString()!="")
				{
					model.F_StyleID=int.Parse(row["F_StyleID"].ToString());
				}
				if(row["F_StyleName"]!=null)
				{
					model.F_StyleName=row["F_StyleName"].ToString();
				}
				if(row["Formula"]!=null)
				{
					model.Formula=row["Formula"].ToString();
				}
				if(row["Company_Profit"]!=null)
				{
					model.Company_Profit=row["Company_Profit"].ToString();
				}
				if(row["sjs_Profit"]!=null)
				{
					model.sjs_Profit=row["sjs_Profit"].ToString();
				}
				if(row["sgjl_Profit"]!=null)
				{
					model.sgjl_Profit=row["sgjl_Profit"].ToString();
				}
				if(row["ywy_Profit"]!=null)
				{
					model.ywy_Profit=row["ywy_Profit"].ToString();
				}
				if(row["F1_Profit"]!=null)
				{
					model.F1_Profit=row["F1_Profit"].ToString();
				}
				if(row["F2_Profit"]!=null)
				{
					model.F2_Profit=row["F2_Profit"].ToString();
				}
				if(row["F3_Profit"]!=null)
				{
					model.F3_Profit=row["F3_Profit"].ToString();
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
			strSql.Append("select id,F_StyleID,F_StyleName,Formula,Company_Profit,sjs_Profit,sgjl_Profit,ywy_Profit,F1_Profit,F2_Profit,F3_Profit,Remarks ");
			strSql.Append(" FROM Financial_Profit ");
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
			strSql.Append(" id,F_StyleID,F_StyleName,Formula,Company_Profit,sjs_Profit,sgjl_Profit,ywy_Profit,F1_Profit,F2_Profit,F3_Profit,Remarks ");
			strSql.Append(" FROM Financial_Profit ");
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
			strSql.Append("select count(1) FROM Financial_Profit ");
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
			strSql.Append(")AS Row, T.*  from Financial_Profit T ");
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
			parameters[0].Value = "Financial_Profit";
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
        public DataSet GetListPage(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  * from Financial_Profit");
            strSql.Append(" WHERE ( id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM CRM_Customer  ");
            if (filedOrder != "  id  desc")
            {
                strSql.Append(" where " + strWhere + " order by " + filedOrder + " ,id desc) )");
            }
            else
            {
                strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) )");
            };


            strSql1.Append(" select count(id) FROM Financial_Profit  ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            if (filedOrder != "  id  desc")
            {
                strSql.Append(" ,id desc ");
            };
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }

        #endregion  ExtensionMethod
    }
}

