using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using XHD.Common;
using System.Text;
using XHD.DBUtility;

namespace XHD.CRM.Data
{
    public class C_Sys_log
    {
        public C_Sys_log() { }
        BLL.Sys_log log = new BLL.Sys_log();
        public void Add_log(int uid, string uname, string ip, string EventTitle, string EventType, int EventID, string Remind_name,string Original_txt, string Current_txt)
        {
         
            Model.Sys_log modellog = new Model.Sys_log();

            modellog.EventDate = DateTime.Now;
            modellog.UserID = uid;
            modellog.UserName = PageValidate.InputText(uname, 255);
            modellog.IPStreet = PageValidate.InputText(ip, 255);

            modellog.EventTitle = PageValidate.InputText(EventTitle, 255);

            modellog.EventType = PageValidate.InputText(EventType,255);
            modellog.EventID = EventID.ToString();
            modellog.Original_txt = "【" + PageValidate.InputText(Remind_name, 255) + "】" + PageValidate.InputText(Original_txt, int.MaxValue);
            modellog.Current_txt = "【" + PageValidate.InputText(Remind_name, 255) + "】" + PageValidate.InputText(Current_txt, int.MaxValue);

            log.Add(modellog);
        }

        /// <summary>
        /// 更新产品选择增加次数
        /// budge_qty预算选择 pur_qty采购选择 work人工选择
        /// </summary>
        /// <param name="productlist"></param>
        /// <param name="type">budge_qty预算选择 pur_qty采购选择 work人工选择</param>
        public void AddOneForProduct(string productlist,string type)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" UPDATE CRM_product SET ");
            if (type == "work") {
                sb.AppendLine(" work_qty =ISNULL(work_qty,0)+1 ,  ");
            }
            else if(type == "pur_qty") {
                sb.AppendLine(" pur_qty =ISNULL(pur_qty,0)+1  , ");
            }
            else if (type == "budge_qty")
            {
                sb.AppendLine(" budge_qty =ISNULL(budge_qty,0)+1 , ");
            }
            sb.AppendLine(" AddOneStatistics =ISNULL(AddOneStatistics,0)+1  ");
            sb.AppendLine(" WHERE product_id IN("+ productlist + ")  ");
            DbHelperSQL.ExecuteSql(sb.ToString());

        }


        public void Add_Trace(string ID,string status,string Name,string per)
        {
          
            log.add_trace(ID, status, Name, per);
        }
    }
}