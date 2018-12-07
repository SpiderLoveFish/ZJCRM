using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Financial_Change_Cost
	/// </summary>
	public partial class Financial_Change_Cost
	{
		public Financial_Change_Cost()
		{}
		#region  BasicMethod

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(string F_Num)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Financial_Change_Cost");
			strSql.Append(" where F_Num=@F_Num ");
			SqlParameter[] parameters = {
					new SqlParameter("@F_Num", SqlDbType.VarChar,20)			};
			parameters[0].Value = F_Num;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.Financial_Change_Cost model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Financial_Change_Cost(");
			strSql.Append("F_Num,F_StyleID,F_StyleName,cwny,Amount,RelevantPerson,Remarks,FromWhere,CreatePerson,CreateTime,IsStatus,DeleteTime,Pay_type_id,Pay_type)");
			strSql.Append(" values (");
			strSql.Append("@F_Num,@F_StyleID,@F_StyleName,@cwny,@Amount,@RelevantPerson,@Remarks,@FromWhere,@CreatePerson,@CreateTime,@IsStatus,@DeleteTime,@Pay_type_id,@Pay_type)");
			SqlParameter[] parameters = {
					new SqlParameter("@F_Num", SqlDbType.VarChar,20),
					new SqlParameter("@F_StyleID", SqlDbType.Int,4),
					new SqlParameter("@F_StyleName", SqlDbType.VarChar,50),
					new SqlParameter("@cwny", SqlDbType.VarChar,6),
					new SqlParameter("@Amount", SqlDbType.Decimal,9),
					new SqlParameter("@RelevantPerson", SqlDbType.VarChar,20),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
					new SqlParameter("@FromWhere", SqlDbType.VarChar,10),
					new SqlParameter("@CreatePerson", SqlDbType.VarChar,20),
					new SqlParameter("@CreateTime", SqlDbType.DateTime),
					new SqlParameter("@IsStatus", SqlDbType.Char,1),
					new SqlParameter("@DeleteTime", SqlDbType.DateTime),
                    new SqlParameter("@Pay_type_id", SqlDbType.Int,4),
                    new SqlParameter("@Pay_type", SqlDbType.VarChar,50)
            };
			parameters[0].Value = model.F_Num;
			parameters[1].Value = model.F_StyleID;
			parameters[2].Value = model.F_StyleName;
			parameters[3].Value = model.cwny;
			parameters[4].Value = model.Amount;
			parameters[5].Value = model.RelevantPerson;
			parameters[6].Value = model.Remarks;
			parameters[7].Value = model.FromWhere;
			parameters[8].Value = model.CreatePerson;
			parameters[9].Value = model.CreateTime;
			parameters[10].Value = model.IsStatus;
			parameters[11].Value = model.DeleteTime;
            parameters[12].Value = model.Pay_type_id;
            parameters[13].Value = model.Pay_type;

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
		public bool Update(XHD.Model.Financial_Change_Cost model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Financial_Change_Cost set ");
			strSql.Append("F_StyleID=@F_StyleID,");
			strSql.Append("F_StyleName=@F_StyleName,");
			strSql.Append("cwny=@cwny,");
			strSql.Append("Amount=@Amount,");
			strSql.Append("RelevantPerson=@RelevantPerson,");
			strSql.Append("Remarks=@Remarks,"); 
			strSql.Append("IsStatus=@IsStatus, ");
            strSql.Append("Pay_type_id=@Pay_type_id,");
            strSql.Append("Pay_type=@Pay_type ");
            strSql.Append(" where F_Num=@F_Num ");
			SqlParameter[] parameters = {
					new SqlParameter("@F_StyleID", SqlDbType.Int,4),
					new SqlParameter("@F_StyleName", SqlDbType.VarChar,50),
					new SqlParameter("@cwny", SqlDbType.VarChar,6),
					new SqlParameter("@Amount", SqlDbType.Decimal,9),
					new SqlParameter("@RelevantPerson", SqlDbType.VarChar,20),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
					new SqlParameter("@FromWhere", SqlDbType.VarChar,10),
					new SqlParameter("@CreatePerson", SqlDbType.VarChar,20),
					new SqlParameter("@CreateTime", SqlDbType.DateTime),
					new SqlParameter("@IsStatus", SqlDbType.Char,1),
					new SqlParameter("@DeleteTime", SqlDbType.DateTime),
                     new SqlParameter("@Pay_type_id", SqlDbType.Int,4),
                    new SqlParameter("@Pay_type", SqlDbType.VarChar,50),
                    new SqlParameter("@F_Num", SqlDbType.VarChar,20)};
			parameters[0].Value = model.F_StyleID;
			parameters[1].Value = model.F_StyleName;
			parameters[2].Value = model.cwny;
			parameters[3].Value = model.Amount;
			parameters[4].Value = model.RelevantPerson;
			parameters[5].Value = model.Remarks;
			parameters[6].Value = model.FromWhere;
			parameters[7].Value = model.CreatePerson;
			parameters[8].Value = model.CreateTime;
			parameters[9].Value = model.IsStatus;
			parameters[10].Value = model.DeleteTime;
            parameters[11].Value = model.Pay_type_id;
            parameters[12].Value = model.Pay_type;
            parameters[13].Value = model.F_Num;

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
		public bool Delete(string F_Num)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Financial_Change_Cost ");
			strSql.Append(" where F_Num=@F_Num ");
			SqlParameter[] parameters = {
					new SqlParameter("@F_Num", SqlDbType.VarChar,20)			};
			parameters[0].Value = F_Num;

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
		public bool DeleteList(string F_Numlist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Financial_Change_Cost ");
			strSql.Append(" where F_Num in ("+F_Numlist + ")  ");
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
		public XHD.Model.Financial_Change_Cost GetModel(string F_Num)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 F_Num,F_StyleID,F_StyleName,cwny,Amount,RelevantPerson,Remarks,FromWhere,CreatePerson,CreateTime,IsStatus,DeleteTime,Pay_type_id,Pay_type from Financial_Change_Cost ");
			strSql.Append(" where F_Num=@F_Num ");
			SqlParameter[] parameters = {
					new SqlParameter("@F_Num", SqlDbType.VarChar,20)			};
			parameters[0].Value = F_Num;

			XHD.Model.Financial_Change_Cost model=new XHD.Model.Financial_Change_Cost();
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
		public XHD.Model.Financial_Change_Cost DataRowToModel(DataRow row)
		{
			XHD.Model.Financial_Change_Cost model=new XHD.Model.Financial_Change_Cost();
			if (row != null)
			{
				if(row["F_Num"]!=null)
				{
					model.F_Num=row["F_Num"].ToString();
				}
				if(row["F_StyleID"]!=null && row["F_StyleID"].ToString()!="")
				{
					model.F_StyleID=int.Parse(row["F_StyleID"].ToString());
				}
				if(row["F_StyleName"]!=null)
				{
					model.F_StyleName=row["F_StyleName"].ToString();
				}
				if(row["cwny"]!=null)
				{
					model.cwny=row["cwny"].ToString();
				}
				if(row["Amount"]!=null && row["Amount"].ToString()!="")
				{
					model.Amount=decimal.Parse(row["Amount"].ToString());
				}
				if(row["RelevantPerson"]!=null)
				{
					model.RelevantPerson=row["RelevantPerson"].ToString();
				}
				if(row["Remarks"]!=null)
				{
					model.Remarks=row["Remarks"].ToString();
				}
				if(row["FromWhere"]!=null)
				{
					model.FromWhere=row["FromWhere"].ToString();
				}
				if(row["CreatePerson"]!=null)
				{
					model.CreatePerson=row["CreatePerson"].ToString();
				}
				if(row["CreateTime"]!=null && row["CreateTime"].ToString()!="")
				{
					model.CreateTime=DateTime.Parse(row["CreateTime"].ToString());
				}
				if(row["IsStatus"]!=null)
				{
					model.IsStatus=row["IsStatus"].ToString();
				}
				if(row["DeleteTime"]!=null && row["DeleteTime"].ToString()!="")
				{
					model.DeleteTime=DateTime.Parse(row["DeleteTime"].ToString());
				}
                if (row["Pay_type_id"] != null && row["Pay_type_id"].ToString() != "")
                {
                    model.Pay_type_id = int.Parse(row["Pay_type_id"].ToString());
                }
                if (row["Pay_type"] != null && row["Pay_type"].ToString() != "")
                {
                    model.Pay_type =  row["Pay_type"].ToString() ;
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
			strSql.Append("select F_Num,F_StyleID,F_StyleName,cwny,Amount,RelevantPerson,Remarks,FromWhere,CreatePerson,CreateTime,IsStatus,DeleteTime,Pay_type_id,Pay_type ");
			strSql.Append(" FROM Financial_Change_Cost ");
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
			strSql.Append(" F_Num,F_StyleID,F_StyleName,cwny,Amount,RelevantPerson,Remarks,FromWhere,CreatePerson,CreateTime,IsStatus,DeleteTime ,Pay_type_id,Pay_type");
			strSql.Append(" FROM Financial_Change_Cost ");
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
			strSql.Append("select count(1) FROM Financial_Change_Cost ");
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
				strSql.Append("order by T.F_Num desc");
			}
			strSql.Append(")AS Row, T.*  from Financial_Change_Cost T ");
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
			parameters[0].Value = "Financial_Change_Cost";
			parameters[1].Value = "F_Num";
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
        public DataSet GetListPage(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  * from Financial_Change_Cost");
            strSql.Append(" WHERE ( F_Num not in ( SELECT top " + (PageIndex - 1) * PageSize + " F_Num FROM CRM_Customer  ");
            if (filedOrder != "  F_Num  desc")
            {
                strSql.Append(" where " + strWhere + " order by " + filedOrder + " ,F_Num desc) )");
            }
            else
            {
                strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) )");
            };


            strSql1.Append(" select count(F_Num) FROM Financial_Change_Cost  ");
             if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            if (filedOrder != "  F_Num  desc")
            {
                strSql.Append(" ,id desc ");
            };
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }
        public string GetMaxID(string per)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" SELECT dbo.[f_NextSerializeID]('" + per + "')");

            DataSet ds = DbHelperSQL.Query(strSql.ToString());
            return ds.Tables[0].Rows[0][0].ToString();
        }

        #endregion  ExtensionMethod
    }
}

