using System;
namespace XHD.Model
{
	/// <summary>
	/// tools_use_mx:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class tools_use_mx
	{
		public tools_use_mx()
		{}
		#region Model
		private int _id;
		private string _toolsid;
		private int? _productid;
		private string _productname;
		private int? _productnumber;
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
		public string toolsid
		{
			set{ _toolsid=value;}
			get{return _toolsid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? productid
		{
			set{ _productid=value;}
			get{return _productid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string productname
		{
			set{ _productname=value;}
			get{return _productname;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? productnumber
		{
			set{ _productnumber=value;}
			get{return _productnumber;}
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

