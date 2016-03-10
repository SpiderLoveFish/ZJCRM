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
          public DataSet geruser(string token,string userid)
          {
              return dal.geruser(token, userid);
          }
          public int Insertuser(int id, string token)
          {
              return dal.Insertuser(id,token);
          }
          public DataSet gerPCuser(string uid, string pwd)
          {
              return dal.gerPCuser(uid,pwd);
          }
          public int inserttopic(string token, int sid, string title, string content)
          {
              return dal.inserttopic(token, sid, title, content);
          }
          public int UpdateTopic(string token, string id, string title, string content)
        {
            return dal.UpdateTopic(token,id,title,content);
        }
         // 话题置精或者取消
          public int UpdateTopicTop(string token, string id, string status)
          {
              return dal.UpdateTopicTop(token,id,status);
          }
          // 话题置精或者取消
          public int UpdateTopicGood(string token, string id, string status)
          {
              return dal.UpdateTopicGood(token, id, status);
          }
        
        // 话题删除或恢复
          public int UpdateTopicShow_status(string token, string id, string status)
          {
              return dal.UpdateTopicShow_status(token, id, status);
          }


          public int UpdateTopict_view(string token, string id)
          {
              return dal.UpdateTopict_view(token,id);
          }
          public int insertreply(string token, int tid, string title, string content)
          {
              return dal.insertreply(token,tid,title,content);
          }
          public int Updatef_reply_delete(string token, string id, string status)
          {
           return   dal.Updatef_reply_delete(token,id,status);
          }
          public int Updatef_reply_best(string token, string id, string status)
          {
              return dal.Updatef_reply_best(token,id,status);
          }

          public int Insertcollect(string token, string tid)
          {
              return dal.Insertcollect(token,tid);
          }
          public int Deletecollect(string token, string tid)
          {
              return dal.Deletecollect(token, tid);
          }
          public DataSet GetDsTopic(int PageIndex, int PageSize, string strWhere, out string Total)
          {
            return  dal.GetDsTopic(PageIndex,PageSize,strWhere,out Total);
          }

          public DataSet GetDsTopicDetail(string token, string tid, out string collectCount)
          {
              return dal.GetDsTopicDetail(token,tid,out collectCount);
          }
          public DataSet GetDsTopicDetail_replay(string token, string tid)
          {
              return dal.GetDsTopicDetail_replay(token,tid);
          }
          public DataSet GetDsTopicDetail_replay_last(string token, string tid)
          {
              return dal.GetDsTopicDetail_replay_last(token, tid);
          }
    }
}
