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
    public partial class CRM_Customer
    {
        public CRM_Customer()
        { }
        #region  Method

        /// <summary>
        /// 得到最大ID
        /// </summary>
        public int GetMaxId()
        {
            return DbHelperSQL.GetMaxID("id", "CRM_Customer");
        }

        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from CRM_Customer");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = id;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(XHD.Model.CRM_Customer model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into CRM_Customer(");
            strSql.Append("Serialnumber,Customer,address,tel,fax,site,industry,Provinces_id,Provinces,City_id,City,Towns_id,Towns,Community_id,Community,BNo,RNo,Gender,CustomerType_id,CustomerType,CustomerLevel_id,CustomerLevel,CustomerSource_id,CustomerSource,DesCripe,Remarks,Department_id,Department,Employee_id,Employee,privatecustomer,lastfollow,Create_id,Create_name,Create_date,isDelete,Delete_time,industry_id,Jfrq,Zxrq,Jhrq1,Jhrq2,Fwyt,Fwmj,Fwhx_id,Fwhx,Zxjd_id,Zxjd,Zxfg_id,Zxfg,Dpt_id_sg,Dpt_sg,Emp_id_sg,Emp_sg,Dpt_id_sj,Dpt_sj,Emp_id_sj,Emp_sj,xy,QQ,WXZT_ID,WXZT_NAME,JKDZ)");
            strSql.Append(" values (");
            strSql.Append("@Serialnumber,@Customer,@address,@tel,@fax,@site,@industry,@Provinces_id,@Provinces,@City_id,@City,@Towns_id,@Towns,@Community_id,@Community,@BNo,@RNo,@Gender,@CustomerType_id,@CustomerType,@CustomerLevel_id,@CustomerLevel,@CustomerSource_id,@CustomerSource,@DesCripe,@Remarks,@Department_id,@Department,@Employee_id,@Employee,@privatecustomer,@lastfollow,@Create_id,@Create_name,@Create_date,@isDelete,@Delete_time,@industry_id,@Jfrq,@Zxrq,@Jhrq1,@Jhrq2,@Fwyt,@Fwmj,@Fwhx_id,@Fwhx,@Zxjd_id,@Zxjd,@Zxfg_id,@Zxfg,@Dpt_id_sg,@Dpt_sg,@Emp_id_sg,@Emp_sg,@Dpt_id_sj,@Dpt_sj,@Emp_id_sj,@Emp_sj,@xy,@QQ,@WXZT_ID,@WXZT_NAME,@JKDZ)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
					new SqlParameter("@Serialnumber", SqlDbType.VarChar,250),
					new SqlParameter("@Customer", SqlDbType.VarChar,250),
					new SqlParameter("@address", SqlDbType.VarChar,250),
					new SqlParameter("@tel", SqlDbType.VarChar,250),
					new SqlParameter("@fax", SqlDbType.VarChar,250),
					new SqlParameter("@site", SqlDbType.VarChar,250),
					new SqlParameter("@industry", SqlDbType.VarChar,250),
					new SqlParameter("@Provinces_id", SqlDbType.Int,4),
					new SqlParameter("@Provinces", SqlDbType.VarChar,250),
					new SqlParameter("@City_id", SqlDbType.Int,4),
					new SqlParameter("@City", SqlDbType.VarChar,250),
                    new SqlParameter("@Towns_id", SqlDbType.Int,4),
					new SqlParameter("@Towns", SqlDbType.VarChar,250),
                    new SqlParameter("@Community_id", SqlDbType.Int,4),
					new SqlParameter("@Community", SqlDbType.VarChar,250),
                    new SqlParameter("@BNo", SqlDbType.VarChar,50),
                    new SqlParameter("@RNo", SqlDbType.VarChar,50),
                    new SqlParameter("@Gender", SqlDbType.VarChar,50),
					new SqlParameter("@CustomerType_id", SqlDbType.Int,4),
					new SqlParameter("@CustomerType", SqlDbType.VarChar,250),
					new SqlParameter("@CustomerLevel_id", SqlDbType.Int,4),
					new SqlParameter("@CustomerLevel", SqlDbType.VarChar,250),
					new SqlParameter("@CustomerSource_id", SqlDbType.Int,4),
					new SqlParameter("@CustomerSource", SqlDbType.VarChar,250),
					new SqlParameter("@DesCripe", SqlDbType.VarChar,4000),
					new SqlParameter("@Remarks", SqlDbType.VarChar,4000),
					new SqlParameter("@Department_id", SqlDbType.Int,4),
					new SqlParameter("@Department", SqlDbType.VarChar,250),
					new SqlParameter("@Employee_id", SqlDbType.Int,4),
					new SqlParameter("@Employee", SqlDbType.VarChar,250),
					new SqlParameter("@privatecustomer", SqlDbType.VarChar,50),
					new SqlParameter("@lastfollow", SqlDbType.DateTime),
					new SqlParameter("@Create_id", SqlDbType.Int,4),
					new SqlParameter("@Create_name", SqlDbType.VarChar,250),
					new SqlParameter("@Create_date", SqlDbType.DateTime),
					new SqlParameter("@isDelete", SqlDbType.Int,4),
					new SqlParameter("@Delete_time", SqlDbType.DateTime),
                    new SqlParameter("@industry_id",SqlDbType.Int,4),
                    new SqlParameter("@Jfrq",SqlDbType.VarChar,50),
                    new SqlParameter("@Zxrq",SqlDbType.VarChar,50),
                    new SqlParameter("@Jhrq1",SqlDbType.VarChar,50),
                    new SqlParameter("@Jhrq2",SqlDbType.VarChar,50),
                    new SqlParameter("@Fwyt",SqlDbType.VarChar,50),
                    new SqlParameter("@Fwmj",SqlDbType.VarChar,50),
                    new SqlParameter("@Fwhx_id",SqlDbType.Int,4),
                    new SqlParameter("@Fwhx",SqlDbType.VarChar,50),
                    new SqlParameter("@Zxjd_id",SqlDbType.Int,4),
                    new SqlParameter("@Zxjd",SqlDbType.VarChar,50),
                    new SqlParameter("@Zxfg_id",SqlDbType.Int,4),
                    new SqlParameter("@Zxfg",SqlDbType.VarChar,50),
                    new SqlParameter("@Dpt_id_sg",SqlDbType.Int,4),
                    new SqlParameter("@Dpt_sg",SqlDbType.VarChar,50),
                    new SqlParameter("@Emp_id_sg",SqlDbType.Int,4),
                    new SqlParameter("@Emp_sg",SqlDbType.VarChar,50),
                    new SqlParameter("@Dpt_id_sj",SqlDbType.Int,4),
                    new SqlParameter("@Dpt_sj",SqlDbType.VarChar,50),
                    new SqlParameter("@Emp_id_sj",SqlDbType.Int,4),
                    new SqlParameter("@Emp_sj",SqlDbType.VarChar,50),
                       new SqlParameter("@xy",SqlDbType.VarChar,50),
                        new SqlParameter("@WXZT_ID",SqlDbType.Int,4),
                    new SqlParameter("@WXZT_NAME",SqlDbType.VarChar,50),
                    new SqlParameter("@QQ",SqlDbType.VarChar,50),
                      new SqlParameter("@JKDZ",SqlDbType.VarChar,250)
                                        };
            parameters[0].Value = model.Serialnumber;
            parameters[1].Value = model.Customer;
            parameters[2].Value = model.address;
            parameters[3].Value = model.tel;
            parameters[4].Value = model.fax;
            parameters[5].Value = model.site;
            parameters[6].Value = model.industry;
            parameters[7].Value = model.Provinces_id;
            parameters[8].Value = model.Provinces;
            parameters[9].Value = model.City_id;
            parameters[10].Value = model.City;
            parameters[11].Value = model.Towns_id;
            parameters[12].Value = model.Towns;
            parameters[13].Value = model.Community_id;
            parameters[14].Value = model.Community;
            parameters[15].Value = model.BNo;
            parameters[16].Value = model.RNo;
            parameters[17].Value = model.Gender;
            parameters[18].Value = model.CustomerType_id;
            parameters[19].Value = model.CustomerType;
            parameters[20].Value = model.CustomerLevel_id;
            parameters[21].Value = model.CustomerLevel;
            parameters[22].Value = model.CustomerSource_id;
            parameters[23].Value = model.CustomerSource;
            parameters[24].Value = model.DesCripe;
            parameters[25].Value = model.Remarks;
            parameters[26].Value = model.Department_id;
            parameters[27].Value = model.Department;
            parameters[28].Value = model.Employee_id;
            parameters[29].Value = model.Employee;
            parameters[30].Value = model.privatecustomer;
            parameters[31].Value = model.lastfollow;
            parameters[32].Value = model.Create_id;
            parameters[33].Value = model.Create_name;
            parameters[34].Value = model.Create_date;
            parameters[35].Value = model.isDelete;
            parameters[36].Value = model.Delete_time;
            parameters[37].Value = model.industry_id;
            parameters[38].Value = model.Jfrq;
            parameters[39].Value = model.Zxrq;
            parameters[40].Value = model.Jhrq1;
            parameters[41].Value = model.Jhrq2;
            parameters[42].Value = model.Fwyt;
            parameters[43].Value = model.Fwmj;
            parameters[44].Value = model.Fwhx_id;
            parameters[45].Value = model.Fwhx;
            parameters[46].Value = model.Zxjd_id;
            parameters[47].Value = model.Zxjd;
            parameters[48].Value = model.Zxfg_id;
            parameters[49].Value = model.Zxfg;
            parameters[50].Value = model.Dpt_id_sg;
            parameters[51].Value = model.Dpt_sg;
            parameters[52].Value = model.Emp_id_sg;
            parameters[53].Value = model.Emp_sg;
            parameters[54].Value = model.Dpt_id_sj;
            parameters[55].Value = model.Dpt_sj;
            parameters[56].Value = model.Emp_id_sj;
            parameters[57].Value = model.Emp_sj;
            parameters[58].Value = model.xy;
            parameters[59].Value = model.WXZT_ID;
            parameters[60].Value = model.WXZT_NAME;
            parameters[61].Value = model.QQ;
            parameters[62].Value = model.JKDZ;
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
        public bool Update(XHD.Model.CRM_Customer model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update CRM_Customer set ");
            strSql.Append("Serialnumber=@Serialnumber,");
            strSql.Append("Customer=@Customer,");
            strSql.Append("address=@address,");
            strSql.Append("tel=@tel,");
            strSql.Append("fax=@fax,");
            strSql.Append("site=@site,");
            strSql.Append("industry=@industry,");
            strSql.Append("Provinces_id=@Provinces_id,");
            strSql.Append("Provinces=@Provinces,");
            strSql.Append("City_id=@City_id,");
            strSql.Append("City=@City,");
            strSql.Append("Towns_id=@Towns_id,");
            strSql.Append("Towns=@Towns,");
            strSql.Append("Community_id=@Community_id,");
            strSql.Append("Community=@Community,");
            strSql.Append("BNo=@BNo,");
            strSql.Append("RNo=@RNo,");
            strSql.Append("Gender=@Gender,");
            strSql.Append("CustomerType_id=@CustomerType_id,");
            strSql.Append("CustomerType=@CustomerType,");
            strSql.Append("CustomerLevel_id=@CustomerLevel_id,");
            strSql.Append("CustomerLevel=@CustomerLevel,");
            strSql.Append("CustomerSource_id=@CustomerSource_id,");
            strSql.Append("CustomerSource=@CustomerSource,");
            strSql.Append("DesCripe=@DesCripe,");
            strSql.Append("Remarks=@Remarks,");
            strSql.Append("Department_id=@Department_id,");
            strSql.Append("Department=@Department,");
            strSql.Append("Employee_id=@Employee_id,");
            strSql.Append("Employee=@Employee,");
            strSql.Append("privatecustomer=@privatecustomer,");
            strSql.Append("industry_id=@industry_id,");
            strSql.Append("Jfrq=@Jfrq,");
            strSql.Append("Zxrq=@Zxrq,");
            strSql.Append("Jhrq1=@Jhrq1,");
            strSql.Append("Jhrq2=@Jhrq2,");
            strSql.Append("Fwyt=@Fwyt,");
            strSql.Append("Fwmj=@Fwmj,");
            strSql.Append("Fwhx_id=@Fwhx_id,");
            strSql.Append("Fwhx=@Fwhx,");
            strSql.Append("Zxjd_id=@Zxjd_id,");
            strSql.Append("Zxjd=@Zxjd,");
            strSql.Append("Zxfg_id=@Zxfg_id,");
            strSql.Append("Zxfg=@Zxfg,");
            strSql.Append("Dpt_id_sg=@Dpt_id_sg,");
            strSql.Append("Dpt_sg=@Dpt_sg,");
            strSql.Append("Emp_id_sg=@Emp_id_sg,");
            strSql.Append("Emp_sg=@Emp_sg,");
            strSql.Append("Dpt_id_sj=@Dpt_id_sj,");
            strSql.Append("Dpt_sj=@Dpt_sj,");
            strSql.Append("Emp_id_sj=@Emp_id_sj,");
            strSql.Append("Emp_sj=@Emp_sj");
            strSql.Append(" ,xy=@xy");
            strSql.Append(" ,WXZT_ID=@WXZT_ID");
            strSql.Append(" ,WXZT_NAME=@WXZT_NAME");
            strSql.Append(" ,QQ=@QQ");
            strSql.Append(" ,JKDZ=@JKDZ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@Serialnumber", SqlDbType.VarChar,250),
					new SqlParameter("@Customer", SqlDbType.VarChar,250),
					new SqlParameter("@address", SqlDbType.VarChar,250),
					new SqlParameter("@tel", SqlDbType.VarChar,250),
					new SqlParameter("@fax", SqlDbType.VarChar,250),
					new SqlParameter("@site", SqlDbType.VarChar,250),
					new SqlParameter("@industry", SqlDbType.VarChar,250),
					new SqlParameter("@Provinces_id", SqlDbType.Int,4),
					new SqlParameter("@Provinces", SqlDbType.VarChar,250),
					new SqlParameter("@City_id", SqlDbType.Int,4),
					new SqlParameter("@City", SqlDbType.VarChar,250),
                    new SqlParameter("@Towns_id", SqlDbType.Int,4),
					new SqlParameter("@Towns", SqlDbType.VarChar,250),
                    new SqlParameter("@Community_id", SqlDbType.Int,4),
					new SqlParameter("@Community", SqlDbType.VarChar,250),
                    new SqlParameter("@BNo", SqlDbType.VarChar,50),
                    new SqlParameter("@RNo", SqlDbType.VarChar,50),
                    new SqlParameter("@Gender", SqlDbType.VarChar,50),
					new SqlParameter("@CustomerType_id", SqlDbType.Int,4),
					new SqlParameter("@CustomerType", SqlDbType.VarChar,250),
					new SqlParameter("@CustomerLevel_id", SqlDbType.Int,4),
					new SqlParameter("@CustomerLevel", SqlDbType.VarChar,250),
					new SqlParameter("@CustomerSource_id", SqlDbType.Int,4),
					new SqlParameter("@CustomerSource", SqlDbType.VarChar,250),
					new SqlParameter("@DesCripe", SqlDbType.VarChar,4000),
					new SqlParameter("@Remarks", SqlDbType.VarChar,4000),
					new SqlParameter("@Department_id", SqlDbType.Int,4),
					new SqlParameter("@Department", SqlDbType.VarChar,250),
					new SqlParameter("@Employee_id", SqlDbType.Int,4),
					new SqlParameter("@Employee", SqlDbType.VarChar,250),
					new SqlParameter("@privatecustomer", SqlDbType.VarChar,50),
                    new SqlParameter("@industry_id",SqlDbType.Int,4),
                    new SqlParameter("@Jfrq",SqlDbType.VarChar,50),
                    new SqlParameter("@Zxrq",SqlDbType.VarChar,50),
                    new SqlParameter("@Jhrq1",SqlDbType.VarChar,50),
                    new SqlParameter("@Jhrq2",SqlDbType.VarChar,50),
                    new SqlParameter("@Fwyt",SqlDbType.VarChar,50),
                    new SqlParameter("@Fwmj",SqlDbType.VarChar,50),
                    new SqlParameter("@Fwhx_id",SqlDbType.Int,4),
                    new SqlParameter("@Fwhx",SqlDbType.VarChar,50),
                    new SqlParameter("@Zxjd_id",SqlDbType.Int,4),
                    new SqlParameter("@Zxjd",SqlDbType.VarChar,50),
                    new SqlParameter("@Zxfg_id",SqlDbType.Int,4),
                    new SqlParameter("@Zxfg",SqlDbType.VarChar,50),
                    new SqlParameter("@Dpt_id_sg",SqlDbType.Int,4),
                    new SqlParameter("@Dpt_sg",SqlDbType.VarChar,50),
                    new SqlParameter("@Emp_id_sg",SqlDbType.Int,4),
                    new SqlParameter("@Emp_sg",SqlDbType.VarChar,50),
                    new SqlParameter("@Dpt_id_sj",SqlDbType.Int,4),
                    new SqlParameter("@Dpt_sj",SqlDbType.VarChar,50),
                    new SqlParameter("@Emp_id_sj",SqlDbType.Int,4),
                    new SqlParameter("@Emp_sj",SqlDbType.VarChar,50),
                       new SqlParameter("@xy",SqlDbType.VarChar,50),
                              new SqlParameter("@WXZT_ID",SqlDbType.Int,4),
                         new SqlParameter("@WXZT_NAME",SqlDbType.VarChar,50),
                           new SqlParameter("@QQ",SqlDbType.VarChar,50),
                              new SqlParameter("@JKDZ",SqlDbType.VarChar,250),
                    new SqlParameter("@id", SqlDbType.Int,4)
                                        };
            parameters[0].Value = model.Serialnumber;
            parameters[1].Value = model.Customer;
            parameters[2].Value = model.address;
            parameters[3].Value = model.tel;
            parameters[4].Value = model.fax;
            parameters[5].Value = model.site;
            parameters[6].Value = model.industry;
            parameters[7].Value = model.Provinces_id;
            parameters[8].Value = model.Provinces;
            parameters[9].Value = model.City_id;
            parameters[10].Value = model.City;
            parameters[11].Value = model.Towns_id;
            parameters[12].Value = model.Towns;
            parameters[13].Value = model.Community_id;
            parameters[14].Value = model.Community;
            parameters[15].Value = model.BNo;
            parameters[16].Value = model.RNo;
            parameters[17].Value = model.Gender;
            parameters[18].Value = model.CustomerType_id;
            parameters[19].Value = model.CustomerType;
            parameters[20].Value = model.CustomerLevel_id;
            parameters[21].Value = model.CustomerLevel;
            parameters[22].Value = model.CustomerSource_id;
            parameters[23].Value = model.CustomerSource;
            parameters[24].Value = model.DesCripe;
            parameters[25].Value = model.Remarks;
            parameters[26].Value = model.Department_id;
            parameters[27].Value = model.Department;
            parameters[28].Value = model.Employee_id;
            parameters[29].Value = model.Employee;
            parameters[30].Value = model.privatecustomer;
            parameters[31].Value = model.industry_id;
            parameters[32].Value = model.Jfrq;
            parameters[33].Value = model.Zxrq;
            parameters[34].Value = model.Jhrq1;
            parameters[35].Value = model.Jhrq2;
            parameters[36].Value = model.Fwyt;
            parameters[37].Value = model.Fwmj;
            parameters[38].Value = model.Fwhx_id;
            parameters[39].Value = model.Fwhx;
            parameters[40].Value = model.Zxjd_id;
            parameters[41].Value = model.Zxjd;
            parameters[42].Value = model.Zxfg_id;
            parameters[43].Value = model.Zxfg;
            parameters[44].Value = model.Dpt_id_sg;
            parameters[45].Value = model.Dpt_sg;
            parameters[46].Value = model.Emp_id_sg;
            parameters[47].Value = model.Emp_sg;
            parameters[48].Value = model.Dpt_id_sj;
            parameters[49].Value = model.Dpt_sj;
            parameters[50].Value = model.Emp_id_sj;
            parameters[51].Value = model.Emp_sj;
            parameters[52].Value = model.xy;
            parameters[53].Value = model.WXZT_ID;
            parameters[54].Value = model.WXZT_NAME;
            parameters[55].Value = model.QQ;
            parameters[56].Value = model.JKDZ;
            parameters[57].Value = model.id;

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
        /// 批量转客户
        /// </summary>
        public bool Update_batch(XHD.Model.CRM_Customer model, string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update CRM_Customer set ");
            strSql.Append("Department_id=@Department_id,");
            strSql.Append("Department=@Department,");
            strSql.Append("Employee_id=@Employee_id,");
            strSql.Append("Employee=@Employee");
            strSql.Append(" where Employee_id=@Create_id");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
            }
            SqlParameter[] parameters = {					
					new SqlParameter("@Department_id", SqlDbType.Int,4),
					new SqlParameter("@Department", SqlDbType.VarChar,250),
					new SqlParameter("@Employee_id", SqlDbType.Int,4),
					new SqlParameter("@Employee", SqlDbType.VarChar,250),
                    new SqlParameter("@Create_id", SqlDbType.Int,4)
                                        };
            parameters[0].Value = model.Department_id;
            parameters[1].Value = model.Department;
            parameters[2].Value = model.Employee_id;
            parameters[3].Value = model.Employee;
            parameters[4].Value = model.Create_id;

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
        /// 预删除
        /// </summary>
        public bool AdvanceDelete(int id, int isDelete, string time)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update CRM_Customer set ");
            strSql.Append("isDelete=" + isDelete);
            strSql.Append(",Delete_time='" + time + "'");
            strSql.Append(" where id=" + id);
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
        public bool Delete(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from CRM_Customer ");
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
        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool DeleteList(string idlist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from CRM_Customer ");
            strSql.Append(" where id in (" + idlist + ")  ");
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
        /// 得到一个对象实体
        /// </summary>
        public XHD.Model.CRM_Customer GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 id,Serialnumber,Customer,address,tel,fax,site,industry,Provinces_id,Provinces,City_id,City,Towns_id,Towns,Community_id,Community,BNo,RNo,Gender,CustomerType_id,CustomerType,CustomerLevel_id,CustomerLevel,CustomerSource_id,CustomerSource,DesCripe,Remarks,Department_id,Department,Employee_id,Employee,privatecustomer,lastfollow,Create_id,Create_name,Create_date,isDelete,Delete_time,Jfrq,Zxrq,Jhrq1,Jhrq2,Fwyt,Fwmj,Fwhx_id,Fwhx,Zxjd_id,Zxjd,Zxfg_id,Zxfg,Emp_id_sg,Emp_sg,Emp_id_sj,Emp_sj,xy,WXZT_ID,WXZT_NAME,QQ,JKDZ from CRM_Customer ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
};
            parameters[0].Value = id;

            XHD.Model.CRM_Customer model = new XHD.Model.CRM_Customer();
            DataSet ds = DbHelperSQL.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["id"] != null && ds.Tables[0].Rows[0]["id"].ToString() != "")
                {
                    model.id = int.Parse(ds.Tables[0].Rows[0]["id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Serialnumber"] != null && ds.Tables[0].Rows[0]["Serialnumber"].ToString() != "")
                {
                    model.Serialnumber = ds.Tables[0].Rows[0]["Serialnumber"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Customer"] != null && ds.Tables[0].Rows[0]["Customer"].ToString() != "")
                {
                    model.Customer = ds.Tables[0].Rows[0]["Customer"].ToString();
                }
                if (ds.Tables[0].Rows[0]["address"] != null && ds.Tables[0].Rows[0]["address"].ToString() != "")
                {
                    model.address = ds.Tables[0].Rows[0]["address"].ToString();
                }
                if (ds.Tables[0].Rows[0]["tel"] != null && ds.Tables[0].Rows[0]["tel"].ToString() != "")
                {
                    model.tel = ds.Tables[0].Rows[0]["tel"].ToString();
                }
                if (ds.Tables[0].Rows[0]["fax"] != null && ds.Tables[0].Rows[0]["fax"].ToString() != "")
                {
                    model.fax = ds.Tables[0].Rows[0]["fax"].ToString();
                }
                if (ds.Tables[0].Rows[0]["site"] != null && ds.Tables[0].Rows[0]["site"].ToString() != "")
                {
                    model.site = ds.Tables[0].Rows[0]["site"].ToString();
                }
                if (ds.Tables[0].Rows[0]["industry"] != null && ds.Tables[0].Rows[0]["industry"].ToString() != "")
                {
                    model.industry = ds.Tables[0].Rows[0]["industry"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Provinces_id"] != null && ds.Tables[0].Rows[0]["Provinces_id"].ToString() != "")
                {
                    model.Provinces_id = int.Parse(ds.Tables[0].Rows[0]["Provinces_id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Provinces"] != null && ds.Tables[0].Rows[0]["Provinces"].ToString() != "")
                {
                    model.Provinces = ds.Tables[0].Rows[0]["Provinces"].ToString();
                }
                if (ds.Tables[0].Rows[0]["City_id"] != null && ds.Tables[0].Rows[0]["City_id"].ToString() != "")
                {
                    model.City_id = int.Parse(ds.Tables[0].Rows[0]["City_id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["City"] != null && ds.Tables[0].Rows[0]["City"].ToString() != "")
                {
                    model.City = ds.Tables[0].Rows[0]["City"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Towns_id"] != null && ds.Tables[0].Rows[0]["Towns_id"].ToString() != "")
                {
                    model.Towns_id = int.Parse(ds.Tables[0].Rows[0]["Towns_id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Towns"] != null && ds.Tables[0].Rows[0]["Towns"].ToString() != "")
                {
                    model.Towns = ds.Tables[0].Rows[0]["Towns"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Community_id"] != null && ds.Tables[0].Rows[0]["Community_id"].ToString() != "")
                {
                    model.Community_id = int.Parse(ds.Tables[0].Rows[0]["Community_id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Community"] != null && ds.Tables[0].Rows[0]["Community"].ToString() != "")
                {
                    model.Community = ds.Tables[0].Rows[0]["Community"].ToString();
                }
                if (ds.Tables[0].Rows[0]["BNo"] != null && ds.Tables[0].Rows[0]["BNo"].ToString() != "")
                {
                    model.BNo = ds.Tables[0].Rows[0]["BNo"].ToString();
                }
                if (ds.Tables[0].Rows[0]["RNo"] != null && ds.Tables[0].Rows[0]["RNo"].ToString() != "")
                {
                    model.RNo = ds.Tables[0].Rows[0]["RNo"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Gender"] != null && ds.Tables[0].Rows[0]["Gender"].ToString() != "")
                {
                    model.Gender = ds.Tables[0].Rows[0]["Gender"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CustomerType_id"] != null && ds.Tables[0].Rows[0]["CustomerType_id"].ToString() != "")
                {
                    model.CustomerType_id = int.Parse(ds.Tables[0].Rows[0]["CustomerType_id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CustomerType"] != null && ds.Tables[0].Rows[0]["CustomerType"].ToString() != "")
                {
                    model.CustomerType = ds.Tables[0].Rows[0]["CustomerType"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CustomerLevel_id"] != null && ds.Tables[0].Rows[0]["CustomerLevel_id"].ToString() != "")
                {
                    model.CustomerLevel_id = int.Parse(ds.Tables[0].Rows[0]["CustomerLevel_id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CustomerLevel"] != null && ds.Tables[0].Rows[0]["CustomerLevel"].ToString() != "")
                {
                    model.CustomerLevel = ds.Tables[0].Rows[0]["CustomerLevel"].ToString();
                }
                if (ds.Tables[0].Rows[0]["CustomerSource_id"] != null && ds.Tables[0].Rows[0]["CustomerSource_id"].ToString() != "")
                {
                    model.CustomerSource_id = int.Parse(ds.Tables[0].Rows[0]["CustomerSource_id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["CustomerSource"] != null && ds.Tables[0].Rows[0]["CustomerSource"].ToString() != "")
                {
                    model.CustomerSource = ds.Tables[0].Rows[0]["CustomerSource"].ToString();
                }
                if (ds.Tables[0].Rows[0]["DesCripe"] != null && ds.Tables[0].Rows[0]["DesCripe"].ToString() != "")
                {
                    model.DesCripe = ds.Tables[0].Rows[0]["DesCripe"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Remarks"] != null && ds.Tables[0].Rows[0]["Remarks"].ToString() != "")
                {
                    model.Remarks = ds.Tables[0].Rows[0]["Remarks"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Department_id"] != null && ds.Tables[0].Rows[0]["Department_id"].ToString() != "")
                {
                    model.Department_id = int.Parse(ds.Tables[0].Rows[0]["Department_id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Department"] != null && ds.Tables[0].Rows[0]["Department"].ToString() != "")
                {
                    model.Department = ds.Tables[0].Rows[0]["Department"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Employee_id"] != null && ds.Tables[0].Rows[0]["Employee_id"].ToString() != "")
                {
                    model.Employee_id = int.Parse(ds.Tables[0].Rows[0]["Employee_id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Employee"] != null && ds.Tables[0].Rows[0]["Employee"].ToString() != "")
                {
                    model.Employee = ds.Tables[0].Rows[0]["Employee"].ToString();
                }
                if (ds.Tables[0].Rows[0]["privatecustomer"] != null && ds.Tables[0].Rows[0]["privatecustomer"].ToString() != "")
                {
                    model.privatecustomer = ds.Tables[0].Rows[0]["privatecustomer"].ToString();
                }
                if (ds.Tables[0].Rows[0]["lastfollow"] != null && ds.Tables[0].Rows[0]["lastfollow"].ToString() != "")
                {
                    model.lastfollow = DateTime.Parse(ds.Tables[0].Rows[0]["lastfollow"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Create_id"] != null && ds.Tables[0].Rows[0]["Create_id"].ToString() != "")
                {
                    model.Create_id = int.Parse(ds.Tables[0].Rows[0]["Create_id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Create_name"] != null && ds.Tables[0].Rows[0]["Create_name"].ToString() != "")
                {
                    model.Create_name = ds.Tables[0].Rows[0]["Create_name"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Create_date"] != null && ds.Tables[0].Rows[0]["Create_date"].ToString() != "")
                {
                    model.Create_date = DateTime.Parse(ds.Tables[0].Rows[0]["Create_date"].ToString());
                }
                if (ds.Tables[0].Rows[0]["isDelete"] != null && ds.Tables[0].Rows[0]["isDelete"].ToString() != "")
                {
                    model.isDelete = int.Parse(ds.Tables[0].Rows[0]["isDelete"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Delete_time"] != null && ds.Tables[0].Rows[0]["Delete_time"].ToString() != "")
                {
                    model.Delete_time = DateTime.Parse(ds.Tables[0].Rows[0]["Delete_time"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Jfrq"] != null && ds.Tables[0].Rows[0]["Jfrq"].ToString() != "")
                {
                    model.Jfrq = ds.Tables[0].Rows[0]["Jfrq"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Zxrq"] != null && ds.Tables[0].Rows[0]["Zxrq"].ToString() != "")
                {
                    model.Zxrq = ds.Tables[0].Rows[0]["Zxrq"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Jhrq1"] != null && ds.Tables[0].Rows[0]["Jhrq1"].ToString() != "")
                {
                    model.Jhrq1 = ds.Tables[0].Rows[0]["Jhrq1"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Jhrq2"] != null && ds.Tables[0].Rows[0]["Jhrq2"].ToString() != "")
                {
                    model.Jhrq2 = ds.Tables[0].Rows[0]["Jhrq2"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Fwyt"] != null && ds.Tables[0].Rows[0]["Fwyt"].ToString() != "")
                {
                    model.Fwyt = ds.Tables[0].Rows[0]["Fwyt"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Fwmj"] != null && ds.Tables[0].Rows[0]["Fwmj"].ToString() != "")
                {
                    model.Fwmj = ds.Tables[0].Rows[0]["Fwmj"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Fwhx_id"] != null && ds.Tables[0].Rows[0]["Fwhx_id"].ToString() != "")
                {
                    model.Fwhx_id = int.Parse(ds.Tables[0].Rows[0]["Fwhx_id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Fwhx"] != null && ds.Tables[0].Rows[0]["Fwhx"].ToString() != "")
                {
                    model.Fwhx = ds.Tables[0].Rows[0]["Fwhx"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Zxjd_id"] != null && ds.Tables[0].Rows[0]["Zxjd_id"].ToString() != "")
                {
                    model.Zxjd_id = int.Parse(ds.Tables[0].Rows[0]["Zxjd_id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Zxjd"] != null && ds.Tables[0].Rows[0]["Zxjd"].ToString() != "")
                {
                    model.Zxjd = ds.Tables[0].Rows[0]["Zxjd"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Zxfg_id"] != null && ds.Tables[0].Rows[0]["Zxfg_id"].ToString() != "")
                {
                    model.Zxfg_id = int.Parse(ds.Tables[0].Rows[0]["Zxfg_id"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Zxfg"] != null && ds.Tables[0].Rows[0]["Zxfg"].ToString() != "")
                {
                    model.Zxfg = ds.Tables[0].Rows[0]["Zxfg"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Dpt_id_sg"] != null && ds.Tables[0].Rows[0]["Dpt_id_sg"].ToString() != "")
                {
                    model.Dpt_id_sg = int.Parse(ds.Tables[0].Rows[0]["Dpt_id_sg"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Dpt_sg"] != null && ds.Tables[0].Rows[0]["Dpt_sg"].ToString() != "")
                {
                    model.Dpt_sg = ds.Tables[0].Rows[0]["Dpt_sg"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Emp_id_sg"] != null && ds.Tables[0].Rows[0]["Emp_id_sg"].ToString() != "")
                {
                    model.Emp_id_sg = int.Parse(ds.Tables[0].Rows[0]["Emp_id_sg"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Emp_sg"] != null && ds.Tables[0].Rows[0]["Emp_sg"].ToString() != "")
                {
                    model.Emp_sg = ds.Tables[0].Rows[0]["Emp_sg"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Dpt_id_sj"] != null && ds.Tables[0].Rows[0]["Dpt_id_sj"].ToString() != "")
                {
                    model.Dpt_id_sj = int.Parse(ds.Tables[0].Rows[0]["Dpt_id_sj"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Dpt_sj"] != null && ds.Tables[0].Rows[0]["Dpt_sj"].ToString() != "")
                {
                    model.Dpt_sj = ds.Tables[0].Rows[0]["Dpt_sj"].ToString();
                }
                if (ds.Tables[0].Rows[0]["Emp_id_sj"] != null && ds.Tables[0].Rows[0]["Emp_id_sj"].ToString() != "")
                {
                    model.Emp_id_sj = int.Parse(ds.Tables[0].Rows[0]["Emp_id_sj"].ToString());
                }
                if (ds.Tables[0].Rows[0]["Emp_sj"] != null && ds.Tables[0].Rows[0]["Emp_sj"].ToString() != "")
                {
                    model.Emp_sj = ds.Tables[0].Rows[0]["Emp_sj"].ToString();
                }
                if (ds.Tables[0].Rows[0]["xy"] != null && ds.Tables[0].Rows[0]["xy"].ToString() != "")
                {
                    model.Emp_sj = ds.Tables[0].Rows[0]["xy"].ToString();
                }

                if (ds.Tables[0].Rows[0]["WXZT_ID"] != null && ds.Tables[0].Rows[0]["WXZT_ID"].ToString() != "")
                {
                    model.WXZT_ID = int.Parse(ds.Tables[0].Rows[0]["WXZT_ID"].ToString());
                }
                if (ds.Tables[0].Rows[0]["WXZT_NAME"] != null && ds.Tables[0].Rows[0]["WXZT_NAME"].ToString() != "")
                {
                    model.WXZT_NAME = ds.Tables[0].Rows[0]["WXZT_NAME"].ToString();
                }

                if (ds.Tables[0].Rows[0]["JKDZ"] != null && ds.Tables[0].Rows[0]["JKDZ"].ToString() != "")
                {
                    model.JKDZ = ds.Tables[0].Rows[0]["JKDZ"].ToString();
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
            strSql.Append("select id,Serialnumber,Customer,address,tel,fax,site,industry_id,industry,Provinces_id,Provinces,City_id,City,Towns_id,Towns,Community_id,Community,BNo,RNo,Gender,CustomerType_id,CustomerType,CustomerLevel_id,CustomerLevel,CustomerSource_id,CustomerSource,DesCripe,Remarks,Department_id,Department,Employee_id,Employee,privatecustomer,lastfollow,Create_id,Create_name,Create_date,isDelete,Delete_time,Jfrq,Zxrq,Jhrq1,Jhrq2,Fwyt,Fwmj,Fwhx_id,Fwhx,Zxjd_id,Zxjd,Zxfg_id,Zxfg,Dpt_id_sg,Dpt_sg,Emp_id_sg,Emp_sg,Dpt_id_sj,Dpt_sj,Emp_id_sj,Emp_sj,xy,WXZT_ID,WXZT_NAME,QQ,JKDZ ");
            strSql.Append(" FROM CRM_Customer ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet GetPageList(int pageIndex, int pageSize)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" SELECT * FROM ( SELECT");
            strSql.Append(" id,");
            strSql.Append(" ROW_NUMBER() over (order by id) AS number, Customer,address,tel,CustomerType");
            strSql.Append(" FROM dbo.CRM_Customer)AA");
            strSql.Append(" WHERE  number  between (" + pageIndex + "-1)*" + pageSize + " and" + pageIndex + "*" + pageSize + ")");

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
            strSql.Append(" id,Serialnumber,Customer,address,tel,fax,site,industry_id,industry,Provinces_id,Provinces,City_id,City,Towns_id,Towns,Community_id,Community,BNo,RNo,Gender,CustomerType_id,CustomerType,CustomerLevel_id,CustomerLevel,CustomerSource_id,CustomerSource,DesCripe,Remarks,Department_id,Department,Employee_id,Employee,privatecustomer,lastfollow,Create_id,Create_name,Create_date,isDelete,Delete_time,Jfrq,Zxrq,Jhrq1,Jhrq2,Fwyt,Fwmj,Fwhx_id,Fwhx,Zxjd_id,Zxjd,Zxfg_id,Zxfg,Dpt_id_sg,Dpt_sg,Emp_id_sg,Emp_sg,Dpt_id_sj,Dpt_sj,Emp_id_sj,Emp_sj,xy,WXZT_ID,WXZT_NAME,QQ,JKDZ ");
            strSql.Append(" FROM CRM_Customer ");
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
            strSql.Append(" top " + PageSize + " id,Serialnumber,Customer,address,tel,fax,site,industry,Provinces,City,Towns,Community,BNo,RNo,Gender,CustomerType,CustomerLevel,CustomerSource,Department_id,Department,Employee_id,Employee,privatecustomer,lastfollow,Create_date,Jfrq,Zxrq,Jhrq1,Jhrq2,Fwyt,Fwmj,Fwhx_id,Fwhx,Zxjd_id,Zxjd,Zxfg_id,Zxfg,Dpt_id_sg,Dpt_sg,Emp_id_sg,Emp_sg,Dpt_id_sj,Dpt_sj,Emp_id_sj,Emp_sj,xy,DesCripe,WXZT_ID,WXZT_NAME,QQ,JKDZ FROM CRM_Customer ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM CRM_Customer ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM CRM_Customer ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }
        /// <summary>
        /// 更新最后跟进
        /// </summary>
        public bool UpdateLastFollow(string id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update CRM_Customer set ");
            strSql.Append("[lastfollow] = isnull((select max(Follow_date) as Followdate from dbo.CRM_Follow where CRM_Customer.id=CRM_Follow.Customer_id),Create_date)");
            strSql.Append(" where CRM_Customer.id=" + id);

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

        public DataSet Reports_year(string items, int year, string where)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("if OBJECT_ID('Tempdb..#t') is not null ");
            strSql.Append("    drop TABLE  #t ");
            //strSql.Append("go");
            strSql.Append(" begin ");
            //strSql.Append("    --预统计表 #t");
            strSql.Append("    select ");
            strSql.Append("        " + items + ",'m'+convert(varchar,month(Create_date)) mm,count(id)tNum into #t ");
            strSql.Append("    from dbo.CRM_Customer ");
            strSql.Append("    where datediff(YEAR,[Create_date],'" + year + "-1-1')=0 and isDelete=0 ");
            if (where.Trim() != "")
            {
                strSql.Append(" and " + where);
            }
            strSql.Append("    group by " + items + ",'m'+convert(varchar,month(Create_date)) ");

            //strSql.Append("    --生成SQL");
            strSql.Append("    declare @sql varchar(8000) ");
            strSql.Append("    set @sql='select " + items + " items ' ");
            strSql.Append("    select @sql = @sql + ',sum(case mm when ' + char(39) +mm+ char(39) + ' then tNum else 0 end) ['+ mm +']' ");
            strSql.Append("        from (select distinct mm from #t)as data ");
            strSql.Append("    set @sql = @sql + ' from #t group by " + items + "' ");

            strSql.Append("    exec(@sql) ");
            strSql.Append(" end ");
            //strSql.Append("go");

            return DbHelperSQL.Query(strSql.ToString());
        }


        /// <summary>
        /// 同比环比【客户新增】
        /// </summary>
        /// <param name="dt1"></param>
        /// <param name="dt2"></param>
        /// <returns></returns>
        public DataSet Compared(string year1,string month1,string year2,string month2)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" select count(id) as yy,");
            strSql.Append(" SUM(case when YEAR( Create_date)=('" + year1 + "') and MONTH(Create_date)=('" + month1 + "') then 1 else 0 end) as dt1, ");
            strSql.Append(" SUM(case when YEAR( Create_date)=('" + year2 + "') and MONTH(Create_date)=('" + month2 + "') then 1 else 0 end) as dt2 ");
            strSql.Append(" FROM CRM_Customer WHERE isDelete=0 ");

            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 客户类型【同比环比】
        /// </summary>
        /// <param name="dt1"></param>
        /// <param name="dt2"></param>
        /// <returns></returns>
        public DataSet Compared_type(string year1, string month1, string year2, string month2)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" select CustomerType as yy,count(CustomerType) as xx,");
            strSql.Append(" SUM(case when YEAR( Create_date)=('" + year1 + "') and MONTH(Create_date)=('" + month1 + "') then 1 else 0 end) as dt1, ");
            strSql.Append(" SUM(case when YEAR( Create_date)=('" + year2 + "') and MONTH(Create_date)=('" + month2 + "') then 1 else 0 end) as dt2 ");
            strSql.Append(" FROM CRM_Customer  WHERE isDelete=0  group by CustomerType");

            return DbHelperSQL.Query(strSql.ToString());

        }

        /// <summary>
        /// 客户级别【同比环比】
        /// </summary>
        /// <param name="dt1"></param>
        /// <param name="dt2"></param>
        /// <returns></returns>
        public DataSet Compared_level(string year1, string month1, string year2, string month2)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" select CustomerLevel as yy,count(CustomerLevel) as xx,");
            strSql.Append(" SUM(case when YEAR( Create_date)=('" + year1 + "') and MONTH(Create_date)=('" + month1 + "') then 1 else 0 end) as dt1, ");
            strSql.Append(" SUM(case when YEAR( Create_date)=('" + year2 + "') and MONTH(Create_date)=('" + month2 + "') then 1 else 0 end) as dt2 ");
            strSql.Append(" FROM CRM_Customer  WHERE isDelete=0 group by CustomerLevel");

            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 客户来源【同比环比】
        /// </summary>
        /// <param name="dt1"></param>
        /// <param name="dt2"></param>
        /// <returns></returns>
        public DataSet Compared_source(string year1, string month1, string year2, string month2)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" select CustomerSource as yy,count(CustomerSource) as xx,");
            strSql.Append(" SUM(case when YEAR( Create_date)=('" + year1 + "') and MONTH(Create_date)=('" + month1 + "') then 1 else 0 end) as dt1, ");
            strSql.Append(" SUM(case when YEAR( Create_date)=('" + year2 + "') and MONTH(Create_date)=('" + month2 + "') then 1 else 0 end) as dt2 ");
            strSql.Append(" FROM CRM_Customer WHERE isDelete=0  group by CustomerSource");


            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet Compared_empcusadd(string year1,string month1,string year2,string month2, string idlist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" select hr_employee.name as yy,");
            strSql.Append(" SUM(case when YEAR( CRM_Customer.Create_date)=('" + year1 + "') and MONTH(CRM_Customer.create_date)=('" + month1 + "') then 1 else 0 end) as dt1, ");
            strSql.Append(" SUM(case when YEAR( CRM_Customer.Create_date)=('" + year2 + "') and MONTH(CRM_Customer.create_date)=('" + month2 + "') then 1 else 0 end) as dt2 ");
            strSql.Append(" FROM hr_employee left outer join  CRM_Customer ");
            strSql.Append(" on hr_employee.ID=CRM_Customer.Create_id ");
            strSql.Append(" where  CRM_Customer.isDelete=0 and hr_employee.ID in " + idlist);
            strSql.Append(" group by hr_employee.name,hr_employee.ID ");
            strSql.Append(" order by hr_employee.ID ");

            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 客户新增统计
        /// </summary>
        public DataSet report_empcus(int year, string idlist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" select name,yy,isnull([1],0) as 'm1',isnull([2],0) as 'm2',isnull([3],0) as 'm3',isnull([4],0) as 'm4',isnull([5],0) as 'm5',isnull([6],0) as 'm6',");
            strSql.Append(" isnull([7],0) as 'm7',isnull([8],0) as 'm8',isnull([9],0) as 'm9',isnull([10],0) as 'm10',isnull([11],0) as 'm11',isnull([12],0) as 'm12' ");
            strSql.Append(" from");
            strSql.Append(" (SELECT   hr_employee.ID, hr_employee.name, COUNT(derivedtbl_1.id) AS cn, YEAR(derivedtbl_1.Create_date) AS yy, ");
            strSql.Append(" MONTH(derivedtbl_1.Create_date) AS mm ");
            strSql.Append(" FROM      hr_employee LEFT OUTER JOIN");
            strSql.Append(" (SELECT '' id,userid AS Create_id,CONVERT(VARCHAR(30),LRRQ,111) Create_date ");
            strSql.Append("  FROM  dbo.KHJD_LIST_VIEW_LIST_person ");
            strSql.Append("  WHERE  (YEAR(LRRQ) = " + year + ")  GROUP BY userid ,CONVERT(VARCHAR(30),LRRQ,111)) AS derivedtbl_1 ON hr_employee.ID = derivedtbl_1.Create_id");
            strSql.Append(" WHERE hr_employee.ID in " + idlist);
            strSql.Append(" GROUP BY hr_employee.ID, hr_employee.name, YEAR(derivedtbl_1.Create_date), MONTH(derivedtbl_1.Create_date)) as tt");
            strSql.Append(" pivot");
            strSql.Append(" (sum(cn) for mm in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]))");
            strSql.Append(" as pvt");

            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// ToExcel
        /// </summary>
        public DataSet ToExcel(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" Customer as '客户',");
            strSql.Append(" address as '地址',");
            strSql.Append(" tel as '电话',");
            strSql.Append(" fax as '传真',");
            strSql.Append(" site as '网站',");
            strSql.Append(" industry as '行业',");
            strSql.Append(" Provinces as '省份',");
            strSql.Append(" City as '城市',");
            strSql.Append(" Towns as '区镇',");
            strSql.Append(" Community as '小区',");
            strSql.Append(" BNo as '楼号',");
            strSql.Append(" RNo as '房号',");
            strSql.Append(" CustomerType as '客户类型',");
            strSql.Append(" CustomerLevel as '客户级别',");
            strSql.Append(" CustomerSource as '客户来源',");
            strSql.Append(" DesCripe as '描述',");
            strSql.Append(" Remarks as '备注',");
            strSql.Append(" Department as '部门',");
            strSql.Append(" Employee as '员工',");
            strSql.Append(" privatecustomer as '公私'");
            strSql.Append(" FROM CRM_Customer ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 导入
        /// </summary>
        public bool ToImport(int emp_id,string create_name,DateTime create_date)
        {
            StringBuilder strSql0 = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            StringBuilder strSql2 = new StringBuilder();
            StringBuilder strSql3 = new StringBuilder();
            StringBuilder strSql4 = new StringBuilder();
            StringBuilder strSql5 = new StringBuilder();
            StringBuilder strSql6 = new StringBuilder();
            StringBuilder strSql7 = new StringBuilder();
            StringBuilder strSql8 = new StringBuilder();
            StringBuilder strSql9 = new StringBuilder();

            strSql0.Append("UPDATE [dbo].[CRM_Customer] SET [isDelete]=0 WHERE [isDelete] is null");
            strSql1.Append("UPDATE [dbo].[CRM_Customer] SET [industry_id] = (select top 1 id from Param_SysParam where params_name=CRM_Customer.industry and parentid=8)");
            strSql2.Append("UPDATE [dbo].[CRM_Customer] SET [CustomerType_id] = (select top 1 id from Param_SysParam where params_name=CRM_Customer.CustomerType and parentid=1)");
            strSql3.Append("UPDATE [dbo].[CRM_Customer] SET [CustomerLevel_id] = (select top 1 id from Param_SysParam where params_name=CRM_Customer.CustomerLevel and parentid=2)");
            strSql4.Append("UPDATE [dbo].[CRM_Customer] SET [CustomerSource_id] = (select top 1 id from Param_SysParam where params_name=CRM_Customer.CustomerSource and parentid=3)");
            strSql5.Append("UPDATE [dbo].[CRM_Customer] SET [Provinces_id] = (select top 1 id from Param_City where City=CRM_Customer.Provinces)");
            strSql6.Append("UPDATE [dbo].[CRM_Customer] SET [City_id] = (select top 1 id from Param_City where City=CRM_Customer.City)");
            strSql7.Append("UPDATE [dbo].[CRM_Customer] SET [Department_id] = (select top 1 id from hr_department where d_name=CRM_Customer.Department)");
            strSql8.Append("UPDATE [dbo].[CRM_Customer] SET [Employee_id] = (select top 1 ID from hr_employee where name=CRM_Customer.Employee)");
            strSql9.Append(string.Format("UPDATE [dbo].[CRM_Customer] SET Create_id={0},Create_name='{1}',Create_date='{2}' where emp_id is null ", emp_id, create_name, create_name));

            int rows0 = DbHelperSQL.ExecuteSql(strSql0.ToString());
            int rows1 = DbHelperSQL.ExecuteSql(strSql1.ToString());
            int rows2 = DbHelperSQL.ExecuteSql(strSql2.ToString());
            int rows3 = DbHelperSQL.ExecuteSql(strSql3.ToString());
            int rows4 = DbHelperSQL.ExecuteSql(strSql4.ToString());
            int rows5 = DbHelperSQL.ExecuteSql(strSql5.ToString());
            int rows7 = DbHelperSQL.ExecuteSql(strSql7.ToString());
            int rows8 = DbHelperSQL.ExecuteSql(strSql8.ToString());
            int rows6 = DbHelperSQL.ExecuteSql(strSql6.ToString());

            if (rows0 > 0 && rows1 > 0 && rows2 > 0 && rows3 > 0 && rows4 > 0 && rows5 > 0 && rows6 > 0 && rows7 > 0 && rows8 > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 统计漏斗
        /// </summary>
        public DataSet Funnel(string strWhere, string year)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" select * from ");
            strSql.Append("( ");
            strSql.Append("	select  ");
            strSql.Append("		a.params_name as CustomerType, ");
            strSql.Append("		a.id as CustomerType_id, ");
            strSql.Append("		a.params_order , ");
            strSql.Append("		COUNT(b.id) as cc  ");
            strSql.Append("	from  ");
            strSql.Append("		Param_SysParam as a left join ( ");
            strSql.Append("			select * from CRM_Customer  ");
            
            if (year.Trim() != "")
            {
                strSql.Append("			where datediff(year,Create_date,'" + year + "-01-01')=0  ");
            }
            
            strSql.Append("			)as b  ");
            strSql.Append("		on a.id = b.CustomerType_id  ");
            strSql.Append("	where a.parentid = 1 ");

            if (strWhere.Trim() != "")
            {
                strSql.Append(" and  " + strWhere);
            }

            strSql.Append("	group by  ");
            strSql.Append("		a.params_name, ");
            strSql.Append("		a.id, ");
            strSql.Append("		a.params_order ");
            strSql.Append(") as t1 ");
            strSql.Append("order by params_order ");

            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet GetMapList(string strWhere)
        {
            var strSql = new StringBuilder();
            strSql.Append("SELECT ");
            strSql.Append("     [id],[Customer],[address],[tel],[xy],[Department_id],[Employee_id]      ");
            strSql.Append("FROM [dbo].[CRM_Customer] ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }
        public DataSet GetGYSMapList(string strWhere)
        {
            var strSql = new StringBuilder();
            strSql.Append("SELECT ");
            strSql.Append("     [id],[Name],[address],[Gsdh],[xy]      ");
            strSql.Append("FROM [dbo].[CgGl_Gys_Main] ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet GetBMapList(string strWhere)
        {
            var strSql = new StringBuilder();
            strSql.Append("SELECT ");
            strSql.Append("     [id],[name],[sl],[xy]     ");
            strSql.Append("FROM [dbo].[V_building] ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }
        #endregion  Method
    }
}

