using System;
namespace XHD.Model
{
	/// <summary>
	/// Budge_Model:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Budge_Model
	{
		public Budge_Model()
		{}
		#region Model
		private int _id;
		private string _moudel_id;
		private int? _budge_id;
		private int? _xmid;
		private string _componentname;
		private string _cname;
		private string _unit;
		private decimal? _mmaterialprice;
		private bool _isshowprice;
		private decimal? _secmaterialprice;
		private decimal? _artificialprice;
		private decimal? _mechanicalloss;
		private decimal? _materialloss;
		private decimal? _totalprice;
		private bool _isdiscount;
		private decimal? _totaldiscountprice;
		private decimal? _materialcost;
		private decimal? _mechanicalcost;
		private decimal? _artificialcost;
		private decimal? _sum;
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
		public string Moudel_id
		{
			set{ _moudel_id=value;}
			get{return _moudel_id;}
		}
		/// <summary>
		/// 项目编号
		/// </summary>
		public int? budge_id
		{
			set{ _budge_id=value;}
			get{return _budge_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? xmid
		{
			set{ _xmid=value;}
			get{return _xmid;}
		}
		/// <summary>
		/// 部件名称
		/// </summary>
		public string ComponentName
		{
			set{ _componentname=value;}
			get{return _componentname;}
		}
		/// <summary>
		/// 分类名称
		/// </summary>
		public string Cname
		{
			set{ _cname=value;}
			get{return _cname;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string unit
		{
			set{ _unit=value;}
			get{return _unit;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? MmaterialPrice
		{
			set{ _mmaterialprice=value;}
			get{return _mmaterialprice;}
		}
		/// <summary>
		/// 
		/// </summary>
		public bool IsShowPrice
		{
			set{ _isshowprice=value;}
			get{return _isshowprice;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? SecmaterialPrice
		{
			set{ _secmaterialprice=value;}
			get{return _secmaterialprice;}
		}
		/// <summary>
		/// 人工单价
		/// </summary>
		public decimal? ArtificialPrice
		{
			set{ _artificialprice=value;}
			get{return _artificialprice;}
		}
		/// <summary>
		/// 机械损耗
		/// </summary>
		public decimal? MechanicalLoss
		{
			set{ _mechanicalloss=value;}
			get{return _mechanicalloss;}
		}
		/// <summary>
		/// 材料损耗
		/// </summary>
		public decimal? MaterialLoss
		{
			set{ _materialloss=value;}
			get{return _materialloss;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? TotalPrice
		{
			set{ _totalprice=value;}
			get{return _totalprice;}
		}
		/// <summary>
		/// 
		/// </summary>
		public bool IsDiscount
		{
			set{ _isdiscount=value;}
			get{return _isdiscount;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? TotalDiscountPrice
		{
			set{ _totaldiscountprice=value;}
			get{return _totaldiscountprice;}
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
		public decimal? MechanicalCost
		{
			set{ _mechanicalcost=value;}
			get{return _mechanicalcost;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? ArtificialCost
		{
			set{ _artificialcost=value;}
			get{return _artificialcost;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? SUM
		{
			set{ _sum=value;}
			get{return _sum;}
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

