using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:JD_list
	/// </summary>
	public partial class CE_Para
	{
        public CE_Para()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "JD_list"); 
		}

        /// <summary>
        /// 得到最大GetMaxVerId
        /// </summary>
        public int GetMaxVerId(string StageID, string pid, string style)
        {
            StringBuilder strSql = new StringBuilder();
            if (style == "add")
                strSql.Append("select max(versions)+1 from JD_list where stageid=" + StageID + " and projectid=" + pid);
            else if (style == "edit")
                strSql.Append("select max(versions) from JD_list where stageid=" + StageID + " and projectid=" + pid);

            object obj = DbHelperSQL.GetSingle(strSql.ToString());
            if (obj == null)
            {
                return 1;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from JD_list");
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
        public bool ExistsChecked(int StageID, int pid, int verid)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from JD_list");
            strSql.Append(" where    projectid=@pid AND StageID=@sid AND versions=@verid");
            SqlParameter[] parameters = {
					new SqlParameter("@pid", SqlDbType.Int,4),
                    new SqlParameter("@sid", SqlDbType.Int,4),
                    new SqlParameter("@verid", SqlDbType.Int,4)
			};
            parameters[0].Value = pid ;
            parameters[1].Value = StageID;
            parameters[2].Value = verid;
            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }



		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(string name,int px,string color,string remarks)
		{
			StringBuilder strSql=new StringBuilder();
           
		 
       strSql.AppendLine(" INSERT INTO dbo.JD_list ");
         strSql.AppendLine("   ( JDMC, JDPX, JDYS, REMARK )");
        strSql.AppendLine(" VALUES  ( '"+name+"', -- JDMC - varchar(50)");
        strSql.AppendLine("  "+px+", -- JDPX - int");
        strSql.AppendLine("  '" + color + "', -- JDYS - varchar(50)");
        strSql.AppendLine(" '" + remarks + "')  -- REMARK - varchar(150)");
           
			object obj = DbHelperSQL.GetSingle(strSql.ToString(),null);
			if (obj == null)
			{
				return 0;
			}
			else
			{
				return Convert.ToInt32(obj);
			}
		}


        public bool Update(int JDID,string name, int px, string color, string remarks)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" update JD_list set");
            strSql.Append(" JDMC='" + name + "',");
            strSql.Append(" JDPX =" + px + ",");
            strSql.Append("  REMARK='" + remarks + "',");
            strSql.Append(" JDYS='" + color + "' ");
            strSql.Append("  where JDID="+JDID+"");

            SqlParameter[] parameters = {
                                       };
            int rows = DbHelperSQL.ExecuteSql(strSql.ToString(),parameters);
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
			strSql.Append("delete from JD_list ");
			strSql.Append(" where JDID=@id");
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
        /// 删除一条数据
        /// </summary>
        public bool Delete(int sid,int pid,int vid)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from JD_list ");
            strSql.Append(" WHERE projectid=@pid AND StageID=@sid AND versions=@vid");
            SqlParameter[] parameters = {
					new SqlParameter("@sid", SqlDbType.Int,4),
                    new SqlParameter("@pid", SqlDbType.Int,4),
                    new SqlParameter("@vid", SqlDbType.Int,4)
			};
            parameters[0].Value = sid;
            parameters[1].Value = pid;
            parameters[2].Value = vid;

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
			strSql.Append("delete from JD_list ");
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
        //public XHD.Model.JD_list GetModel(int id)
        //{
			
        //    StringBuilder strSql=new StringBuilder();
        //    strSql.Append("select  top 1 id,projectid,versions,StageID,AssTime,isChecked,AssDescription,IsClose from JD_list ");
        //    strSql.Append(" where id=@id");
        //    SqlParameter[] parameters = {
        //            new SqlParameter("@id", SqlDbType.Int,4)
        //    };
        //    parameters[0].Value = id;

        //    XHD.Model.JD_list model=new XHD.Model.JD_list();
        //    DataSet ds=DbHelperSQL.Query(strSql.ToString(),parameters);
        //    if(ds.Tables[0].Rows.Count>0)
        //    {
        //        return DataRowToModel(ds.Tables[0].Rows[0]);
        //    }
        //    else
        //    {
        //        return null;
        //    }
        //}


		/// <summary>
		/// 得到一个对象实体
		/// </summary>
        //public XHD.Model.JD_list DataRowToModel(DataRow row)
        //{
        //    XHD.Model.JD_list model=new XHD.Model.JD_list();
        //    if (row != null)
        //    {
        //        if(row["id"]!=null && row["id"].ToString()!="")
        //        {
        //            model.id=int.Parse(row["id"].ToString());
        //        }
        //        if(row["projectid"]!=null && row["projectid"].ToString()!="")
        //        {
        //            model.projectid=int.Parse(row["projectid"].ToString());
        //        }
        //        if(row["versions"]!=null && row["versions"].ToString()!="")
        //        {
        //            model.versions=int.Parse(row["versions"].ToString());
        //        }
        //        if(row["StageID"]!=null && row["StageID"].ToString()!="")
        //        {
        //            model.StageID=int.Parse(row["StageID"].ToString());
        //        }
        //        if(row["AssTime"]!=null && row["AssTime"].ToString()!="")
        //        {
        //            model.AssTime = decimal.Parse(row["AssTime"].ToString());
        //        }
        //        if(row["isChecked"]!=null && row["isChecked"].ToString()!="")
        //        {
        //            if((row["isChecked"].ToString()=="1")||(row["isChecked"].ToString().ToLower()=="true"))
        //            {
        //                model.isChecked=true;
        //            }
        //            else
        //            {
        //                model.isChecked=false;
        //            }
        //        }
        //        if(row["AssDescription"]!=null)
        //        {
        //            model.AssDescription=row["AssDescription"].ToString();
        //        }
        //        if(row["IsClose"]!=null && row["IsClose"].ToString()!="")
        //        {
        //            if((row["IsClose"].ToString()=="1")||(row["IsClose"].ToString().ToLower()=="true"))
        //            {
        //                model.IsClose=true;
        //            }
        //            else
        //            {
        //                model.IsClose=false;
        //            }
        //        }
        //    }
        //    return model;
        //}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public DataSet GetList(string strWhere)
		{
			StringBuilder strSql=new StringBuilder();
            strSql.Append("select * ");
			strSql.Append(" FROM JD_list ");
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
			strSql.Append(" id,projectid,versions,StageID,AssTime,isChecked,AssDescription,IsClose ");
			strSql.Append(" FROM JD_list ");
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
			strSql.Append("select count(1) FROM JD_list ");
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
			strSql.Append(")AS Row, T.*  from JD_list T ");
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
			parameters[0].Value = "JD_list";
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
            strSql.Append(" top " + PageSize + " * FROM JD_list");
            strSql.Append(" WHERE JDID not in ( SELECT top " + (PageIndex - 1) * PageSize + " JDID FROM JD_list");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(JDID) FROM JD_list ");
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
        /// 分页获取数据列表JD_list
        /// </summary>
        public DataSet GetListJD_list(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM  JD_list ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM  JD_list ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM  JD_list ");
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
        /// 分页获取未结案数据列表
        /// </summary>
        public DataSet GetListStage(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM V_CRM_CEStage ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM CRM_CEStage ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM CRM_CEStage ");
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
        /// 获得数据列表
        /// </summary>
        public DataSet GetSingleSignOnList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * ");
            strSql.Append(" FROM T_SingleSignOn ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }


		#endregion  ExtensionMethod
	}
}

