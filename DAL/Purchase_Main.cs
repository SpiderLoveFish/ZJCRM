using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Purchase_Main
	/// </summary>
	public partial class Purchase_Main
	{
		public Purchase_Main()
		{}
		#region  BasicMethod

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(string Purid)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Purchase_Main");
			strSql.Append(" where Purid=SQL2012Purid ");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012Purid", SqlDbType.VarChar,8)			};
			parameters[0].Value = Purid;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}

        public string GetMaxPurId()
        {
            string per = "P";
            per = per + DateTime.Now.ToString("yyMMdd-");
            string strsql = "select max(REPLACE(Purid,'" + per + "',''))+1 from Purchase_Main where Purid like '" + per + "%'";
            object obj = DbHelperSQL.GetSingle(strsql);
            if (obj == null)
            {
                return per + "001";
            }
            else
            {
                return per + int.Parse(obj.ToString()).ToString("000");
            }

            // return DbHelperSQL.GetMaxID("id", "CRM_CEStage");
        }
		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.Purchase_Main model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Purchase_Main(");
			strSql.Append("Purid,supplier_id,supplier_name,purdate,paid_amount,payable_amount,arrears,isNode,remarks,correlation_id,materialman,customid,txm)");
			strSql.Append(" values (");
			strSql.Append("SQL2012Purid,SQL2012supplier_id,SQL2012supplier_name,SQL2012purdate,SQL2012paid_amount,SQL2012payable_amount,SQL2012arrears,SQL2012isNode,SQL2012remarks,SQL2012correlation_id,SQL2012materialman,SQL2012customid,SQL2012txm)");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012Purid", SqlDbType.VarChar,8),
					new SqlParameter("SQL2012supplier_id", SqlDbType.VarChar,8),
					new SqlParameter("SQL2012supplier_name", SqlDbType.NVarChar,100),
					new SqlParameter("SQL2012purdate", SqlDbType.DateTime),
					new SqlParameter("SQL2012paid_amount", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012payable_amount", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012arrears", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012isNode", SqlDbType.Int,4),
					new SqlParameter("SQL2012remarks", SqlDbType.VarChar,250),
					new SqlParameter("SQL2012correlation_id", SqlDbType.VarChar,30),
					new SqlParameter("SQL2012materialman", SqlDbType.VarChar,20),
					new SqlParameter("SQL2012customid", SqlDbType.Int,4),
					new SqlParameter("SQL2012txm", SqlDbType.VarChar,50)};
			parameters[0].Value = model.Purid;
			parameters[1].Value = model.supplier_id;
			parameters[2].Value = model.supplier_name;
			parameters[3].Value = model.purdate;
			parameters[4].Value = model.paid_amount;
			parameters[5].Value = model.payable_amount;
			parameters[6].Value = model.arrears;
			parameters[7].Value = model.isNode;
			parameters[8].Value = model.remarks;
			parameters[9].Value = model.correlation_id;
			parameters[10].Value = model.materialman;
			parameters[11].Value = model.customid;
			parameters[12].Value = model.txm;

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
		public bool Update(XHD.Model.Purchase_Main model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Purchase_Main set ");
			strSql.Append("supplier_id=SQL2012supplier_id,");
			strSql.Append("supplier_name=SQL2012supplier_name,");
			strSql.Append("purdate=SQL2012purdate,");
			strSql.Append("paid_amount=SQL2012paid_amount,");
			strSql.Append("payable_amount=SQL2012payable_amount,");
			strSql.Append("arrears=SQL2012arrears,");
			strSql.Append("isNode=SQL2012isNode,");
			strSql.Append("remarks=SQL2012remarks,");
			strSql.Append("correlation_id=SQL2012correlation_id,");
			strSql.Append("materialman=SQL2012materialman,");
			strSql.Append("customid=SQL2012customid,");
			strSql.Append("txm=SQL2012txm");
			strSql.Append(" where Purid=SQL2012Purid ");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012supplier_id", SqlDbType.VarChar,8),
					new SqlParameter("SQL2012supplier_name", SqlDbType.NVarChar,100),
					new SqlParameter("SQL2012purdate", SqlDbType.DateTime),
					new SqlParameter("SQL2012paid_amount", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012payable_amount", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012arrears", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012isNode", SqlDbType.Int,4),
					new SqlParameter("SQL2012remarks", SqlDbType.VarChar,250),
					new SqlParameter("SQL2012correlation_id", SqlDbType.VarChar,30),
					new SqlParameter("SQL2012materialman", SqlDbType.VarChar,20),
					new SqlParameter("SQL2012customid", SqlDbType.Int,4),
					new SqlParameter("SQL2012txm", SqlDbType.VarChar,50),
					new SqlParameter("SQL2012Purid", SqlDbType.VarChar,8)};
			parameters[0].Value = model.supplier_id;
			parameters[1].Value = model.supplier_name;
			parameters[2].Value = model.purdate;
			parameters[3].Value = model.paid_amount;
			parameters[4].Value = model.payable_amount;
			parameters[5].Value = model.arrears;
			parameters[6].Value = model.isNode;
			parameters[7].Value = model.remarks;
			parameters[8].Value = model.correlation_id;
			parameters[9].Value = model.materialman;
			parameters[10].Value = model.customid;
			parameters[11].Value = model.txm;
			parameters[12].Value = model.Purid;

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
		public bool Delete(string Purid)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Purchase_Main ");
            strSql.Append(" where Purid='" + Purid + "'  and isNode=0");
			SqlParameter[] parameters = { 	};
		 
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
		public bool DeleteList(string Puridlist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Purchase_Main ");
			strSql.Append(" where Purid in ("+Puridlist + ")  ");
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
		public XHD.Model.Purchase_Main GetModel(string Purid)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 Purid,supplier_id,supplier_name,purdate,paid_amount,payable_amount,arrears,isNode,remarks,correlation_id,materialman,customid,txm from Purchase_Main ");
			strSql.Append(" where Purid=SQL2012Purid ");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012Purid", SqlDbType.VarChar,8)			};
			parameters[0].Value = Purid;

			XHD.Model.Purchase_Main model=new XHD.Model.Purchase_Main();
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
		public XHD.Model.Purchase_Main DataRowToModel(DataRow row)
		{
			XHD.Model.Purchase_Main model=new XHD.Model.Purchase_Main();
			if (row != null)
			{
				if(row["Purid"]!=null)
				{
					model.Purid=row["Purid"].ToString();
				}
				if(row["supplier_id"]!=null)
				{
					model.supplier_id=row["supplier_id"].ToString();
				}
				if(row["supplier_name"]!=null)
				{
					model.supplier_name=row["supplier_name"].ToString();
				}
				if(row["purdate"]!=null && row["purdate"].ToString()!="")
				{
					model.purdate=DateTime.Parse(row["purdate"].ToString());
				}
				if(row["paid_amount"]!=null && row["paid_amount"].ToString()!="")
				{
					model.paid_amount=decimal.Parse(row["paid_amount"].ToString());
				}
				if(row["payable_amount"]!=null && row["payable_amount"].ToString()!="")
				{
					model.payable_amount=decimal.Parse(row["payable_amount"].ToString());
				}
				if(row["arrears"]!=null && row["arrears"].ToString()!="")
				{
					model.arrears=decimal.Parse(row["arrears"].ToString());
				}
				if(row["isNode"]!=null && row["isNode"].ToString()!="")
				{
		 
                        model.customid = int.Parse(row["isNode"].ToString());
					 
				}
				if(row["remarks"]!=null)
				{
					model.remarks=row["remarks"].ToString();
				}
				if(row["correlation_id"]!=null)
				{
					model.correlation_id=row["correlation_id"].ToString();
				}
				if(row["materialman"]!=null)
				{
					model.materialman=row["materialman"].ToString();
				}
				if(row["customid"]!=null && row["customid"].ToString()!="")
				{
					model.customid=int.Parse(row["customid"].ToString());
				}
				if(row["txm"]!=null)
				{
					model.txm=row["txm"].ToString();
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
			strSql.Append("select Purid,supplier_id,supplier_name,purdate,paid_amount,payable_amount,arrears,isNode,remarks,correlation_id,materialman,customid,txm ");
			strSql.Append(" FROM Purchase_Main ");
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
			strSql.Append(" Purid,supplier_id,supplier_name,purdate,paid_amount,payable_amount,arrears,isNode,remarks,correlation_id,materialman,customid,txm ");
			strSql.Append(" FROM Purchase_Main ");
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
			strSql.Append("select count(1) FROM Purchase_Main ");
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
				strSql.Append("order by T.Purid desc");
			}
			strSql.Append(")AS Row, T.*  from Purchase_Main T ");
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
					new SqlParameter("SQL2012tblName", SqlDbType.VarChar, 255),
					new SqlParameter("SQL2012fldName", SqlDbType.VarChar, 255),
					new SqlParameter("SQL2012PageSize", SqlDbType.Int),
					new SqlParameter("SQL2012PageIndex", SqlDbType.Int),
					new SqlParameter("SQL2012IsReCount", SqlDbType.Bit),
					new SqlParameter("SQL2012OrderType", SqlDbType.Bit),
					new SqlParameter("SQL2012strWhere", SqlDbType.VarChar,1000),
					};
			parameters[0].Value = "Purchase_Main";
			parameters[1].Value = "Purid";
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
        public DataSet GetPurchase_Main(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "   A.*,B.Customer,B.tel,B.address FROM  dbo.Purchase_Main  A");
            strSql.Append(" INNER JOIN  dbo.CRM_Customer B ON A.customid=B.id ");
            strSql.Append(" WHERE  Purid not in ( SELECT top " + (PageIndex - 1) * PageSize + " Purid FROM Purchase_Main  ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(Purid) FROM Purchase_Main   ");

            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                //strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }
      
        public DataSet GetCgGl_Gys_Main(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  * FROM  dbo.CgGl_Gys_Main ");
            strSql.Append(" WHERE  id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM CgGl_Gys_Main  ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM CgGl_Gys_Main   ");

            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }


        public bool Add(string pid,string supid,string user,string cid,string remarks,string isgdd)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("INSERT INTO dbo.Purchase_Main");
            sb.AppendLine("        ( Purid ,");
            sb.AppendLine("          supplier_id ,");
            sb.AppendLine("          supplier_name ,");
            sb.AppendLine("          purdate ,");
            sb.AppendLine("          paid_amount ,");
            sb.AppendLine("          payable_amount ,");
            sb.AppendLine("          arrears ,");
            sb.AppendLine("          isNode ,");
            sb.AppendLine("          remarks ,");
            sb.AppendLine("          correlation_id ,");
            sb.AppendLine("          materialman ,");
            sb.AppendLine("          customid ,");
            sb.AppendLine("          txm,IsGD");
            sb.AppendLine("        )");
            sb.AppendLine("SELECT '" + pid + "',ID,Name,GETDATE(),0,0,0,0,'" + remarks + "','','" + user + "','" + cid + "',''," + isgdd + "");
            sb.AppendLine(" FROM dbo.CgGl_Gys_Main");
            sb.AppendLine("  WHERE ID="+supid+"");
            SqlParameter[] parameters = { };
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
        public bool updateremarks(string pid, string remarks,string date,string isgd)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine(" update Purchase_Main");
            sb.AppendLine("  set ");
            sb.AppendLine("          IsGD=" + isgd + ",");
            sb.AppendLine("          purdate='" + date + "',");
            sb.AppendLine("          remarks='"+remarks+"'");
            sb.AppendLine(" where Purid='"+pid+"'");
            SqlParameter[] parameters = { };
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
        public DataSet GetListdetail(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select A.* ");
            strSql.Append(" ,B.Customer,B.address,B.tel,B.Emp_sg,C.Address as gysdz");
            strSql.Append(" FROM Purchase_Main A");
            strSql.Append(" INNER JOIN  dbo.CRM_Customer B ON A.customid=B.id");
            strSql.Append(" INNER JOIN  dbo.CgGl_Gys_Main C ON A.supplier_id=C.id");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        public int updatetotal(string pid, decimal status)
        {
            SqlParameter[] parameters = {
					new SqlParameter("@pid", SqlDbType.VarChar,50),
					new SqlParameter("@status", SqlDbType.Decimal,10) 
                                     };
            parameters[0].Value = pid;
            parameters[1].Value = status;
            int rowaffected = 0;
            DbHelperSQL.RunProcedure("USP_ComputerPurScore", parameters, out rowaffected);
            return rowaffected;
        }

        public bool Updatestatus(string pid,string status)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update Purchase_Main set ");

            strSql.Append("isNode=" + status + "");
             if(status=="3")//确定
                 strSql.Append(" ,ConfirmDate=GETDATE() ");
            strSql.Append(" where Purid='"+pid+"' ");
            SqlParameter[] parameters = {
					 };
  
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
       
        public DataSet GetKcGl_Jcb_Cklb(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  * FROM  dbo.KcGl_Jcb_Cklb ");
            strSql.Append(" WHERE  ID not in ( SELECT top " + (PageIndex - 1) * PageSize + " Purid FROM KcGl_Jcb_Cklb  ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(ID) FROM KcGl_Jcb_Cklb   ");

            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }
        public DataSet GetListCklb(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  ID,Name ");
            strSql.Append(" from dbo.KcGl_Jcb_Cklb WHERE isdel='Y'");
             if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }


        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList_main(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select A.* ,B.Customer,B.tel,B.address ");
            strSql.Append(" FROM Purchase_Main A");
            strSql.Append(" INNER JOIN  dbo.CRM_Customer B ON A.customid=B.id ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }


        /// <summary>
        /// 更新发票
        /// </summary>
        public bool UpdateInvoice(string orderid)
        {
            StringBuilder strSql1 = new StringBuilder();
            strSql1.Append(" /*更新发票*/ ");
            strSql1.Append(" UPDATE Purchase_Main SET ");
            strSql1.Append("     invoice_money=(SELECT SUM(ISNULL(invoice_amount,0)) AS Expr1 FROM CRM_Cope_invoice WHERE ( ISNULL(isDelete,0)=0 and  order_id='" + orderid + "'))  ");
            strSql1.Append(" WHERE (Purid='" + orderid + "') ");

            StringBuilder strSql2 = new StringBuilder();
            strSql2.Append(" /*更新发票*/ ");
            strSql2.Append(" UPDATE Purchase_Main SET ");
            strSql2.Append("     arrears_invoice= ISNULL(payable_amount,0) - ISNULL(invoice_money,0)  ");
            strSql2.Append(" WHERE (Purid='" + orderid + "') ");

            int rows1 = DbHelperSQL.ExecuteSql(strSql1.ToString());
            int rows2 = DbHelperSQL.ExecuteSql(strSql2.ToString());

            if (rows1 > 0 && rows2 > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /// <summary>
        /// 更新发票
        /// </summary>
        public bool UpdateReceive(string orderid)
        {
            StringBuilder strSql1 = new StringBuilder();
            strSql1.Append(" /*更新收款*/ ");
            strSql1.Append(" UPDATE Purchase_Main SET ");
            strSql1.Append("     paid_amount=(SELECT SUM(ISNULL(Receive_amount,0)) AS Expr1 FROM CRM_Cope WHERE ( ISNULL(isDelete,0)=0 and order_id='" + orderid + "'))  ");
            strSql1.Append(" WHERE (Purid='" + orderid + "') ");

            StringBuilder strSql2 = new StringBuilder();
            strSql2.Append(" /*更新收款*/ ");
            strSql2.Append(" UPDATE Purchase_Main SET ");
            strSql2.Append("     arrears= ISNULL(payable_amount,0) - ISNULL(paid_amount,0)  ");
            strSql2.Append(" WHERE (Purid='" + orderid + "') ");

            int rows1 = DbHelperSQL.ExecuteSql(strSql1.ToString());
            int rows2 = DbHelperSQL.ExecuteSql(strSql2.ToString());

            if (rows1 > 0 && rows2 > 0)
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

