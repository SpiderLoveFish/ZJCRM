using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:tools_use_mx
	/// </summary>
	public partial class tools_use_mx
	{
		public tools_use_mx()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "tools_use_mx"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from tools_use_mx");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
			parameters[0].Value = id;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.tools_use_mx model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into tools_use_mx(");
			strSql.Append("id,toolsid,productid,productname,productnumber,remarks)");
			strSql.Append(" values (");
			strSql.Append("@id,@toolsid,@productid,@productname,@productnumber,@remarks)");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4),
					new SqlParameter("@toolsid", SqlDbType.VarChar,50),
					new SqlParameter("@productid", SqlDbType.Int,4),
					new SqlParameter("@productname", SqlDbType.VarChar,50),
					new SqlParameter("@productnumber", SqlDbType.Int,4),
					new SqlParameter("@remarks", SqlDbType.VarChar,50)};
			parameters[0].Value = model.id;
			parameters[1].Value = model.toolsid;
			parameters[2].Value = model.productid;
			parameters[3].Value = model.productname;
			parameters[4].Value = model.productnumber;
			parameters[5].Value = model.remarks;

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
		public bool Update(XHD.Model.tools_use_mx model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update tools_use_mx set ");
			strSql.Append("toolsid=@toolsid,");
			strSql.Append("productid=@productid,");
			strSql.Append("productname=@productname,");
			strSql.Append("productnumber=@productnumber,");
			strSql.Append("remarks=@remarks");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@toolsid", SqlDbType.VarChar,50),
					new SqlParameter("@productid", SqlDbType.Int,4),
					new SqlParameter("@productname", SqlDbType.VarChar,50),
					new SqlParameter("@productnumber", SqlDbType.Int,4),
					new SqlParameter("@remarks", SqlDbType.VarChar,50),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.toolsid;
			parameters[1].Value = model.productid;
			parameters[2].Value = model.productname;
			parameters[3].Value = model.productnumber;
			parameters[4].Value = model.remarks;
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
			strSql.Append("delete from tools_use_mx ");
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

        public bool Delete(String toolsid)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from tools_use_mx ");
            strSql.Append(" where toolsid=@id ");
            SqlParameter[] parameters = {
                    new SqlParameter("@id",  SqlDbType.VarChar,50)            };
            parameters[0].Value = toolsid;

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
        /// 批量删除数据
        /// </summary>
        public bool DeleteList(string idlist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from tools_use_mx ");
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
		public XHD.Model.tools_use_mx GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,toolsid,productid,productname,productnumber,remarks from tools_use_mx ");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
			parameters[0].Value = id;

			XHD.Model.tools_use_mx model=new XHD.Model.tools_use_mx();
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
		public XHD.Model.tools_use_mx DataRowToModel(DataRow row)
		{
			XHD.Model.tools_use_mx model=new XHD.Model.tools_use_mx();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["toolsid"]!=null)
				{
					model.toolsid=row["toolsid"].ToString();
				}
				if(row["productid"]!=null && row["productid"].ToString()!="")
				{
					model.productid=int.Parse(row["productid"].ToString());
				}
				if(row["productname"]!=null)
				{
					model.productname=row["productname"].ToString();
				}
				if(row["productnumber"]!=null && row["productnumber"].ToString()!="")
				{
					model.productnumber=int.Parse(row["productnumber"].ToString());
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
			strSql.Append("select id,toolsid,productid,productname,productnumber,remarks ");
			strSql.Append(" FROM tools_use_mx ");
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
			strSql.Append(" id,toolsid,productid,productname,productnumber,remarks ");
			strSql.Append(" FROM tools_use_mx ");
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
			strSql.Append("select count(1) FROM tools_use_mx ");
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
			strSql.Append(")AS Row, T.*  from tools_use_mx T ");
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
			parameters[0].Value = "tools_use_mx";
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
            strSql.Append(" top " + PageSize + " * FROM tools_use_mx  A ");
            strSql.Append(" INNER JOIN  dbo.CRM_product B ON	A.productid=B.product_id ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM tools_use_mx  A");
            strSql.Append(" INNER JOIN  dbo.CRM_product B ON	A.productid=B.product_id ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM tools_use_mx A ");
            strSql1.Append(" INNER JOIN  dbo.CRM_product B ON	A.productid=B.product_id ");
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

