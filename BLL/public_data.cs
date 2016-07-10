using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
    /// <summary>
    /// public_data
    /// </summary>
    public partial class public_data
    {
        private readonly XHD.DAL.public_data dal = new XHD.DAL.public_data();
        public public_data()
        { }
        #region  Method

        /// <summary>
        /// �õ����ID
        /// </summary>
        public int GetMaxId()
        {
            return dal.GetMaxId();
        }

        /// <summary>
        /// �Ƿ���ڸü�¼
        /// </summary>
        public bool Exists(int id)
        {
            return dal.Exists(id);
        }

        /// <summary>
        /// ����һ������
        /// </summary>
        public int Add(XHD.Model.public_data model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// ����һ������
        /// </summary>
        public bool Update(XHD.Model.public_data model)
        {
            return dal.Update(model);
        }

        /// <summary>
        /// Ԥɾ��
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
        /// ɾ��һ������
        /// </summary>
        public bool Delete(int id)
        {

            return dal.Delete(id);
        }
        /// <summary>
        /// ɾ��һ������
        /// </summary>
        public bool DeleteList(string idlist)
        {
            return dal.DeleteList(idlist);
        }

        /// <summary>
        /// �õ�һ������ʵ��
        /// </summary>
        public XHD.Model.public_data GetModel(int id)
        {

            return dal.GetModel(id);
        }

        /// <summary>
        /// �õ�һ������ʵ�壬�ӻ�����
        /// </summary>
        public XHD.Model.public_data GetModelByCache(int id)
        {

            string CacheKey = "public_dataModel-" + id;
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
            return (XHD.Model.public_data)objModel;
        }

        /// <summary>
        /// ��������б�
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }
        /// <summary>
        /// ���ǰ��������
        /// </summary>
        public DataSet GetList(int Top, string strWhere, string filedOrder)
        {
            return dal.GetList(Top, strWhere, filedOrder);
        }
        /// <summary>
        /// ��������б�
        /// </summary>
        public List<XHD.Model.public_data> GetModelList(string strWhere)
        {
            DataSet ds = dal.GetList(strWhere);
            return DataTableToList(ds.Tables[0]);
        }
        /// <summary>
        /// ��������б�
        /// </summary>
        public List<XHD.Model.public_data> DataTableToList(DataTable dt)
        {
            List<XHD.Model.public_data> modelList = new List<XHD.Model.public_data>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                XHD.Model.public_data model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new XHD.Model.public_data();
                    if (dt.Rows[n]["id"] != null && dt.Rows[n]["id"].ToString() != "")
                    {
                        model.id = int.Parse(dt.Rows[n]["id"].ToString());
                    }
                    if (dt.Rows[n]["category_id"] != null && dt.Rows[n]["category_id"].ToString() != "")
                    {
                        model.category_id = int.Parse(dt.Rows[n]["category_id"].ToString());
                    }
                    if (dt.Rows[n]["category_name"] != null && dt.Rows[n]["category_name"].ToString() != "")
                    {
                        model.category_name = dt.Rows[n]["category_name"].ToString();
                    }
                    if (dt.Rows[n]["title"] != null && dt.Rows[n]["title"].ToString() != "")
                    {
                        model.title = dt.Rows[n]["title"].ToString();
                    }
                    if (dt.Rows[n]["t_content"] != null && dt.Rows[n]["t_content"].ToString() != "")
                    {
                        model.t_content = dt.Rows[n]["t_content"].ToString();
                    }
                    if (dt.Rows[n]["create_id"] != null && dt.Rows[n]["create_id"].ToString() != "")
                    {
                        model.create_id = int.Parse(dt.Rows[n]["create_id"].ToString());
                    }
                    if (dt.Rows[n]["create_name"] != null && dt.Rows[n]["create_name"].ToString() != "")
                    {
                        model.create_name = dt.Rows[n]["create_name"].ToString();
                    }
                    if (dt.Rows[n]["create_time"] != null && dt.Rows[n]["create_time"].ToString() != "")
                    {
                        model.create_time = DateTime.Parse(dt.Rows[n]["create_time"].ToString());
                    }
                    if (dt.Rows[n]["isDelete"] != null && dt.Rows[n]["isDelete"].ToString() != "")
                    {
                        model.isDelete = int.Parse(dt.Rows[n]["isDelete"].ToString());
                    }
                    if (dt.Rows[n]["Delete_time"] != null && dt.Rows[n]["Delete_time"].ToString() != "")
                    {
                        model.Delete_time = DateTime.Parse(dt.Rows[n]["Delete_time"].ToString());
                    }
                    if (dt.Rows[n]["orderid"] != null && dt.Rows[n]["orderid"].ToString() != "")
                    {
                        model.orderid = int.Parse(dt.Rows[n]["orderid"].ToString());
                    }
                    if (dt.Rows[n]["qxbd"] != null && dt.Rows[n]["qxbd"].ToString() != "")
                    {
                        model.qxbd = dt.Rows[n]["qxbd"].ToString();
                    }
                    
                    modelList.Add(model);
                }
            }
            return modelList;
        }

        /// <summary>
        /// ��������б�
        /// </summary>
        public DataSet GetAllList()
        {
            return GetList("");
        }

        /// <summary>
        /// ��ҳ��ȡ�����б�
        /// </summary>
        public DataSet GetList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            return dal.GetList(PageSize, PageIndex, strWhere, filedOrder, out Total);
        }

        #endregion  Method
    }
}

