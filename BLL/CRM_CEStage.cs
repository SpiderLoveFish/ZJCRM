using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
	/// <summary>
	/// CRM_CEStage
	/// </summary>
	public partial class CRM_CEStage
	{
		private readonly xhd.DAL.CRM_CEStage dal=new xhd.DAL.CRM_CEStage();
		public CRM_CEStage()
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
		public bool Exists(int CstomerID,int EmpID,int StageID)
		{
			return dal.Exists(CstomerID,EmpID,StageID);
		}

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add(xhd.Model.CRM_CEStage model)
		{
			return dal.Add(model);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(xhd.Model.CRM_CEStage model)
		{
			return dal.Update(model);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(int CstomerID,int EmpID,int StageID)
		{
			
			return dal.Delete(CstomerID,EmpID,StageID);
		}

		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public xhd.Model.CRM_CEStage GetModel(int CstomerID,int EmpID,int StageID)
		{
			
			return dal.GetModel(CstomerID,EmpID,StageID);
		}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
		public xhd.Model.CRM_CEStage GetModelByCache(int CstomerID,int EmpID,int StageID)
		{
			
			string CacheKey = "CRM_CEStageModel-" + CstomerID+EmpID+StageID;
			object objModel = XHD.Common.DataCache.GetCache(CacheKey);
			if (objModel == null)
			{
				try
				{
					objModel = dal.GetModel(CstomerID,EmpID,StageID);
					if (objModel != null)
					{
						int ModelCache = XHD.Common.ConfigHelper.GetConfigInt("ModelCache");
						XHD.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
					}
				}
				catch{}
			}
			return (xhd.Model.CRM_CEStage)objModel;
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
		public List<xhd.Model.CRM_CEStage> GetModelList(string strWhere)
		{
			DataSet ds = dal.GetList(strWhere);
			return DataTableToList(ds.Tables[0]);
		}
		/// <summary>
		/// 获得数据列表
		/// </summary>
		public List<xhd.Model.CRM_CEStage> DataTableToList(DataTable dt)
		{
			List<xhd.Model.CRM_CEStage> modelList = new List<xhd.Model.CRM_CEStage>();
			int rowsCount = dt.Rows.Count;
			if (rowsCount > 0)
			{
				xhd.Model.CRM_CEStage model;
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

