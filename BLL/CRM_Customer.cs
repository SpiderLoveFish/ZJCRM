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
    public partial class CRM_Customer
    {
        private readonly XHD.DAL.CRM_Customer dal = new XHD.DAL.CRM_Customer();
        public CRM_Customer()
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

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(XHD.Model.CRM_Customer model)
        {
            return dal.Update(model);
        }

        /// <summary>
        /// 高级修改
        /// </summary>
        public bool Update_GJXG(int id, string tel, DateTime Create_date)
        {
            return dal.Update_GJXG(id,tel,Create_date);
        }

        /// <summary>
        /// 批量转客源
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public bool Update_batch(XHD.Model.CRM_Customer model, string strWhere)
        {
            return dal.Update_batch(model, strWhere);
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
        /// 提交签单一条数据
        /// </summary>
        public bool subok(int id)
        {

            return dal.subok(id);
        }

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public XHD.Model.CRM_Customer GetModel(int id)
        {

            return dal.GetModel(id);
        }

        /// <summary>
        /// 得到一个对象实体，从缓存中
        /// </summary>
        public XHD.Model.CRM_Customer GetModelByCache(int id)
        {

            string CacheKey = "CRM_CustomerModel-" + id;
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
            return (XHD.Model.CRM_Customer)objModel;
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetPageList(int pi, int ps,string where )
        {
            return dal.GetPageList(pi, ps,where);
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
        public List<XHD.Model.CRM_Customer> GetModelList(string strWhere)
        {
            DataSet ds = dal.GetList(strWhere);
            return DataTableToList(ds.Tables[0]);
        }
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<XHD.Model.CRM_Customer> DataTableToList(DataTable dt)
        {
            List<XHD.Model.CRM_Customer> modelList = new List<XHD.Model.CRM_Customer>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                XHD.Model.CRM_Customer model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new XHD.Model.CRM_Customer();
                    if (dt.Rows[n]["id"] != null && dt.Rows[n]["id"].ToString() != "")
                    {
                        model.id = int.Parse(dt.Rows[n]["id"].ToString());
                    }
                    if (dt.Rows[n]["Serialnumber"] != null && dt.Rows[n]["Serialnumber"].ToString() != "")
                    {
                        model.Serialnumber = dt.Rows[n]["Serialnumber"].ToString();
                    }
                    if (dt.Rows[n]["Customer"] != null && dt.Rows[n]["Customer"].ToString() != "")
                    {
                        model.Customer = dt.Rows[n]["Customer"].ToString();
                    }
                    if (dt.Rows[n]["address"] != null && dt.Rows[n]["address"].ToString() != "")
                    {
                        model.address = dt.Rows[n]["address"].ToString();
                    }
                    if (dt.Rows[n]["tel"] != null && dt.Rows[n]["tel"].ToString() != "")
                    {
                        model.tel = dt.Rows[n]["tel"].ToString();
                    }
                    if (dt.Rows[n]["fax"] != null && dt.Rows[n]["fax"].ToString() != "")
                    {
                        model.fax = dt.Rows[n]["fax"].ToString();
                    }
                    if (dt.Rows[n]["site"] != null && dt.Rows[n]["site"].ToString() != "")
                    {
                        model.site = dt.Rows[n]["site"].ToString();
                    }
                    if (dt.Rows[n]["industry"] != null && dt.Rows[n]["industry"].ToString() != "")
                    {
                        model.industry = dt.Rows[n]["industry"].ToString();
                    }
                    if (dt.Rows[n]["Provinces_id"] != null && dt.Rows[n]["Provinces_id"].ToString() != "")
                    {
                        model.Provinces_id = int.Parse(dt.Rows[n]["Provinces_id"].ToString());
                    }
                    if (dt.Rows[n]["Provinces"] != null && dt.Rows[n]["Provinces"].ToString() != "")
                    {
                        model.Provinces = dt.Rows[n]["Provinces"].ToString();
                    }
                    if (dt.Rows[n]["City_id"] != null && dt.Rows[n]["City_id"].ToString() != "")
                    {
                        model.City_id = int.Parse(dt.Rows[n]["City_id"].ToString());
                    }
                    if (dt.Rows[n]["City"] != null && dt.Rows[n]["City"].ToString() != "")
                    {
                        model.City = dt.Rows[n]["City"].ToString();
                    }
                    if (dt.Rows[n]["Community_id"] != null && dt.Rows[n]["Community_id"].ToString() != "")
                    {
                        model.City_id = int.Parse(dt.Rows[n]["Community_id"].ToString());
                    }
                    if (dt.Rows[n]["Community"] != null && dt.Rows[n]["Community"].ToString() != "")
                    {
                        model.City = dt.Rows[n]["Community"].ToString();
                    }
                    if (dt.Rows[n]["CustomerType_id"] != null && dt.Rows[n]["CustomerType_id"].ToString() != "")
                    {
                        model.CustomerType_id = int.Parse(dt.Rows[n]["CustomerType_id"].ToString());
                    }
                    if (dt.Rows[n]["CustomerType"] != null && dt.Rows[n]["CustomerType"].ToString() != "")
                    {
                        model.CustomerType = dt.Rows[n]["CustomerType"].ToString();
                    }
                    if (dt.Rows[n]["CustomerLevel_id"] != null && dt.Rows[n]["CustomerLevel_id"].ToString() != "")
                    {
                        model.CustomerLevel_id = int.Parse(dt.Rows[n]["CustomerLevel_id"].ToString());
                    }
                    if (dt.Rows[n]["CustomerLevel"] != null && dt.Rows[n]["CustomerLevel"].ToString() != "")
                    {
                        model.CustomerLevel = dt.Rows[n]["CustomerLevel"].ToString();
                    }
                    if (dt.Rows[n]["CustomerSource_id"] != null && dt.Rows[n]["CustomerSource_id"].ToString() != "")
                    {
                        model.CustomerSource_id = int.Parse(dt.Rows[n]["CustomerSource_id"].ToString());
                    }
                    if (dt.Rows[n]["CustomerSource"] != null && dt.Rows[n]["CustomerSource"].ToString() != "")
                    {
                        model.CustomerSource = dt.Rows[n]["CustomerSource"].ToString();
                    }
                    if (dt.Rows[n]["DesCripe"] != null && dt.Rows[n]["DesCripe"].ToString() != "")
                    {
                        model.DesCripe = dt.Rows[n]["DesCripe"].ToString();
                    }
                    if (dt.Rows[n]["Remarks"] != null && dt.Rows[n]["Remarks"].ToString() != "")
                    {
                        model.Remarks = dt.Rows[n]["Remarks"].ToString();
                    }
                    if (dt.Rows[n]["Department_id"] != null && dt.Rows[n]["Department_id"].ToString() != "")
                    {
                        model.Department_id = int.Parse(dt.Rows[n]["Department_id"].ToString());
                    }
                    if (dt.Rows[n]["Department"] != null && dt.Rows[n]["Department"].ToString() != "")
                    {
                        model.Department = dt.Rows[n]["Department"].ToString();
                    }
                    if (dt.Rows[n]["Employee_id"] != null && dt.Rows[n]["Employee_id"].ToString() != "")
                    {
                        model.Employee_id = int.Parse(dt.Rows[n]["Employee_id"].ToString());
                    }
                    if (dt.Rows[n]["Employee"] != null && dt.Rows[n]["Employee"].ToString() != "")
                    {
                        model.Employee = dt.Rows[n]["Employee"].ToString();
                    }
                    if (dt.Rows[n]["privatecustomer"] != null && dt.Rows[n]["privatecustomer"].ToString() != "")
                    {
                        model.privatecustomer = dt.Rows[n]["privatecustomer"].ToString();
                    }
                    if (dt.Rows[n]["lastfollow"] != null && dt.Rows[n]["lastfollow"].ToString() != "")
                    {
                        model.lastfollow = DateTime.Parse(dt.Rows[n]["lastfollow"].ToString());
                    }
                    if (dt.Rows[n]["Create_id"] != null && dt.Rows[n]["Create_id"].ToString() != "")
                    {
                        model.Create_id = int.Parse(dt.Rows[n]["Create_id"].ToString());
                    }
                    if (dt.Rows[n]["Create_name"] != null && dt.Rows[n]["Create_name"].ToString() != "")
                    {
                        model.Create_name = dt.Rows[n]["Create_name"].ToString();
                    }
                    if (dt.Rows[n]["Create_date"] != null && dt.Rows[n]["Create_date"].ToString() != "")
                    {
                        model.Create_date = DateTime.Parse(dt.Rows[n]["Create_date"].ToString());
                    }
                    if (dt.Rows[n]["isDelete"] != null && dt.Rows[n]["isDelete"].ToString() != "")
                    {
                        model.isDelete = int.Parse(dt.Rows[n]["isDelete"].ToString());
                    }
                    if (dt.Rows[n]["Delete_time"] != null && dt.Rows[n]["Delete_time"].ToString() != "")
                    {
                        model.Delete_time = DateTime.Parse(dt.Rows[n]["Delete_time"].ToString());
                    }
                    if (dt.Rows[n]["WXZT_ID"] != null && dt.Rows[n]["WXZT_ID"].ToString() != "")
                    {
                        model.WXZT_ID = int.Parse(dt.Rows[n]["WXZT_ID"].ToString());
                    }
                    if (dt.Rows[n]["WXZT_NAME"] != null && dt.Rows[n]["WXZT_NAME"].ToString() != "")
                    {
                        model.WXZT_NAME = dt.Rows[n]["WXZT_NAME"].ToString();
                    }
                    if (dt.Rows[n]["QQ"] != null && dt.Rows[n]["QQ"].ToString() != "")
                    {
                        model.WXZT_NAME = dt.Rows[n]["QQ"].ToString();
                    }
                    if (dt.Rows[n]["JKDZ"] != null && dt.Rows[n]["JKDZ"].ToString() != "")
                    {
                        model.JKDZ = dt.Rows[n]["JKDZ"].ToString();
                    }
                    if (dt.Rows[n]["hxt"] != null && dt.Rows[n]["hxt"].ToString() != "")
                    {
                        model.hxt = dt.Rows[n]["hxt"].ToString();
                    }
                    if (dt.Rows[n]["jgqjt"] != null && dt.Rows[n]["jgqjt"].ToString() != "")
                    {
                        model.jgqjt = dt.Rows[n]["jgqjt"].ToString();
                    }
                    if (dt.Rows[n]["birthday_lunar"] != null && dt.Rows[n]["birthday_lunar"].ToString() != "")
                    {
                        model.birthday_lunar = dt.Rows[n]["birthday_lunar"].ToString();
                    }
                    if (dt.Rows[n]["birthday"] != null && dt.Rows[n]["birthday"].ToString() != "")
                    {
                        model.birthday = dt.Rows[n]["birthday"].ToString();
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

        /// <summary>
        /// 更新最后跟进
        /// </summary>
        public bool UpdateLastFollow(string id)
        {
            return dal.UpdateLastFollow(id);
        }
        public DataSet Reports_year(string items, int year, string where)
        {
            return dal.Reports_year(items, year, where);
        }

        /// <summary>
        /// 同比环比【客户新增】
        /// </summary>
        /// <param name="dt1"></param>
        /// <param name="dt2"></param>
        /// <param name="project_id"></param>
        /// <returns></returns>
        public DataSet Compared(string year1, string month1, string year2, string month2)
        {
            return dal.Compared(year1, month1, year2, month2);
        }

        public DataSet Compared_type(string year1, string month1, string year2, string month2)
        {
            return dal.Compared_type(year1, month1, year2, month2);
        }

        public DataSet Compared_level(string year1, string month1, string year2, string month2)
        {
            return dal.Compared_level(year1, month1, year2, month2);
        }

        public DataSet Compared_source(string year1, string month1, string year2, string month2)
        {
            return dal.Compared_source(year1, month1, year2, month2);
        }

        public DataSet Compared_empcusadd(string year1, string month1, string year2, string month2 , string idlist)//, string idlist)
        {
            return dal.Compared_empcusadd(year1, month1, year2, month2, idlist);//, idlist);
        }

        /// <summary>
        /// 客户新增统计
        /// </summary>
        /// <param name="year"></param>
        /// <param name="idlist"></param>
        /// <returns></returns>
        public DataSet report_empcus(int year, string idlist)
        {
            return dal.report_empcus(year, idlist);
        }

        /// <summary>
        /// ToExcel
        /// </summary>
        public DataSet ToExcel(string strWhere)
        {
            return dal.ToExcel(strWhere);
        }
        /// <summary>
        /// 导入
        /// </summary>
        public bool ToImport(int emp_id,string emp_name,DateTime create_time,string type)
        {
            return dal.ToImport(emp_id, emp_name, create_time, type);
        }

        /// <summary>
        /// 统计漏斗
        /// </summary>
        public DataSet Funnel(string strWhere, string year)
        {
            return dal.Funnel(strWhere, year);
        }

        public DataSet GetMapList(string strWhere)
        {
            return dal.GetMapList(strWhere);
        }

        public DataSet GetBMapList(string strWhere)
        {
            return dal.GetBMapList(strWhere);
        }
        public DataSet GetGYSMapList(string strWhere)
        {
            return dal.GetGYSMapList(strWhere);
        }


        public DataSet GetListdy(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetListdy(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }
        public DataSet GetListdy(string strWhere)
        {
            return dal.GetListdy(strWhere);
        }
        public DataSet GetDSRep(string xtype, string ytype,string strWhere)
        {
            return dal.GetDSRep(xtype, ytype,strWhere);
        }
            public bool Deletedy(int id, int cid)
        {
            return dal.Deletedy(id,cid);
        }
        public bool Updatedy(int id, int cid, string dyname, string dyurl, string remarks)
        {
            return dal.Updatedy(id, cid, dyname, dyurl, remarks);
        }
        public int Adddy(int cid, string dyname, string dyurl, string remarks)
        {
            return dal.Adddy(cid, dyname, dyurl, remarks);
        }
        #endregion  Method

        public int AddFavorite(string cid, string uid)
        {
            return dal.AddFavorite(cid,uid);
        }
        public bool DeleteFavorite(string cid, string uid)
        {
            return dal.DeleteFavorite(cid, uid);
        }
        public bool UpdateIsDelete(int id, int iselete)
        {
            return dal.UpdateIsDelete(id, iselete);
        }
    }
}

