﻿using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
	/// <summary>
	/// PurchaseList
	/// </summary>
	public partial class PurchaseList
	{
		private readonly XHD.DAL.PurchaseList dal=new XHD.DAL.PurchaseList();
		public PurchaseList()
		{}
		#region  BasicMethod

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
		public int  Add(XHD.Model.PurchaseList model)
		{
			return dal.Add(model);
		}
        /// <summary>
        /// 多个选择插入数据
        /// </summary>
        /// <param name="cid"></param>
        /// <param name="pid"></param>
        /// <returns></returns>
        public int InsertList(int cid, string pid, string emp_id,string style)
        {
            return dal.InsertList(cid, pid, emp_id,style);
             
        }

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(XHD.Model.PurchaseList model)
		{
			return dal.Update(model);
		}
        public bool UpdateRemarks(string SupplierName, string t_contents, int cid, int id
            ,DateTime RequestDate,string Sender, string ShippingMethod, string Receiver, string b1, string b2, string b3)
        {
            return dal.UpdateRemarks(SupplierName,   t_contents,   cid,   id, RequestDate, Sender, ShippingMethod, Receiver, b1, b2, b3);
        }
            public bool UpdateZT(int status, int empid, int cid, int id)
        {
            return dal.UpdateZT(status,empid,cid,id);
        }
        public bool UpdateSUM(decimal sum, int empid, int cid, int id)
        {
            return dal.UpdateSUM(sum, empid, cid, id);
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
		public XHD.Model.PurchaseList GetModel(int id)
		{
			
			return dal.GetModel(id);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public XHD.Model.PurchaseList GetModelByCache(int id)
		{
			
			string CacheKey = "PurchaseListModel-" + id;
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
			return (XHD.Model.PurchaseList)objModel;
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
		public List<XHD.Model.PurchaseList> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<XHD.Model.PurchaseList> DataTableToList(DataTable dt)
		{
			List<XHD.Model.PurchaseList> modelList = new List<XHD.Model.PurchaseList>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				XHD.Model.PurchaseList model;
				for (int n = 0; n < rowsCount; n++)
				{
					model = dal.DataRowToModel(dt.Rows[n]);
					if (model != null)
					{
						modelList.Add(model);
					}
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
		public int GetRecordCount(string strWhere)
		{
			return dal.GetRecordCount(strWhere);
		}
		/// <summary>
		/// 分页获取数据列表
		/// </summary>
		public DataSet GetListByPage(string strWhere, string orderby, int startIndex, int endIndex)
		{
			return dal.GetListByPage( strWhere,  orderby,  startIndex,  endIndex);
		}
		/// <summary>
		/// 分页获取数据列表
		/// </summary>
		//public DataSet GetList(int PageSize,int PageIndex,string strWhere)
		//{
			//return dal.GetList(PageSize,PageIndex,strWhere);
		//}

		#endregion  BasicMethod
		#region  ExtensionMethod
        public DataSet GetList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetList(PageSize, PageIndex, strWhere,filedOrder,out Total);
        }


        public DataSet GetTempList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetTempList(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }
        public DataSet GetRefMaterialsList(int PageSize, int PageIndex, string strWhere,string strorder)
        {
            return dal.GetRefMaterialsList(PageSize, PageIndex, strWhere, strorder);
        }
        public DataSet GetysList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetysList(PageSize, PageIndex, strWhere, filedOrder, out Total);
      
        }
        public DataSet GetTempListDB(int PageSize, int PageIndex, string strWhere,string cid, string filedOrder, out string Total)
        {
            return dal.GetTempListDB(PageSize, PageIndex, strWhere,cid, filedOrder, out Total);
        }
            #endregion  ExtensionMethod
        }
}

