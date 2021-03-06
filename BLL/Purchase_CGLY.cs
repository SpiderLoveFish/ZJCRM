﻿using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
	/// <summary>
	/// Purchase_CGLY
	/// </summary>
	public partial class Purchase_CGLY
	{
		private readonly XHD.DAL.Purchase_CGLY dal=new XHD.DAL.Purchase_CGLY();
		public Purchase_CGLY()
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
		public bool Add(XHD.Model.Purchase_CGLY model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(XHD.Model.Purchase_CGLY model)
		{
			return dal.Update(model);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(string Purid)
		{
			
			return dal.Delete(Purid);
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
		public XHD.Model.Purchase_CGLY GetModel(string Purid)
		{
			
			return dal.GetModel(Purid);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public XHD.Model.Purchase_CGLY GetModelByCache(string Purid)
		{
			
			string CacheKey = "Purchase_CGLYModel-" + Purid;
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
			return (XHD.Model.Purchase_CGLY)objModel;
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
		public List<XHD.Model.Purchase_CGLY> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<XHD.Model.Purchase_CGLY> DataTableToList(DataTable dt)
		{
			List<XHD.Model.Purchase_CGLY> modelList = new List<XHD.Model.Purchase_CGLY>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				XHD.Model.Purchase_CGLY model;
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
        public DataSet GetPurchase_CGLY(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetPurchase_CGLY(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }
        public DataSet GetCgGl_Gys_Main(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetCgGl_Gys_Main(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }

        public bool Add(string pid, string supid, string user, string cid, string remarks, string isgd
            ,string did,string dname,string purstyle,string cgstyle)
        {
            return dal.Add(pid, supid, user, cid, remarks, isgd, did,   dname,   purstyle,   cgstyle);
        }
        public bool updateremarks(string pid, string remarks, string date, string isgd)
        {
            return dal.updateremarks(pid, remarks, date, isgd);
        }

        public DataSet GetListdetail(string strWhere)
        {
            return dal.GetListdetail(strWhere);
        }

        public int updatetotal(string pid, decimal status)
        {
            return dal.updatetotal(pid, status);
        }

        public bool Updatestatus(string pid, string status)
        {
            return dal.Updatestatus(pid, status);
        }
        public DataSet GetKcGl_Jcb_Cklb(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetKcGl_Jcb_Cklb(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }
        public DataSet GetListCklb(string strWhere)
        {
            return dal.GetListCklb(strWhere);
        }

        public DataSet GetList_main(string strWhere)
        {
            return dal.GetList_main(strWhere);
        }

        public bool UpdateInvoice(string orderid)
        {
            return dal.UpdateInvoice(orderid);
        }

        public bool UpdateReceive(string orderid)
        {
            return dal.UpdateReceive(orderid);
        }
        #endregion  ExtensionMethod
    }
}

