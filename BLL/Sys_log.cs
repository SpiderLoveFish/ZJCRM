using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
	/// <summary>
	/// Sys_log
	/// </summary>
	public partial class Sys_log
	{
		private readonly XHD.DAL.Sys_log dal=new XHD.DAL.Sys_log();
		public Sys_log()
		{}
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
		public int  Add(XHD.Model.Sys_log model)
		{
			return dal.Add(model);
		}

        /// <summary>
        /// 获取日志类型
        /// </summary>
        /// <returns></returns>
        public DataSet GetLogtype()
        {
            return dal.GetLogtype();
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

        public DataSet GetListtrace(string strWhere)
        {
            return dal.GetListtrace(strWhere);
        }
        public int add_trace(string ID, string sta, string Name, string per)
        {
            return dal.add_trace(ID,sta,Name,per);
        }
	}
}

