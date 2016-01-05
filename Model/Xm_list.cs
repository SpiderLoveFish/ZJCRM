using System;
namespace XHD.Model
{
	/// <summary>
	/// Xm_list:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Xm_list
	{
		public Xm_list()
		{}
		#region Model
		private int _xmid;
		private string _xmmc;
		private int? _xmpx;
		private string _remark;
		private string _czr;
		/// <summary>
		/// 
		/// </summary>
		public int XMID
		{
			set{ _xmid=value;}
			get{return _xmid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string XMMC
		{
			set{ _xmmc=value;}
			get{return _xmmc;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? XMPX
		{
			set{ _xmpx=value;}
			get{return _xmpx;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string REMARK
		{
			set{ _remark=value;}
			get{return _remark;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string CZR
		{
			set{ _czr=value;}
			get{return _czr;}
		}
		#endregion Model

	}
}

