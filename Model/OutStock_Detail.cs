using System;
namespace XHD.Model
{
	/// <summary>
	/// OutStock_Detail:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class OutStock_Detail
	{
		public OutStock_Detail()
		{}
		#region Model
		private string _ckid;
		private string _material_id;
		private string _material_name;
		private string _specifications;
		private string _model;
		private string _unit;
		private decimal? _purprice;
		private decimal? _pursum;
		private decimal? _subtotal;
		private string _remarks;
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
		public string material_id
		{
			set{ _material_id=value;}
			get{return _material_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string material_name
		{
			set{ _material_name=value;}
			get{return _material_name;}
		}
		/// <summary>
		/// 规格
		/// </summary>
		public string specifications
		{
			set{ _specifications=value;}
			get{return _specifications;}
		}
		/// <summary>
		/// 型号
		/// </summary>
		public string model
		{
			set{ _model=value;}
			get{return _model;}
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
		public decimal? purprice
		{
			set{ _purprice=value;}
			get{return _purprice;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? pursum
		{
			set{ _pursum=value;}
			get{return _pursum;}
		}
		/// <summary>
		/// 小计
		/// </summary>
		public decimal? subtotal
		{
			set{ _subtotal=value;}
			get{return _subtotal;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string remarks
		{
			set{ _remarks=value;}
			get{return _remarks;}
		}
		#endregion Model

	}
}

