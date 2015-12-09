using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Crm_CEDetail
	/// </summary>
	public partial class Crm_CEDetail
	{
		public Crm_CEDetail()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("StageDetailID", "Crm_CEDetail"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int StageDetailID,int AssTime)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Crm_CEDetail");
			strSql.Append(" where StageDetailID=@StageDetailID and AssTime=@AssTime ");
			SqlParameter[] parameters = {
					new SqlParameter("@StageDetailID", SqlDbType.Int,4),
					new SqlParameter("@AssTime", SqlDbType.Int,4)			};
			parameters[0].Value = StageDetailID;
			parameters[1].Value = AssTime;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(xhd.Model.Crm_CEDetail model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Crm_CEDetail(");
			strSql.Append("StageDetailID,AssTime,isChecked,AssDescription,IsClose)");
			strSql.Append(" values (");
			strSql.Append("@StageDetailID,@AssTime,@isChecked,@AssDescription,@IsClose)");
			SqlParameter[] parameters = {
					new SqlParameter("@StageDetailID", SqlDbType.Int,4),
					new SqlParameter("@AssTime", SqlDbType.Int,4),
					new SqlParameter("@isChecked", SqlDbType.Bit,1),
					new SqlParameter("@AssDescription", SqlDbType.VarChar,250),
					new SqlParameter("@IsClose", SqlDbType.Bit,1)};
			parameters[0].Value = model.StageDetailID;
			parameters[1].Value = model.AssTime;
			parameters[2].Value = model.isChecked;
			parameters[3].Value = model.AssDescription;
			parameters[4].Value = model.IsClose;

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
		public bool Update(xhd.Model.Crm_CEDetail model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Crm_CEDetail set ");
			strSql.Append("isChecked=@isChecked,");
			strSql.Append("AssDescription=@AssDescription,");
			strSql.Append("IsClose=@IsClose");
			strSql.Append(" where StageDetailID=@StageDetailID and AssTime=@AssTime ");
			SqlParameter[] parameters = {
					new SqlParameter("@isChecked", SqlDbType.Bit,1),
					new SqlParameter("@AssDescription", SqlDbType.VarChar,250),
					new SqlParameter("@IsClose", SqlDbType.Bit,1),
					new SqlParameter("@StageDetailID", SqlDbType.Int,4),
					new SqlParameter("@AssTime", SqlDbType.Int,4)};
			parameters[0].Value = model.isChecked;
			parameters[1].Value = model.AssDescription;
			parameters[2].Value = model.IsClose;
			parameters[3].Value = model.StageDetailID;
			parameters[4].Value = model.AssTime;

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
		public bool Delete(int StageDetailID,int AssTime)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Crm_CEDetail ");
			strSql.Append(" where StageDetailID=@StageDetailID and AssTime=@AssTime ");
			SqlParameter[] parameters = {
					new SqlParameter("@StageDetailID", SqlDbType.Int,4),
					new SqlParameter("@AssTime", SqlDbType.Int,4)			};
			parameters[0].Value = StageDetailID;
			parameters[1].Value = AssTime;

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
		public xhd.Model.Crm_CEDetail GetModel(int StageDetailID,int AssTime)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 StageDetailID,AssTime,isChecked,AssDescription,IsClose from Crm_CEDetail ");
			strSql.Append(" where StageDetailID=@StageDetailID and AssTime=@AssTime ");
			SqlParameter[] parameters = {
					new SqlParameter("@StageDetailID", SqlDbType.Int,4),
					new SqlParameter("@AssTime", SqlDbType.Int,4)			};
			parameters[0].Value = StageDetailID;
			parameters[1].Value = AssTime;

			xhd.Model.Crm_CEDetail model=new xhd.Model.Crm_CEDetail();
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
		public xhd.Model.Crm_CEDetail DataRowToModel(DataRow row)
		{
			xhd.Model.Crm_CEDetail model=new xhd.Model.Crm_CEDetail();
			if (row != null)
			{
				if(row["StageDetailID"]!=null && row["StageDetailID"].ToString()!="")
				{
					model.StageDetailID=int.Parse(row["StageDetailID"].ToString());
				}
				if(row["AssTime"]!=null && row["AssTime"].ToString()!="")
				{
					model.AssTime=int.Parse(row["AssTime"].ToString());
				}
				if(row["isChecked"]!=null && row["isChecked"].ToString()!="")
				{
					if((row["isChecked"].ToString()=="1")||(row["isChecked"].ToString().ToLower()=="true"))
					{
						model.isChecked=true;
					}
					else
					{
						model.isChecked=false;
					}
				}
				if(row["AssDescription"]!=null)
				{
					model.AssDescription=row["AssDescription"].ToString();
				}
				if(row["IsClose"]!=null && row["IsClose"].ToString()!="")
				{
					if((row["IsClose"].ToString()=="1")||(row["IsClose"].ToString().ToLower()=="true"))
					{
						model.IsClose=true;
					}
					else
					{
						model.IsClose=false;
					}
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
			strSql.Append("select StageDetailID,AssTime,isChecked,AssDescription,IsClose ");
			strSql.Append(" FROM Crm_CEDetail ");
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
			strSql.Append(" StageDetailID,AssTime,isChecked,AssDescription,IsClose ");
			strSql.Append(" FROM Crm_CEDetail ");
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
			strSql.Append("select count(1) FROM Crm_CEDetail ");
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
				strSql.Append("order by T.AssTime desc");
			}
			strSql.Append(")AS Row, T.*  from Crm_CEDetail T ");
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
			parameters[0].Value = "Crm_CEDetail";
			parameters[1].Value = "AssTime";
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

