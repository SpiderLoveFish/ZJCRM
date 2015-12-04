using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

/// <summary>
/// ReturnValue 的摘要说明
/// </summary>

[Serializable]
public class ReturnValue
{
    public ReturnValue()
    {
        Result = true;
        Message = "";
    }
    public ReturnValue(bool result, string message)
    {
        Result = result;
        Message = message;
    }
    public bool Result { get; set; }
    public string Message { get; set; }

    public override string ToString()
    {
        var xe = new XElement("o");
        xe.Add(new XAttribute("Result", Result));
        xe.Add(new XElement("Message", Message));
        return Serialization.Current.WriteXml(xe);
    }

    public static ReturnValue Parse(string val)
    {
        var rv = new ReturnValue();
        if (string.IsNullOrEmpty(val))
            return null;
        var xe = XElement.Parse(val);
        if (xe == null)
            return null;
        var xa = xe.Attribute("Result");
        if (xa == null)
            return null;
        rv.Result = bool.Parse(xa.Value);
        var sxe = xe.Element("Message");
        if (sxe == null)
            return null;
        rv.Message = sxe.Value;
        return rv;
    }

    public static ReturnValue<string> ParseS(string val)
    {
        var rv = new ReturnValue<string>();
        if (string.IsNullOrEmpty(val))
            return null;
        var xe = XElement.Parse(val);
        if (xe == null)
            return null;
        var xa = xe.Attribute("Result");
        if (xa == null)
            return null;
        rv.Result = bool.Parse(xa.Value);
        var sxe = xe.Element("Message");
        if (sxe == null)
            return null;
        rv.Message = sxe.Value;
        sxe = xe.Element("Output1");
        if (sxe == null)
            return null;
        rv.Output1 = sxe.Value;
        return rv;
    }

    public static ReturnValue<string, string> ParseSS(string val)
    {
        var rv = new ReturnValue<string, string>();
        if (string.IsNullOrEmpty(val))
            return null;
        var xe = XElement.Parse(val);
        if (xe == null)
            return null;
        var xa = xe.Attribute("Result");
        if (xa == null)
            return null;
        rv.Result = bool.Parse(xa.Value);
        var sxe = xe.Element("Message");
        if (sxe == null)
            return null;
        rv.Message = sxe.Value;
        sxe = xe.Element("Output1");
        if (sxe == null)
            return null;
        rv.Output1 = sxe.Value;
        sxe = xe.Element("Output2");
        if (sxe == null)
            return null;
        rv.Output2 = sxe.Value;
        return rv;
    }

}

[Serializable]
public class ReturnValue<T1>
{
    public ReturnValue()
    {
        Result = true;
        Message = "";
    }
    public ReturnValue(T1 out1)
    {
        Result = true;
        Message = "";
        Output1 = out1;
    }
    public ReturnValue(bool result, string message)
    {
        Result = result;
        Message = message;
    }
    public ReturnValue(bool result, string message, T1 value)
    {
        Result = result;
        Message = message;
        Output1 = value;
    }
    public bool Result { get; set; }
    public string Message { get; set; }
    public T1 Output1 { get; set; }

    public override string ToString()
    {
        var xe = new XElement("o");
        xe.Add(new XAttribute("Result", Result));
        xe.Add(new XElement("Message", Message));
        xe.Add(new XElement("Output1", Output1));
        return Serialization.Current.WriteXml(xe);
    }

}

[Serializable]
public class ReturnValue<T1, T2>
{
    public ReturnValue()
    {
        Result = true;
        Message = "";
    }
    public ReturnValue(T1 out1, T2 out2)
    {
        Result = true;
        Message = "";
        Output1 = out1;
        Output2 = out2;
    }
    public ReturnValue(bool result, string message)
    {
        Result = result;
        Message = message;
    }
    public bool Result { get; set; }
    public string Message { get; set; }
    public T1 Output1 { get; set; }
    public T2 Output2 { get; set; }

    public override string ToString()
    {
        var xe = new XElement("o");
        xe.Add(new XAttribute("Result", Result));
        xe.Add(new XElement("Message", Message));
        xe.Add(new XElement("Output1", Output1));
        xe.Add(new XElement("Output2", Output2));

        return Serialization.Current.WriteXml(xe);
    }
}