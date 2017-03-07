using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
    /// <summary>
    /// hr_employee_accounts
    /// </summary>
    public partial class hr_employee_accounts
    {
        private readonly XHD.DAL.hr_employee_accounts dal = new XHD.DAL.hr_employee_accounts();
        public hr_employee_accounts()
        { }
        #region  Method
        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int ID)
        {
            return dal.Exists(ID);
        }

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(XHD.Model.hr_employee_accounts model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(XHD.Model.hr_employee_accounts model)
        {
            return dal.Update(model);
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int ID)
        {

            return dal.Delete(ID);
        }
        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool DeleteList(string IDlist)
        {
            return dal.DeleteList(IDlist);
        }
        public bool DeleteUID(string uid)
        {
            return dal.DeleteUID(uid);
        }
        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public XHD.Model.hr_employee_accounts GetModel(int ID)
        {

            return dal.GetModel(ID);
        }

        /// <summary>
        /// 得到一个对象实体，从缓存中
        /// </summary>
        public XHD.Model.hr_employee_accounts GetModelByCache(int ID)
        {

            string CacheKey = "hr_employee_accountsModel-" + ID;
            object objModel = XHD.Common.DataCache.GetCache(CacheKey);
            if (objModel == null)
            {
                try
                {
                    objModel = dal.GetModel(ID);
                    if (objModel != null)
                    {
                        int ModelCache = XHD.Common.ConfigHelper.GetConfigInt("ModelCache");
                        XHD.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                    }
                }
                catch { }
            }
            return (XHD.Model.hr_employee_accounts)objModel;
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
        public List<XHD.Model.hr_employee_accounts> GetModelList(string strWhere)
        {
            DataSet ds = dal.GetList(strWhere);
            return DataTableToList(ds.Tables[0]);
        }
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<XHD.Model.hr_employee_accounts> DataTableToList(DataTable dt)
        {
            List<XHD.Model.hr_employee_accounts> modelList = new List<XHD.Model.hr_employee_accounts>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                XHD.Model.hr_employee_accounts model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new XHD.Model.hr_employee_accounts();
                    if (dt.Rows[n]["ID"] != null && dt.Rows[n]["ID"].ToString() != "")
                    {
                        model.ID = int.Parse(dt.Rows[n]["ID"].ToString());
                    }
                    if (dt.Rows[n]["accountType"] != null && dt.Rows[n]["accountType"].ToString() != "")
                    {
                        model.accountType = dt.Rows[n]["accountType"].ToString();
                    }
                    if (dt.Rows[n]["account"] != null && dt.Rows[n]["account"].ToString() != "")
                    {
                        model.account = dt.Rows[n]["account"].ToString();
                    }
                    if (dt.Rows[n]["pwd"] != null && dt.Rows[n]["pwd"].ToString() != "")
                    {
                        model.pwd = dt.Rows[n]["pwd"].ToString();
                    }
                    if (dt.Rows[n]["bz"] != null && dt.Rows[n]["bz"].ToString() != "")
                    {
                        model.bz = dt.Rows[n]["bz"].ToString();
                    }
                    if (dt.Rows[n]["employeeId"] != null && dt.Rows[n]["employeeId"].ToString() != "")
                    {
                        model.employeeId = int.Parse(dt.Rows[n]["employeeId"].ToString());
                    }
                    
                    modelList.Add(model);
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
        public DataSet GetList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetList(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }    

        #endregion  Method
    }
}

