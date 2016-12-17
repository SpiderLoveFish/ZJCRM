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
    public partial class budge
    {
        public budge()
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

        public int AddBJlist(int cid,string bid, string plist)
        { 
                StringBuilder strSql = new StringBuilder();
                //strSql.Append("  DELETE dbo.Budge_Para_Ver ");
                //strSql.Append(" WHERE budge_id='" + bid + "' and  ");
                //strSql.Append("   bp_name NOT IN(SELECT ComponentName FROM Budge_BasicDetail WHERE budge_id='"+bid+"')");
           strSql.Append("  INSERT INTO dbo.Budge_Para_Ver ");
           strSql.Append("  ( customer_id ,  budge_id ,versions , b_Part_id , parentid , BP_Name ) ");
        strSql.Append(" SELECT "+cid+",'"+bid+"',0,id,0,BP_Name FROM dbo.Budge_BasicPart ");
        strSql.Append(" WHERE id IN(" + plist + ") ");
        strSql.Append(" and id not in(select b_Part_id from Budge_Para_Ver where budge_id='" + bid + "' )");
        SqlParameter[] parameters = { };
            object obj = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
        if (obj == null)
        {
            return 0;
        }
        else
        {
            return Convert.ToInt32(obj);
        }
        }

        public int AddBJcopylist(string copyname, string bid, string bpid)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("INSERT INTO dbo.Budge_Para_Ver");
            sb.AppendLine("        ( customer_id ,");
            sb.AppendLine("          budge_id ,");
            sb.AppendLine("          versions ,");
            sb.AppendLine("          b_Part_id ,");
            sb.AppendLine("          parentid ,");
            sb.AppendLine("          BP_Name");
            sb.AppendLine("        )");
            sb.AppendLine(" SELECT");
            sb.AppendLine("		 customer_id ,");
            sb.AppendLine("          budge_id ,");
            sb.AppendLine("          versions ,");
            sb.AppendLine("          " + bpid + " ,");
            sb.AppendLine("          parentid ,");
            sb.AppendLine("         (SELECT BP_Name  FROM dbo.Budge_BasicPart WHERE id='" + bpid + "')  FROM  dbo.Budge_Para_Ver  A");
            sb.AppendLine("		  WHERE	 budge_id='" + bid + "' AND A.BP_Name='" + copyname + "'");
            sb.AppendLine("		  AND  A.b_Part_id NOT IN('" + bpid + "')");
            sb.AppendLine("");
            sb.AppendLine("");
            sb.AppendLine("		  INSERT INTO dbo.Budge_BasicDetail");
            sb.AppendLine("		          ( budge_id ,");
            sb.AppendLine("		            xmid ,");
            sb.AppendLine("		            ComponentID ,");
            sb.AppendLine("		            ComponentName ,");
            sb.AppendLine("		            Cname ,");
            sb.AppendLine("		            unit ,");
            sb.AppendLine("		            MmaterialPrice ,");
            sb.AppendLine("		            IsShowPrice ,");
            sb.AppendLine("		            SecmaterialPrice ,");
            sb.AppendLine("		            ArtificialPrice ,");
            sb.AppendLine("		            MechanicalLoss ,");
            sb.AppendLine("		            MaterialLoss ,");
            sb.AppendLine("		            TotalPrice ,");
            sb.AppendLine("		            IsDiscount ,");
            sb.AppendLine("		            Discount ,");
            sb.AppendLine("		            TotalDiscountPrice ,");
            sb.AppendLine("		            MaterialCost ,");
            sb.AppendLine("		            MechanicalCost ,");
            sb.AppendLine("		            ArtificialCost ,");
            sb.AppendLine("		            SUM ,");
            sb.AppendLine("		            SubTotal ,");
            sb.AppendLine("		            DiscountSubTotal ,");
            sb.AppendLine("		            Remarks ,");
            sb.AppendLine("		            zc_price ,");
            sb.AppendLine("		            fc_price ,");
            sb.AppendLine("		            rg_price");
            sb.AppendLine("		          )");
            sb.AppendLine("		  SELECT budge_id ,");
            sb.AppendLine("		            xmid ,");
            sb.AppendLine(" '" + bpid + "',");
            sb.AppendLine("		           (SELECT BP_Name  FROM dbo.Budge_BasicPart WHERE id='" + bpid + "')  ,");
            sb.AppendLine("		            Cname ,");
            sb.AppendLine("		            unit ,");
            sb.AppendLine("		            MmaterialPrice ,");
            sb.AppendLine("		            IsShowPrice ,");
            sb.AppendLine("		            SecmaterialPrice ,");
            sb.AppendLine("		            ArtificialPrice ,");
            sb.AppendLine("		            MechanicalLoss ,");
            sb.AppendLine("		            MaterialLoss ,");
            sb.AppendLine("		            TotalPrice ,");
            sb.AppendLine("		            IsDiscount ,");
            sb.AppendLine("		            Discount ,");
            sb.AppendLine("		            TotalDiscountPrice ,");
            sb.AppendLine("		            MaterialCost ,");
            sb.AppendLine("		            MechanicalCost ,");
            sb.AppendLine("		            ArtificialCost ,");
            sb.AppendLine("		            SUM ,");
            sb.AppendLine("		            SubTotal ,");
            sb.AppendLine("		            DiscountSubTotal ,");
            sb.AppendLine("		            Remarks ,");
            sb.AppendLine("		            zc_price ,");
            sb.AppendLine("		            fc_price ,");
            sb.AppendLine("		            rg_price FROM dbo.Budge_BasicDetail WHERE  budge_id='" + bid + "' AND ComponentName='" + copyname + "'");
            sb.AppendLine("					AND ComponentName NOT IN(SELECT BP_Name FROM dbo.Budge_BasicPart WHERE id=" + bpid + ")");
            sb.AppendLine("");
            sb.AppendLine(""); SqlParameter[] parameters = { };
            object obj = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
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
 
        #endregion  Method

        /// <summary>
        /// 得到最大ID
        /// </summary>
        public string GetMaxModelId()
        {
            string per = "M";
            per = per + DateTime.Now.ToString("yyMMdd-");
            string strsql = "select max(REPLACE(id,'" + per + "',''))+1 from Budge_BasicMain where id like '" + per + "%'";
            object obj = DbHelperSQL.GetSingle(strsql);
            if (obj == null)
            {
                return per + "001";
            }
            else
            {
                return per + int.Parse(obj.ToString()).ToString("000");
            }

            // return DbHelperSQL.GetMaxID("id", "CRM_CEStage");
        }

        /// <summary>
		/// 获得数据列表
		/// </summary>
		public DataSet GetIsExistModelid(string strWhere)
		{
			StringBuilder strSql=new StringBuilder();
            strSql.Append(" SELECT   model_id FROM dbo.budge_modelMain WHERE budge_id='"+strWhere+"' ");
			 
			return DbHelperSQL.Query(strSql.ToString());
		}

       
        public int AddModel(string bid,string modelid,string modelname,  int empid,string remaks)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("  INSERT INTO [dbo].[Budge_BasicMain] ");
            sb.AppendLine("  (id, ");
            sb.AppendLine("customer_id, ");
            sb.AppendLine("BudgetName, ");
            sb.AppendLine("DoPerson, ");
            sb.AppendLine("DoTime, ");
            sb.AppendLine("IsStatus, ");
            sb.AppendLine("ProjectDirectCost, ");
            sb.AppendLine("DirectCostDiscount, ");
            sb.AppendLine("AdditionalCost, ");
            sb.AppendLine("BudgetAmount, ");
            sb.AppendLine("DiscountAmount, ");
            sb.AppendLine("CostAmount, ");
            sb.AppendLine("SigningAmount, ");
            sb.AppendLine("SigningTime, ");
            sb.AppendLine("Profit, ");
            sb.AppendLine("Remarks, ");
            sb.AppendLine("Mmaterial, ");
            sb.AppendLine("MmaterialDiscount, ");
            sb.AppendLine("fbAmount, ");
            sb.AppendLine("JJAmount, ");
            sb.AppendLine("ZCAmount, ");
            sb.AppendLine("FJAmount, ");
            sb.AppendLine("DetailDiscount, ");
            sb.AppendLine("versions, ");
            sb.AppendLine("ConfirmDate, ");
            sb.AppendLine("IsModel, ");
            sb.AppendLine("ModelStyle, ");
            sb.AppendLine("OldBudgeID, ");
            sb.AppendLine("FromTimes) ");
            sb.AppendLine("  SELECT  '" + modelid + "' , ");
            sb.AppendLine("customer_id, ");
            sb.AppendLine("'" + modelname + "', ");
            sb.AppendLine("'" + empid + "', ");
            sb.AppendLine("getdate(), ");
            sb.AppendLine("IsStatus, ");
            sb.AppendLine("ProjectDirectCost, ");
            sb.AppendLine("DirectCostDiscount, ");
            sb.AppendLine("AdditionalCost, ");
            sb.AppendLine("BudgetAmount, ");
            sb.AppendLine("DiscountAmount, ");
            sb.AppendLine("CostAmount, ");
            sb.AppendLine("SigningAmount, ");
            sb.AppendLine("SigningTime, ");
            sb.AppendLine("Profit, ");
            sb.AppendLine("'" + remaks + "', ");
            sb.AppendLine("Mmaterial, ");
            sb.AppendLine("MmaterialDiscount, ");
            sb.AppendLine("fbAmount, ");
            sb.AppendLine("JJAmount, ");
            sb.AppendLine("ZCAmount, ");
            sb.AppendLine("FJAmount, ");
            sb.AppendLine("DetailDiscount, ");
            sb.AppendLine("versions, ");
            sb.AppendLine("getdate(), ");
            sb.AppendLine("'Y', ");
            sb.AppendLine("ModelStyle, ");
            sb.AppendLine("id, ");
            sb.AppendLine("FromTimes  ");
            sb.AppendLine(" from [dbo].[Budge_BasicMain] WHERE id='" + bid + "'  ");

            sb.AppendLine("  INSERT INTO [dbo].[Budge_BasicDetail]");
            sb.AppendLine("  ( ");
            sb.AppendLine("budge_id, ");
            sb.AppendLine("xmid, ");
	    sb.AppendLine("Componentid, ");
            sb.AppendLine("ComponentName, ");
            sb.AppendLine("Cname, ");
            sb.AppendLine("unit, ");
            sb.AppendLine("MmaterialPrice, ");
            sb.AppendLine("IsShowPrice, ");
            sb.AppendLine("SecmaterialPrice, ");
            sb.AppendLine("ArtificialPrice, ");
            sb.AppendLine("MechanicalLoss, ");
            sb.AppendLine("MaterialLoss, ");
            sb.AppendLine("TotalPrice, ");
            sb.AppendLine("IsDiscount, ");
            sb.AppendLine("Discount, ");
            sb.AppendLine("TotalDiscountPrice, ");
            sb.AppendLine("MaterialCost, ");
            sb.AppendLine("MechanicalCost, ");
            sb.AppendLine("ArtificialCost, ");
            sb.AppendLine("SUM, ");
            sb.AppendLine("SubTotal, ");
            sb.AppendLine("DiscountSubTotal, ");
            sb.AppendLine("Remarks, ");
            sb.AppendLine("zc_price, ");
            sb.AppendLine("fc_price, ");
            sb.AppendLine("rg_price) ");
            sb.AppendLine(" SELECT ");
            sb.AppendLine("'"+modelid+"', ");
            sb.AppendLine("xmid, ");
	    sb.AppendLine("Componentid, ");
            sb.AppendLine("ComponentName, ");
            sb.AppendLine("Cname, ");
            sb.AppendLine("unit, ");
            sb.AppendLine("MmaterialPrice, ");
            sb.AppendLine("IsShowPrice, ");
            sb.AppendLine("SecmaterialPrice, ");
            sb.AppendLine("ArtificialPrice, ");
            sb.AppendLine("MechanicalLoss, ");
            sb.AppendLine("MaterialLoss, ");
            sb.AppendLine("TotalPrice, ");
            sb.AppendLine("IsDiscount, ");
            sb.AppendLine("Discount, ");
            sb.AppendLine("TotalDiscountPrice, ");
            sb.AppendLine("MaterialCost, ");
            sb.AppendLine("MechanicalCost, ");
            sb.AppendLine("ArtificialCost, ");
            sb.AppendLine("SUM, ");
            sb.AppendLine("SubTotal, ");
            sb.AppendLine("DiscountSubTotal, ");
            sb.AppendLine("Remarks, ");
            sb.AppendLine("zc_price, ");
            sb.AppendLine("fc_price, ");
            sb.AppendLine("rg_price ");
            sb.AppendLine(" FROM [dbo].[Budge_BasicDetail] WHERE budge_id='" + bid + "' ");

            sb.AppendLine("  INSERT INTO [dbo].[Budge_Rate_Ver]");
            sb.AppendLine("  (");
            sb.AppendLine("rateid, ");
            sb.AppendLine("budge_id, ");
            sb.AppendLine("RateName, ");
            sb.AppendLine("measure, ");
            sb.AppendLine("rate, ");
            sb.AppendLine("RateAmount, ");
            sb.AppendLine("Remarks) ");
            sb.AppendLine(" SELECT ");
            sb.AppendLine("rateid, ");
            sb.AppendLine("'"+modelid+"', ");
            sb.AppendLine("RateName, ");
            sb.AppendLine("measure, ");
            sb.AppendLine("rate, ");
            sb.AppendLine("RateAmount, ");
            sb.AppendLine("Remarks ");
            sb.AppendLine(" FROM [dbo].[Budge_Rate_Ver] WHERE budge_id='" + bid + "' ");

            sb.AppendLine("  INSERT INTO [dbo].[Budge_tax]");
            sb.AppendLine("  (");
            sb.AppendLine("budge_id, ");
            sb.AppendLine("b_sl, ");
            sb.AppendLine("b_sj, ");
            sb.AppendLine("b_zje, ");
            sb.AppendLine("remarks, ");
            sb.AppendLine("b_zkzje) ");
            sb.AppendLine(" SELECT ");
            sb.AppendLine("'"+modelid+"', ");
            sb.AppendLine("b_sl, ");
            sb.AppendLine("b_sj, ");
            sb.AppendLine("b_zje, ");
            sb.AppendLine("remarks, ");
            sb.AppendLine("b_zkzje ");
            sb.AppendLine(" FROM [dbo].[Budge_tax] WHERE budge_id='" + bid + "' ");


            //sb.AppendLine(";select @@IDENTITY");
            SqlParameter[] parameters = { };

            object obj = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

        public int AddModelToBudge(string bid, string modelid)
        {
            var sb = new System.Text.StringBuilder();

            sb.Append("  DELETE	Budge_BasicDetail WHERE budge_id='" + bid + "'  ");
            sb.Append(" DELETE Budge_Rate_Ver WHERE budge_id='" + bid + "' ");
            sb.Append(" DELETE Budge_Para_Ver WHERE budge_id='" + bid + "' ");

           //修改类型
            sb.AppendLine("UPDATE Budge_BasicMain SET ModelStyle=( SELECT  SUBSTRING(ISNULL(ModelStyle,'常规预算'),0,3)+'预算' FROM dbo.Budge_BasicMain	");
            sb.AppendLine(" WHERE	 id='" + modelid + "')");
            sb.AppendLine(" WHERE	 id='" + bid + "'");

            sb.AppendLine(" UPDATE	Budge_BasicMain	SET	FromTimes=ISNULL(FromTimes,0)+1");
            sb.AppendLine(" WHERE	 id='" + modelid + "'");

            sb.AppendLine("  INSERT INTO [dbo].[Budge_BasicDetail]");
            sb.AppendLine("  ( ");
            sb.AppendLine("budge_id, ");
            sb.AppendLine("xmid, ");
	sb.AppendLine("Componentid, ");
            sb.AppendLine("ComponentName, ");
            sb.AppendLine("Cname, ");
            sb.AppendLine("unit, ");
            sb.AppendLine("MmaterialPrice, ");
            sb.AppendLine("IsShowPrice, ");
            sb.AppendLine("SecmaterialPrice, ");
            sb.AppendLine("ArtificialPrice, ");
            sb.AppendLine("MechanicalLoss, ");
            sb.AppendLine("MaterialLoss, ");
            sb.AppendLine("TotalPrice, ");
            sb.AppendLine("IsDiscount, ");
            sb.AppendLine("Discount, ");
            sb.AppendLine("TotalDiscountPrice, ");
            sb.AppendLine("MaterialCost, ");
            sb.AppendLine("MechanicalCost, ");
            sb.AppendLine("ArtificialCost, ");
            sb.AppendLine("SUM, ");
            sb.AppendLine("SubTotal, ");
            sb.AppendLine("DiscountSubTotal, ");
            sb.AppendLine("Remarks, ");
            sb.AppendLine("zc_price, ");
            sb.AppendLine("fc_price, ");
            sb.AppendLine("rg_price,OrderBy) ");
            sb.AppendLine(" SELECT ");
            sb.AppendLine("'" + bid + "', ");
            sb.AppendLine("xmid, ");
	sb.AppendLine("Componentid, ");
            sb.AppendLine("ComponentName, ");
            sb.AppendLine("Cname, ");
            sb.AppendLine("unit, ");
            sb.AppendLine("MmaterialPrice, ");
            sb.AppendLine("IsShowPrice, ");
            sb.AppendLine("SecmaterialPrice, ");
            sb.AppendLine("ArtificialPrice, ");
            sb.AppendLine("MechanicalLoss, ");
            sb.AppendLine("MaterialLoss, ");
            sb.AppendLine("TotalPrice, ");
            sb.AppendLine("IsDiscount, ");
            sb.AppendLine("Discount, ");
            sb.AppendLine("TotalDiscountPrice, ");
            sb.AppendLine("MaterialCost, ");
            sb.AppendLine("MechanicalCost, ");
            sb.AppendLine("ArtificialCost, ");
            sb.AppendLine("SUM, ");
            sb.AppendLine("SubTotal, ");
            sb.AppendLine("DiscountSubTotal, ");
            sb.AppendLine("Remarks, ");
            sb.AppendLine("zc_price, ");
            sb.AppendLine("fc_price, ");
            sb.AppendLine("rg_price,OrderBy ");
            sb.AppendLine(" FROM [dbo].[Budge_BasicDetail] WHERE budge_id='" + modelid + "' ");

            sb.AppendLine("  INSERT INTO [dbo].[Budge_Rate_Ver]");
            sb.AppendLine("  (");
            sb.AppendLine("rateid, ");
            sb.AppendLine("budge_id, ");
            sb.AppendLine("RateName, ");
            sb.AppendLine("measure, ");
            sb.AppendLine("rate, ");
            sb.AppendLine("RateAmount, ");
            sb.AppendLine("Remarks) ");
            sb.AppendLine(" SELECT ");
            sb.AppendLine("rateid, ");
            sb.AppendLine("'" + bid + "', ");
            sb.AppendLine("RateName, ");
            sb.AppendLine("measure, ");
            sb.AppendLine("rate, ");
            sb.AppendLine("RateAmount, ");
            sb.AppendLine("Remarks ");
            sb.AppendLine(" FROM [dbo].[Budge_Rate_Ver] WHERE budge_id='" + modelid + "' ");

            sb.AppendLine("  INSERT INTO [dbo].[Budge_tax]");
            sb.AppendLine("  (");
            sb.AppendLine("budge_id, ");
            sb.AppendLine("b_sl, ");
            sb.AppendLine("b_sj, ");
            sb.AppendLine("b_zje, ");
            sb.AppendLine("remarks, ");
            sb.AppendLine("b_zkzje) ");
            sb.AppendLine(" SELECT ");
            sb.AppendLine("'" + bid + "', ");
            sb.AppendLine("b_sl, ");
            sb.AppendLine("b_sj, ");
            sb.AppendLine("b_zje, ");
            sb.AppendLine("remarks, ");
            sb.AppendLine("b_zkzje ");
            sb.AppendLine(" FROM [dbo].[Budge_tax] WHERE budge_id='" + modelid + "' ");
        
            sb.AppendLine("INSERT INTO dbo.Budge_Para_Ver");
            sb.AppendLine("        ( customer_id ,");
            sb.AppendLine("          budge_id ,");
            sb.AppendLine("          versions ,");
            sb.AppendLine("          b_Part_id ,");
            sb.AppendLine("          parentid ,");
            sb.AppendLine("          BP_Name");
            sb.AppendLine("        )");
            sb.AppendLine(" SELECT customer_id ,");
            sb.AppendLine("          '" + bid + "' ,");
            sb.AppendLine("          versions ,");
            sb.AppendLine("          b_Part_id ,");
            sb.AppendLine("          parentid ,");
            sb.AppendLine("          BP_Name FROM dbo.Budge_Para_Ver");
            sb.AppendLine("		  WHERE	budge_id='" + modelid + "'");

            //sb.AppendLine(";select @@IDENTITY");
            SqlParameter[] parameters = { };

            object obj = DbHelperSQL.ExecuteSql(sb.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

        public int AddModelToBudge_bak(string bid, string modelid)
        {
            StringBuilder strSql = new StringBuilder();

            strSql.Append("  DELETE	Budge_BasicDetail WHERE budge_id='" + bid + "'  ");
            strSql.Append(" DELETE Budge_Para_Ver WHERE budge_id='" + bid + "' ");

            strSql.Append(" INSERT INTO  dbo.Budge_BasicDetail ");
            strSql.Append("     (    budge_id , xmid , Componentid ,ComponentName ,Cname ,unit , MmaterialPrice , ");
            strSql.Append("       IsShowPrice , SecmaterialPrice ,ArtificialPrice , MechanicalLoss , MaterialLoss , ");
            strSql.Append("        TotalPrice ,IsDiscount ,Discount,TotalDiscountPrice , MaterialCost , MechanicalCost , ");
            strSql.Append("       ArtificialCost , SUM , Remarks ");
            strSql.Append("    ) ");
            strSql.Append("  SELECT    '" + bid + "' , xmid , Componentid ,ComponentName ,Cname ,unit , MmaterialPrice , ");
            strSql.Append("     IsShowPrice , SecmaterialPrice ,ArtificialPrice , MechanicalLoss , MaterialLoss , ");
            strSql.Append("     TotalPrice ,IsDiscount ,Discount,TotalDiscountPrice , MaterialCost , MechanicalCost ,");
            strSql.Append("    ArtificialCost , SUM , Remarks FROM Budge_Model  ");
            strSql.Append("   WHERE model_id='" + modelid + "' ");
            strSql.Append("  INSERT INTO dbo.Budge_Para_Ver");
            strSql.Append("    ( customer_id , budge_id  , versions , b_Part_id ,parentid , BP_Name) ");
            strSql.Append("  SELECT  customer_id , '" + bid + "' , versions , b_Part_id ,parentid , BP_Name ");
            strSql.Append(" FROM Budge_Para_Model  ");
            strSql.Append("  WHERE model_id='" + modelid + "'");
            SqlParameter[] parameters = { };

            object obj = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

        public int copybudge(string copyid, string maxid, string userid, string newcustomerid, string newcustomername)
        {
            StringBuilder strSql = new StringBuilder();
           
            strSql.Append(" INSERT INTO  dbo.Budge_BasicDetail ");
            strSql.Append("     (    budge_id , xmid , Componentid,ComponentName ,Cname ,unit , MmaterialPrice , ");
            strSql.Append("       IsShowPrice , SecmaterialPrice ,ArtificialPrice , MechanicalLoss , MaterialLoss , ");
            strSql.Append("        TotalPrice ,IsDiscount ,Discount,TotalDiscountPrice , MaterialCost , MechanicalCost , ");
            strSql.Append("       ArtificialCost , SUM , Remarks ");
            strSql.Append("    ) ");
            strSql.Append("  SELECT    '" + maxid + "' , xmid ,Componentid,ComponentName ,Cname ,unit , MmaterialPrice , ");
            strSql.Append("     IsShowPrice , SecmaterialPrice ,ArtificialPrice , MechanicalLoss , MaterialLoss , ");
            strSql.Append("     TotalPrice ,IsDiscount ,Discount,TotalDiscountPrice , MaterialCost , MechanicalCost ,");
            strSql.Append("    ArtificialCost , SUM , Remarks FROM Budge_BasicDetail  ");
            strSql.Append("   WHERE budge_id='" + copyid + "' ");
            strSql.Append("  INSERT INTO dbo.Budge_Para_Ver");
            strSql.Append("    ( customer_id , budge_id  , versions , b_Part_id ,parentid , BP_Name) ");
            strSql.Append("  SELECT  customer_id , '" + maxid + "' , versions , b_Part_id ,parentid , BP_Name ");
            strSql.Append(" FROM Budge_Para_Ver  ");
            strSql.Append("  WHERE budge_id='" + copyid + "'");

            strSql.Append("INSERT INTO dbo.Budge_BasicMain");
            strSql.Append("        ( id , customer_id , BudgetName , DoPerson ,DoTime , IsStatus ,");
            strSql.Append(" ProjectDirectCost ,");
            strSql.Append("          DirectCostDiscount ,");
            strSql.Append("          AdditionalCost ,");
            strSql.Append("          BudgetAmount ,");
            strSql.Append("          DiscountAmount ,");
            strSql.Append("          CostAmount ,");
            strSql.Append("          SigningAmount ,");
            strSql.Append("          SigningTime ,");
            strSql.Append("          Profit ,");
            strSql.Append("          Remarks ,");
            strSql.Append("          Mmaterial ,");
            strSql.Append("          MmaterialDiscount ,");
            strSql.Append("          fbAmount ,");
            strSql.Append("          JJAmount ,");
            strSql.Append("          ZCAmount ,");
            strSql.Append("          FJAmount ,");
            strSql.Append("          DetailDiscount ,");
            strSql.Append("          versions");
            strSql.Append("        )");
            strSql.Append("  SELECT '" + maxid + "' ,");
            strSql.Append("          " + newcustomerid + " ,");
            strSql.Append("          '" + newcustomername + "' ,");
            strSql.Append("          '" + userid + "' ,");
            strSql.Append("          GETDATE() ,");
            strSql.Append("          0 ,");
            strSql.Append("          ProjectDirectCost ,");
            strSql.Append("          DirectCostDiscount ,");
            strSql.Append("          AdditionalCost ,");
            strSql.Append("          BudgetAmount ,");
            strSql.Append("          DiscountAmount ,");
            strSql.Append("          CostAmount ,");
            strSql.Append("          SigningAmount ,");
            strSql.Append("          SigningTime ,");
            strSql.Append("          Profit ,");
            strSql.Append("          Remarks ,");
            strSql.Append("          Mmaterial ,");
            strSql.Append("          MmaterialDiscount ,");
            strSql.Append("          fbAmount ,");
            strSql.Append("          JJAmount ,");
            strSql.Append("          ZCAmount ,");
            strSql.Append("          FJAmount ,");
            strSql.Append("          DetailDiscount ,");
            strSql.Append("          versions  FROM Budge_BasicMain where id='" + copyid + "' ");

            SqlParameter[] parameters = { };

            object obj = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
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
        /// 分页获取数据列表
        /// </summary>
        public DataSet Getbudge_modelMain(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + "  A.*,B.name FROM dbo.budge_modelMain A INNER JOIN dbo.hr_employee B ON	 A.DoPerson=B.id ");
            strSql.Append("  left join Budge_BasicMain C on A.budge_id=C.id");
            strSql.Append("  left join CRM_Customer D on C.customer_id=D.id");
            strSql.Append(" WHERE A.id not in ( SELECT top " + (PageIndex - 1) * PageSize + " A.id FROM budge_modelMain A");
            strSql.Append("  left join Budge_BasicMain C on A.budge_id=C.id");
            strSql.Append("  left join CRM_Customer D on C.customer_id=D.id");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(A.id) FROM budge_modelMain A ");
            strSql1.Append("  left join Budge_BasicMain C on A.budge_id=C.id");
            strSql1.Append("  left join CRM_Customer D on C.customer_id=D.id");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }

        public int updatetotal(string bid,decimal sl)
        {
            SqlParameter[] parameters = {
					new SqlParameter("@bid", SqlDbType.VarChar,50),
					new SqlParameter("@tax", SqlDbType.Decimal,10) 
                                     };
            parameters[0].Value = bid;
            parameters[1].Value = sl; 
            int rowaffected = 0;
            DbHelperSQL.RunProcedure("Usp_Update_TAX", parameters, out rowaffected);
            return rowaffected;
        }


        public int updateAll(string bid,decimal zk, decimal sl)
        {
            SqlParameter[] parameters = {
					new SqlParameter("@bid", SqlDbType.VarChar,50),
                   new SqlParameter("@zk", SqlDbType.Decimal,10) ,
					new SqlParameter("@tax", SqlDbType.Decimal,10) 
                                     };
            parameters[0].Value = bid;
            parameters[1].Value = zk;
            parameters[2].Value = sl;

            int rowaffected = 0;
            DbHelperSQL.RunProcedure("Usp_Update_Budge_ALL", parameters, out rowaffected);
            return rowaffected;
        }


        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetTax(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" SELECT * FROM Budge_tax WHERE budge_id='" + strWhere + "' ");

            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetBudge_Rate(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM dbo.Budge_Rate ");
            strSql.Append(" WHERE  id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM Budge_Rate ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM Budge_Rate ");
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
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetBudge_Rate_Ver(int PageSize, int PageIndex, string strWhere, string filedOrder, out string Total)
        {
            StringBuilder strSql = new StringBuilder();
            StringBuilder strSql1 = new StringBuilder();
            strSql.Append("select ");
            strSql.Append(" top " + PageSize + " * FROM dbo.Budge_Rate_Ver ");
            strSql.Append(" WHERE id not in ( SELECT top " + (PageIndex - 1) * PageSize + " id FROM Budge_Rate_Ver ");
            strSql.Append(" where " + strWhere + " order by " + filedOrder + " ) ");
            strSql1.Append(" select count(id) FROM Budge_Rate_Ver ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" and " + strWhere);
                strSql1.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            Total = DbHelperSQL.Query(strSql1.ToString()).Tables[0].Rows[0][0].ToString();
            return DbHelperSQL.Query(strSql.ToString());
        }

        public int insertRatelist(string bid, string xmlistid)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("  INSERT INTO Budge_Rate_Ver ");
            strSql.Append("   (rateid, budge_id , RateName , measure , rate ,Remarks) ");
            strSql.Append(" SELECT id, '" + bid + "' , RateName , measure , rate ,Remarks FROM dbo.Budge_Rate WHERE id IN(" + xmlistid + ") ");

            SqlParameter[] parameters = { };
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
        /// 删除一条数据
        /// </summary>
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

