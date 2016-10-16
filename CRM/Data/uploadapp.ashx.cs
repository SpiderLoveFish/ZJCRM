using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using XHD.DBUtility;//Please add references
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Web.Services.Protocols;
using System.IO;
using System.Drawing;
using System.Security.Cryptography;

namespace XHD.CRM.Data
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class uploadapp : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            context.Response.ContentType =  "text/plain";
             HttpRequest request = context.Request;
            
             //if (request["data"]=="")
             //context.Response.Write("-1|" + "0");
             //else context.Response.Write("-1|" + "1");

             //return;

             string dirPath = context.Server.MapPath(@"~/images/upload/temp/");
              if (request["Action"] == "uploadhead")
             dirPath = context.Server.MapPath(@"~/images/upload/portrait/"); 
            if (!Directory.Exists(dirPath))
            {
                Directory.CreateDirectory(dirPath);
            }
          
            //return;
             try
             {
                 string nowfileName = DateTime.Now.ToString("yyyyMMddHHmmss") + GetRandom(6) + ".jpg";
                 var a = request.Form["base64"];
                 string err = Base64StringToImage(a.Replace("data:image/png;base64,", "").Replace("data:image/jpeg;base64,", ""), dirPath + nowfileName);
                 //.Replace("data:image/png;base64,", "")
                 //SqlParameter[] parameters = { };
                 //DbHelperSQL.ExecuteSql("INSERT INTO dbo.test ( test )VALUES  ( '"+a+"'    )", parameters);

                 if (err == "") context.Response.Write("0|" + nowfileName);
                 else context.Response.Write("-1|" +a.Substring(0,7)+ err);

            //   HttpFileCollection files = context.Request.Files;
               
               

            //    if (files.Count > 0)
            //    {
            //        //string str=Base64StringToImage(request["base64"], dirPath + nowfileName);
            //        //if (str=="")
            //        //    context.Response.Write("0|0" + nowfileName);
            //        //else context.Response.Write("-1|0" + str);
            //        for (int i = 0; i < files.Count; i++)
            //        {
            //            HttpPostedFile file = context.Request.Files[i];
            //            string filePath = dirPath + nowfileName;

            //            file.SaveAs(filePath);
            //            context.Response.Write("0|" + nowfileName);
            //        }
                  
            //    }
            //    else context.Response.Write("-1|0");
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        //base64编码的文本 转为    图片
        private string Base64StringToImage(string base64string,string path)
        {
            try
            {
                byte[] bt = Convert.FromBase64String(base64string);
                File.WriteAllBytes(path, bt);
                 return "";
            }
            catch (Exception ex) 
            {
                return ex.Message;
            }
        }

        #region GetRandom
        private string GetRandom(int length)
        {
            byte[] random = new Byte[length / 2];
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            rng.GetNonZeroBytes(random);

            StringBuilder sb = new StringBuilder(length);
            int i;
            for (i = 0; i < random.Length; i++)
            {
                sb.Append(String.Format("{0:X2}", random[i]));
            }
            return sb.ToString();
        }
        #endregion

        
       
    }
}