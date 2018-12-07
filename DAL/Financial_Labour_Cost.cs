using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Financial_Labour_Cost
	/// </summary>
	public partial class Financial_Labour_Cost
	{
		public Financial_Labour_Cost()
		{}
		#region  BasicMethod

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(string F_Num)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Financial_Labour_Cost");
			strSql.Append(" where F_Num=@F_Num ");
			SqlParameter[] parameters = {
					new SqlParameter("@F_Num", SqlDbType.VarChar,20)			};
			parameters[0].Value = F_Num;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.Financial_Labour_Cost model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Financial_Labour_Cost(");
			strSql.Append("F_Num,F_StyleID,F_StyleName,ManDayPrice,ManHour,Amount,AdjustAmount,TotalAmount,worker,Remarks,FromWhere,CreatePerson,CreateTime,IsStatus,DeleteTime,CustomerID,Pay_type_id,Pay_type,IsHaveDetail,receive_money)");
			strSql.Append(" values (");
			strSql.Append("@F_Num,@F_StyleID,@F_StyleName,@ManDayPrice,@ManHour,@Amount,@AdjustAmount,@TotalAmount,@worker,@Remarks,@FromWhere,@CreatePerson,@CreateTime,@IsStatus,@DeleteTime,@CustomerID,@Pay_type_id,@Pay_type,@IsHaveDetail,@receive_money)");
			SqlParameter[] parameters = {
					new SqlParameter("@F_Num", SqlDbType.VarChar,20),
                        new SqlParameter("@F_StyleID", SqlDbType.Int,4),
					new SqlParameter("@F_StyleName", SqlDbType.VarChar,50),
					new SqlParameter("@ManDayPrice", SqlDbType.Decimal,9),
					new SqlParameter("@ManHour", SqlDbType.Decimal,9),
					new SqlParameter("@Amount", SqlDbType.Decimal,9),
					new SqlParameter("@AdjustAmount", SqlDbType.Decimal,9),
					new SqlParameter("@TotalAmount", SqlDbType.Decimal,9),
					new SqlParameter("@worker", SqlDbType.VarChar,50),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
					new SqlParameter("@FromWhere", SqlDbType.VarChar,10),
					new SqlParameter("@CreatePerson", SqlDbType.VarChar,20),
					new SqlParameter("@CreateTime", SqlDbType.DateTime),
					new SqlParameter("@IsStatus", SqlDbType.Char,1),
					new SqlParameter("@DeleteTime", SqlDbType.DateTime)
                     ,new SqlParameter("@CustomerID", SqlDbType.Int,4),
                      new SqlParameter("@Pay_type_id", SqlDbType.Int,4),
                    new SqlParameter("@Pay_type", SqlDbType.VarChar,50),
                    new SqlParameter("@receive_money", SqlDbType.Decimal,9),
                     new SqlParameter("@IsHaveDetail", SqlDbType.Char,1) 
             };
			parameters[0].Value = model.F_Num;
			parameters[1].Value = model.F_StyleID;
			parameters[2].Value = model.F_StyleName;
			parameters[3].Value = model.ManDayPrice;
			parameters[4].Value = model.ManHour;
			parameters[5].Value = model.Amount;
			parameters[6].Value = model.AdjustAmount;
			parameters[7].Value = model.TotalAmount;
			parameters[8].Value = model.worker;
			parameters[9].Value = model.Remarks;
			parameters[10].Value = model.FromWhere;
			parameters[11].Value = model.CreatePerson;
			parameters[12].Value = model.CreateTime;
			parameters[13].Value = model.IsStatus;
			parameters[14].Value = model.DeleteTime;
            parameters[15].Value = model.CustomerID;
            parameters[16].Value = model.Pay_type_id;
            parameters[17].Value = model.Pay_type;
            parameters[18].Value = model.receive_money; 
            parameters[19].Value = model.IsHaveDetail; 

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

        public bool Addlist(string pid, string list )
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" INSERT INTO [dbo].[Financial_Labour_Cost_Detail]  ");
            sb.AppendLine("         ( [F_Num] ,  ");
            sb.AppendLine("           [material_id] ,  ");
            sb.AppendLine("           [material_name] ,  ");
            sb.AppendLine("           [specifications] ,  ");
            sb.AppendLine("           [model] ,  ");
            sb.AppendLine("           [unit] ,  ");
            sb.AppendLine("           [Fprice] ,  ");
            sb.AppendLine("           [Fsum] ,  ");
            sb.AppendLine("           [totalMoney] ,  ");
            sb.AppendLine("           [remarks]  ");
            sb.AppendLine("         )  ");


            sb.AppendLine("SELECT '" + pid + "',product_id,product_name,specifications,ProModel,unit,price,0,0,''");
                sb.AppendLine(" FROM dbo.CRM_product WHERE product_id IN(" + list + ")");

            sb.AppendLine("  UPDATE Financial_Labour_Cost SET	TotalAmount=(SELECT  SUM(totalMoney) FROM dbo.Financial_Labour_Cost_Detail  ");
            sb.AppendLine(" WHERE F_Num='" + pid + "')  ");
            sb.AppendLine(" WHERE	F_Num='" + pid + "'  ");

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
        public bool Updatedetail(string pid, string mid, decimal price, decimal sum, string remarks )
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("UPDATE	 dbo.Financial_Labour_Cost_Detail");
            sb.AppendLine(" SET");
            if (price > 0)
            {
                sb.AppendLine("          Fprice=" + price + " ");
                sb.AppendLine("         ,totalMoney=" + price + "*Fsum  ");
            }
            if (sum > 0)
            {
                sb.AppendLine("          Fsum=" + sum + " ");
                sb.AppendLine("         ,totalMoney=" + sum + "*Fprice  ");
            }
            if (remarks.Length > 0)
                sb.AppendLine("          remarks='" + remarks + "'");
            sb.AppendLine(" WHERE		F_Num='" + pid + "'");
            sb.AppendLine(" AND ");
            sb.AppendLine("          material_id='" + mid + "'"); 
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
        /// 更新一条数据
        /// </summary>
        public bool Update(XHD.Model.Financial_Labour_Cost model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Financial_Labour_Cost set ");
			strSql.Append("F_StyleID=@F_StyleID,");
			strSql.Append("F_StyleName=@F_StyleName,");
            strSql.Append("ManDayPrice=@ManDayPrice,");
			strSql.Append("ManHour=@ManHour,");
			strSql.Append("Amount=@Amount,");
			strSql.Append("AdjustAmount=@AdjustAmount,");
			strSql.Append("TotalAmount=@TotalAmount,");
			strSql.Append("worker=@worker,");
			strSql.Append("Remarks=@Remarks,"); 
			strSql.Append("IsStatus=@IsStatus,");
			strSql.Append("DeleteTime=@DeleteTime");
            strSql.Append(" ,CustomerID=@CustomerID,");
            strSql.Append("Pay_type_id=@Pay_type_id,");
            strSql.Append("IsHaveDetail=@IsHaveDetail,");
            strSql.Append("Pay_type=@Pay_type ");
            strSql.Append(" where F_Num=@F_Num ");
			SqlParameter[] parameters = {
					new SqlParameter("@F_StyleID", SqlDbType.Int,4),
					new SqlParameter("@F_StyleName", SqlDbType.VarChar,50),
					new SqlParameter("@ManDayPrice", SqlDbType.Decimal,9),
                 
                    new SqlParameter("@ManHour", SqlDbType.Decimal,9),
					new SqlParameter("@Amount", SqlDbType.Decimal,9),
					new SqlParameter("@AdjustAmount", SqlDbType.Decimal,9),
					new SqlParameter("@TotalAmount", SqlDbType.Decimal,9),
					new SqlParameter("@worker", SqlDbType.VarChar,50),
					new SqlParameter("@Remarks", SqlDbType.VarChar,50),
					new SqlParameter("@FromWhere", SqlDbType.VarChar,10),
					new SqlParameter("@CreatePerson", SqlDbType.VarChar,20),
					new SqlParameter("@CreateTime", SqlDbType.DateTime),
					new SqlParameter("@IsStatus", SqlDbType.Char,1),
					new SqlParameter("@DeleteTime", SqlDbType.DateTime),
					new SqlParameter("@F_Num", SqlDbType.VarChar,20)
                    ,   new SqlParameter("@CustomerID", SqlDbType.Int,4),
                       new SqlParameter("@Pay_type_id", SqlDbType.Int,4),
                          new SqlParameter("@IsHaveDetail", SqlDbType.Char,1), 
                    new SqlParameter("@Pay_type", SqlDbType.VarChar,50),
            };
			parameters[0].Value = model.F_StyleID;
			parameters[1].Value = model.F_StyleName;
			parameters[2].Value = model.ManDayPrice;
			parameters[3].Value = model.ManHour;
			parameters[4].Value = model.Amount;
			parameters[5].Value = model.AdjustAmount;
			parameters[6].Value = model.TotalAmount;
			parameters[7].Value = model.worker;
			parameters[8].Value = model.Remarks;
			parameters[9].Value = model.FromWhere;
			parameters[10].Value = model.CreatePerson;
			parameters[11].Value = model.CreateTime;
			parameters[12].Value = model.IsStatus;
			parameters[13].Value = model.DeleteTime;
			parameters[14].Value = model.F_Num;
            parameters[15].Value = model.CustomerID;
            parameters[16].Value = model.Pay_type_id;
            parameters[17].Value = model.IsHaveDetail; 
            parameters[18].Value = model.Pay_type;


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
		public bool Delete(string F_Num)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Financial_Labour_Cost ");
			strSql.Append(" where F_Num=@F_Num ");
			SqlParameter[] parameters = {
					new SqlParameter("@F_Num", SqlDbType.VarChar,20)			};
			parameters[0].Value = F_Num;

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
		public bool DeleteList(string F_Numlist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Financial_Labour_Cost ");
			strSql.Append(" where F_Num in ("+F_Numlist + ")  ");
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
		public XHD.Model.Financial_Labour_Cost GetModel(string F_Num)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 F_Num,F_StyleID,F_StyleName,ManDayPrice,ManHour,Amount,AdjustAmount,TotalAmount,worker,Remarks,FromWhere,CreatePerson,CreateTime,IsStatus,DeleteTime,CustomerID,Pay_type_id,Pay_type,IsHaveDetail,receive_money from Financial_Labour_Cost ");
			strSql.Append(" where F_Num=@F_Num ");
			SqlParameter[] parameters = {
					new SqlParameter("@F_Num", SqlDbType.VarChar,20)			};
			parameters[0].Value = F_Num;

			XHD.Model.Financial_Labour_Cost model=new XHD.Model.Financial_Labour_Cost();
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
		public XHD.Model.Financial_Labour_Cost DataRowToModel(DataRow row)
		{
			XHD.Model.Financial_Labour_Cost model=new XHD.Model.Financial_Labour_Cost();
			if (row != null)
			{
				if(row["F_Num"]!=null)
				{
					model.F_Num=row["F_Num"].ToString();
				}
				if(row["F_StyleID"]!=null && row["F_StyleID"].ToString()!="")
				{
					model.F_StyleID=int.Parse(row["F_StyleID"].ToString());
				}
				if(row["F_StyleName"]!=null)
				{
					model.F_StyleName=row["F_StyleName"].ToString();
				}
				if(row["ManDayPrice"]!=null && row["ManDayPrice"].ToString()!="")
				{
					model.ManDayPrice=decimal.Parse(row["ManDayPrice"].ToString());
				}
				if(row["ManHour"]!=null && row["ManHour"].ToString()!="")
				{
					model.ManHour=decimal.Parse(row["ManHour"].ToString());
				}
				if(row["Amount"]!=null && row["Amount"].ToString()!="")
				{
					model.Amount=decimal.Parse(row["Amount"].ToString());
				}
				if(row["AdjustAmount"]!=null && row["AdjustAmount"].ToString()!="")
				{
					model.AdjustAmount=decimal.Parse(row["AdjustAmount"].ToString());
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
				if(row["IsStatus"]!=null)
				{
					model.IsStatus=row["IsStatus"].ToString();
				}
                if (row["IsHaveDetail"] != null)
                {
                    model.IsHaveDetail = row["IsHaveDetail"].ToString();
                }
                

                if (row["DeleteTime"]!=null && row["DeleteTime"].ToString()!="")
				{
					model.DeleteTime=DateTime.Parse(row["DeleteTime"].ToString());
				}

                if (row["CustomerID"] != null && row["CustomerID"].ToString() != "")
                {
                    model.CustomerID = decimal.Parse(row["CustomerID"].ToString());
                }

                if (row["Pay_type_id"] != null && row["Pay_type_id"].ToString() != "")
                {
                    model.Pay_type_id = int.Parse(row["Pay_type_id"].ToString());
                }
                if (row["Pay_type"] != null && row["Pay_type"].ToString() != "")
                {
                    model.Pay_type = row["Pay_type"].ToString();
                }
                if (row["receive_money"] != null && row["receive_money"].ToString() != "")
                {
                    model.receive_money = decimal.Parse(row["receive_money"].ToString());  
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
			strSql.Append("select A.* , B.Customer+'【'+B.address+'】'+B.tel as Customer ");
			strSql.Append(" FROM Financial_Labour_Cost A ");
            strSql.Append(" INNER JOIN  dbo.CRM_Customer B ON	 A.CustomerID=B.id ");

            if (strWhere.Trim()!="")
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
			strSql.Append(" F_Num,F_StyleID,F_StyleName,ManDayPrice,ManHour,Amount,AdjustAmount,TotalAmount,worker,Remarks,FromWhere,CreatePerson,CreateTime,IsStatus,DeleteTime,CustomerID,Pay_type_id,Pay_type,IsHaveDetail,receive_money ");
			strSql.Append(" FROM Financial_Labour_Cost ");
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
			strSql.Append("select count(1) FROM Financial_Labour_Cost ");
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
				strSql.Append("order by T.F_Num desc");
			}
			strSql.Append(")AS Row, T.*  from Financial_Labour_Cost T ");
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
			parameters[0].Value = "Financial_Labour_Cost";
			parameters[1].Value = "F_Num";
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
            strSql.Append(" top " + PageSize + "  A.*, B.Customer+'【'+B.address+'】'+B.tel as Customer,isnull(c.Receive_amount,0) Receive_amount,a.TotalAmount-isnull(c.Receive_amount,0) as UnReceive_amount  from Financial_Labour_Cost A ");
            strSql.Append(" INNER JOIN  dbo.CRM_Customer B ON	 A.CustomerID=B.id ");
            strSql.Append(" left  JOIN (SELECT Customer_name, sum(Receive_amount)Receive_amount FROM  dbo.CRM_receive WHERE Customer_name IS NOT NULL GROUP BY Customer_name) C ON	 A.F_Num=c.Customer_name ");
 

            strSql.Append(" WHERE ( F_Num not in ( SELECT top " + (PageIndex - 1) * PageSize + " F_Num FROM Financial_Labour_Cost  ");
            if (filedOrder != "  F_Num  desc")
            {
                strSql.Append(" where " + strWhere + " order by " + filedOrder + " ,F_Num desc) )");
            }
            else
            {
                strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) )");
            };


            strSql1.Append(" select count(F_Num) FROM Financial_Labour_Cost A");
            strSql1.Append(" INNER JOIN  dbo.CRM_Customer B ON	 A.CustomerID=B.id ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            if (filedOrder != "  F_Num  desc")
            {
                strSql.Append(" ,F_Num desc ");
            };
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }
        public DataSet GetListPageDetail(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  A.*  from Financial_Labour_Cost_Detail A ");
 
            strSql.Append(" WHERE ( material_id not in ( SELECT top " + (PageIndex - 1) * PageSize + " material_id FROM Financial_Labour_Cost_Detail  ");
            if (filedOrder != "  material_id  desc")
            {
                strSql.Append(" where " + strWhere + " order by " + filedOrder + " ,material_id desc) )");
            }
            else
            {
                strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) )");
            };


            strSql1.Append(" select count(material_id) FROM Financial_Labour_Cost_Detail  ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            if (filedOrder != "  material_id  desc")
            {
                strSql.Append(" ,material_id desc ");
            };
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }

        public string GetMaxID(string per)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" SELECT dbo.[f_NextSerializeID]('" + per + "')");

            DataSet ds = DbHelperSQL.Query(strSql.ToString());
            return ds.Tables[0].Rows[0][0].ToString();
        }
        public bool DeleteDetail(string Purid, string MID)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from Financial_Labour_Cost_Detail ");
            strSql.Append(" where F_Num='" + Purid + "' "); 
            if (MID != "")
                strSql.Append(" AND material_id=" + MID + " ");
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
        


        #endregion  ExtensionMethod
    }
}

