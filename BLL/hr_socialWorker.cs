using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
    /// <summary>
    /// hr_socialWorker
    /// </summary>
    public partial class hr_socialWorker
    {
        private readonly XHD.DAL.hr_socialWorker dal = new XHD.DAL.hr_socialWorker();
        public hr_socialWorker()
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
        public int Add(XHD.Model.hr_socialWorker model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(XHD.Model.hr_socialWorker model)
        {
            return dal.Update(model);
        }

        public bool UpdateKJL(XHD.Model.hr_socialWorker model)
        {
            return dal.UpdateKJL(model);
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

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public XHD.Model.hr_socialWorker GetModel(int ID)
        {

            return dal.GetModel(ID);
        }

        /// <summary>
        /// 得到一个对象实体，从缓存中
        /// </summary>
        public XHD.Model.hr_socialWorker GetModelByCache(int ID)
        {

            string CacheKey = "hr_socialWorkerModel-" + ID;
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
            return (XHD.Model.hr_socialWorker)objModel;
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
        public List<XHD.Model.hr_socialWorker> GetModelList(string strWhere)
        {
            DataSet ds = dal.GetList(strWhere);
            return DataTableToList(ds.Tables[0]);
        }
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<XHD.Model.hr_socialWorker> DataTableToList(DataTable dt)
        {
            List<XHD.Model.hr_socialWorker> modelList = new List<XHD.Model.hr_socialWorker>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                XHD.Model.hr_socialWorker model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new XHD.Model.hr_socialWorker();
                    if (dt.Rows[n]["ID"] != null && dt.Rows[n]["ID"].ToString() != "")
                    {
                        model.ID = int.Parse(dt.Rows[n]["ID"].ToString());
                    }
                    if (dt.Rows[n]["uid"] != null && dt.Rows[n]["uid"].ToString() != "")
                    {
                        model.uid = dt.Rows[n]["uid"].ToString();
                    }
                    if (dt.Rows[n]["pwd"] != null && dt.Rows[n]["pwd"].ToString() != "")
                    {
                        model.pwd = dt.Rows[n]["pwd"].ToString();
                    }
                    if (dt.Rows[n]["name"] != null && dt.Rows[n]["name"].ToString() != "")
                    {
                        model.name = dt.Rows[n]["name"].ToString();
                    }
                    if (dt.Rows[n]["idcard"] != null && dt.Rows[n]["idcard"].ToString() != "")
                    {
                        model.idcard = dt.Rows[n]["idcard"].ToString();
                    }
                    if (dt.Rows[n]["birthday"] != null && dt.Rows[n]["birthday"].ToString() != "")
                    {
                        model.birthday = dt.Rows[n]["birthday"].ToString();
                    }
                    if (dt.Rows[n]["rqlx"] != null && dt.Rows[n]["rqlx"].ToString() != "")
                    {
                        model.rqlx = dt.Rows[n]["rqlx"].ToString();
                    }
                    if (dt.Rows[n]["d_id"] != null && dt.Rows[n]["d_id"].ToString() != "")
                    {
                        model.d_id = int.Parse(dt.Rows[n]["d_id"].ToString());
                    }
                    if (dt.Rows[n]["dname"] != null && dt.Rows[n]["dname"].ToString() != "")
                    {
                        model.dname = dt.Rows[n]["dname"].ToString();
                    }
                    if (dt.Rows[n]["postid"] != null && dt.Rows[n]["postid"].ToString() != "")
                    {
                        model.postid = int.Parse(dt.Rows[n]["postid"].ToString());
                    }
                    if (dt.Rows[n]["post"] != null && dt.Rows[n]["post"].ToString() != "")
                    {
                        model.post = dt.Rows[n]["post"].ToString();
                    }
                    if (dt.Rows[n]["email"] != null && dt.Rows[n]["email"].ToString() != "")
                    {
                        model.email = dt.Rows[n]["email"].ToString();
                    }
                    if (dt.Rows[n]["sex"] != null && dt.Rows[n]["sex"].ToString() != "")
                    {
                        model.sex = dt.Rows[n]["sex"].ToString();
                    }
                    if (dt.Rows[n]["tel"] != null && dt.Rows[n]["tel"].ToString() != "")
                    {
                        model.tel = dt.Rows[n]["tel"].ToString();
                    }
                    if (dt.Rows[n]["status"] != null && dt.Rows[n]["status"].ToString() != "")
                    {
                        model.status = dt.Rows[n]["status"].ToString();
                    }
                    if (dt.Rows[n]["zhiwuid"] != null && dt.Rows[n]["zhiwuid"].ToString() != "")
                    {
                        model.zhiwuid = int.Parse(dt.Rows[n]["zhiwuid"].ToString());
                    }
                    if (dt.Rows[n]["zhiwu"] != null && dt.Rows[n]["zhiwu"].ToString() != "")
                    {
                        model.zhiwu = dt.Rows[n]["zhiwu"].ToString();
                    }
                    if (dt.Rows[n]["sort"] != null && dt.Rows[n]["sort"].ToString() != "")
                    {
                        model.sort = int.Parse(dt.Rows[n]["sort"].ToString());
                    }
                    if (dt.Rows[n]["EntryDate"] != null && dt.Rows[n]["EntryDate"].ToString() != "")
                    {
                        model.EntryDate = dt.Rows[n]["EntryDate"].ToString();
                    }
                    if (dt.Rows[n]["address"] != null && dt.Rows[n]["address"].ToString() != "")
                    {
                        model.address = dt.Rows[n]["address"].ToString();
                    }
                    if (dt.Rows[n]["remarks"] != null && dt.Rows[n]["remarks"].ToString() != "")
                    {
                        model.remarks = dt.Rows[n]["remarks"].ToString();
                    }
                    if (dt.Rows[n]["education"] != null && dt.Rows[n]["education"].ToString() != "")
                    {
                        model.education = dt.Rows[n]["education"].ToString();
                    }
                    if (dt.Rows[n]["level"] != null && dt.Rows[n]["level"].ToString() != "")
                    {
                        model.level = dt.Rows[n]["level"].ToString();
                    }
                    if (dt.Rows[n]["professional"] != null && dt.Rows[n]["professional"].ToString() != "")
                    {
                        model.professional = dt.Rows[n]["professional"].ToString();
                    }
                    if (dt.Rows[n]["schools"] != null && dt.Rows[n]["schools"].ToString() != "")
                    {
                        model.schools = dt.Rows[n]["schools"].ToString();
                    }
                    if (dt.Rows[n]["title"] != null && dt.Rows[n]["title"].ToString() != "")
                    {
                        model.title = dt.Rows[n]["title"].ToString();
                    }
                    if (dt.Rows[n]["isDelete"] != null && dt.Rows[n]["isDelete"].ToString() != "")
                    {
                        model.isDelete = int.Parse(dt.Rows[n]["isDelete"].ToString());
                    }
                    if (dt.Rows[n]["Delete_time"] != null && dt.Rows[n]["Delete_time"].ToString() != "")
                    {
                        model.Delete_time = DateTime.Parse(dt.Rows[n]["Delete_time"].ToString());
                    }
                    if (dt.Rows[n]["portal"] != null && dt.Rows[n]["portal"].ToString() != "")
                    {
                        model.portal = dt.Rows[n]["portal"].ToString();
                    }
                    if (dt.Rows[n]["theme"] != null && dt.Rows[n]["theme"].ToString() != "")
                    {
                        model.theme = dt.Rows[n]["theme"].ToString();
                    }
                    if (dt.Rows[n]["canlogin"] != null && dt.Rows[n]["canlogin"].ToString() != "")
                    {
                        model.canlogin = int.Parse(dt.Rows[n]["canlogin"].ToString());
                    }
                    if (dt.Rows[n]["jbx"] != null && dt.Rows[n]["jbx"].ToString() != "")
                    {
                        model.jbx = int.Parse(dt.Rows[n]["jbx"].ToString());
                    }
                    if (dt.Rows[n]["Emp_id_sg"] != null && dt.Rows[n]["Emp_id_sg"].ToString() != "")
                    {
                        model.Emp_id_sg = int.Parse(dt.Rows[n]["Emp_id_sg"].ToString());
                    }
                    if (dt.Rows[n]["zt"] != null && dt.Rows[n]["zt"].ToString() != "")
                    {
                        model.zt = dt.Rows[n]["zt"].ToString();
                    }
                    if (dt.Rows[n]["xj"] != null && dt.Rows[n]["xj"].ToString() != "")
                    {
                        model.xj = dt.Rows[n]["xj"].ToString();
                    }
                    if (dt.Rows[n]["private_per"] != null && dt.Rows[n]["private_per"].ToString() != "")
                    {
                        model.private_per = dt.Rows[n]["private_per"].ToString();
                    }
                    if (dt.Rows[n]["Emp_sg"] != null && dt.Rows[n]["Emp_sg"].ToString() != "")
                    {
                        model.Emp_sg = dt.Rows[n]["Emp_sg"].ToString();
                    }
                    if (dt.Rows[n]["create_id"] != null && dt.Rows[n]["create_id"].ToString() != "")
                    {
                        model.create_id = int.Parse(dt.Rows[n]["create_id"].ToString());
                    }
                    if (dt.Rows[n]["create_name"] != null && dt.Rows[n]["create_name"].ToString() != "")
                    {
                        model.create_name = dt.Rows[n]["create_name"].ToString();
                    }

                    if (dt.Rows[n]["theme"] != null && dt.Rows[n]["theme"].ToString() != "")
                    {
                        model.theme = dt.Rows[n]["theme"].ToString();
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
        /// 更新岗位
        /// </summary>
        public bool UpdatePost(XHD.Model.hr_socialWorker model)
        {
            return dal.UpdatePost(model);
        }
        /// <summary>
        /// 获取密码
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public DataSet GetPWD(int ID)
        {
            return dal.GetPWD(ID);
        }
        /// <summary>
        /// 更新密码
        /// </summary>
        public bool changepwd(XHD.Model.hr_socialWorker model)
        {
            return dal.changepwd(model);
        }

        /// <summary>
        /// 获取权限
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public DataSet GetRole(int ID)
        {
            return dal.GetRole(ID);
        }

        /// <summary>
        /// 个人信息修改
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public bool PersonalUpdate(Model.hr_socialWorker model)
        {
            return dal.PersonalUpdate(model);
        }

        /// <summary>
        /// 更新客户，订单，合同，收款，开票 人员
        /// </summary>
        public bool UpdateCOCRI(XHD.Model.hr_socialWorker model)
        {
            return dal.UpdateCOCRI(model);
        }


        /// <summary>
        /// 更新默认地图
        /// </summary>
        public bool UpdateDefaultCity(XHD.Model.hr_socialWorker model)
        {
            return dal.UpdateDefaultCity(model);
        }

        /// <summary>
        /// 更新最后跟进
        /// </summary>
        public bool UpdateLastFollow(string id)
        {
            return dal.UpdateLastFollow(id);
        }

        #endregion  Method
    }
}

