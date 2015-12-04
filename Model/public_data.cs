using System;
namespace XHD.Model
{
	/// <summary>
    /// public_help:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class public_data
	{
        public public_data()
		{}
		#region Model
		private int _id;
		private string _name;
		private int? _category_id;
		private string _category_name;
        private string _title;
        private string _t_content;
        private int? _create_id;
        private string _create_name;
        private DateTime? _create_time;
		private int? _isdelete;
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
		public string name
		{
			set{ _name=value;}
			get{return _name;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? category_id
		{
			set{ _category_id=value;}
			get{return _category_id;}
		}
		/// <summary>
		/// 
		/// </summary>
        public string category_name
        {
            set { _category_name = value; }
            get { return _category_name; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string title
        {
            set { _title = value; }
            get { return _title; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string t_content
        {
            set { _t_content = value; }
            get { return _t_content; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? create_id
        {
            set { _create_id = value; }
            get { return _create_id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string create_name
        {
            set { _create_name = value; }
            get { return _create_name; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime? create_time
        {
            set { _create_time = value; }
            get { return _create_time; }
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

