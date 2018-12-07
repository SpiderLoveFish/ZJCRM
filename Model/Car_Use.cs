using System;
namespace XHD.Model
{
	/// <summary>
	/// Car_Use:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Car_Use
	{
		public Car_Use()
		{}
		#region Model
		private int _id;
		private int? _carid;
		private string _carnumber;
		private string _userperson;
		private DateTime? _usebegintiime;
		private DateTime? _useendtiime;
		private string _remarks;
		private string _isstatus="Y";
		/// <summary>
		/// 
		/// </summary>
		public int id
		{
			set{ _id=value;}
			get{return _id;}
		}
		/// <summary>
		/// 车辆类型编号
		/// </summary>
		public int? carid
		{
			set{ _carid=value;}
			get{return _carid;}
		}
		/// <summary>
		/// 车牌
		/// </summary>
		public string carNumber
		{
			set{ _carnumber=value;}
			get{return _carnumber;}
		}
		/// <summary>
		/// 负责人
		/// </summary>
		public string userPerson
		{
			set{ _userperson=value;}
			get{return _userperson;}
		}
		/// <summary>
		/// 上次年检
		/// </summary>
		public DateTime? useBeginTiime
		{
			set{ _usebegintiime=value;}
			get{return _usebegintiime;}
		}
		/// <summary>
		/// 上次投保日期
		/// </summary>
		public DateTime? useEndTiime
		{
			set{ _useendtiime=value;}
			get{return _useendtiime;}
		}
		/// <summary>
		/// 备注
		/// </summary>
		public string Remarks
		{
			set{ _remarks=value;}
			get{return _remarks;}
		}
		/// <summary>
		/// 状态
		/// </summary>
		public string IsStatus
		{
			set{ _isstatus=value;}
			get{return _isstatus;}
		}
		#endregion Model

	}
}

