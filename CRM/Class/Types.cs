using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Types 的摘要说明
/// </summary>
public class Types
{
    /// <summary>
    /// 通讯类型
    /// </summary>
    public enum HttpType
    {
        POST,
        GET
    }

    /// <summary>
    /// 自动回复内容类型
    /// </summary>
    public enum JosnType
    {
        Form = 0,
        Grid = 1
    }
}