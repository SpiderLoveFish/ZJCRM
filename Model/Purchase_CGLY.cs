using System;
namespace XHD.Model
{
	/// <summary>
	/// Purchase_CGLY:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Purchase_CGLY
	{
		public Purchase_CGLY()
		{}
		#region Model
		private string _purid;
		private string _supplier_id;
		private string _supplier_name;
		private DateTime? _purdate;
		private decimal? _paid_amount;
		private decimal? _payable_amount;
		private decimal? _arrears;
		private int? _isnode;
		private string _remarks;
		private string _correlation_id;
		private string _materialman;
		private int? _customid;
		private string _txm;
		private bool _isgd;
		private DateTime? _confirmdate;
		private decimal? _invoice_money=0M;
		private decimal? _arrears_invoice;
		private int? _departmentid;
		private string _departmentname;
		private string _purstyle;
		private string _cgstyle;
		/// <summary>
		/// 
		/// </summary>
		public string Purid
		{
			set{ _purid=value;}
			get{return _purid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string supplier_id
		{
			set{ _supplier_id=value;}
			get{return _supplier_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string supplier_name
		{
			set{ _supplier_name=value;}
			get{return _supplier_name;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? purdate
		{
			set{ _purdate=value;}
			get{return _purdate;}
		}
		/// <summary>
		/// 已付金额
		/// </summary>
		public decimal? paid_amount
		{
			set{ _paid_amount=value;}
			get{return _paid_amount;}
		}
		/// <summary>
		/// 应付金额
		/// </summary>
		public decimal? payable_amount
		{
			set{ _payable_amount=value;}
			get{return _payable_amount;}
		}
		/// <summary>
		/// 欠款
		/// </summary>
		public decimal? arrears
		{
			set{ _arrears=value;}
			get{return _arrears;}
		}
		/// <summary>
		/// 状态（原结讫）
		/// </summary>
		public int? isNode
		{
			set{ _isnode=value;}
			get{return _isnode;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string remarks
		{
			set{ _remarks=value;}
			get{return _remarks;}
		}
		/// <summary>
		/// 关联单号
		/// </summary>
		public string correlation_id
		{
			set{ _correlation_id=value;}
			get{return _correlation_id;}
		}
		/// <summary>
		/// 材料员
		/// </summary>
		public string materialman
		{
			set{ _materialman=value;}
			get{return _materialman;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? customid
		{
			set{ _customid=value;}
			get{return _customid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string txm
		{
			set{ _txm=value;}
			get{return _txm;}
		}
		/// <summary>
		/// 是否直接确认到工地
		/// </summary>
		public bool IsGD
		{
			set{ _isgd=value;}
			get{return _isgd;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? ConfirmDate
		{
			set{ _confirmdate=value;}
			get{return _confirmdate;}
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
		public int? departmentid
		{
			set{ _departmentid=value;}
			get{return _departmentid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string departmentname
		{
			set{ _departmentname=value;}
			get{return _departmentname;}
		}
		/// <summary>
		/// 采购类型（用品采购，材料采购等）
		/// </summary>
		public string purstyle
		{
			set{ _purstyle=value;}
			get{return _purstyle;}
		}
		/// <summary>
		/// 采购类型（专属公司用品采购）
		/// </summary>
		public string cgstyle
		{
			set{ _cgstyle=value;}
			get{return _cgstyle;}
		}
		#endregion Model

	}
}

