using System;
namespace XHD.Model
{
	/// <summary>
	/// KHJD_LIST_VIEW_LIST_person:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class KHJD_LIST_VIEW_LIST_person
	{
		public KHJD_LIST_VIEW_LIST_person()
		{}
		#region Model
		private int _khjdid;
		private string _cid;
		private int _jdid;
		private int _xmid;
		private int _userid;
		private string _username;
		private int? _roleid;
		private string _rolename;
		private string _czr;
		private string _remark;
		private DateTime _lrrq;
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
		public int JDID
		{
			set{ _jdid=value;}
			get{return _jdid;}
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
		public int userid
		{
			set{ _userid=value;}
			get{return _userid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string username
		{
			set{ _username=value;}
			get{return _username;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? roleid
		{
			set{ _roleid=value;}
			get{return _roleid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string rolename
		{
			set{ _rolename=value;}
			get{return _rolename;}
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
		public int status
		{
			set{ _status=value;}
			get{return _status;}
		}
		#endregion Model

	}
}

