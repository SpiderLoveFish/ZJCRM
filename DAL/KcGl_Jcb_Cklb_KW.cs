using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:KcGl_Jcb_Cklb_KW
	/// </summary>
	public partial class KcGl_Jcb_Cklb_KW
	{
		public KcGl_Jcb_Cklb_KW()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("CklbID", "KcGl_Jcb_Cklb_KW"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(string KWID,int CklbID)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from KcGl_Jcb_Cklb_KW");
			strSql.Append(" where KWID=@KWID and CklbID=@CklbID ");
			SqlParameter[] parameters = {
					new SqlParameter("@KWID", SqlDbType.VarChar,20),
					new SqlParameter("@CklbID", SqlDbType.Int,4)			};
			parameters[0].Value = KWID;
			parameters[1].Value = CklbID;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.KcGl_Jcb_Cklb_KW model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into KcGl_Jcb_Cklb_KW(");
			strSql.Append("KWID,CklbID,Name,Lxrid,Lxr,Lxrdh,Remark,InEmpID,InDate,EditEmpID,EditDate,IsDel,DelEmpID,DelDate)");
			strSql.Append(" values (");
			strSql.Append("@KWID,@CklbID,@Name,@Lxrid,@Lxr,@Lxrdh,@Remark,@InEmpID,@InDate,@EditEmpID,@EditDate,@IsDel,@DelEmpID,@DelDate)");
			SqlParameter[] parameters = {
					new SqlParameter("@KWID", SqlDbType.VarChar,20),
					new SqlParameter("@CklbID", SqlDbType.Int,4),
					new SqlParameter("@Name", SqlDbType.NVarChar,50),
					new SqlParameter("@Lxrid", SqlDbType.Int,4),
					new SqlParameter("@Lxr", SqlDbType.VarChar,50),
					new SqlParameter("@Lxrdh", SqlDbType.VarChar,50),
					new SqlParameter("@Remark", SqlDbType.NVarChar,500),
					new SqlParameter("@InEmpID", SqlDbType.SmallInt,2),
					new SqlParameter("@InDate", SqlDbType.DateTime),
					new SqlParameter("@EditEmpID", SqlDbType.SmallInt,2),
					new SqlParameter("@EditDate", SqlDbType.DateTime),
					new SqlParameter("@IsDel", SqlDbType.Char,1),
					new SqlParameter("@DelEmpID", SqlDbType.SmallInt,2),
					new SqlParameter("@DelDate", SqlDbType.DateTime)};
			parameters[0].Value = model.KWID;
			parameters[1].Value = model.CklbID;
			parameters[2].Value = model.Name;
			parameters[3].Value = model.Lxrid;
			parameters[4].Value = model.Lxr;
			parameters[5].Value = model.Lxrdh;
			parameters[6].Value = model.Remark;
			parameters[7].Value = model.InEmpID;
			parameters[8].Value = model.InDate;
			parameters[9].Value = model.EditEmpID;
			parameters[10].Value = model.EditDate;
			parameters[11].Value = model.IsDel;
			parameters[12].Value = model.DelEmpID;
			parameters[13].Value = model.DelDate;

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
		public bool Update(XHD.Model.KcGl_Jcb_Cklb_KW model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update KcGl_Jcb_Cklb_KW set ");
			strSql.Append("Name=@Name,");
			strSql.Append("Lxrid=@Lxrid,");
			strSql.Append("Lxr=@Lxr,");
			strSql.Append("Lxrdh=@Lxrdh,");
			strSql.Append("Remark=@Remark,");
			strSql.Append("InEmpID=@InEmpID,");
			strSql.Append("InDate=@InDate,");
			strSql.Append("EditEmpID=@EditEmpID,");
			strSql.Append("EditDate=@EditDate,");
			strSql.Append("IsDel=@IsDel,");
			strSql.Append("DelEmpID=@DelEmpID,");
			strSql.Append("DelDate=@DelDate");
			strSql.Append(" where KWID=@KWID and CklbID=@CklbID ");
			SqlParameter[] parameters = {
					new SqlParameter("@Name", SqlDbType.NVarChar,50),
					new SqlParameter("@Lxrid", SqlDbType.Int,4),
					new SqlParameter("@Lxr", SqlDbType.VarChar,50),
					new SqlParameter("@Lxrdh", SqlDbType.VarChar,50),
					new SqlParameter("@Remark", SqlDbType.NVarChar,500),
					new SqlParameter("@InEmpID", SqlDbType.SmallInt,2),
					new SqlParameter("@InDate", SqlDbType.DateTime),
					new SqlParameter("@EditEmpID", SqlDbType.SmallInt,2),
					new SqlParameter("@EditDate", SqlDbType.DateTime),
					new SqlParameter("@IsDel", SqlDbType.Char,1),
					new SqlParameter("@DelEmpID", SqlDbType.SmallInt,2),
					new SqlParameter("@DelDate", SqlDbType.DateTime),
					new SqlParameter("@KWID", SqlDbType.VarChar,20),
					new SqlParameter("@CklbID", SqlDbType.Int,4)};
			parameters[0].Value = model.Name;
			parameters[1].Value = model.Lxrid;
			parameters[2].Value = model.Lxr;
			parameters[3].Value = model.Lxrdh;
			parameters[4].Value = model.Remark;
			parameters[5].Value = model.InEmpID;
			parameters[6].Value = model.InDate;
			parameters[7].Value = model.EditEmpID;
			parameters[8].Value = model.EditDate;
			parameters[9].Value = model.IsDel;
			parameters[10].Value = model.DelEmpID;
			parameters[11].Value = model.DelDate;
			parameters[12].Value = model.KWID;
			parameters[13].Value = model.CklbID;

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
		public bool Delete(string KWID,int CklbID)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from KcGl_Jcb_Cklb_KW ");
			strSql.Append(" where KWID=@KWID and CklbID=@CklbID ");
			SqlParameter[] parameters = {
					new SqlParameter("@KWID", SqlDbType.VarChar,20),
					new SqlParameter("@CklbID", SqlDbType.Int,4)			};
			parameters[0].Value = KWID;
			parameters[1].Value = CklbID;

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

        public bool UpdateDel(string KWID, int CklbID,string isdel)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("update from KcGl_Jcb_Cklb_KW set IsDel='" + isdel + "' ");
            strSql.Append(" where KWID=@KWID and CklbID=@CklbID ");
            SqlParameter[] parameters = {
					new SqlParameter("@KWID", SqlDbType.VarChar,20),
					new SqlParameter("@CklbID", SqlDbType.Int,4)			};
            parameters[0].Value = KWID;
            parameters[1].Value = CklbID;

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
		/// 得到一个对象实体
		/// </summary>
		public XHD.Model.KcGl_Jcb_Cklb_KW GetModel(string KWID,int CklbID)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 KWID,CklbID,Name,Lxrid,Lxr,Lxrdh,Remark,InEmpID,InDate,EditEmpID,EditDate,IsDel,DelEmpID,DelDate from KcGl_Jcb_Cklb_KW ");
			strSql.Append(" where KWID=@KWID and CklbID=@CklbID ");
			SqlParameter[] parameters = {
					new SqlParameter("@KWID", SqlDbType.VarChar,20),
					new SqlParameter("@CklbID", SqlDbType.Int,4)			};
			parameters[0].Value = KWID;
			parameters[1].Value = CklbID;

			XHD.Model.KcGl_Jcb_Cklb_KW model=new XHD.Model.KcGl_Jcb_Cklb_KW();
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
		public XHD.Model.KcGl_Jcb_Cklb_KW DataRowToModel(DataRow row)
		{
			XHD.Model.KcGl_Jcb_Cklb_KW model=new XHD.Model.KcGl_Jcb_Cklb_KW();
			if (row != null)
			{
				if(row["KWID"]!=null)
				{
					model.KWID=row["KWID"].ToString();
				}
				if(row["CklbID"]!=null && row["CklbID"].ToString()!="")
				{
					model.CklbID=int.Parse(row["CklbID"].ToString());
				}
				if(row["Name"]!=null)
				{
					model.Name=row["Name"].ToString();
				}
				if(row["Lxrid"]!=null && row["Lxrid"].ToString()!="")
				{
					model.Lxrid=int.Parse(row["Lxrid"].ToString());
				}
				if(row["Lxr"]!=null)
				{
					model.Lxr=row["Lxr"].ToString();
				}
				if(row["Lxrdh"]!=null)
				{
					model.Lxrdh=row["Lxrdh"].ToString();
				}
				if(row["Remark"]!=null)
				{
					model.Remark=row["Remark"].ToString();
				}
				if(row["InEmpID"]!=null && row["InEmpID"].ToString()!="")
				{
					model.InEmpID=int.Parse(row["InEmpID"].ToString());
				}
				if(row["InDate"]!=null && row["InDate"].ToString()!="")
				{
					model.InDate=DateTime.Parse(row["InDate"].ToString());
				}
				if(row["EditEmpID"]!=null && row["EditEmpID"].ToString()!="")
				{
					model.EditEmpID=int.Parse(row["EditEmpID"].ToString());
				}
				if(row["EditDate"]!=null && row["EditDate"].ToString()!="")
				{
					model.EditDate=DateTime.Parse(row["EditDate"].ToString());
				}
				if(row["IsDel"]!=null)
				{
					model.IsDel=row["IsDel"].ToString();
				}
				if(row["DelEmpID"]!=null && row["DelEmpID"].ToString()!="")
				{
					model.DelEmpID=int.Parse(row["DelEmpID"].ToString());
				}
				if(row["DelDate"]!=null && row["DelDate"].ToString()!="")
				{
					model.DelDate=DateTime.Parse(row["DelDate"].ToString());
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
			strSql.Append("select KWID,CklbID,Name,Lxrid,Lxr,Lxrdh,Remark,InEmpID,InDate,EditEmpID,EditDate,IsDel,DelEmpID,DelDate ");
			strSql.Append(" FROM KcGl_Jcb_Cklb_KW ");
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
			strSql.Append(" KWID,CklbID,Name,Lxrid,Lxr,Lxrdh,Remark,InEmpID,InDate,EditEmpID,EditDate,IsDel,DelEmpID,DelDate ");
			strSql.Append(" FROM KcGl_Jcb_Cklb_KW ");
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
			strSql.Append("select count(1) FROM KcGl_Jcb_Cklb_KW ");
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
				strSql.Append("order by T.CklbID desc");
			}
			strSql.Append(")AS Row, T.*  from KcGl_Jcb_Cklb_KW T ");
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
			parameters[0].Value = "KcGl_Jcb_Cklb_KW";
			parameters[1].Value = "CklbID";
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
            strSql.Append(" top " + PageSize + " * FROM(  ");
            strSql.Append(" SELECT ROW_NUMBER() over(order by KWID) as id,A.*,B.Name AS CKNAME,B.Address FROM dbo.KcGl_Jcb_Cklb_KW A ");
            strSql.Append("  INNER JOIN  dbo.KcGl_Jcb_Cklb B ON  A.CklbID=B.ID )A");
            strSql.Append(" WHERE A.id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM( ");
            strSql.Append(" SELECT ROW_NUMBER() over(order by KWID) as id,A.*,B.Name AS CKNAME,B.Address FROM dbo.KcGl_Jcb_Cklb_KW A ");
            strSql.Append("  INNER JOIN  dbo.KcGl_Jcb_Cklb B ON  A.CklbID=B.ID )A");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM ( ");
            strSql1.Append(" SELECT ROW_NUMBER() over(order by KWID) as id,A.*,B.Name AS CKNAME,B.Address FROM dbo.KcGl_Jcb_Cklb_KW A ");
            strSql1.Append("  INNER JOIN  dbo.KcGl_Jcb_Cklb B ON  A.CklbID=B.ID )A");
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

