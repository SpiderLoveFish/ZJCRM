using System;
namespace XHD.Model
{
	/// <summary>
	/// Crm_CEDetail:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Crm_CEDetail
	{
		public Crm_CEDetail()
		{}
		#region Model
		private int _id;
		private int? _projectid;
		private int? _versions;
		private int? _stageid;
		private decimal? _asstime;
		private bool _ischecked= false;
		private string _assdescription;
		private bool _isclose= false;
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
		public int? projectid
		{
			set{ _projectid=value;}
			get{return _projectid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? versions
		{
			set{ _versions=value;}
			get{return _versions;}
		}
		/// <summary>
		/// 考核等级
		/// </summary>
		public int? StageID
		{
			set{ _stageid=value;}
			get{return _stageid;}
		}
		/// <summary>
		/// 考核次数
		/// </summary>
        public decimal? AssTime
		{
			set{ _asstime=value;}
			get{return _asstime;}
		}
		/// <summary>
		/// 
		/// </summary>
		public bool isChecked
		{
			set{ _ischecked=value;}
			get{return _ischecked;}
		}
		/// <summary>
		/// 考核描述
		/// </summary>
		public string AssDescription
		{
			set{ _assdescription=value;}
			get{return _assdescription;}
		}
		/// <summary>
		/// 是否结案
		/// </summary>
		public bool IsClose
		{
			set{ _isclose=value;}
			get{return _isclose;}
		}
		#endregion Model

	}
}

