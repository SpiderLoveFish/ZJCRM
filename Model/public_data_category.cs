using System;
namespace XHD.Model
{
	/// <summary>
	/// public_data_category:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class public_data_category
	{
		public public_data_category()
		{}
		#region Model
		private int _id;
		private string _category;
		private int? _parentid;
		private string _icon;
		private int? _isdelete;
		private int? _delete_id;
		private DateTime? _delete_time;
        private int? _orderid;
		/// <summary>
		/// 
		/// </summary>
		public int id
		{
			set{ _id=value;}
			get{return _id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string category
		{
			set{ _category=value;}
			get{return _category;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? parentid
		{
			set{ _parentid=value;}
			get{return _parentid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string icon
		{
			set{ _icon=value;}
			get{return _icon;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? isDelete
		{
			set{ _isdelete=value;}
			get{return _isdelete;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? Delete_id
		{
			set{ _delete_id=value;}
			get{return _delete_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? Delete_time
		{
			set{ _delete_time=value;}
			get{return _delete_time;}
		}
        /// <summary>
        /// 
        /// </summary>
        public int? orderid
        {
            set { _orderid = value; }
            get { return _orderid; }
        }
		#endregion Model

	}
}

