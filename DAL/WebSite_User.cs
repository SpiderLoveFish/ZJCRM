using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:WebSite_User
	/// </summary>
	public partial class WebSite_User
	{
		public WebSite_User()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "WebSite_User"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from WebSite_User");
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
		public int Add(XHD.Model.WebSite_User model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into WebSite_User(");
			strSql.Append("userid,tel,pwd,dotime,nickname,birthday,sex,status,kjl_login)");
			strSql.Append(" values (");
			strSql.Append("@userid,@tel,@pwd,@dotime,@nickname,@birthday,@sex,@status,@kjl_login)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@userid", SqlDbType.VarChar,20),
					new SqlParameter("@tel", SqlDbType.VarChar,20),
					new SqlParameter("@pwd", SqlDbType.VarChar,50),
					new SqlParameter("@dotime", SqlDbType.DateTime),
					new SqlParameter("@nickname", SqlDbType.NVarChar,20),
					new SqlParameter("@birthday", SqlDbType.SmallDateTime),
					new SqlParameter("@sex", SqlDbType.Char,1),
					new SqlParameter("@status", SqlDbType.Char,1),
					new SqlParameter("@kjl_login", SqlDbType.VarChar,20)};
			parameters[0].Value = model.userid;
			parameters[1].Value = model.tel;
			parameters[2].Value = model.pwd;
			parameters[3].Value = model.dotime;
			parameters[4].Value = model.nickname;
			parameters[5].Value = model.birthday;
			parameters[6].Value = model.sex;
			parameters[7].Value = model.status;
			parameters[8].Value = model.kjl_login;

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
		public bool Update(XHD.Model.WebSite_User model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update WebSite_User set ");
			strSql.Append("userid=@userid,");
			strSql.Append("tel=@tel,");
			strSql.Append("pwd=@pwd,");
			strSql.Append("dotime=@dotime,");
			strSql.Append("nickname=@nickname,");
			strSql.Append("birthday=@birthday,");
			strSql.Append("sex=@sex,");
			strSql.Append("status=@status,");
			strSql.Append("kjl_login=@kjl_login");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@userid", SqlDbType.VarChar,20),
					new SqlParameter("@tel", SqlDbType.VarChar,20),
					new SqlParameter("@pwd", SqlDbType.VarChar,50),
					new SqlParameter("@dotime", SqlDbType.DateTime),
					new SqlParameter("@nickname", SqlDbType.NVarChar,20),
					new SqlParameter("@birthday", SqlDbType.SmallDateTime),
					new SqlParameter("@sex", SqlDbType.Char,1),
					new SqlParameter("@status", SqlDbType.Char,1),
					new SqlParameter("@kjl_login", SqlDbType.VarChar,20),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.userid;
			parameters[1].Value = model.tel;
			parameters[2].Value = model.pwd;
			parameters[3].Value = model.dotime;
			parameters[4].Value = model.nickname;
			parameters[5].Value = model.birthday;
			parameters[6].Value = model.sex;
			parameters[7].Value = model.status;
			parameters[8].Value = model.kjl_login;
			parameters[9].Value = model.id;

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
			strSql.Append("delete from WebSite_User ");
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
			strSql.Append("delete from WebSite_User ");
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
		public XHD.Model.WebSite_User GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,userid,tel,pwd,dotime,nickname,birthday,sex,status,kjl_login from WebSite_User ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.WebSite_User model=new XHD.Model.WebSite_User();
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
		public XHD.Model.WebSite_User DataRowToModel(DataRow row)
		{
			XHD.Model.WebSite_User model=new XHD.Model.WebSite_User();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["userid"]!=null)
				{
					model.userid=row["userid"].ToString();
				}
				if(row["tel"]!=null)
				{
					model.tel=row["tel"].ToString();
				}
				if(row["pwd"]!=null)
				{
					model.pwd=row["pwd"].ToString();
				}
				if(row["dotime"]!=null && row["dotime"].ToString()!="")
				{
					model.dotime=DateTime.Parse(row["dotime"].ToString());
				}
				if(row["nickname"]!=null)
				{
					model.nickname=row["nickname"].ToString();
				}
				if(row["birthday"]!=null && row["birthday"].ToString()!="")
				{
					model.birthday=DateTime.Parse(row["birthday"].ToString());
				}
				if(row["sex"]!=null)
				{
					model.sex=row["sex"].ToString();
				}
				if(row["status"]!=null)
				{
					model.status=row["status"].ToString();
				}
				if(row["kjl_login"]!=null)
				{
					model.kjl_login=row["kjl_login"].ToString();
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
			strSql.Append("select id,userid,tel,pwd,dotime,nickname,birthday,sex,status,kjl_login ");
			strSql.Append(" FROM WebSite_User ");
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
			strSql.Append(" id,userid,tel,pwd,dotime,nickname,birthday,sex,status,kjl_login ");
			strSql.Append(" FROM WebSite_User ");
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
			strSql.Append("select count(1) FROM WebSite_User ");
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
			strSql.Append(")AS Row, T.*  from WebSite_User T ");
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
			parameters[0].Value = "WebSite_User";
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

