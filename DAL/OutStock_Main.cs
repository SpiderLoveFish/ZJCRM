using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:OutStock_Main
	/// </summary>
	public partial class OutStock_Main
	{
		public OutStock_Main()
		{}
		#region  BasicMethod

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(string CKID,DateTime CKDate)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from OutStock_Main");
			strSql.Append(" where CKID=@CKID and CKDate=@CKDate ");
			SqlParameter[] parameters = {
					new SqlParameter("@CKID", SqlDbType.VarChar,15),
					new SqlParameter("@CKDate", SqlDbType.DateTime)			};
			parameters[0].Value = CKID;
			parameters[1].Value = CKDate;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.OutStock_Main model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into OutStock_Main(");
            strSql.Append("CKID,CKDate,CustomerID,FYM,TotalAmount,PayAmount,InPerson,remarks,CostAmount,UseStyle,isNode)");
			strSql.Append(" values (");
            strSql.Append("@CKID,@CKDate,@CustomerID,@FYM,@TotalAmount,@PayAmount,@InPerson,@remarks,@CostAmount,@UseStyle,@isNode)");
			SqlParameter[] parameters = {
					new SqlParameter("@CKID", SqlDbType.VarChar,15),
					new SqlParameter("@CKDate", SqlDbType.DateTime),
					new SqlParameter("@CustomerID", SqlDbType.Int,4),
					new SqlParameter("@FYM", SqlDbType.VarChar,6),
					new SqlParameter("@TotalAmount", SqlDbType.Decimal,9),
					new SqlParameter("@PayAmount", SqlDbType.Decimal,9),
					new SqlParameter("@InPerson", SqlDbType.VarChar,20),
					new SqlParameter("@remarks", SqlDbType.VarChar,50),
					new SqlParameter("@CostAmount", SqlDbType.Decimal,9),
					new SqlParameter("@UseStyle", SqlDbType.VarChar,20),
                     new SqlParameter("@isNode", SqlDbType.Int,4)                   };
			parameters[0].Value = model.CKID;
			parameters[1].Value = model.CKDate;
			parameters[2].Value = model.CustomerID;
			parameters[3].Value = model.FYM;
			parameters[4].Value = model.TotalAmount;
			parameters[5].Value = model.PayAmount;
			parameters[6].Value = model.InPerson;
			parameters[7].Value = model.remarks;
			parameters[8].Value = model.CostAmount;
			parameters[9].Value = model.UseStyle;
            parameters[10].Value = model.isNode;

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
		public bool Update(XHD.Model.OutStock_Main model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update OutStock_Main set ");
			strSql.Append("CustomerID=@CustomerID,");
			strSql.Append("FYM=@FYM,");
			strSql.Append("TotalAmount=@TotalAmount,");
			strSql.Append("PayAmount=@PayAmount,");
			strSql.Append("InPerson=@InPerson,");
			strSql.Append("remarks=@remarks,");
			strSql.Append("CostAmount=@CostAmount,");
			strSql.Append("UseStyle=@UseStyle");
			strSql.Append(" where CKID=@CKID and CKDate=@CKDate ");
			SqlParameter[] parameters = {
					new SqlParameter("@CustomerID", SqlDbType.Int,4),
					new SqlParameter("@FYM", SqlDbType.VarChar,6),
					new SqlParameter("@TotalAmount", SqlDbType.Decimal,9),
					new SqlParameter("@PayAmount", SqlDbType.Decimal,9),
					new SqlParameter("@InPerson", SqlDbType.VarChar,20),
					new SqlParameter("@remarks", SqlDbType.VarChar,50),
					new SqlParameter("@CostAmount", SqlDbType.Decimal,9),
					new SqlParameter("@UseStyle", SqlDbType.VarChar,20),
					new SqlParameter("@CKID", SqlDbType.VarChar,15),
					new SqlParameter("@CKDate", SqlDbType.DateTime)};
			parameters[0].Value = model.CustomerID;
			parameters[1].Value = model.FYM;
			parameters[2].Value = model.TotalAmount;
			parameters[3].Value = model.PayAmount;
			parameters[4].Value = model.InPerson;
			parameters[5].Value = model.remarks;
			parameters[6].Value = model.CostAmount;
			parameters[7].Value = model.UseStyle;
			parameters[8].Value = model.CKID;
			parameters[9].Value = model.CKDate;

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
		public bool Delete(string CKID,DateTime CKDate)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from OutStock_Main ");
			strSql.Append(" where CKID=@CKID and CKDate=@CKDate ");
			SqlParameter[] parameters = {
					new SqlParameter("@CKID", SqlDbType.VarChar,15),
					new SqlParameter("@CKDate", SqlDbType.DateTime)			};
			parameters[0].Value = CKID;
			parameters[1].Value = CKDate;

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
		/// 得到一个对象实体
		/// </summary>
		public XHD.Model.OutStock_Main GetModel(string CKID,DateTime CKDate)
		{
			
			StringBuilder strSql=new StringBuilder();
            strSql.Append("select  top 1 CKID,CKDate,CustomerID,FYM,TotalAmount,PayAmount,InPerson,remarks,CostAmount,UseStyle,isNode from OutStock_Main ");
			strSql.Append(" where CKID=@CKID and CKDate=@CKDate ");
			SqlParameter[] parameters = {
					new SqlParameter("@CKID", SqlDbType.VarChar,15),
					new SqlParameter("@CKDate", SqlDbType.DateTime)			};
			parameters[0].Value = CKID;
			parameters[1].Value = CKDate;

			XHD.Model.OutStock_Main model=new XHD.Model.OutStock_Main();
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
		public XHD.Model.OutStock_Main DataRowToModel(DataRow row)
		{
			XHD.Model.OutStock_Main model=new XHD.Model.OutStock_Main();
			if (row != null)
			{
				if(row["CKID"]!=null)
				{
					model.CKID=row["CKID"].ToString();
				}
				if(row["CKDate"]!=null && row["CKDate"].ToString()!="")
				{
					model.CKDate=DateTime.Parse(row["CKDate"].ToString());
				}
				if(row["CustomerID"]!=null && row["CustomerID"].ToString()!="")
				{
					model.CustomerID=int.Parse(row["CustomerID"].ToString());
				}
				if(row["FYM"]!=null)
				{
					model.FYM=row["FYM"].ToString();
				}
				if(row["TotalAmount"]!=null && row["TotalAmount"].ToString()!="")
				{
					model.TotalAmount=decimal.Parse(row["TotalAmount"].ToString());
				}
				if(row["PayAmount"]!=null && row["PayAmount"].ToString()!="")
				{
					model.PayAmount=decimal.Parse(row["PayAmount"].ToString());
				}
				if(row["InPerson"]!=null)
				{
					model.InPerson=row["InPerson"].ToString();
				}
				if(row["remarks"]!=null)
				{
					model.remarks=row["remarks"].ToString();
				}
				if(row["CostAmount"]!=null && row["CostAmount"].ToString()!="")
				{
					model.CostAmount=decimal.Parse(row["CostAmount"].ToString());
				}
				if(row["UseStyle"]!=null)
				{
					model.UseStyle=row["UseStyle"].ToString();
				}

                if (row["isNode"] != null && row["isNode"].ToString() != "")
				{
                    model.isNode = int.Parse(row["isNode"].ToString());
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
			strSql.Append("select CKID,CKDate,CustomerID,FYM,TotalAmount,PayAmount,InPerson,remarks,CostAmount,UseStyle ");
			strSql.Append(" FROM OutStock_Main ");
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
			strSql.Append(" CKID,CKDate,CustomerID,FYM,TotalAmount,PayAmount,InPerson,remarks,CostAmount,UseStyle ");
			strSql.Append(" FROM OutStock_Main ");
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
			strSql.Append("select count(1) FROM OutStock_Main ");
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
				strSql.Append("order by T.CKDate desc");
			}
			strSql.Append(")AS Row, T.*  from OutStock_Main T ");
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
			parameters[0].Value = "OutStock_Main";
			parameters[1].Value = "CKDate";
			parameters[2].Value = PageSize;
			parameters[3].Value = PageIndex;
			parameters[4].Value = 0;
			parameters[5].Value = 0;
			parameters[6].Value = strWhere;	
			return DbHelperSQL.RunProcedure("UP_GetRecordByPage",parameters,"ds");
		}*/

		#endregion  BasicMethod
		#region  ExtensionMethod

        public string GetMaxCKId()
        {
            string per = "CK";
            string strsql = "select max(REPLACE(CKID,'" + per + "',''))+1 from OutStock_Main where CKID like '" + per + "%'";
            object obj = DbHelperSQL.GetSingle(strsql);
            if (obj == null)
            {
                return per + "0001";
            }
            else
            {
                return per + int.Parse(obj.ToString()).ToString("000");
            }

            // return DbHelperSQL.GetMaxID("id", "CRM_CEStage");
        }

        public DataSet GetOutStock_Main(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  * FROM  dbo.OutStock_Main A");
            strSql.Append(" INNER JOIN  dbo.CRM_Customer B ON A.CustomerID=B.id");
            strSql.Append(" WHERE  CKID not in ( SELECT top " + (PageIndex - 1) * PageSize + " CKID FROM OutStock_Main  ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(CKID) FROM OutStock_Main   ");

            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                //strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }

        public bool Updatestatus(string pid, string status)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update OutStock_Main set ");

            strSql.Append("isNode=" + status + "");

            strSql.Append(" where CKID='" + pid + "' ");
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

        public bool Delete(string Purid)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from OutStock_Main ");
            strSql.Append(" where CKID='" + Purid + "'  and isNode=0");
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
        public DataSet GetListdetail(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select A.* ");
            strSql.Append(" ,B.Customer,B.address,B.Emp_sg");
            strSql.Append(" FROM OutStock_Main A");
            strSql.Append(" INNER JOIN  dbo.CRM_Customer B ON A.CustomerID=B.id");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        public bool updateremarks(string ckid, string remarks, string usestyle)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("  UPDATE	dbo.OutStock_Main");

            sb.AppendLine(" SET remarks='" + remarks + "',usestyle='" + usestyle + "' ");

            sb.AppendLine(" WHERE	 CKID='" + ckid + "' ");

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
		#endregion  ExtensionMethod
	}
}

