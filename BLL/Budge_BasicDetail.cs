using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
	/// <summary>
	/// Budge_BasicDetail
	/// </summary>
	public partial class Budge_BasicDetail
	{
		private readonly XHD.DAL.Budge_BasicDetail dal=new XHD.DAL.Budge_BasicDetail();
		public Budge_BasicDetail()
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
		public int  Add(XHD.Model.Budge_BasicDetail model)
		{
			return dal.Add(model);
		}

        public int insertlist(string bid, string xmlistid, string compname)
        { 
            return dal.insertlist(bid,xmlistid,compname);
        }

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(XHD.Model.Budge_BasicDetail model)
		{
			return dal.Update(model);
		}
        public bool UpdateSum(decimal sum, int id, string bid,int orderby)
        {
            return dal.UpdateSum(sum, id, bid, orderby);
        }
        //折扣价格
        public bool UpdateDisPrice(decimal sum,   string bid)
        {
            return dal.UpdateDisPrice(sum,  bid);
        }
        //刷新价格
        public bool UpdateRefreshPrice( string bid)
        {
            return dal.UpdateRefreshPrice(bid);
        }
        
        /// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(int id)
		{
			
			return dal.Delete(id);
		}

        public bool Delete_comp(string comp, string bid)
        {
            return dal.Delete_comp(comp, bid);
        }
        public bool Delete_id(int id, string bid)
        {
            return dal.Delete_id(id, bid);
     
        }
            /// </summary>
        public bool Delete(string bid)
        {
            return dal.Delete(bid);
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
		public XHD.Model.Budge_BasicDetail GetModel(int id)
		{
			
			return dal.GetModel(id);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public XHD.Model.Budge_BasicDetail GetModelByCache(int id)
		{
			
			string CacheKey = "Budge_BasicDetailModel-" + id;
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
			return (XHD.Model.Budge_BasicDetail)objModel;
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
		public List<XHD.Model.Budge_BasicDetail> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<XHD.Model.Budge_BasicDetail> DataTableToList(DataTable dt)
		{
			List<XHD.Model.Budge_BasicDetail> modelList = new List<XHD.Model.Budge_BasicDetail>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				XHD.Model.Budge_BasicDetail model;
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
        /// <summary>
        /// 分页获取数据正式明细列表
        /// </summary>
        public DataSet GetBudge_BasicDetail(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetBudge_BasicDetail(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }

		#endregion  ExtensionMethod
	}
}

