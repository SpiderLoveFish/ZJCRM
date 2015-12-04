using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Security.Cryptography;
using XHD.Common;

namespace XHD.CRM
{
    public partial class GetRegNum : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnReg_Click(object sender, EventArgs e)
        {
            Common.SoftReg rg = new Common.SoftReg();
            string strMNum = txtMNum.Text;
            string strRNum = rg.getRNum(strMNum);
            lbRNum.Text = "注册码：" + strRNum + "<br/>";
        }
    }
}