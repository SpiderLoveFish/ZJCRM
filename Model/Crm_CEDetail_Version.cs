using System;
namespace XHD.Model
{
	/// <summary>
	/// Crm_CEDetail_Version:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Crm_CEDetail_Version
	{
		public Crm_CEDetail_Version()
		{}
		#region Model
		private int _id;
		private int? _projectid;
		private int? _stageid;
		private int? _stagedetailid;
		private int? _ischecked=0;
		private int? _version;
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
		public int? stageid
		{
			set{ _stageid=value;}
			get{return _stageid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? stagedetailid
		{
			set{ _stagedetailid=value;}
			get{return _stagedetailid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? ischecked
		{
			set{ _ischecked=value;}
			get{return _ischecked;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? version
		{
			set{ _version=value;}
			get{return _version;}
		}
		#endregion Model

	}
}

