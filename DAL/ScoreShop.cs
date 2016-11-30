using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:ScoreShop
	/// </summary>
	public partial class ScoreShop
	{
		public ScoreShop()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "ScoreShop"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from ScoreShop");
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
		public int Add(XHD.Model.ScoreShop model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into ScoreShop(");
			strSql.Append("ScoreName,ScoreDescribe,NeedScore,img,thumimg,TotalSum,RemainSum,DoTime)");
			strSql.Append(" values (");
			strSql.Append("@ScoreName,@ScoreDescribe,@NeedScore,@img,@thumimg,@TotalSum,@RemainSum,@DoTime)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@ScoreName", SqlDbType.VarChar,50),
					new SqlParameter("@ScoreDescribe", SqlDbType.VarChar,250),
					new SqlParameter("@NeedScore", SqlDbType.Int,4),
					new SqlParameter("@img", SqlDbType.VarChar,100),
					new SqlParameter("@thumimg", SqlDbType.VarChar,100),
					new SqlParameter("@TotalSum", SqlDbType.Int,4),
					new SqlParameter("@RemainSum", SqlDbType.Int,4),
					new SqlParameter("@DoTime", SqlDbType.DateTime)};
			parameters[0].Value = model.ScoreName;
			parameters[1].Value = model.ScoreDescribe;
			parameters[2].Value = model.NeedScore;
			parameters[3].Value = model.img;
			parameters[4].Value = model.thumimg;
			parameters[5].Value = model.TotalSum;
			parameters[6].Value = model.RemainSum;
			parameters[7].Value = model.DoTime;

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
		public bool Update(XHD.Model.ScoreShop model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update ScoreShop set ");
			strSql.Append("ScoreName=@ScoreName,");
			strSql.Append("ScoreDescribe=@ScoreDescribe,");
			strSql.Append("NeedScore=@NeedScore,");
			strSql.Append("img=@img,");
			strSql.Append("thumimg=@thumimg,");
			strSql.Append("TotalSum=@TotalSum,");
			strSql.Append("RemainSum=@RemainSum,");
			strSql.Append("DoTime=@DoTime");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@ScoreName", SqlDbType.VarChar,50),
					new SqlParameter("@ScoreDescribe", SqlDbType.VarChar,250),
					new SqlParameter("@NeedScore", SqlDbType.Int,4),
					new SqlParameter("@img", SqlDbType.VarChar,100),
					new SqlParameter("@thumimg", SqlDbType.VarChar,100),
					new SqlParameter("@TotalSum", SqlDbType.Int,4),
					new SqlParameter("@RemainSum", SqlDbType.Int,4),
					new SqlParameter("@DoTime", SqlDbType.DateTime),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.ScoreName;
			parameters[1].Value = model.ScoreDescribe;
			parameters[2].Value = model.NeedScore;
			parameters[3].Value = model.img;
			parameters[4].Value = model.thumimg;
			parameters[5].Value = model.TotalSum;
			parameters[6].Value = model.RemainSum;
			parameters[7].Value = model.DoTime;
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
			strSql.Append("delete from ScoreShop ");
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
			strSql.Append("delete from ScoreShop ");
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
		public XHD.Model.ScoreShop GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,ScoreName,ScoreDescribe,NeedScore,img,thumimg,TotalSum,RemainSum,DoTime from ScoreShop ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.ScoreShop model=new XHD.Model.ScoreShop();
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
		public XHD.Model.ScoreShop DataRowToModel(DataRow row)
		{
			XHD.Model.ScoreShop model=new XHD.Model.ScoreShop();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["ScoreName"]!=null)
				{
					model.ScoreName=row["ScoreName"].ToString();
				}
				if(row["ScoreDescribe"]!=null)
				{
					model.ScoreDescribe=row["ScoreDescribe"].ToString();
				}
				if(row["NeedScore"]!=null && row["NeedScore"].ToString()!="")
				{
					model.NeedScore=int.Parse(row["NeedScore"].ToString());
				}
				if(row["img"]!=null)
				{
					model.img=row["img"].ToString();
				}
				if(row["thumimg"]!=null)
				{
					model.thumimg=row["thumimg"].ToString();
				}
				if(row["TotalSum"]!=null && row["TotalSum"].ToString()!="")
				{
					model.TotalSum=int.Parse(row["TotalSum"].ToString());
				}
				if(row["RemainSum"]!=null && row["RemainSum"].ToString()!="")
				{
					model.RemainSum=int.Parse(row["RemainSum"].ToString());
				}
				if(row["DoTime"]!=null && row["DoTime"].ToString()!="")
				{
					model.DoTime=DateTime.Parse(row["DoTime"].ToString());
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
			strSql.Append("select id,ScoreName,ScoreDescribe,NeedScore,img,thumimg,TotalSum,RemainSum,DoTime ");
			strSql.Append(" FROM ScoreShop ");
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
			strSql.Append(" id,ScoreName,ScoreDescribe,NeedScore,img,thumimg,TotalSum,RemainSum,DoTime ");
			strSql.Append(" FROM ScoreShop ");
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
			strSql.Append("select count(1) FROM ScoreShop ");
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
			strSql.Append(")AS Row, T.*  from ScoreShop T ");
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
			parameters[0].Value = "ScoreShop";
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
        /// 分页获取数据列表动态图
        /// </summary>
        public DataSet GetList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  *  FROM dbo.ScoreShop ");
            strSql.Append(" WHERE  id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM ScoreShop ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM ScoreShop ");
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

