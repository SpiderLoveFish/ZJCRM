using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.IO;
using System.Xml;

/// <summary>
/// Tools 的摘要说明
/// </summary>
public class Tools
{
    /// <summary>
    /// 将Xml文件转换为文本
    /// </summary>
    public static string XmlToString(XmlDocument xmlDoc)
    {
        MemoryStream stream = new MemoryStream();
        XmlTextWriter writer = new XmlTextWriter(stream, null);
        writer.Formatting = Formatting.Indented;
        xmlDoc.Save(writer);
        StreamReader sr = new StreamReader(stream, System.Text.Encoding.UTF8);
        stream.Position = 0;
        string xmlString = sr.ReadToEnd();
        sr.Close();
        stream.Close();
        return xmlString;
    }

    /// <summary>
    /// 获取Json字符串某节点的值
    /// </summary>
    public static string GetJsonValue(string strJson, string key)
    {
        string result = string.Empty;
        if (!string.IsNullOrEmpty(strJson))
        {
            key = "\"" + key.Trim('"') + "\"";
            int index = strJson.IndexOf(key) + key.Length + 1;
            if (index > key.Length + 1)
            {
                //先截逗号，若是最后一个，截“｝”号，取最小值
                int end = strJson.IndexOf(',', index);
                if (end == -1)
                {
                    end = strJson.IndexOf('}', index);
                }

                result = strJson.Substring(index, end - index);
                result = result.Trim(new char[] { '"', ' ', '\'' }); //过滤引号或空格
            }
        }
        return result;
    }

    /// <summary>
    /// DataTable转换为Json格式
    /// </summary>
    public static string DataTableToJson(DataTable dt, Types.JosnType jt)
    {
        if (dt == null)
        {
            if (jt == Types.JosnType.Grid)
                return "{Rows:[],Total:0}";
            else if (jt == Types.JosnType.Form)
                return "{}";
        }

        return DataRowToJson(dt.AsEnumerable().ToArray(), dt.AsEnumerable().ToArray().Length, jt);
    }

    /// <summary>
    /// DataTable转换为Json格式
    /// </summary>
    public static string DataTableToJson(DataTable dt, int total, Types.JosnType jt)
    {
        if (dt == null)
        {
            if (jt == Types.JosnType.Grid)
                return "{Rows:[],Total:0}";
            else if (jt == Types.JosnType.Form)
                return "{}";
        }

        return DataRowToJson(dt.AsEnumerable().ToArray(), total, jt);
    }

    /// <summary>
    /// DataRow转换为Json格式
    /// </summary>
    public static string DataRowToJson(DataRow[] dr, Types.JosnType jt)
    {
        if (dr == null)
        {
            if (jt == Types.JosnType.Grid)
                return "{Rows:[],Total:0}";
            else if (jt == Types.JosnType.Form)
                return "{}";
        }
        var cnt = dr.Length;
        if (cnt == 0)
        {
            if (jt == Types.JosnType.Grid)
                return "{Rows:[],Total:0}";
            else if (jt == Types.JosnType.Form)
                return "{}";
        }
        if (jt == Types.JosnType.Form)
            cnt = 1;
        var columns = dr[0].Table.Columns;
        string[] colNames = new string[columns.Count];
        for (int i = 0; i < colNames.Length; i++)
            colNames[i] = columns[i].ColumnName;

        var jsonBuilder = new System.Text.StringBuilder();
        if (jt == Types.JosnType.Grid)
            jsonBuilder.Append("{Rows:[");
        for (int i = 0; i < cnt; i++)
        {
            jsonBuilder.Append("{");
            bool needQuote;
            for (int j = 0; j < colNames.Length; j++)
            {
                jsonBuilder.Append("\"");
                jsonBuilder.Append(colNames[j]);
                jsonBuilder.Append("\":");
                if (dr[i][j] == null)
                    jsonBuilder.Append("null");
                else
                {
                    string v;
                    var t = dr[i][j].GetType();
                    needQuote = true;
                    switch (t.Name)
                    {
                        case "Byte":
                        case "Int16":
                        case "UInt16":
                        case "Int32":
                        case "UInt32":
                        case "Int64":
                        case "UInt64":
                        case "Double":
                        case "Decimal":
                        case "Single":
                            v = dr[i][j].ToString();
                            if (System.Text.RegularExpressions.Regex.IsMatch(v, "^[0-9]\\.0$"))
                                v = v.Substring(0, v.IndexOf('.'));
                            needQuote = false;
                            break;
                        case "DateTime":
                            v = DateTime.Parse(dr[i][j].ToString()).ToString("yyyy-MM-dd HH:mm:ss");
                            break;
                        case "Boolean":
                            needQuote = false;
                            if ((bool)dr[i][j])
                                v = "true";
                            else
                                v = "false";
                            break;
                        default:
                            v = dr[i][j].ToString().Replace("\"", "“").Replace("\\", "\\\\").Replace("\n", "\\n").Replace("\r", "\\r").Replace("\t", "\\t");
                            break;
                    }
                    if (needQuote)
                        v = "\"" + v + "\"";
                    jsonBuilder.Append(v);
                }
                jsonBuilder.Append(",");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("},");
        }
        jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        if (jt == Types.JosnType.Grid)
            jsonBuilder.Append("],Total:" + dr.Length + "}");
        return jsonBuilder.ToString();
    }

    /// <summary>
    /// DataRow转换为Json格式
    /// </summary>
    public static string DataRowToJson(DataRow[] dr, int total, Types.JosnType jt)
    {
        if (dr == null)
        {
            if (jt == Types.JosnType.Grid)
                return "{Rows:[],Total:0}";
            else if (jt == Types.JosnType.Form)
                return "{}";
        }
        var cnt = dr.Length;
        if (cnt == 0)
        {
            if (jt == Types.JosnType.Grid)
                return "{Rows:[],Total:0}";
            else if (jt == Types.JosnType.Form)
                return "{}";
        }
        if (jt == Types.JosnType.Form)
            cnt = 1;
        var columns = dr[0].Table.Columns;
        string[] colNames = new string[columns.Count];
        for (int i = 0; i < colNames.Length; i++)
            colNames[i] = columns[i].ColumnName;

        var jsonBuilder = new System.Text.StringBuilder();
        if (jt == Types.JosnType.Grid)
            jsonBuilder.Append("{Rows:[");
        for (int i = 0; i < cnt; i++)
        {
            jsonBuilder.Append("{");
            bool needQuote;
            for (int j = 0; j < colNames.Length; j++)
            {
                jsonBuilder.Append("\"");
                jsonBuilder.Append(colNames[j]);
                jsonBuilder.Append("\":");
                if (dr[i][j] == null)
                    jsonBuilder.Append("null");
                else
                {
                    string v;
                    var t = dr[i][j].GetType();
                    needQuote = true;
                    switch (t.Name)
                    {
                        case "Byte":
                        case "Int16":
                        case "UInt16":
                        case "Int32":
                        case "UInt32":
                        case "Int64":
                        case "UInt64":
                        case "Double":
                        case "Decimal":
                        case "Single":
                            v = dr[i][j].ToString();
                            if (System.Text.RegularExpressions.Regex.IsMatch(v, "^[0-9]\\.0$"))
                                v = v.Substring(0, v.IndexOf('.'));
                            needQuote = false;
                            break;
                        case "DateTime":
                            v = dr[i][j].ToString();
                            break;
                        case "Boolean":
                            needQuote = false;
                            if ((bool)dr[i][j])
                                v = "true";
                            else
                                v = "false";
                            break;
                        default:
                            v = dr[i][j].ToString().Replace("\"", "“").Replace("\\", "\\\\").Replace("\n", "\\n").Replace("\r", "\\r").Replace("\t", "\\t");
                            break;
                    }
                    if (needQuote)
                        v = "\"" + v + "\"";
                    jsonBuilder.Append(v);
                }
                jsonBuilder.Append(",");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("},");
        }
        jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        if (jt == Types.JosnType.Grid)
            jsonBuilder.Append("],Total:" + total + "}");
        return jsonBuilder.ToString();
    }

    /// <summary>
    /// 公历转为农历的函数
    /// </summary>
    /// <param name="solarDateTime">公历日期</param>
    /// <returns>农历的日期</returns>
    public static string SolarToChineseLunisolarDate(DateTime solarDateTime)
    {
        System.Globalization.ChineseLunisolarCalendar cal = new System.Globalization.ChineseLunisolarCalendar();

        int year = cal.GetYear(solarDateTime);
        int month = cal.GetMonth(solarDateTime);
        int day = cal.GetDayOfMonth(solarDateTime);
        int leapMonth = cal.GetLeapMonth(year);
        return string.Format("农历{0}{1}（{2}）年{3}{4}月{5}{6}"
                            , "甲乙丙丁戊己庚辛壬癸"[(year - 4) % 10]
                            , "子丑寅卯辰巳午未申酉戌亥"[(year - 4) % 12]
                            , "鼠牛虎兔龙蛇马羊猴鸡狗猪"[(year - 4) % 12]
                            , month == leapMonth ? "闰" : ""
                            , "无正二三四五六七八九十冬腊"[leapMonth > 0 && leapMonth <= month ? month - 1 : month]
                            , "初十廿三"[day / 10]
                            , "日一二三四五六七八九"[day % 10]
                            );
    }
}