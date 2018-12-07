using System;
namespace XHD.Model
{
	/// <summary>
	/// Financial_Profit:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Financial_Profit
	{
		public Financial_Profit()
		{}
		#region Model
		private int _id;
		private int? _f_styleid;
		private string _f_stylename;
		private string _formula;
		private string _company_profit;
		private string _sjs_profit;
		private string _sgjl_profit;
		private string _ywy_profit;
		private string _f1_profit;
		private string _f2_profit;
		private string _f3_profit;
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
		public int? F_StyleID
		{
			set{ _f_styleid=value;}
			get{return _f_styleid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string F_StyleName
		{
			set{ _f_stylename=value;}
			get{return _f_stylename;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Formula
		{
			set{ _formula=value;}
			get{return _formula;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Company_Profit
		{
			set{ _company_profit=value;}
			get{return _company_profit;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string sjs_Profit
		{
			set{ _sjs_profit=value;}
			get{return _sjs_profit;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string sgjl_Profit
		{
			set{ _sgjl_profit=value;}
			get{return _sgjl_profit;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string ywy_Profit
		{
			set{ _ywy_profit=value;}
			get{return _ywy_profit;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string F1_Profit
		{
			set{ _f1_profit=value;}
			get{return _f1_profit;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string F2_Profit
		{
			set{ _f2_profit=value;}
			get{return _f2_profit;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string F3_Profit
		{
			set{ _f3_profit=value;}
			get{return _f3_profit;}
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

