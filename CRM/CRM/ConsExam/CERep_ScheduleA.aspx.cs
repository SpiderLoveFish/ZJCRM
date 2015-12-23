using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using XHD.BLL;

namespace XHD.CRM.CRM.ConsExam
{
    public partial class CERep_ScheduleA : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BLL.CERep_Schedule ces = new CERep_Schedule();

            string Total = "";
            DataSet ds = ces.RunProcedureView_Schedule(out Total);
            if (ds == null)
            { }
            else { 
            GridView1.DataSource=ds.Tables[0];
            GridView1.DataBind();
            }
               
        }

      

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)//判定当前的行是否属于datarow类型的行
            //{
            //    //当鼠标放上去的时候 先保存当前行的背景颜色 并给附一颜色
            //    e.Row.Attributes.Add("onmouseover", "currentcolor=this.style.backgroundColor;this.style.backgroundColor='#7f9edb',this.style.fontWeight='';");
            //    //当鼠标离开的时候 将背景颜色还原的以前的颜色
            //    e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=currentcolor,this.style.fontWeight='';");
            //}
                 if (e.Row.RowIndex >= 0)
                {
                    try
                    {
                        for (int i = 0; i <= 89; i++)
                        {
                            var cell = e.Row.Cells[i];
                            cell.Text = "";
                            string[] a = cell.Text.Split(';');

                            //cell.ForeColor = System.Drawing.Color.Blue;
                            if (a[0].Length > 0)
                                cell.BackColor = System.Drawing.Color.Blue;
                            //e.Row.Attributes.Add("style", "background-color:#" + a[0]);
                            if (a[3].Length > 0)
                                cell.Text = "★";
                        }
                    }
                    catch { }
                
             //}
                 
            }  
        }
    }
}