using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
	/// <summary>
	/// KcGl_Jcb_Cklb_KW
	/// </summary>
	public partial class KcGl_Jcb_Cklb_KW
	{
		private readonly XHD.DAL.KcGl_Jcb_Cklb_KW dal=new XHD.DAL.KcGl_Jcb_Cklb_KW();
		public KcGl_Jcb_Cklb_KW()
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
		public bool Exists(string KWID,int CklbID)
		{
			return dal.Exists(KWID,CklbID);
		}

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(XHD.Model.KcGl_Jcb_Cklb_KW model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(XHD.Model.KcGl_Jcb_Cklb_KW model)
		{
			return dal.Update(model);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(string KWID,int CklbID)
		{
			
			return dal.Delete(KWID,CklbID);
		}

		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public XHD.Model.KcGl_Jcb_Cklb_KW GetModel(string KWID,int CklbID)
		{
			
			return dal.GetModel(KWID,CklbID);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public XHD.Model.KcGl_Jcb_Cklb_KW GetModelByCache(string KWID,int CklbID)
		{
			
			string CacheKey = "KcGl_Jcb_Cklb_KWModel-" + KWID+CklbID;
			object objModel = XHD.Common.DataCache.GetCache(CacheKey);
			if (objModel == null)
			{
				try
				{
					objModel = dal.GetModel(KWID,CklbID);
					if (objModel != null)
					{
						int ModelCache = XHD.Common.ConfigHelper.GetConfigInt("ModelCache");
						XHD.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
					}
				}
				catch{}
			}
			return (XHD.Model.KcGl_Jcb_Cklb_KW)objModel;
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
		public List<XHD.Model.KcGl_Jcb_Cklb_KW> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<XHD.Model.KcGl_Jcb_Cklb_KW> DataTableToList(DataTable dt)
		{
			List<XHD.Model.KcGl_Jcb_Cklb_KW> modelList = new List<XHD.Model.KcGl_Jcb_Cklb_KW>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				XHD.Model.KcGl_Jcb_Cklb_KW model;
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
            return dal.GetList( PageSize,   PageIndex,   strWhere,   filedOrder, out   Total);
        }
        public bool UpdateDel(string KWID, int CklbID, string isdel)
        {
            return dal.UpdateDel(KWID,CklbID,isdel);
        }
		#endregion  ExtensionMethod
	}
}

