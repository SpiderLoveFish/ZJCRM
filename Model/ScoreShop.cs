using System;
namespace XHD.Model
{
	/// <summary>
	/// ScoreShop:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class ScoreShop
	{
		public ScoreShop()
		{}
		#region Model
		private int _id;
		private string _scorename;
		private string _scoredescribe;
		private int? _needscore;
		private string _img;
		private string _thumimg;
		private int? _totalsum;
		private int? _remainsum;
		private DateTime? _dotime;
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
		public string ScoreName
		{
			set{ _scorename=value;}
			get{return _scorename;}
		}
		/// <summary>
		/// 描述
		/// </summary>
		public string ScoreDescribe
		{
			set{ _scoredescribe=value;}
			get{return _scoredescribe;}
		}
		/// <summary>
		/// 需要积分
		/// </summary>
		public int? NeedScore
		{
			set{ _needscore=value;}
			get{return _needscore;}
		}
		/// <summary>
		/// 图片
		/// </summary>
		public string img
		{
			set{ _img=value;}
			get{return _img;}
		}
		/// <summary>
		/// 缩略图
		/// </summary>
		public string thumimg
		{
			set{ _thumimg=value;}
			get{return _thumimg;}
		}
		/// <summary>
		/// 总数量
		/// </summary>
		public int? TotalSum
		{
			set{ _totalsum=value;}
			get{return _totalsum;}
		}
		/// <summary>
		/// 剩余数量
		/// </summary>
		public int? RemainSum
		{
			set{ _remainsum=value;}
			get{return _remainsum;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? DoTime
		{
			set{ _dotime=value;}
			get{return _dotime;}
		}
		#endregion Model

	}
}

