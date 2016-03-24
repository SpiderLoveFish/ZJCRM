using System;
namespace XHD.Model
{
	/// <summary>
	/// MasterStock:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class MasterStock
	{
		public MasterStock()
		{}
		#region Model
		private int _id;
		private string _financial_y_m;
		private int? _productid;
		private decimal? _beginstock;
		private decimal? _endstock;
		private decimal? _instock;
		private decimal? _outstock;
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
		public string Financial_Y_M
		{
			set{ _financial_y_m=value;}
			get{return _financial_y_m;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? ProductID
		{
			set{ _productid=value;}
			get{return _productid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? BeginStock
		{
			set{ _beginstock=value;}
			get{return _beginstock;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? EndStock
		{
			set{ _endstock=value;}
			get{return _endstock;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? InStock
		{
			set{ _instock=value;}
			get{return _instock;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? OutStock
		{
			set{ _outstock=value;}
			get{return _outstock;}
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

