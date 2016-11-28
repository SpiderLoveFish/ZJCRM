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
            if (type == "M")//当月
            { strtype = " AND  DATENAME(month,InDate) = DATENAME(month,GETDATE())"; }
            else if (type == "S")//当季
            { strtype = " AND DATENAME(quarter,InDate)=DATENAME(quarter,GETDATE()) "; }
            else if (type == "Y")//当年
            { strtype = " AND  DATENAME(year,InDate)= DATENAME(year,GETDATE()) "; }
            else if (type == "Z")//自定义
            {
                string[] str = strwhere.Split(';');
                if (str[0] != "")
                    strtype += " AND InDate>='" + str[0] + "'";
                if (str[1] != "")
                    strtype += " AND AND InDate<='" + str[1] + "'";
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
                sb.AppendLine("SELECT * FROM (");
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



        public string GetLastListFollow( string nowindex, string strwhere)
        {
        var sb = new System.Text.StringBuilder();
        int startindex = int.Parse(nowindex) - 10;
            sb.AppendLine("SELECT * FROM (");
            sb.AppendLine("SELECT  row_number() OVER (ORDER BY Follow_date DESC ) n , id,Customer_id,Customer_name,Follow,Follow_date,Follow_Type_id,Follow_Type,employee_name");
            sb.AppendLine(" FROM");
            sb.AppendLine("dbo.CRM_Follow");
            sb.AppendLine(" WHERE	ISNULL(isDelete,0)=0 ");
            sb.AppendLine(strwhere);
            sb.AppendLine("  )AA");
            sb.AppendLine(" WHERE n>" + startindex);
            return sb.ToString();
        }

    }
    
}