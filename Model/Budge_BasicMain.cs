using System;
namespace XHD.Model
{
	/// <summary>
	/// Budge_BasicMain:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Budge_BasicMain
	{
		public Budge_BasicMain()
		{}
		#region Model
		private int _id;
		private int? _customer_id;
		private string _budgetname;
		private int? _doperson;
		private DateTime? _dotime;
		private int? _isstatus;
		private decimal? _projectdirectcost;
		private decimal? _directcostdiscount;
		private decimal? _additionalcost;
		private decimal? _budgetamount;
		private decimal? _discountamount;
		private decimal? _costamount;
		private decimal? _signingamount;
		private DateTime? _signingtime;
		private decimal? _profit;
		private string _remarks;
		private decimal? _mmaterial;
		private decimal? _mmaterialdiscount;
		private decimal? _fbamount;
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
		public int? customer_id
		{
			set{ _customer_id=value;}
			get{return _customer_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string BudgetName
		{
			set{ _budgetname=value;}
			get{return _budgetname;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? DoPerson
		{
			set{ _doperson=value;}
			get{return _doperson;}
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
		public int? IsStatus
		{
			set{ _isstatus=value;}
			get{return _isstatus;}
		}
		/// <summary>
		/// 工程直接费用
		/// </summary>
		public decimal? ProjectDirectCost
		{
			set{ _projectdirectcost=value;}
			get{return _projectdirectcost;}
		}
		/// <summary>
		/// 直接费用折后小计
		/// </summary>
		public decimal? DirectCostDiscount
		{
			set{ _directcostdiscount=value;}
			get{return _directcostdiscount;}
		}
		/// <summary>
		/// 附加费用
		/// </summary>
		public decimal? AdditionalCost
		{
			set{ _additionalcost=value;}
			get{return _additionalcost;}
		}
		/// <summary>
		/// 预算总金额
		/// </summary>
		public decimal? BudgetAmount
		{
			set{ _budgetamount=value;}
			get{return _budgetamount;}
		}
		/// <summary>
		/// 折后总金额
		/// </summary>
		public decimal? DiscountAmount
		{
			set{ _discountamount=value;}
			get{return _discountamount;}
		}
		/// <summary>
		/// 成本总金额
		/// </summary>
		public decimal? CostAmount
		{
			set{ _costamount=value;}
			get{return _costamount;}
		}
		/// <summary>
		/// 签单总金额
		/// </summary>
		public decimal? SigningAmount
		{
			set{ _signingamount=value;}
			get{return _signingamount;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? SigningTime
		{
			set{ _signingtime=value;}
			get{return _signingtime;}
		}
		/// <summary>
		/// 利润
		/// </summary>
		public decimal? Profit
		{
			set{ _profit=value;}
			get{return _profit;}
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
		/// 主材小计
		/// </summary>
		public decimal? Mmaterial
		{
			set{ _mmaterial=value;}
			get{return _mmaterial;}
		}
		/// <summary>
		/// 主材折后小计
		/// </summary>
		public decimal? MmaterialDiscount
		{
			set{ _mmaterialdiscount=value;}
			get{return _mmaterialdiscount;}
		}
		/// <summary>
		/// 发包金额
		/// </summary>
		public decimal? fbAmount
		{
			set{ _fbamount=value;}
			get{return _fbamount;}
		}
		#endregion Model

	}
}

