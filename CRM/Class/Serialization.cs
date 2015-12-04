using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;


/// <summary>
/// Serialization 的摘要说明
/// </summary>
public class Serialization
{
    private static Serialization _current;
    public static Serialization Current
    {
        get
        {
            if (_current == null)
                _current = new Serialization();
            return _current;
        }
    }

    /// <summary>
    /// 深拷贝一个对象,该对象必须是Serializable的
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="a"></param>
    /// <returns></returns>
    public static T DeepClone<T>(T a) where T : class
    {
        using (MemoryStream stream = new MemoryStream())
        {
            BinaryFormatter formatter = new BinaryFormatter();
            formatter.Serialize(stream, a);
            stream.Position = 0;
            return (T)formatter.Deserialize(stream);
        }
    }

    /// <summary>
    /// 将一个XElement输出为xml文档
    /// </summary>
    /// <param name="xElem">XElement元素</param>
    /// <param name="isOmitXmlDeclaration">是否生成xml声明</param>
    /// <param name="isIndent">是否缩进</param>
    /// <returns></returns>
    public string WriteXml(XElement xElem, bool isOmitXmlDeclaration = true, bool isIndent = false)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        XmlWriterSettings settings = new XmlWriterSettings();
        settings.OmitXmlDeclaration = isOmitXmlDeclaration;
        settings.Indent = isIndent;
        XmlWriter writer = XmlWriter.Create(sb, settings);
        xElem.WriteTo(writer);
        writer.Close();
        return sb.ToString();
    }

    public System.Data.DataTable CloneDataTable(System.Data.DataTable dt)
    {
        var cp = new System.Data.DataTable();
        for (int i = 0; i < dt.Columns.Count; i++)
            cp.Columns.Add(dt.Columns[i].ColumnName, dt.Columns[i].DataType);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            var dr = cp.NewRow();
            for (int j = 0; j < dt.Columns.Count; j++)
                dr[j] = dt.Rows[i][j];
            cp.Rows.Add(dr);
        }
        return cp;
    }

    public System.Data.SqlClient.SqlParameter CloneSqlParameter(System.Data.SqlClient.SqlParameter para)
    {
        return new System.Data.SqlClient.SqlParameter(
             para.ParameterName,
             para.SqlDbType,
             para.Size)
        {
            Value = para.Value
        };
    }

    /// <summary>
    /// 将一个允许序列化的对象序列化为一个base64字符串
    /// </summary>
    /// <param name="obj"></param>
    /// <returns></returns>
    public string Serialize(object obj)
    {
        using (var ms = new MemoryStream())
        {
            var bf = new BinaryFormatter();
            bf.Serialize(ms, obj);
            ms.Position = 0;
            return System.Convert.ToBase64String(ms.ToArray());
        }
    }

    /// <summary>
    /// 将一个以base64编码的对象反序列化.
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public object Deserialize(string str)
    {
        var buffer = System.Convert.FromBase64String(str);
        using (var ms = new MemoryStream(buffer))
        {
            var bf = new BinaryFormatter();
            return bf.Deserialize(ms);
        }
    }
}