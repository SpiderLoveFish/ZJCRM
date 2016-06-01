using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
	/// <summary>
	/// Crm_CEDetail
	/// </summary>
	public partial class CE_Para
	{
        private readonly XHD.DAL.CE_Para dal = new XHD.DAL.CE_Para();
        public CE_Para()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
			return dal.GetMaxId();
		}

        public int GetMaxVerId(string sid, string pid, string style)
        {
            return dal.GetMaxVerId(sid, pid, style);
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
        public bool ExistsChecked(int StageID, int pid, int verid)
        {
            return dal.ExistsChecked(StageID, pid, verid);
        }

		/// <summary>
		/// 增加一条数据
		/// </summary>
        public int Add(string name, int px, string color, string remarks)
		{
			return dal.Add(name,px,color,remarks);
		}

		/// <summary>
		/// 更新一条数据
		/// </summary>
        //public bool Update(XHD.Model.Crm_CEDetail model)
        //{
        //    return dal.Update(model);
        //}


        public bool Update(int JDID, string name, int px, string color, string remarks)
		{
			return dal.Update(JDID,name,px,color,remarks);
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
        public bool Delete(int sid,int pid,int vid)
        {

            return dal.Delete(sid,pid,vid);
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
        //public XHD.Model.Crm_CEDetail GetModel(int id)
        //{
			
        //    return dal.GetModel(id);
        //}

		/// <summary>
		/// 得到一个对象实体，从缓存中
		/// </summary>
        //public XHD.Model.Crm_CEDetail GetModelByCache(int id)
        //{
			
        //    string CacheKey = "Crm_CEDetailModel-" + id;
        //    object objModel = XHD.Common.DataCache.GetCache(CacheKey);
        //    if (objModel == null)
        //    {
        //        try
        //        {
        //            objModel = dal.GetModel(id);
        //            if (objModel != null)
        //            {
        //                int ModelCache = XHD.Common.ConfigHelper.GetConfigInt("ModelCache");
        //                XHD.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
        //            }
        //        }
        //        catch{}
        //    }
        //    return (XHD.Model.Crm_CEDetail)objModel;
        //}

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
        //public List<XHD.Model.Crm_CEDetail> GetModelList(string strWhere)
        //{
        //    DataSet ds = dal.GetList(strWhere);
        //    return DataTableToList(ds.Tables[0]);
        //}
		/// <summary>
		/// 获得数据列表
		/// </summary>
        //public List<XHD.Model.Crm_CEDetail> DataTableToList(DataTable dt)
        //{
        //    List<XHD.Model.Crm_CEDetail> modelList = new List<XHD.Model.Crm_CEDetail>();
        //    int rowsCount = dt.Rows.Count;
        //    if (rowsCount > 0)
        //    {
        //        XHD.Model.Crm_CEDetail model;
        //        for (int n = 0; n < rowsCount; n++)
        //        {
        //            model = dal.DataRowToModel(dt.Rows[n]);
        //            if (model != null)
        //            {
        //                modelList.Add(model);
        //            }
        //        }
        //    }
        //    return modelList;
        //}

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
        public DataSet GetListDetail(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetListDetail(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }
        //public DataSet GetListCrm_CEDetail(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        //{
        //    return dal.GetListCrm_CEDetail(PageSize, PageIndex, strWhere, filedOrder, out Total);
        //}
        

        public DataSet GetListStage(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetListStage(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }


        public DataSet GetSingleSignOnList(string where)
        {
            return dal.GetSingleSignOnList(where);
        }

        public bool Updatekjl_api(string des, int cid, string fpid,string DyGraphicsName, string imgtype, string simg, string img, string pano)
        {
            return dal.Updatekjl_api(des, cid, fpid,DyGraphicsName, imgtype, simg, img, pano);

        }
        public bool Addkjl_api(string des, int cid, string fpid,string DyGraphicsName, string imgtype, string simg, string img, string pano)
        {
            return dal.Addkjl_api(des, cid, fpid,DyGraphicsName, imgtype, simg, img, pano);

        }
        public bool deletekjl_api(string des, int cid, string fpid)
        {
            return dal.deletekjl_api(des,cid,fpid);
        }
        #endregion  ExtensionMethod
	}
}

