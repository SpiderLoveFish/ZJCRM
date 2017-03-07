using System;
namespace XHD.Model
{
    /// <summary>
    /// hr_employee_accounts:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class hr_employee_accounts
    {
        public hr_employee_accounts()
        { }
        #region Model
        private int _id;
        private string _accountType;
        private string _account;
        private string _pwd;
        private string _bz;
        private int _employeeId;

        /// <summary>
        /// 
        /// </summary>
        public int ID
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string accountType
        {
            set { _accountType = value; }
            get { return _accountType; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string account
        {
            set { _account = value; }
            get { return _account; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string pwd
        {
            set { _pwd = value; }
            get { return _pwd; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string bz
        {
            set { _bz = value; }
            get { return _bz; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int employeeId
        {
            set { _employeeId = value; }
            get { return _employeeId; }
        }

        #endregion Model

    }
}

