using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
	/// <summary>
	/// CRM_Cope_invoice
	/// </summary>
	public partial class CRM_Cope_invoice
	{
		private readonly XHD.DAL.CRM_Cope_invoice dal=new XHD.DAL.CRM_Cope_invoice();
        public CRM_Cope_invoice()
		{}
		#region  Method

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
			return dal.GetMaxId();
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int id)
		{
			return dal.Exists(id);
		}

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int  Add(XHD.Model.CRM_Cope_invoice model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(XHD.Model.CRM_Cope_invoice model)
		{
			return dal.Update(model);
		}

		/// <summary>
		/// 预删除
		/// </summary>
		/// <param name="id"></param>
		/// <param name="isDelete"></param>
		/// <param name="time"></param>
		/// <returns></returns>
		public bool AdvanceDelete(int id, int isDelete, string time)
		{
			return dal.AdvanceDelete(id, isDelete, time);
		}
		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(int id)
		{
			
			return dal.Delete(id);
		}
		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool DeleteList(string idlist )
		{
			return dal.DeleteList(idlist );
		}

		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public XHD.Model.CRM_Cope_invoice GetModel(int id)
		{
			
			return dal.GetModel(id);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public XHD.Model.CRM_Cope_invoice GetModelByCache(int id)
		{
			
			string CacheKey = "CRM_Cope_invoiceModel-" + id;
			object objModel = XHD.Common.DataCache.GetCache(CacheKey);
			if (objModel == null)
			{
				try
				{
					objModel = dal.GetModel(id);
					if (objModel != null)
					{
						int ModelCache = XHD.Common.ConfigHelper.GetConfigInt("ModelCache");
						XHD.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
					}
				}
				catch{}
			}
			return (XHD.Model.CRM_Cope_invoice)objModel;
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public DataSet GetList(string strWhere)
		{
			return dal.GetList(strWhere);
		}
		/// <summary>
		/// 获得前几行数据
		/// </summary>
		public DataSet GetList(int Top,string strWhere,string filedOrder)
		{
			return dal.GetList(Top,strWhere,filedOrder);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<XHD.Model.CRM_Cope_invoice> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<XHD.Model.CRM_Cope_invoice> DataTableToList(DataTable dt)
		{
			List<XHD.Model.CRM_Cope_invoice> modelList = new List<XHD.Model.CRM_Cope_invoice>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				XHD.Model.CRM_Cope_invoice model;
				for (int n = 0; n < rowsCount; n++)
				{
					model = new XHD.Model.CRM_Cope_invoice();
					if(dt.Rows[n]["id"]!=null && dt.Rows[n]["id"].ToString()!="")
					{
						model.id=int.Parse(dt.Rows[n]["id"].ToString());
					}
					if(dt.Rows[n]["Customer_id"]!=null && dt.Rows[n]["Customer_id"].ToString()!="")
					{
						model.Customer_id=int.Parse(dt.Rows[n]["Customer_id"].ToString());
					}
					if(dt.Rows[n]["Customer_name"]!=null && dt.Rows[n]["Customer_name"].ToString()!="")
					{
					model.Customer_name=dt.Rows[n]["Customer_name"].ToString();
					}
					if(dt.Rows[n]["invoice_num"]!=null && dt.Rows[n]["invoice_num"].ToString()!="")
					{
					model.invoice_num=dt.Rows[n]["invoice_num"].ToString();
					}
					if(dt.Rows[n]["invoice_type_id"]!=null && dt.Rows[n]["invoice_type_id"].ToString()!="")
					{
						model.invoice_type_id=int.Parse(dt.Rows[n]["invoice_type_id"].ToString());
					}
					if(dt.Rows[n]["invoice_type"]!=null && dt.Rows[n]["invoice_type"].ToString()!="")
					{
					model.invoice_type=dt.Rows[n]["invoice_type"].ToString();
					}
					if(dt.Rows[n]["invoice_amount"]!=null && dt.Rows[n]["invoice_amount"].ToString()!="")
					{
						model.invoice_amount=decimal.Parse(dt.Rows[n]["invoice_amount"].ToString());
					}
					if(dt.Rows[n]["invoice_content"]!=null && dt.Rows[n]["invoice_content"].ToString()!="")
					{
					model.invoice_content=dt.Rows[n]["invoice_content"].ToString();
					}
					if(dt.Rows[n]["invoice_date"]!=null && dt.Rows[n]["invoice_date"].ToString()!="")
					{
						model.invoice_date=DateTime.Parse(dt.Rows[n]["invoice_date"].ToString());
					}
					if(dt.Rows[n]["C_depid"]!=null && dt.Rows[n]["C_depid"].ToString()!="")
					{
						model.C_depid=int.Parse(dt.Rows[n]["C_depid"].ToString());
					}
					if(dt.Rows[n]["C_depname"]!=null && dt.Rows[n]["C_depname"].ToString()!="")
					{
					model.C_depname=dt.Rows[n]["C_depname"].ToString();
					}
					if(dt.Rows[n]["C_empid"]!=null && dt.Rows[n]["C_empid"].ToString()!="")
					{
						model.C_empid=int.Parse(dt.Rows[n]["C_empid"].ToString());
					}
					if(dt.Rows[n]["C_empname"]!=null && dt.Rows[n]["C_empname"].ToString()!="")
					{
					model.C_empname=dt.Rows[n]["C_empname"].ToString();
					}
					if(dt.Rows[n]["create_id"]!=null && dt.Rows[n]["create_id"].ToString()!="")
					{
						model.create_id=int.Parse(dt.Rows[n]["create_id"].ToString());
					}
					if(dt.Rows[n]["create_name"]!=null && dt.Rows[n]["create_name"].ToString()!="")
					{
					model.create_name=dt.Rows[n]["create_name"].ToString();
					}
					if(dt.Rows[n]["create_date"]!=null && dt.Rows[n]["create_date"].ToString()!="")
					{
						model.create_date=DateTime.Parse(dt.Rows[n]["create_date"].ToString());
					}
					if(dt.Rows[n]["order_id"]!=null && dt.Rows[n]["order_id"].ToString()!="")
					{
						model.order_id=dt.Rows[n]["order_id"].ToString();
					}
					if(dt.Rows[n]["isDelete"]!=null && dt.Rows[n]["isDelete"].ToString()!="")
					{
						model.isDelete=int.Parse(dt.Rows[n]["isDelete"].ToString());
					}
					if(dt.Rows[n]["Delete_time"]!=null && dt.Rows[n]["Delete_time"].ToString()!="")
					{
						model.Delete_time=DateTime.Parse(dt.Rows[n]["Delete_time"].ToString());
					}
					modelList.Add(model);
				}
			}
			return modelList;
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public DataSet GetAllList()
		{
			return GetList("");
		}

		/// <summary>
		/// 分页获取数据列表
		/// </summary>
		public DataSet GetList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
		{
			return dal.GetList(PageSize, PageIndex, strWhere, filedOrder, out Total);
		}

		#endregion  Method
	}
}

