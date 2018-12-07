using System;
namespace XHD.Model
{
	/// <summary>
	/// Financial_Labour_Cost:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Financial_Labour_Cost
	{
		public Financial_Labour_Cost()
		{}
		#region Model
		private string _f_num;
		private int? _f_styleid;
		private string _f_stylename;
		private decimal? _mandayprice;
		private decimal? _manhour;
		private decimal? _amount;
		private decimal? _adjustamount;
		private decimal? _totalamount;
		private string _worker;
		private string _remarks;
		private string _fromwhere;
		private string _createperson;
		private DateTime? _createtime;
		private string _isstatus;
		private DateTime? _deletetime;
        private decimal? _CustomerID;
        private int? _Pay_type_id;
        private string _Pay_type;
        private string _IsHaveDetail;
        private decimal? _receive_money; 
        public int? Pay_type_id
        {
            set { _Pay_type_id = value; }
            get { return _Pay_type_id; }
        }
        public string Pay_type
        {
            set { _Pay_type = value; }
            get { return _Pay_type; }
        }

        /// <summary>
        /// 
        /// </summary>
        public string F_Num
		{
			set{ _f_num=value;}
			get{return _f_num;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? F_StyleID
		{
			set{ _f_styleid=value;}
			get{return _f_styleid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string F_StyleName
		{
			set{ _f_stylename=value;}
			get{return _f_stylename;}
		}
		/// <summary>
		/// 单价(人/天)
		/// </summary>
		public decimal? ManDayPrice
		{
			set{ _mandayprice=value;}
			get{return _mandayprice;}
		}
		/// <summary>
		/// 工时
		/// </summary>
		public decimal? ManHour
		{
			set{ _manhour=value;}
			get{return _manhour;}
		}
		/// <summary>
		/// 金额
		/// </summary>
		public decimal? Amount
		{
			set{ _amount=value;}
			get{return _amount;}
		}
		/// <summary>
		/// 调整金额
		/// </summary>
		public decimal? AdjustAmount
		{
			set{ _adjustamount=value;}
			get{return _adjustamount;}
		}
		/// <summary>
		/// 总金额
		/// </summary>
		public decimal? TotalAmount
		{
			set{ _totalamount=value;}
			get{return _totalamount;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string worker
		{
			set{ _worker=value;}
			get{return _worker;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Remarks
		{
			set{ _remarks=value;}
			get{return _remarks;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string FromWhere
		{
			set{ _fromwhere=value;}
			get{return _fromwhere;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string CreatePerson
		{
			set{ _createperson=value;}
			get{return _createperson;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime
		{
			set{ _createtime=value;}
			get{return _createtime;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string IsStatus
		{
			set{ _isstatus=value;}
			get{return _isstatus;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? DeleteTime
		{
			set{ _deletetime=value;}
			get{return _deletetime;}
		}

        public decimal? CustomerID
        {
            set { _CustomerID = value; }
            get { return _CustomerID; }
        }
        public string  IsHaveDetail
        {
            set { _IsHaveDetail = value; }
            get { return _IsHaveDetail; }
        }
        public decimal? receive_money
        {
            set { _receive_money = value; }
            get { return _receive_money; }
        }
        #endregion Model

    }
}

