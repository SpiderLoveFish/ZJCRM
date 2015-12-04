using System;
using System.Data;
using System.Collections.Generic;
using XHD.Common;
using XHD.Model;
namespace XHD.BLL
{
	/// <summary>
	/// sys_info
	/// </summary>
	public partial class sys_info
	{
		private readonly XHD.DAL.sys_info dal=new XHD.DAL.sys_info();
		public sys_info()
		{}
		#region  Method
        
		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(XHD.Model.sys_info model)
		{
			return dal.Update(model);
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
		public DataSet GetAllList()
		{
			return GetList("");
		}
		

		#endregion  Method
	}
}

