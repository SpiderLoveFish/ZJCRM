using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Financial_Labour_Cost_Recive
	/// </summary>
	public partial class Financial_Labour_Cost_Recive
	{
		public Financial_Labour_Cost_Recive()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "Financial_Labour_Cost_Recive"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Financial_Labour_Cost_Recive");
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
		public int Add(XHD.Model.Financial_Labour_Cost_Recive model)
		{
            try
            {
                StringBuilder strSql = new StringBuilder();
                strSql.Append("insert into Financial_Labour_Cost_Recive(");
                strSql.Append("Serialnumber,F_Num,CustomerID,F_StyleID,F_StyleName,receive_money,arrears_money,invoice_money,arrears_invoice,TotalAmount,worker,Remarks,FromWhere,CreatePerson,CreateTime,Order_status_id,Order_status,IsStatus,DeleteTime,Pay_type_id,Pay_type,IsHaveDetail)");
                strSql.Append(" values (");
                strSql.Append("@Serialnumber,@F_Num,@CustomerID,@F_StyleID,@F_StyleName,@receive_money,@arrears_money,@invoice_money,@arrears_invoice,@TotalAmount,@worker,@Remarks,@FromWhere,@CreatePerson,@CreateTime,@Order_status_id,@Order_status,@IsStatus,@DeleteTime,@Pay_type_id,@Pay_type,@IsHaveDetail)");
                strSql.Append(";select @@IDENTITY");
                SqlParameter[] parameters = {
                    new SqlParameter("@Serialnumber", SqlDbType.VarChar,250),
                    new SqlParameter("@F_Num", SqlDbType.VarChar,20),
                    new SqlParameter("@CustomerID", SqlDbType.Int,4),
                    new SqlParameter("@F_StyleID", SqlDbType.Int,4),
                    new SqlParameter("@F_StyleName", SqlDbType.VarChar,50),
                    new SqlParameter("@receive_money", SqlDbType.Float,8),
                    new SqlParameter("@arrears_money", SqlDbType.Float,8),
                    new SqlParameter("@invoice_money", SqlDbType.Float,8),
                    new SqlParameter("@arrears_invoice", SqlDbType.Float,8),
                    new SqlParameter("@TotalAmount", SqlDbType.Decimal,9),
                    new SqlParameter("@worker", SqlDbType.VarChar,50),
                    new SqlParameter("@Remarks", SqlDbType.VarChar,50),
                    new SqlParameter("@FromWhere", SqlDbType.VarChar,10),
                    new SqlParameter("@CreatePerson", SqlDbType.VarChar,20),
                    new SqlParameter("@CreateTime", SqlDbType.DateTime),
                    new SqlParameter("@Order_status_id", SqlDbType.Int,4),
                    new SqlParameter("@Order_status", SqlDbType.VarChar,50),
                    new SqlParameter("@IsStatus", SqlDbType.Char,1),
                    new SqlParameter("@DeleteTime", SqlDbType.DateTime),
                    new SqlParameter("@Pay_type_id", SqlDbType.Int,4),
                    new SqlParameter("@Pay_type", SqlDbType.VarChar,50),
                    new SqlParameter("@IsHaveDetail", SqlDbType.Char,1)};
                parameters[0].Value = model.Serialnumber;
                parameters[1].Value = model.F_Num;
                parameters[2].Value = model.CustomerID;
                parameters[3].Value = model.F_StyleID;
                parameters[4].Value = model.F_StyleName;
                parameters[5].Value = model.receive_money;
                parameters[6].Value = model.arrears_money;
                parameters[7].Value = model.invoice_money;
                parameters[8].Value = model.arrears_invoice;
                parameters[9].Value = model.TotalAmount;
                parameters[10].Value = model.worker;
                parameters[11].Value = model.Remarks;
                parameters[12].Value = model.FromWhere;
                parameters[13].Value = model.CreatePerson;
                parameters[14].Value = model.CreateTime;
                parameters[15].Value = model.Order_status_id;
                parameters[16].Value = model.Order_status;
                parameters[17].Value = model.IsStatus;
                parameters[18].Value = model.DeleteTime;
                parameters[19].Value = model.Pay_type_id;
                parameters[20].Value = model.Pay_type;
                parameters[21].Value = model.IsHaveDetail;

                object obj = DbHelperSQL.GetSingle(strSql.ToString(), parameters);
                if (obj == null)
                {
                    return 0;
                }
                else
                {
                    return Convert.ToInt32(obj);
                }
            }
            catch (Exception e)
            {
                return 0;
            }
		}
		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(XHD.Model.Financial_Labour_Cost_Recive model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Financial_Labour_Cost_Recive set ");
			strSql.Append("Serialnumber=@Serialnumber,");
			strSql.Append("F_Num=@F_Num,");
			strSql.Append("CustomerID=@CustomerID,");
			strSql.Append("F_StyleID=@F_StyleID,");
			strSql.Append("F_StyleName=@F_StyleName,");
			strSql.Append("receive_money=@receive_money,");
			strSql.Append("arrears_money=@arrears_money,");
			strSql.Append("invoice_money=@invoice_money,");
			strSql.Append("arrears_invoice=@arrears_invoice,");
			strSql.Append("TotalAmount=@TotalAmount,");
			strSql.Append("worker=@worker,");
			strSql.Append("Remarks=@Remarks,");
			strSql.Append("FromWhere=@FromWhere,");
			strSql.Append("CreatePerson=@CreatePerson,");
			strSql.Append("CreateTime=@CreateTime,");
			strSql.Append("Order_status_id=@Order_status_id,");
			strSql.Append("Order_status=@Order_status,");
			strSql.Append("IsStatus=@IsStatus,");
			strSql.Append("DeleteTime=@DeleteTime,");
			strSql.Append("Pay_type_id=@Pay_type_id,");
			strSql.Append("Pay_type=@Pay_type,");
			strSql.Append("IsHaveDetail=@IsHaveDetail");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@Serialnumber", SqlDbType.VarChar,250),
					new SqlParameter("@F_Num", SqlDbType.VarChar,20),
					new SqlParameter("@CustomerID", SqlDbType.Int,4),
					new SqlParameter("@F_StyleID", SqlDbType.Int,4),
					new SqlParameter("@F_StyleName", SqlDbType.VarChar,50),
					new SqlParameter("@receive_money", SqlDbType.Float,8),
					new SqlParameter("@arrears_money", SqlDbType.Float,8),
					new SqlParameter("@invoice_money", SqlDbType.Float,8),
					new SqlParameter("@arrears_invoice", SqlDbType.Float,8),
					new SqlParameter("@TotalAmount", SqlDbType.Decimal,9),
					new SqlParameter("@worker", SqlDbType.VarChar,50),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
					new SqlParameter("@FromWhere", SqlDbType.VarChar,10),
					new SqlParameter("@CreatePerson", SqlDbType.VarChar,20),
					new SqlParameter("@CreateTime", SqlDbType.DateTime),
					new SqlParameter("@Order_status_id", SqlDbType.Int,4),
					new SqlParameter("@Order_status", SqlDbType.VarChar,50),
					new SqlParameter("@IsStatus", SqlDbType.Char,1),
					new SqlParameter("@DeleteTime", SqlDbType.DateTime),
					new SqlParameter("@Pay_type_id", SqlDbType.Int,4),
					new SqlParameter("@Pay_type", SqlDbType.VarChar,50),
					new SqlParameter("@IsHaveDetail", SqlDbType.Char,1),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.Serialnumber;
			parameters[1].Value = model.F_Num;
			parameters[2].Value = model.CustomerID;
			parameters[3].Value = model.F_StyleID;
			parameters[4].Value = model.F_StyleName;
			parameters[5].Value = model.receive_money;
			parameters[6].Value = model.arrears_money;
			parameters[7].Value = model.invoice_money;
			parameters[8].Value = model.arrears_invoice;
			parameters[9].Value = model.TotalAmount;
			parameters[10].Value = model.worker;
			parameters[11].Value = model.Remarks;
			parameters[12].Value = model.FromWhere;
			parameters[13].Value = model.CreatePerson;
			parameters[14].Value = model.CreateTime;
			parameters[15].Value = model.Order_status_id;
			parameters[16].Value = model.Order_status;
			parameters[17].Value = model.IsStatus;
			parameters[18].Value = model.DeleteTime;
			parameters[19].Value = model.Pay_type_id;
			parameters[20].Value = model.Pay_type;
			parameters[21].Value = model.IsHaveDetail;
			parameters[22].Value = model.id;

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
			strSql.Append("delete from Financial_Labour_Cost_Recive ");
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
			strSql.Append("delete from Financial_Labour_Cost_Recive ");
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
		public XHD.Model.Financial_Labour_Cost_Recive GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,Serialnumber,F_Num,CustomerID,F_StyleID,F_StyleName,receive_money,arrears_money,invoice_money,arrears_invoice,TotalAmount,worker,Remarks,FromWhere,CreatePerson,CreateTime,Order_status_id,Order_status,IsStatus,DeleteTime,Pay_type_id,Pay_type,IsHaveDetail from Financial_Labour_Cost_Recive ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.Financial_Labour_Cost_Recive model=new XHD.Model.Financial_Labour_Cost_Recive();
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
		public XHD.Model.Financial_Labour_Cost_Recive DataRowToModel(DataRow row)
		{
			XHD.Model.Financial_Labour_Cost_Recive model=new XHD.Model.Financial_Labour_Cost_Recive();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["Serialnumber"]!=null)
				{
					model.Serialnumber=row["Serialnumber"].ToString();
				}
				if(row["F_Num"]!=null)
				{
					model.F_Num=row["F_Num"].ToString();
				}
				if(row["CustomerID"]!=null && row["CustomerID"].ToString()!="")
				{
					model.CustomerID=int.Parse(row["CustomerID"].ToString());
				}
				if(row["F_StyleID"]!=null && row["F_StyleID"].ToString()!="")
				{
					model.F_StyleID=int.Parse(row["F_StyleID"].ToString());
				}
				if(row["F_StyleName"]!=null)
				{
					model.F_StyleName=row["F_StyleName"].ToString();
				}
				if(row["receive_money"]!=null && row["receive_money"].ToString()!="")
				{
					model.receive_money=decimal.Parse(row["receive_money"].ToString());
				}
				if(row["arrears_money"]!=null && row["arrears_money"].ToString()!="")
				{
					model.arrears_money=decimal.Parse(row["arrears_money"].ToString());
				}
				if(row["invoice_money"]!=null && row["invoice_money"].ToString()!="")
				{
					model.invoice_money=decimal.Parse(row["invoice_money"].ToString());
				}
				if(row["arrears_invoice"]!=null && row["arrears_invoice"].ToString()!="")
				{
					model.arrears_invoice=decimal.Parse(row["arrears_invoice"].ToString());
				}
				if(row["TotalAmount"]!=null && row["TotalAmount"].ToString()!="")
				{
					model.TotalAmount=decimal.Parse(row["TotalAmount"].ToString());
				}
				if(row["worker"]!=null)
				{
					model.worker=row["worker"].ToString();
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
				if(row["Order_status_id"]!=null && row["Order_status_id"].ToString()!="")
				{
					model.Order_status_id=int.Parse(row["Order_status_id"].ToString());
				}
				if(row["Order_status"]!=null)
				{
					model.Order_status=row["Order_status"].ToString();
				}
				if(row["IsStatus"]!=null)
				{
					model.IsStatus=row["IsStatus"].ToString();
				}
				if(row["DeleteTime"]!=null && row["DeleteTime"].ToString()!="")
				{
					model.DeleteTime=DateTime.Parse(row["DeleteTime"].ToString());
				}
				if(row["Pay_type_id"]!=null && row["Pay_type_id"].ToString()!="")
				{
					model.Pay_type_id=int.Parse(row["Pay_type_id"].ToString());
				}
				if(row["Pay_type"]!=null)
				{
					model.Pay_type=row["Pay_type"].ToString();
				}
				if(row["IsHaveDetail"]!=null)
				{
					model.IsHaveDetail=row["IsHaveDetail"].ToString();
				}
			}
			return model;
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public DataSet GetList(string strWhere)
		{
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("    SELECT   A.CustomerID ,  ");
            sb.AppendLine("             A.F_Num ,customer.Customer+'['+customer.address+']' AS customer,  ");
            sb.AppendLine("             ISNULL(A.Order_amount, 0) Order_amount ,  ");
            sb.AppendLine("             ISNULL(B.dj_amount, 0) dj_amount ,  ");
            sb.AppendLine("             ISNULL(C.zx_amount, 0) zx_amount ,  ");
            sb.AppendLine("             ( ISNULL(A.Order_amount, 0) - ISNULL(B.dj_amount, 0)  ");
            sb.AppendLine("               - ISNULL(C.zx_amount, 0) ) wf_amount  ");
            sb.AppendLine("    FROM     ( SELECT    CustomerID ,  ");
            sb.AppendLine("                         F_Num ,  ");
            sb.AppendLine("                         SUM(TotalAmount) Order_amount  ");
            sb.AppendLine("               FROM      dbo.Financial_Labour_Cost_Recive  ");
            sb.AppendLine("               GROUP BY  CustomerID ,  ");
            sb.AppendLine("                         F_Num  ");
            sb.AppendLine("             ) A  ");
            sb.AppendLine("             LEFT JOIN ( SELECT  Customer_id ,Customer_name,  ");
            sb.AppendLine("                                 SUM(Receive_amount) dj_amount  ");
            sb.AppendLine("                         FROM    CRM_receive  ");
            sb.AppendLine("                         WHERE   receive_direction_name IN ( '收定金', '退定金' )  ");
            //sb.AppendLine("                                 AND isDelete = 1  ");
            sb.AppendLine("                         GROUP BY Customer_id,Customer_name  ");
            sb.AppendLine("                       ) B ON A.CustomerID = B.Customer_id AND	A.F_Num=B.Customer_name  ");
            sb.AppendLine("             LEFT JOIN ( SELECT  Customer_id ,Customer_name,  ");
            sb.AppendLine("                                 SUM(Receive_amount) zx_amount  ");
            sb.AppendLine("                         FROM    CRM_receive  ");
            sb.AppendLine("                         WHERE   receive_direction_name IN ( '收装修款', '退装修款' )  ");
            //sb.AppendLine("                                 AND isDelete = 1  ");
            sb.AppendLine("                         GROUP BY Customer_id,Customer_name  ");
            sb.AppendLine("                       ) C ON A.CustomerID = C.Customer_id  AND	A.F_Num=C.Customer_name  ");
            sb.AppendLine("        INNER JOIN dbo.CRM_Customer customer ON	 A.CustomerID=customer.id   ");

            if (strWhere.Trim()!="")
			{
                sb.Append(" where "+strWhere);
			}
			return DbHelperSQL.Query(sb.ToString());
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
			strSql.Append(" id,Serialnumber,F_Num,CustomerID,F_StyleID,F_StyleName,receive_money,arrears_money,invoice_money,arrears_invoice,TotalAmount,worker,Remarks,FromWhere,CreatePerson,CreateTime,Order_status_id,Order_status,IsStatus,DeleteTime,Pay_type_id,Pay_type,IsHaveDetail ");
			strSql.Append(" FROM Financial_Labour_Cost_Recive ");
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
			strSql.Append("select count(1) FROM Financial_Labour_Cost_Recive ");
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
			strSql.Append(")AS Row, T.*  from Financial_Labour_Cost_Recive T ");
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
			parameters[0].Value = "Financial_Labour_Cost_Recive";
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
        /// 更新发票
        /// </summary>
        public bool UpdateZT(int status, int empid, int cid, int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update CRM_receive set Delete_time=getdate(), ");
            strSql.Append("isDelete=" + status + " ");

            strSql.Append(" where id=" + id + "");
            strSql.Append(" and Customer_id=" + cid + "");
            //  strSql.Append(" and DoPerson=" + empid + "");
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
        public bool UpdateInvoice(string orderid)
        {
            StringBuilder strSql1 = new StringBuilder();
            strSql1.Append(" /*更新发票*/ ");
            strSql1.Append(" UPDATE Financial_Labour_Cost_Recive SET ");
            strSql1.Append("     invoice_money=(SELECT SUM(ISNULL(invoice_amount,0)) AS Expr1 FROM CRM_invoice WHERE ( ISNULL(isDelete,0)=0 and  Customer_name='" + orderid + "'))  ");
            strSql1.Append(" WHERE (F_Num='" + orderid + "') ");

            StringBuilder strSql2 = new StringBuilder();
            strSql2.Append(" /*更新发票*/ ");
            strSql2.Append(" UPDATE Financial_Labour_Cost_Recive SET ");
            strSql2.Append("     arrears_invoice= ISNULL(TotalAmount,0) - ISNULL(invoice_money,0)  ");
            strSql2.Append(" WHERE (F_Num='" + orderid + "') ");

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
            strSql1.Append(" UPDATE Financial_Labour_Cost_Recive SET ");
            strSql1.Append("     receive_money=(SELECT SUM(ISNULL(Receive_amount,0)) AS Expr1 FROM CRM_receive WHERE ( ISNULL(isDelete,0)=0 and Customer_name='" + orderid + "'))  ");
            strSql1.Append(" WHERE (F_Num='" + orderid + "') ");

            StringBuilder strSql2 = new StringBuilder();
            strSql2.Append(" /*更新收款*/ ");
            strSql2.Append(" UPDATE Financial_Labour_Cost_Recive SET ");
            strSql2.Append("     arrears_money= ISNULL(TotalAmount,0) - ISNULL(receive_money,0)  ");
            strSql2.Append(" WHERE (F_Num='" + orderid + "') ");

            StringBuilder sb = new StringBuilder();
            sb.AppendLine("  UPDATE Financial_Labour_Cost  ");
            sb.AppendLine("  SET	 receive_money =(SELECT SUM(ISNULL(Receive_amount,0)) AS Expr1 FROM CRM_receive WHERE ( ISNULL(isDelete,0)=0 and Customer_name='" + orderid + "'))  ");
            sb.AppendLine("  WHERE F_Num='" + orderid + "' ");


            int rows1 = DbHelperSQL.ExecuteSql(strSql1.ToString());
            int rows2 = DbHelperSQL.ExecuteSql(strSql2.ToString());
            int rows3 = DbHelperSQL.ExecuteSql(sb.ToString());
            //if (rows1 > 0 && rows2 > 0)
            if (rows3> 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="PageSize"></param>
        /// <param name="PageIndex"></param>
        /// <param name="strWhere"></param>
        /// <param name="filedOrder"></param>
        /// <param name="Total"></param>
        /// <returns></returns>
        public DataSet GetList_F_l_C_R(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbb = new StringBuilder();
            sbb.AppendLine("   ");
            sbb.AppendLine("            SELECT count(*)   ");
            sbb.AppendLine("            FROM(  ");
            sbb.AppendLine("                 SELECT ROW_NUMBER() OVER(ORDER BY C.Receive_date) AS rowId, id, Receive_num, receive_direction_name, Pay_type, Receive_amount, C_depname, C_empname, Receive_date, create_name,IsStatus FROM  ");
            sbb.AppendLine("                   (  ");
            sbb.AppendLine("                SELECT id, '' AS Receive_num, '应收' AS receive_direction_name, Pay_type, TotalAmount AS Receive_amount, '' AS C_depname, '' AS C_empname, '' AS Receive_date, '' AS create_name,''IsStatus  ");
            sbb.AppendLine("      FROM   ( select *,F_Num as Customer_name     FROM dbo.Financial_Labour_Cost_Recive ) Financial_Labour_Cost_Recive");
            sbb.AppendLine("           ");
            sbb.AppendLine("                UNION ALL  ");
            sbb.AppendLine("              SELECT id, Receive_num, receive_direction_name, Pay_type, Receive_amount, C_depname, C_empname, Receive_date, create_name  ");
            sbb.AppendLine("            ,CASE  isDelete WHEN 0 THEN '待确认' WHEN	1 THEN	 '已确认' WHEN	7 THEN '作废' END	 AS	 IsStatus  ");
            sbb.AppendLine("               FROM    CRM_receive  ");
            sbb.AppendLine("    WHERE " + strWhere + "  ");
            sbb.AppendLine("             ");
            sbb.AppendLine("              )C  ");
            sbb.AppendLine("           )D;  ");
            sbb.AppendLine("   ");

            sb.AppendLine("           SELECT TOP   " + PageSize + "    ");
            sb.AppendLine("          D.*  ");
            sb.AppendLine("           FROM(  ");
            sb.AppendLine("                 SELECT ROW_NUMBER() OVER(ORDER BY C.Receive_date) AS rowId, id, Receive_num, receive_direction_name, Pay_type, Receive_amount, C_depname, C_empname, Receive_date, create_name,IsStatus FROM  ");
            sb.AppendLine("                   (  ");
            sb.AppendLine("                SELECT id, '' AS Receive_num, '应收' AS receive_direction_name, Pay_type, TotalAmount AS Receive_amount, '' AS C_depname, '' AS C_empname, CreateTime AS Receive_date, worker AS create_name,''IsStatus  ");
            sb.AppendLine("      FROM   ( select *,F_Num as Customer_name     FROM dbo.Financial_Labour_Cost_Recive ) Financial_Labour_Cost_Recive");
            sb.AppendLine("    WHERE " + strWhere +"  ");
            sb.AppendLine("              ");
            sb.AppendLine("                UNION ALL  ");
            sb.AppendLine("              SELECT id, Receive_num, receive_direction_name, Pay_type, Receive_amount, C_depname, C_empname, Receive_date, create_name  ");
            sb.AppendLine("             ,CASE  isDelete WHEN 0 THEN '待确认' WHEN	1 THEN	 '已确认'  WHEN	7 THEN '作废' END	 AS	 IsStatus  ");
            sb.AppendLine("            FROM    CRM_receive  ");
            sb.AppendLine("    WHERE " + strWhere + "  ");
            sb.AppendLine("             ");
            sb.AppendLine("              )C  ");
            sb.AppendLine("           )D  ");
            sb.AppendLine("     WHERE   D.rowId NOT IN(SELECT TOP   " + (PageIndex - 1) * PageSize+"  ");
            sb.AppendLine("                              B.rowId  ");
            sb.AppendLine("                      FROM(  ");
            sb.AppendLine("                                  SELECT ROW_NUMBER() OVER(ORDER BY A.Receive_date) AS rowId, id, Receive_num, receive_direction_name, Pay_type, Receive_amount, C_depname, C_empname, Receive_date, create_name,IsStatus FROM  ");
            sb.AppendLine("                                  (  ");
            sb.AppendLine("                                  SELECT id, '' AS Receive_num, '应收' AS receive_direction_name, Pay_type, Total_Money AS Receive_amount, C_dep_name AS C_depname, C_emp_name AS C_empname, Order_date AS Receive_date, C_emp_name AS create_name,''IsStatus  ");
            sb.AppendLine("   ");
            sb.AppendLine("                                  FROM dbo.CRM_order  ");
            sb.AppendLine("    WHERE " + strWhere + "  ");
            sb.AppendLine("                                ");
            sb.AppendLine("   ");
            sb.AppendLine("                                  UNION ALL  ");
            sb.AppendLine("   ");
            sb.AppendLine("                                  SELECT id, Receive_num, receive_direction_name, Pay_type, Receive_amount, C_depname, C_empname, Receive_date, create_name  ");
            sb.AppendLine("                                  ,CASE  isDelete WHEN 0 THEN '待确认' WHEN	 1 THEN	 '已确认'  WHEN	7 THEN '作废' END	 AS	 IsStatus  ");
            sb.AppendLine("   ");
            sb.AppendLine("                                  FROM    CRM_receive  ");
            sb.AppendLine("    WHERE " + strWhere + "  ");
            sb.AppendLine("                                 ");
            sb.AppendLine("                                  )A  ");
            sb.AppendLine("                               )B  ");
            sb.AppendLine("                     )  ");
            sb.AppendLine("    ORDER BY D.rowId ;  ");
            sb.AppendLine("   ");
 

            Total = DbHelperSQL.Query(sbb.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(sb.ToString());
        }
        #endregion  ExtensionMethod
    }
}

