﻿using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
	/// <summary>
	/// KHJD_LIST_VIEW_LIST_person
	/// </summary>
	public partial class KHJD_LIST_VIEW_LIST_person
	{
		private readonly XHD.DAL.KHJD_LIST_VIEW_LIST_person dal=new XHD.DAL.KHJD_LIST_VIEW_LIST_person();
		public KHJD_LIST_VIEW_LIST_person()
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
		public bool Exists(int KHJDID,string CID,int JDID,int XMID,int userid,DateTime LRRQ,int status)
		{
			return dal.Exists(KHJDID,CID,JDID,XMID,userid,LRRQ,status);
		}

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.KHJD_LIST_VIEW_LIST_person model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(XHD.Model.KHJD_LIST_VIEW_LIST_person model)
		{
			return dal.Update(model);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(int KHJDID,string CID,int JDID,int XMID,int userid,DateTime LRRQ,int status)
		{
			
			return dal.Delete(KHJDID,CID,JDID,XMID,userid,LRRQ,status);
		}

		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public XHD.Model.KHJD_LIST_VIEW_LIST_person GetModel(int KHJDID,string CID,int JDID,int XMID,int userid,DateTime LRRQ,int status)
		{
			
			return dal.GetModel(KHJDID,CID,JDID,XMID,userid,LRRQ,status);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public XHD.Model.KHJD_LIST_VIEW_LIST_person GetModelByCache(int KHJDID,string CID,int JDID,int XMID,int userid,DateTime LRRQ,int status)
		{
			
			string CacheKey = "KHJD_LIST_VIEW_LIST_personModel-" + KHJDID+CID+JDID+XMID+userid+LRRQ+status;
			object objModel = XHD.Common.DataCache.GetCache(CacheKey);
			if (objModel == null)
			{
				try
				{
					objModel = dal.GetModel(KHJDID,CID,JDID,XMID,userid,LRRQ,status);
					if (objModel != null)
					{
						int ModelCache = XHD.Common.ConfigHelper.GetConfigInt("ModelCache");
						XHD.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
					}
				}
				catch{}
			}
			return (XHD.Model.KHJD_LIST_VIEW_LIST_person)objModel;
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
		public List<XHD.Model.KHJD_LIST_VIEW_LIST_person> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<XHD.Model.KHJD_LIST_VIEW_LIST_person> DataTableToList(DataTable dt)
		{
			List<XHD.Model.KHJD_LIST_VIEW_LIST_person> modelList = new List<XHD.Model.KHJD_LIST_VIEW_LIST_person>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				XHD.Model.KHJD_LIST_VIEW_LIST_person model;
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

		#endregion  ExtensionMethod
	}
}

