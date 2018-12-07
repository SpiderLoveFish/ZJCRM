 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;

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
            {
                strtype = " AND  DATENAME(month,InDate) = DATENAME(month,GETDATE())";
                strtype += " AND  DATENAME(year,InDate)= DATENAME(year,GETDATE()) ";
            }
            else if (type == "S")//当年当季
            {
                strtype = " AND DATENAME(quarter,InDate)=DATENAME(quarter,GETDATE()) ";
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
                sb.AppendLine(" WHERE 1=1  ");
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
                sb.AppendLine("WHERE   ( a.d_id <> '0' )  AND a.status='在职'");
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



        public string GetLastListFollow(string nowindex, string strwhere, string url, string serchtxt, string userid, string IsTotal)
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
            if (IsTotal == "N")
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
            sb.AppendLine(strwhere);
            if (IsTotal == "N")
            {
                sb.AppendLine(" )a");
                sb.AppendLine(" WHERE n>" + startindex);
            }
            sb.AppendLine(serchtxt);
            return sb.ToString();
        }



        public string GetLastListClassicCase(string nowindex, string strwhere, string type, string url)
        {
            var sb = new System.Text.StringBuilder();
            int startindex = int.Parse(nowindex) - 10;
            sb.AppendLine("SELECT top 10 * FROM (");
            sb.AppendLine("SELECT  row_number() OVER (ORDER BY DoTime DESC ) n ,");
            sb.AppendLine("  CASE  WHEN	params_name LIKE '%全景图%' THEN	'qjt' WHEN	 params_name LIKE '%全景放样%' THEN 'qjfy' WHEN params_name LIKE '%施工图%' THEN 'sgt' WHEN  params_name LIKE '%竣工图%' THEN 'jgt' END AS ptype ,");
            sb.AppendLine("c_title,customer_name,img_style,'" + url + "'+thum_img AS thumimg,IsStatus,URL as viewurl");
            sb.AppendLine(" FROM  dbo.Crm_Classic_case A");
            sb.AppendLine(" INNER JOIN  Param_SysParam	B ON A.img_style=B.id ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(")aa");
            sb.AppendLine(" WHERE n>" + startindex);
            if (strwhere != "")
                sb.AppendLine(" AND 1=1 ");
            if (type != "")
                sb.AppendLine(" AND ptype='"+type+"' ");
            return sb.ToString();
        }
        public string GetLastDetailClassicCase(string strwhere, string url)
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
                sb.AppendLine(" AND (cc.tel like '%" + strWhere + "%' OR B.budge_id LIKE '%" + strWhere + "%' OR a.address like '%" + strWhere + "%' or B.BudgetName like '%" + strWhere + "%')");
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
                if (str[2] != "")
                    sb.AppendLine(" AND NeedScore >=" + str[2] + " ");
                if (str[3] != "")
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

        public string GetAccountList(string strwhere)
        {
            var sb = new System.Text.StringBuilder();


            sb.AppendLine("select * from dbo.hr_employee_accounts");
            sb.AppendLine(" WHERE 1=1 ");
            if(strwhere!="")
            sb.AppendLine(" AND employeeID='"+strwhere+"'");


            return sb.ToString();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="strWhere">比如30内的</param>
        /// <param name="lx">客户还是员工</param>
        /// 
        public string getbirstring()
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("SELECT * FROM");
            sb.AppendLine("(");
            sb.AppendLine("SELECT *,");
            sb.AppendLine("CASE WHEN  datediff(day,getdate(),bir_thisyear)<0 THEN  datediff(day,getdate(),bir_nextyear) ELSE datediff(day,getdate(),bir_thisyear) END");
            sb.AppendLine(" AS ts,datediff(yy,b,bir_thisyear) AS age,  ");//年龄
            sb.AppendLine(" RIGHT(b,5) AS birthday,");
            sb.AppendLine("  CONVERT(VARCHAR(10),CASE WHEN  datediff(day,getdate(),bir_thisyear)<0 THEN  bir_nextyear  ELSE  bir_thisyear  END,120)");
            sb.AppendLine(" AS nearbir");//最近的年份生日
            sb.AppendLine(" FROM (");
            sb.AppendLine("SELECT birthday as b, rqlx,uid,");
            sb.AppendLine("birthday_lunar,ID,name AS  UserName,tel,dname as DepartmentName,address,ISNULL(title,'') AS Avatar");
            sb.AppendLine(",token as UserId,");
            sb.AppendLine("dateadd(yy,datediff(yy,bir,getdate()),bir) AS bir_thisyear");
            sb.AppendLine(",dateadd(yy,datediff(yy,bir,getdate())+1,bir) AS bir_nextyear");
            sb.AppendLine("FROM");
            sb.AppendLine("(");
            sb.AppendLine("SELECT CASE WHEN rqlx='阳历' THEN birthday ELSE");
            sb.AppendLine("LEFT(birthday,4)+RIGHT( (SELECT TOP 1 lunar FROM dbo.Lunar_Solar_List WHERE solar=CONVERT(VARCHAR(4),GETDATE(),120)+RIGHT(birthday,6)),6) ");
            sb.AppendLine("END AS bir,");
            sb.AppendLine(" *    FROM  dbo.hr_employee");
            sb.AppendLine("WHERE uid NOT IN('NoVerer','admin') AND status='在职'");
            sb.AppendLine(")AA");
            sb.AppendLine(")AAA");
            sb.AppendLine(")AAAA");
            sb.AppendLine("WHERE 1=1");
            return sb.ToString();
        }

        public string GetFinance(string type, string strwhere)
        {
            var sb = new System.Text.StringBuilder();
           var sbHead= new System.Text.StringBuilder();
            if (type == "KHMX")//明細
            {
                
                if (strwhere != "")
                    sb.AppendLine(" WHERE Customer_id=" + strwhere);
                sbHead.AppendLine(" select * from ( select * from fi_rpt_view  ");
                sbHead.AppendLine(sb.ToString());
                sbHead.AppendLine(" UNION all  ");
                sbHead.AppendLine(" select  '合计', 0, sum(a.ys) as ys, sum(a.dj) dj, sum(a.zxk)zxk, '', '', '合计', '',0, '合计'      ,'','','','','',  '' ,''  from fi_rpt_customer_view a ");
                sbHead.AppendLine(sb.ToString());
                sbHead.AppendLine("  )aa  ORDER BY create_date");
            }
            else if (type == "SZHZ")//收支汇总
            {
                string[] strs = strwhere.Split('|');
                if (strs[0] != "")
                    sb.AppendLine(" AND Community_id=" + strs[0]);
                if (!string.IsNullOrEmpty(strs[1]))
                {
                    string[] str = strs[1].Split(';');
                    if (str[0] != "")//应收未收，仅收定金
                    {
                        if (str[0] == "all") { }
                        else if (str[0] == "ysws")
                        {
                            sb.AppendLine(" and ys-dj-zxk>0 ");//lb   = '应收'
                        }//应收未收
                        else if (str[0] == "jsdj")
                        {
                            sb.AppendLine(" and (dj!=0  and ys=0 and zxk=0)  ");//  = '定金'
                        }//仅收定金
                    }
                    else
                    {
                        sb.AppendLine(" and isnull((ys) -(dj) - (zxk),0)<> 0 ");
                    }

                    if (str[1] != "")//设计师我，业务是我，监理是我
                    {
                        if (str[1] == "1")
                            sb.AppendLine(" and Emp_id_sj   = '" + str[7] + "' ");
                        if (str[1] == "2")
                            sb.AppendLine(" and Employee_id    = '" + str[7] + "' ");
                        if (str[1] == "3")
                            sb.AppendLine(" and   Emp_id_sg = '" + str[7] + "' ");

                    }

                    if (str[2] != "")
                    {
                        sb.AppendLine(" and  (Customer LIKE '%" + str[2] + "%' OR address LIKE '%" + str[2] + "%' OR tel LIKE '%" + str[2] + "%' ) ");
                    }

                    if (str[3] != "")
                        sb.AppendLine(" and create_date   >= '" + str[3] + "' ");
                    if (str[4] != "")
                        sb.AppendLine(" and  create_date    <= '" + str[4] + "' ");
                    if (str[5] != "")
                        sb.AppendLine(" and customer_create_date    >= '" + str[5] + "' ");
                    if (str[6] != "")
                        sb.AppendLine(" and  customer_create_date   <= '" + str[6] + "' ");
                    if (str[8] != "")
                    {
                        sb.AppendLine(" and Order_date    >= '" +  str[8] + "' ");
                        sb.AppendLine(" and Order_date    <= '" + str[9] + "' ");
                    }
                    else {
                        sb.AppendLine(" and convert(varchar(7),Order_date,120)=convert(varchar(7), getdate(), 120)  ");
                    }

                    //if (str[9] != "")
                    //    sb.AppendLine(" and Order_date   <= '" + str[9] + "' ");
                }
                else sb.AppendLine(" and convert(varchar(7),Order_date,120)=convert(varchar(7), getdate(), 120)  ");


                string groupby = "  group by  customer_id  ";

                sbHead.AppendLine(" select * from ( select customer_id,max(tel)tel,max(customer)customer,max(address)address,max(community)community,isnull(sum(ys),0)ys,isnull(sum(dj),0)dj,sum(zxk)zxk,isnull(sum(ys)-sum(dj)-sum(zxk),0)wsk ");
                sbHead.AppendLine(" from fi_rpt_view  where 1=1 ");
                sbHead.AppendLine(sb.ToString() + groupby);
                sbHead.AppendLine(" UNION all  ");
                sbHead.AppendLine(" select 0,'','合计','','合计',isnull(sum(ys),0)ys,isnull(sum(dj),0)dj,isnull(sum(zxk),0)zxk,isnull(sum(ys)-sum(dj)-sum(zxk),0)wsk ");
                sbHead.AppendLine(" from fi_rpt_view a where 1=1 ");
                sbHead.AppendLine(sb.ToString());
                sbHead.AppendLine("  )aa ");
            }
            else if (type == "XQMX")//小區明細
            { }
            else if (type == "XQHZ")//小區匯總
            {

                if (!string.IsNullOrEmpty(strwhere))
                {
                    string[] str = strwhere.Split(';');
                    if (str[0] != "")//应收未收，仅收定金
                    {
                        if (str[0] == "all")
                        {

                        }
                        else if (str[0] == "ysws")
                        {
                            sb.AppendLine(" and ys-dj-zxk>0 ");//lb   = '应收'
                        }//应收未收
                        else if (str[0] == "jsdj")
                        {
                            sb.AppendLine(" and (dj!=0  and ys=0 and zxk=0)  ");//  = '定金'
                        }//仅收定金
                    }
                    else {
                        sb.AppendLine(" and isnull((ys) -(dj) - (zxk),0)<> 0 ");
                    }

                    if (str[1] != "")//设计师我，业务是我，监理是我
                    {
                        if (str[1] == "1")
                            sb.AppendLine(" and Emp_id_sj   = '" + str[7] + "' ");
                        if (str[1] == "2")
                            sb.AppendLine(" and Employee_id    = '" + str[7] + "' ");
                        if (str[1] == "3")
                            sb.AppendLine(" and   Emp_id_sg = '" + str[7] + "' ");

                    }

                    if (str[2] != "")
                    {
                        sb.AppendLine(" and  (Customer LIKE '%" + str[2] + "%' OR address LIKE '%" + str[2] + "%' OR tel LIKE '%" + str[2] + "%' ) ");
                    }

                    if (str[3] != "")
                        sb.AppendLine(" and create_date   >= '" + str[3] + "' ");
                    if (str[4] != "")
                        sb.AppendLine(" and  create_date   <= '" + str[4] + "' ");
                    if (str[5] != "")
                        sb.AppendLine(" and customer_create_date    >= '" + str[5] + "' ");
                    if (str[6] != "")
                        sb.AppendLine(" and  customer_create_date   <= '" + str[6] + "' ");
                    //if (str[8] != "")
                    //{
                    //    sb.AppendLine(" and convert(varchar(10),Order_date,120)    >= '" + str[8] + "' ");
                    //    sb.AppendLine(" and convert(varchar(10),Order_date,120)    <= '" + str[9] + "' ");
                    //}

                    //if (str[9] != "")
                    //    sb.AppendLine(" and Order_date   <= '" + str[9] + "' ");
                }
                 
                //if (strwhere != "")
                //    sb.AppendLine(strwhere);
                 string groupby="  group by community,Community_id ";
                sbHead.AppendLine(" select * from ( select  Community_id, community,COUNT(*)AS sl, isnull(sum(ys),0)ys,isnull(sum(dj),0)dj,isnull(sum(zxk),0)zxk,isnull(sum(ys) - sum(dj) - sum(zxk),0)wsk ");
                sbHead.AppendLine("  from fi_rpt_customer_view  where 1=1 ");
                sbHead.AppendLine(sb.ToString()+ groupby);
                sbHead.AppendLine(" UNION all  ");
                sbHead.AppendLine(" select  0,'合计', 0, isnull(sum(a.ys),0) as ys, isnull(sum(a.dj),0) dj, isnull(sum(a.zxk),0)zxk, isnull(sum(ys) - sum(dj) - sum(zxk),0)wsk   from fi_rpt_customer_view a where 1=1");
                sbHead.AppendLine(sb.ToString());
                sbHead.AppendLine("  )aa ");
            }
            else if (type == "KHHZ")//客戶匯總
            {
                string[] strs = strwhere.Split('|');
                if (strs[0] != "")
                    sb.AppendLine(" AND Community_id="+ strs[0]);
                if (!string.IsNullOrEmpty(strs[1]))
                {
                    string[] str = strs[1].Split(';');
                    if (str[0] != "")//应收未收，仅收定金
                    {
                        if (str[0] == "all") { }
                        else if (str[0] == "ysws")
                        {
                            sb.AppendLine(" and ys-dj-zxk>0 ");//lb   = '应收'
                        }//应收未收
                        else if (str[0] == "jsdj")
                        {
                            sb.AppendLine(" and (dj!=0  and ys=0 and zxk=0)  ");//  = '定金'
                        }//仅收定金
                    }
                    else
                    {
                        sb.AppendLine(" and isnull((ys) -(dj) - (zxk),0)<> 0 ");
                    }

                    if (str[1] != "")//设计师我，业务是我，监理是我
                    {
                        if (str[1] == "1")
                            sb.AppendLine(" and Emp_id_sj   = '" + str[7] + "' ");
                        if (str[1] == "2")
                            sb.AppendLine(" and Employee_id    = '" + str[7] + "' ");
                        if (str[1] == "3")
                            sb.AppendLine(" and   Emp_id_sg = '" + str[7] + "' ");

                    }

                    if (str[2] != "")
                    {
                        sb.AppendLine(" and  (Customer LIKE '%" + str[2] + "%' OR address LIKE '%" + str[2] + "%' OR tel LIKE '%" + str[2] + "%' ) ");
                    }

                    if (str[3] != "")
                        sb.AppendLine(" and create_date   >= '" + str[3] + "' ");
                    if (str[4] != "")
                        sb.AppendLine(" and create_date   <= '" + str[4] + "' ");
                    if (str[5] != "")
                        sb.AppendLine(" and customer_create_date    >= '" + str[5] + "' ");
                    if (str[6] != "")
                        sb.AppendLine(" and  customer_create_date   <= '" + str[6] + "' ");
                    //if (str[8] != "")
                    //{
                    //    sb.AppendLine(" and convert(varchar(10),Order_date,120)    >= '" + str[8] + "' ");
                    //    sb.AppendLine(" and convert(varchar(10),Order_date,120)    <= '" + str[9] + "' ");
                    //}

                    //if (str[9] != "")
                    //    sb.AppendLine(" and Order_date   <= '" + str[9] + "' ");
                }


                string groupby = "  group by  customer_id  ";

                sbHead.AppendLine(" select * from ( select customer_id,max(tel)tel,max(customer)customer,max(address)address,max(community)community,isnull(sum(ys),0)ys,isnull(sum(dj),0)dj,sum(zxk)zxk,isnull(sum(ys)-sum(dj)-sum(zxk),0)wsk ");
                sbHead.AppendLine(" from fi_rpt_customer_view  where 1=1 ");
                sbHead.AppendLine(sb.ToString() + groupby);
                sbHead.AppendLine(" UNION all  ");
                sbHead.AppendLine(" select 0,'','合计','','合计',isnull(sum(ys),0)ys,isnull(sum(dj),0)dj,isnull(sum(zxk),0)zxk,isnull(sum(ys)-sum(dj)-sum(zxk),0)wsk ");
                sbHead.AppendLine(" from fi_rpt_customer_view a where 1=1 ");
                sbHead.AppendLine(sb.ToString());
                sbHead.AppendLine("  )aa ");
            }
           


            return sbHead.ToString();
        }
        /// <summary>
        /// 申请材料
        /// </summary>
        /// <param name="type"></param>
        /// <param name="strwhere"></param>
        /// <returns></returns>
        public string GetPurchaseList(string nowindex, string cid,string str,string id,string uid)
        {

            StringBuilder sb = new StringBuilder();
            int startindex = int.Parse(nowindex) - 10;
            sb.AppendLine("SELECT top 10 * FROM (");
            sb.AppendLine("SELECT  row_number() OVER (ORDER BY DoTime DESC ) n ,");
            sb.AppendLine("                * FROM (SELECT a.id,a.CustomerID, A.AmountSum,IsStatus,b1, A.DoTime,  ");
            sb.AppendLine("              B.product_name,B.category_name,B.specifications,B.status,B.unit ,B.isDelete,B.Delete_time,  ");
            sb.AppendLine("                B.url,B.InternalPrice ,B.Suppliers ,B.ProModel ,B.ProSeries ,  ");
            sb.AppendLine("                B.Themes,B.Brand,B.C_code,B.C_style ,c.name,ISNULL(d.pursum, 0) AS wcsl,ISNULL(e.pursum, 0) AS ztsl  ");
            sb.AppendLine("                FROM dbo.PurchaseList A   ");
            sb.AppendLine("               INNER JOIN dbo.CRM_product B ON    ");
            sb.AppendLine("               A.product_id=B.product_id AND A.category_id=B.category_id  ");
            sb.AppendLine("               inner JOIN dbo.hr_employee c ON a.DoPerson=c.ID    ");
            sb.AppendLine("             			  INNER JOIN  dbo.CRM_Customer customer ON	a.CustomerID=customer.id ");
            sb.AppendLine("                LEFT JOIN ( SELECT a.Customer_id,a.material_id,SUM(a.pursum)pursum FROM  dbo.OutStock_Detail a  ");
            sb.AppendLine("                LEFT JOIN dbo.OutStock_Main b ON a.CKID=b.CKID  ");
            sb.AppendLine("                WHERE b.isNode=3  ");
            sb.AppendLine("               GROUP BY a.Customer_id,a.material_id)d ON d.Customer_id=a.Customerid AND d.material_id=a.product_id  ");
            sb.AppendLine("               LEFT JOIN ( SELECT a.Customer_id,a.material_id,SUM(a.pursum)pursum FROM  dbo.OutStock_Detail a  ");
            sb.AppendLine("               LEFT JOIN dbo.OutStock_Main b ON a.CKID=b.CKID  ");
            sb.AppendLine("               WHERE b.isNode IN (0,1,2)  ");
            sb.AppendLine(  DataAuth(uid) );
            sb.AppendLine("               GROUP BY a.Customer_id,a.material_id)e ON e.Customer_id=a.Customerid AND e.material_id=a.product_id  ");
            sb.AppendLine("                 ");
            sb.AppendLine("               )PurchaseList   ");
            sb.AppendLine("              WHERE 1=1  ");
            sb.AppendLine("  and CustomerID="+cid+" ");
            if ( id != "")
            {
                sb.AppendLine("  and id=" + id + " ");
            }
            if (str != "")
            {
                sb.AppendLine("  and (product_name like '%" + str + "%' or specifications  like '%" + str + "%' OR  ProModel  like '%" + str + "%')");
            }
            sb.AppendLine(")aa");
            sb.AppendLine(" WHERE n>" + startindex);
            return sb.ToString();

        }



        /// <summary>
        /// 客户权限
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        private string DataAuth(string uid)
        {
            //权限
            BLL.hr_employee emp = new BLL.hr_employee();
            DataSet dsemp = emp.GetList("ID=" + int.Parse(uid));

            string returntxt = " and 1=1";
            if (dsemp.Tables[0].Rows.Count > 0)
            {
                if (dsemp.Tables[0].Rows[0]["uid"].ToString() != "admin")
                {
                    Data.GetDataAuth dataauth = new Data.GetDataAuth();
                    string txt = dataauth.GetDataAuthByid("1", "Sys_view", uid);

                    string[] arr = txt.Split(':');

                    switch (arr[0])
                    {
                        case "none":
                            returntxt = " and 1=2 ";
                            break;
                        case "my":
                            returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or  customer.Create_id=" + int.Parse(arr[1]) + ")";
                            break;
                        case "dep":
                            if (string.IsNullOrEmpty(arr[1]))
                                returntxt = " and ( privatecustomer='公客' or Employee_id=" + int.Parse(uid) + " or Emp_id_sg=" + int.Parse(uid) + " or Emp_id_sj=" + int.Parse(uid) + " or  customer.Create_id=" + int.Parse(uid) + ")";
                            else
                                returntxt = " and ( privatecustomer='公客' or Department_id=" + int.Parse(arr[1]) + " or Emp_id_sg=" + int.Parse(arr[1]) + " or Emp_id_sj=" + int.Parse(arr[1]) + " or  customer.Create_id=" + int.Parse(uid) + ")";
                            break;
                        case "depall":
                            BLL.hr_department dep = new BLL.hr_department();
                            DataSet ds = dep.GetAllList();
                            string deptask = GetDepTask(int.Parse(arr[1]), ds.Tables[0]);
                            string intext = arr[1] + "," + deptask;

                            returntxt = " and ( privatecustomer='公客' or a.Create_id=" + int.Parse(uid) + "  or Department_id in (" + intext.TrimEnd(',') + ") or Dpt_id_sg in (" + intext.TrimEnd(',') + ") or Dpt_id_sj in (" + intext.TrimEnd(',') + "))";
                            //or Create_id=32 or Department_id in (" + intext.TrimEnd(',') + " or Dpt_id_sg in (" + intext.TrimEnd(',') + " or Dpt_id_sj in (" + intext.TrimEnd(',') + ")
                            break;
                    }
                }
            }
            return returntxt;
        }

        private static string GetDepTask(int Id, DataTable table)
        {
            DataRow[] rows = table.Select("parentid=" + Id.ToString());

            if (rows.Length == 0) return string.Empty; ;
            StringBuilder str = new StringBuilder();

            foreach (DataRow row in rows)
            {
                str.Append(row["id"] + ",");
                if (GetDepTask((int)row["id"], table).Length > 0)
                    str.Append(GetDepTask((int)row["id"], table));
            }
            return str.ToString();
        }
    }
}
 