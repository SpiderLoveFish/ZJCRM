using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
	/// <summary>
	/// Crm_CEDetail_Version
	/// </summary>
	public partial class CERep_Schedule
	{
        private readonly XHD.DAL.CERep_Schedule dal = new XHD.DAL.CERep_Schedule();
        public CERep_Schedule()
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
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int sid, int pid, int vid)
        {
            return dal.Exists(sid,pid,vid);
        }

        public int RunProcedureComputerSUM(int sid, int pid, int vid)
        {
            return dal.RunProcedureComputerSUM(sid,pid,vid);
        }

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int  Add(XHD.Model.Crm_CEDetail_Version model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(XHD.Model.Crm_CEDetail_Version model)
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
		public XHD.Model.Crm_CEDetail_Version GetModel(int id)
		{
			
			return dal.GetModel(id);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public XHD.Model.Crm_CEDetail_Version GetModelByCache(int id)
		{
			
			string CacheKey = "Crm_CEDetail_VersionModel-" + id;
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
			return (XHD.Model.Crm_CEDetail_Version)objModel;
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
		public List<XHD.Model.Crm_CEDetail_Version> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<XHD.Model.Crm_CEDetail_Version> DataTableToList(DataTable dt)
		{
			List<XHD.Model.Crm_CEDetail_Version> modelList = new List<XHD.Model.Crm_CEDetail_Version>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				XHD.Model.Crm_CEDetail_Version model;
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
        /// 获得表头数据列表
        /// </summary>
        public DataSet GetListHeadCol(string strWhere)
        {
            return dal.GetListHeadCol(strWhere);
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public int UpdateCrm_CEDetail_Version(string style, int stageid, string strsdetailid, int pid, int vid)
        {
            return dal.UpdateCrm_CEDetail_Version(style, stageid, strsdetailid, pid, vid);
        }


        /// <summary>
        /// 分页获取数据正式明细列表
        /// </summary>
        public DataSet GetListDetail(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetListDetail(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }
        /// <summary>
        /// 分页获取数据正式明细列表
        /// </summary>
        public DataSet GetListCEDetail_VersionDetail(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetListCEDetail_VersionDetail(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }
		#endregion  ExtensionMethod
	}
}

