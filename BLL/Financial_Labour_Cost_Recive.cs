using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
	/// <summary>
	/// Financial_Labour_Cost_Recive
	/// </summary>
	public partial class Financial_Labour_Cost_Recive
	{
		private readonly XHD.DAL.Financial_Labour_Cost_Recive dal=new XHD.DAL.Financial_Labour_Cost_Recive();
		public Financial_Labour_Cost_Recive()
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
		public int  Add(XHD.Model.Financial_Labour_Cost_Recive model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(XHD.Model.Financial_Labour_Cost_Recive model)
		{
			return dal.Update(model);
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
		public XHD.Model.Financial_Labour_Cost_Recive GetModel(int id)
		{
			
			return dal.GetModel(id);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public XHD.Model.Financial_Labour_Cost_Recive GetModelByCache(int id)
		{
			
			string CacheKey = "Financial_Labour_Cost_ReciveModel-" + id;
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
			return (XHD.Model.Financial_Labour_Cost_Recive)objModel;
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
		public List<XHD.Model.Financial_Labour_Cost_Recive> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<XHD.Model.Financial_Labour_Cost_Recive> DataTableToList(DataTable dt)
		{
			List<XHD.Model.Financial_Labour_Cost_Recive> modelList = new List<XHD.Model.Financial_Labour_Cost_Recive>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				XHD.Model.Financial_Labour_Cost_Recive model;
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
        /// 更新发票金额
        /// </summary>
        /// <param name="orderid"></param>
        /// <returns></returns>
        public bool UpdateInvoice(string orderid)
        {
            return dal.UpdateInvoice(orderid);
        }

        /// <summary>
        /// 更新收款金额
        /// </summary>
        /// <param name="orderid"></param>
        /// <returns></returns>
        public bool UpdateReceive(string orderid)
        {
            return dal.UpdateReceive(orderid);
        }
        public DataSet GetList_F_l_C_R(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetList_F_l_C_R(  PageSize,   PageIndex,   strWhere,   filedOrder, out   Total);
        }
            #endregion  ExtensionMethod
        }
}

