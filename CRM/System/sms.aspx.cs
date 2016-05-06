using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Text;
using System.IO;
using XHD.BLL;
using XHD.Common;
using System.Data;

public partial class sms : System.Web.UI.Page
{
    Param_SysParam ps = new Param_SysParam();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnClareAll_Click(object sender, EventArgs e)
    {
        Caches.CRM_Customer = null;
        Caches.CRM_Repair = null;
        Caches.CRM_Repair_Follow = null;
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        //查询余额
      DataSet ds=  ps.GetList_SMSConfig(0,"","");
      if (ds == null) {
          TextBox3.Text = "请先配置相关参数！"; return;
      }
      if (ds.Tables[0].Rows.Count <= 0)
      {
          TextBox3.Text = "请先配置相关参数！"; return;
      }
      try
      {
          foreach (DataRow dr in ds.Tables[0].Rows)
          {
              string param = "userid=" + dr["userid"].ToString() + "&account=" + dr["account"].ToString() + "&password=" + dr["password"].ToString() + "&action=overage";
              byte[] bs = Encoding.UTF8.GetBytes(param);
              string strReturn = string.Empty;
              HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create("http://" + dr["ip"].ToString() + "/sms.aspx");
              req.Method = "POST";
              req.ContentType = "application/x-www-form-urlencoded";
              req.ContentLength = bs.Length;

              using (Stream reqStream = req.GetRequestStream())
              {
                  reqStream.Write(bs, 0, bs.Length);
              }
              using (WebResponse wr = req.GetResponse())
              {
                  StreamReader sr = new StreamReader(wr.GetResponseStream(), System.Text.Encoding.Default);
                  Stream stream = wr.GetResponseStream();
                  strReturn += new StreamReader(stream, System.Text.Encoding.UTF8).ReadToEnd();//解决乱码：utf-8 + streamreader.readtoend

                  TextBox3.Text = strReturn;
              }
          }
      }
      catch (Exception ex) { TextBox3.Text = ex.Message; }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        DataSet ds = ps.GetList_SMSConfig(0, "", "");
        if (ds == null)
        {
            TextBox3.Text = "请先配置相关参数！"; return;
        } if (ds.Tables[0].Rows.Count <= 0)
        {
            TextBox3.Text = "请先配置相关参数！"; return;
        }
        //发送短信
 try
      {
          foreach (DataRow dr in ds.Tables[0].Rows)
          {
              string param = "action=send&userid=" + dr["userid"].ToString() + "&account=" + dr["account"].ToString() + "&password=" + dr["password"].ToString() + "&content=" + TextBox2.Text + "&mobile=" + TextBox1.Text + "&sendtime=";
              if (CheckBox1.Checked)//是否定时发送
              {
                  param = param + TextBox4.Text; //格式 yyyymmddhhnnss
              }
              else
              {
                  // param = param + "0";//不需要定时发送，也需要带上0
              }
              byte[] bs = Encoding.UTF8.GetBytes(param);

              HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create("http://" + dr["ip"].ToString() + "/sms.aspx");
              req.Method = "POST";
              req.ContentType = "application/x-www-form-urlencoded";
              req.ContentLength = bs.Length;
              string strReturn = string.Empty;
              using (Stream reqStream = req.GetRequestStream())
              {
                  reqStream.Write(bs, 0, bs.Length);
              }
              using (WebResponse wr = req.GetResponse())
              {
                  StreamReader sr = new StreamReader(wr.GetResponseStream(), System.Text.Encoding.Default);
                  Stream stream = wr.GetResponseStream();
                  strReturn += new StreamReader(stream, System.Text.Encoding.UTF8).ReadToEnd();//解决乱码：utf-8 + streamreader.readtoend

                  TextBox3.Text = strReturn;
                  ps.InsertSMSLog(strReturn,"");
              }
          }
         }
      catch (Exception ex) { TextBox3.Text = ex.Message; }
    
    }
}