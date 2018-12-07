using System;
namespace XHD.Model
{
	/// <summary>
	/// Financial_Labour_Cost_Recive:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Financial_Labour_Cost_Recive
	{
		public Financial_Labour_Cost_Recive()
		{}
		#region Model
		private int _id;
		private string _serialnumber;
		private string _f_num;
		private int? _customerid;
		private int? _f_styleid;
		private string _f_stylename;
		private decimal? _receive_money;
		private decimal? _arrears_money;
		private decimal? _invoice_money;
		private decimal? _arrears_invoice;
		private decimal? _totalamount;
		private string _worker;
		private string _remarks;
		private string _fromwhere;
		private string _createperson;
		private DateTime? _createtime;
		private int? _order_status_id;
		private string _order_status;
		private string _isstatus;
		private DateTime? _deletetime;
		private int? _pay_type_id;
		private string _pay_type;
		private string _ishavedetail="N";
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
		public string Serialnumber
		{
			set{ _serialnumber=value;}
			get{return _serialnumber;}
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
		public int? CustomerID
		{
			set{ _customerid=value;}
			get{return _customerid;}
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
		/// 
		/// </summary>
		public decimal? receive_money
		{
			set{ _receive_money=value;}
			get{return _receive_money;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? arrears_money
		{
			set{ _arrears_money=value;}
			get{return _arrears_money;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? invoice_money
		{
			set{ _invoice_money=value;}
			get{return _invoice_money;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? arrears_invoice
		{
			set{ _arrears_invoice=value;}
			get{return _arrears_invoice;}
		}
		/// <summary>
		/// 
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
		public int? Order_status_id
		{
			set{ _order_status_id=value;}
			get{return _order_status_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Order_status
		{
			set{ _order_status=value;}
			get{return _order_status;}
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
		/// <summary>
		/// 
		/// </summary>
		public int? Pay_type_id
		{
			set{ _pay_type_id=value;}
			get{return _pay_type_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Pay_type
		{
			set{ _pay_type=value;}
			get{return _pay_type;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string IsHaveDetail
		{
			set{ _ishavedetail=value;}
			get{return _ishavedetail;}
		}
		#endregion Model

	}
}

