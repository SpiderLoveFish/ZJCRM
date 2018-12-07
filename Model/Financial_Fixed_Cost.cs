using System;
namespace XHD.Model
{
	/// <summary>
	/// Financial_Fixed_Cost:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Financial_Fixed_Cost
	{
		public Financial_Fixed_Cost()
		{}
		#region Model
		private string _f_num;
		private int? _f_styleid;
		private string _f_stylename;
		private string _cwny;
		private decimal? _amount;
		private string _relevantperson;
		private string _remarks;
		private string _fromwhere;
		private string _createperson;
		private DateTime? _createtime;
		private string _isstatus;
		private DateTime? _deletetime;
        private int? _Pay_type_id;
        private string _Pay_type;


        public int? Pay_type_id
        {
            set { _Pay_type_id = value; }
            get { return _Pay_type_id; }
        }
        public string Pay_type
        {
            set { _Pay_type = value; }
            get { return _Pay_type; }
        }

        /// <summary>
        /// 
        /// </summary>
        public string F_Num
		{
			set{ _f_num=value;}
			get{return _f_num;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? F_StyleID
		{
			set{ _f_styleid=value;}
			get{return _f_styleid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string F_StyleName
		{
			set{ _f_stylename=value;}
			get{return _f_stylename;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string cwny
		{
			set{ _cwny=value;}
			get{return _cwny;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal? Amount
		{
			set{ _amount=value;}
			get{return _amount;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string RelevantPerson
		{
			set{ _relevantperson=value;}
			get{return _relevantperson;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Remarks
		{
			set{ _remarks=value;}
			get{return _remarks;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string FromWhere
		{
			set{ _fromwhere=value;}
			get{return _fromwhere;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string CreatePerson
		{
			set{ _createperson=value;}
			get{return _createperson;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime
		{
			set{ _createtime=value;}
			get{return _createtime;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string IsStatus
		{
			set{ _isstatus=value;}
			get{return _isstatus;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? DeleteTime
		{
			set{ _deletetime=value;}
			get{return _deletetime;}
		}
		#endregion Model

	}
}

