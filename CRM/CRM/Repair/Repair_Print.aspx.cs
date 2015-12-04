using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XHD.Common;

namespace XHD.CRM.CRM.Repair
{
    public partial class Repair_Print : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["rid"] != null)
            {
                lbTitle.Text = Caches.sys_info.Select("sys_key='sys_name'")[0]["sys_value"].ToString() + "维修安排单";
                lbCpy.Text = Caches.sys_info.Select("sys_key='sys_name'")[0]["sys_value"].ToString();
                DataRow[] dr1 = Caches.CRM_Repair.Select("RepairID='" + Request["rid"].ToString() + "'");
                if (dr1.Length > 0)
                {
                    lbRepairID.Text = dr1[0]["RepairID"].ToString().PadLeft(4, '0');
                    lbWxrq.Text = dr1[0]["Wxrq"].ToString();
                    lbWxry.Text = dr1[0]["WxEmpName"].ToString();
                    lbKhmc.Text = dr1[0]["Khmc"].ToString();
                    lbKhdh.Text = dr1[0]["Khdh"].ToString();
                    lbKhxq.Text = dr1[0]["Khxq"].ToString();
                    lbWxyy.Text = dr1[0]["Wxyy"].ToString().Replace("\n", "<br/>");
                }

                DataRow[] dr2 = Caches.CRM_Repair_Follow.Select("RepairID='" + Request["rid"].ToString() + "'");
                for (int i = 0; i < dr2.Length; i++)
                    lbGjxx.Text += (i + 1).ToString() + "、" + dr2[i]["FollowContent"].ToString() + "-" + dr2[i]["InEmpName"].ToString() + "<br/>";
            }
        }
    }
}