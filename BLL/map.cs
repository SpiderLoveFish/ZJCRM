using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using XHD.Common;
using XHD.Model;
using System.Data;

namespace XHD.BLL
{
    public partial class map
    {
          private readonly XHD.DAL.map dal = new XHD.DAL.map();
          public map()
        { }


          public DataSet GetMapList(string strWhere)
          {
              return dal.GetMapList(strWhere);
          }

          public DataSet GetBMapList(string strWhere)
          {
              return dal.GetBMapList(strWhere);
          }
          public DataSet GetGYSMapList(string strWhere)
          {
              return dal.GetGYSMapList(strWhere);
          }

    }
}
