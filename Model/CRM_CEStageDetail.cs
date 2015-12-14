using System;
namespace XHD.Model
{
	/// <summary>
	/// CRM_CEStageDetail:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class CRM_CEStageDetail
	{
		public CRM_CEStageDetail()
		{}
		#region Model
		private int _stageid;
		private int _stagedetailid;
		private string _description;

        private string _stagecontent;
		/// <summary>
		/// 施工阶段ID
		/// </summary>
		public int StageID
		{
			set{ _stageid=value;}
			get{return _stageid;}
		}
		/// <summary>
		/// 施工阶段ID
		/// </summary>
		public int StageDetailID
		{
			set{ _stagedetailid=value;}
			get{return _stagedetailid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Description
		{
			set{ _description=value;}
			get{return _description;}
		}
        /// <summary>
        /// 
        /// </summary>
        public string StageContent
        {
            set { _stagecontent = value; }
            get { return _stagecontent; }
        }

		#endregion Model

	}
}

