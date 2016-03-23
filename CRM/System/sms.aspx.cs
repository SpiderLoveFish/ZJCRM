using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Text;
using System.IO;


public partial class sms : System.Web.UI.Page
{
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
        string param = "userid=4905&account=xincheng&password=a123123&action=overage";
        byte[] bs = Encoding.UTF8.GetBytes(param);

        HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create("http://118.145.18.170:8080/sms.aspx");
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
            TextBox3.Text = sr.ReadToEnd().Trim();
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        //发送短信
        string param = "action=send&userid=4905&account=xincheng&password=a123123&content=" + TextBox2.Text + "&mobile=" + TextBox1.Text + "&sendtime=";
            if (CheckBox1.Checked)//是否定时发送
            {
                param = param + TextBox4.Text; //格式 yyyymmddhhnnss
            }
            else
            {
               // param = param + "0";//不需要定时发送，也需要带上0
            }
            byte[] bs = Encoding.UTF8.GetBytes(param);

            HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create("http://118.145.18.170:8080/sms.aspx");
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
                TextBox3.Text = sr.ReadToEnd().Trim();
            }
        
    }
}