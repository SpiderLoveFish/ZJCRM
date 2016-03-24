using System;
namespace XHD.Model
{
	/// <summary>
	/// INStock_Main:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class INStock_Main
	{
		public INStock_Main()
		{}
		#region Model
		private string _rkid;
		private DateTime? _rkdate;
		private string _fym;
		private int? _gysid;
		private decimal? _totalamount;
		private decimal? _payamount;
		private string _inperson;
		private string _remarks;
		private string _stockid;
		/// <summary>
		/// 
		/// </summary>
		public string RKID
		{
			set{ _rkid=value;}
			get{return _rkid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? RKDate
		{
			set{ _rkdate=value;}
			get{return _rkdate;}
		}
		/// <summary>
		/// 财务年月
		/// </summary>
		public string FYM
		{
			set{ _fym=value;}
			get{return _fym;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? GYSID
		{
			set{ _gysid=value;}
			get{return _gysid;}
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
		public string StockID
		{
			set{ _stockid=value;}
			get{return _stockid;}
		}
		#endregion Model

	}
}

