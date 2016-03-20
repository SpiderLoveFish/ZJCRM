using System;
namespace XHD.Model
{
	/// <summary>
	/// Purchase_Main:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Purchase_Main
	{
		public Purchase_Main()
		{}
		#region Model
		private string _purid;
		private string _supplier_id;
		private string _supplier_name;
		private DateTime? _purdate;
		private decimal? _paid_amount;
		private decimal? _payable_amount;
		private decimal? _arrears;
		private int?_isnode;
		private string _remarks;
		private string _correlation_id;
		private string _materialman;
		private int? _customid;
		private string _txm;
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
		/// 
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
		#endregion Model

	}
}

