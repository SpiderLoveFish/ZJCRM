using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XHD.Common;

namespace XHD.CRM.CRM.Product
{
    public partial class Product_QrCode_Print_Style2 : System.Web.UI.Page
    {
        protected readonly int PageSize = 4;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["id"] != null && Request["id"] != "")
            {
                DataTable dt = new DataTable();
                var sb = new System.Text.StringBuilder();
                sb.AppendLine("SELECT ROW_NUMBER() OVER (ORDER BY product_id) as xh,product_id ,  ");
                sb.AppendLine("                          product_name ,  ");
                sb.AppendLine("                          category_id ,  ");
                sb.AppendLine("                          category_name ,  ");
                sb.AppendLine("                          specifications ,  ");
                sb.AppendLine("                		     unit ,  ");
                sb.AppendLine("                          remarks ,  ");
                sb.AppendLine("                          price ,t_content  ");
                sb.AppendLine("						    ,InternalPrice	  ");
                sb.AppendLine("							,Suppliers	  ");
                sb.AppendLine("							,ProModel	  ");
                sb.AppendLine("							,ProSeries	  ");
                sb.AppendLine("							,Themes,brand   ");
                sb.AppendLine("						  ,B.sys_value as CompanyName");
                sb.AppendLine("                 FROM dbo.CRM_product  A ");
                sb.AppendLine("				 INNER JOIN (SELECT sys_value FROM  dbo.sys_info WHERE sys_key ='sys_name') B ON 1=1 ");
                sb.AppendLine("WHERE product_id in (" + Request["id"] + ")  ");
               
                

                /*
                sb.AppendLine("SELECT ROW_NUMBER() OVER (ORDER BY product_id) as xh,product_id as id,product_name as name,specifications as spec  ");
                sb.AppendLine(" , category_name ");
                sb.AppendLine("INTO #product  ");
                sb.AppendLine("FROM dbo.CRM_product  ");
                sb.AppendLine("WHERE product_id in (" + Request["id"] + ")  ");
                sb.AppendLine("CREATE TABLE #qry(id1 INT,id2 INT,id3 INT,name1 VARCHAR(250),name2 VARCHAR(250),name3 VARCHAR(250),spec1 VARCHAR(250),category_name1 VARCHAR(250),spec2 VARCHAR(250),category_name2 VARCHAR(250),spec3 VARCHAR(250),category_name3 VARCHAR(250))  ");
                sb.AppendLine("INSERT INTO #qry(id1,name1,spec1,category_name1,id2,name2,spec2,category_name2,id3,name3,spec3,category_name3)  ");
                sb.AppendLine("SELECT a.id,a.name,a.spec,a.category_name,b.id,b.name,b.spec,b.category_name,c.id,c.name,c.spec ,c.category_name ");
                sb.AppendLine("FROM (  ");
                sb.AppendLine("	SELECT ROW_NUMBER() OVER(ORDER BY id) AS xh,id,name,spec,category_name  ");
                sb.AppendLine("	FROM #product  ");
                sb.AppendLine("	WHERE xh%9=1 OR xh%9=4 OR xh%9=7  ");
                sb.AppendLine("	) a  ");
                sb.AppendLine("FULL JOIN (  ");
                sb.AppendLine("	SELECT ROW_NUMBER() OVER(ORDER BY id) AS xh,id,name,spec,category_name  ");
                sb.AppendLine("	FROM #product  ");
                sb.AppendLine("	WHERE xh%9=2 OR xh%9=5 OR xh%9=8  ");
                sb.AppendLine("	) b ON a.xh=b.xh  ");
                sb.AppendLine("FULL JOIN (  ");
                sb.AppendLine("	SELECT ROW_NUMBER() OVER(ORDER BY id) AS xh,id,name,spec,category_name  ");
                sb.AppendLine("	FROM #product  ");
                sb.AppendLine("	WHERE xh%9=3 OR xh%9=6 OR xh%9=0  ");
                sb.AppendLine("	) c ON a.xh=c.xh  ");
                sb.AppendLine("SELECT * FROM #qry  ");
                 * */
  
                var rv = SqlDB.ExecuteDataTable(sb.ToString());
                if (!rv.Result)
                {
                    Response.Write(rv.Message);
                    Response.End();
                    return;
                }
                else
                    dt = rv.Output1;
                DLMain.DataSource = dt;
                DLMain.DataBind();
            }
            else
            {
                Response.Write("参数错误");
                Response.End();
            }
        }

        protected void DLMain_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            Image Image1 = (Image)e.Item.FindControl("Image1");
            
            Label lbproduct = (Label)e.Item.FindControl("lbproduct");
            
            Label lbPager = (Label)e.Item.FindControl("lbPager");
            Label lbspec = (Label)e.Item.FindControl("lbspec");
             
            Label lbcompy = (Label)e.Item.FindControl("lbcompy");//公司名称
            Label lbcp = (Label)e.Item.FindControl("lbcp");//产品

            Label lbbrand = (Label)e.Item.FindControl("lbbrand");//品牌



            string t1 = "http://" + Request.Url.Authority + "/view/product_view.aspx?pid=" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "product_id"));
            Image1.ImageUrl = "../../View/QrCodeHandler.ashx?e=M&q=Two&s=8&t=" + HttpUtility.UrlEncode(t1);
            //DataBinder.Eval(e.Item.DataItem, "id1")) + ")" + 
            lbcompy.Text = Convert.ToString(DataBinder.Eval(e.Item.DataItem, "CompanyName"));
              lbproduct.Text = "名称：" + Convert.ToString(Convert.ToString(DataBinder.Eval(e.Item.DataItem, "product_name")));
              lbspec.Text = "规格：" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "specifications"));
              lbbrand.Text = "品牌：" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "brand"));
          
            int prid1 = 0;
            try
            {
                prid1 = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "product_id"));
            }
            catch { }
            lbcp.Text = prid1.ToString("0000");
           
            //if (!string.IsNullOrWhiteSpace(Convert.ToString(DataBinder.Eval(e.Item.DataItem, "id3"))))
            //{
            //    Image3.ImageUrl = "../../View/QrCodeHandler.ashx?e=M&q=Two&s=8&t=" + HttpUtility.UrlEncode(t3);
            //    lbproduct3.Text = "名称:(" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "id3")) + ")" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "name3"));
            //    lbspec3.Text = "规格:" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "spec3"));
            //    lbcategory3.Text = "名称:" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "category_name3"));
            //}
            //else
            //    Image3.Visible = false;

            if ((e.Item.ItemIndex + 1) % PageSize != 0)
                lbPager.Text = "";
            else
                lbPager.Text = "<div class=\"nextpage\"></div>";
        }
    }
}