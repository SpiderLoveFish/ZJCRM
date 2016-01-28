using System;
namespace XHD.Model
{
	/// <summary>
	/// PurchaseList:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class PurchaseList
	{
		public PurchaseList()
		{}
		#region Model
		private int _id;
		private int? _customerid;
		private int? _category_id;
		private int? _product_id;
		private DateTime? _dotime;
		private string _doperson;
		private int? _isstatus;
		private decimal? _price;
		private decimal? _amountsum;
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
		public int? CustomerID
		{
			set{ _customerid=value;}
			get{return _customerid;}
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
		public int? product_id
		{
			set{ _product_id=value;}
			get{return _product_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? DoTime
		{
			set{ _dotime=value;}
			get{return _dotime;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string DoPerson
		{
			set{ _doperson=value;}
			get{return _doperson;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? IsStatus
		{
			set{ _isstatus=value;}
			get{return _isstatus;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? Price
		{
			set{ _price=value;}
			get{return _price;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? AmountSum
		{
			set{ _amountsum=value;}
			get{return _amountsum;}
		}
		#endregion Model

	}
}

