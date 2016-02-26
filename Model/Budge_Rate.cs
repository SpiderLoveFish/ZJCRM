using System;
namespace XHD.Model
{
	/// <summary>
	/// Budge_Rate:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Budge_Rate
	{
		public Budge_Rate()
		{}
		#region Model
		private int _id;
		private string _ratename;
		private string _measure;
		private decimal? _rate;
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
		public string RateName
		{
			set{ _ratename=value;}
			get{return _ratename;}
		}
		/// <summary>
		/// 计算方式描述
		/// </summary>
		public string measure
		{
			set{ _measure=value;}
			get{return _measure;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? rate
		{
			set{ _rate=value;}
			get{return _rate;}
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

