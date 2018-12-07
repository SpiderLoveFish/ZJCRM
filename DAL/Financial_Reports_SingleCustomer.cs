using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Financial_Reports_SingleCustomer
	/// </summary>
	public partial class Financial_Reports_SingleCustomer
	{
		public Financial_Reports_SingleCustomer()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "Financial_Reports_SingleCustomer"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Financial_Reports_SingleCustomer");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
			parameters[0].Value = id;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.Financial_Reports_SingleCustomer model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Financial_Reports_SingleCustomer(");
			strSql.Append("id,CustomerID,cwny,CollectedAmount,MaterialCost,LabourCost,FixedApportionment,ChangeApportionment,CompanyMaori,BusinessProfit,ConstructionProfit,DesignProfit,CompanyProfit,Remarks)");
			strSql.Append(" values (");
			strSql.Append("@id,@CustomerID,@cwny,@CollectedAmount,@MaterialCost,@LabourCost,@FixedApportionment,@ChangeApportionment,@CompanyMaori,@BusinessProfit,@ConstructionProfit,@DesignProfit,@CompanyProfit,@Remarks)");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4),
					new SqlParameter("@CustomerID", SqlDbType.Int,4),
					new SqlParameter("@cwny", SqlDbType.VarChar,6),
					new SqlParameter("@CollectedAmount", SqlDbType.Decimal,9),
					new SqlParameter("@MaterialCost", SqlDbType.Decimal,9),
					new SqlParameter("@LabourCost", SqlDbType.Decimal,9),
					new SqlParameter("@FixedApportionment", SqlDbType.Decimal,9),
					new SqlParameter("@ChangeApportionment", SqlDbType.Decimal,9),
					new SqlParameter("@CompanyMaori", SqlDbType.Decimal,9),
					new SqlParameter("@BusinessProfit", SqlDbType.Decimal,9),
					new SqlParameter("@ConstructionProfit", SqlDbType.Decimal,9),
					new SqlParameter("@DesignProfit", SqlDbType.Decimal,9),
					new SqlParameter("@CompanyProfit", SqlDbType.Decimal,9),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50)};
			parameters[0].Value = model.id;
			parameters[1].Value = model.CustomerID;
			parameters[2].Value = model.cwny;
			parameters[3].Value = model.CollectedAmount;
			parameters[4].Value = model.MaterialCost;
			parameters[5].Value = model.LabourCost;
			parameters[6].Value = model.FixedApportionment;
			parameters[7].Value = model.ChangeApportionment;
			parameters[8].Value = model.CompanyMaori;
			parameters[9].Value = model.BusinessProfit;
			parameters[10].Value = model.ConstructionProfit;
			parameters[11].Value = model.DesignProfit;
			parameters[12].Value = model.CompanyProfit;
			parameters[13].Value = model.Remarks;

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
		public bool Update(XHD.Model.Financial_Reports_SingleCustomer model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Financial_Reports_SingleCustomer set ");
			strSql.Append("CustomerID=@CustomerID,");
			strSql.Append("cwny=@cwny,");
			strSql.Append("CollectedAmount=@CollectedAmount,");
			strSql.Append("MaterialCost=@MaterialCost,");
			strSql.Append("LabourCost=@LabourCost,");
			strSql.Append("FixedApportionment=@FixedApportionment,");
			strSql.Append("ChangeApportionment=@ChangeApportionment,");
			strSql.Append("CompanyMaori=@CompanyMaori,");
			strSql.Append("BusinessProfit=@BusinessProfit,");
			strSql.Append("ConstructionProfit=@ConstructionProfit,");
			strSql.Append("DesignProfit=@DesignProfit,");
			strSql.Append("CompanyProfit=@CompanyProfit,");
			strSql.Append("Remarks=@Remarks");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@CustomerID", SqlDbType.Int,4),
					new SqlParameter("@cwny", SqlDbType.VarChar,6),
					new SqlParameter("@CollectedAmount", SqlDbType.Decimal,9),
					new SqlParameter("@MaterialCost", SqlDbType.Decimal,9),
					new SqlParameter("@LabourCost", SqlDbType.Decimal,9),
					new SqlParameter("@FixedApportionment", SqlDbType.Decimal,9),
					new SqlParameter("@ChangeApportionment", SqlDbType.Decimal,9),
					new SqlParameter("@CompanyMaori", SqlDbType.Decimal,9),
					new SqlParameter("@BusinessProfit", SqlDbType.Decimal,9),
					new SqlParameter("@ConstructionProfit", SqlDbType.Decimal,9),
					new SqlParameter("@DesignProfit", SqlDbType.Decimal,9),
					new SqlParameter("@CompanyProfit", SqlDbType.Decimal,9),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.CustomerID;
			parameters[1].Value = model.cwny;
			parameters[2].Value = model.CollectedAmount;
			parameters[3].Value = model.MaterialCost;
			parameters[4].Value = model.LabourCost;
			parameters[5].Value = model.FixedApportionment;
			parameters[6].Value = model.ChangeApportionment;
			parameters[7].Value = model.CompanyMaori;
			parameters[8].Value = model.BusinessProfit;
			parameters[9].Value = model.ConstructionProfit;
			parameters[10].Value = model.DesignProfit;
			parameters[11].Value = model.CompanyProfit;
			parameters[12].Value = model.Remarks;
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
			strSql.Append("delete from Financial_Reports_SingleCustomer ");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
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
			strSql.Append("delete from Financial_Reports_SingleCustomer ");
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
		public XHD.Model.Financial_Reports_SingleCustomer GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,CustomerID,cwny,CollectedAmount,MaterialCost,LabourCost,FixedApportionment,ChangeApportionment,CompanyMaori,BusinessProfit,ConstructionProfit,DesignProfit,CompanyProfit,Remarks from Financial_Reports_SingleCustomer ");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
			parameters[0].Value = id;

			XHD.Model.Financial_Reports_SingleCustomer model=new XHD.Model.Financial_Reports_SingleCustomer();
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
		public XHD.Model.Financial_Reports_SingleCustomer DataRowToModel(DataRow row)
		{
			XHD.Model.Financial_Reports_SingleCustomer model=new XHD.Model.Financial_Reports_SingleCustomer();
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
				if(row["cwny"]!=null)
				{
					model.cwny=row["cwny"].ToString();
				}
				if(row["CollectedAmount"]!=null && row["CollectedAmount"].ToString()!="")
				{
					model.CollectedAmount=decimal.Parse(row["CollectedAmount"].ToString());
				}
				if(row["MaterialCost"]!=null && row["MaterialCost"].ToString()!="")
				{
					model.MaterialCost=decimal.Parse(row["MaterialCost"].ToString());
				}
				if(row["LabourCost"]!=null && row["LabourCost"].ToString()!="")
				{
					model.LabourCost=decimal.Parse(row["LabourCost"].ToString());
				}
				if(row["FixedApportionment"]!=null && row["FixedApportionment"].ToString()!="")
				{
					model.FixedApportionment=decimal.Parse(row["FixedApportionment"].ToString());
				}
				if(row["ChangeApportionment"]!=null && row["ChangeApportionment"].ToString()!="")
				{
					model.ChangeApportionment=decimal.Parse(row["ChangeApportionment"].ToString());
				}
				if(row["CompanyMaori"]!=null && row["CompanyMaori"].ToString()!="")
				{
					model.CompanyMaori=decimal.Parse(row["CompanyMaori"].ToString());
				}
				if(row["BusinessProfit"]!=null && row["BusinessProfit"].ToString()!="")
				{
					model.BusinessProfit=decimal.Parse(row["BusinessProfit"].ToString());
				}
				if(row["ConstructionProfit"]!=null && row["ConstructionProfit"].ToString()!="")
				{
					model.ConstructionProfit=decimal.Parse(row["ConstructionProfit"].ToString());
				}
				if(row["DesignProfit"]!=null && row["DesignProfit"].ToString()!="")
				{
					model.DesignProfit=decimal.Parse(row["DesignProfit"].ToString());
				}
				if(row["CompanyProfit"]!=null && row["CompanyProfit"].ToString()!="")
				{
					model.CompanyProfit=decimal.Parse(row["CompanyProfit"].ToString());
				}
				if(row["Remarks"]!=null)
				{
					model.Remarks=row["Remarks"].ToString();
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
			strSql.Append("select id,CustomerID,cwny,CollectedAmount,MaterialCost,LabourCost,FixedApportionment,ChangeApportionment,CompanyMaori,BusinessProfit,ConstructionProfit,DesignProfit,CompanyProfit,Remarks ");
			strSql.Append(" FROM Financial_Reports_SingleCustomer ");
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
			strSql.Append(" id,CustomerID,cwny,CollectedAmount,MaterialCost,LabourCost,FixedApportionment,ChangeApportionment,CompanyMaori,BusinessProfit,ConstructionProfit,DesignProfit,CompanyProfit,Remarks ");
			strSql.Append(" FROM Financial_Reports_SingleCustomer ");
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
			strSql.Append("select count(1) FROM Financial_Reports_SingleCustomer ");
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
			strSql.Append(")AS Row, T.*  from Financial_Reports_SingleCustomer T ");
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
			parameters[0].Value = "Financial_Reports_SingleCustomer";
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
        public DataSet GetListPage(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "   A.*,B.Customer,B.address FROM dbo.Financial_Reports_SingleCustomer A");
            strSql.Append(" INNER JOIN dbo.CRM_Customer B ON	A.CustomerID=B.id ");

            strSql.Append(" WHERE ( a.id not in ( SELECT top " + (PageIndex - 1) * PageSize + " A.id FROM Financial_Reports_SingleCustomer A INNER JOIN dbo.CRM_Customer B ON	A.CustomerID=B.id  ");
            if (filedOrder != "  a.id  desc")
            {
                strSql.Append(" where " + strWhere + " order by " + filedOrder + " ,a.id desc) )");
            }
            else
            {
                strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) )");
            };


            strSql1.Append(" select count(a.id) FROM Financial_Reports_SingleCustomer   A");
            strSql1.Append(" INNER JOIN dbo.CRM_Customer B ON	A.CustomerID=B.id ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            if (filedOrder != "  a.id  desc")
            {
                strSql.Append(" ,a.id desc ");
            };
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }


        public DataSet GetListPage1(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "   A.*,'【'+B.Customer+'】'+B.address AS Customer,B.address FROM dbo.Financial_Reports_SingleCustomer_KH A");
            strSql.Append(" LEFT JOIN dbo.CRM_Customer B ON	A.CustomerID=B.id ");

            strSql.Append(" WHERE ( a.id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM Financial_Reports_SingleCustomer_KH  ");
            //if (filedOrder != "  a.id  desc")
            //{
            //    strSql.Append(" where " + strWhere + " order by " + filedOrder + " ,a.id desc) )");
            //}
            //else
            {
                strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) )");
            };


            strSql1.Append(" select count(a.id) FROM Financial_Reports_SingleCustomer_KH   A");
            strSql1.Append(" LEFT JOIN dbo.CRM_Customer B ON	A.CustomerID=B.id ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            //if (filedOrder != "  a.id  desc")
            //{
            //    strSql.Append(" ,a.id desc ");
            //};
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }
        public DataSet ToExcel()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select ");
            sb.Append(" '【'+B.Customer+'】'+B.address AS '客户' ,");
            sb.AppendLine("    cwny '财务年月',  ");
            sb.AppendLine("           costtype '类型',  ");
            sb.AppendLine("           summary '摘要',  ");
            sb.AppendLine("           Price '价格',  ");
            sb.AppendLine("           QTY '数量',  ");
            sb.AppendLine("           --ArSum ,  ");
            sb.AppendLine("           BudgeQty '预算数量',  ");
            sb.AppendLine("           BudgeAmount '预算金额',  ");
            sb.AppendLine("           CollectedAmount '收款金额',  ");
            sb.AppendLine("           MaterialCost '材料成本',  ");
            sb.AppendLine("           LabourCost '人工成本',  ");
            sb.AppendLine("           --FixedApportionment '',  ");
            sb.AppendLine("           --ChangeApportionment ,  ");
            sb.AppendLine("           CompanyMaori '公司利润',  ");
            sb.AppendLine("           BusinessProfit '业务利润',  ");
            sb.AppendLine("           ConstructionProfit '施工利润',  ");
            sb.AppendLine("           DesignProfit '设计利润',  ");
            sb.AppendLine("          -- CompanyProfit '公司利润',  ");
            sb.AppendLine("           A.Remarks '备注'  ");

            sb.Append(" FROM Financial_Reports_SingleCustomer_KH  A");
            sb.Append(" LEFT JOIN dbo.CRM_Customer B ON	A.CustomerID=B.id ");


            //if (strWhere.Trim() != "")
            //{
            //    strSql.Append(" where " + strWhere);
            //}
            return DbHelperSQL.Query(sb.ToString());
        }

        #endregion  ExtensionMethod
    }
}

