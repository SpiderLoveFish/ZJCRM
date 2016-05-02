using System;
namespace XHD.Model
{
    /// <summary>
    /// CRM_Customer:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class CRM_Customer
    {
        public CRM_Customer()
        { }
        #region Model
        private int _id;
        private string _serialnumber;
        private string _customer;
        private string _address;
        private string _tel;
        private string _fax;
        private string _site;
        private string _industry;
        private int? _provinces_id;
        private string _provinces;
        private int? _city_id;
        private string _city;
        private int? _towns_id;
        private string _towns;
        private int? _community_id;
        private string _community;
        private string _bNo;
        private string _rNo;
        private string _gender;
        private int? _customertype_id;
        private string _customertype;
        private int? _customerlevel_id;
        private string _customerlevel;
        private int? _customersource_id;
        private string _customersource;
        private string _descripe;
        private string _remarks;
        private int? _department_id;
        private string _department;
        private int? _employee_id;
        private string _employee;
        private string _privatecustomer;
        private DateTime? _lastfollow;
        private int? _create_id;
        private string _create_name;
        private DateTime? _create_date;
        private int? _isdelete;
        private DateTime? _delete_time;
        private int? _industry_id;
        private string _jfrq;
        private string _zxrq;
        private string _jhrq1;
        private string _jhrq2;
        private string _fwyt;
        private string _fwmj;
        private int? _fwhx_id;
        private string _fwhx;
        private int? _zxjd_id;
        private string _zxjd;
        private int? _zxfg_id;
        private string _zxfg;
        private int? _dpt_id_sg;
        private string _dpt_sg;
        private int? _emp_id_sg;
        private string _emp_sg;
        private int? _dpt_id_sj;
        private string _dpt_sj;
        private int? _emp_id_sj;
        private string _emp_sj;
        private string _xy;
        private string _QQ;
        private int? _WXZT_ID;
        private string _WXZT_NAME;
        private string _JKDZ;
        private string _hxt;
        private string _jgqjt;

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
        public string Serialnumber
        {
            set { _serialnumber = value; }
            get { return _serialnumber; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Customer
        {
            set { _customer = value; }
            get { return _customer; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string address
        {
            set { _address = value; }
            get { return _address; }
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
        /// 
        /// </summary>
        public string fax
        {
            set { _fax = value; }
            get { return _fax; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string site
        {
            set { _site = value; }
            get { return _site; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string industry
        {
            set { _industry = value; }
            get { return _industry; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? Provinces_id
        {
            set { _provinces_id = value; }
            get { return _provinces_id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Provinces
        {
            set { _provinces = value; }
            get { return _provinces; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? City_id
        {
            set { _city_id = value; }
            get { return _city_id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string City
        {
            set { _city = value; }
            get { return _city; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? Towns_id
        {
            set { _towns_id = value; }
            get { return _towns_id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Towns
        {
            set { _towns = value; }
            get { return _towns; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? Community_id
        {
            set { _community_id = value; }
            get { return _community_id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Community
        {
            set { _community = value; }
            get { return _community; }
        }

        /// <summary>
        /// 
        /// </summary>
        public string BNo
        {
            set { _bNo = value; }
            get { return _bNo; }
        }

        /// <summary>
        /// 
        /// </summary>
        public string RNo
        {
            set { _rNo = value; }
            get { return _rNo; }
        }

        /// <summary>
        /// 
        /// </summary>
        public string Gender
        {
            set { _gender = value; }
            get { return _gender; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? CustomerType_id
        {
            set { _customertype_id = value; }
            get { return _customertype_id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string CustomerType
        {
            set { _customertype = value; }
            get { return _customertype; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? CustomerLevel_id
        {
            set { _customerlevel_id = value; }
            get { return _customerlevel_id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string CustomerLevel
        {
            set { _customerlevel = value; }
            get { return _customerlevel; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? CustomerSource_id
        {
            set { _customersource_id = value; }
            get { return _customersource_id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string CustomerSource
        {
            set { _customersource = value; }
            get { return _customersource; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string DesCripe
        {
            set { _descripe = value; }
            get { return _descripe; }
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
        public int? Department_id
        {
            set { _department_id = value; }
            get { return _department_id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Department
        {
            set { _department = value; }
            get { return _department; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? Employee_id
        {
            set { _employee_id = value; }
            get { return _employee_id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Employee
        {
            set { _employee = value; }
            get { return _employee; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string privatecustomer
        {
            set { _privatecustomer = value; }
            get { return _privatecustomer; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime? lastfollow
        {
            set { _lastfollow = value; }
            get { return _lastfollow; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? Create_id
        {
            set { _create_id = value; }
            get { return _create_id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Create_name
        {
            set { _create_name = value; }
            get { return _create_name; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime? Create_date
        {
            set { _create_date = value; }
            get { return _create_date; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? isDelete
        {
            set { _isdelete = value; }
            get { return _isdelete; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime? Delete_time
        {
            set { _delete_time = value; }
            get { return _delete_time; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? industry_id
        {
            set { _industry_id = value; }
            get { return _industry_id; }
        }

        public string Jfrq
        {
            set { _jfrq = value; }
            get { return _jfrq; }
        }

        public string Zxrq
        {
            set { _zxrq = value; }
            get { return _zxrq; }
        }

        public string Jhrq1
        {
            set { _jhrq1 = value; }
            get { return _jhrq1; }
        }

        public string Jhrq2
        {
            set { _jhrq2 = value; }
            get { return _jhrq2; }
        }

        public string Fwyt
        {
            set { _fwyt = value; }
            get { return _fwyt; }
        }

        public string Fwmj
        {
            set { _fwmj = value; }
            get { return _fwmj; }
        }

        public int? Fwhx_id
        {
            set { _fwhx_id = value; }
            get { return _fwhx_id; }
        }
        public string Fwhx
        {
            set { _fwhx = value; }
            get { return _fwhx; }
        }

        public int? Zxjd_id
        {
            set { _zxjd_id = value; }
            get { return _zxjd_id; }
        }
        public string Zxjd
        {
            set { _zxjd = value; }
            get { return _zxjd; }
        }

        public int? Zxfg_id
        {
            set { _zxfg_id = value; }
            get { return _zxfg_id; }
        }
        public string Zxfg
        {
            set { _zxfg = value; }
            get { return _zxfg; }
        }

        public int? Dpt_id_sg
        {
            set { _dpt_id_sg = value; }
            get { return _dpt_id_sg; }
        }
        public string Dpt_sg
        {
            set { _dpt_sg = value; }
            get { return _dpt_sg; }
        }
        public int? Emp_id_sg
        {
            set { _emp_id_sg = value; }
            get { return _emp_id_sg; }
        }
        public string Emp_sg
        {
            set { _emp_sg = value; }
            get { return _emp_sg; }
        }

        public int? Dpt_id_sj
        {
            set { _dpt_id_sj = value; }
            get { return _dpt_id_sj; }
        }
        public string Dpt_sj
        {
            set { _dpt_sj = value; }
            get { return _dpt_sj; }
        }
        public int? Emp_id_sj
        {
            set { _emp_id_sj = value; }
            get { return _emp_id_sj; }
        }
        public string Emp_sj
        {
            set { _emp_sj = value; }
            get { return _emp_sj; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string xy
        {
            set { _xy = value; }
            get { return _xy; }
        }
        public int? WXZT_ID
        {
            set { _WXZT_ID = value; }
            get { return _WXZT_ID; }
        }
        public string WXZT_NAME
        {
            set { _WXZT_NAME = value; }
            get { return _WXZT_NAME; }
        }
        public string QQ
        {
            set { _QQ = value; }
            get { return _QQ; }
        }
        public string JKDZ
        {
            set { _JKDZ = value; }
            get { return _JKDZ; }
        }
        public string hxt
        {
            set { _hxt = value; }
            get { return _hxt; }
        }
        public string jgqjt
        {
            set { _jgqjt = value; }
            get { return _jgqjt; }
        }

        #endregion Model

    }
}

