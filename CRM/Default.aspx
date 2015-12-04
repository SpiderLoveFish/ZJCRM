<%@ Page Language="C#" AutoEventWireup="true" %>
 
<!--Èë¿ÚÒ³Ãæ->
<%
    //Ë¢ÐÂ¾²Ì¬·½·¨»º´æ  
    CRM.Data.install inss = new CRM.Data.install();
    string filename = Server.MapPath("/conn.config");
    inss.CheckConfig(filename);
    string filename1 = Server.MapPath("/Web.config");
    inss.CheckConfig(filename1);

    //ÅÐ¶ÏÊÇ·ñÒÑÅäÖÃ
    CRM.Data.install ins = new CRM.Data.install();
    int configed = ins.configed();

    if (configed == 1)
    {
        //ÅÐ¶ÏÊÇ·ñµÇÂ½
        HttpCookie cookie = Request.Cookies[FormsAuthentication.FormsCookieName]; 
        if (Request.IsAuthenticated && null!=cookie)
            Response.Redirect("main.aspx");
       //     Response.Write("<script language=javascript>   "+
       //" window.open('main.aspx','_blank','left=0,top=0,width='+ (screen.availWidth - 10) +',height='+ (screen.availHeight-50) +',scrollbars,resizable=yes,toolbar=no');</script>");
        else
            Response.Redirect("login.aspx");
        //Response.Write("<script language=javascript>   " +
        //" window.open('login.aspx','_blank','left=0,top=0,width='+ (screen.availWidth - 10) +',height='+ (screen.availHeight-50) +',scrollbars,resizable=yes,toolbar=no');</script>");
      
    }
    else
        Response.Redirect("install/index.aspx");
 %>
