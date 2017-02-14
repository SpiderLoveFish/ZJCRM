using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace XHD.CRM.Data
{
    public class JsonSocialWorkerCalendarViewData
    {
        public JsonSocialWorkerCalendarViewData(List<XHD.Model.hr_socialWorker_Follow> eventList, DateTime startDate, DateTime endDate)
        {
            events = eventList;
            start = startDate;
            end = endDate;
            issort = true;
        }

        public JsonSocialWorkerCalendarViewData(List<XHD.Model.hr_socialWorker_Follow> eventList, DateTime startDate, DateTime endDate, bool isSort)
        {
            start = startDate;
            end = endDate;
            events = eventList;
            issort = isSort;
        }
        
        public List<XHD.Model.hr_socialWorker_Follow> events { get; private set; }
        public bool issort
        {
            get;
            private set;
        }

        public DateTime start { get; private set; }
        public DateTime end { get; private set; }
    }
}
