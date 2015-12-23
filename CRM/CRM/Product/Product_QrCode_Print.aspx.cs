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
    public partial class Product_QrCode_Print : System.Web.UI.Page
    {
        protected readonly int PageSize = 2;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["id"] != null && Request["id"] != "")
            {
                DataTable dt = new DataTable();
                var sb = new System.Text.StringBuilder();
                //sb.AppendLine("SELECT ROW_NUMBER() OVER (ORDER BY product_id) as xh,product_id ,  ");
                //sb.AppendLine("                          product_name ,  ");
                //sb.AppendLine("                          category_id ,  ");
                //sb.AppendLine("                          category_name ,  ");
                //sb.AppendLine("                          specifications ,  ");
                //sb.AppendLine("                		     unit ,  ");
                //sb.AppendLine("                          remarks ,  ");
                //sb.AppendLine("                          price ,t_content  ");
                //sb.AppendLine("						    ,InternalPrice	  ");
                //sb.AppendLine("							,Suppliers	  ");
                //sb.AppendLine("							,ProModel	  ");
                //sb.AppendLine("							,ProSeries	  ");
                //sb.AppendLine("							,Themes,brand   ");
                //sb.AppendLine("						  ,B.sys_value as CompanyName");
                //sb.AppendLine("                 FROM dbo.CRM_product  A ");
                //sb.AppendLine("				 INNER JOIN (SELECT sys_value FROM  dbo.sys_info WHERE sys_key ='sys_name') B ON 1=1 ");
                //sb.AppendLine("WHERE product_id in (" + Request["id"] + ")  ");
               
                

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

                sb.AppendLine("EXEC Usp_PrintDataQr ' WHERE product_id in (" + Request["id"] + ")'  ");
               
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
            Image Image2 = (Image)e.Item.FindControl("Image2");
            //Image Image3 = (Image)e.Item.FindControl("Image3");
            Label lbproduct1 = (Label)e.Item.FindControl("lbproduct1");
            Label lbproduct2 = (Label)e.Item.FindControl("lbproduct2");
            //Label lbproduct3 = (Label)e.Item.FindControl("lbproduct3");
            Label lbcategory1 = (Label)e.Item.FindControl("lbcategory1");
            Label lbcategory2 = (Label)e.Item.FindControl("lbcategory2");
            //Label lbcategory3 = (Label)e.Item.FindControl("lbcategory3");
            Label lbPager = (Label)e.Item.FindControl("lbPager");
            Label lbspec1 = (Label)e.Item.FindControl("lbspec1");
            Label lbspec2 = (Label)e.Item.FindControl("lbspec2");
            Label lbcompy1 = (Label)e.Item.FindControl("lbcompy1");//公司名称
            Label lbcompy2 = (Label)e.Item.FindControl("lbcompy2");//公司名称
            Label lbtc1 = (Label)e.Item.FindControl("lbtc1");//套餐
            Label lbxl1 = (Label)e.Item.FindControl("lbxl1");//系列
            Label lbxh1 = (Label)e.Item.FindControl("lbxh1");//型号
            Label lbtc2 = (Label)e.Item.FindControl("lbtc2");//套餐
            Label lbxl2 = (Label)e.Item.FindControl("lbxl2");//系列
            Label lbxh2 = (Label)e.Item.FindControl("lbxh2");//型号
            Label lbremarks1 = (Label)e.Item.FindControl("lbremarks1");//规格
            Label lbprice1 = (Label)e.Item.FindControl("lbprice1");//规格
            Label lbsys1  =(Label)e.Item.FindControl("lbsys1");//少一勺
            Label lbremarks2 = (Label)e.Item.FindControl("lbremarks2");//规格
            Label lbprice2 = (Label)e.Item.FindControl("lbprice2");//规格
            Label lbsys2 = (Label)e.Item.FindControl("lbsys2");//少一勺
            Panel p2 = (Panel)e.Item.FindControl("p2");

            string t1 = "http://" + Request.Url.Authority + "/view/product_view.aspx?pid=" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "id1"));
            string t2 = "http://" + Request.Url.Authority + "/view/product_view.aspx?pid=" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "id2"));
            //string t3 = "http://" + Request.Url.Authority + "/view/product_view.aspx?pid=" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "id3"));
            //lbgg.Text = "规格：800*800";
            Image1.ImageUrl = "../../View/QrCodeHandler.ashx?e=M&q=Two&s=8&t=" + HttpUtility.UrlEncode(t1);
            //DataBinder.Eval(e.Item.DataItem, "id1")) + ")" + 
            lbcompy1.Text = Convert.ToString(DataBinder.Eval(e.Item.DataItem, "CompanyName1"));
            lbtc1.Text = Convert.ToString(DataBinder.Eval(e.Item.DataItem, "Themes1"));
            lbproduct1.Text = "名称：" + Convert.ToString(Convert.ToString(DataBinder.Eval(e.Item.DataItem, "product_name1")));
            lbspec1.Text = "规格：" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "specifications1"));
            lbxh1.Text = "型号：" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "ProModel1")); ;
            lbcategory1.Text = "品牌：" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "brand1"));
            lbxl1.Text = "系列：" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "ProSeries1")); 
            //单价：105元/平方米
            lbprice1.Text = "价格：" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "price1")) +"元/"+ Convert.ToString(DataBinder.Eval(e.Item.DataItem, "unit1"));
            lbremarks1.Text = "备注："+Convert.ToString(DataBinder.Eval(e.Item.DataItem, "remarks1"));
            int prid1 = 0;
            try
            {
                prid1 = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "id1"));
            }
            catch { }
             
                string code1 = Convert.ToString(DataBinder.Eval(e.Item.DataItem, "C_code1"));
            if(code1=="")
                lbsys1.Text = prid1.ToString("0000");
            else
                lbsys1.Text = code1.ToString().PadLeft(4, '0');
            //int d2 = 0;
            //try
            //{
            //    d2 = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "xh"));
            //}
            //catch { }
            if (!string.IsNullOrWhiteSpace(Convert.ToString(DataBinder.Eval(e.Item.DataItem, "id2"))))
          
            {
                Image2.ImageUrl = "../../View/QrCodeHandler.ashx?e=M&q=Two&s=8&t=" + HttpUtility.UrlEncode(t2);
                  //DataBinder.Eval(e.Item.DataItem, "id1")) + ")" + 
                lbcompy2.Text = Convert.ToString(DataBinder.Eval(e.Item.DataItem, "CompanyName2"));
                lbtc2.Text = Convert.ToString(DataBinder.Eval(e.Item.DataItem, "Themes2"));
                lbproduct2.Text = "名称：" + Convert.ToString(Convert.ToString(DataBinder.Eval(e.Item.DataItem, "product_name2")));
                lbspec2.Text = "规格：" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "specifications2"));
                lbxh2.Text = "型号：" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "ProModel2")); ;
                lbcategory2.Text = "品牌：" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "brand2"));
                lbxl2.Text = "系列：" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "ProSeries2"));
                //单价：105元/平方米
                lbprice2.Text = "价格：" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "price2")) + "元/" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "unit2"));
                lbremarks2.Text = "备注：" + Convert.ToString(DataBinder.Eval(e.Item.DataItem, "remarks2"));
                int prid2 = 0;
                try
                {
                    prid2 = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "id2"));
                }
                catch { }

                string code2= Convert.ToString(DataBinder.Eval(e.Item.DataItem, "C_code2"));
                if (code2== "")
                    lbsys2.Text = prid2.ToString("0000");
                else
                    lbsys2.Text = code2.ToString().PadLeft(4, '0');
            }
            else
                p2.Visible = false;
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