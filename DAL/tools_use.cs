using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:tools_use
	/// </summary>
	public partial class tools_use
	{
		public tools_use()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "tools_use"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from tools_use");
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
		public int Add(XHD.Model.tools_use model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into tools_use(");
			strSql.Append("toolsid,borrowersid,borrowers,begintime,endtime,isstatus,remarks,dotime)");
			strSql.Append(" values (");
			strSql.Append("@toolsid,@borrowersid,@borrowers,@begintime,@endtime,@isstatus,@remarks,@dotime)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@toolsid", SqlDbType.VarChar,50),
					new SqlParameter("@borrowersid", SqlDbType.Int,4),
					new SqlParameter("@borrowers", SqlDbType.VarChar,50),
					new SqlParameter("@begintime", SqlDbType.DateTime),
					new SqlParameter("@endtime", SqlDbType.DateTime),
					new SqlParameter("@isstatus", SqlDbType.Char,1),
					new SqlParameter("@remarks", SqlDbType.VarChar,50),
                new SqlParameter("@dotime", SqlDbType.DateTime)};
			parameters[0].Value = model.toolsid;
			parameters[1].Value = model.borrowersid;
			parameters[2].Value = model.borrowers;
			parameters[3].Value = model.begintime;
			parameters[4].Value = model.endtime;
			parameters[5].Value = model.isstatus;
			parameters[6].Value = model.remarks;
            parameters[7].Value = model.dotime;
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
		public bool Update(XHD.Model.tools_use model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update tools_use set ");
			strSql.Append("toolsid=@toolsid,");
			strSql.Append("borrowersid=@borrowersid,");
			strSql.Append("borrowers=@borrowers,");
			strSql.Append("begintime=@begintime,");
			strSql.Append("endtime=@endtime,");
            strSql.Append("dotime=@dotime,");
            strSql.Append("isstatus=@isstatus,");
			strSql.Append("remarks=@remarks");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@toolsid", SqlDbType.VarChar,50),
					new SqlParameter("@borrowersid", SqlDbType.Int,4),
					new SqlParameter("@borrowers", SqlDbType.VarChar,50),
					new SqlParameter("@begintime", SqlDbType.DateTime),
					new SqlParameter("@endtime", SqlDbType.DateTime),
                                new SqlParameter("@dotime", SqlDbType.DateTime),
                    new SqlParameter("@isstatus", SqlDbType.Char,1),
					new SqlParameter("@remarks", SqlDbType.VarChar,50),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.toolsid;
			parameters[1].Value = model.borrowersid;
			parameters[2].Value = model.borrowers;
			parameters[3].Value = model.begintime;
			parameters[4].Value = model.endtime;
            parameters[5].Value = model.dotime;
            parameters[6].Value = model.isstatus;
			parameters[7].Value = model.remarks;
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
		/// 删除一条数据
		/// </summary>
		public bool Delete(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from tools_use ");
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
			strSql.Append("delete from tools_use ");
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
		public XHD.Model.tools_use GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,toolsid,borrowersid,borrowers,begintime,endtime,isstatus,remarks,dotime from tools_use ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.tools_use model=new XHD.Model.tools_use();
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
		public XHD.Model.tools_use DataRowToModel(DataRow row)
		{
			XHD.Model.tools_use model=new XHD.Model.tools_use();
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
				if(row["borrowersid"]!=null && row["borrowersid"].ToString()!="")
				{
					model.borrowersid=int.Parse(row["borrowersid"].ToString());
				}
				if(row["borrowers"]!=null)
				{
					model.borrowers=row["borrowers"].ToString();
				}
				if(row["begintime"]!=null && row["begintime"].ToString()!="")
				{
					model.begintime=DateTime.Parse(row["begintime"].ToString());
				}
				if(row["endtime"]!=null && row["endtime"].ToString()!="")
				{
					model.endtime=DateTime.Parse(row["endtime"].ToString());
				}
				if(row["isstatus"]!=null)
				{
					model.isstatus=row["isstatus"].ToString();
				}
				if(row["remarks"]!=null)
				{
					model.remarks=row["remarks"].ToString();
				}
                if (row["dotime"] != null && row["dotime"].ToString() != "")
                {
                    model.dotime = DateTime.Parse(row["dotime"].ToString());
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
			strSql.Append("select id,toolsid,borrowersid,borrowers,begintime,endtime,isstatus,remarks,dotime ");
			strSql.Append(" FROM tools_use ");
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
			strSql.Append(" id,toolsid,borrowersid,borrowers,begintime,endtime,isstatus,remarks ,dotime");
			strSql.Append(" FROM tools_use ");
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
			strSql.Append("select count(1) FROM tools_use ");
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
			strSql.Append(")AS Row, T.*  from tools_use T ");
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
			parameters[0].Value = "tools_use";
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

        public bool UpdateStatus(string id,string sfsh)
        { 
            StringBuilder strSql = new StringBuilder();
            strSql.Append("UPDATE	 tools_use SET IsStatus= CASE IsStatus WHEN 'Y' THEN 'N' WHEN 'N' THEN 'Y' ELSE 'Y' END ");
            if (sfsh != "Y")//是否审核，归还的时候才更新时间
                strSql.Append(" ,endtime=getdate() ");
            strSql.Append(" where id=@id");
            //strSql.Append("UPDATE	 tools_use SET IsStatus= CASE IsStatus WHEN 'Y' THEN 'N' WHEN 'N' THEN 'Y' ELSE 'Y' END ");
            //strSql.Append("  ,endtime=GETDATE()");
            //strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
                    new SqlParameter("@id", SqlDbType.Int,4)
                                        };
            parameters[0].Value = id;
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

        public DataSet GetList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " *,DATEDIFF(DAY,endtime,begintime) ts FROM tools_use ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM tools_use ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM tools_use ");
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

