using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
	/// <summary>
	/// 数据访问类:Crm_Classic_case
	/// </summary>
	public partial class Crm_Classic_case
	{
		public Crm_Classic_case()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("id", "Crm_Classic_case"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Crm_Classic_case");
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
		public int Add(XHD.Model.Crm_Classic_case model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Crm_Classic_case(");
			strSql.Append("c_title,customer_id,customer_name,Community,housearea,housetype,decorationtpye,designer,img_style,URL,thum_img,remarks,IsStatus)");
			strSql.Append(" values (");
			strSql.Append("@c_title,@customer_id,@customer_name,@Community,@housearea,@housetype,@decorationtpye,@designer,@img_style,@URL,@thum_img,@remarks,@IsStatus)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@c_title", SqlDbType.VarChar,250),
					new SqlParameter("@customer_id", SqlDbType.Int,4),
					new SqlParameter("@customer_name", SqlDbType.VarChar,250),
					new SqlParameter("@Community", SqlDbType.VarChar,150),
					new SqlParameter("@housearea", SqlDbType.VarChar,50),
					new SqlParameter("@housetype", SqlDbType.VarChar,50),
					new SqlParameter("@decorationtpye", SqlDbType.VarChar,50),
					new SqlParameter("@designer", SqlDbType.VarChar,50),
					new SqlParameter("@img_style", SqlDbType.VarChar,5),
					new SqlParameter("@URL", SqlDbType.VarChar,100),
					new SqlParameter("@thum_img", SqlDbType.VarChar,50),
					new SqlParameter("@remarks", SqlDbType.VarChar,50),
					new SqlParameter("@IsStatus", SqlDbType.VarChar,5)};
			parameters[0].Value = model.c_title;
			parameters[1].Value = model.customer_id;
			parameters[2].Value = model.customer_name;
			parameters[3].Value = model.Community;
			parameters[4].Value = model.housearea;
			parameters[5].Value = model.housetype;
			parameters[6].Value = model.decorationtpye;
			parameters[7].Value = model.designer;
			parameters[8].Value = model.img_style;
			parameters[9].Value = model.URL;
			parameters[10].Value = model.thum_img;
			parameters[11].Value = model.remarks;
			parameters[12].Value = model.IsStatus;

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
		public bool Update(XHD.Model.Crm_Classic_case model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Crm_Classic_case set ");
			strSql.Append("c_title=@c_title,");
			strSql.Append("customer_id=@customer_id,");
			strSql.Append("customer_name=@customer_name,");
			strSql.Append("Community=@Community,");
			strSql.Append("housearea=@housearea,");
			strSql.Append("housetype=@housetype,");
			strSql.Append("decorationtpye=@decorationtpye,");
			strSql.Append("designer=@designer,");
			strSql.Append("img_style=@img_style,");
			strSql.Append("URL=@URL,");
			strSql.Append("thum_img=@thum_img,");
			strSql.Append("remarks=@remarks,");
			strSql.Append("IsStatus=@IsStatus");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@c_title", SqlDbType.VarChar,250),
					new SqlParameter("@customer_id", SqlDbType.Int,4),
					new SqlParameter("@customer_name", SqlDbType.VarChar,250),
					new SqlParameter("@Community", SqlDbType.VarChar,150),
					new SqlParameter("@housearea", SqlDbType.VarChar,50),
					new SqlParameter("@housetype", SqlDbType.VarChar,50),
					new SqlParameter("@decorationtpye", SqlDbType.VarChar,50),
					new SqlParameter("@designer", SqlDbType.VarChar,50),
					new SqlParameter("@img_style", SqlDbType.VarChar,5),
					new SqlParameter("@URL", SqlDbType.VarChar,100),
					new SqlParameter("@thum_img", SqlDbType.VarChar,50),
					new SqlParameter("@remarks", SqlDbType.VarChar,50),
					new SqlParameter("@IsStatus", SqlDbType.VarChar,5),
					new SqlParameter("@id", SqlDbType.Int,4)};
			parameters[0].Value = model.c_title;
			parameters[1].Value = model.customer_id;
			parameters[2].Value = model.customer_name;
			parameters[3].Value = model.Community;
			parameters[4].Value = model.housearea;
			parameters[5].Value = model.housetype;
			parameters[6].Value = model.decorationtpye;
			parameters[7].Value = model.designer;
			parameters[8].Value = model.img_style;
			parameters[9].Value = model.URL;
			parameters[10].Value = model.thum_img;
			parameters[11].Value = model.remarks;
			parameters[12].Value = model.IsStatus;
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
			strSql.Append("delete from Crm_Classic_case ");
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
			strSql.Append("delete from Crm_Classic_case ");
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
		public XHD.Model.Crm_Classic_case GetModel(int id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 id,c_title,customer_id,customer_name,Community,housearea,housetype,decorationtpye,designer,img_style,URL,thum_img,remarks,IsStatus from Crm_Classic_case ");
			strSql.Append(" where id=@id");
			SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
			parameters[0].Value = id;

			XHD.Model.Crm_Classic_case model=new XHD.Model.Crm_Classic_case();
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
		public XHD.Model.Crm_Classic_case DataRowToModel(DataRow row)
		{
			XHD.Model.Crm_Classic_case model=new XHD.Model.Crm_Classic_case();
			if (row != null)
			{
				if(row["id"]!=null && row["id"].ToString()!="")
				{
					model.id=int.Parse(row["id"].ToString());
				}
				if(row["c_title"]!=null)
				{
					model.c_title=row["c_title"].ToString();
				}
				if(row["customer_id"]!=null && row["customer_id"].ToString()!="")
				{
					model.customer_id=int.Parse(row["customer_id"].ToString());
				}
				if(row["customer_name"]!=null)
				{
					model.customer_name=row["customer_name"].ToString();
				}
				if(row["Community"]!=null)
				{
					model.Community=row["Community"].ToString();
				}
				if(row["housearea"]!=null)
				{
					model.housearea=row["housearea"].ToString();
				}
				if(row["housetype"]!=null)
				{
					model.housetype=row["housetype"].ToString();
				}
				if(row["decorationtpye"]!=null)
				{
					model.decorationtpye=row["decorationtpye"].ToString();
				}
				if(row["designer"]!=null)
				{
					model.designer=row["designer"].ToString();
				}
				if(row["img_style"]!=null)
				{
					model.img_style=row["img_style"].ToString();
				}
				if(row["URL"]!=null)
				{
					model.URL=row["URL"].ToString();
				}
				if(row["thum_img"]!=null)
				{
					model.thum_img=row["thum_img"].ToString();
				}
				if(row["remarks"]!=null)
				{
					model.remarks=row["remarks"].ToString();
				}
				if(row["IsStatus"]!=null)
				{
					model.IsStatus=row["IsStatus"].ToString();
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
			strSql.Append("select id,c_title,customer_id,customer_name,Community,housearea,housetype,decorationtpye,designer,img_style,URL,thum_img,remarks,IsStatus ");
			strSql.Append(" FROM Crm_Classic_case ");
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
			strSql.Append(" id,c_title,customer_id,customer_name,Community,housearea,housetype,decorationtpye,designer,img_style,URL,thum_img,remarks,IsStatus ");
			strSql.Append(" FROM Crm_Classic_case ");
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
			strSql.Append("select count(1) FROM Crm_Classic_case ");
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
			strSql.Append(")AS Row, T.*  from Crm_Classic_case T ");
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
			parameters[0].Value = "Crm_Classic_case";
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

		#endregion  ExtensionMethod
	}
}

