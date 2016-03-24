using System;
namespace XHD.Model
{
	/// <summary>
	/// OutStock_Main:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class OutStock_Main
	{
		public OutStock_Main()
		{}
		#region Model
		private string _ckid;
		private DateTime _ckdate;
		private int? _customerid;
		private string _fym;
		private decimal? _totalamount;
		private decimal? _payamount;
		private string _inperson;
		private string _remarks;
		private decimal? _costamount;
		private string _usestyle;
		/// <summary>
		/// 
		/// </summary>
		public string CKID
		{
			set{ _ckid=value;}
			get{return _ckid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime CKDate
		{
			set{ _ckdate=value;}
			get{return _ckdate;}
		}
		/// <summary>
		/// 财务年月
		/// </summary>
		public int? CustomerID
		{
			set{ _customerid=value;}
			get{return _customerid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string FYM
		{
			set{ _fym=value;}
			get{return _fym;}
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
		public decimal? PayAmount
		{
			set{ _payamount=value;}
			get{return _payamount;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string InPerson
		{
			set{ _inperson=value;}
			get{return _inperson;}
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
		/// 
		/// </summary>
		public decimal? CostAmount
		{
			set{ _costamount=value;}
			get{return _costamount;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string UseStyle
		{
			set{ _usestyle=value;}
			get{return _usestyle;}
		}
		#endregion Model

	}
}

