using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using XHD.Common;
using XHD.Model;
using System.Data;

namespace XHD.BLL
{
    public partial class f_bbs
    {
        private readonly XHD.DAL.f_bbs dal = new XHD.DAL.f_bbs();
          public f_bbs()
        { }


          public DataSet Getf_section()
          {
              return dal.Getf_section();
          }

 
    }
}
