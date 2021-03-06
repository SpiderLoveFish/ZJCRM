using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
    /// <summary>
    /// CRM_product
    /// </summary>
    public partial class CRM_product
    {
        private readonly XHD.DAL.CRM_product dal = new XHD.DAL.CRM_product();
        public CRM_product()
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
        public bool Exists(int product_id)
        {
            return dal.Exists(product_id);
        }

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(XHD.Model.CRM_product model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(XHD.Model.CRM_product model)
        {
            return dal.Update(model);
        }

        /// <summary>
        /// 预删除
        /// </summary>
        /// <param name="id"></param>
        /// <param name="isDelete"></param>
        /// <param name="time"></param>
        /// <returns></returns>
        public bool AdvanceDelete(int id, int isDelete, string time)
        {
            return dal.AdvanceDelete(id, isDelete, time);
        }
        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int product_id)
        {

            return dal.Delete(product_id);
        }
        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool DeleteList(string product_idlist)
        {
            return dal.DeleteList(product_idlist);
        }

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public XHD.Model.CRM_product GetModel(int product_id)
        {

            return dal.GetModel(product_id);
        }

        /// <summary>
        /// 得到一个对象实体，从缓存中
        /// </summary>
        public XHD.Model.CRM_product GetModelByCache(int product_id)
        {

            string CacheKey = "CRM_productModel-" + product_id;
            object objModel = XHD.Common.DataCache.GetCache(CacheKey);
            if (objModel == null)
            {
                try
                {
                    objModel = dal.GetModel(product_id);
                    if (objModel != null)
                    {
                        int ModelCache = XHD.Common.ConfigHelper.GetConfigInt("ModelCache");
                        XHD.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                    }
                }
                catch { }
            }
            return (XHD.Model.CRM_product)objModel;
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
        public List<XHD.Model.CRM_product> GetModelList(string strWhere)
        {
            DataSet ds = dal.GetList(strWhere);
            return DataTableToList(ds.Tables[0]);
        }
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<XHD.Model.CRM_product> DataTableToList(DataTable dt)
        {
            List<XHD.Model.CRM_product> modelList = new List<XHD.Model.CRM_product>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                XHD.Model.CRM_product model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new XHD.Model.CRM_product();
                    if (dt.Rows[n]["product_id"] != null && dt.Rows[n]["product_id"].ToString() != "")
                    {
                        model.product_id = int.Parse(dt.Rows[n]["product_id"].ToString());
                    }
                    if (dt.Rows[n]["product_name"] != null && dt.Rows[n]["product_name"].ToString() != "")
                    {
                        model.product_name = dt.Rows[n]["product_name"].ToString();
                    }
                    if (dt.Rows[n]["category_id"] != null && dt.Rows[n]["category_id"].ToString() != "")
                    {
                        model.category_id = int.Parse(dt.Rows[n]["category_id"].ToString());
                    }
                    if (dt.Rows[n]["category_name"] != null && dt.Rows[n]["category_name"].ToString() != "")
                    {
                        model.category_name = dt.Rows[n]["category_name"].ToString();
                    }
                    if (dt.Rows[n]["specifications"] != null && dt.Rows[n]["specifications"].ToString() != "")
                    {
                        model.specifications = dt.Rows[n]["specifications"].ToString();
                    }
                    if (dt.Rows[n]["status"] != null && dt.Rows[n]["status"].ToString() != "")
                    {
                        model.status = dt.Rows[n]["status"].ToString();
                    }
                    if (dt.Rows[n]["unit"] != null && dt.Rows[n]["unit"].ToString() != "")
                    {
                        model.unit = dt.Rows[n]["unit"].ToString();
                    }
                    if (dt.Rows[n]["remarks"] != null && dt.Rows[n]["remarks"].ToString() != "")
                    {
                        model.remarks = dt.Rows[n]["remarks"].ToString();
                    }
                    if (dt.Rows[n]["url"] != null && dt.Rows[n]["url"].ToString() != "")
                    {
                        model.url = dt.Rows[n]["url"].ToString();
                    }
                    if (dt.Rows[n]["zc_price"] != null && dt.Rows[n]["zc_price"].ToString() != "")
                    {
                        model.zc_price = decimal.Parse(dt.Rows[n]["zc_price"].ToString());
                    }
                    if (dt.Rows[n]["fc_price"] != null && dt.Rows[n]["fc_price"].ToString() != "")
                    {
                        model.fc_price = decimal.Parse(dt.Rows[n]["fc_price"].ToString());
                    }
                    if (dt.Rows[n]["rg_price"] != null && dt.Rows[n]["rg_price"].ToString() != "")
                    {
                        model.rg_price = decimal.Parse(dt.Rows[n]["rg_price"].ToString());
                    }
                    if (dt.Rows[n]["price"] != null && dt.Rows[n]["price"].ToString() != "")
                    {
                        model.price = decimal.Parse(dt.Rows[n]["price"].ToString());
                    }
                    if (dt.Rows[n]["isDelete"] != null && dt.Rows[n]["isDelete"].ToString() != "")
                    {
                        model.isDelete = int.Parse(dt.Rows[n]["isDelete"].ToString());
                    }
                    if (dt.Rows[n]["Delete_time"] != null && dt.Rows[n]["Delete_time"].ToString() != "")
                    {
                        model.Delete_time = DateTime.Parse(dt.Rows[n]["Delete_time"].ToString());
                    }
                    if (dt.Rows[n]["t_content"] != null && dt.Rows[n]["t_content"].ToString() != "")
                    {
                        model.t_content = dt.Rows[n]["t_content"].ToString();
                    }
                    if (dt.Rows[n]["InternalPrice"] != null && dt.Rows[n]["InternalPrice"].ToString() != "")
                    {
                        model.nbj = decimal.Parse(dt.Rows[n]["InternalPrice"].ToString());
                    }
                    if (dt.Rows[n]["Suppliers"] != null && dt.Rows[n]["Suppliers"].ToString() != "")
                    {
                        model.gys = dt.Rows[n]["Suppliers"].ToString();
                    } if (dt.Rows[n]["ProModel"] != null && dt.Rows[n]["ProModel"].ToString() != "")
                    {
                        model.xh = dt.Rows[n]["ProModel"].ToString();
                    } if (dt.Rows[n]["ProSeries"] != null && dt.Rows[n]["ProSeries"].ToString() != "")
                    {
                        model.xl = dt.Rows[n]["ProSeries"].ToString();
                    } if (dt.Rows[n]["Themes"] != null && dt.Rows[n]["Themes"].ToString() != "")
                    {
                        model.zt = dt.Rows[n]["Themes"].ToString();
                    }
                    if (dt.Rows[n]["clzt"] != null && dt.Rows[n]["clzt"].ToString() != "")
                    {
                        model.clzt = dt.Rows[n]["clzt"].ToString();
                    }
                    if (dt.Rows[n]["jbx"] != null && dt.Rows[n]["jbx"].ToString() != "")
                    {
                        model.jbx = int.Parse(dt.Rows[n]["jbx"].ToString());
                    }
                    if (dt.Rows[n]["fbj"] != null && dt.Rows[n]["fbj"].ToString() != "")
                    {
                        model.fbj = decimal.Parse(dt.Rows[n]["fbj"].ToString());
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
        public DataSet GetListgys(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetListgys(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }

         /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet Get_code(int catid)
        {
            return dal.Get_code(catid);
        }
        public DataSet Get_categorycode(int catid)
        {
            return dal.Get_categorycode(catid);
        }
            public DataSet GetList_gys(string strWhere)
        {
            return dal.GetList_gys(strWhere);
        }

        #endregion  Method
    }
}

