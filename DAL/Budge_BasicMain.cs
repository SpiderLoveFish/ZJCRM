using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Budge_BasicMain
	/// </summary>
	public partial class Budge_BasicMain
	{
		public Budge_BasicMain()
		{}
		#region  BasicMethod

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(string id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Budge_BasicMain");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.VarChar,15)			};
			parameters[0].Value = id;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}

       
        /// <summary>
        /// 得到最大ID
        /// </summary>
        public string GetMaxId()
        {
            string per = "YS";
            per = per + DateTime.Now.ToString("yyMMdd-");
            string strsql = "select max(REPLACE(id,'" + per + "',''))+1 from Budge_BasicMain WHERE id LIKE '"+per+"%'";
            object obj = DbHelperSQL.GetSingle(strsql);
            if (obj == null)
            {
                return per+"001";
            }
            else
            {
                return per+int.Parse(obj.ToString()).ToString("000");
            }

           // return DbHelperSQL.GetMaxID("id", "CRM_CEStage");
        }


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.Budge_BasicMain model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Budge_BasicMain(");
            strSql.Append("id,customer_id,BudgetName,DoPerson,DoTime,IsStatus,ProjectDirectCost,DirectCostDiscount,AdditionalCost,BudgetAmount,DiscountAmount,CostAmount,SigningAmount,SigningTime,Profit,Remarks,Mmaterial,MmaterialDiscount,fbAmount,versions,ModelStyle)");
			strSql.Append(" values (");
            strSql.Append("@id,@customer_id,@BudgetName,@DoPerson,@DoTime,@IsStatus,@ProjectDirectCost,@DirectCostDiscount,@AdditionalCost,@BudgetAmount,@DiscountAmount,@CostAmount,@SigningAmount,@SigningTime,@Profit,@Remarks,@Mmaterial,@MmaterialDiscount,@fbAmount,@versions,@ModelStyle)");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.VarChar,15),
					new SqlParameter("@customer_id", SqlDbType.Int,4),
					new SqlParameter("@BudgetName", SqlDbType.VarChar,250),
					new SqlParameter("@DoPerson", SqlDbType.Int,4),
					new SqlParameter("@DoTime", SqlDbType.DateTime),
					new SqlParameter("@IsStatus", SqlDbType.Int,4),
					new SqlParameter("@ProjectDirectCost", SqlDbType.Decimal,9),
					new SqlParameter("@DirectCostDiscount", SqlDbType.Decimal,9),
					new SqlParameter("@AdditionalCost", SqlDbType.Decimal,9),
					new SqlParameter("@BudgetAmount", SqlDbType.Decimal,9),
					new SqlParameter("@DiscountAmount", SqlDbType.Decimal,9),
					new SqlParameter("@CostAmount", SqlDbType.Decimal,9),
					new SqlParameter("@SigningAmount", SqlDbType.Decimal,9),
					new SqlParameter("@SigningTime", SqlDbType.DateTime),
					new SqlParameter("@Profit", SqlDbType.Decimal,9),
					new SqlParameter("@Remarks", SqlDbType.VarChar,250),
					new SqlParameter("@Mmaterial", SqlDbType.Decimal,9),
					new SqlParameter("@MmaterialDiscount", SqlDbType.Decimal,9),
					new SqlParameter("@fbAmount", SqlDbType.Decimal,9),
					new SqlParameter("@versions", SqlDbType.SmallInt,2),
                                        	new SqlParameter("@ModelStyle", SqlDbType.VarChar,50)};
			parameters[0].Value = model.id;
			parameters[1].Value = model.customer_id;
			parameters[2].Value = model.BudgetName;
			parameters[3].Value = model.DoPerson;
			parameters[4].Value = model.DoTime;
			parameters[5].Value = model.IsStatus;
			parameters[6].Value = model.ProjectDirectCost;
			parameters[7].Value = model.DirectCostDiscount;
			parameters[8].Value = model.AdditionalCost;
			parameters[9].Value = model.BudgetAmount;
			parameters[10].Value = model.DiscountAmount;
			parameters[11].Value = model.CostAmount;
			parameters[12].Value = model.SigningAmount;
			parameters[13].Value = model.SigningTime;
			parameters[14].Value = model.Profit;
			parameters[15].Value = model.Remarks;
			parameters[16].Value = model.Mmaterial;
			parameters[17].Value = model.MmaterialDiscount;
			parameters[18].Value = model.fbAmount;
			parameters[19].Value = model.versions;
            parameters[20].Value = model.ModelStyle;

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

        public bool Addmb(XHD.Model.Budge_BasicMain model,string mblx)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into Budge_BasicMain(");
            strSql.Append("id,customer_id,BudgetName,DoPerson,DoTime,IsStatus,ProjectDirectCost,DirectCostDiscount,AdditionalCost,BudgetAmount,DiscountAmount,CostAmount,SigningAmount,SigningTime,Profit,Remarks,Mmaterial,MmaterialDiscount,fbAmount,versions,IsModel,ModelStyle,FromTimes)");
            strSql.Append(" values (");
            strSql.Append("@id,@customer_id,@BudgetName,@DoPerson,@DoTime,@IsStatus,@ProjectDirectCost,@DirectCostDiscount,@AdditionalCost,@BudgetAmount,@DiscountAmount,@CostAmount,@SigningAmount,@SigningTime,@Profit,@Remarks,@Mmaterial,@MmaterialDiscount,@fbAmount,@versions,'Y','"+mblx+"',0)");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.VarChar,15),
					new SqlParameter("@customer_id", SqlDbType.Int,4),
					new SqlParameter("@BudgetName", SqlDbType.VarChar,250),
					new SqlParameter("@DoPerson", SqlDbType.Int,4),
					new SqlParameter("@DoTime", SqlDbType.DateTime),
					new SqlParameter("@IsStatus", SqlDbType.Int,4),
					new SqlParameter("@ProjectDirectCost", SqlDbType.Decimal,9),
					new SqlParameter("@DirectCostDiscount", SqlDbType.Decimal,9),
					new SqlParameter("@AdditionalCost", SqlDbType.Decimal,9),
					new SqlParameter("@BudgetAmount", SqlDbType.Decimal,9),
					new SqlParameter("@DiscountAmount", SqlDbType.Decimal,9),
					new SqlParameter("@CostAmount", SqlDbType.Decimal,9),
					new SqlParameter("@SigningAmount", SqlDbType.Decimal,9),
					new SqlParameter("@SigningTime", SqlDbType.DateTime),
					new SqlParameter("@Profit", SqlDbType.Decimal,9),
					new SqlParameter("@Remarks", SqlDbType.VarChar,250),
					new SqlParameter("@Mmaterial", SqlDbType.Decimal,9),
					new SqlParameter("@MmaterialDiscount", SqlDbType.Decimal,9),
					new SqlParameter("@fbAmount", SqlDbType.Decimal,9),
					new SqlParameter("@versions", SqlDbType.SmallInt,2)};
            parameters[0].Value = model.id;
            parameters[1].Value = model.customer_id;
            parameters[2].Value = model.BudgetName;
            parameters[3].Value = model.DoPerson;
            parameters[4].Value = model.DoTime;
            parameters[5].Value = model.IsStatus;
            parameters[6].Value = model.ProjectDirectCost;
            parameters[7].Value = model.DirectCostDiscount;
            parameters[8].Value = model.AdditionalCost;
            parameters[9].Value = model.BudgetAmount;
            parameters[10].Value = model.DiscountAmount;
            parameters[11].Value = model.CostAmount;
            parameters[12].Value = model.SigningAmount;
            parameters[13].Value = model.SigningTime;
            parameters[14].Value = model.Profit;
            parameters[15].Value = model.Remarks;
            parameters[16].Value = model.Mmaterial;
            parameters[17].Value = model.MmaterialDiscount;
            parameters[18].Value = model.fbAmount;
            parameters[19].Value = model.versions;

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
		/// 更新一条数据,只更新名称
		/// </summary>
        public bool Update(XHD.Model.Budge_BasicMain model, string mblx)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Budge_BasicMain set ");
            //strSql.Append("customer_id=@customer_id,");
			strSql.Append("BudgetName=@BudgetName,");
			strSql.Append("DoPerson=@DoPerson,");
			strSql.Append("DoTime=@DoTime,");
            if (mblx!="")
                strSql.Append(" ModelStyle='"+mblx+"',");
            //strSql.Append("IsStatus=@IsStatus,");
            //strSql.Append("ProjectDirectCost=@ProjectDirectCost,");
            //strSql.Append("DirectCostDiscount=@DirectCostDiscount,");
            //strSql.Append("AdditionalCost=@AdditionalCost,");
            //strSql.Append("BudgetAmount=@BudgetAmount,");
            //strSql.Append("DiscountAmount=@DiscountAmount,");
            //strSql.Append("CostAmount=@CostAmount,");
            //strSql.Append("SigningAmount=@SigningAmount,");
            //strSql.Append("SigningTime=@SigningTime,");
            //strSql.Append("Profit=@Profit,");
            //strSql.Append("Remarks=@Remarks,");
            //strSql.Append("Mmaterial=@Mmaterial,");
            //strSql.Append("MmaterialDiscount=@MmaterialDiscount,");
            //strSql.Append("fbAmount=@fbAmount,");
            strSql.Append("versions=@versions");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@customer_id", SqlDbType.Int,4),
					new SqlParameter("@BudgetName", SqlDbType.VarChar,250),
					new SqlParameter("@DoPerson", SqlDbType.Int,4),
					new SqlParameter("@DoTime", SqlDbType.DateTime),
					new SqlParameter("@IsStatus", SqlDbType.Int,4),
					new SqlParameter("@ProjectDirectCost", SqlDbType.Decimal,9),
					new SqlParameter("@DirectCostDiscount", SqlDbType.Decimal,9),
					new SqlParameter("@AdditionalCost", SqlDbType.Decimal,9),
					new SqlParameter("@BudgetAmount", SqlDbType.Decimal,9),
					new SqlParameter("@DiscountAmount", SqlDbType.Decimal,9),
					new SqlParameter("@CostAmount", SqlDbType.Decimal,9),
					new SqlParameter("@SigningAmount", SqlDbType.Decimal,9),
					new SqlParameter("@SigningTime", SqlDbType.DateTime),
					new SqlParameter("@Profit", SqlDbType.Decimal,9),
					new SqlParameter("@Remarks", SqlDbType.VarChar,250),
					new SqlParameter("@Mmaterial", SqlDbType.Decimal,9),
					new SqlParameter("@MmaterialDiscount", SqlDbType.Decimal,9),
					new SqlParameter("@fbAmount", SqlDbType.Decimal,9),
					new SqlParameter("@versions", SqlDbType.SmallInt,2),
					new SqlParameter("@id", SqlDbType.VarChar,15)};
			parameters[0].Value = model.customer_id;
			parameters[1].Value = model.BudgetName;
			parameters[2].Value = model.DoPerson;
			parameters[3].Value = model.DoTime;
			parameters[4].Value = model.IsStatus;
			parameters[5].Value = model.ProjectDirectCost;
			parameters[6].Value = model.DirectCostDiscount;
			parameters[7].Value = model.AdditionalCost;
			parameters[8].Value = model.BudgetAmount;
			parameters[9].Value = model.DiscountAmount;
			parameters[10].Value = model.CostAmount;
			parameters[11].Value = model.SigningAmount;
			parameters[12].Value = model.SigningTime;
			parameters[13].Value = model.Profit;
			parameters[14].Value = model.Remarks;
			parameters[15].Value = model.Mmaterial;
			parameters[16].Value = model.MmaterialDiscount;
			parameters[17].Value = model.fbAmount;
			parameters[18].Value = model.versions;
			parameters[19].Value = model.id;

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

        public bool updatestatus(int status,string bid)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update Budge_BasicMain set ");
            strSql.Append("IsStatus="+status+"");
            if(status==2)//确定日期
                strSql.Append(" ,ConfirmDate=getdate()");
            	strSql.Append(" where id='"+bid+"' ");
                SqlParameter[] parameters = { };
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
		/// 删除一条数据
		/// </summary>
		public bool Delete(string id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Budge_BasicMain ");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.VarChar,15)			};
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
			strSql.Append("delete from Budge_BasicMain ");
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
		public XHD.Model.Budge_BasicMain GetModel(string id)
		{
			
			StringBuilder strSql=new StringBuilder();
            strSql.Append("select  top 1 id,customer_id,BudgetName,DoPerson,DoTime,IsStatus,ProjectDirectCost,DirectCostDiscount,AdditionalCost,BudgetAmount,DiscountAmount,CostAmount,SigningAmount,SigningTime,Profit,Remarks,Mmaterial,MmaterialDiscount,fbAmount,versions,ModelStyle from Budge_BasicMain ");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.VarChar,15)			};
			parameters[0].Value = id;

			XHD.Model.Budge_BasicMain model=new XHD.Model.Budge_BasicMain();
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
		public XHD.Model.Budge_BasicMain DataRowToModel(DataRow row)
		{
			XHD.Model.Budge_BasicMain model=new XHD.Model.Budge_BasicMain();
			if (row != null)
			{
				if(row["id"]!=null)
				{
					model.id=row["id"].ToString();
				}
				if(row["customer_id"]!=null && row["customer_id"].ToString()!="")
				{
					model.customer_id=int.Parse(row["customer_id"].ToString());
				}
				if(row["BudgetName"]!=null)
				{
					model.BudgetName=row["BudgetName"].ToString();
				}
				if(row["DoPerson"]!=null && row["DoPerson"].ToString()!="")
				{
					model.DoPerson=int.Parse(row["DoPerson"].ToString());
				}
				if(row["DoTime"]!=null && row["DoTime"].ToString()!="")
				{
					model.DoTime=DateTime.Parse(row["DoTime"].ToString());
				}
				if(row["IsStatus"]!=null && row["IsStatus"].ToString()!="")
				{
					model.IsStatus=int.Parse(row["IsStatus"].ToString());
				}
				if(row["ProjectDirectCost"]!=null && row["ProjectDirectCost"].ToString()!="")
				{
					model.ProjectDirectCost=decimal.Parse(row["ProjectDirectCost"].ToString());
				}
				if(row["DirectCostDiscount"]!=null && row["DirectCostDiscount"].ToString()!="")
				{
					model.DirectCostDiscount=decimal.Parse(row["DirectCostDiscount"].ToString());
				}
				if(row["AdditionalCost"]!=null && row["AdditionalCost"].ToString()!="")
				{
					model.AdditionalCost=decimal.Parse(row["AdditionalCost"].ToString());
				}
				if(row["BudgetAmount"]!=null && row["BudgetAmount"].ToString()!="")
				{
					model.BudgetAmount=decimal.Parse(row["BudgetAmount"].ToString());
				}
				if(row["DiscountAmount"]!=null && row["DiscountAmount"].ToString()!="")
				{
					model.DiscountAmount=decimal.Parse(row["DiscountAmount"].ToString());
				}
				if(row["CostAmount"]!=null && row["CostAmount"].ToString()!="")
				{
					model.CostAmount=decimal.Parse(row["CostAmount"].ToString());
				}
				if(row["SigningAmount"]!=null && row["SigningAmount"].ToString()!="")
				{
					model.SigningAmount=decimal.Parse(row["SigningAmount"].ToString());
				}
				if(row["SigningTime"]!=null && row["SigningTime"].ToString()!="")
				{
					model.SigningTime=DateTime.Parse(row["SigningTime"].ToString());
				}
				if(row["Profit"]!=null && row["Profit"].ToString()!="")
				{
					model.Profit=decimal.Parse(row["Profit"].ToString());
				}
				if(row["Remarks"]!=null)
				{
					model.Remarks=row["Remarks"].ToString();
				}
				if(row["Mmaterial"]!=null && row["Mmaterial"].ToString()!="")
				{
					model.Mmaterial=decimal.Parse(row["Mmaterial"].ToString());
				}
				if(row["MmaterialDiscount"]!=null && row["MmaterialDiscount"].ToString()!="")
				{
					model.MmaterialDiscount=decimal.Parse(row["MmaterialDiscount"].ToString());
				}
				if(row["fbAmount"]!=null && row["fbAmount"].ToString()!="")
				{
					model.fbAmount=decimal.Parse(row["fbAmount"].ToString());
				}
				if(row["versions"]!=null && row["versions"].ToString()!="")
				{
					model.versions=int.Parse(row["versions"].ToString());
				}
                if (row["ModelStyle"] != null)
                {
                    model.Remarks = row["ModelStyle"].ToString();
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
			strSql.Append("select id,customer_id,BudgetName,DoPerson,DoTime,IsStatus,ProjectDirectCost,DirectCostDiscount,AdditionalCost,BudgetAmount,DiscountAmount,CostAmount,SigningAmount,SigningTime,Profit,Remarks,Mmaterial,MmaterialDiscount,fbAmount,versions ");
			strSql.Append(" FROM Budge_BasicMain ");
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
			strSql.Append(" id,customer_id,BudgetName,DoPerson,DoTime,IsStatus,ProjectDirectCost,DirectCostDiscount,AdditionalCost,BudgetAmount,DiscountAmount,CostAmount,SigningAmount,SigningTime,Profit,Remarks,Mmaterial,MmaterialDiscount,fbAmount,versions ");
			strSql.Append(" FROM Budge_BasicMain ");
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
			strSql.Append("select count(1) FROM Budge_BasicMain ");
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
			strSql.Append(")AS Row, T.*  from Budge_BasicMain T ");
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
			parameters[0].Value = "Budge_BasicMain";
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
        public DataSet GetBudge_BasicMain(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " A.*,B.tel,C.name,B.Customer AS CustomerName,B.Emp_sg AS sgjl,Emp_sj AS sjs,B.address ");
            strSql.Append(" ,CASE IsStatus WHEN 0 THEN '待提交' WHEN 1 THEN '待审核' WHEN 2 THEN '已生效' WHEN 99 THEN '已作废' ELSE '未知状态'END	 AS txtstatus ");
            strSql.Append(" FROM dbo.Budge_BasicMain A LEFT JOIN dbo.CRM_Customer B ON A.customer_id=B.id ");
            strSql.Append(" INNER JOIN  dbo.hr_employee C ON A.DoPerson=C.ID ");
            strSql.Append(" WHERE A.id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM Budge_BasicMain ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM Budge_BasicMain A");
         
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                //strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetListBasicPart(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * ");
            strSql.Append(" FROM Budge_BasicPart ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetListPara_Ver(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * ");
            strSql.Append(" FROM Budge_Para_Ver ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList_form(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" select    A.*,ISNULL(b_zje,0) as zje,C.b_sj,C.b_sl,A.FJAmount as fjfy,B.id AS CustomerID,");
            strSql.Append(" isnull(C.b_zkzje,0) zkzje,  B.tel,B.Customer AS CustomerName,B.Emp_sg AS sgjl,B.address,cc.tel as sjstel,B.gender  ");
            strSql.Append(" ,B.Emp_sj AS sjs,B.Employee AS ywy ");
              strSql.Append(" FROM dbo.Budge_BasicMain A ");
              strSql.Append(" LEFT JOIN dbo.CRM_Customer B ON A.customer_id=B.id   ");
              strSql.Append(" LEFT JOIN dbo.Budge_tax C ON	 A.id =C.budge_id ");
              strSql.Append(" LEFT JOIN dbo.hr_employee CC ON	 B.emp_id_sj=CC.[ID] ");
              strSql.Append(" LEFT JOIN (SELECT SUM(rate) AS rate,budge_id FROM  dbo.Budge_Rate_Ver GROUP BY budge_id) D ON  A.id =D.budge_id ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }


        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetPrintCount(string bid)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("SELECT c.c_style,isnull(SUM(SubTotal),0) AS je,ComponentName INTO #temp FROM dbo.Budge_BasicDetail a");
            sb.AppendLine(" INNER JOIN dbo.CRM_product B ON A.xmid=B.product_id");
            sb.AppendLine(" INNER JOIN  dbo.CRM_product_category C ON B.category_id=C.id");
            sb.AppendLine("  WHERE budge_id='" + bid + "'");
            sb.AppendLine("  GROUP BY c.c_style,ComponentName");
            sb.AppendLine("SELECT ComponentName, COUNT(xmid)AS	zl");
            sb.AppendLine(", isnull(SUM([SUM]),0) AS zsl,isnull(SUM(a.TotalPrice*[SUM]),0) AS zje,isnull(SUM(a.zc_price*[SUM]),0) AS zc_zje,isnull(SUM(a.fc_price*[SUM]),0) AS fc_zje,isnull(SUM(a.rg_price*[SUM]),0) AS rg_zje");
            sb.AppendLine(",(SELECT isnull(je,0) as je FROM #temp WHERE C_style='主材' AND ComponentName=A.ComponentName	 ) AS zcje, (SELECT isnull(je,0) as je FROM #temp WHERE C_style='基建' AND ComponentName=A.ComponentName) jcje");
            sb.AppendLine(" FROM  dbo.Budge_BasicDetail A");
            sb.AppendLine(" INNER JOIN dbo.CRM_product B ON A.xmid=B.product_id");
            sb.AppendLine(" INNER JOIN  dbo.CRM_product_category C ON B.category_id=C.id");
            sb.AppendLine("  WHERE budge_id='" + bid + "'");
            sb.AppendLine(" GROUP BY ComponentName");
            sb.AppendLine("  UNION ALL");
            sb.AppendLine("SELECT '合计', COUNT(xmid)AS	zl");
            sb.AppendLine(", isnull(SUM([SUM]),0) AS zsl,isnull(SUM(a.TotalPrice*[SUM]),0) AS zje,isnull(SUM(a.zc_price*[SUM]),0) AS zc_zje,isnull(SUM(a.fc_price*[SUM]),0) AS fc_zje,isnull(SUM(a.rg_price*[SUM]),0) AS rg_zje");
            sb.AppendLine(",0 AS zcje, 0 as jcje");
            sb.AppendLine(" FROM  dbo.Budge_BasicDetail A");
            sb.AppendLine(" INNER JOIN dbo.CRM_product B ON A.xmid=B.product_id");
            sb.AppendLine(" INNER JOIN  dbo.CRM_product_category C ON B.category_id=C.id");
            sb.AppendLine("  WHERE budge_id='" + bid + "'");
            sb.AppendLine("");
            return DbHelperSQL.Query(sb.ToString());
        }


		#endregion  ExtensionMethod
	}
}

