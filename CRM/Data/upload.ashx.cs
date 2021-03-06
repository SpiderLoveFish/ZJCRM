﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Text;
using System.Security.Cryptography;
using System.Configuration;
using System.IO;
using System.Web.SessionState;
using XHD.DBUtility;

namespace XHD.CRM.Data
{
    /// <summary>
    /// upload 的摘要说明
    /// </summary>
    public class upload : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;
            if (request["Action"] == "upload")
            {
                string fileName = request["filename"];    //文件路径
                fileName = fileName.Substring(fileName.LastIndexOf('\\') + 1);

                HttpPostedFile uploadFile = request.Files[0];
                uploadFile.SaveAs(context.Server.MapPath(@"~/images/upload/temp/" + fileName));
                //this.File1.PostedFile.SaveAs(page.Server.MapPath(@"~/focusimage/" + fileName));
                context.Response.Write(@"../images/upload/temp/" + fileName);
            }
            if (request["Action"] == "uploadbbs")
            {
                context.Response.ContentType = "text/plain";
                context.Response.Charset = "utf-8";

                var files = context.Request.Files;
                if (files.Count <= 0)
                {
                    return;
                }

                HttpPostedFile file = files[0];

                if (file == null)
                {
                    context.Response.Write("error|file is null");
                    return;
                }
                else
                {
                    string path = context.Server.MapPath("~/uploadedFiles/");  //存储图片的文件夹
                    string originalFileName = file.FileName;
                    string fileExtension = originalFileName.Substring(originalFileName.LastIndexOf('.'), originalFileName.Length - originalFileName.LastIndexOf('.'));
                    string currentFileName = (new Random()).Next() + fileExtension;  //文件名中不要带中文，否则会出错
                    //生成文件路径
                    string imagePath = path + currentFileName;
                    //保存文件
                    file.SaveAs(imagePath);

                    //获取图片url地址
                    string imgUrl = "http://mb.xczs.co/uploadedFiles/" + currentFileName;
                    string sql = "INSERT INTO testupload(filename_upload,FILENAME_save,Dotime) VALUES " +
                       "( '" + originalFileName + "','" + currentFileName + "',getdate())";
                    DbHelperSQL.Query(sql);
                    //返回图片url地址
                    context.Response.Write(imgUrl);
                    return;
                }
            }
            if (request["Action"] == "upload1")
            {
                string fileName = request["filename"];    //文件路径
                fileName = fileName.Substring(fileName.LastIndexOf('\\') + 1);

                HttpPostedFile uploadFile = request.Files[0];
                uploadFile.SaveAs(context.Server.MapPath(@"~/images/upload/temp/" + fileName));
                //this.File1.PostedFile.SaveAs(page.Server.MapPath(@"~/focusimage/" + fileName));
                context.Response.Write(@"../../images/upload/temp/" + fileName);
            }
            if (request["Action"] == "cus_import")
            {
                string fileName = request["filename"];    //文件路径
                fileName = fileName.Substring(fileName.LastIndexOf('\\') + 1);
                string sExt = fileName.Substring(fileName.LastIndexOf(".")).ToLower();

                DateTime now = DateTime.Now;
                string nowfileName = now.ToString("yyyyMMddHHmmss") + GetRandom(6) + sExt;

                HttpPostedFile uploadFile = request.Files[0];
                uploadFile.SaveAs(context.Server.MapPath(@"~/file/customer/" + nowfileName));

                context.Response.Write(nowfileName);
            }
            if (request["Action"] == "upheadimg")
            {
                int x1 = int.Parse(request["x1"]);
                int y1 = int.Parse(request["y1"]);
                int w = int.Parse(request["w"]);
                int h = int.Parse(request["h"]);

                string fileName = request["upload"];
                fileName = fileName.Substring(fileName.LastIndexOf('\\') + 1);
                string sExt = fileName.Substring(fileName.LastIndexOf(".")).ToLower();

                DateTime now = DateTime.Now;
                string nowfileName = now.ToString("yyyyMMddHHmmss") + GetRandom(6) + sExt;

                System.Web.UI.Page page = new Page();

                string oldpath = page.Server.MapPath(@"~/images/upload/temp/" + fileName);
                string currpath = page.Server.MapPath(@"~/images/upload/portrait/" + nowfileName);

                System.Drawing.Image originalImg = System.Drawing.Image.FromFile(oldpath);

                ZoomImage.SaveCutPic(oldpath, currpath, 0, 0, w, h, x1, y1, Convert.ToInt32(300 * originalImg.Width / originalImg.Height), 300);

                originalImg.Dispose();

                System.IO.File.Delete(oldpath);

                context.Response.Write(nowfileName);

            }
            if (request["Action"] == "upfavimg")
            {
                int x1 = int.Parse(request["x1"]);
                int y1 = int.Parse(request["y1"]);
                int w = int.Parse(request["w"]);
                int h = int.Parse(request["h"]);

                string fileName = request["upload"];
                fileName = fileName.Substring(fileName.LastIndexOf('\\') + 1);
                string sExt = fileName.Substring(fileName.LastIndexOf(".")).ToLower();

                DateTime now = DateTime.Now;
                string nowfileName = now.ToString("yyyyMMddHHmmss") + GetRandom(6) + sExt;

                System.Web.UI.Page page = new Page();

                string oldpath = page.Server.MapPath(@"~/images/upload/temp/" + fileName);
                string currpath = page.Server.MapPath(@"~/images/upload/favimg/" + nowfileName);

                System.Drawing.Image originalImg = System.Drawing.Image.FromFile(oldpath);

                ZoomImage.SaveCutPic(oldpath, currpath, 0, 0, w, h, x1, y1, Convert.ToInt32(300 * originalImg.Width / originalImg.Height), 300);

                originalImg.Dispose();

                System.IO.File.Delete(oldpath);

                context.Response.Write(nowfileName);

            }

            if (request["Action"] == "uprepair")
            {
                int x1 = int.Parse(request["x1"]);
                int y1 = int.Parse(request["y1"]);
                int w = int.Parse(request["w"]);
                int h = int.Parse(request["h"]);

                string fileName = request["upload"];
                fileName = fileName.Substring(fileName.LastIndexOf('\\') + 1);
                string sExt = fileName.Substring(fileName.LastIndexOf(".")).ToLower();

                DateTime now = DateTime.Now;
                string nowfileName = now.ToString("yyyyMMddHHmmss") + GetRandom(6) + sExt;

                System.Web.UI.Page page = new Page();

                string oldpath = page.Server.MapPath(@"~/images/upload/temp/" + fileName);
                string currpath = page.Server.MapPath(@"~/images/upload/repair/" + nowfileName);

                System.Drawing.Image originalImg = System.Drawing.Image.FromFile(oldpath);

                ZoomImage.SaveCutPic(oldpath, currpath, 0, 0, w, h, x1, y1, Convert.ToInt32(300 * originalImg.Width / originalImg.Height), 300);

                originalImg.Dispose();

                System.IO.File.Delete(oldpath);

                context.Response.Write(nowfileName);

            }
            if (request["Action"] == "contract")
            {
                try
                {
                    HttpPostedFile file;
                    for (int i = 0; i < request.Files.Count; ++i)
                    {
                        file = request.Files[i];
                        if (file == null || file.ContentLength == 0 || string.IsNullOrEmpty(file.FileName)) continue;

                        string filename = file.FileName;
                        string sExt = filename.Substring(filename.LastIndexOf(".")).ToLower();
                        DateTime now = DateTime.Now;
                        string nowfileName = now.ToString("yyyyMMddHHmmss") + GetRandom(6) + sExt;

                        file.SaveAs(HttpContext.Current.Server.MapPath("../file/contract/" + nowfileName));

                        context.Response.Write(nowfileName);
                    }
                }
                catch (Exception ex)
                {
                    context.Response.StatusCode = 500;
                    context.Response.Write(ex.Message);
                    context.Response.End();
                }
                finally
                {
                    context.Response.End();
                }
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
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}