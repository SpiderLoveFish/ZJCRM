﻿using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Budge_Model
	/// </summary>
	public partial class Budge_Model
	{
		public Budge_Model()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "Budge_Model"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Budge_Model");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
			parameters[0].Value = id;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.Budge_Model model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Budge_Model(");
			strSql.Append("id,Moudel_id,budge_id,xmid,ComponentName,Cname,unit,MmaterialPrice,IsShowPrice,SecmaterialPrice,ArtificialPrice,MechanicalLoss,MaterialLoss,TotalPrice,IsDiscount,TotalDiscountPrice,MaterialCost,MechanicalCost,ArtificialCost,SUM,Remarks)");
			strSql.Append(" values (");
			strSql.Append("@id,@Moudel_id,@budge_id,@xmid,@ComponentName,@Cname,@unit,@MmaterialPrice,@IsShowPrice,@SecmaterialPrice,@ArtificialPrice,@MechanicalLoss,@MaterialLoss,@TotalPrice,@IsDiscount,@TotalDiscountPrice,@MaterialCost,@MechanicalCost,@ArtificialCost,@SUM,@Remarks)");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4),
					new SqlParameter("@Moudel_id", SqlDbType.VarChar,15),
					new SqlParameter("@budge_id", SqlDbType.VarChar,15),
					new SqlParameter("@xmid", SqlDbType.VarChar,15),
					new SqlParameter("@ComponentName", SqlDbType.VarChar,100),
					new SqlParameter("@Cname", SqlDbType.VarChar,100),
					new SqlParameter("@unit", SqlDbType.VarChar,20),
					new SqlParameter("@MmaterialPrice", SqlDbType.Decimal,9),
					new SqlParameter("@IsShowPrice", SqlDbType.Bit,1),
					new SqlParameter("@SecmaterialPrice", SqlDbType.Decimal,9),
					new SqlParameter("@ArtificialPrice", SqlDbType.Decimal,9),
					new SqlParameter("@MechanicalLoss", SqlDbType.Decimal,9),
					new SqlParameter("@MaterialLoss", SqlDbType.Decimal,9),
					new SqlParameter("@TotalPrice", SqlDbType.Decimal,9),
					new SqlParameter("@IsDiscount", SqlDbType.Bit,1),
					new SqlParameter("@TotalDiscountPrice", SqlDbType.Decimal,9),
					new SqlParameter("@MaterialCost", SqlDbType.Decimal,9),
					new SqlParameter("@MechanicalCost", SqlDbType.Decimal,9),
					new SqlParameter("@ArtificialCost", SqlDbType.Decimal,9),
					new SqlParameter("@SUM", SqlDbType.Decimal,9),
					new SqlParameter("@Remarks", SqlDbType.VarChar,-1)};
			parameters[0].Value = model.id;
			parameters[1].Value = model.Moudel_id;
			parameters[2].Value = model.budge_id;
			parameters[3].Value = model.xmid;
			parameters[4].Value = model.ComponentName;
			parameters[5].Value = model.Cname;
			parameters[6].Value = model.unit;
			parameters[7].Value = model.MmaterialPrice;
			parameters[8].Value = model.IsShowPrice;
			parameters[9].Value = model.SecmaterialPrice;
			parameters[10].Value = model.ArtificialPrice;
			parameters[11].Value = model.MechanicalLoss;
			parameters[12].Value = model.MaterialLoss;
			parameters[13].Value = model.TotalPrice;
			parameters[14].Value = model.IsDiscount;
			parameters[15].Value = model.TotalDiscountPrice;
			parameters[16].Value = model.MaterialCost;
			parameters[17].Value = model.MechanicalCost;
			parameters[18].Value = model.ArtificialCost;
			parameters[19].Value = model.SUM;
			parameters[20].Value = model.Remarks;

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
		public bool Update(XHD.Model.Budge_Model model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Budge_Model set ");
			strSql.Append("Moudel_id=@Moudel_id,");
			strSql.Append("budge_id=@budge_id,");
			strSql.Append("xmid=@xmid,");
			strSql.Append("ComponentName=@ComponentName,");
			strSql.Append("Cname=@Cname,");
			strSql.Append("unit=@unit,");
			strSql.Append("MmaterialPrice=@MmaterialPrice,");
			strSql.Append("IsShowPrice=@IsShowPrice,");
			strSql.Append("SecmaterialPrice=@SecmaterialPrice,");
			strSql.Append("ArtificialPrice=@ArtificialPrice,");
			strSql.Append("MechanicalLoss=@MechanicalLoss,");
			strSql.Append("MaterialLoss=@MaterialLoss,");
			strSql.Append("TotalPrice=@TotalPrice,");
			strSql.Append("IsDiscount=@IsDiscount,");
			strSql.Append("TotalDiscountPrice=@TotalDiscountPrice,");
			strSql.Append("MaterialCost=@MaterialCost,");
			strSql.Append("MechanicalCost=@MechanicalCost,");
			strSql.Append("ArtificialCost=@ArtificialCost,");
			strSql.Append("SUM=@SUM,");
			strSql.Append("Remarks=@Remarks");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@Moudel_id", SqlDbType.VarChar,15),
					new SqlParameter("@budge_id", SqlDbType.VarChar,15),
					new SqlParameter("@xmid", SqlDbType.VarChar,15),
					new SqlParameter("@ComponentName", SqlDbType.VarChar,100),
					new SqlParameter("@Cname", SqlDbType.VarChar,100),
					new SqlParameter("@unit", SqlDbType.VarChar,20),
					new SqlParameter("@MmaterialPrice", SqlDbType.Decimal,9),
					new SqlParameter("@IsShowPrice", SqlDbType.Bit,1),
					new SqlParameter("@SecmaterialPrice", SqlDbType.Decimal,9),
					new SqlParameter("@ArtificialPrice", SqlDbType.Decimal,9),
					new SqlParameter("@MechanicalLoss", SqlDbType.Decimal,9),
					new SqlParameter("@MaterialLoss", SqlDbType.Decimal,9),
					new SqlParameter("@TotalPrice", SqlDbType.Decimal,9),
					new SqlParameter("@IsDiscount", SqlDbType.Bit,1),
					new SqlParameter("@TotalDiscountPrice", SqlDbType.Decimal,9),
					new SqlParameter("@MaterialCost", SqlDbType.Decimal,9),
					new SqlParameter("@MechanicalCost", SqlDbType.Decimal,9),
					new SqlParameter("@ArtificialCost", SqlDbType.Decimal,9),
					new SqlParameter("@SUM", SqlDbType.Decimal,9),
					new SqlParameter("@Remarks", SqlDbType.VarChar,-1),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.Moudel_id;
			parameters[1].Value = model.budge_id;
			parameters[2].Value = model.xmid;
			parameters[3].Value = model.ComponentName;
			parameters[4].Value = model.Cname;
			parameters[5].Value = model.unit;
			parameters[6].Value = model.MmaterialPrice;
			parameters[7].Value = model.IsShowPrice;
			parameters[8].Value = model.SecmaterialPrice;
			parameters[9].Value = model.ArtificialPrice;
			parameters[10].Value = model.MechanicalLoss;
			parameters[11].Value = model.MaterialLoss;
			parameters[12].Value = model.TotalPrice;
			parameters[13].Value = model.IsDiscount;
			parameters[14].Value = model.TotalDiscountPrice;
			parameters[15].Value = model.MaterialCost;
			parameters[16].Value = model.MechanicalCost;
			parameters[17].Value = model.ArtificialCost;
			parameters[18].Value = model.SUM;
			parameters[19].Value = model.Remarks;
			parameters[20].Value = model.id;

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
			strSql.Append("delete from Budge_Model ");
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
        public bool Delete(string modelid)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from Budge_Model ");
            strSql.Append(" where model_id='" + modelid + "' ");
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
		/// 批量删除数据
		/// </summary>
		public bool DeleteList(string idlist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Budge_Model ");
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
		public XHD.Model.Budge_Model GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,Moudel_id,budge_id,xmid,ComponentName,Cname,unit,MmaterialPrice,IsShowPrice,SecmaterialPrice,ArtificialPrice,MechanicalLoss,MaterialLoss,TotalPrice,IsDiscount,TotalDiscountPrice,MaterialCost,MechanicalCost,ArtificialCost,SUM,Remarks from Budge_Model ");
			strSql.Append(" where id=@id ");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
			parameters[0].Value = id;

			XHD.Model.Budge_Model model=new XHD.Model.Budge_Model();
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
		public XHD.Model.Budge_Model DataRowToModel(DataRow row)
		{
			XHD.Model.Budge_Model model=new XHD.Model.Budge_Model();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["Moudel_id"]!=null)
				{
					model.Moudel_id=row["Moudel_id"].ToString();
				}
				if(row["budge_id"]!=null)
				{
					model.budge_id=row["budge_id"].ToString();
				}
				if(row["xmid"]!=null)
				{
					model.xmid=int.Parse(row["xmid"].ToString());
				}
				if(row["ComponentName"]!=null)
				{
					model.ComponentName=row["ComponentName"].ToString();
				}
				if(row["Cname"]!=null)
				{
					model.Cname=row["Cname"].ToString();
				}
				if(row["unit"]!=null)
				{
					model.unit=row["unit"].ToString();
				}
				if(row["MmaterialPrice"]!=null && row["MmaterialPrice"].ToString()!="")
				{
					model.MmaterialPrice=decimal.Parse(row["MmaterialPrice"].ToString());
				}
				if(row["IsShowPrice"]!=null && row["IsShowPrice"].ToString()!="")
				{
					if((row["IsShowPrice"].ToString()=="1")||(row["IsShowPrice"].ToString().ToLower()=="true"))
					{
						model.IsShowPrice=true;
					}
					else
					{
						model.IsShowPrice=false;
					}
				}
				if(row["SecmaterialPrice"]!=null && row["SecmaterialPrice"].ToString()!="")
				{
					model.SecmaterialPrice=decimal.Parse(row["SecmaterialPrice"].ToString());
				}
				if(row["ArtificialPrice"]!=null && row["ArtificialPrice"].ToString()!="")
				{
					model.ArtificialPrice=decimal.Parse(row["ArtificialPrice"].ToString());
				}
				if(row["MechanicalLoss"]!=null && row["MechanicalLoss"].ToString()!="")
				{
					model.MechanicalLoss=decimal.Parse(row["MechanicalLoss"].ToString());
				}
				if(row["MaterialLoss"]!=null && row["MaterialLoss"].ToString()!="")
				{
					model.MaterialLoss=decimal.Parse(row["MaterialLoss"].ToString());
				}
				if(row["TotalPrice"]!=null && row["TotalPrice"].ToString()!="")
				{
					model.TotalPrice=decimal.Parse(row["TotalPrice"].ToString());
				}
				if(row["IsDiscount"]!=null && row["IsDiscount"].ToString()!="")
				{
					if((row["IsDiscount"].ToString()=="1")||(row["IsDiscount"].ToString().ToLower()=="true"))
					{
						model.IsDiscount=true;
					}
					else
					{
						model.IsDiscount=false;
					}
				}
				if(row["TotalDiscountPrice"]!=null && row["TotalDiscountPrice"].ToString()!="")
				{
					model.TotalDiscountPrice=decimal.Parse(row["TotalDiscountPrice"].ToString());
				}
				if(row["MaterialCost"]!=null && row["MaterialCost"].ToString()!="")
				{
					model.MaterialCost=decimal.Parse(row["MaterialCost"].ToString());
				}
				if(row["MechanicalCost"]!=null && row["MechanicalCost"].ToString()!="")
				{
					model.MechanicalCost=decimal.Parse(row["MechanicalCost"].ToString());
				}
				if(row["ArtificialCost"]!=null && row["ArtificialCost"].ToString()!="")
				{
					model.ArtificialCost=decimal.Parse(row["ArtificialCost"].ToString());
				}
				if(row["SUM"]!=null && row["SUM"].ToString()!="")
				{
					model.SUM=decimal.Parse(row["SUM"].ToString());
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
			strSql.Append("select id,Moudel_id,budge_id,xmid,ComponentName,Cname,unit,MmaterialPrice,IsShowPrice,SecmaterialPrice,ArtificialPrice,MechanicalLoss,MaterialLoss,TotalPrice,IsDiscount,TotalDiscountPrice,MaterialCost,MechanicalCost,ArtificialCost,SUM,Remarks ");
			strSql.Append(" FROM Budge_Model ");
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
			strSql.Append(" id,Moudel_id,budge_id,xmid,ComponentName,Cname,unit,MmaterialPrice,IsShowPrice,SecmaterialPrice,ArtificialPrice,MechanicalLoss,MaterialLoss,TotalPrice,IsDiscount,TotalDiscountPrice,MaterialCost,MechanicalCost,ArtificialCost,SUM,Remarks ");
			strSql.Append(" FROM Budge_Model ");
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
			strSql.Append("select count(1) FROM Budge_Model ");
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
			strSql.Append(")AS Row, T.*  from Budge_Model T ");
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
			parameters[0].Value = "Budge_Model";
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
        public DataSet GetBudge_Model(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  A.*,B.product_name  FROM dbo.Budge_Model  A INNER JOIN dbo.CRM_product B ON A.xmid=B.product_id   ");
            strSql.Append(" WHERE A.id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM Budge_Model ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM Budge_Model ");
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

