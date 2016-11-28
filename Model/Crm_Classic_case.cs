using System;
namespace XHD.Model
{
	/// <summary>
	/// Crm_Classic_case:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Crm_Classic_case
	{
		public Crm_Classic_case()
		{}
		#region Model
		private int _id;
		private string _c_title;
		private int? _customer_id;
		private string _customer_name;
		private string _community;
		private string _housearea;
		private string _housetype;
		private string _decorationtpye;
		private string _designer;
		private string _img_style;
		private string _url;
		private string _thum_img;
		private string _remarks;
		private string _isstatus;
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
		public string c_title
		{
			set{ _c_title=value;}
			get{return _c_title;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? customer_id
		{
			set{ _customer_id=value;}
			get{return _customer_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string customer_name
		{
			set{ _customer_name=value;}
			get{return _customer_name;}
		}
		/// <summary>
		/// 楼盘
		/// </summary>
		public string Community
		{
			set{ _community=value;}
			get{return _community;}
		}
		/// <summary>
		/// 铭记
		/// </summary>
		public string housearea
		{
			set{ _housearea=value;}
			get{return _housearea;}
		}
		/// <summary>
		/// 户型
		/// </summary>
		public string housetype
		{
			set{ _housetype=value;}
			get{return _housetype;}
		}
		/// <summary>
		/// 装修类型
		/// </summary>
		public string decorationtpye
		{
			set{ _decorationtpye=value;}
			get{return _decorationtpye;}
		}
		/// <summary>
		/// 设计师
		/// </summary>
		public string designer
		{
			set{ _designer=value;}
			get{return _designer;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string img_style
		{
			set{ _img_style=value;}
			get{return _img_style;}
		}
		/// <summary>
		/// 案例地址
		/// </summary>
		public string URL
		{
			set{ _url=value;}
			get{return _url;}
		}
		/// <summary>
		/// 缩略图
		/// </summary>
		public string thum_img
		{
			set{ _thum_img=value;}
			get{return _thum_img;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string remarks
		{
			set{ _remarks=value;}
			get{return _remarks;}
		}
		/// <summary>
		/// 0 edit 1 send 2 aprove
		/// </summary>
		public string IsStatus
		{
			set{ _isstatus=value;}
			get{return _isstatus;}
		}
		#endregion Model

	}
}

