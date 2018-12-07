using System;
namespace XHD.Model
{
	/// <summary>
	/// KcGl_Jcb_Cklb_KW:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class KcGl_Jcb_Cklb_KW
	{
		public KcGl_Jcb_Cklb_KW()
		{}
		#region Model
		private string _kwid;
		private int _cklbid;
		private string _name;
		private int? _lxrid;
		private string _lxr;
		private string _lxrdh;
		private string _remark;
		private int? _inempid;
		private DateTime? _indate;
		private int? _editempid;
		private DateTime? _editdate;
		private string _isdel;
		private int? _delempid;
		private DateTime? _deldate;
		/// <summary>
		/// 
		/// </summary>
		public string KWID
		{
			set{ _kwid=value;}
			get{return _kwid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int CklbID
		{
			set{ _cklbid=value;}
			get{return _cklbid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Name
		{
			set{ _name=value;}
			get{return _name;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? Lxrid
		{
			set{ _lxrid=value;}
			get{return _lxrid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Lxr
		{
			set{ _lxr=value;}
			get{return _lxr;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Lxrdh
		{
			set{ _lxrdh=value;}
			get{return _lxrdh;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Remark
		{
			set{ _remark=value;}
			get{return _remark;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? InEmpID
		{
			set{ _inempid=value;}
			get{return _inempid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? InDate
		{
			set{ _indate=value;}
			get{return _indate;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? EditEmpID
		{
			set{ _editempid=value;}
			get{return _editempid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditDate
		{
			set{ _editdate=value;}
			get{return _editdate;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string IsDel
		{
			set{ _isdel=value;}
			get{return _isdel;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? DelEmpID
		{
			set{ _delempid=value;}
			get{return _delempid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? DelDate
		{
			set{ _deldate=value;}
			get{return _deldate;}
		}
		#endregion Model

	}
}

