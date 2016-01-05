using System;
namespace XHD.Model
{
	/// <summary>
	/// KHJD_LIST_VIEW_LIST:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class KHJD_LIST_VIEW_LIST
	{
		public KHJD_LIST_VIEW_LIST()
		{}
		#region Model
		private int _khjdid;
		private string _cid;
		private string _cpro;
		private string _ccity;
		private int _jdid;
		private string _jdmc;
		private int _xmid;
		private string _xmmc;
		private string _remark;
		private DateTime _lrrq;
		private string _jdys;
		private string _cname;
		private string _czr;
		private string _cmob;
		private int _status;
		/// <summary>
		/// 
		/// </summary>
		public int KHJDID
		{
			set{ _khjdid=value;}
			get{return _khjdid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string CID
		{
			set{ _cid=value;}
			get{return _cid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Cpro
		{
			set{ _cpro=value;}
			get{return _cpro;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Ccity
		{
			set{ _ccity=value;}
			get{return _ccity;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int JDID
		{
			set{ _jdid=value;}
			get{return _jdid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string JDMC
		{
			set{ _jdmc=value;}
			get{return _jdmc;}
		}
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
		public string REMARK
		{
			set{ _remark=value;}
			get{return _remark;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime LRRQ
		{
			set{ _lrrq=value;}
			get{return _lrrq;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string JDYS
		{
			set{ _jdys=value;}
			get{return _jdys;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Cname
		{
			set{ _cname=value;}
			get{return _cname;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string CZR
		{
			set{ _czr=value;}
			get{return _czr;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Cmob
		{
			set{ _cmob=value;}
			get{return _cmob;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int status
		{
			set{ _status=value;}
			get{return _status;}
		}
		#endregion Model

	}
}

