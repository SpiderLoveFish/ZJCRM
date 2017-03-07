using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
    /// <summary>
    /// 数据访问类:hr_employee_accounts
    /// </summary>
    public partial class hr_employee_accounts
    {
        public hr_employee_accounts()
        { }
        #region  Method
        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int ID)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from hr_employee_accounts");
            strSql.Append(" where ID=@ID ");
            SqlParameter[] parameters = {
					new SqlParameter("@ID", SqlDbType.Int,4)};
            parameters[0].Value = ID;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(XHD.Model.hr_employee_accounts model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into hr_employee_accounts(");
            strSql.Append("accountType,account,pwd,bz,employeeId)");
            strSql.Append(" values (");
            strSql.Append("@accountType,@account,@pwd,@bz,@employeeId)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
					new SqlParameter("@accountType", SqlDbType.VarChar,50),
					new SqlParameter("@account", SqlDbType.VarChar,50),
					new SqlParameter("@pwd", SqlDbType.VarChar,50),
					new SqlParameter("@bz", SqlDbType.VarChar,50),
					new SqlParameter("@employeeId", SqlDbType.Int,4)};
            parameters[0].Value = model.accountType;
            parameters[1].Value = model.account;
            parameters[2].Value = model.pwd;
            parameters[3].Value = model.bz;
            parameters[4].Value = model.employeeId;          

            object obj = DbHelperSQL.GetSingle(strSql.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(XHD.Model.hr_employee_accounts model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update hr_employee_accounts set ");
            strSql.Append("accountType=@accountType,");
            strSql.Append("account=@account,");
            strSql.Append("pwd=@pwd,");
            strSql.Append("bz=@bz");        
            strSql.Append(" where ID=@ID");
            SqlParameter[] parameters = {
					new SqlParameter("@accountType", SqlDbType.VarChar,50),
					new SqlParameter("@account", SqlDbType.VarChar,50),
					new SqlParameter("@pwd", SqlDbType.VarChar,50),
					new SqlParameter("@bz", SqlDbType.VarChar,50),                 
					new SqlParameter("@ID", SqlDbType.Int,4)};
            parameters[0].Value = model.accountType;
            parameters[1].Value = model.account;
            parameters[2].Value = model.pwd;
            parameters[3].Value = model.bz;       
            parameters[4].Value = model.ID;

            int rows = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int ID)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from hr_employee_accounts ");
            strSql.Append(" where ID=@ID");
            SqlParameter[] parameters = {
					new SqlParameter("@ID", SqlDbType.Int,4)
};
            parameters[0].Value = ID;

            int rows = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool DeleteList(string IDlist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from hr_employee_accounts ");
            strSql.Append(" where ID in (" + IDlist + ")  ");
            int rows = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool DeleteUID(string uid)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from hr_employee_accounts ");
            strSql.Append(" where uid=@ID");
            SqlParameter[] parameters = {
					new SqlParameter("@ID", SqlDbType.VarChar,50)
                };
            parameters[0].Value = uid;

            int rows = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
     

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public XHD.Model.hr_employee_accounts GetModel(int ID)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 * from hr_employee_accounts ");
            strSql.Append(" where ID=@ID");
            SqlParameter[] parameters = {
					new SqlParameter("@ID", SqlDbType.Int,4)
                };
            parameters[0].Value = ID;

            XHD.Model.hr_employee_accounts model = new XHD.Model.hr_employee_accounts();
            DataSet ds = DbHelperSQL.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["ID"] != null && ds.Tables[0].Rows[0]["ID"].ToString() != "")
                {
                    model.ID = int.Parse(ds.Tables[0].Rows[0]["ID"].ToString());
                }
                if (ds.Tables[0].Rows[0]["accountType"] != null && ds.Tables[0].Rows[0]["accountType"].ToString() != "")
                {
                    model.accountType = ds.Tables[0].Rows[0]["accountType"].ToString();
                }
                if (ds.Tables[0].Rows[0]["account"] != null && ds.Tables[0].Rows[0]["account"].ToString() != "")
                {
                    model.account = ds.Tables[0].Rows[0]["account"].ToString();
                }
                if (ds.Tables[0].Rows[0]["pwd"] != null && ds.Tables[0].Rows[0]["pwd"].ToString() != "")
                {
                    model.pwd = ds.Tables[0].Rows[0]["pwd"].ToString();
                }
                if (ds.Tables[0].Rows[0]["bz"] != null && ds.Tables[0].Rows[0]["bz"].ToString() != "")
                {
                    model.bz = ds.Tables[0].Rows[0]["bz"].ToString();
                }
                if (ds.Tables[0].Rows[0]["employeeId"] != null && ds.Tables[0].Rows[0]["employeeId"].ToString() != "")
                {
                    model.employeeId = int.Parse(ds.Tables[0].Rows[0]["employeeId"].ToString());
                }
                
                return model;
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * ");
            strSql.Append(" FROM hr_employee_accounts ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得前几行数据
        /// </summary>
        public DataSet GetList(int Top, string strWhere, string filedOrder)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (Top > 0)
            {
                strSql.Append(" top " + Top.ToString());
            }
            strSql.Append(" * ");
            strSql.Append(" FROM hr_employee_accounts ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetList(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM hr_employee_accounts ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM hr_employee_accounts ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM hr_employee_accounts ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }  
    
        #endregion  Method
    }
}

