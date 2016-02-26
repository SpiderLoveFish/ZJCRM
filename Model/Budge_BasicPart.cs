using System;
namespace XHD.Model
{
	/// <summary>
	/// Budge_BasicPart:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Budge_BasicPart
	{
		public Budge_BasicPart()
		{}
		#region Model
		private int _id;
		private string _bp_name;
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
		public string BP_Name
		{
			set{ _bp_name=value;}
			get{return _bp_name;}
		}
		#endregion Model

	}
}

