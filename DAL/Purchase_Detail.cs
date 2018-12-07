using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Purchase_Detail
	/// </summary>
	public partial class Purchase_Detail
	{
		public Purchase_Detail()
		{}
		#region  BasicMethod

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(string Purid)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Purchase_Detail");
			strSql.Append(" where Purid=SQL2012Purid ");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012Purid", SqlDbType.VarChar,8)			};
			parameters[0].Value = Purid;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.Purchase_Detail model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Purchase_Detail(");
			strSql.Append("Purid,material_id,material_name,specifications,model,unit,purprice,pursum,subtotal,remarks)");
			strSql.Append(" values (");
			strSql.Append("SQL2012Purid,SQL2012material_id,SQL2012material_name,SQL2012specifications,SQL2012model,SQL2012unit,SQL2012purprice,SQL2012pursum,SQL2012subtotal,SQL2012remarks)");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012Purid", SqlDbType.VarChar,8),
					new SqlParameter("SQL2012material_id", SqlDbType.VarChar,10),
					new SqlParameter("SQL2012material_name", SqlDbType.VarChar,250),
					new SqlParameter("SQL2012specifications", SqlDbType.VarChar,50),
					new SqlParameter("SQL2012model", SqlDbType.VarChar,50),
					new SqlParameter("SQL2012unit", SqlDbType.VarChar,10),
					new SqlParameter("SQL2012purprice", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012pursum", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012subtotal", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012remarks", SqlDbType.VarChar,250)};
			parameters[0].Value = model.Purid;
			parameters[1].Value = model.material_id;
			parameters[2].Value = model.material_name;
			parameters[3].Value = model.specifications;
			parameters[4].Value = model.model;
			parameters[5].Value = model.unit;
			parameters[6].Value = model.purprice;
			parameters[7].Value = model.pursum;
			parameters[8].Value = model.subtotal;
			parameters[9].Value = model.remarks;

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
		public bool Update(XHD.Model.Purchase_Detail model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Purchase_Detail set ");
			strSql.Append("material_id=SQL2012material_id,");
			strSql.Append("material_name=SQL2012material_name,");
			strSql.Append("specifications=SQL2012specifications,");
			strSql.Append("model=SQL2012model,");
			strSql.Append("unit=SQL2012unit,");
			strSql.Append("purprice=SQL2012purprice,");
			strSql.Append("pursum=SQL2012pursum,");
			strSql.Append("subtotal=SQL2012subtotal,");
			strSql.Append("remarks=SQL2012remarks");
			strSql.Append(" where Purid=SQL2012Purid ");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012material_id", SqlDbType.VarChar,10),
					new SqlParameter("SQL2012material_name", SqlDbType.VarChar,250),
					new SqlParameter("SQL2012specifications", SqlDbType.VarChar,50),
					new SqlParameter("SQL2012model", SqlDbType.VarChar,50),
					new SqlParameter("SQL2012unit", SqlDbType.VarChar,10),
					new SqlParameter("SQL2012purprice", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012pursum", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012subtotal", SqlDbType.Decimal,9),
					new SqlParameter("SQL2012remarks", SqlDbType.VarChar,250),
					new SqlParameter("SQL2012Purid", SqlDbType.VarChar,8)};
			parameters[0].Value = model.material_id;
			parameters[1].Value = model.material_name;
			parameters[2].Value = model.specifications;
			parameters[3].Value = model.model;
			parameters[4].Value = model.unit;
			parameters[5].Value = model.purprice;
			parameters[6].Value = model.pursum;
			parameters[7].Value = model.subtotal;
			parameters[8].Value = model.remarks;
			parameters[9].Value = model.Purid;

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
		public bool Delete(string Purid,string MID)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Purchase_Detail ");
            strSql.Append(" where Purid='" + Purid + "' ");
            strSql.Append("delete from OutStock_Detail ");
            strSql.Append(" where CKID='" + Purid + "' ");
            if(MID!="")
            strSql.Append(" AND material_id=" + MID + " ");
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
			strSql.Append("delete from Purchase_Detail ");
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
		public XHD.Model.Purchase_Detail GetModel(string Purid)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 Purid,material_id,material_name,specifications,model,unit,purprice,pursum,subtotal,remarks from Purchase_Detail ");
			strSql.Append(" where Purid=SQL2012Purid ");
			SqlParameter[] parameters = {
					new SqlParameter("SQL2012Purid", SqlDbType.VarChar,8)			};
			parameters[0].Value = Purid;

			XHD.Model.Purchase_Detail model=new XHD.Model.Purchase_Detail();
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
		public XHD.Model.Purchase_Detail DataRowToModel(DataRow row)
		{
			XHD.Model.Purchase_Detail model=new XHD.Model.Purchase_Detail();
			if (row != null)
			{
				if(row["Purid"]!=null)
				{
					model.Purid=row["Purid"].ToString();
				}
				if(row["material_id"]!=null)
				{
					model.material_id=row["material_id"].ToString();
				}
				if(row["material_name"]!=null)
				{
					model.material_name=row["material_name"].ToString();
				}
				if(row["specifications"]!=null)
				{
					model.specifications=row["specifications"].ToString();
				}
				if(row["model"]!=null)
				{
					model.model=row["model"].ToString();
				}
				if(row["unit"]!=null)
				{
					model.unit=row["unit"].ToString();
				}
				if(row["purprice"]!=null && row["purprice"].ToString()!="")
				{
					model.purprice=decimal.Parse(row["purprice"].ToString());
				}
				if(row["pursum"]!=null && row["pursum"].ToString()!="")
				{
					model.pursum=decimal.Parse(row["pursum"].ToString());
				}
				if(row["subtotal"]!=null && row["subtotal"].ToString()!="")
				{
					model.subtotal=decimal.Parse(row["subtotal"].ToString());
				}
				if(row["remarks"]!=null)
				{
					model.remarks=row["remarks"].ToString();
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
			strSql.Append("select Purid,material_id,material_name,specifications,model,unit,purprice,pursum,subtotal,remarks ");
			strSql.Append(" FROM Purchase_Detail ");
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
			strSql.Append(" Purid,material_id,material_name,specifications,model,unit,purprice,pursum,subtotal,remarks ");
			strSql.Append(" FROM Purchase_Detail ");
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
			strSql.Append("select count(1) FROM Purchase_Detail ");
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
			strSql.Append(")AS Row, T.*  from Purchase_Detail T ");
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
			parameters[0].Value = "Purchase_Detail";
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
        public bool Addlist(string pid, string list, string isauto)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("INSERT INTO dbo.Purchase_Detail");
            sb.AppendLine("        ( Purid ,");
            sb.AppendLine("          material_id ,");
            sb.AppendLine("          material_name ,");
            sb.AppendLine("          specifications ,");
            sb.AppendLine("          model ,");
            sb.AppendLine("          unit ,");
            sb.AppendLine("          purprice ,");
            sb.AppendLine("          pursum ,");
            sb.AppendLine("          subtotal ,");
            sb.AppendLine("          remarks,Customer_id");
            sb.AppendLine("        )");
            if (isauto == "Y")
            {
                sb.AppendLine(" SELECT '" + pid + "',A.product_id,product_name,specifications,ProModel,unit,b.internalprice,AmountSum-isnull(d.pursum,0)-isnull(e.pursum,0) as AmountSum,AmountSum*b.internalprice,A.b1,A.CustomerID ");
                sb.AppendLine(" from PurchaseList A ");
                sb.AppendLine(" inner join dbo.CRM_product B on A.product_id=B.product_id ");
                sb.AppendLine("  LEFT JOIN ( SELECT a.Customer_id,a.material_id,SUM(a.pursum)pursum FROM  dbo.OutStock_Detail a");
                sb.AppendLine(" LEFT JOIN dbo.OutStock_Main b ON a.CKID=b.CKID");
			 sb.AppendLine("  WHERE b.isNode=3 GROUP BY a.Customer_id,a.material_id)d ON d.Customer_id=a.Customerid AND d.material_id=a.product_id");
             sb.AppendLine("   LEFT JOIN ( SELECT a.Customer_id,a.material_id,SUM(a.pursum)pursum FROM  dbo.OutStock_Detail a");
             sb.AppendLine("  LEFT JOIN dbo.OutStock_Main b ON a.CKID=b.CKID");
			 sb.AppendLine("  WHERE b.isNode IN (0,1,2) GROUP BY a.Customer_id,a.material_id)e ON e.Customer_id=a.Customerid AND e.material_id=a.product_id");
                sb.AppendLine(" WHERE a.id IN(" + list + ")");
            }
            else {
                sb.AppendLine("SELECT '" + pid + "',product_id,product_name,specifications,ProModel,unit,price,0,0,'','"+ isauto + "'");
                sb.AppendLine(" FROM dbo.CRM_product WHERE product_id IN(" + list + ")");
            }
            SqlParameter[] parameters = {};
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

        //调拨明细
        public bool AddlistDB(string pid, string list, string cid)
        {
            var sb = new System.Text.StringBuilder(); 
            sb.AppendLine(" INSERT INTO dbo.Purchase_Detail  ");
            sb.AppendLine("         ( Purid ,  ");
            sb.AppendLine("           material_id ,  ");
            sb.AppendLine("           material_name ,  ");
            sb.AppendLine("           specifications ,  ");
            sb.AppendLine("           model ,  ");
            sb.AppendLine("           unit ,  ");
            sb.AppendLine("           purprice ,  ");
            sb.AppendLine("           pursum ,  ");
            sb.AppendLine("           subtotal ,  ");
            sb.AppendLine("           remarks ,  ");
            sb.AppendLine("           StockID ,  ");
            sb.AppendLine("           Customer_id ,  ");
            sb.AppendLine("           ischeck  ");
            sb.AppendLine("         )  ");
            sb.AppendLine("    ");
            sb.AppendLine(" SELECT '"+pid+"' ,  B.material_id,B.material_name,B.specifications,B.model,B.unit    ");
            sb.AppendLine("  ,MAX(B.purprice) price,0,  ");
            sb.AppendLine("  SUM( B.pursum)   ");
            //sb.AppendLine("  CASE WHEN  LEFT(A.CKID,1)='P' THEN B.subtotal WHEN LEFT(A.CKID,1)='D' THEN -B.subtotal  ELSE B.subtotal END	) subtotal   ");
            sb.AppendLine("  ,'','' ,'" + cid+"','0'  ");
            sb.AppendLine("   FROM dbo.OutStock_Main A    ");
            sb.AppendLine("  INNER JOIN dbo.OutStock_Detail B ON	B.CKID = A.CKID    ");
            sb.AppendLine("  INNER JOIN dbo.CRM_product C ON B.material_id=C.product_id  ");
            sb.AppendLine("    WHERE isNode IN(3,4)    ");
            sb.AppendLine("    AND	B.Customer_id="+ cid + "    ");
            sb.AppendLine("     and  product_id IN(" + list + ")");
            sb.AppendLine("    GROUP BY B.material_id,B.material_name,B.specifications,B.model,B.unit    ");
            sb.AppendLine("   ");

            
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
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetPurchase_Detail(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  A.*,'【'+isnull(b.customer,'自己')+'】'+b.address customer,Emp_sg,Emp_sg,Emp_sj,isnull(c.b1,'') b1,cp.c_code,ischeck FROM  dbo.Purchase_Detail A ");
            strSql.Append(" LEFT JOIN CRM_CUSTOMER b on a.customer_id=b.id ");
            strSql.Append(" LEFT JOIN crm_product cp on cp.product_id=a.material_id ");
            strSql.Append(" LEFT JOIN (SELECT  CustomerID,product_id,MAX(b1) AS b1 FROM  dbo.PurchaseList GROUP BY CustomerID,product_id) c on a.customer_id=c.CustomerID and a.material_id=c.product_id ");
            strSql.Append(" WHERE  Purid not in ( SELECT top " + (PageIndex - 1) * PageSize + " Purid FROM Purchase_Detail  ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(Purid) FROM Purchase_Detail   ");

            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet GetPur_ViewList(int PageSize, int PageIndex, string strWhere)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine(" SELECT * FROM (");
            sb.AppendLine(" SELECT  ROW_NUMBER() OVER ( ORDER BY a.material_id DESC ) n ,");
            sb.AppendLine(" aa.Customer_id ,");
            sb.AppendLine(" b.Customer ,");
            sb.AppendLine(" b.address ,");
            sb.AppendLine(" ISNULL(a.pursum,0)pursum ,");
            sb.AppendLine(" ISNULL(a.subtotal,0) subtotal,");
            sb.AppendLine(" ISNULL(bb.pursum,0)  pursum_zt ,");
            sb.AppendLine(" ISNULL(bb.subtotal,0)  subtotal_zt ,");
            sb.AppendLine(" ISNULL(CC.pursum,0) outsum ,");
            sb.AppendLine(" ISNULL(CC.subtotal,0) subtotaloutsum,");
            sb.AppendLine(" ISNULL(DD.pursum,0)  outsum_zt ,");
            sb.AppendLine(" ISNULL(DD.subtotal,0)  subtotaloutsum_zt ,");
            sb.AppendLine(" c.InternalPrice ,");
            sb.AppendLine(" c.InternalPrice * (ISNULL(cc.pursum,0)+ISNULL(dd.pursum,0)) AS CostSum ,");
            sb.AppendLine(" c.product_name ,");
            sb.AppendLine(" c.specifications ,");
            sb.AppendLine(" c.ProModel ,");
            sb.AppendLine(" c.ProSeries ,");
            sb.AppendLine(" c.Brand ,");
            sb.AppendLine(" c.unit ,");
            sb.AppendLine(" c.c_style ,");
            sb.AppendLine(" c.remarks");
            sb.AppendLine(" FROM    (SELECT DISTINCT Customer_id,material_id FROM (SELECT Customer_id,material_id FROM dbo.Purchase_Detail UNION ALL SELECT  Customer_id,material_id FROM  dbo.OutStock_Detail)a) aa");
            sb.AppendLine(" LEFT JOIN ( SELECT   ");
            sb.AppendLine(" a.Customer_id ,");
            sb.AppendLine(" a.material_id ,");
            sb.AppendLine(" 3 isnode,");
            sb.AppendLine(" SUM(pursum) pursum ,");
            sb.AppendLine(" SUM(a.subtotal) subtotal");
            sb.AppendLine(" FROM      dbo.Purchase_Detail a");
            sb.AppendLine(" LEFT JOIN dbo.Purchase_Main b ON a.Purid = b.Purid");
            sb.AppendLine(" WHERE b.isnode=3");
            sb.AppendLine(" GROUP BY  a.Customer_id ,");
            sb.AppendLine(" a.material_id");
            sb.AppendLine(" ) a ON aa.Customer_id=a.Customer_id AND aa.material_id=a.material_id");
            sb.AppendLine(" LEFT JOIN ( SELECT   ");
            sb.AppendLine(" a.Customer_id ,");
            sb.AppendLine(" a.material_id ,");
            sb.AppendLine(" 1 isnode,");
            sb.AppendLine(" SUM(pursum) pursum ,");
            sb.AppendLine(" SUM(a.subtotal) subtotal");
            sb.AppendLine(" FROM      dbo.Purchase_Detail a");
            sb.AppendLine(" LEFT JOIN dbo.Purchase_Main b ON a.Purid = b.Purid");
            sb.AppendLine(" WHERE b.isnode IN (0,1,2)");
            sb.AppendLine(" GROUP BY  a.Customer_id ,");
            sb.AppendLine(" a.material_id");
            sb.AppendLine(" ) bb ON aa.Customer_id=bb.Customer_id AND aa.material_id=bb.material_id");
            sb.AppendLine(" LEFT JOIN ( SELECT   ");
            sb.AppendLine(" a.Customer_id ,");
            sb.AppendLine(" a.material_id ,");
            sb.AppendLine(" 1 isnode,");
            sb.AppendLine(" SUM(pursum) pursum ,");
            sb.AppendLine(" SUM(a.subtotal) subtotal");
            sb.AppendLine(" FROM      dbo.OutStock_Detail a");
            sb.AppendLine(" LEFT JOIN dbo.OutStock_Main b ON a.CKID = b.CKID");
            sb.AppendLine(" WHERE b.isNode =3");
            sb.AppendLine(" GROUP BY  a.Customer_id ,");
            sb.AppendLine(" a.material_id");
            sb.AppendLine(" ) cc ON aa.Customer_id=cc.Customer_id AND aa.material_id=cc.material_id");
            sb.AppendLine(" LEFT JOIN ( SELECT   ");
            sb.AppendLine(" a.Customer_id ,");
            sb.AppendLine(" a.material_id ,");
            sb.AppendLine(" 1 isnode,");
            sb.AppendLine(" SUM(pursum) pursum ,");
            sb.AppendLine(" SUM(a.subtotal) subtotal");
            sb.AppendLine(" FROM      dbo.OutStock_Detail a");
            sb.AppendLine(" LEFT JOIN dbo.OutStock_Main b ON a.CKID = b.CKID");
            sb.AppendLine(" WHERE b.isNode IN (0,1,2)");
            sb.AppendLine(" GROUP BY  a.Customer_id ,");
            sb.AppendLine(" a.material_id");
            sb.AppendLine(" ) dd ON aa.Customer_id=dd.Customer_id AND aa.material_id=dd.material_id");
            sb.AppendLine(" LEFT JOIN dbo.CRM_Customer b ON aa.Customer_id = b.id");
            sb.AppendLine(" LEFT JOIN dbo.CRM_product c ON c.product_id = aa.material_id");
            sb.AppendLine(" WHERE   1 = 1");
            sb.AppendLine(" )Pur");
              sb.AppendLine(" WHERE n>=" + (PageIndex - 1) * PageSize + "");
            sb.AppendLine("  AND n<" + PageSize * PageIndex + "");

            
            if (strWhere.Trim() != "")
            {
                sb.AppendLine("  AND  " +  strWhere);

            }

            return DbHelperSQL.Query(sb.ToString());
        }

        public DataSet GetSuppPur_ViewList(int PageSize, int PageIndex, string strWhere,string starttime,string endtime)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT * FROM (  ");
            sb.AppendLine(" SELECT  ROW_NUMBER() OVER ( ORDER BY d.ID DESC ) n ,  ");
            sb.AppendLine("         d.ID,d.name ,  ");
            sb.AppendLine("         a.pursum   ,  ");
            sb.AppendLine("         a.subtotal   ,  ");
            sb.AppendLine("         c.InternalPrice   ,  ");
            sb.AppendLine("         c.InternalPrice * a.pursum AS	 CostSum ,  ");
            sb.AppendLine(" 		a.isNode,  ");
            sb.AppendLine("         CASE a.isNode  ");
            sb.AppendLine("           WHEN 0 THEN '采购录入'  ");
            sb.AppendLine("           WHEN 1 THEN '采购提交'  ");
            sb.AppendLine("           WHEN 2 THEN '采购审核'  ");
            sb.AppendLine("           WHEN 3 THEN '采购确认'  ");
            sb.AppendLine("         END 采购状态 ,  ");
            sb.AppendLine("         c.product_id ,  ");
            sb.AppendLine("         c.product_name ,  ");
            sb.AppendLine("         c.specifications ,  ");
            sb.AppendLine("         c.ProModel ,  ");
            sb.AppendLine("         c.ProSeries ,  ");
            sb.AppendLine("         c.Brand ,  ");
            sb.AppendLine("         c.unit ,  ");
            sb.AppendLine("         c.c_style ,  ");
            sb.AppendLine("         c.remarks  ");
            sb.AppendLine(" FROM    ( SELECT    b.supplier_id ,  ");
            sb.AppendLine("                     a.material_id ,  ");
            sb.AppendLine("                     b.isNode ,  ");
            sb.AppendLine("                     SUM(pursum) pursum ,  ");
            sb.AppendLine("                     SUM(a.subtotal) subtotal  ");
            sb.AppendLine("           FROM      dbo.Purchase_Detail a  ");
            sb.AppendLine("                     LEFT JOIN dbo.Purchase_Main b ON a.Purid = b.Purid  ");
            sb.AppendLine("           WHERE    1=1 ");
            if(starttime!="")
            sb.AppendLine("               AND     b.purdate >= '"+starttime+"' ");
            if(endtime!="")
            sb.AppendLine("                     AND b.purdate <= '"+endtime+"'  ");
            sb.AppendLine("           GROUP BY  b.supplier_id ,  ");
            sb.AppendLine("                     b.isNode ,  ");
            sb.AppendLine("                     a.material_id  ");
            sb.AppendLine("         ) a  ");
            sb.AppendLine("         LEFT JOIN dbo.CRM_product c ON c.product_id = a.material_id  ");
            sb.AppendLine("         LEFT JOIN dbo.CgGl_Gys_Main d ON d.ID = a.supplier_id  ");
            sb.AppendLine("  )cggl  ");
            sb.AppendLine(" WHERE   1 = 1  ");

            sb.AppendLine("  AND n>=" + (PageIndex - 1) * PageSize + "");
            sb.AppendLine("  AND n<" + PageSize * PageIndex + "");


            if (strWhere.Trim() != "")
            {
                sb.AppendLine("  AND  " + strWhere);

            }

            return DbHelperSQL.Query(sb.ToString());
        }

        public DataSet GetSuppPur_DetailList(int PageSize, int PageIndex, string strWhere, string starttime, string endtime)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT * FROM (  ");
            sb.AppendLine(" SELECT  ROW_NUMBER() OVER ( ORDER BY d.ID DESC ) n ,  ");
            sb.AppendLine("         a.Purid ,  ");
            sb.AppendLine("         b.purdate ,  ");
            sb.AppendLine("         d.[Name] ,  ");
            sb.AppendLine("         e.Customer ,  ");
            sb.AppendLine("         e.address ,  ");
            sb.AppendLine("         CASE b.isNode  ");
            sb.AppendLine("           WHEN 0 THEN '采购录入'  ");
            sb.AppendLine("           WHEN 1 THEN '采购提交'  ");
            sb.AppendLine("           WHEN 2 THEN '采购审核'  ");
            sb.AppendLine("           WHEN 3 THEN '采购确认'  ");
            sb.AppendLine("         END 采购状态 ,  ");
            sb.AppendLine("         b.isNode ,  ");
            sb.AppendLine(" 		b.supplier_id, b.supplier_name, ");
            sb.AppendLine("         pursum ,  ");
            sb.AppendLine("         a.purprice ,  ");
            sb.AppendLine("         a.subtotal ,  ");
            sb.AppendLine("        c.product_id, c.product_name ,  ");
            sb.AppendLine("         c.specifications ,  ");
            sb.AppendLine("         c.ProModel ,  ");
            sb.AppendLine("         c.ProSeries ,  ");
            sb.AppendLine("         c.Brand ,  ");
            sb.AppendLine("         c.unit ,  ");
            sb.AppendLine("         c.c_style,  ");
            sb.AppendLine("         c.remarks ,a.ischeck ");
            sb.AppendLine(" FROM    dbo.Purchase_Detail a  ");
            sb.AppendLine("         LEFT JOIN dbo.Purchase_Main b ON a.Purid = b.Purid  ");
            sb.AppendLine("         LEFT JOIN dbo.CRM_product c ON c.product_id = a.material_id  ");
            sb.AppendLine("         LEFT JOIN dbo.CgGl_Gys_Main d ON d.ID = b.supplier_id  ");
            sb.AppendLine("         LEFT JOIN dbo.CRM_Customer e ON e.id = a.Customer_id  ");
            sb.AppendLine(" 		)pur  ");
            sb.AppendLine(" WHERE  1=1   ");
            if (starttime != "")
                sb.AppendLine("               AND     b.purdate >= '" + starttime + "' ");
            if (endtime != "")
                sb.AppendLine("                     AND b.purdate <= '" + endtime + "'  ");
        
            sb.AppendLine("  AND n>=" + (PageIndex - 1) * PageSize + "");
            sb.AppendLine("  AND n<" + PageSize * PageIndex + "");


            if (strWhere.Trim() != "")
            {
                sb.AppendLine("  AND  " + strWhere);

            }

            return DbHelperSQL.Query(sb.ToString());
        }



        public bool Updatedetail(string pid, string mid, decimal price, decimal sum, string remarks,string cid)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("UPDATE	 dbo.Purchase_Detail");
            sb.AppendLine(" SET");
            if (price > 0)
            {
                sb.AppendLine("          purprice=" + price + " ");
                sb.AppendLine("         ,subtotal=" + price + "*pursum  ");
            }
            if (sum > 0)
            {
                sb.AppendLine("          pursum=" + sum + " ");
                sb.AppendLine("         ,subtotal=" + sum + "*purprice  ");
            }
            if(remarks.Length>0)
            sb.AppendLine("          remarks='"+remarks+"'");
            sb.AppendLine(" WHERE		Purid='"+pid+"'");
            sb.AppendLine(" AND ");
            sb.AppendLine("          material_id='" + mid + "'");
            sb.AppendLine("    AND      Customer_id='" + cid + "'");
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
        //调拨修改数量，价格
        public bool UpdatedetailDB(string pid, string mid, decimal price, decimal sum, string remarks, string cid)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("UPDATE	 dbo.Purchase_Detail");
            sb.AppendLine(" SET");
            if (price > 0)
            {
                sb.AppendLine("          purprice=" + price + " ");
                //sb.AppendLine("         ,subtotal=" + price + "*pursum  ");
            }
            if (sum > 0)
            {
                sb.AppendLine("          pursum=" + sum + " ");
                //sb.AppendLine("         ,subtotal=" + sum + "*purprice  ");
            }
            if (remarks.Length > 0)
                sb.AppendLine("          remarks='" + remarks + "'");
            sb.AppendLine(" WHERE		Purid='" + pid + "'");
            sb.AppendLine(" AND ");
            sb.AppendLine("          material_id='" + mid + "'");
            sb.AppendLine("    AND      Customer_id='" + cid + "'");
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

        public bool Updatestock(string pid,string mid, string stockid)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update Purchase_Detail set ");

            strSql.Append("StockID=" + stockid + "");

            strSql.Append(" where Purid='" + pid + "' ");
            if(mid!="")
            strSql.Append(" AND    material_id='" + mid + "'");
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
		#endregion  ExtensionMethod
	}
}

