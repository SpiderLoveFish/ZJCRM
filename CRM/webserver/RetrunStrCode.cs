using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;

namespace XHD.CRM.webserver
{
    public class RetrunStrCode
    {
        /// <summary>
        /// 获取积分
        /// </summary>
        /// <returns></returns>
        public string ListSorce(string sfkh, string nowindex, string strwhere, string type)
        {
            var sb = new System.Text.StringBuilder();
            int startindex = int.Parse(nowindex) - 10;
            string strtype = "";
            
            if (type == "M")//当年当月
            { strtype = " AND  DATENAME(month,InDate) = DATENAME(month,GETDATE())";
            strtype += " AND  DATENAME(year,InDate)= DATENAME(year,GETDATE()) ";
            }
            else if (type == "S")//当年当季
            { strtype = " AND DATENAME(quarter,InDate)=DATENAME(quarter,GETDATE()) ";
            strtype += " AND  DATENAME(year,InDate)= DATENAME(year,GETDATE()) ";
            }
            else if (type == "Y")//当年
            { strtype = " AND  DATENAME(year,InDate)= DATENAME(year,GETDATE()) "; }
            else if (type == "Z")//自定义
            {
                string[] str = strwhere.Split(';');
                if (str[0] != "")
                    strtype += " AND InDate>='" + str[0] + "'";
                if (str[1] != "")
                    strtype += " AND   InDate<='" + str[1] + "'";
            }
           
                if (sfkh == "N")
                {
                    sb.AppendLine(" SELECT top 10 * FROM ( ");
                    sb.AppendLine("SELECT  row_number() OVER (ORDER BY Jf DESC ) n , a.ID ,");
                    sb.AppendLine("        a.Name ,");
                    sb.AppendLine("        a.Tel ,");
                    sb.AppendLine("        a.Sex ,");
                    sb.AppendLine("        ISNULL(b.Jf, 0) AS Jf ,");
                    sb.AppendLine("        ISNULL(b.Jf1, 0) AS Jf1 ,");
                    sb.AppendLine("        ISNULL(-b.Jf2, 0) AS Jf2 ,");
                    sb.AppendLine("        a.title");
                    sb.AppendLine("FROM    dbo.hr_employee AS a");
                    sb.AppendLine("        LEFT OUTER JOIN ( SELECT    a_1.ID ,");
                    sb.AppendLine("                                    a_1.Jf1 - ISNULL(b_1.Jf2, 0) AS Jf ,");
                    sb.AppendLine("                                    a_1.Jf1 ,");
                    sb.AppendLine("                                    b_1.Jf2");
                    sb.AppendLine("                          FROM      ( SELECT    ID ,");
                    sb.AppendLine("                                                SUM(Jf) AS Jf1");
                    sb.AppendLine("                                      FROM      dbo.CRM_Jifen");
                    sb.AppendLine(" WHERE 1=1 ");
                    sb.AppendLine("                                 AND          ( Sfkh = '" + sfkh + "' )");
                    sb.AppendLine("                                                AND ( Jflx = 0 ) ");
                    sb.AppendLine("                                                AND ( IsDel = 'N' ) ");
                    sb.AppendLine(strtype);
                    sb.AppendLine("                                      GROUP BY  ID");
                    sb.AppendLine("                                    ) AS a_1");
                    sb.AppendLine("                                    LEFT OUTER JOIN ( SELECT  ID ,");
                    sb.AppendLine("                                                              SUM(Jf) AS Jf2");
                    sb.AppendLine("                                                      FROM    dbo.CRM_Jifen AS CRM_Jifen_1");
                    sb.AppendLine("                                                      WHERE     ( Sfkh = '" + sfkh + "' )");
                    sb.AppendLine("                                                              AND ( Jflx = 1 ) ");
                    sb.AppendLine("                                                              AND ( IsDel = 'N' ) ");
                    sb.AppendLine(strtype);
                    sb.AppendLine("                                                      GROUP BY ID");
                    sb.AppendLine("                                                    ) AS b_1 ON a_1.ID = b_1.ID");
                    sb.AppendLine("                        ) AS b ON a.ID = b.ID");
                    sb.AppendLine("WHERE   ( a.d_id <> '0' )");
                    sb.AppendLine("  )AA ");
                    sb.AppendLine("WHERE n >" + startindex);
                    sb.AppendLine("          ");
                }
                else if (sfkh == "Y")
                {
                    sb.AppendLine("SELECT top 10 * FROM (");
                    sb.AppendLine("SELECT  row_number() OVER (ORDER BY Jf DESC ) n , a.ID ,");
                    sb.AppendLine("        a.Customer AS Name ,");
                    sb.AppendLine("        a.Tel ,");
                    sb.AppendLine("        a.Gender AS Sex ,");
                    sb.AppendLine("        ISNULL(b.Jf, 0) AS Jf ,");
                    sb.AppendLine("        ISNULL(b.Jf1, 0) AS Jf1 ,");
                    sb.AppendLine("        ISNULL(-b.Jf2, 0) AS Jf2 ,");
                    sb.AppendLine("        a.Provinces + a.City + a.Towns + a.Community AS Khdz");
                    sb.AppendLine("FROM    dbo.CRM_Customer a");
                    sb.AppendLine("        LEFT JOIN ( SELECT  a.ID ,");
                    sb.AppendLine("                            a.Jf1 - ISNULL(b.Jf2, 0) AS Jf ,");
                    sb.AppendLine("                            a.Jf1 ,");
                    sb.AppendLine("                            b.Jf2");
                    sb.AppendLine("                    FROM    ( SELECT    ID ,");
                    sb.AppendLine("                                        SUM(Jf) AS Jf1");
                    sb.AppendLine("                              FROM      dbo.CRM_Jifen");
                    sb.AppendLine("                              WHERE     Sfkh = 'Y'");
                    sb.AppendLine("                                        AND Jflx = 0");
                    sb.AppendLine("                                        AND IsDel = 'N'");
                    sb.AppendLine(strtype);
                    sb.AppendLine("                              GROUP BY  ID");
                    sb.AppendLine("                            ) a");
                    sb.AppendLine("                            LEFT JOIN ( SELECT  ID ,");
                    sb.AppendLine("                                                SUM(Jf) AS Jf2");
                    sb.AppendLine("                                        FROM    dbo.CRM_Jifen");
                    sb.AppendLine("                                        WHERE   Sfkh = 'Y'");
                    sb.AppendLine("                                                AND Jflx = 1");
                    sb.AppendLine("                                                AND IsDel = 'N'");
                    sb.AppendLine(strtype);
                    sb.AppendLine("                                        GROUP BY ID");
                    sb.AppendLine("                                      ) b ON a.ID = b.ID");
                    sb.AppendLine("                  ) b ON a.ID = b.ID");
                    sb.AppendLine("				  )AA");
                    sb.AppendLine("WHERE n >" + startindex);
                    sb.AppendLine("          ");
                }
            
            sb.AppendLine("");

  

         
            return sb.ToString();
        }



        public string GetLastListFollow(string nowindex, string strwhere, string url, string serchtxt, string userid,string IsTotal)
        {
        var sb = new System.Text.StringBuilder();
        int startindex = int.Parse(nowindex) - 10;
        if (!string.IsNullOrEmpty(strwhere))
        {
            string[] str = strwhere.Split(';');
            if (str[5] == "fav")
            {
                // sb.AppendLine("  LEFT JOIN Crm_Customer_Favorite B on B.customer_id=A.id and userid=" + ID);
                sb.AppendLine("  and  c.id in (select customer_id  from  Crm_Customer_Favorite where userid=" + userid + ")");

            }

            sb.AppendLine(" and c.address    like    '%" + str[0] + "%' ");
            if (str[1] != "")
                sb.AppendLine(" and Emp_id_sg   = '" + str[1] + "' ");
            if (str[2] != "")
                sb.AppendLine(" and Emp_id_sj    =    '" + str[2] + "' ");
            if (str[10] != "")
                sb.AppendLine(" and Create_id    =    '" + str[10] + "' ");
            sb.AppendLine(" and c.CustomerType_id    like    '%" + str[3] + "%' ");
            sb.AppendLine(" and c.tel    like    '%" + str[4] + "%' ");
            sb.AppendLine(" and a.employee_name    like    '%" + str[6] + "%' ");//录入人
            if (str[7] != "")
                sb.AppendLine(" and a.Follow_date >= '" + str[7] + " 00:00' ");//开始时间
            if (str[8] != "")
                sb.AppendLine(" and a.Follow_date  <=  '" + str[8] + " 23:59' ");//
            if (str[9] != "")
            {
                //sb.AppendLine(" and Customer    like    '%" + str[9] + "%' ");//姓名
                string zh = string.Format(" and ( c.Customer like N'%{0}%' or c.tel  like N'%{0}%' or c.Community like N'%{0}%' or c.address like N'%{0}%' or c.DesCripe like N'%{0}%' or c.Remarks like N'%{0}%' ) ", str[9]);
                sb.AppendLine(zh);
            }
        }
        strwhere = sb.ToString();
        sb.Clear();
        if (IsTotal=="N")
        { 
        sb.AppendLine("SELECT top 10 * FROM (");
        sb.AppendLine("SELECT  row_number() OVER (ORDER BY Follow_date DESC ) n ,");
        sb.AppendLine("CONVERT(VARCHAR(16),Follow_date,120) AS Follow_date,A.id,a.Customer_id,c.Customer+'【'+c.address+'】' AS Customer_name,a.Follow,employee_name,a.Follow_Type");
        sb.AppendLine(" ,CASE WHEN ISNULL(title,'')='' THEN '" + url + "'+'images/icons/function_icon_set/user_48.png'");
        sb.AppendLine("ELSE '" + url + "'+'images/upload/portrait/'+title  END AS Avatar");
        sb.AppendLine(",C.employee_id,C.privatecustomer,C.Create_id,C.Department_id ,Emp_id_sg,Emp_id_sj,Dpt_id_sg");
        }
        else if (IsTotal == "Y")
        {
            sb.AppendLine("SELECT COUNT(1) AS Total");
        }
        sb.AppendLine("FROM dbo.CRM_Follow A");
        sb.AppendLine("INNER JOIN dbo.hr_employee B ON A.employee_id=B.ID");
        sb.AppendLine("INNER JOIN  CRM_Customer C ON A.Customer_id=C.id");
        sb.AppendLine(" where ISNULL(A.isDelete,0)='0' ");
        sb.AppendLine(strwhere );
        if (IsTotal == "N")
        {
            sb.AppendLine(" )a");
            sb.AppendLine(" WHERE n>" + startindex);
        }
        sb.AppendLine(serchtxt);
            return sb.ToString();
        }



        public string GetLastListClassicCase(string nowindex, string strwhere,string url)
        {
            var sb = new System.Text.StringBuilder();
            int startindex = int.Parse(nowindex) - 10;
            sb.AppendLine("SELECT top 10 * FROM (");
            sb.AppendLine("SELECT  row_number() OVER (ORDER BY DoTime DESC ) n ,");
            sb.AppendLine("  CASE  WHEN	params_name LIKE '%全景图%' THEN	'qjt' WHEN	 params_name LIKE '%全景放样%' THEN 'qjfy' WHEN params_name LIKE '%施工图%' THEN 'sgt' WHEN  params_name LIKE '%竣工图%' THEN 'jgt' END AS ptype ,");
            sb.AppendLine("c_title,customer_name,img_style,'"+url+"'+thum_img AS thumimg,IsStatus");
            sb.AppendLine(" FROM  dbo.Crm_Classic_case A");
            sb.AppendLine(" INNER JOIN  Param_SysParam	B ON A.img_style=B.id ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(strwhere);
            sb.AppendLine(")aa");
            sb.AppendLine(" WHERE n>" + startindex);
            return sb.ToString();
        }
        public string GetLastDetailClassicCase( string strwhere,string url)
        {
            var sb = new System.Text.StringBuilder();
          
        
            sb.AppendLine("SELECT  ");
            sb.AppendLine("*,'" + url + "'+thum_img AS thumimg");
            sb.AppendLine(" FROM  dbo.Crm_Classic_case");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(strwhere);
     
      
            return sb.ToString();
        }

        public string GetBudge(string strWhere, string lx, string uid, string nowindex, string DataAuth)
        {
            var sb = new System.Text.StringBuilder();
            int startindex = int.Parse(nowindex) - 10;
          
            sb.AppendLine("");
            sb.AppendLine("SELECT top 10 * FROM (");
            sb.AppendLine("SELECT   row_number() OVER (ORDER BY DoTime DESC ) n , B.JJAmount,B.ZCAmount,B.FJAmount,B.DiscountAmount, B.customer_id,B.BudgetName,B.IsStatus,B.id ,");
            sb.AppendLine("      case IsStatus when '0' then '待提交'  when '1' then '待审核'  when '2' then '待确认'  when '3' then '已生效'  when '99' then '已删除' else '未知状态' end as zt,");
            sb.AppendLine("        ISNULL(b_zje, 0) AS zje ,B.DoTime,");
            sb.AppendLine("        C.b_sj ,");
            sb.AppendLine("        C.b_sl ,");
            sb.AppendLine("        B.FJAmount AS fjfy ,");
            sb.AppendLine("        A.id AS CustomerID ,");
            sb.AppendLine("        ISNULL(C.b_zkzje, 0) zkzje ,");
            sb.AppendLine("        a.tel ,");
            sb.AppendLine("        a.Customer AS CustomerName ,");
            sb.AppendLine("        a.Emp_sg AS sgjl ,");
            sb.AppendLine("        a.address ,");
            sb.AppendLine("        cc.tel AS sjstel ,");
            sb.AppendLine("        a.gender ,");
            sb.AppendLine("        a.Emp_sj AS sjs ,");
            sb.AppendLine("        a.Employee AS ywy");
            sb.AppendLine("FROM    dbo.Budge_BasicMain B");
            sb.AppendLine("        LEFT JOIN dbo.CRM_Customer a ON B.customer_id = A.id");
            sb.AppendLine("        LEFT JOIN dbo.Budge_tax C ON B.id = C.budge_id");
            sb.AppendLine("        LEFT JOIN dbo.hr_employee CC ON a.emp_id_sj = CC.[ID]");
            sb.AppendLine("        LEFT JOIN ( SELECT  SUM(rate) AS rate ,");
            sb.AppendLine("                            budge_id");
            sb.AppendLine("                    FROM    dbo.Budge_Rate_Ver");
            sb.AppendLine("                    GROUP BY budge_id");
            sb.AppendLine("                  ) D ON B.id = D.budge_id");
            sb.AppendLine("WHERE   1 = 1 AND  ISNULL(IsModel,'N')!='Y'");

            if (strWhere.Trim() != "" && lx != "search")//单独查询 
            {
                sb.AppendLine(" AND (cc.tel like '%" + strWhere + "%' OR budge_id LIKE '%" + strWhere + "%' OR a.address like '%" + strWhere + "%' or B.BudgetName like '%" + strWhere + "%')");
            }
            if (lx == "dqr")//待确认
            {
                sb.AppendLine("  and B.IsStatus in(0,1,2,3)  ");
            }
            else if (lx == "yqr")//已确认
            {
                sb.AppendLine("  and B.IsStatus in(3)  ");
            }
            else if (lx == "search")//查询
            {
                sb.AppendLine("  and B.customer_id=" + strWhere + "  ");
            }
            else if (lx == "ys_dsh")//待审核
            {
                sb.AppendLine("  and B.IsStatus in(1)  ");
            }
            else if (lx == "ys_dqr")//待确认
            {
                sb.AppendLine("  and B.IsStatus in(2)  ");
            }
            sb.AppendLine(DataAuth);
            sb.AppendLine(")AA  ");
            sb.AppendLine(" WHERE n>" + startindex);
           
 

            return sb.ToString();
        }



        public string GetLastListScoreShop(string nowindex, string strwhere, string url)
        {
            var sb = new System.Text.StringBuilder();
            int startindex = int.Parse(nowindex) - 10;
            sb.AppendLine("SELECT top 10 * FROM (");
            sb.AppendLine("SELECT  row_number() OVER (ORDER BY DoTime DESC ) n ,");
            sb.AppendLine(" * ");
            sb.AppendLine(" FROM  dbo.ScoreShop");
            sb.AppendLine(" WHERE 1=1 ");
            if (strwhere != "")
            {
                string[] str = strwhere.Split(';');
                sb.AppendLine("  and ScoreName LIKE '%" + str[0] + "%' AND ScoreDescribe LIKE '%" + str[1] + "%' ");
                if (str[2]!="")
                    sb.AppendLine(" AND NeedScore >=" + str[2] + " ");
                if(str[3]!="")
                    sb.AppendLine(" AND NeedScore <=" + str[3] + " ");   
            }
           // sb.AppendLine(strwhere);
            sb.AppendLine(")aa");
            sb.AppendLine(" WHERE n>" + startindex);
            return sb.ToString();
        }
        public string GetLastDetailScoreShop(string strwhere, string url)
        {
            var sb = new System.Text.StringBuilder();


            sb.AppendLine("SELECT  ");
            sb.AppendLine("*,'" + url + "'+ thumimg  AS thum_img");
            sb.AppendLine(" FROM  dbo.ScoreShop");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(strwhere);
         

            return sb.ToString();
        }

    }
    
}