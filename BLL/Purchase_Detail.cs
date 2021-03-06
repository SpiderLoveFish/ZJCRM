﻿using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
	/// <summary>
	/// Purchase_Detail
	/// </summary>
	public partial class Purchase_Detail
	{
		private readonly XHD.DAL.Purchase_Detail dal=new XHD.DAL.Purchase_Detail();
		public Purchase_Detail()
		{}
		#region  BasicMethod
		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(string Purid)
		{
			return dal.Exists(Purid);
		}

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.Purchase_Detail model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(XHD.Model.Purchase_Detail model)
		{
			return dal.Update(model);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(string Purid,string mid)
		{
			
			return dal.Delete(Purid,mid);
		}
		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool DeleteList(string Puridlist )
		{
			return dal.DeleteList(Puridlist );
		}

		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public XHD.Model.Purchase_Detail GetModel(string Purid)
		{
			
			return dal.GetModel(Purid);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public XHD.Model.Purchase_Detail GetModelByCache(string Purid)
		{
			
			string CacheKey = "Purchase_DetailModel-" + Purid;
			object objModel = XHD.Common.DataCache.GetCache(CacheKey);
			if (objModel == null)
			{
				try
				{
					objModel = dal.GetModel(Purid);
					if (objModel != null)
					{
						int ModelCache = XHD.Common.ConfigHelper.GetConfigInt("ModelCache");
                        XHD.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
					}
				}
				catch{}
			}
			return (XHD.Model.Purchase_Detail)objModel;
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
		public List<XHD.Model.Purchase_Detail> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<XHD.Model.Purchase_Detail> DataTableToList(DataTable dt)
		{
			List<XHD.Model.Purchase_Detail> modelList = new List<XHD.Model.Purchase_Detail>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				XHD.Model.Purchase_Detail model;
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

        public DataSet GetPur_ViewList(int PageSize, int PageIndex, string strWhere)
        {
            return dal.GetPur_ViewList( PageSize,  PageIndex,  strWhere);
        }
            #endregion  BasicMethod
            #region  ExtensionMethod
            public bool Addlist(string pid, string list,string isauto)
        {
            return dal.Addlist(pid,list, isauto);
        }
        public bool AddlistDB(string pid, string list, string cid)
        {
            return dal.AddlistDB(pid, list, cid);
        }
            public DataSet GetPurchase_Detail(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetPurchase_Detail(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }

        public DataSet GetSuppPur_ViewList(int PageSize, int PageIndex, string strWhere, string starttime, string endtime)
        {
            return dal.GetSuppPur_ViewList(  PageSize,   PageIndex,   strWhere,   starttime,   endtime);
        }
        public DataSet GetSuppPur_DetailList(int PageSize, int PageIndex, string strWhere, string starttime, string endtime)
        {
            return dal.GetSuppPur_DetailList( PageSize, PageIndex,  strWhere,  starttime,  endtime);
        }
            public bool Updatedetail(string pid, string mid, decimal price, decimal sum, string remarks,string cid)
        {
            return  dal.Updatedetail(pid, mid, price, sum, remarks,cid);
        }
        public bool UpdatedetailDB(string pid, string mid, decimal price, decimal sum, string remarks, string cid)
        {
            return dal.UpdatedetailDB(pid, mid, price, sum, remarks, cid);
        }
        public bool Updatestock(string pid,string mid, string stockid)
        {
            return dal.Updatestock(pid, mid,stockid);
        }
		#endregion  ExtensionMethod
	}
}

