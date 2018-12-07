using System;
namespace XHD.Model
{
	/// <summary>
	/// Purchase_Detail:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Financial_Labour_Cost_Detail
    {
		public Financial_Labour_Cost_Detail()
		{}
		#region Model
		private string _fid;
		private string _material_id;
		private string _material_name;
		private string _specifications;
		private string _model;
		private string _unit;
		private decimal? _fprice;
		private decimal? _fsum;
		private decimal? _totalmoney;
		private string _remarks;
		/// <summary>
		/// 
		/// </summary>
		public string Purid
		{
			set{ _fid=value;}
			get{return _fid;}
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
		public decimal?fprice
		{
			set{ _fprice=value;}
			get{return _fprice;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? fsum
		{
			set{ _fsum=value;}
			get{return _fsum;}
		}
		/// <summary>
		/// 小计
		/// </summary>
		public decimal?  totalmoney
        {
			set{ _totalmoney = value;}
			get{return _totalmoney; }
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

