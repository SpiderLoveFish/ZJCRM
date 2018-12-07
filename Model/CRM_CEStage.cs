using System;
namespace XHD.Model
{
    /// <summary>
    /// CRM_CEStage:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class CRM_CEStage
    {
        public CRM_CEStage()
        { }
        #region Model
        private int _id;
        private int _customerid;
        private string _tel;
        private string _customername;
        private string _sgjl;
        private int? _sgjlid;
        private string _sjs = "0";
        private int? _sjsid;
        private string _ywy;
        private int? _ywyid;
        private decimal? _stagescore;
        private decimal? _specialscore;
        private string _stage_icon;
        private string _remarks;
        private int? _iscolse = 0;
        private DateTime _Jh_date;
        private DateTime _Begindate;
        /// <summary>
        /// 
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int CustomerID
        {
            set { _customerid = value; }
            get { return _customerid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string tel
        {
            set { _tel = value; }
            get { return _tel; }
        }
        /// <summary>
        /// 施工阶段ID
        /// </summary>
        public string CustomerName
        {
            set { _customername = value; }
            get { return _customername; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string sgjl
        {
            set { _sgjl = value; }
            get { return _sgjl; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? sgjlid
        {
            set { _sgjlid = value; }
            get { return _sgjlid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string sjs
        {
            set { _sjs = value; }
            get { return _sjs; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? sjsid
        {
            set { _sjsid = value; }
            get { return _sjsid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string ywy
        {
            set { _ywy = value; }
            get { return _ywy; }
        }
        /// <summary>
        /// 每个客户有一个主负责人，多个其他人员
        /// </summary>
        public int? ywyid
        {
            set { _ywyid = value; }
            get { return _ywyid; }
        }
        /// <summary>
        /// 考核分数
        /// </summary>
        public decimal? StageScore
        {
            set { _stagescore = value; }
            get { return _stagescore; }
        }
        /// <summary>
        /// 特殊情况下特殊权限控制加或减少百分比的分数
        /// </summary>
        public decimal? SpecialScore
        {
            set { _specialscore = value; }
            get { return _specialscore; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Stage_icon
        {
            set { _stage_icon = value; }
            get { return _stage_icon; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Remarks
        {
            set { _remarks = value; }
            get { return _remarks; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? IsColse
        {
            set { _iscolse = value; }
            get { return _iscolse; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime Jh_date
        {
            set { _Jh_date = value; }
            get { return _Jh_date; }
        }
        public DateTime Begindate
        {
            set { _Begindate = value; }
            get { return _Begindate; }
        }
        
        #endregion Model

    }
}

