using System;
namespace XHD.Model
{
	/// <summary>
	/// crm_customer_type:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class crm_customer_type
	{
		public crm_customer_type()
		{}
		#region Model
		private int _id;
		private int? _typeid;
		private decimal? _followhours;
		private string _remarks;
		private DateTime? _createtime;
		private string _createperson;
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
		public int? typeid
		{
			set{ _typeid=value;}
			get{return _typeid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? followhours
		{
			set{ _followhours=value;}
			get{return _followhours;}
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
		public DateTime? createtime
		{
			set{ _createtime=value;}
			get{return _createtime;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string createperson
		{
			set{ _createperson=value;}
			get{return _createperson;}
		}
		#endregion Model

	}
}

