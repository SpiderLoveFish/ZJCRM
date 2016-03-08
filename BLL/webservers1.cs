using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using XHD.Common;
using XHD.Model;
using System.Data;

namespace XHD.BLL
{
    public partial class webservers1
    {
        private readonly XHD.DAL.webserver1 dal = new XHD.DAL.webserver1();
        public webservers1()
        { }

        public int HR_SignIn(int id, string localstate, string MapPosition)
        {
            return dal.HR_SignIn(id,localstate,MapPosition);
        }

        public DataSet Get_SignInlist(string id, int topindex)
        {
            return dal.Get_SignInlist(id, topindex);
        }
        public int HR_follow(string cid, string follow, string type, string id)
        {
            return dal.HR_follow(cid,follow,type,id);
        }

        public DataSet GetFollow(string cid)
        {
            return dal.GetFollow(cid);
        }
        public DataSet GetCRM_Customer(string cid)
        {
            return dal.GetCRM_Customer(cid);
        }
    }
}
