using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using XHD.Common;
using System.Text;

namespace Budge_Rate
{
    public partial class Budge_Rate_Add : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var cmd = Request["cmd"];
            if (cmd == "form")
            {
                if (PageValidate.IsNumber(Request["cid"]))
                {
                    try
                    {
                        var sb = new System.Text.StringBuilder();
                        sb.AppendLine("SELECT * ");
                        sb.AppendLine("FROM dbo.Budge_Rate A LEFT JOIN Budge_Rate_CalculationFormula B ON A.formulaId=B.id ");
                        sb.AppendLine("WHERE A.ID='" + Request["cid"] + "'");
                        DataRow[] dr = SqlDB.ExecuteDataTable(sb.ToString()).Output1.Select("");
                        string jdata = Tools.DataRowToJson(dr, Types.JosnType.Form);
                        Response.ContentType = "application/json";
                        Response.Write(jdata);
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.Message);
                    }
                    finally
                    {
                        Response.End();
                    }
                }
                else
                {
                    Response.Write("{}");
                    Response.End();
                }
            }
            if (cmd == "getBz")
            {
                if (!string.IsNullOrEmpty(Request["formula"]))
                {
                    try
                    {
                        string strFormula = Request["formula"];
                        strFormula = Convert.ToString(System.Web.HttpUtility.UrlDecode(strFormula));

                        //string strFormula = PageValidate.InputText(Request["formula"], 255);
                        var sb = new System.Text.StringBuilder();
                        sb.AppendLine("SELECT bz ");
                        sb.AppendLine("FROM dbo.Budge_Rate_CalculationFormula ");
                        sb.AppendLine("WHERE formula='" + strFormula + "'");
                        DataRow[] dr = SqlDB.ExecuteDataTable(sb.ToString()).Output1.Select("");
                        string jdata = Tools.DataRowToJson(dr, Types.JosnType.Form);
                        Response.ContentType = "application/json";
                        Response.Write(jdata);
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.Message);
                    }
                    finally
                    {
                        Response.End();
                    }
                }
                else
                {
                    Response.Write("{}");
                    Response.End();
                }
            }
            if (cmd == "getCalculationFormula")    //获取计算公式
            {
                try
                {
                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("SELECT * ");
                    sb.AppendLine("FROM dbo.Budge_Rate_CalculationFormula ");
                    DataTable dt = SqlDB.ExecuteDataTable(sb.ToString()).Output1;
                    StringBuilder str = new StringBuilder();
                    str.Append("[");
                    //str.Append("{id:0,text:'无'},");
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        str.Append("{id:" + dt.Rows[i]["id"].ToString() + ",text:'" + dt.Rows[i]["formula"] + "'},");
                    }
                    str.Replace(",", "", str.Length - 1, 1);
                    str.Append("]");

                    Response.Write(str);
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
                finally
                {
                    Response.End();
                }
            }
            else if (cmd == "save")
            {
                try
                {
                    var ID = Request["cid"];
                    var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                    var ticket = FormsAuthentication.Decrypt(cookie.Value);
                    var sb = new System.Text.StringBuilder();
                    if (string.IsNullOrWhiteSpace(ID) || ID == "null")
                    {
                        sb.AppendLine("INSERT INTO dbo.Budge_Rate (RateName,measure,rate,Remarks,formulaId) ");
                        sb.AppendLine("VALUES  ('" + Request["RateName"] + "', ");
                        sb.AppendLine("         '按工程直接费用百分比计算', ");
                        sb.AppendLine(" " + Request["rate"] + ", ");
                     //   sb.AppendLine("         '" + Request["lxrid"] + "', ");
                        sb.AppendLine("         '" + Request["Remarks"] + "', ");
                        sb.AppendLine("         '" + Request["formula_val"] + "') ");
                    }
                    else
                    {
                        sb.AppendLine("UPDATE dbo.Budge_Rate SET ");
                        sb.AppendLine("         RateName='" + Request["RateName"] + "', ");
                        sb.AppendLine("         rate='" + Request["rate"] + "', ");
                        sb.AppendLine("         Remarks='" + Request["Remarks"] + "', ");
                        sb.AppendLine("         formulaId='" + Request["formula_val"] + "' ");
                        sb.AppendLine("WHERE ID='" + ID + "' ");

                    }

                    var rv = SqlDB.ExecuteNoneQuery(sb.ToString());
                    if (!rv.Result)
                        Response.Write(rv.Message);
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
                finally
                {
                    Response.End();
                }
            }
            else if (cmd == "del")
            {
                try
                {
                    var ID = Request["cid"];
                    var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                    var ticket = FormsAuthentication.Decrypt(cookie.Value);
                    var sb = new System.Text.StringBuilder();
                    sb.AppendLine("SELECT * FROM dbo.Budge_Rate_Ver ");
                    sb.AppendLine("WHERE rateid=" + ID);
                    var rv = SqlDB.ExecuteDataTable(sb.ToString());
                    if (!rv.Result)
                        Response.Write(rv.Message);
                    else
                    {
                        if (rv.Output1.Rows.Count > 0)
                        {
                            Response.Write("此附加费已使用，不能删除！");
                            return;
                        }
                    }
                    //此楼盘中有未删除的客户，不能删除！
                    sb.Clear();
                    sb.AppendLine("delete dbo.Budge_Rate ");
                    sb.AppendLine("WHERE ID=" + ID );

                    var rv1 = SqlDB.ExecuteNoneQuery(sb.ToString());
                    if (!rv1.Result)
                        Response.Write(rv1.Message);
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
                finally
                {
                    Response.End();
                }
            }
        }
    }
}