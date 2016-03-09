using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
    /// <summary>
    /// CRM_Customer
    /// </summary>
    public partial class budge
    {
        private readonly XHD.DAL.budge dal = new XHD.DAL.budge();
        public budge()
        { }
        #region  Method

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
        public int Add(XHD.Model.CRM_Customer model)
        {
            return dal.Add(model);
        }
        public int AddModel(string bid,string modelid,string modelname, int empid, string remaks)
        { return dal.AddModel(bid, modelid,modelname, empid, remaks); }


        public int AddModelToBudge(string bid, string modelid)
        {
            return dal.AddModelToBudge(bid,modelid);
        }
        public int AddBJlist(int cid, string bid,   string plist)
        {
            return dal.AddBJlist(cid,bid, plist);
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(XHD.Model.CRM_Customer model)
        {
            return dal.Update(model);
        }

        public DataSet Getbudge_modelMain(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.Getbudge_modelMain(PageSize, PageIndex, strWhere, filedOrder,out Total);
        }

        public DataSet GetIsExistModelid(string strwhere)
        {
            return dal.GetIsExistModelid(strwhere);
        }

        public string GetMaxModelId()
        {
            return dal.GetMaxModelId();
        }
        public int updatetotal(string bid,decimal sl)
        {
            return dal.updatetotal(bid,sl);
        }

        public int updateAll(string bid,decimal zk, decimal sl)
        {
            return dal.updateAll(bid, zk, sl);
        }

        
        public DataSet GetTax(string strwhere)
        {
            return dal.GetTax(strwhere);
        }


        #endregion  Method

        public DataSet GetBudge_Rate(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetBudge_Rate(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }


        public DataSet GetBudge_Rate_Ver(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetBudge_Rate_Ver(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }

        public int insertRatelist(string bid, string ratelistid)
        {
            return dal.insertRatelist(bid, ratelistid);
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool DeleteRateVer(int id)
        {

            return dal.DeleteRateVer(id);
        }


        public int copybudge(string copyid, string maxid, string userid)
        {
            return dal.copybudge(copyid,maxid,userid);
        }

    }
}

