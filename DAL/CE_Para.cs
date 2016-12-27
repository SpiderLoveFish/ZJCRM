using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;


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
        public DataSet GetSingleSignOnList(string strWhere,string host)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("select [appkey],");
            sb.AppendLine("	[appSecret],");
            sb.AppendLine("	[timestamp],");
            sb.AppendLine("   B.uid+'@'+'" + host + "'  as	[appuid] ,");
            sb.AppendLine("	[sign] ,");
            sb.AppendLine("	B.name as [appuname] ,");
            sb.AppendLine("	B.uid+'@'+'" + host + "' as [appuemail] ,");
            sb.AppendLine("	B.tel as [appuphone] ,");
            sb.AppendLine("	[appussn] ,");
            sb.AppendLine("	[appuAddr],");
            sb.AppendLine("	[appuavatar],");
            sb.AppendLine("	A.[id] ,");
            sb.AppendLine("	[api]");
            sb.AppendLine("	 from [dbo].[T_SingleSignOn]  A");
            sb.AppendLine("INNER JOIN [dbo].[hr_employee] B on 1=1");
            //sb.AppendLine("where B.uid='admin'");
            if (strWhere.Trim() != "")
            {
                sb.AppendLine(" where " + strWhere);
            }
            return DbHelperSQL.Query(sb.ToString());
        }


        public bool Addkjl_api(string des, int cid, string fpid, string DyGraphicsName, string imgtype, string simg, string img, string pano, string DP, int DPID, string remarks)
        {
            var sb = new System.Text.StringBuilder();
            //先有户型图
            sb.AppendLine("IF EXISTS( SELECT 1 FROM dbo.kjl_api WHERE	curstomerid=" + cid + " AND fpId='" + fpid + "')");
            sb.AppendLine("BEGIN");
            sb.AppendLine("");
            if (des != "")
            {
                sb.AppendLine(" UPDATE dbo.kjl_api ");
                sb.AppendLine("   SET  ");
                sb.AppendLine("           desid='" + des + "' ");
                sb.AppendLine(" WHERE  curstomerid = " + cid + "  ");
                sb.AppendLine("        AND  fpId= '" + fpid + "'  ");
                
            }
            sb.AppendLine(" UPDATE dbo.kjl_api ");
            sb.AppendLine("   SET  ");
            if (DyGraphicsName != "")
            sb.AppendLine("          DyGraphicsName= '" + DyGraphicsName + "' , "); 
            if (imgtype != "")
                sb.AppendLine("          imgtype= '" + imgtype + "' , ");
            if (simg != "")
                sb.AppendLine("          simg='" + simg + "'  , ");
            if (img != "")
                sb.AppendLine("          img ='" + img + "', ");
            if (pano != "")
                sb.AppendLine("          pano= '" + pano + "', ");
            sb.AppendLine("          dotime=getdate() ");
            sb.AppendLine("          ");
            sb.AppendLine(" WHERE  curstomerid = " + cid + "  ");
            if (fpid != "")
                sb.AppendLine("        AND  fpId= '" + fpid + "'  ");
            if (des != "")
                sb.AppendLine("       and     desid='" + des + "'  ");
            sb.AppendLine("END");
            sb.AppendLine("ELSE	");
            sb.AppendLine("BEGIN");
            sb.AppendLine("INSERT INTO dbo.kjl_api ");
            sb.AppendLine("        ( curstomerid , ");
            sb.AppendLine("          desid , ");
            sb.AppendLine("          fpId , ");
            sb.AppendLine("          imgtype , ");
            sb.AppendLine("          simg , ");
            sb.AppendLine("          img , ");
            sb.AppendLine("          pano,DyGraphicsName,DoPerson,DoPersonID,remarks ");
            sb.AppendLine("        ) ");
            sb.AppendLine("VALUES  ( "+cid+" , -- curstomerid - int ");
            sb.AppendLine("          '"+des+"' , -- desid - varchar(20) ");
            sb.AppendLine("          '"+fpid+"' , -- fpId - varchar(20) ");
            sb.AppendLine("          '" + imgtype + "' , -- imgtype - varchar(20) ");
            sb.AppendLine("          '" + simg + "' , -- simg - varchar(200) ");
            sb.AppendLine("          '" + img + "' , -- img - varchar(200) ");
            sb.AppendLine("          '" + pano + "','" + DyGraphicsName + "','" + DP + "'," + DPID + ",'" + remarks + "'  -- pano - varchar(200) ");
            sb.AppendLine("        ) ");
            sb.AppendLine(" END ");
            SqlParameter[] parameters = {
                                       };
            int rows = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }


        public bool Updatekjl_api(string des, int cid, string fpid,string DyGraphicsName, string imgtype, string simg, string img, string pano)
        {
            var sb = new System.Text.StringBuilder();
            if (des != "")
            {
                sb.AppendLine(" UPDATE dbo.kjl_api ");
                sb.AppendLine("   SET  ");
                sb.AppendLine("           desid='" + des + "' ");
                sb.AppendLine(" WHERE  curstomerid = " + cid + "  ");
                sb.AppendLine("        AND  fpId= '" + fpid + "'  ");
            }
            sb.AppendLine(" UPDATE dbo.kjl_api ");
            sb.AppendLine("   SET  ");
            if (DyGraphicsName != "")
            sb.AppendLine("          DyGraphicsName= '" + DyGraphicsName + "' , ");            
            if (imgtype != "")
            sb.AppendLine("          imgtype= '" + imgtype + "' , ");
            if (simg != "")
            sb.AppendLine("          simg='" + simg + "'  , ");
            if (img != "")
            sb.AppendLine("          img ='" + img + "', ");
            if (pano != "")
            sb.AppendLine("          pano= '" + pano + "', ");
            sb.AppendLine("          dotime=getdate() ");
            sb.AppendLine("          ");
            sb.AppendLine(" WHERE  curstomerid = " + cid + "  ");
            if (des != "")
            {
                sb.AppendLine("       AND   desid='" + des + "' ");
            }
            sb.AppendLine("        AND  fpId= '" + fpid + "'  ");
            sb.AppendLine("        ");

            SqlParameter[] parameters = {
                                       };
            int rows = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public bool Updatekjl_api_name( string fpid, string DyGraphicsName)
        {
            var sb = new System.Text.StringBuilder();
           
        
            sb.AppendLine(" UPDATE dbo.kjl_api ");
            sb.AppendLine("   SET  ");
           
                sb.AppendLine("          DyGraphicsName= '" + DyGraphicsName + "' , ");
            
            sb.AppendLine("          dotime=getdate() ");
           
            sb.AppendLine("        where  fpId= '" + fpid + "'  ");
            sb.AppendLine("        ");

            SqlParameter[] parameters = {
                                       };
            int rows = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }


        public bool deletekjl_api(string des, int cid, string fpid)
        {

            string sql = "  DELETE	dbo.kjl_api WHERE curstomerid=" + cid + " " +
            "";
            if (des != "")
                sql = sql + " and desid='"+des+"'";
            if (fpid != "")
                sql = sql + " and fpId='" + fpid + "'";
            //不能2个都为空啊
            if (des == "" && fpid == "")
                sql = "";
                    SqlParameter[] parameters = {
                                       };
            int rows = DbHelperSQL.ExecuteSql(sql, parameters);
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
        public DataSet Getkjl_api_list(string strWhere,string uid)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select   ");
            strSql.AppendLine("curstomerid ,");
            strSql.AppendLine("          desid ,");
            strSql.AppendLine("          fpId ,");
            strSql.AppendLine("          imgtype ,");
            strSql.AppendLine("          simg ,");
            strSql.AppendLine("          img ,");
            strSql.AppendLine("          pano ,");
            strSql.AppendLine("          dotime ,");
            strSql.AppendLine("          DyGraphicsName ,");
            strSql.AppendLine("          isnull(remarks,'') as Remarks ,");
            strSql.AppendLine("          DoPerson ,");
            strSql.AppendLine("          DoPersonID");
            strSql.Append(" ,case when DoPerson='" + uid + "' then 1 else 0 end as ismy");
            strSql.Append(" FROM kjl_api ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" ORDER BY  dotime DESC");
            return DbHelperSQL.Query(strSql.ToString());
        }
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetListkjl_api(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM kjl_api");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM kjl_api ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM  kjl_api");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }


        public bool Addkjl_list_text(string uid, int style, string userid, string text, string remarks)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine(" delete dbo.kjl_list_text  where uid='"+uid+"' and DoStyle="+style+"");
            sb.AppendLine("INSERT INTO dbo.kjl_list_text ");
            sb.AppendLine("        ( userid , ");
            sb.AppendLine("          uid , ");
            sb.AppendLine("          text , ");
            sb.AppendLine("          dotime , ");
            sb.AppendLine("          IsUse , ");
            sb.AppendLine("          DoStyle , ");
            sb.AppendLine("          Remarks ");
            sb.AppendLine("        ) ");
            sb.AppendLine("VALUES  ( '"+userid+"' , -- userid - varchar(50) ");
            sb.AppendLine("          '"+uid+"' , -- uid - varchar(20) ");
            sb.AppendLine("          '"+text+"' , -- text - text ");
            sb.AppendLine("          getdate() , -- dotime - datetime ");
            sb.AppendLine("          'N' , -- IsUse - char(1) ");
            sb.AppendLine("          "+style+" , -- DoStyle - int ");
            sb.AppendLine("          '"+remarks+"'  -- Remarks - varchar(100) ");
            sb.AppendLine("        ) ");
            sb.AppendLine(" ");
            sb.AppendLine(" ");
            sb.AppendLine(" ");
            SqlParameter[] parameters = {
                                       };
            int rows = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
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
        public DataSet GetPrint_list(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * ");
            strSql.Append(" ");
            strSql.Append(" FROM Budge_Print_list ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }


        /// <summary>
        /// 配置API
        /// </summary>
        public DataSet GetAPI_KEY(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * ");
            strSql.Append(" ");
            strSql.Append(" FROM API_KEY ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }


        public bool Addkjl_account_list(string uid, int style, string userid, string text, string remarks)
        {

            JArray ja = (JArray)JsonConvert.DeserializeObject(text);
          
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("");
            sb.AppendLine("DELETE	dbo.kjl_account_list WHERE uid='" + uid + "'");
            foreach(var ja1 in ja)
            {
                JObject o = (JObject)ja1;
                sb.AppendLine("INSERT INTO dbo.kjl_account_list");
                sb.AppendLine("        ( userid ,");
                sb.AppendLine("          uid ,");
                sb.AppendLine("          obsPlanId ,");
                sb.AppendLine("          planCity ,");
                sb.AppendLine("          commName ,");
                sb.AppendLine("          area ,");
                sb.AppendLine("          name ,");
                sb.AppendLine("          srcArea ,");
                sb.AppendLine("          modifiedTime ,");
                sb.AppendLine("          pics ,");
                sb.AppendLine("          smallPics ,");
                sb.AppendLine("          created ,");
                sb.AppendLine("          dotime ,");
                sb.AppendLine("          DoStyle");
                sb.AppendLine("        )");
                sb.AppendLine("VALUES  ( '" + userid + "' ,"); // userid - varchar(50)
                sb.AppendLine("         '" + uid + "' ,"); // uid - varchar(20)
                sb.AppendLine("          '" + o["obsPlanId"].Value<string>() + "' ,"); // obsPlanId - varchar(20)
                sb.AppendLine("          '" + o["planCity"].Value<string>() + "' ,"); // planCity - varchar(300)
                sb.AppendLine("         '" + o["commName"].Value<string>() + "'  ,"); // commName - varchar(300)
                try
                {
                    if (o["area"].Value<string>() == null)
                        sb.AppendLine("           " + 0 + " ,");
                    else
                        sb.AppendLine("           " + o["area"].Value<string>() + " ,"); // area - decimal
                    if (o["name"].Value<string>() == null)
                        sb.AppendLine("           '' ,");
                    else
                        sb.AppendLine("          '" + o["name"].Value<string>() + "' ,"); // name - varchar(300)
                    if (o["srcArea"].Value<string>() == null)
                        sb.AppendLine("           " + 0 + " ,");
                    else
                        sb.AppendLine("          " + o["srcArea"].Value<string>() + " ,"); // srcArea - float
                }
                catch {
                    sb.AppendLine("           " + 0 + " ,");
                    sb.AppendLine("           '' ,");
                    sb.AppendLine("           " + 0 + " ,");
                }
                sb.AppendLine("          '" + GetTime(o["modifiedTime"].ToString()) + "' ,"); // modifiedTime - datetime
                sb.AppendLine("          '" + o["pics"].Value<string>() + "' ,"); // pics - varchar(300)
                sb.AppendLine("          '" + o["smallPics"].Value<string>() + "' ,"); // smallPics - varchar(300)
                sb.AppendLine("          '" + GetTime(o["created"].ToString()) + "' ,"); // created - datetime
                sb.AppendLine("          getdate() ,"); // dotime - datetime
                sb.AppendLine("          " + style + ""); // DoStyle - int
                sb.AppendLine("        )");
            }
            

            SqlParameter[] parameters = {
                                       };
            int rows = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
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
        public DataSet GetDS_kjl_account_list(string strWhere)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("SELECT   * FROM ");
            sb.AppendLine("dbo.kjl_account_list");
            //sb.AppendLine("where B.uid='admin'");
            if (strWhere.Trim() != "")
            {
                sb.AppendLine(" where " + strWhere);
            }
 		sb.AppendLine(" order by modifiedtime desc");
            return DbHelperSQL.Query(sb.ToString());
        }


        /// <summary>
        /// 时间戳转为C#格式时间
        /// </summary>
        /// <param name="timeStamp">Unix时间戳格式</param>
        /// <returns>C#格式时间</returns>
        public static DateTime GetTime(string timeStamp)
        {
            DateTime dtStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
            long lTime = long.Parse(timeStamp + "0000");
            TimeSpan toNow = new TimeSpan(lTime);
            return dtStart.Add(toNow);
        }

		#endregion  ExtensionMethod
	}
}

