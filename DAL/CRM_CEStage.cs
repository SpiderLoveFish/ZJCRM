using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace xhd.DAL
{
	/// <summary>
	/// 数据访问类:CRM_CEStage
	/// </summary>
	public partial class CRM_CEStage
	{
		public CRM_CEStage()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("CstomerID", "CRM_CEStage"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int CstomerID,int EmpID,int StageID)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from CRM_CEStage");
			strSql.Append(" where CstomerID=@CstomerID and EmpID=@EmpID and StageID=@StageID ");
			SqlParameter[] parameters = {
					new SqlParameter("@CstomerID", SqlDbType.Int,4),
					new SqlParameter("@EmpID", SqlDbType.Int,4),
					new SqlParameter("@StageID", SqlDbType.Int,4)			};
			parameters[0].Value = CstomerID;
			parameters[1].Value = EmpID;
			parameters[2].Value = StageID;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(xhd.Model.CRM_CEStage model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into CRM_CEStage(");
			strSql.Append("CstomerID,EmpID,StageID,StageDescription,Stage_icon,isdelete,deleteid,deletetime,EmpIDs,StageScore,SpecialScore)");
			strSql.Append(" values (");
			strSql.Append("@CstomerID,@EmpID,@StageID,@StageDescription,@Stage_icon,@isdelete,@deleteid,@deletetime,@EmpIDs,@StageScore,@SpecialScore)");
			SqlParameter[] parameters = {
					new SqlParameter("@CstomerID", SqlDbType.Int,4),
					new SqlParameter("@EmpID", SqlDbType.Int,4),
					new SqlParameter("@StageID", SqlDbType.Int,4),
					new SqlParameter("@StageDescription", SqlDbType.VarChar,200),
					new SqlParameter("@Stage_icon", SqlDbType.VarChar,200),
					new SqlParameter("@isdelete", SqlDbType.Int,4),
					new SqlParameter("@deleteid", SqlDbType.Int,4),
					new SqlParameter("@deletetime", SqlDbType.DateTime),
					new SqlParameter("@EmpIDs", SqlDbType.VarChar,200),
					new SqlParameter("@StageScore", SqlDbType.Decimal,9),
					new SqlParameter("@SpecialScore", SqlDbType.Decimal,9)};
			parameters[0].Value = model.CstomerID;
			parameters[1].Value = model.EmpID;
			parameters[2].Value = model.StageID;
			parameters[3].Value = model.StageDescription;
			parameters[4].Value = model.Stage_icon;
			parameters[5].Value = model.isdelete;
			parameters[6].Value = model.deleteid;
			parameters[7].Value = model.deletetime;
			parameters[8].Value = model.EmpIDs;
			parameters[9].Value = model.StageScore;
			parameters[10].Value = model.SpecialScore;

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
		public bool Update(xhd.Model.CRM_CEStage model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update CRM_CEStage set ");
			strSql.Append("StageDescription=@StageDescription,");
			strSql.Append("Stage_icon=@Stage_icon,");
			strSql.Append("isdelete=@isdelete,");
			strSql.Append("deleteid=@deleteid,");
			strSql.Append("deletetime=@deletetime,");
			strSql.Append("EmpIDs=@EmpIDs,");
			strSql.Append("StageScore=@StageScore,");
			strSql.Append("SpecialScore=@SpecialScore");
			strSql.Append(" where CstomerID=@CstomerID and EmpID=@EmpID and StageID=@StageID ");
			SqlParameter[] parameters = {
					new SqlParameter("@StageDescription", SqlDbType.VarChar,200),
					new SqlParameter("@Stage_icon", SqlDbType.VarChar,200),
					new SqlParameter("@isdelete", SqlDbType.Int,4),
					new SqlParameter("@deleteid", SqlDbType.Int,4),
					new SqlParameter("@deletetime", SqlDbType.DateTime),
					new SqlParameter("@EmpIDs", SqlDbType.VarChar,200),
					new SqlParameter("@StageScore", SqlDbType.Decimal,9),
					new SqlParameter("@SpecialScore", SqlDbType.Decimal,9),
					new SqlParameter("@CstomerID", SqlDbType.Int,4),
					new SqlParameter("@EmpID", SqlDbType.Int,4),
					new SqlParameter("@StageID", SqlDbType.Int,4)};
			parameters[0].Value = model.StageDescription;
			parameters[1].Value = model.Stage_icon;
			parameters[2].Value = model.isdelete;
			parameters[3].Value = model.deleteid;
			parameters[4].Value = model.deletetime;
			parameters[5].Value = model.EmpIDs;
			parameters[6].Value = model.StageScore;
			parameters[7].Value = model.SpecialScore;
			parameters[8].Value = model.CstomerID;
			parameters[9].Value = model.EmpID;
			parameters[10].Value = model.StageID;

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
		public bool Delete(int CstomerID,int EmpID,int StageID)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from CRM_CEStage ");
			strSql.Append(" where CstomerID=@CstomerID and EmpID=@EmpID and StageID=@StageID ");
			SqlParameter[] parameters = {
					new SqlParameter("@CstomerID", SqlDbType.Int,4),
					new SqlParameter("@EmpID", SqlDbType.Int,4),
					new SqlParameter("@StageID", SqlDbType.Int,4)			};
			parameters[0].Value = CstomerID;
			parameters[1].Value = EmpID;
			parameters[2].Value = StageID;

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
		public xhd.Model.CRM_CEStage GetModel(int CstomerID,int EmpID,int StageID)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 CstomerID,EmpID,StageID,StageDescription,Stage_icon,isdelete,deleteid,deletetime,EmpIDs,StageScore,SpecialScore from CRM_CEStage ");
			strSql.Append(" where CstomerID=@CstomerID and EmpID=@EmpID and StageID=@StageID ");
			SqlParameter[] parameters = {
					new SqlParameter("@CstomerID", SqlDbType.Int,4),
					new SqlParameter("@EmpID", SqlDbType.Int,4),
					new SqlParameter("@StageID", SqlDbType.Int,4)			};
			parameters[0].Value = CstomerID;
			parameters[1].Value = EmpID;
			parameters[2].Value = StageID;

			xhd.Model.CRM_CEStage model=new xhd.Model.CRM_CEStage();
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
		public xhd.Model.CRM_CEStage DataRowToModel(DataRow row)
		{
			xhd.Model.CRM_CEStage model=new xhd.Model.CRM_CEStage();
			if (row != null)
			{
				if(row["CstomerID"]!=null && row["CstomerID"].ToString()!="")
				{
					model.CstomerID=int.Parse(row["CstomerID"].ToString());
				}
				if(row["EmpID"]!=null && row["EmpID"].ToString()!="")
				{
					model.EmpID=int.Parse(row["EmpID"].ToString());
				}
				if(row["StageID"]!=null && row["StageID"].ToString()!="")
				{
					model.StageID=int.Parse(row["StageID"].ToString());
				}
				if(row["StageDescription"]!=null)
				{
					model.StageDescription=row["StageDescription"].ToString();
				}
				if(row["Stage_icon"]!=null)
				{
					model.Stage_icon=row["Stage_icon"].ToString();
				}
				if(row["isdelete"]!=null && row["isdelete"].ToString()!="")
				{
					model.isdelete=int.Parse(row["isdelete"].ToString());
				}
				if(row["deleteid"]!=null && row["deleteid"].ToString()!="")
				{
					model.deleteid=int.Parse(row["deleteid"].ToString());
				}
				if(row["deletetime"]!=null && row["deletetime"].ToString()!="")
				{
					model.deletetime=DateTime.Parse(row["deletetime"].ToString());
				}
				if(row["EmpIDs"]!=null)
				{
					model.EmpIDs=row["EmpIDs"].ToString();
				}
				if(row["StageScore"]!=null && row["StageScore"].ToString()!="")
				{
					model.StageScore=decimal.Parse(row["StageScore"].ToString());
				}
				if(row["SpecialScore"]!=null && row["SpecialScore"].ToString()!="")
				{
					model.SpecialScore=decimal.Parse(row["SpecialScore"].ToString());
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
			strSql.Append("select CstomerID,EmpID,StageID,StageDescription,Stage_icon,isdelete,deleteid,deletetime,EmpIDs,StageScore,SpecialScore ");
			strSql.Append(" FROM CRM_CEStage ");
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
			strSql.Append(" CstomerID,EmpID,StageID,StageDescription,Stage_icon,isdelete,deleteid,deletetime,EmpIDs,StageScore,SpecialScore ");
			strSql.Append(" FROM CRM_CEStage ");
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
			strSql.Append("select count(1) FROM CRM_CEStage ");
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
				strSql.Append("order by T.StageID desc");
			}
			strSql.Append(")AS Row, T.*  from CRM_CEStage T ");
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
			parameters[0].Value = "CRM_CEStage";
			parameters[1].Value = "StageID";
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

