using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
using XHD.DAL;
namespace XHD.BLL
{
	/// <summary>
	/// Financial_Change_Cost
	/// </summary>
	public partial class Financial_Change_Cost
	{
		 private readonly XHD.DAL.Financial_Change_Cost dal=new XHD.DAL.Financial_Change_Cost();
         public Financial_Change_Cost()
		{}
		#region  BasicMethod
		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(string F_Num)
		{
			return dal.Exists(F_Num);
		}

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.Financial_Change_Cost model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(XHD.Model.Financial_Change_Cost model)
		{
			return dal.Update(model);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(string F_Num)
		{
			
			return dal.Delete(F_Num);
		}
		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool DeleteList(string F_Numlist )
		{
			return dal.DeleteList(F_Numlist );
		}

		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public XHD.Model.Financial_Change_Cost GetModel(string F_Num)
		{
			
			return dal.GetModel(F_Num);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public XHD.Model.Financial_Change_Cost GetModelByCache(string F_Num)
		{
			
			string CacheKey = "Financial_Change_CostModel-" + F_Num;
			object objModel = XHD.Common.DataCache.GetCache(CacheKey);
			if (objModel == null)
			{
				try
				{
					objModel = dal.GetModel(F_Num);
					if (objModel != null)
					{
						int ModelCache = XHD.Common.ConfigHelper.GetConfigInt("ModelCache");
						XHD.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
					}
				}
				catch{}
			}
			return (XHD.Model.Financial_Change_Cost)objModel;
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
		public List<XHD.Model.Financial_Change_Cost> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<XHD.Model.Financial_Change_Cost> DataTableToList(DataTable dt)
		{
			List<XHD.Model.Financial_Change_Cost> modelList = new List<XHD.Model.Financial_Change_Cost>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				XHD.Model.Financial_Change_Cost model;
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
            return dal.GetListPage(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }
        public string GetMaxID(string per)
        {
            return dal.GetMaxID(per);
        }
        #endregion  ExtensionMethod
    }
}

