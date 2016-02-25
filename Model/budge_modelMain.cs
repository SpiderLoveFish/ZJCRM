using System;
namespace XHD.Model
{
	/// <summary>
	/// budge_modelMain:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class budge_modelMain
	{
		public budge_modelMain()
		{}
		#region Model
		private int _id;
		private string _model_id;
		private string _model_name;
		private int? _doperson;
		private DateTime? _dotime;
		private int? _citations;
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
		public string model_id
		{
			set{ _model_id=value;}
			get{return _model_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string model_name
		{
			set{ _model_name=value;}
			get{return _model_name;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? DoPerson
		{
			set{ _doperson=value;}
			get{return _doperson;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? DoTime
		{
			set{ _dotime=value;}
			get{return _dotime;}
		}
		/// <summary>
		/// 引用次数
		/// </summary>
		public int? citations
		{
			set{ _citations=value;}
			get{return _citations;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Remarks
		{
			set{ _remarks=value;}
			get{return _remarks;}
		}
		#endregion Model

	}
}

