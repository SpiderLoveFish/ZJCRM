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
        private readonly XHD.DAL.CRM_CEStage dal = new XHD.DAL.CRM_CEStage();
        public CRM_CEStage()
        { }
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
        public int Add(XHD.Model.CRM_CEStage model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(XHD.Model.CRM_CEStage model)
        {
            return dal.Update(model);
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(XHD.Model.CRM_CEStage model,int id)
        {
            return dal.Update(model,id);
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
        public bool DeleteList(string idlist)
        {
            return dal.DeleteList(idlist);
        }

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public XHD.Model.CRM_CEStage GetModel(int id)
        {

            return dal.GetModel(id);
        }

        /// <summary>
        /// 得到一个对象实体，从缓存中
        /// </summary>
        public XHD.Model.CRM_CEStage GetModelByCache(int id)
        {

            string CacheKey = "CRM_CEStageModel-" + id;
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
                catch { }
            }
            return (XHD.Model.CRM_CEStage)objModel;
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
        public DataSet GetList(int Top, string strWhere, string filedOrder)
        {
            return dal.GetList(Top, strWhere, filedOrder);
        }
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<XHD.Model.CRM_CEStage> GetModelList(string strWhere)
        {
            DataSet ds = dal.GetList(strWhere);
            return DataTableToList(ds.Tables[0]);
        }
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<XHD.Model.CRM_CEStage> DataTableToList(DataTable dt)
        {
            List<XHD.Model.CRM_CEStage> modelList = new List<XHD.Model.CRM_CEStage>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                XHD.Model.CRM_CEStage model;
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
            return dal.GetListByPage(strWhere, orderby, startIndex, endIndex);
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
        public bool ExistsCestage(int id)
        {
            return dal.ExistsCestage(id);
        }
        public int AddCEstage(string id)
        {
            return dal.AddCEstage(id);
        }
        public bool UpdateStatus(string status, string id,DateTime jgrq)
        {
            return dal.UpdateStatus(status,id,jgrq);
        }

        /// <summary>
        /// 分页获取数据正式明细列表
        /// </summary>
        public DataSet GetListDetail(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetListDetail(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }

        /// <summary>
        /// 分页获取数据客户列表
        /// </summary>
        public DataSet GetListCustomer(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetListCustomer(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }

        //选择工地
        public DataSet GetxzListCustomer(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetxzListCustomer(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }
        //目标工地
        public DataSet GetmbgdListCustomer(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetmbgdListCustomer(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }

        public DataSet GetListCountScorce(string wherestr, out string Total)
        {
            return dal.GetListCountScorce(wherestr,out  Total);
         }

        public int AddIPCam(string cid, string szDevIP, string acc, string pwd, string str, string ipstyle, string comp)
        {
            return dal.AddIPCam(cid,szDevIP,acc,pwd,str,ipstyle,comp);
        }
        public bool UpdateIPCam(string cid, string szDevIP, string acc, string pwd, string str, string ipstyle, string comp)
        {
            return dal.UpdateIPCam(cid, szDevIP, acc, pwd, str, ipstyle, comp);
        }
        #endregion  ExtensionMethod
    }
}

