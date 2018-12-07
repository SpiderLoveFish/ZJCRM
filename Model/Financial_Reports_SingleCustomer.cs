using System;
namespace XHD.Model
{
	/// <summary>
	/// Financial_Reports_SingleCustomer:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Financial_Reports_SingleCustomer
	{
		public Financial_Reports_SingleCustomer()
		{}
		#region Model
		private int _id;
		private int _customerid;
		private string _cwny;
		private decimal? _collectedamount;
		private decimal? _materialcost;
		private decimal? _labourcost;
		private decimal? _fixedapportionment;
		private decimal? _changeapportionment;
		private decimal? _companymaori;
		private decimal? _businessprofit;
		private decimal? _constructionprofit;
		private decimal? _designprofit;
		private decimal? _companyprofit;
		private string _remarks;
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
		public int CustomerID
		{
			set{ _customerid=value;}
			get{return _customerid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string cwny
		{
			set{ _cwny=value;}
			get{return _cwny;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? CollectedAmount
		{
			set{ _collectedamount=value;}
			get{return _collectedamount;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? MaterialCost
		{
			set{ _materialcost=value;}
			get{return _materialcost;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? LabourCost
		{
			set{ _labourcost=value;}
			get{return _labourcost;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? FixedApportionment
		{
			set{ _fixedapportionment=value;}
			get{return _fixedapportionment;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? ChangeApportionment
		{
			set{ _changeapportionment=value;}
			get{return _changeapportionment;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? CompanyMaori
		{
			set{ _companymaori=value;}
			get{return _companymaori;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? BusinessProfit
		{
			set{ _businessprofit=value;}
			get{return _businessprofit;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? ConstructionProfit
		{
			set{ _constructionprofit=value;}
			get{return _constructionprofit;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? DesignProfit
		{
			set{ _designprofit=value;}
			get{return _designprofit;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? CompanyProfit
		{
			set{ _companyprofit=value;}
			get{return _companyprofit;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Remarks
		{
			set{ _remarks=value;}
			get{return _remarks;}
		}
		#endregion Model

	}
}

