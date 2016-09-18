using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using XHD.DBUtility;//Please add references
namespace XHD.DAL
{
    /// <summary>
    /// 数据访问类:CRM_Customer
    /// </summary>
    public partial class AppDal
    {
        public AppDal()
        { }
    
       

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetTax(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" SELECT * FROM Budge_tax WHERE budge_id='" + strWhere + "' ");

            return DbHelperSQL.Query(strSql.ToString());
        }

      
        public bool DeleteRateVer(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from Budge_Rate_Ver ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
            parameters[0].Value = id;

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


    }
}

