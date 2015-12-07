using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using XHD.CRM.Class;

/// <summary>
/// Caches 的摘要说明
/// </summary>
public class Caches
{
    private static DataTable _CRM_Customer;
    /// <summary>
    /// CRM_Customer
    /// </summary>
    public static DataTable CRM_Customer
    {
        get
        {
            if (_CRM_Customer == null)
            {
                string strSql = "SELECT * FROM dbo.CRM_Customer";
                var rv = SqlDB.ExecuteDataTable(strSql);
                if (rv.Result)
                    _CRM_Customer = rv.Output1;
                if (_CRM_Customer == null)
                    return null;
            }
            return _CRM_Customer;
        }
        set
        {
            _CRM_Customer = null;
        }
    }

    private static DataTable _CRM_Repair;
    /// <summary>
    /// CRM_Repair
    /// </summary>
    public static DataTable CRM_Repair
    {
        get
        {
            if (_CRM_Repair == null)
            {
                var sb = new System.Text.StringBuilder();
                sb.AppendLine("SELECT * FROM dbo.v_Repair ");
                var rv = SqlDB.ExecuteDataTable(sb.ToString());
                if (rv.Result)
                    _CRM_Repair = rv.Output1;
                if (_CRM_Repair == null)
                    return null;
            }
            return _CRM_Repair;
        }
        set
        {
            _CRM_Repair = null;
        }
    }

    private static DataTable _CRM_Repair_Follow;
    /// <summary>
    /// CRM_Repair
    /// </summary>
    public static DataTable CRM_Repair_Follow
    {
        get
        {
            if (_CRM_Repair_Follow == null)
            {
                var sb = new System.Text.StringBuilder();
                sb.AppendLine("SELECT A.FollowID,A.RepairID,A.FollowTypeID,B.params_name AS FollowTypeName,A.FollowContent,A.IsDel, ");
                sb.AppendLine(" A.InEmpID,C.name AS InEmpName,CONVERT(VARCHAR(20),A.InDate,120) AS InDate, ");
                sb.AppendLine(" A.EditEmpID,D.name AS EditEmpName,CONVERT(VARCHAR(20),A.EditDate,120) AS EditDate, ");
                sb.AppendLine(" A.DelEmpID,E.name AS DelEmpName,CONVERT(VARCHAR(20),A.DelDate,120) AS DelDate,A.PicUrl ");
                sb.AppendLine("FROM dbo.CRM_Repair_Follow A");
                sb.AppendLine("LEFT JOIN dbo.Param_SysParam B ON A.FollowTypeID=B.ID ");
                sb.AppendLine("LEFT JOIN dbo.hr_employee C ON A.InEmpID=C.ID ");
                sb.AppendLine("LEFT JOIN dbo.hr_employee D ON A.EditEmpID=D.ID ");
                sb.AppendLine("LEFT JOIN dbo.hr_employee E ON A.DelEmpID=E.ID ");
                var rv = SqlDB.ExecuteDataTable(sb.ToString());
                if (rv.Result)
                    _CRM_Repair_Follow = rv.Output1;
                if (_CRM_Repair_Follow == null)
                    return null;
            }
            return _CRM_Repair_Follow;
        }
        set
        {
            _CRM_Repair_Follow = null;
        }
    }

    private static DataTable _sys_info;
    /// <summary>
    /// CRM_Repair
    /// </summary>
    public static DataTable sys_info
    {
        get
        {
            if (_sys_info == null)
            {
                var sb = new System.Text.StringBuilder();
                sb.AppendLine("SELECT * FROM dbo.sys_info ");
                var rv = SqlDB.ExecuteDataTable(sb.ToString());
                if (rv.Result)
                    _sys_info = rv.Output1;
                if (_sys_info == null)
                    return null;
            }
            return _sys_info;
        }
        set
        {
            _sys_info = null;
        }
    }

    private static qqMessage _qqMes;
    public static qqMessage qqMes
    {
        get
        {
            if (_qqMes == null)
                _qqMes = new qqMessage();
            return _qqMes;
        }
        set
        {
            if (_qqMes == null)
                _qqMes = new qqMessage();
            _qqMes = value;
        }
    }

}


public class qqMessage
{
    public qqMessage()
    {
        this.loginStatus = "0";
    }
    //str += "openid：" + openid + newline;
    //                str += "昵称：" + nickname + newline;
    //                str += "性别：" + sex + newline;
    //                str += "会员VIP等级：" + vip_level + newline;
    //                str += "空间黄钻等级：" + qzone_level + newline;
    //                str += "默认头像：" + face + newline;
    //                str += "头像1：" + face1 + newline;
    //                str += "头像2：" + face2 + newline;    

    /// <summary>
    /// 0:普通登录。1.表示qq登录成功 
    /// </summary>
    private string _loginStatus;

    public string loginStatus
    {
        get
        {
            return _loginStatus;
        }
        set
        {
            _loginStatus = value;
        }
    }

    private string _openid;
    public string openid
    {
        get
        {
            return _openid;
        }
        set
        {
            _openid = value;
        }
    }

    private string _nickname;
    public string nickname
    {
        get
        {
            return _nickname;
        }
        set
        {
            _nickname = value;
        }
    }

    private string _sex;
    public string sex
    {
        get
        {
            return _sex;
        }
        set
        {
            _sex = value;
        }
    }
    private string _vip_level;
    public string vip_level
    {
        get
        {
            return _vip_level;
        }
        set
        {
            _vip_level = value;
        }
    }
    private string _qzone_level;
    public string qzone_level
    {
        get
        {
            return _qzone_level;
        }
        set
        {
            _qzone_level = value;
        }
    }
    private string _face;
    public string face
    {
        get
        {
            return _face;
        }
        set
        {
            _face = value;
        }
    }

    private string _face1;
    public string face1
    {
        get
        {
            return _face1;
        }
        set
        {
            _face1 = value;
        }
    }

    private string _face2;
    public string face2
    {
        get
        {
            return _face2;
        }
        set
        {
            _face2 = value;
        }
    }
}