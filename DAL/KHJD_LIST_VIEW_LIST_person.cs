using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:KHJD_LIST_VIEW_LIST_person
	/// </summary>
	public partial class KHJD_LIST_VIEW_LIST_person
	{
		public KHJD_LIST_VIEW_LIST_person()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("KHJDID", "KHJD_LIST_VIEW_LIST_person"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int KHJDID,string CID,int JDID,int XMID,int userid,DateTime LRRQ,int status)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from KHJD_LIST_VIEW_LIST_person");
			strSql.Append(" where KHJDID=@KHJDID and CID=@CID and JDID=@JDID and XMID=@XMID and userid=@userid and LRRQ=@LRRQ and status=@status ");
			SqlParameter[] parameters = {
					new SqlParameter("@KHJDID", SqlDbType.Int,4),
					new SqlParameter("@CID", SqlDbType.VarChar,50),
					new SqlParameter("@JDID", SqlDbType.Int,4),
					new SqlParameter("@XMID", SqlDbType.Int,4),
					new SqlParameter("@userid", SqlDbType.Int,4),
					new SqlParameter("@LRRQ", SqlDbType.DateTime),
					new SqlParameter("@status", SqlDbType.Int,4)			};
			parameters[0].Value = KHJDID;
			parameters[1].Value = CID;
			parameters[2].Value = JDID;
			parameters[3].Value = XMID;
			parameters[4].Value = userid;
			parameters[5].Value = LRRQ;
			parameters[6].Value = status;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.KHJD_LIST_VIEW_LIST_person model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into KHJD_LIST_VIEW_LIST_person(");
			strSql.Append("KHJDID,CID,JDID,XMID,userid,username,roleid,rolename,CZR,REMARK,LRRQ,status)");
			strSql.Append(" values (");
			strSql.Append("@KHJDID,@CID,@JDID,@XMID,@userid,@username,@roleid,@rolename,@CZR,@REMARK,@LRRQ,@status)");
			SqlParameter[] parameters = {
					new SqlParameter("@KHJDID", SqlDbType.Int,4),
					new SqlParameter("@CID", SqlDbType.VarChar,50),
					new SqlParameter("@JDID", SqlDbType.Int,4),
					new SqlParameter("@XMID", SqlDbType.Int,4),
					new SqlParameter("@userid", SqlDbType.Int,4),
					new SqlParameter("@username", SqlDbType.VarChar,50),
					new SqlParameter("@roleid", SqlDbType.Int,4),
					new SqlParameter("@rolename", SqlDbType.VarChar,200),
					new SqlParameter("@CZR", SqlDbType.VarChar,50),
					new SqlParameter("@REMARK", SqlDbType.VarChar,500),
					new SqlParameter("@LRRQ", SqlDbType.DateTime),
					new SqlParameter("@status", SqlDbType.Int,4)};
			parameters[0].Value = model.KHJDID;
			parameters[1].Value = model.CID;
			parameters[2].Value = model.JDID;
			parameters[3].Value = model.XMID;
			parameters[4].Value = model.userid;
			parameters[5].Value = model.username;
			parameters[6].Value = model.roleid;
			parameters[7].Value = model.rolename;
			parameters[8].Value = model.CZR;
			parameters[9].Value = model.REMARK;
			parameters[10].Value = model.LRRQ;
			parameters[11].Value = model.status;

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
		public bool Update(XHD.Model.KHJD_LIST_VIEW_LIST_person model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update KHJD_LIST_VIEW_LIST_person set ");
			strSql.Append("username=@username,");
			strSql.Append("roleid=@roleid,");
			strSql.Append("rolename=@rolename,");
			strSql.Append("CZR=@CZR,");
			strSql.Append("REMARK=@REMARK");
			strSql.Append(" where KHJDID=@KHJDID and CID=@CID and JDID=@JDID and XMID=@XMID and userid=@userid and LRRQ=@LRRQ and status=@status ");
			SqlParameter[] parameters = {
					new SqlParameter("@username", SqlDbType.VarChar,50),
					new SqlParameter("@roleid", SqlDbType.Int,4),
					new SqlParameter("@rolename", SqlDbType.VarChar,200),
					new SqlParameter("@CZR", SqlDbType.VarChar,50),
					new SqlParameter("@REMARK", SqlDbType.VarChar,500),
					new SqlParameter("@KHJDID", SqlDbType.Int,4),
					new SqlParameter("@CID", SqlDbType.VarChar,50),
					new SqlParameter("@JDID", SqlDbType.Int,4),
					new SqlParameter("@XMID", SqlDbType.Int,4),
					new SqlParameter("@userid", SqlDbType.Int,4),
					new SqlParameter("@LRRQ", SqlDbType.DateTime),
					new SqlParameter("@status", SqlDbType.Int,4)};
			parameters[0].Value = model.username;
			parameters[1].Value = model.roleid;
			parameters[2].Value = model.rolename;
			parameters[3].Value = model.CZR;
			parameters[4].Value = model.REMARK;
			parameters[5].Value = model.KHJDID;
			parameters[6].Value = model.CID;
			parameters[7].Value = model.JDID;
			parameters[8].Value = model.XMID;
			parameters[9].Value = model.userid;
			parameters[10].Value = model.LRRQ;
			parameters[11].Value = model.status;

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
		public bool Delete(int KHJDID,string CID,int JDID,int XMID,int userid,DateTime LRRQ,int status)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from KHJD_LIST_VIEW_LIST_person ");
			strSql.Append(" where KHJDID=@KHJDID and CID=@CID and JDID=@JDID and XMID=@XMID and userid=@userid and LRRQ=@LRRQ and status=@status ");
			SqlParameter[] parameters = {
					new SqlParameter("@KHJDID", SqlDbType.Int,4),
					new SqlParameter("@CID", SqlDbType.VarChar,50),
					new SqlParameter("@JDID", SqlDbType.Int,4),
					new SqlParameter("@XMID", SqlDbType.Int,4),
					new SqlParameter("@userid", SqlDbType.Int,4),
					new SqlParameter("@LRRQ", SqlDbType.DateTime),
					new SqlParameter("@status", SqlDbType.Int,4)			};
			parameters[0].Value = KHJDID;
			parameters[1].Value = CID;
			parameters[2].Value = JDID;
			parameters[3].Value = XMID;
			parameters[4].Value = userid;
			parameters[5].Value = LRRQ;
			parameters[6].Value = status;

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
		public XHD.Model.KHJD_LIST_VIEW_LIST_person GetModel(int KHJDID,string CID,int JDID,int XMID,int userid,DateTime LRRQ,int status)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 KHJDID,CID,JDID,XMID,userid,username,roleid,rolename,CZR,REMARK,LRRQ,status from KHJD_LIST_VIEW_LIST_person ");
			strSql.Append(" where KHJDID=@KHJDID and CID=@CID and JDID=@JDID and XMID=@XMID and userid=@userid and LRRQ=@LRRQ and status=@status ");
			SqlParameter[] parameters = {
					new SqlParameter("@KHJDID", SqlDbType.Int,4),
					new SqlParameter("@CID", SqlDbType.VarChar,50),
					new SqlParameter("@JDID", SqlDbType.Int,4),
					new SqlParameter("@XMID", SqlDbType.Int,4),
					new SqlParameter("@userid", SqlDbType.Int,4),
					new SqlParameter("@LRRQ", SqlDbType.DateTime),
					new SqlParameter("@status", SqlDbType.Int,4)			};
			parameters[0].Value = KHJDID;
			parameters[1].Value = CID;
			parameters[2].Value = JDID;
			parameters[3].Value = XMID;
			parameters[4].Value = userid;
			parameters[5].Value = LRRQ;
			parameters[6].Value = status;

			XHD.Model.KHJD_LIST_VIEW_LIST_person model=new XHD.Model.KHJD_LIST_VIEW_LIST_person();
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
		public XHD.Model.KHJD_LIST_VIEW_LIST_person DataRowToModel(DataRow row)
		{
			XHD.Model.KHJD_LIST_VIEW_LIST_person model=new XHD.Model.KHJD_LIST_VIEW_LIST_person();
			if (row != null)
			{
				if(row["KHJDID"]!=null && row["KHJDID"].ToString()!="")
				{
					model.KHJDID=int.Parse(row["KHJDID"].ToString());
				}
				if(row["CID"]!=null)
				{
					model.CID=row["CID"].ToString();
				}
				if(row["JDID"]!=null && row["JDID"].ToString()!="")
				{
					model.JDID=int.Parse(row["JDID"].ToString());
				}
				if(row["XMID"]!=null && row["XMID"].ToString()!="")
				{
					model.XMID=int.Parse(row["XMID"].ToString());
				}
				if(row["userid"]!=null && row["userid"].ToString()!="")
				{
					model.userid=int.Parse(row["userid"].ToString());
				}
				if(row["username"]!=null)
				{
					model.username=row["username"].ToString();
				}
				if(row["roleid"]!=null && row["roleid"].ToString()!="")
				{
					model.roleid=int.Parse(row["roleid"].ToString());
				}
				if(row["rolename"]!=null)
				{
					model.rolename=row["rolename"].ToString();
				}
				if(row["CZR"]!=null)
				{
					model.CZR=row["CZR"].ToString();
				}
				if(row["REMARK"]!=null)
				{
					model.REMARK=row["REMARK"].ToString();
				}
				if(row["LRRQ"]!=null && row["LRRQ"].ToString()!="")
				{
					model.LRRQ=DateTime.Parse(row["LRRQ"].ToString());
				}
				if(row["status"]!=null && row["status"].ToString()!="")
				{
					model.status=int.Parse(row["status"].ToString());
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
			strSql.Append("select KHJDID,CID,JDID,XMID,userid,username,roleid,rolename,CZR,REMARK,LRRQ,status ");
			strSql.Append(" FROM KHJD_LIST_VIEW_LIST_person ");
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
			strSql.Append(" KHJDID,CID,JDID,XMID,userid,username,roleid,rolename,CZR,REMARK,LRRQ,status ");
			strSql.Append(" FROM KHJD_LIST_VIEW_LIST_person ");
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
			strSql.Append("select count(1) FROM KHJD_LIST_VIEW_LIST_person ");
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
				strSql.Append("order by T.status desc");
			}
			strSql.Append(")AS Row, T.*  from KHJD_LIST_VIEW_LIST_person T ");
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
			parameters[0].Value = "KHJD_LIST_VIEW_LIST_person";
			parameters[1].Value = "status";
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

