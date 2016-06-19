using System;
namespace XHD.Model
{
	/// <summary>
	/// WebSite_User:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class WebSite_User
	{
		public WebSite_User()
		{}
		#region Model
		private int _id;
		private string _userid;
		private string _tel;
		private string _pwd;
		private DateTime? _dotime;
		private string _nickname;
		private DateTime? _birthday;
		private string _sex="M";
		private string _status="Y";
		private string _kjl_login="admin@mb.xczs.com";
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
		public string userid
		{
			set{ _userid=value;}
			get{return _userid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string tel
		{
			set{ _tel=value;}
			get{return _tel;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string pwd
		{
			set{ _pwd=value;}
			get{return _pwd;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? dotime
		{
			set{ _dotime=value;}
			get{return _dotime;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string nickname
		{
			set{ _nickname=value;}
			get{return _nickname;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? birthday
		{
			set{ _birthday=value;}
			get{return _birthday;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string sex
		{
			set{ _sex=value;}
			get{return _sex;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string status
		{
			set{ _status=value;}
			get{return _status;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string kjl_login
		{
			set{ _kjl_login=value;}
			get{return _kjl_login;}
		}
		#endregion Model

	}
}

