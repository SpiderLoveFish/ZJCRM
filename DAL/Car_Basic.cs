using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Car_Basic
	/// </summary>
	public partial class Car_Basic
	{
		public Car_Basic()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "Car_Basic"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Car_Basic");
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
		public int Add(XHD.Model.Car_Basic model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Car_Basic(");
			strSql.Append("cartype_id,cartype,carbuydate,carNumber,carFrame,leadPerson,lastMOT,MOTgapYear,LastTimeInsured,CurrentKM,engine_number,Remarks)");
			strSql.Append(" values (");
			strSql.Append("@cartype_id,@cartype,@carbuydate,@carNumber,@carFrame,@leadPerson,@lastMOT,@MOTgapYear,@LastTimeInsured,@CurrentKM,@engine_number,@Remarks)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@cartype_id", SqlDbType.Int,4),
					new SqlParameter("@cartype", SqlDbType.VarChar,50),
					new SqlParameter("@carbuydate", SqlDbType.DateTime),
					new SqlParameter("@carNumber", SqlDbType.VarChar,20),
					new SqlParameter("@carFrame", SqlDbType.VarChar,50),
					new SqlParameter("@leadPerson", SqlDbType.VarChar,20),
					new SqlParameter("@lastMOT", SqlDbType.DateTime),
					new SqlParameter("@MOTgapYear", SqlDbType.Int,4),
					new SqlParameter("@LastTimeInsured", SqlDbType.DateTime),
					new SqlParameter("@CurrentKM", SqlDbType.Int,4),
                    new SqlParameter("@engine_number", SqlDbType.VarChar,50),
                    new SqlParameter("@Remarks", SqlDbType.VarChar,50)};
			parameters[0].Value = model.cartype_id;
			parameters[1].Value = model.cartype;
			parameters[2].Value = model.carbuydate;
			parameters[3].Value = model.carNumber;
			parameters[4].Value = model.carFrame;
			parameters[5].Value = model.leadPerson;
			parameters[6].Value = model.lastMOT;
			parameters[7].Value = model.MOTgapYear;
			parameters[8].Value = model.LastTimeInsured;
			parameters[9].Value = model.CurrentKM;
            parameters[10].Value = model.engine_number;
            parameters[11].Value = model.Remarks;

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
		public bool Update(XHD.Model.Car_Basic model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Car_Basic set ");
			strSql.Append("cartype_id=@cartype_id,");
			strSql.Append("cartype=@cartype,");
			strSql.Append("carbuydate=@carbuydate,");
			strSql.Append("carNumber=@carNumber,");
			strSql.Append("carFrame=@carFrame,");
			strSql.Append("leadPerson=@leadPerson,");
			strSql.Append("lastMOT=@lastMOT,");
			strSql.Append("MOTgapYear=@MOTgapYear,");
			strSql.Append("LastTimeInsured=@LastTimeInsured,");
			strSql.Append("CurrentKM=@CurrentKM,");
			strSql.Append("Remarks=@Remarks,");
            strSql.Append("engine_number=@engine_number");
            strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@cartype_id", SqlDbType.Int,4),
					new SqlParameter("@cartype", SqlDbType.VarChar,50),
					new SqlParameter("@carbuydate", SqlDbType.DateTime),
					new SqlParameter("@carNumber", SqlDbType.VarChar,20),
					new SqlParameter("@carFrame", SqlDbType.VarChar,50),
					new SqlParameter("@leadPerson", SqlDbType.VarChar,20),
					new SqlParameter("@lastMOT", SqlDbType.DateTime),
					new SqlParameter("@MOTgapYear", SqlDbType.Int,4),
					new SqlParameter("@LastTimeInsured", SqlDbType.DateTime),
					new SqlParameter("@CurrentKM", SqlDbType.Int,4),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
                    new SqlParameter("@engine_number", SqlDbType.VarChar,50),
                    new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.cartype_id;
			parameters[1].Value = model.cartype;
			parameters[2].Value = model.carbuydate;
			parameters[3].Value = model.carNumber;
			parameters[4].Value = model.carFrame;
			parameters[5].Value = model.leadPerson;
			parameters[6].Value = model.lastMOT;
			parameters[7].Value = model.MOTgapYear;
			parameters[8].Value = model.LastTimeInsured;
			parameters[9].Value = model.CurrentKM;
			parameters[10].Value = model.Remarks;
            parameters[11].Value = model.engine_number;
            parameters[12].Value = model.id;

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
			strSql.Append("delete from Car_Basic ");
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
			strSql.Append("delete from Car_Basic ");
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
		public XHD.Model.Car_Basic GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,cartype_id,cartype,carbuydate,carNumber,carFrame,leadPerson,lastMOT,MOTgapYear,LastTimeInsured,CurrentKM,Remarks,engine_number from Car_Basic ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.Car_Basic model=new XHD.Model.Car_Basic();
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
		public XHD.Model.Car_Basic DataRowToModel(DataRow row)
		{
			XHD.Model.Car_Basic model=new XHD.Model.Car_Basic();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["cartype_id"]!=null && row["cartype_id"].ToString()!="")
				{
					model.cartype_id=int.Parse(row["cartype_id"].ToString());
				}
				if(row["cartype"]!=null)
				{
					model.cartype=row["cartype"].ToString();
				}
				if(row["carbuydate"]!=null && row["carbuydate"].ToString()!="")
				{
					model.carbuydate=DateTime.Parse(row["carbuydate"].ToString());
				}
				if(row["carNumber"]!=null)
				{
					model.carNumber=row["carNumber"].ToString();
				}
				if(row["carFrame"]!=null)
				{
					model.carFrame=row["carFrame"].ToString();
				}
				if(row["leadPerson"]!=null)
				{
					model.leadPerson=row["leadPerson"].ToString();
				}
				if(row["lastMOT"]!=null && row["lastMOT"].ToString()!="")
				{
					model.lastMOT=DateTime.Parse(row["lastMOT"].ToString());
				}
				if(row["MOTgapYear"]!=null && row["MOTgapYear"].ToString()!="")
				{
					model.MOTgapYear=int.Parse(row["MOTgapYear"].ToString());
				}
				if(row["LastTimeInsured"]!=null && row["LastTimeInsured"].ToString()!="")
				{
					model.LastTimeInsured=DateTime.Parse(row["LastTimeInsured"].ToString());
				}
				if(row["CurrentKM"]!=null && row["CurrentKM"].ToString()!="")
				{
					model.CurrentKM=int.Parse(row["CurrentKM"].ToString());
				}
				if(row["Remarks"]!=null)
				{
					model.Remarks=row["Remarks"].ToString();
				}
                if (row["engine_number"] != null)
                {
                    model.engine_number = row["engine_number"].ToString();
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
			strSql.Append("select id,cartype_id,cartype,carbuydate,carNumber,carFrame,leadPerson,lastMOT,MOTgapYear,LastTimeInsured,CurrentKM,Remarks,engine_number ");
			strSql.Append(" FROM Car_Basic ");
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
			strSql.Append(" id,cartype_id,cartype,carbuydate,carNumber,carFrame,leadPerson,lastMOT,MOTgapYear,LastTimeInsured,CurrentKM,Remarks,engine_number ");
			strSql.Append(" FROM Car_Basic ");
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
			strSql.Append("select count(1) FROM Car_Basic ");
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
			strSql.Append(")AS Row, T.*  from Car_Basic T ");
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
			parameters[0].Value = "Car_Basic";
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
        public bool Exists_IsUse(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from Car_Basic");
            strSql.Append(" where b_Part_idid=@id ");
            SqlParameter[] parameters = {
                    new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = id;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }


        public bool UpdateStatus(string id,string carstatus,string sfarp)
        {
            StringBuilder strSql = new StringBuilder();
            if (sfarp == "Y")//审核
            {
                strSql.Append("UPDATE	 Car_Basic SET IsStatus='Y'  ");
                strSql.Append(" where id=@id");
            }
            else
            {
                if (carstatus == "")
                    strSql.Append("UPDATE	 Car_Basic SET IsStatus= CASE IsStatus WHEN 'Y' THEN 'N' WHEN 'N' THEN 'Y' ELSE 'Y' END ");
                else
                    strSql.Append("UPDATE	 Car_Basic SET IsStatus='" + carstatus + "'");
                strSql.Append(" where id=@id");
            }
            SqlParameter[] parameters = {
                    new SqlParameter("@id", SqlDbType.Int,4)
                                        };
            parameters[0].Value = id;
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

        public DataSet GetList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " *,dateadd(yy,MOTgapYear,lastMOT) as NextMot,dateadd(yy,1,LastTimeInsured) as NextTimeInsured,DATEDIFF(day,getdate(),dateadd(yy,MOTgapYear,lastMOT)) AS MotDays,DATEDIFF(day,getdate(),dateadd(yy,1,LastTimeInsured)) as TimeInsuredDays FROM Car_Basic ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM Car_Basic ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM Car_Basic ");
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

