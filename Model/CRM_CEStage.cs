using System;
namespace xhd.Model
{
	/// <summary>
	/// CRM_CEStage:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class CRM_CEStage
	{
		public CRM_CEStage()
		{}
		#region Model
		private int _cstomerid;
		private int _empid;
		private int _stageid;
		private string _stagedescription;
		private string _stage_icon;
		private int? _isdelete=0;
		private int? _deleteid;
		private DateTime? _deletetime;
		private string _empids;
		private decimal? _stagescore;
		private decimal? _specialscore;
		/// <summary>
		/// 
		/// </summary>
		public int CstomerID
		{
			set{ _cstomerid=value;}
			get{return _cstomerid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int EmpID
		{
			set{ _empid=value;}
			get{return _empid;}
		}
		/// <summary>
		/// 施工阶段ID
		/// </summary>
		public int StageID
		{
			set{ _stageid=value;}
			get{return _stageid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string StageDescription
		{
			set{ _stagedescription=value;}
			get{return _stagedescription;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Stage_icon
		{
			set{ _stage_icon=value;}
			get{return _stage_icon;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? isdelete
		{
			set{ _isdelete=value;}
			get{return _isdelete;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? deleteid
		{
			set{ _deleteid=value;}
			get{return _deleteid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? deletetime
		{
			set{ _deletetime=value;}
			get{return _deletetime;}
		}
		/// <summary>
		/// 每个客户有一个主负责人，多个其他人员
		/// </summary>
		public string EmpIDs
		{
			set{ _empids=value;}
			get{return _empids;}
		}
		/// <summary>
		/// 考核分数
		/// </summary>
		public decimal? StageScore
		{
			set{ _stagescore=value;}
			get{return _stagescore;}
		}
		/// <summary>
		/// 特殊情况下特殊权限控制加或减少百分比的分数
		/// </summary>
		public decimal? SpecialScore
		{
			set{ _specialscore=value;}
			get{return _specialscore;}
		}
		#endregion Model

	}
}

