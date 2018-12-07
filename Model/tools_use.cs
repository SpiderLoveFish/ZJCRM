using System;
namespace XHD.Model
{
	/// <summary>
	/// tools_use:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class tools_use
	{
		public tools_use()
		{}
		#region Model
		private int _id;
		private string _toolsid;
		private int? _borrowersid;
		private string _borrowers;
		private DateTime? _begintime;
		private DateTime? _endtime;
		private string _isstatus;
		private string _remarks;
        private DateTime? _dotime;
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
		public string toolsid
		{
			set{ _toolsid=value;}
			get{return _toolsid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? borrowersid
		{
			set{ _borrowersid=value;}
			get{return _borrowersid;}
		}
		/// <summary>
		/// 借用人
		/// </summary>
		public string borrowers
		{
			set{ _borrowers=value;}
			get{return _borrowers;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? begintime
		{
			set{ _begintime=value;}
			get{return _begintime;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? endtime
		{
			set{ _endtime=value;}
			get{return _endtime;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string isstatus
		{
			set{ _isstatus=value;}
			get{return _isstatus;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string remarks
		{
			set{ _remarks=value;}
			get{return _remarks;}
		}


        public DateTime? dotime
        {
            set { _dotime = value; }
            get { return _dotime; }
        }
        #endregion Model

    }
}

