using System;
namespace XHD.Model
{
	/// <summary>
	/// Car_Basic:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Car_Basic
	{
		public Car_Basic()
		{}
		#region Model
		private int _id;
		private int? _cartype_id;
		private string _cartype;
		private DateTime? _carbuydate;
		private string _carnumber;
		private string _carframe;
		private string _leadperson;
		private DateTime? _lastmot;
		private int? _motgapyear;
		private DateTime? _lasttimeinsured;
		private int? _currentkm;
		private string _remarks;
        private string _engine_number; 
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
		public int? cartype_id
		{
			set{ _cartype_id=value;}
			get{return _cartype_id;}
		}
		/// <summary>
		/// 车辆类型
		/// </summary>
		public string cartype
		{
			set{ _cartype=value;}
			get{return _cartype;}
		}
		/// <summary>
		/// 购买日期
		/// </summary>
		public DateTime? carbuydate
		{
			set{ _carbuydate=value;}
			get{return _carbuydate;}
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
		/// 车架号
		/// </summary>
		public string carFrame
		{
			set{ _carframe=value;}
			get{return _carframe;}
		}
		/// <summary>
		/// 负责人
		/// </summary>
		public string leadPerson
		{
			set{ _leadperson=value;}
			get{return _leadperson;}
		}
		/// <summary>
		/// 上次年检
		/// </summary>
		public DateTime? lastMOT
		{
			set{ _lastmot=value;}
			get{return _lastmot;}
		}
		/// <summary>
		/// 年检间隔年数
		/// </summary>
		public int? MOTgapYear
		{
			set{ _motgapyear=value;}
			get{return _motgapyear;}
		}
		/// <summary>
		/// 上次投保日期
		/// </summary>
		public DateTime? LastTimeInsured
		{
			set{ _lasttimeinsured=value;}
			get{return _lasttimeinsured;}
		}
		/// <summary>
		/// 当前公里数
		/// </summary>
		public int? CurrentKM
		{
			set{ _currentkm=value;}
			get{return _currentkm;}
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
        /// 发动机号
        /// </summary>
        public string engine_number
        {
            set { _engine_number = value; }
            get { return _engine_number; }
        }
        #endregion Model

    }
}

