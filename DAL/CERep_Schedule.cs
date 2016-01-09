using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Crm_CEDetail_Version
	/// </summary>
	public partial class CERep_Schedule
	{
        public CERep_Schedule()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "Crm_CEDetail_Version"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Crm_CEDetail_Version");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}
        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int sid, int pid, int vid)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from Crm_CEDetail_Version");
            strSql.Append(" where stageid=@sid   and version=@vid AND projectid=@pid");
            SqlParameter[] parameters = {
					new SqlParameter("@sid", SqlDbType.Int,4),
					new SqlParameter("@pid", SqlDbType.Int,4),
					new SqlParameter("@vid", SqlDbType.Int,4),
                                     };
            parameters[0].Value = sid;
            parameters[1].Value = pid;
            parameters[2].Value = vid;
        

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }

        public int UpdateCrm_CEDetail_Version(string style,int stageid,string strsdetailid,int pid,int vid)
        {
            var sb = new System.Text.StringBuilder();
            //if (style == "add")
            //{
                sb.AppendLine("DELETE Crm_CEDetail_Version WHERE projectid="+pid+" AND stageid=" + stageid + " and version=" + vid + " ");
           
                sb.AppendLine(" INSERT INTO dbo.Crm_CEDetail_Version ");
                sb.AppendLine("		          ( projectid , ");
                sb.AppendLine("		            stageid , ");
                sb.AppendLine("		            stagedetailid , ");
                sb.AppendLine("		            ischecked , ");
                sb.AppendLine("		            version ");
                sb.AppendLine("		          ) ");
                sb.AppendLine("		SELECT "+pid+", StageID,StageDetailID,0,"+vid+" ");
                sb.AppendLine("FROM  dbo.CRM_CEStageDetail  where	StageID=" + stageid + " ");
            //}
           // sb.AppendLine("UPDATE Crm_CEDetail_Version SET ischecked=0 WHERE stageid=" + stageid + " and version=" + vid + " AND projectid=" + pid + " ");
            if (strsdetailid != "")
            {
                sb.AppendLine("UPDATE dbo.Crm_CEDetail_Version SET ischecked=1 WHERE stageid=" + stageid + " and version=" + vid + " AND projectid=" + pid + "");
                sb.AppendLine("AND stagedetailid IN(" + strsdetailid + ") ");
                sb.AppendLine(" ");
            }
            sb.AppendLine(" ");
            object obj = DbHelperSQL.GetSingle(sb.ToString(), null);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

        //计算分数
        public int RunProcedureComputerSUM(int sid,int pid,int vid)
        {
            SqlParameter[] parameters = {
					new SqlParameter("@sid", SqlDbType.Int,4),
					new SqlParameter("@pid", SqlDbType.Int,4),
					new SqlParameter("@vid", SqlDbType.Int,4),
                                     };
             parameters[0].Value = sid;
			parameters[1].Value = pid;
			parameters[2].Value = vid;
            int rowaffected=0;
            DbHelperSQL.RunProcedure("USP_ComputerScore", parameters, out rowaffected);
            return rowaffected;
        }


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(XHD.Model.Crm_CEDetail_Version model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Crm_CEDetail_Version(");
			strSql.Append("projectid,stageid,stagedetailid,ischecked,version)");
			strSql.Append(" values (");
			strSql.Append("@projectid,@stageid,@stagedetailid,@ischecked,@version)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@projectid", SqlDbType.Int,4),
					new SqlParameter("@stageid", SqlDbType.Int,4),
					new SqlParameter("@stagedetailid", SqlDbType.Int,4),
					new SqlParameter("@ischecked", SqlDbType.Int,4),
					new SqlParameter("@version", SqlDbType.Int,4)};
			parameters[0].Value = model.projectid;
			parameters[1].Value = model.stageid;
			parameters[2].Value = model.stagedetailid;
			parameters[3].Value = model.ischecked;
			parameters[4].Value = model.version;

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
		public bool Update(XHD.Model.Crm_CEDetail_Version model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Crm_CEDetail_Version set ");
			strSql.Append("projectid=@projectid,");
			strSql.Append("stageid=@stageid,");
			strSql.Append("stagedetailid=@stagedetailid,");
			strSql.Append("ischecked=@ischecked,");
			strSql.Append("version=@version");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@projectid", SqlDbType.Int,4),
					new SqlParameter("@stageid", SqlDbType.Int,4),
					new SqlParameter("@stagedetailid", SqlDbType.Int,4),
					new SqlParameter("@ischecked", SqlDbType.Int,4),
					new SqlParameter("@version", SqlDbType.Int,4),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.projectid;
			parameters[1].Value = model.stageid;
			parameters[2].Value = model.stagedetailid;
			parameters[3].Value = model.ischecked;
			parameters[4].Value = model.version;
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
			strSql.Append("delete from Crm_CEDetail_Version ");
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
			strSql.Append("delete from Crm_CEDetail_Version ");
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
		public XHD.Model.Crm_CEDetail_Version GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,projectid,stageid,stagedetailid,ischecked,version from Crm_CEDetail_Version ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.Crm_CEDetail_Version model=new XHD.Model.Crm_CEDetail_Version();
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
		public XHD.Model.Crm_CEDetail_Version DataRowToModel(DataRow row)
		{
			XHD.Model.Crm_CEDetail_Version model=new XHD.Model.Crm_CEDetail_Version();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["projectid"]!=null && row["projectid"].ToString()!="")
				{
					model.projectid=int.Parse(row["projectid"].ToString());
				}
				if(row["stageid"]!=null && row["stageid"].ToString()!="")
				{
					model.stageid=int.Parse(row["stageid"].ToString());
				}
				if(row["stagedetailid"]!=null && row["stagedetailid"].ToString()!="")
				{
					model.stagedetailid=int.Parse(row["stagedetailid"].ToString());
				}
				if(row["ischecked"]!=null && row["ischecked"].ToString()!="")
				{
					model.ischecked=int.Parse(row["ischecked"].ToString());
				}
				if(row["version"]!=null && row["version"].ToString()!="")
				{
					model.version=int.Parse(row["version"].ToString());
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
			strSql.Append("select id,projectid,stageid,stagedetailid,ischecked,version ");
			strSql.Append(" FROM Crm_CEDetail_Version ");
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
			strSql.Append(" id,projectid,stageid,stagedetailid,ischecked,version ");
			strSql.Append(" FROM Crm_CEDetail_Version ");
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
			strSql.Append("select count(1) FROM Crm_CEDetail_Version ");
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
			strSql.Append(")AS Row, T.*  from Crm_CEDetail_Version T ");
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
			parameters[0].Value = "Crm_CEDetail_Version";
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
        /// 获得数据列表
        /// </summary>
        public DataSet GetListHeadCol(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  * ");
            strSql.Append(" FROM testxm ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        //public DataSet RunProcedureView_Schedule(out string Total)
        //{
        //    SqlParameter[] parameters = {
				 
        //                             };

        //    string sql = "SELECT COUNT(1) FROM testxm";
        //    DataSet ds = DbHelperSQL.RunProcedure("USP_View_Schedule", parameters, "schedule");
        //    Total = DbHelperSQL.Query(sql).Tables[0].Rows[0][0].ToString();
           
        //    return ds;
        //}

        public DataSet RunProcedureView_Schedule(out string Total)
        {
            SqlParameter[] parameters = {
					new SqlParameter("@TName", SqlDbType.Text),
                    new SqlParameter("@GColumn", SqlDbType.Text),
                    new SqlParameter("@RC", SqlDbType.Text),
                     new SqlParameter("@RCValue", SqlDbType.Text),
                      new SqlParameter("@RCValues", SqlDbType.Text),
                        new SqlParameter("@sql_where", SqlDbType.Text)
			};
            parameters[0].Value = "KHJD_LIST_VIEW_LIST";
             parameters[1].Value = "CID";
             parameters[2].Value = "XMMC";
             parameters[3].Value = "Cpro,Cname";
             parameters[4].Value = "(jdys+';项目:'+XMMC+';'+Cname+';'+remark+';'+CONVERT(VARCHAR(20),lrrq,120))";
             parameters[5].Value = "WHERE 1=1";
             string sql = "select  COUNT(1)  from (SELECT DISTINCT cid FROM OLD_XCZS.dbo.KHJD_LIST_VIEW_LIST)T	";

            var sb = new System.Text.StringBuilder();
            sb.AppendLine("EXEC dbo.USP_View_Schedule @TName = 'KHJD_LIST_VIEW_LIST', -- varchar(20) ");
            sb.AppendLine("    @GColumn = 'CID', -- varchar(20) ");
            sb.AppendLine("    @RC = 'XMMC', -- varchar(20) ");
            sb.AppendLine("	@RCValue = 'Cpro,Cname', -- varchar(20) ");
            sb.AppendLine("    @RCValues = '(jdys+'';项目:''+XMMC+'';''+Cname+'';''+remark+'';''+CONVERT(VARCHAR(20),lrrq,120))', -- varchar(20) ");
            sb.AppendLine("    @sql_where = N'WHERE 1=1' ");
            sb.AppendLine(" ");
            DataSet ds = DbHelperSQL.RunProcedure("dbo.USP_View_Schedule", 
                parameters,
                "schedule");
            Total = DbHelperSQL.Query(sql).Tables[0].Rows[0][0].ToString();

            return ds;
        }



        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetListDetail(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " *,0 as ischecked FROM (SELECT A.StageID,B.CEStage_category,A.StageDetailID,A.Description ");
             strSql.Append(" FROM  dbo.CRM_CEStageDetail A ");
             strSql.Append(" INNER JOIN  dbo.CRM_CEStage_category B ON A.StageID=B.id)Crm_CEDetail ");
             strSql.Append(" WHERE StageDetailID not in ( SELECT top " + (PageIndex - 1) * PageSize + " StageDetailID FROM (SELECT A.StageID,B.CEStage_category,A.StageDetailID,A.Description ");
             strSql.Append(" FROM  dbo.CRM_CEStageDetail A ");
             strSql.Append(" INNER JOIN  dbo.CRM_CEStage_category B ON A.StageID=B.id)Crm_CEDetail ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(StageDetailID) FROM (SELECT A.StageID,B.CEStage_category,A.StageDetailID,A.Description ");
            strSql1.Append(" FROM  dbo.CRM_CEStageDetail A ");
            strSql1.Append(" INNER JOIN  dbo.CRM_CEStage_category B ON A.StageID=B.id)Crm_CEDetail ");
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
        public DataSet GetListCEDetail_VersionDetail(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM (SELECT A.*,B.CEStage_category,C.Description FROM dbo.Crm_CEDetail_Version A ");
              strSql.Append(" INNER JOIN dbo.CRM_CEStage_category B ON A.stageid=B.id ");
              strSql.Append(" INNER JOIN  dbo.CRM_CEStageDetail C ON C.StageDetailID=A.stagedetailid AND A.stageid=C.StageID)Crm_CEDetail_Version");
              strSql.Append(" WHERE StageDetailID not in ( SELECT top " + (PageIndex - 1) * PageSize + " StageDetailID FROM (SELECT A.*,B.CEStage_category,C.Description FROM dbo.Crm_CEDetail_Version A ");
             strSql.Append(" INNER JOIN dbo.CRM_CEStage_category B ON A.stageid=B.id ");
             strSql.Append(" INNER JOIN  dbo.CRM_CEStageDetail C ON C.StageDetailID=A.stagedetailid AND A.stageid=C.StageID)Crm_CEDetail ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(StageDetailID) FROM (SELECT A.*,B.CEStage_category,C.Description FROM dbo.Crm_CEDetail_Version A ");
          strSql1.Append(" INNER JOIN dbo.CRM_CEStage_category B ON A.stageid=B.id ");
          strSql1.Append(" INNER JOIN  dbo.CRM_CEStageDetail C ON C.StageDetailID=A.stagedetailid AND A.stageid=C.StageID)Crm_CEDetail ");
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

