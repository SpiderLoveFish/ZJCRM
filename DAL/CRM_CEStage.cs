﻿using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
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
		return DbHelperSQL.GetMaxID("id", "CRM_CEStage"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from CRM_CEStage");
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
		public int Add(XHD.Model.CRM_CEStage model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into CRM_CEStage(");
			strSql.Append("CustomerID,tel,CustomerName,sgjl,sgjlid,sjs,sjsid,ywy,ywyid,StageScore,SpecialScore,Stage_icon,Remarks,IsColse,Jh_date,BeginDate)");
			strSql.Append(" values (");
            strSql.Append("@CustomerID,@tel,@CustomerName,@sgjl,@sgjlid,@sjs,@sjsid,@ywy,@ywyid,@StageScore,@SpecialScore,@Stage_icon,@Remarks,@IsColse,@Jh_date,@BeginDate)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@CustomerID", SqlDbType.Int,4),
					new SqlParameter("@tel", SqlDbType.VarChar,20),
					new SqlParameter("@CustomerName", SqlDbType.NVarChar,20),
					new SqlParameter("@sgjl", SqlDbType.NVarChar,20),
					new SqlParameter("@sgjlid", SqlDbType.Int,4),
					new SqlParameter("@sjs", SqlDbType.NVarChar,20),
					new SqlParameter("@sjsid", SqlDbType.Int,4),
					new SqlParameter("@ywy", SqlDbType.NVarChar,20),
					new SqlParameter("@ywyid", SqlDbType.Int,4),
					new SqlParameter("@StageScore", SqlDbType.Decimal,9),
					new SqlParameter("@SpecialScore", SqlDbType.Decimal,9),
					new SqlParameter("@Stage_icon", SqlDbType.VarChar,50),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
					new SqlParameter("@IsColse", SqlDbType.Int,4),
                                        new SqlParameter("@Jh_date", SqlDbType.DateTime),
                                            new SqlParameter("@BeginDate", SqlDbType.DateTime)

            };
			parameters[0].Value = model.CustomerID;
			parameters[1].Value = model.tel;
			parameters[2].Value = model.CustomerName;
			parameters[3].Value = model.sgjl;
			parameters[4].Value = model.sgjlid;
			parameters[5].Value = model.sjs;
			parameters[6].Value = model.sjsid;
			parameters[7].Value = model.ywy;
			parameters[8].Value = model.ywyid;
			parameters[9].Value = model.StageScore;
			parameters[10].Value = model.SpecialScore;
			parameters[11].Value = model.Stage_icon;
			parameters[12].Value = model.Remarks;
			parameters[13].Value = model.IsColse;
            parameters[14].Value = model.Jh_date;
            parameters[15].Value = model.Begindate;
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

        public bool Update(XHD.Model.CRM_CEStage model,int id)
		{
            StringBuilder sb =new StringBuilder();
            sb.Append("update CRM_CEStage set ");
            sb.Append("SpecialScore=@SpecialScore,");
            sb.Append("Stage_icon=@Stage_icon,");
			sb.Append("Remarks=@Remarks,");
            sb.Append("Jh_date=@Jh_date,");
            sb.Append("BeginDate=@BeginDate,");
            sb.Append("IsColse=@IsColse");
            sb.Append(" where id="+id+"");
            SqlParameter[] parameters = {
                    new SqlParameter("@SpecialScore", SqlDbType.Decimal,9),
					new SqlParameter("@Stage_icon", SqlDbType.VarChar,50),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
                    	new SqlParameter("@Jh_date", SqlDbType.DateTime),
                            new SqlParameter("@BeginDate", SqlDbType.DateTime),
                    new SqlParameter("@IsColse", SqlDbType.Int,4),
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = model.SpecialScore;
			parameters[1].Value = model.Stage_icon;
			parameters[2].Value = model.Remarks;
            parameters[3].Value = model.Jh_date;
            parameters[4].Value = model.Begindate;
            parameters[5].Value = model.IsColse;
			parameters[6].Value = model.id;

            int rows=DbHelperSQL.ExecuteSql(sb.ToString(),parameters);
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
		public bool Update(XHD.Model.CRM_CEStage model)
		{
			StringBuilder strSql=new StringBuilder();
            strSql.Append("update CRM_CEStage set ");
            strSql.Append("CustomerID=@CustomerID,");
            strSql.Append("tel=@tel,");
            strSql.Append("CustomerName=@CustomerName,");
            strSql.Append("sgjl=@sgjl,");
            strSql.Append("sgjlid=@sgjlid,");
            strSql.Append("sjs=@sjs,");
            strSql.Append("sjsid=@sjsid,");
            strSql.Append("ywy=@ywy,");
            strSql.Append("ywyid=@ywyid,");
            //strSql.Append("StageScore=@StageScore,");
			strSql.Append("SpecialScore=@SpecialScore,");
			strSql.Append("Stage_icon=@Stage_icon,");
			strSql.Append("Remarks=@Remarks,");
            strSql.Append("Jh_date=@Jh_date,");
            strSql.Append("BeginDate=@BeginDate,");
            strSql.Append("IsColse=@IsColse");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@CustomerID", SqlDbType.Int,4),
					new SqlParameter("@tel", SqlDbType.VarChar,20),
					new SqlParameter("@CustomerName", SqlDbType.NVarChar,20),
					new SqlParameter("@sgjl", SqlDbType.NVarChar,20),
					new SqlParameter("@sgjlid", SqlDbType.Int,4),
					new SqlParameter("@sjs", SqlDbType.NVarChar,20),
					new SqlParameter("@sjsid", SqlDbType.Int,4),
					new SqlParameter("@ywy", SqlDbType.NVarChar,20),
					new SqlParameter("@ywyid", SqlDbType.Int,4),
                    //new SqlParameter("@StageScore", SqlDbType.Decimal,9),
					new SqlParameter("@SpecialScore", SqlDbType.Decimal,9),
					new SqlParameter("@Stage_icon", SqlDbType.VarChar,50),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
                    new SqlParameter("@Jh_date", SqlDbType.DateTime),
                           new SqlParameter("@BeginDate", SqlDbType.DateTime),
                    new SqlParameter("@IsColse", SqlDbType.Int,4),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.CustomerID;
			parameters[1].Value = model.tel;
			parameters[2].Value = model.CustomerName;
			parameters[3].Value = model.sgjl;
			parameters[4].Value = model.sgjlid;
			parameters[5].Value = model.sjs;
			parameters[6].Value = model.sjsid;
			parameters[7].Value = model.ywy;
			parameters[8].Value = model.ywyid;
            //parameters[9].Value = model.StageScore;
			parameters[9].Value = model.SpecialScore;
			parameters[10].Value = model.Stage_icon;
			parameters[11].Value = model.Remarks;
            parameters[12].Value = model.Jh_date;
            parameters[13].Value = model.Begindate; 
            parameters[14].Value = model.IsColse;
			parameters[15].Value = model.id;

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
			strSql.Append("delete from CRM_CEStage ");
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
			strSql.Append("delete from CRM_CEStage ");
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
		public XHD.Model.CRM_CEStage GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,CustomerID,tel,CustomerName,sgjl,sgjlid,sjs,sjsid,ywy,ywyid,StageScore,SpecialScore,Stage_icon,Remarks,IsColse,Jh_date,BeginDate from CRM_CEStage ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.CRM_CEStage model=new XHD.Model.CRM_CEStage();
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
		public XHD.Model.CRM_CEStage DataRowToModel(DataRow row)
		{
			XHD.Model.CRM_CEStage model=new XHD.Model.CRM_CEStage();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["CustomerID"]!=null && row["CustomerID"].ToString()!="")
				{
					model.CustomerID=int.Parse(row["CustomerID"].ToString());
				}
				if(row["tel"]!=null)
				{
					model.tel=row["tel"].ToString();
				}
				if(row["CustomerName"]!=null)
				{
					model.CustomerName=row["CustomerName"].ToString();
				}
				if(row["sgjl"]!=null)
				{
					model.sgjl=row["sgjl"].ToString();
				}
				if(row["sgjlid"]!=null && row["sgjlid"].ToString()!="")
				{
					model.sgjlid=int.Parse(row["sgjlid"].ToString());
				}
				if(row["sjs"]!=null)
				{
					model.sjs=row["sjs"].ToString();
				}
				if(row["sjsid"]!=null && row["sjsid"].ToString()!="")
				{
					model.sjsid=int.Parse(row["sjsid"].ToString());
				}
				if(row["ywy"]!=null)
				{
					model.ywy=row["ywy"].ToString();
				}
				if(row["ywyid"]!=null && row["ywyid"].ToString()!="")
				{
					model.ywyid=int.Parse(row["ywyid"].ToString());
				}
				if(row["StageScore"]!=null && row["StageScore"].ToString()!="")
				{
					model.StageScore=decimal.Parse(row["StageScore"].ToString());
				}
				if(row["SpecialScore"]!=null && row["SpecialScore"].ToString()!="")
				{
					model.SpecialScore=decimal.Parse(row["SpecialScore"].ToString());
				}
				if(row["Stage_icon"]!=null)
				{
					model.Stage_icon=row["Stage_icon"].ToString();
				}
				if(row["Remarks"]!=null)
				{
					model.Remarks=row["Remarks"].ToString();
				}
				if(row["IsColse"]!=null && row["IsColse"].ToString()!="")
				{
					model.IsColse=int.Parse(row["IsColse"].ToString());
				}
                if (row["Jh_date"] != null && row["Jh_date"].ToString() != "")
                {
                    model.Jh_date = DateTime.Parse(row["Jh_date"].ToString());
                }
                if (row["BeginDate"] != null && row["BeginDate"].ToString() != "")
                {
                    model.Begindate = DateTime.Parse(row["BeginDate"].ToString());
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
            strSql.Append("select * ");
            strSql.Append(" FROM V_CRM_CEStage ");
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
            strSql.Append(" id,CustomerID,tel,CustomerName,sgjl,sgjlid,sjs,sjsid,ywy,ywyid,StageScore,SpecialScore,Stage_icon,Remarks,IsColse,address,sum_Score,TotalScorce,Scoring,Jh_date,sl,cgsl,BeginDate ");
			strSql.Append(" FROM V_CRM_CEStage ");
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
				strSql.Append("order by T.id desc");
			}
			strSql.Append(")AS Row, T.*  from V_CRM_CEStage T ");
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

        public bool ExistsCestage(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from CRM_CEStage");
            strSql.Append(" where CustomerID=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
            parameters[0].Value = id;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }
        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int AddCEstage(string id)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("INSERT dbo.CRM_CEStage( CustomerID,tel,CustomerName,sgjl,sgjlid,sjs,sjsid,ywy,ywyid,StageScore,SpecialScore,Stage_icon,Remarks,IsColse,Jh_date,BeginDate)");
            sb.AppendLine("SELECT id,tel,Customer,Emp_sg,Emp_id_sg,Emp_sj,Emp_id_sj,Employee,Employee_id,0,0,'正在施工' ,'',0,Jhrq2,getdate() FROM dbo.CRM_Customer WHERE id="+id);
            sb.AppendLine("");
            sb.Append(";select @@IDENTITY");
            SqlParameter[] parameters = { };

            object obj = DbHelperSQL.GetSingle(sb.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

        public bool UpdateStatus(string status,string id,DateTime jgrq)
        {
            StringBuilder strSql = new StringBuilder();
            SqlParameter[] parameters = { };
            if(status== "施工完成")
            strSql.AppendLine(" UPDATE	CRM_CEStage SET Stage_icon='" + status + "',EndDate='"+jgrq+"' WHERE id=" + id);
            else
            strSql.AppendLine(" UPDATE	CRM_CEStage SET Stage_icon='" + status + "' WHERE id=" + id);
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
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetListDetail(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM V_CRM_CEStage A inner join crm_customer B on A.customerid=B.id");
            strSql.Append(" WHERE a.id not in ( SELECT top " + (PageIndex - 1) * PageSize + " a.id FROM V_CRM_CEStage A inner join crm_customer B on A.customerid=B.id");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(a.id) FROM V_CRM_CEStage A inner join crm_customer B on A.customerid=B.id");
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
        public DataSet GetListCustomer(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  id AS CustomerID,tel,Customer AS CustomerName,Emp_sg AS sgjl,address, ");
            strSql.Append(" Emp_id_sg AS sgjlid,Emp_sj AS sjs,Emp_id_sj AS sjsid, ");
            strSql.Append(" Employee AS ywy,Employee_id AS ywyid,Fwmj FROM CRM_Customer ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM CRM_Customer ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM CRM_Customer ");
             if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where  " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }
        //选择工地
        public DataSet GetxzListCustomer(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "   * FROM ( SELECT ROW_NUMBER() OVER(ORDER BY AA.CustomerID) AS id,* ");
            strSql.AppendLine("   FROM  (  ");
            strSql.AppendLine(" SELECT DISTINCT  id AS CustomerID,tel,Customer AS CustomerName,Emp_sg AS sgjl,address,    ");
            strSql.AppendLine("  Emp_id_sg AS sgjlid,Emp_sj AS sjs,Emp_id_sj AS sjsid,   ");
            strSql.AppendLine("   Employee AS ywy,Employee_id AS ywyid,Fwmj    FROM  dbo.OutStock_Detail A   ");
            strSql.AppendLine(" INNER JOIN CRM_Customer B ON	A.Customer_id=B.id  ");
            strSql.AppendLine(" )AA )AAA ");
             
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM  (");
            strSql.AppendLine(" SELECT DISTINCT ROW_NUMBER() OVER(ORDER BY B.id) AS id, id AS CustomerID,tel,Customer AS CustomerName,Emp_sg AS sgjl,address,    ");
            strSql.AppendLine("  Emp_id_sg AS sgjlid,Emp_sj AS sjs,Emp_id_sj AS sjsid,   ");
            strSql.AppendLine("   Employee AS ywy,Employee_id AS ywyid,Fwmj    FROM  dbo.OutStock_Detail A   ");
            strSql.AppendLine(" INNER JOIN CRM_Customer B ON	A.Customer_id=B.id  ");
            strSql.AppendLine(" )AA  ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM ( ");
            strSql1.AppendLine(" SELECT DISTINCT ROW_NUMBER() OVER(ORDER BY B.id) AS id, id AS CustomerID,tel,Customer AS CustomerName,Emp_sg AS sgjl,address,    ");
            strSql1.AppendLine("  Emp_id_sg AS sgjlid,Emp_sj AS sjs,Emp_id_sj AS sjsid,   ");
            strSql1.AppendLine("   Employee AS ywy,Employee_id AS ywyid,Fwmj    FROM  dbo.OutStock_Detail A   ");
            strSql1.AppendLine(" INNER JOIN CRM_Customer B ON	A.Customer_id=B.id  ");
            strSql1.AppendLine(" )AA  ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where  " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }
        //目标工地
        public DataSet GetmbgdListCustomer(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "    ");
            strSql.AppendLine("   * FROM (  ");
            strSql.AppendLine("  SELECT  DISTINCT ROW_NUMBER() OVER(ORDER BY B.id) AS id, B.id AS CustomerID,B.tel,Customer AS CustomerName,Emp_sg AS sgjl,address,    ");
            strSql.AppendLine("  Emp_id_sg AS sgjlid,Emp_sj AS sjs,Emp_id_sj AS sjsid,   ");
            strSql.AppendLine("   Employee AS ywy,Employee_id AS ywyid,Fwmj  FROM dbo.CRM_CEStage  A  ");
            strSql.AppendLine("  INNER JOIN CRM_Customer B ON	A.CustomerID=B.id  ");
            strSql.AppendLine("  WHERE A.Stage_icon='正在施工'  ");
            strSql.AppendLine("  )AA  ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM ( ");
            strSql.AppendLine("  SELECT  DISTINCT ROW_NUMBER() OVER(ORDER BY B.id) AS id, B.id AS CustomerID,B.tel,Customer AS CustomerName,Emp_sg AS sgjl,address,    ");
            strSql.AppendLine("  Emp_id_sg AS sgjlid,Emp_sj AS sjs,Emp_id_sj AS sjsid,   ");
            strSql.AppendLine("   Employee AS ywy,Employee_id AS ywyid,Fwmj  FROM dbo.CRM_CEStage  A  ");
            strSql.AppendLine("  INNER JOIN CRM_Customer B ON	A.CustomerID=B.id  ");
            strSql.AppendLine("  WHERE A.Stage_icon='正在施工'  ");
            strSql.AppendLine("  )AA  ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM ( ");
            strSql1.AppendLine("  SELECT  DISTINCT ROW_NUMBER() OVER(ORDER BY B.id) AS id, B.id AS CustomerID,B.tel,Customer AS CustomerName,Emp_sg AS sgjl,address,    ");
            strSql1.AppendLine("  Emp_id_sg AS sgjlid,Emp_sj AS sjs,Emp_id_sj AS sjsid,   ");
            strSql1.AppendLine("   Employee AS ywy,Employee_id AS ywyid,Fwmj  FROM dbo.CRM_CEStage  A  ");
            strSql1.AppendLine("  INNER JOIN CRM_Customer B ON	A.CustomerID=B.id  ");
            strSql1.AppendLine("  WHERE A.Stage_icon='正在施工'  ");
            strSql1.AppendLine("  )AA  ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where  " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetListCountScorce(string strWhere, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("SELECT COUNT(versions) AS ver,A.projectid,A.stageid ");
            strSql.Append(" ,B.CEStage_category,AVG(A.TotalScore) AS TotalScore  ");
             strSql.Append(" ,AVG(A.AssTime*1.00) AS AssTime,SUM(a.AssTime*1.00)/SUM(isnull(A.TotalScore,1))*100 AS dcl ");
              strSql.Append(" FROM dbo.Crm_CEDetail A ");
             strSql.Append(" INNER JOIN  dbo.CRM_CEStage_category B ON	 A.stageid =B.id ");
 
           
            strSql1.Append(" select count(versions) FROM Crm_CEDetail A ");
           if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
                strSql1.Append(" where  " + strWhere);
            }
           strSql1.Append(" GROUP BY A.projectid ,A.stageid	   ");

           strSql.Append(" GROUP BY A.projectid ,A.stageid	 ,B.CEStage_category");

            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
           
            return DbHelperSQL.Query(strSql.ToString());
        }


        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int AddIPCam(string cid, string szDevIP, string acc, string pwd, string str, string ipstyle, string comp)
        {
           var sb = new System.Text.StringBuilder();
            sb.AppendLine("INSERT INTO dbo.IPCam ");
            sb.AppendLine("        ( CustomerID , ");
            sb.AppendLine("          szDevIP , ");
            sb.AppendLine("          szAuthAcc , ");
            sb.AppendLine("          szAuthPwd , ");
            sb.AppendLine("          g_DevStr , ");
            sb.AppendLine("          IPstyle , ");
            sb.AppendLine("          CompName ");
            sb.AppendLine("        ) ");
            sb.AppendLine("VALUES  ( "+cid+" , -- CustomerID - int ");
            sb.AppendLine("          '" + szDevIP + "' , -- szDevIP - varchar(50) ");
            sb.AppendLine("          '"+acc+"' , -- szAuthAcc - varchar(10) ");
            sb.AppendLine("          '"+pwd+"' , -- szAuthPwd - varchar(50) ");
            sb.AppendLine("          '"+str+"' , -- g_DevStr - varchar(100) ");
            sb.AppendLine("          "+ipstyle+" , -- IPstyle - smallint ");
            sb.AppendLine("          '"+comp+"'  -- CompName - varchar(50) ");
            sb.AppendLine("        ) ");
            sb.AppendLine(" ");
            SqlParameter[] parameters = {
                                        }; 
            object obj = DbHelperSQL.GetSingle(sb.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

        public bool UpdateIPCam(string cid, string szDevIP, string acc, string pwd, string str, string ipstyle, string comp)
        {
            var sb = new System.Text.StringBuilder();

            sb.AppendLine(" IF EXISTS(SELECT 1 FROM IPCAM WHERE	    CustomerID = " + cid + "  )");
            sb.AppendLine(" begin");
            sb.AppendLine(" UPDATE   dbo.IPCam ");
            sb.AppendLine("    SET ");
            sb.AppendLine("          szDevIP='" + szDevIP + "' , ");
            //sb.AppendLine("          szAuthAcc , ");
            //sb.AppendLine("          szAuthPwd , ");
            //sb.AppendLine("          g_DevStr , ");
            //sb.AppendLine("          IPstyle , ");
            sb.AppendLine("          CompName='" + comp + "' ");
            sb.AppendLine("          ");
            sb.AppendLine(" where   CustomerID = " + cid + "    ");
            sb.AppendLine(" end  else begin");
            sb.AppendLine("INSERT INTO dbo.IPCam ");
            sb.AppendLine("        ( CustomerID , ");
            sb.AppendLine("          szDevIP , ");
            sb.AppendLine("          szAuthAcc , ");
            sb.AppendLine("          szAuthPwd , ");
            sb.AppendLine("          g_DevStr , ");
            sb.AppendLine("          IPstyle , ");
            sb.AppendLine("          CompName ");
            sb.AppendLine("        ) ");
            sb.AppendLine("VALUES  ( " + cid + " , -- CustomerID - int ");
            sb.AppendLine("          '" + szDevIP + "' , -- szDevIP - varchar(50) ");
            sb.AppendLine("          '" + acc + "' , -- szAuthAcc - varchar(10) ");
            sb.AppendLine("          '" + pwd + "' , -- szAuthPwd - varchar(50) ");
            sb.AppendLine("          '" + str + "' , -- g_DevStr - varchar(100) ");
            sb.AppendLine("          " + ipstyle + " , -- IPstyle - smallint ");
            sb.AppendLine("          '" + comp + "'  -- CompName - varchar(50) ");
            sb.AppendLine("        ) ");
            sb.AppendLine(" end ");
          
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

		#endregion  ExtensionMethod
	}
}

 