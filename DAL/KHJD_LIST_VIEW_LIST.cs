using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:KHJD_LIST_VIEW_LIST
	/// </summary>
	public partial class KHJD_LIST_VIEW_LIST
	{
		public KHJD_LIST_VIEW_LIST()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("KHJDID", "KHJD_LIST_VIEW_LIST"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int KHJDID,string CID,int JDID,int XMID,DateTime LRRQ,int status)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from KHJD_LIST_VIEW_LIST");
			strSql.Append(" where KHJDID=@KHJDID and CID=@CID and JDID=@JDID and XMID=@XMID and LRRQ=@LRRQ and status=@status ");
			SqlParameter[] parameters = {
					new SqlParameter("@KHJDID", SqlDbType.Int,4),
					new SqlParameter("@CID", SqlDbType.VarChar,50),
					new SqlParameter("@JDID", SqlDbType.Int,4),
					new SqlParameter("@XMID", SqlDbType.Int,4),
					new SqlParameter("@LRRQ", SqlDbType.DateTime),
					new SqlParameter("@status", SqlDbType.Int,4)			};
			parameters[0].Value = KHJDID;
			parameters[1].Value = CID;
			parameters[2].Value = JDID;
			parameters[3].Value = XMID;
			parameters[4].Value = LRRQ;
			parameters[5].Value = status;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.KHJD_LIST_VIEW_LIST model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into KHJD_LIST_VIEW_LIST(");
			strSql.Append("KHJDID,CID,Cpro,Ccity,JDID,JDMC,XMID,XMMC,REMARK,LRRQ,JDYS,Cname,CZR,Cmob,status)");
			strSql.Append(" values (");
			strSql.Append("@KHJDID,@CID,@Cpro,@Ccity,@JDID,@JDMC,@XMID,@XMMC,@REMARK,@LRRQ,@JDYS,@Cname,@CZR,@Cmob,@status)");
			SqlParameter[] parameters = {
					new SqlParameter("@KHJDID", SqlDbType.Int,4),
					new SqlParameter("@CID", SqlDbType.VarChar,50),
					new SqlParameter("@Cpro", SqlDbType.VarChar,20),
					new SqlParameter("@Ccity", SqlDbType.VarChar,20),
					new SqlParameter("@JDID", SqlDbType.Int,4),
					new SqlParameter("@JDMC", SqlDbType.VarChar,50),
					new SqlParameter("@XMID", SqlDbType.Int,4),
					new SqlParameter("@XMMC", SqlDbType.VarChar,50),
					new SqlParameter("@REMARK", SqlDbType.VarChar,500),
					new SqlParameter("@LRRQ", SqlDbType.DateTime),
					new SqlParameter("@JDYS", SqlDbType.VarChar,50),
					new SqlParameter("@Cname", SqlDbType.VarChar,200),
					new SqlParameter("@CZR", SqlDbType.VarChar,50),
					new SqlParameter("@Cmob", SqlDbType.VarChar,100),
					new SqlParameter("@status", SqlDbType.Int,4)};
			parameters[0].Value = model.KHJDID;
			parameters[1].Value = model.CID;
			parameters[2].Value = model.Cpro;
			parameters[3].Value = model.Ccity;
			parameters[4].Value = model.JDID;
			parameters[5].Value = model.JDMC;
			parameters[6].Value = model.XMID;
			parameters[7].Value = model.XMMC;
			parameters[8].Value = model.REMARK;
			parameters[9].Value = model.LRRQ;
			parameters[10].Value = model.JDYS;
			parameters[11].Value = model.Cname;
			parameters[12].Value = model.CZR;
			parameters[13].Value = model.Cmob;
			parameters[14].Value = model.status;

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
		public bool Update(XHD.Model.KHJD_LIST_VIEW_LIST model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update KHJD_LIST_VIEW_LIST set ");
			strSql.Append("Cpro=@Cpro,");
			strSql.Append("Ccity=@Ccity,");
			strSql.Append("JDMC=@JDMC,");
			strSql.Append("XMMC=@XMMC,");
			strSql.Append("REMARK=@REMARK,");
			strSql.Append("JDYS=@JDYS,");
			strSql.Append("Cname=@Cname,");
			strSql.Append("CZR=@CZR,");
			strSql.Append("Cmob=@Cmob");
			strSql.Append(" where KHJDID=@KHJDID and CID=@CID and JDID=@JDID and XMID=@XMID and LRRQ=@LRRQ and status=@status ");
			SqlParameter[] parameters = {
					new SqlParameter("@Cpro", SqlDbType.VarChar,20),
					new SqlParameter("@Ccity", SqlDbType.VarChar,20),
					new SqlParameter("@JDMC", SqlDbType.VarChar,50),
					new SqlParameter("@XMMC", SqlDbType.VarChar,50),
					new SqlParameter("@REMARK", SqlDbType.VarChar,500),
					new SqlParameter("@JDYS", SqlDbType.VarChar,50),
					new SqlParameter("@Cname", SqlDbType.VarChar,200),
					new SqlParameter("@CZR", SqlDbType.VarChar,50),
					new SqlParameter("@Cmob", SqlDbType.VarChar,100),
					new SqlParameter("@KHJDID", SqlDbType.Int,4),
					new SqlParameter("@CID", SqlDbType.VarChar,50),
					new SqlParameter("@JDID", SqlDbType.Int,4),
					new SqlParameter("@XMID", SqlDbType.Int,4),
					new SqlParameter("@LRRQ", SqlDbType.DateTime),
					new SqlParameter("@status", SqlDbType.Int,4)};
			parameters[0].Value = model.Cpro;
			parameters[1].Value = model.Ccity;
			parameters[2].Value = model.JDMC;
			parameters[3].Value = model.XMMC;
			parameters[4].Value = model.REMARK;
			parameters[5].Value = model.JDYS;
			parameters[6].Value = model.Cname;
			parameters[7].Value = model.CZR;
			parameters[8].Value = model.Cmob;
			parameters[9].Value = model.KHJDID;
			parameters[10].Value = model.CID;
			parameters[11].Value = model.JDID;
			parameters[12].Value = model.XMID;
			parameters[13].Value = model.LRRQ;
			parameters[14].Value = model.status;

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
		public bool Delete(int KHJDID,string CID,int JDID,int XMID,DateTime LRRQ,int status)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from KHJD_LIST_VIEW_LIST ");
			strSql.Append(" where KHJDID=@KHJDID and CID=@CID and JDID=@JDID and XMID=@XMID and LRRQ=@LRRQ and status=@status ");
			SqlParameter[] parameters = {
					new SqlParameter("@KHJDID", SqlDbType.Int,4),
					new SqlParameter("@CID", SqlDbType.VarChar,50),
					new SqlParameter("@JDID", SqlDbType.Int,4),
					new SqlParameter("@XMID", SqlDbType.Int,4),
					new SqlParameter("@LRRQ", SqlDbType.DateTime),
					new SqlParameter("@status", SqlDbType.Int,4)			};
			parameters[0].Value = KHJDID;
			parameters[1].Value = CID;
			parameters[2].Value = JDID;
			parameters[3].Value = XMID;
			parameters[4].Value = LRRQ;
			parameters[5].Value = status;

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
		public XHD.Model.KHJD_LIST_VIEW_LIST GetModel(int KHJDID,string CID,int JDID,int XMID,DateTime LRRQ,int status)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 KHJDID,CID,Cpro,Ccity,JDID,JDMC,XMID,XMMC,REMARK,LRRQ,JDYS,Cname,CZR,Cmob,status from KHJD_LIST_VIEW_LIST ");
			strSql.Append(" where KHJDID=@KHJDID and CID=@CID and JDID=@JDID and XMID=@XMID and LRRQ=@LRRQ and status=@status ");
			SqlParameter[] parameters = {
					new SqlParameter("@KHJDID", SqlDbType.Int,4),
					new SqlParameter("@CID", SqlDbType.VarChar,50),
					new SqlParameter("@JDID", SqlDbType.Int,4),
					new SqlParameter("@XMID", SqlDbType.Int,4),
					new SqlParameter("@LRRQ", SqlDbType.DateTime),
					new SqlParameter("@status", SqlDbType.Int,4)			};
			parameters[0].Value = KHJDID;
			parameters[1].Value = CID;
			parameters[2].Value = JDID;
			parameters[3].Value = XMID;
			parameters[4].Value = LRRQ;
			parameters[5].Value = status;

			XHD.Model.KHJD_LIST_VIEW_LIST model=new XHD.Model.KHJD_LIST_VIEW_LIST();
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
		public XHD.Model.KHJD_LIST_VIEW_LIST DataRowToModel(DataRow row)
		{
			XHD.Model.KHJD_LIST_VIEW_LIST model=new XHD.Model.KHJD_LIST_VIEW_LIST();
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
				if(row["Cpro"]!=null)
				{
					model.Cpro=row["Cpro"].ToString();
				}
				if(row["Ccity"]!=null)
				{
					model.Ccity=row["Ccity"].ToString();
				}
				if(row["JDID"]!=null && row["JDID"].ToString()!="")
				{
					model.JDID=int.Parse(row["JDID"].ToString());
				}
				if(row["JDMC"]!=null)
				{
					model.JDMC=row["JDMC"].ToString();
				}
				if(row["XMID"]!=null && row["XMID"].ToString()!="")
				{
					model.XMID=int.Parse(row["XMID"].ToString());
				}
				if(row["XMMC"]!=null)
				{
					model.XMMC=row["XMMC"].ToString();
				}
				if(row["REMARK"]!=null)
				{
					model.REMARK=row["REMARK"].ToString();
				}
				if(row["LRRQ"]!=null && row["LRRQ"].ToString()!="")
				{
					model.LRRQ=DateTime.Parse(row["LRRQ"].ToString());
				}
				if(row["JDYS"]!=null)
				{
					model.JDYS=row["JDYS"].ToString();
				}
				if(row["Cname"]!=null)
				{
					model.Cname=row["Cname"].ToString();
				}
				if(row["CZR"]!=null)
				{
					model.CZR=row["CZR"].ToString();
				}
				if(row["Cmob"]!=null)
				{
					model.Cmob=row["Cmob"].ToString();
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
			strSql.Append("select KHJDID,CID,Cpro,Ccity,JDID,JDMC,XMID,XMMC,REMARK,LRRQ,JDYS,Cname,CZR,Cmob,status ");
			strSql.Append(" FROM KHJD_LIST_VIEW_LIST ");
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
			strSql.Append(" KHJDID,CID,Cpro,Ccity,JDID,JDMC,XMID,XMMC,REMARK,LRRQ,JDYS,Cname,CZR,Cmob,status ");
			strSql.Append(" FROM KHJD_LIST_VIEW_LIST ");
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
			strSql.Append("select count(1) FROM KHJD_LIST_VIEW_LIST ");
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
			strSql.Append(")AS Row, T.*  from KHJD_LIST_VIEW_LIST T ");
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
			parameters[0].Value = "KHJD_LIST_VIEW_LIST";
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
        public bool UpdateData( )
        {
            StringBuilder strSql = new StringBuilder();
         strSql.AppendLine("  UPDATE A SET XMMC=B.XMMC,JDYS=C.JDYS ");
           strSql.AppendLine("  FROM dbo.KHJD_LIST_VIEW_LIST A");
         strSql.AppendLine("   INNER JOIN  dbo.Xm_list B ON A.XMID=B.XMID");
         strSql.AppendLine("  INNER JOIN dbo.JD_list C ON A.JDID=C.JDID");
         strSql.AppendLine(" WHERE ISNULL(A.XMMC,'')='' OR ISNULL(A.JDYS,'')=''");
           
           strSql.AppendLine("  UPDATE A SET username=B.name");
       strSql.AppendLine("  FROM dbo.KHJD_LIST_VIEW_LIST_person A");
       strSql.AppendLine(" INNER JOIN  dbo.hr_employee B ON	A.userid=B.id");
       strSql.AppendLine("  WHERE name=''");
            
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
        /// 获得数据列表
        /// </summary>
        public DataSet GetDetailList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            //strSql.Append("select KHJDID,CID,Cpro,Ccity,JDID,JDMC,XMID,XMMC,REMARK,LRRQ,JDYS,Cname,CZR,Cmob,status ");
            //strSql.Append(" FROM KHJD_LIST_VIEW_LIST ");
            strSql.Append("  SELECT DISTINCT CID,KHJDID,LRRQ,REMARK,JDMC,");
          strSql.Append("  dbo.F_GetString(CID,KHJDID,'P') AS ry ,");
          strSql.Append("  dbo.F_GetString(CID,KHJDID,'M')  AS xmmc");
          strSql.Append("   FROM KHJD_LIST_VIEW_LIST");
         //strSql.Append("   WHERE cid=2 AND KHJDID=2
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetLastList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            //strSql.Append("select KHJDID,CID,Cpro,Ccity,JDID,JDMC,XMID,XMMC,REMARK,LRRQ,JDYS,Cname,CZR,Cmob,status ");
            //strSql.Append(" FROM KHJD_LIST_VIEW_LIST ");
            strSql.Append(" SELECT A.* FROM KHJD_LIST_VIEW_LIST A  ");
           strSql.Append(" INNER JOIN   ");
          strSql.Append("  ( ");
           strSql.Append(" SELECT DISTINCT  XMID,MAX(LRRQ) lrrq ");
           strSql.Append("  FROM  dbo.KHJD_LIST_VIEW_LIST  ");
           if (strWhere.Trim() != "")
           {
               strSql.Append(" where " + strWhere);
           }
          strSql.Append("   GROUP BY XMID ");
          strSql.Append("  )B ON A.LRRQ = B.lrrq AND A.XMID = B.XMID ");

            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }


		#endregion  ExtensionMethod
	}
}

