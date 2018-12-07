using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:PurchaseList
	/// </summary>
	public partial class PurchaseList
	{
		public PurchaseList()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "PurchaseList"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from PurchaseList");
			strSql.Append(" where id=SQL2012id");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(XHD.Model.PurchaseList model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into PurchaseList(");
			strSql.Append("CustomerID,category_id,product_id,DoTime,DoPerson,IsStatus,Price,AmountSum)");
			strSql.Append(" values (");
			strSql.Append("SQL2012CustomerID,SQL2012category_id,SQL2012product_id,SQL2012DoTime,SQL2012DoPerson,SQL2012IsStatus,SQL2012Price,SQL2012AmountSum)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012CustomerID", SqlDbType.Int,4),
					new SqlParameter("SQL2012category_id", SqlDbType.Int,4),
					new SqlParameter("SQL2012product_id", SqlDbType.Int,4),
					new SqlParameter("SQL2012DoTime", SqlDbType.DateTime),
					new SqlParameter("SQL2012DoPerson", SqlDbType.VarChar,20),
					new SqlParameter("SQL2012IsStatus", SqlDbType.Int,4),
					new SqlParameter("SQL2012Price", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012AmountSum", SqlDbType.Decimal,9)};
			parameters[0].Value = model.CustomerID;
			parameters[1].Value = model.category_id;
			parameters[2].Value = model.product_id;
			parameters[3].Value = model.DoTime;
			parameters[4].Value = model.DoPerson;
			parameters[5].Value = model.IsStatus;
			parameters[6].Value = model.Price;
			parameters[7].Value = model.AmountSum;

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
		public bool Update(XHD.Model.PurchaseList model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update PurchaseList set ");
			strSql.Append("CustomerID=SQL2012CustomerID,");
			strSql.Append("category_id=SQL2012category_id,");
			strSql.Append("product_id=SQL2012product_id,");
			strSql.Append("DoTime=SQL2012DoTime,");
			strSql.Append("DoPerson=SQL2012DoPerson,");
			strSql.Append("IsStatus=SQL2012IsStatus,");
			strSql.Append("Price=SQL2012Price,");
			strSql.Append("AmountSum=SQL2012AmountSum");
			strSql.Append(" where id=SQL2012id");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012CustomerID", SqlDbType.Int,4),
					new SqlParameter("SQL2012category_id", SqlDbType.Int,4),
					new SqlParameter("SQL2012product_id", SqlDbType.Int,4),
					new SqlParameter("SQL2012DoTime", SqlDbType.DateTime),
					new SqlParameter("SQL2012DoPerson", SqlDbType.VarChar,20),
					new SqlParameter("SQL2012IsStatus", SqlDbType.Int,4),
					new SqlParameter("SQL2012Price", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012AmountSum", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012id", SqlDbType.Int,4)};
			parameters[0].Value = model.CustomerID;
			parameters[1].Value = model.category_id;
			parameters[2].Value = model.product_id;
			parameters[3].Value = model.DoTime;
			parameters[4].Value = model.DoPerson;
			parameters[5].Value = model.IsStatus;
			parameters[6].Value = model.Price;
			parameters[7].Value = model.AmountSum;
			parameters[8].Value = model.id;

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
        /// 更新状态和数量
        /// </summary>
        /// <param name="status"></param>
        /// <param name="sum"></param>
        /// <param name="empid"></param>
        /// <param name="cid"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public bool UpdateRemarks(string SupplierName,string t_contents,   int cid, int id
            , DateTime RequestDate, string Sender, string ShippingMethod, string Receiver, string b1, string b2, string b3)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update PurchaseList set ");

            strSql.Append("SupplierName='" + SupplierName + "',");
            strSql.Append("RequestDate='" + RequestDate + "',");
            strSql.Append("Sender='" + Sender + "',");
            strSql.Append("ShippingMethod='" + ShippingMethod + "',");
            strSql.Append("Receiver='" + Receiver + "',");
            strSql.Append("b1='" + b1 + "',");
            strSql.Append("b2='" + b2 + "',");
            strSql.Append("b3='" + b3 + "',");
            strSql.Append("t_contents='" + t_contents + "'");
            strSql.Append(" where id=" + id + "");
            strSql.Append(" and CustomerID=" + cid + "");
            // strSql.Append(" and DoPerson=" + empid + "");
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
        /// 更新状态和数量
        /// </summary>
        /// <param name="status"></param>
        /// <param name="sum"></param>
        /// <param name="empid"></param>
        /// <param name="cid"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public bool UpdateSUM( decimal sum, int empid, int cid, int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update PurchaseList set ");
         
            strSql.Append("AmountSum="+sum+"");
            strSql.Append(" where id="+id+"");
            strSql.Append(" and CustomerID=" + cid + "");
           // strSql.Append(" and DoPerson=" + empid + "");
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
        /// 更新状态和数量
        /// </summary>
        /// <param name="status"></param>
        /// <param name="sum"></param>
        /// <param name="empid"></param>
        /// <param name="cid"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public bool UpdateZT(int status, int empid, int cid, int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update PurchaseList set DoTime=getdate(), ");
            strSql.Append("IsStatus=" + status + " ");
        
            strSql.Append(" where id=" + id + "");
            strSql.Append(" and CustomerID=" + cid + "");
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

        /// <summary>
        /// 多个选择插入数据
        /// </summary>
        /// <param name="cid"></param>
        /// <param name="pid"></param>
        /// <returns></returns>
        public int InsertList(int cid, string pid, string emp_id,string style)
        {
            string strsql = " INSERT INTO dbo.PurchaseList "+
                            " ( CustomerID ,  category_id ,  product_id ,DoTime , DoPerson , IsStatus , Price , AmountSum,SupplierName ) ";
                         if(style=="ALL")
                         {
                             strsql += " SELECT " + cid + ",category_id,product_id,GETDATE(),'" + emp_id + "',0,0,1 ,Suppliers" +
                               " FROM CRM_product WHERE product_id IN(" + pid + ")";
                             }
                         else if (style == "YS")
                         {
                             strsql += " SELECT " + cid + ",B.category_id,B.product_id,GETDATE(),'" + emp_id + "',0,A.totaldiscountprice,ISNULL(A.[SUM],1) AS [SUM],'' as Suppliers  " +
                                  " FROM budge_basicdetail A  INNER JOIN budge_basicmain c ON A.budge_id=c.ID inner join CRM_product B on A.xmid=B.product_id    WHERE product_id IN(" + pid + ") and C.customer_id=" + cid + "";
                           
                         }
                            
            SqlParameter[] parameters = { };
            int obj = DbHelperSQL.ExecuteSql(strsql, parameters);
            if (obj == 0)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from PurchaseList ");
			strSql.Append(" where id="+id+"");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012id", SqlDbType.Int,4)
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
			strSql.Append("delete from PurchaseList ");
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
		public XHD.Model.PurchaseList GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,CustomerID,category_id,product_id,DoTime,DoPerson,IsStatus,Price,AmountSum from PurchaseList ");
			strSql.Append(" where id=SQL2012id");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.PurchaseList model=new XHD.Model.PurchaseList();
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
		public XHD.Model.PurchaseList DataRowToModel(DataRow row)
		{
			XHD.Model.PurchaseList model=new XHD.Model.PurchaseList();
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
				if(row["category_id"]!=null && row["category_id"].ToString()!="")
				{
					model.category_id=int.Parse(row["category_id"].ToString());
				}
				if(row["product_id"]!=null && row["product_id"].ToString()!="")
				{
					model.product_id=int.Parse(row["product_id"].ToString());
				}
				if(row["DoTime"]!=null && row["DoTime"].ToString()!="")
				{
					model.DoTime=DateTime.Parse(row["DoTime"].ToString());
				}
				if(row["DoPerson"]!=null)
				{
					model.DoPerson=row["DoPerson"].ToString();
				}
				if(row["IsStatus"]!=null && row["IsStatus"].ToString()!="")
				{
					model.IsStatus=int.Parse(row["IsStatus"].ToString());
				}
				if(row["Price"]!=null && row["Price"].ToString()!="")
				{
					model.Price=decimal.Parse(row["Price"].ToString());
				}
				if(row["AmountSum"]!=null && row["AmountSum"].ToString()!="")
				{
					model.AmountSum=decimal.Parse(row["AmountSum"].ToString());
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
			strSql.Append("select *    ");
			strSql.Append(" FROM PurchaseList A ");
            strSql.Append(" INNER JOIN  dbo.CRM_product B ON	 A.product_id=B.product_id ");
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
			strSql.Append(" id,CustomerID,category_id,product_id,DoTime,DoPerson,IsStatus,Price,AmountSum ");
			strSql.Append(" FROM PurchaseList ");
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
			strSql.Append("select count(1) FROM PurchaseList ");
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
			strSql.Append(")AS Row, T.*  from PurchaseList T ");
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
			parameters[0].Value = "PurchaseList";
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
            strSql.Append(" top " + PageSize + " * FROM PurchaseList ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM PurchaseList ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(ID) FROM PurchaseList ");
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
        /// 分页获取预算数据列表
        /// </summary>
        public DataSet GetysList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM budge_basicdetail A ");
            strSql.AppendLine("INNER JOIN budge_basicmain B ON A.budge_id=B.ID ");
            strSql.AppendLine("INNER JOIN [dbo].[CRM_product] C ON A.xmid=C.product_id ");
            strSql.Append(" WHERE A.id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM budge_basicdetail ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(*) FROM budge_basicdetail A ");
            strSql1.AppendLine("INNER JOIN budge_basicmain B ON A.budge_id=B.ID ");
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
        public DataSet GetRefMaterialsList(int PageSize, int PageIndex, string strWhere,string strorder)
        {
            string sqlstr = " SELECT *" +
                                "  FROM   ( SELECT  row_number() OVER (ORDER BY A.DoTime DESC ) n,  a.id ," +
                                "        a.CustomerID ,  " +
                                "        a.product_id ,A.DoTime,A.DoPerson," +
                                "        c.product_name ," +
                                "        a.amountsum-ISNULL(d.pursum, 0) as sqsl ," +
                                "        ISNULL(b.pursum, 0) cgsl ," +
                                "        ISNULL(d.pursum, 0) llsl ," +
                                "        CASE WHEN a.amountsum - ISNULL(d.pursum, 0) <= 0 THEN '5'" +//  -- 领料完成 申请减领料小于等于0
                                "             WHEN a.amountsum - ISNULL(d.pursum, 0) > 0" +
                                "                  AND ISNULL(d.pursum, 0) > 0" +
                                "                  AND a.IsStatus <> 7 THEN '2'" +// -- 领料未完申请减领料大于0并状态不等于7
                                "             WHEN a.amountsum - ISNULL(b.pursum, 0) <= 0 THEN '4'" +//  --采购完成 申请采购料小于等于0
                                "             WHEN a.amountsum - ISNULL(b.pursum, 0) > 0" +
                                "                  AND ISNULL(b.pursum, 0) > 0" +
                                "                  AND a.IsStatus <> 7 THEN '1'" +// --采购未完申请减采购大于0并状态不等于7
                                "             WHEN ISNULL(d.pursum, 0) + ISNULL(b.pursum, 0) = 0" +
                                "                  AND a.IsStatus <> 7 THEN '3' " +//--未处理未发生过领料与采购的显示未处理
                                "             WHEN a.IsStatus = 7 THEN '7'" +// --已结案以上不满足并状态是7的显示已结案
                                "             ELSE '未知'" +//--有没考虑到的显示未知,发现后补充
                                "        END AS IsStatus," +
                                "		 C.category_name,C.specifications,C.status,C.unit,C.remarks,C.isDelete,C.Delete_time,  " +
                                "                                 C.t_content,C.url,C.InternalPrice ,C.Suppliers ,C.ProModel ,C.ProSeries ,  " +
                                "                                 C.Themes,C.Brand,C.C_code,C.C_style ,f.Customer ,e.name,f.address,f.tel,a.SupplierName,a.b1   " +
                                " FROM    dbo.PurchaseList a" +
                                "        LEFT JOIN ( SELECT  Customer_id ," +
                                "                            material_id ," +
                                "                            SUM(pursum) pursum" +
                                "                    FROM    dbo.Purchase_Detail " +
                                "                           " +
                                "                    GROUP BY Customer_id ," +
                                "                            material_id" +
                                "                  ) b ON a.customerid = b.Customer_id" +
                                "                         AND a.product_id = b.material_id" +
                                "        LEFT JOIN ( SELECT  a.Customer_id ," +
                                "                            a.material_id ," +
                                "                            SUM(pursum) pursum" +
                                "                    FROM    dbo.OutStock_Detail a" +
                                "                            LEFT JOIN dbo.OutStock_Main b ON a.ckid = b.ckid" +
                                "                    GROUP BY a.Customer_id ," +
                                "                            a.material_id" +
                                "                  ) d ON a.customerid = d.Customer_id" +
                                "                         AND a.product_id = d.material_id" +
                                "        LEFT JOIN dbo.CRM_product c ON a.product_id = c.product_id" +
                                "		  LEFT JOIN dbo.hr_employee e ON a.DoPerson=e.ID    " +
                                "        INNER JOIN dbo.CRM_Customer f ON A.CustomerID=f.id " +
                                " WHERE   a.isstatus = 1" +
                                "        AND c.product_id IS NOT NULL" +
                                "   ) PurchaseList   " +

                         "			  WHERE n>=" + (PageIndex - 1) * PageSize + "" +
                         "			  AND n<" + PageSize * PageIndex + "";
                        if (strWhere.Trim() != "")
                    {
                        sqlstr += " and " + strWhere;
               
                    }
            if (strorder.Trim() != "")
            {
                sqlstr += " ORDER BY " + strorder;

            }




            return DbHelperSQL.Query(sqlstr);
        }


        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetTempList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM (SELECT A.*, ");
            strSql.Append(" B.product_name,B.category_name,B.specifications,B.status,B.unit,B.remarks,B.isDelete,B.Delete_time,");
              strSql.Append(" B.t_content,B.url,B.InternalPrice ,B.Suppliers ,B.ProModel ,B.ProSeries ,");
              strSql.Append(" B.Themes,B.Brand,B.C_code,B.C_style ,c.name,ISNULL(d.pursum, 0) AS wcsl,ISNULL(e.pursum, 0) AS ztsl");
              strSql.Append(" FROM dbo.PurchaseList A ");
             strSql.Append(" INNER JOIN dbo.CRM_product B ON  ");
             strSql.Append(" A.product_id=B.product_id AND A.category_id=B.category_id");
             strSql.Append(" inner JOIN dbo.hr_employee c ON a.DoPerson=c.ID  ");
             strSql.Append("  LEFT JOIN ( SELECT a.Customer_id,a.material_id,SUM(a.pursum)pursum FROM  dbo.OutStock_Detail a");
             strSql.Append("  LEFT JOIN dbo.OutStock_Main b ON a.CKID=b.CKID");
             strSql.Append("  WHERE b.isNode=3");
             strSql.Append(" GROUP BY a.Customer_id,a.material_id)d ON d.Customer_id=a.Customerid AND d.material_id=a.product_id");
             strSql.Append(" LEFT JOIN ( SELECT a.Customer_id,a.material_id,SUM(a.pursum)pursum FROM  dbo.OutStock_Detail a");
             strSql.Append(" LEFT JOIN dbo.OutStock_Main b ON a.CKID=b.CKID");
             strSql.Append(" WHERE b.isNode IN (0,1,2)");
             strSql.Append(" GROUP BY a.Customer_id,a.material_id)e ON e.Customer_id=a.Customerid AND e.material_id=a.product_id");
              
             strSql.Append(" )PurchaseList ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM PurchaseList ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(1) FROM PurchaseList A");
            strSql1.Append("  INNER JOIN dbo.CRM_product B ON A.product_id=B.product_id AND A.category_id=B.category_id ");
          
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet GetTempListDB(int PageSize, int PageIndex, string strWhere, string cid, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "   ");
            strSql.AppendLine("  * FROM (  ");
            strSql.AppendLine(" SELECT  ROW_NUMBER() OVER(ORDER BY  material_id) AS id,B.material_id,B.material_name,B.unit  ");
            strSql.AppendLine(" ,MAX(B.purprice) price,SUM(  ");
            strSql.AppendLine(" pursum	) subtotal  ");
            strSql.AppendLine("  FROM dbo.OutStock_Main A  ");
            strSql.AppendLine(" INNER JOIN dbo.OutStock_Detail B ON	B.CKID = A.CKID  ");
            strSql.AppendLine("   WHERE isNode IN(3,4)  ");
            if(cid!="")
                strSql.AppendLine("   AND	B.Customer_id="+cid+"  ");
            strSql.AppendLine("   GROUP BY B.material_id,B.material_name,B.unit  ");
            strSql.AppendLine("   )AA  ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM ( ");
            strSql.AppendLine(" SELECT ROW_NUMBER() OVER(ORDER BY  material_id) AS id, B.material_id,B.material_name,B.unit  ");
            strSql.AppendLine(" ,MAX(B.purprice) price,SUM(  ");
            strSql.AppendLine(" pursum	) subtotal  ");
            strSql.AppendLine("  FROM dbo.OutStock_Main A  ");
            strSql.AppendLine(" INNER JOIN dbo.OutStock_Detail B ON	B.CKID = A.CKID  ");
            strSql.AppendLine("   WHERE isNode IN(3,4)  ");
            if (cid != "")
                strSql.AppendLine("   AND	B.Customer_id="+cid+"  ");
            strSql.AppendLine("   GROUP BY B.material_id,B.material_name,B.unit  ");
            strSql.AppendLine("   )AA  ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(1) FROM (  ");
            strSql1.AppendLine(" SELECT ROW_NUMBER() OVER(ORDER BY  material_id) AS id, B.material_id,B.material_name,B.unit  ");
            strSql1.AppendLine(" ,MAX(B.purprice) price,SUM(  ");
            strSql1.AppendLine(" pursum ) subtotal  ");
            strSql1.AppendLine("  FROM dbo.OutStock_Main A  ");
            strSql1.AppendLine(" INNER JOIN dbo.OutStock_Detail B ON	B.CKID = A.CKID  ");
            strSql1.AppendLine("   WHERE isNode IN(3,4)  ");
            if (cid != "")
                strSql1.AppendLine("   AND	B.Customer_id="+cid+"  ");
            strSql1.AppendLine("   GROUP BY B.material_id,B.material_name,B.unit  ");
            strSql1.AppendLine("   )AA  ");
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

