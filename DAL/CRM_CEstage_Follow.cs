using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:CRM_CEstage_Follow
	/// </summary>
	public partial class CRM_CEstage_Follow
	{
		public CRM_CEstage_Follow()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "CRM_CEstage_Follow"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from CRM_CEstage_Follow");
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
		public int Add(XHD.Model.CRM_CEstage_Follow model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into CRM_CEstage_Follow(");
			strSql.Append("CEStage_id,Customer_id,Customer_name,Follow,Follow_date,Follow_Type_id,Follow_Type,department_id,department_name,employee_id,employee_name,isDelete,Delete_time)");
			strSql.Append(" values (");
			strSql.Append("@CEStage_id,@Customer_id,@Customer_name,@Follow,@Follow_date,@Follow_Type_id,@Follow_Type,@department_id,@department_name,@employee_id,@employee_name,@isDelete,@Delete_time)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@CEStage_id", SqlDbType.Int,4),
					new SqlParameter("@Customer_id", SqlDbType.Int,4),
					new SqlParameter("@Customer_name", SqlDbType.VarChar,250),
					new SqlParameter("@Follow", SqlDbType.VarChar,-1),
					new SqlParameter("@Follow_date", SqlDbType.DateTime),
					new SqlParameter("@Follow_Type_id", SqlDbType.Int,4),
					new SqlParameter("@Follow_Type", SqlDbType.VarChar,250),
					new SqlParameter("@department_id", SqlDbType.Int,4),
					new SqlParameter("@department_name", SqlDbType.VarChar,250),
					new SqlParameter("@employee_id", SqlDbType.Int,4),
					new SqlParameter("@employee_name", SqlDbType.VarChar,250),
					new SqlParameter("@isDelete", SqlDbType.Int,4),
					new SqlParameter("@Delete_time", SqlDbType.DateTime)};
			parameters[0].Value = model.CEStage_id;
			parameters[1].Value = model.Customer_id;
			parameters[2].Value = model.Customer_name;
			parameters[3].Value = model.Follow;
			parameters[4].Value = model.Follow_date;
			parameters[5].Value = model.Follow_Type_id;
			parameters[6].Value = model.Follow_Type;
			parameters[7].Value = model.department_id;
			parameters[8].Value = model.department_name;
			parameters[9].Value = model.employee_id;
			parameters[10].Value = model.employee_name;
			parameters[11].Value = model.isDelete;
			parameters[12].Value = model.Delete_time;

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
		public bool Update(XHD.Model.CRM_CEstage_Follow model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update CRM_CEstage_Follow set ");
			strSql.Append("CEStage_id=@CEStage_id,");
			strSql.Append("Customer_id=@Customer_id,");
			strSql.Append("Customer_name=@Customer_name,");
			strSql.Append("Follow=@Follow,");
			strSql.Append("Follow_date=@Follow_date,");
			strSql.Append("Follow_Type_id=@Follow_Type_id,");
			strSql.Append("Follow_Type=@Follow_Type,");
			strSql.Append("department_id=@department_id,");
			strSql.Append("department_name=@department_name,");
			strSql.Append("employee_id=@employee_id,");
			strSql.Append("employee_name=@employee_name,");
			strSql.Append("isDelete=@isDelete,");
			strSql.Append("Delete_time=@Delete_time");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@CEStage_id", SqlDbType.Int,4),
					new SqlParameter("@Customer_id", SqlDbType.Int,4),
					new SqlParameter("@Customer_name", SqlDbType.VarChar,250),
					new SqlParameter("@Follow", SqlDbType.VarChar,-1),
					new SqlParameter("@Follow_date", SqlDbType.DateTime),
					new SqlParameter("@Follow_Type_id", SqlDbType.Int,4),
					new SqlParameter("@Follow_Type", SqlDbType.VarChar,250),
					new SqlParameter("@department_id", SqlDbType.Int,4),
					new SqlParameter("@department_name", SqlDbType.VarChar,250),
					new SqlParameter("@employee_id", SqlDbType.Int,4),
					new SqlParameter("@employee_name", SqlDbType.VarChar,250),
					new SqlParameter("@isDelete", SqlDbType.Int,4),
					new SqlParameter("@Delete_time", SqlDbType.DateTime),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.CEStage_id;
			parameters[1].Value = model.Customer_id;
			parameters[2].Value = model.Customer_name;
			parameters[3].Value = model.Follow;
			parameters[4].Value = model.Follow_date;
			parameters[5].Value = model.Follow_Type_id;
			parameters[6].Value = model.Follow_Type;
			parameters[7].Value = model.department_id;
			parameters[8].Value = model.department_name;
			parameters[9].Value = model.employee_id;
			parameters[10].Value = model.employee_name;
			parameters[11].Value = model.isDelete;
			parameters[12].Value = model.Delete_time;
			parameters[13].Value = model.id;

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
			strSql.Append("delete from CRM_CEstage_Follow ");
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
			strSql.Append("delete from CRM_CEstage_Follow ");
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
		public XHD.Model.CRM_CEstage_Follow GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,CEStage_id,Customer_id,Customer_name,Follow,Follow_date,Follow_Type_id,Follow_Type,department_id,department_name,employee_id,employee_name,isDelete,Delete_time from CRM_CEstage_Follow ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.CRM_CEstage_Follow model=new XHD.Model.CRM_CEstage_Follow();
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
		public XHD.Model.CRM_CEstage_Follow DataRowToModel(DataRow row)
		{
			XHD.Model.CRM_CEstage_Follow model=new XHD.Model.CRM_CEstage_Follow();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["CEStage_id"]!=null && row["CEStage_id"].ToString()!="")
				{
					model.CEStage_id=int.Parse(row["CEStage_id"].ToString());
				}
				if(row["Customer_id"]!=null && row["Customer_id"].ToString()!="")
				{
					model.Customer_id=int.Parse(row["Customer_id"].ToString());
				}
				if(row["Customer_name"]!=null)
				{
					model.Customer_name=row["Customer_name"].ToString();
				}
				if(row["Follow"]!=null)
				{
					model.Follow=row["Follow"].ToString();
				}
				if(row["Follow_date"]!=null && row["Follow_date"].ToString()!="")
				{
					model.Follow_date=DateTime.Parse(row["Follow_date"].ToString());
				}
				if(row["Follow_Type_id"]!=null && row["Follow_Type_id"].ToString()!="")
				{
					model.Follow_Type_id=int.Parse(row["Follow_Type_id"].ToString());
				}
				if(row["Follow_Type"]!=null)
				{
					model.Follow_Type=row["Follow_Type"].ToString();
				}
				if(row["department_id"]!=null && row["department_id"].ToString()!="")
				{
					model.department_id=int.Parse(row["department_id"].ToString());
				}
				if(row["department_name"]!=null)
				{
					model.department_name=row["department_name"].ToString();
				}
				if(row["employee_id"]!=null && row["employee_id"].ToString()!="")
				{
					model.employee_id=int.Parse(row["employee_id"].ToString());
				}
				if(row["employee_name"]!=null)
				{
					model.employee_name=row["employee_name"].ToString();
				}
				if(row["isDelete"]!=null && row["isDelete"].ToString()!="")
				{
					model.isDelete=int.Parse(row["isDelete"].ToString());
				}
				if(row["Delete_time"]!=null && row["Delete_time"].ToString()!="")
				{
					model.Delete_time=DateTime.Parse(row["Delete_time"].ToString());
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
			strSql.Append("select id,CEStage_id,Customer_id,Customer_name,Follow,Follow_date,Follow_Type_id,Follow_Type,department_id,department_name,employee_id,employee_name,isDelete,Delete_time ");
			strSql.Append(" FROM CRM_CEstage_Follow ");
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
			strSql.Append(" id,CEStage_id,Customer_id,Customer_name,Follow,Follow_date,Follow_Type_id,Follow_Type,department_id,department_name,employee_id,employee_name,isDelete,Delete_time ");
			strSql.Append(" FROM CRM_CEstage_Follow ");
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
			strSql.Append("select count(1) FROM CRM_CEstage_Follow ");
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
			strSql.Append(")AS Row, T.*  from CRM_CEstage_Follow T ");
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
			parameters[0].Value = "CRM_CEstage_Follow";
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
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM CRM_CEstage_Follow left join (SELECT id AS khid,address,privatecustomer,Employee_id AS Emp_id,Emp_id_sg,Emp_id_sj,Create_id,Department_id AS Dep_id,Dpt_id_sg,Dpt_id_sj FROM  dbo.CRM_Customer) CRM_Customer on CRM_CEstage_Follow.Customer_id=CRM_Customer.khid   ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM CRM_CEstage_Follow ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM CRM_CEstage_Follow left join (SELECT id AS khid,address,privatecustomer,Employee_id AS Emp_id,Emp_id_sg,Emp_id_sj,Create_id,Department_id AS Dep_id,Dpt_id_sg,Dpt_id_sj FROM  dbo.CRM_Customer) CRM_Customer on CRM_CEstage_Follow.Customer_id=CRM_Customer.khid ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet Reports_year(string items, int year, string where)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("if OBJECT_ID('Tempdb..#t') is not null ");
            strSql.Append("    drop TABLE  #t ");
            //strSql.Append("go");
            strSql.Append(" begin ");
            //strSql.Append("    --预统计表 #t");
            strSql.Append("    select ");
            strSql.Append("        " + items + ",'m'+convert(varchar,month(Follow_date)) mm,count(id)tNum into #t ");
            strSql.Append("    from dbo.CRM_CEstage_Follow ");
            strSql.Append("    where datediff(YEAR,[Follow_date],'" + year + "-1-1')=0 ");
            if (where.Trim() != "")
            {
                strSql.Append(" and " + where);
            }
            strSql.Append("    group by " + items + ",'m'+convert(varchar,month(Follow_date)) ");

            //strSql.Append("    --生成SQL");
            strSql.Append("    declare @sql varchar(8000) ");
            strSql.Append("    set @sql='select " + items + " items ' ");
            strSql.Append("    select @sql = @sql + ',sum(case mm when ' + char(39) +mm+ char(39) + ' then tNum else 0 end) ['+ mm +']' ");
            strSql.Append("        from (select distinct mm from #t)as data ");
            strSql.Append("    set @sql = @sql + ' from #t group by " + items + "' ");

            strSql.Append("    exec(@sql) ");
            strSql.Append(" end ");
            //strSql.Append("go");

            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 客户跟进【同比环比】
        /// </summary>
        /// <param name="dt1"></param>
        /// <param name="dt2"></param>
        /// <returns></returns>
        public DataSet Compared_follow(string year1, string month1, string year2, string month2)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" select Follow_Type as yy, count(Follow_Type)as xx,");
            strSql.Append(" SUM(case when YEAR( Follow_date)=('" + year1 + "') and MONTH(Follow_date)=('" + month1 + "') then 1 else 0 end) as dt1, ");
            strSql.Append(" SUM(case when YEAR( Follow_date)=('" + year2 + "') and MONTH(Follow_date)=('" + month2 + "') then 1 else 0 end) as dt2 ");
            strSql.Append(" FROM CRM_CEstage_Follow group by Follow_Type");

            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet Compared_empcusfollow(string year1, string month1, string year2, string month2, string idlist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" select hr_employee.name as yy,");
            strSql.Append(" SUM(case when YEAR( CRM_CEstage_Follow.Follow_date)=('" + year1 + "') and MONTH(CRM_CEstage_Follow.Follow_date)=('" + month1 + "') then 1 else 0 end) as dt1, ");
            strSql.Append(" SUM(case when YEAR( CRM_CEstage_Follow.Follow_date)=('" + year2 + "') and MONTH(CRM_CEstage_Follow.Follow_date)=('" + month2 + "') then 1 else 0 end) as dt2 ");
            strSql.Append(" from hr_employee left outer join CRM_CEstage_Follow ");
            strSql.Append(" on hr_employee.ID=CRM_CEstage_Follow.employee_id ");
            strSql.Append(" where hr_employee.ID in " + idlist);
            strSql.Append(" group by hr_employee.name,hr_employee.ID ");
            strSql.Append(" order by hr_employee.ID");

            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 客户跟进统计
        /// </summary>
        /// <param name="year"></param>
        /// <param name="idlist"></param>
        /// <returns></returns>
        public DataSet report_empfollow(int year, string idlist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" select name,yy,isnull([1],0) as 'm1',isnull([2],0) as 'm2',isnull([3],0) as 'm3',isnull([4],0) as 'm4',isnull([5],0) as 'm5',isnull([6],0) as 'm6',");
            strSql.Append(" isnull([7],0) as 'm7',isnull([8],0) as 'm8',isnull([9],0) as 'm9',isnull([10],0) as 'm10',isnull([11],0) as 'm11',isnull([12],0) as 'm12' ");
            strSql.Append(" from");
            strSql.Append(" (SELECT   hr_employee.ID, hr_employee.name, COUNT(derivedtbl_1.id) AS cn, YEAR(derivedtbl_1.Follow_date) AS yy, ");
            strSql.Append(" MONTH(derivedtbl_1.Follow_date) AS mm");
            strSql.Append(" FROM      hr_employee LEFT OUTER JOIN");
            strSql.Append("  (SELECT   id, employee_id, Follow_date");
            strSql.Append("  FROM      CRM_CEstage_Follow");
            strSql.Append("  WHERE  ISNULL(isdelete,0)=0 and (YEAR(Follow_date) = " + year + ")) AS derivedtbl_1 ON hr_employee.ID = derivedtbl_1.employee_id");
            strSql.Append(" WHERE hr_employee.ID in " + idlist);
            strSql.Append(" GROUP BY hr_employee.ID, hr_employee.name, YEAR(derivedtbl_1.Follow_date), MONTH(derivedtbl_1.Follow_date)) as tt");
            strSql.Append(" pivot");
            strSql.Append(" (sum(cn) for mm in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]))");
            strSql.Append(" as pvt");

            return DbHelperSQL.Query(strSql.ToString());
        }

		#endregion  ExtensionMethod
	}
}

