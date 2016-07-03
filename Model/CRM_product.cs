using System;
namespace XHD.Model
{
	/// <summary>
	/// CRM_product:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class CRM_product
	{
		public CRM_product()
		{}
		#region Model
		private int _product_id;
		private string _product_name;
		private int? _category_id;
		private string _category_name;
		private string _specifications;
		private string _status;
		private string _unit;
        private string _remarks;
        private string _url;
        private string _t_content;
		private decimal? _price;
        private decimal? _zc_price;
        private decimal? _fc_price;
        private decimal? _rg_price;

		private int? _isdelete;
		private DateTime? _delete_time;
        private decimal? _nbj;
        private string _xh;
        private string _xl;
        private string _gys;
        private string _zt;
        private string _pp;
        private string _C_code;
        private string _c_style;

		/// <summary>
		/// 
		/// </summary>
		public int product_id
		{
			set{ _product_id=value;}
			get{return _product_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string product_name
		{
			set{ _product_name=value;}
			get{return _product_name;}
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
			set{ _category_name=value;}
			get{return _category_name;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string specifications
		{
			set{ _specifications=value;}
			get{return _specifications;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string status
		{
			set{ _status=value;}
			get{return _status;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string unit
		{
			set{ _unit=value;}
			get{return _unit;}
		}
        /// <summary>
        /// 
        /// </summary>
        public string remarks
        {
            set { _remarks = value; }
            get { return _remarks; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string url
        {
            set { _url = value; }
            get { return _url; }
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
		public decimal? price
		{
			set{ _price=value;}
			get{return _price;}
		}
        public decimal? zc_price
        {
            set { _zc_price = value; }
            get { return _zc_price; }
        }
        public decimal? fc_price
        {
            set { _fc_price = value; }
            get { return _fc_price; }
        }
        public decimal? rg_price
        {
            set { _rg_price = value; }
            get { return _rg_price; }
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
		public decimal? nbj
		{
			set{ _nbj=value;}
			get{return _nbj;}
		}
               /// <summary>
        /// 
        /// </summary>
        public string gys
        {
            set { _gys = value; }
            get { return _gys; }
        }
               /// <summary>
        /// 
        /// </summary>
        public string xh
        {
            set { _xh = value; }
            get { return _xh; }
        }
            /// <summary>
        /// 
        /// </summary>
        public string xl
        {
            set { _xl = value; }
            get { return _xl; }
        }
          /// <summary>
        /// 
        /// </summary>
        public string zt
        {
            set { _zt = value; }
            get { return _zt; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string pp
        {
            set { _pp = value; }
            get { return _pp; }
        }

        public string C_code
        {
            set { _C_code = value; }
            get { return _C_code; }
        }

        public string C_style
        {
            set { _c_style = value; }
            get { return _c_style; }
        }
		#endregion Model

	}
}

