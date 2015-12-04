using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
 
    public class ToJson
    {
        public static string getnulljson()
        {
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.Append("{\"total\": 0,\"");
            jsonBuilder.Append("rows");
            jsonBuilder.Append("\":[ ");

            jsonBuilder.Append("]");
            jsonBuilder.Append("}");
            return jsonBuilder.ToString();
        }

        #region dataTable转换成Json格式
        /// <summary>  
        /// dataTable转换成Jquery DataGrid需要的JSON格式  不分頁模式下  所有資料行
        /// </summary>  
        /// <param name="dt"></param>  
        /// <returns></returns>  
        public static string toDataGridJSON(DataTable dt, int rows = 0)
        {
            string totalrow = (rows == 0 ? dt.Rows.Count : rows).ToString();
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.Append("{\"total\": " + totalrow + ",\"");
            jsonBuilder.Append("rows");
            jsonBuilder.Append("\":[ ");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(dt.Rows[i][j].ToString().Replace("\n", "").Replace(" ", "").Replace("\r", "").Replace("\t", ""));
                    jsonBuilder.Append("\",");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("]");
            jsonBuilder.Append("}");
            return jsonBuilder.ToString();
        }
        #endregion

        #region dataTable转换成Json格式
        /// <summary>  
        /// dataTable转换成Json格式  顯示自定義的datatable名稱
        /// </summary>  
        /// <param name="dt"></param>  
        /// <returns></returns>  
        public static string DataTable2Json(DataTable dt, string tableName = "")
        {
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.Append("{\"");
            jsonBuilder.Append(tableName == "" ? dt.TableName : tableName);
            jsonBuilder.Append("\":[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(dt.Rows[i][j].ToString().Replace("\n", "").Replace(" ", "").Replace("\r", "").Replace("\t", ""));
                    jsonBuilder.Append("\",");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("]");
            jsonBuilder.Append("}");
            return jsonBuilder.ToString();
        }
        #endregion

        #region DataSet转换成Json格式
        /// <summary>  
        /// DataSet转换成Json格式  
        /// </summary>  
        /// <param name="ds">DataSet</param> 
        /// <returns></returns>  
        public static string Dataset2Json(DataSet ds)
        {
            StringBuilder json = new StringBuilder();
            json.Append("{");
            foreach (DataTable dt in ds.Tables)
            {
                json.Append(DataTable2Json(dt));
                json.Append(",");
            }
            string reStr = json.ToString().Substring(0, json.ToString().Length - 1) + "}";
            return reStr;
        }
        #endregion


        #region dataTable转换成Json格式
        /// <summary>  
        /// dataTable转换成Json格式  只適用於 autocoplete  textbox功能  combox功能
        /// </summary>  
        /// <param name="dt"></param>  
        /// <returns></returns>  
        public static string DataTable2CompleteJson(DataTable dt)
        {
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.Append("[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(dt.Rows[i][j].ToString().Replace("\n", "").Replace(" ", "").Replace("\r", "").Replace("\t", ""));
                    jsonBuilder.Append("\",");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("]");
            return jsonBuilder.ToString();
        }
        #endregion

        /// <summary>
        ///  將dataset轉換成多個前臺datagridview可以直接綁定的資料源
        ///  套用了 datatable轉json的方法
        /// </summary>
        /// <param name="ds"></param>
        /// <returns></returns>
        public static string DataSetToDataGridJson(DataSet ds)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("[");
            foreach (DataTable dt in ds.Tables)
            {
                sb.Append(toDataGridJSON(dt));
                sb.Append(",");
            }
            sb.Remove(sb.Length - 1, 1);
            sb.Append("]");
            return sb.ToString();
        }
    } 