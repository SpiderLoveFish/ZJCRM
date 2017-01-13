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


        public DataSet GetSingleSignOnList(string where,string host)
        {
            return dal.GetSingleSignOnList(where,host);
        }

        public bool Updatekjl_api(string des, int cid, string fpid,string DyGraphicsName, string imgtype, string simg, string img, string pano)
        {
            return dal.Updatekjl_api(des, cid, fpid,DyGraphicsName, imgtype, simg, img, pano);

        }
        public bool Addkjl_api(string des, int cid, string fpid, string DyGraphicsName, string imgtype, string simg, string img, string pano, string DP, int DPID, string remarks)
        {
            return dal.Addkjl_api(des, cid, fpid, DyGraphicsName, imgtype, simg, img, pano, DP, DPID, remarks);

        }
        public bool deletekjl_api(string des, int cid, string fpid)
        {
            return dal.deletekjl_api(des,cid,fpid);
        }

        public bool Updatekjl_api_name(string fpid, string DyGraphicsName)
        {
            return dal.Updatekjl_api_name(fpid,DyGraphicsName);
        }

        public DataSet Getkjl_api_list(string strWhere,string uid)
        {
            return dal.Getkjl_api_list(strWhere, uid);
        }

        public DataSet GetListkjl_api(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetListkjl_api(PageSize,PageIndex,strWhere,filedOrder,out Total);
        }

        public bool Addkjl_list_text(string uid, int style, string userid, string text, string remarks)
        {
            return dal.Addkjl_list_text(uid,style,userid,text,remarks);
        }

        public DataSet GetPrint_list(string strWhere)
        {
            return dal.GetPrint_list(strWhere);
        }

        public DataSet GetAPI_KEY(string strWhere)
        {
            return dal.GetAPI_KEY(strWhere);
        }
        public bool Addkjl_account_list(string uid, int style, string userid, string text, string remarks)
        {
            return dal.Addkjl_account_list(uid, style, userid, text, remarks);
        }
        public bool Addkjl_api_list(string uid, string tel,string fid, string desid, int style, string userid, string text, string remarks)
        {
            return dal.Addkjl_api_list(uid,tel,fid,desid, style, userid, text, remarks);
        }

        public bool Addkjl_api_roomlist(string uid, string tel, string fid, string desid, string userid, string text, string remarks)
        {

            return dal.Addkjl_api_roomlist(uid, tel,fid, desid,  userid, text, remarks);
        }

        public DataSet GetDS_kjl_account_list(string strWhere)
        {
            return dal.GetDS_kjl_account_list(strWhere);
        }

         public DataSet GetDS_kjl_api_list(string strWhere)
        {
            return dal.GetDS_kjl_api_list(strWhere);
        }
        #endregion  ExtensionMethod
    }
}

