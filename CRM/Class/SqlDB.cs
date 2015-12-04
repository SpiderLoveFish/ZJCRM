using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Xml;
using System.Web;

/// <summary>
/// SqlDB 的摘要说明
/// </summary>
public class SqlDB
{
    /// <summary>
    /// 获取连接字符串
    /// </summary>
    private static string ConnectionString
    {
        get
        {
            string _connectionString = ConfigurationManager.AppSettings["ConnectionString"];
            string ConStringEncrypt = ConfigurationManager.AppSettings["ConStringEncrypt"];
            if (ConStringEncrypt == "true")
            {
                _connectionString = DESEncrypt.Decrypt(_connectionString);
            }
            return _connectionString;
        }
    }

    public static ReturnValue<DataTable> ExecuteDataTable(
                string cmdText,
                params SqlParameter[] paras)
    {
        var rv = new ReturnValue<DataTable>();
        var dt = new DataTable("UF_DAL_ExecuteDataTable");
        using (var conn = new SqlConnection(ConnectionString))
        {
            try
            {
                conn.Open();
            }
            catch (Exception ex)
            {
                rv.Result = false;
                rv.Message = ex.Message;
                return rv;
            }

            SqlTransaction ts = null;
            var cmd = new SqlCommand();
            var adt = new SqlDataAdapter();
            cmd.Connection = conn;
            //3600 seconds, means 1 hour
            cmd.CommandTimeout = 3600;
            cmd.CommandText = cmdText;
            if (paras != null && paras.Length > 0)
                cmd.Parameters.AddRange(paras.ToArray());
            ts = conn.BeginTransaction();
            cmd.Transaction = ts;
            adt.SelectCommand = cmd;
            try
            {
                rv.Message = adt.Fill(dt).ToString();
                ts.Commit();
            }
            catch (Exception ex)
            {
                ts.Rollback();
                rv.Result = false;
                rv.Message = ex.Message;
                return rv;
            }
            finally
            {
                cmd.Parameters.Clear();
            }

        } //end using

        rv.Output1 = dt;
        return rv;
    }

    public static ReturnValue ExecuteNoneQuery(
        string cmdText,
        params SqlParameter[] paras)
    {
        var rv = new ReturnValue();
        using (var conn = new SqlConnection(ConnectionString))
        {
            try
            {
                conn.Open();
            }
            catch (Exception ex)
            {
                rv.Result = false;
                rv.Message = ex.Message;
                return rv;
            }

            SqlTransaction ts = null;
            var cmd = new SqlCommand();
            cmd.Connection = conn;
            //3600 seconds, means 1 hour
            cmd.CommandTimeout = 3600;
            cmd.CommandText = cmdText;
            if (paras != null && paras.Length > 0)
                cmd.Parameters.AddRange(paras.ToArray());
            ts = conn.BeginTransaction();
            cmd.Transaction = ts;

            try
            {
                rv.Message = cmd.ExecuteNonQuery().ToString();
                ts.Commit();
            }
            catch (Exception ex)
            {
                ts.Rollback();
                rv.Result = false;
                rv.Message = ex.Message;
                return rv;
            }
            finally
            {
                cmd.Parameters.Clear();
            }

        } //end using

        return rv;
    }

    public static ReturnValue<DataSet> ExecuteDataSet(
        string cmdText,
        params SqlParameter[] paras)
    {
        var rv = new ReturnValue<DataSet>();
        var ds = new DataSet("UF_DAL_ExecuteDataSet");
        using (var conn = new SqlConnection(ConnectionString))
        {
            try
            {
                conn.Open();
            }
            catch (Exception ex)
            {
                rv.Result = false;
                rv.Message = ex.Message;
                return rv;
            }

            SqlTransaction ts = null;
            var cmd = new SqlCommand();
            var adt = new SqlDataAdapter();
            cmd.Connection = conn;
            //3600 seconds, means 1 hour
            cmd.CommandTimeout = 3600;
            cmd.CommandText = cmdText;
            if (paras != null && paras.Length > 0)
                cmd.Parameters.AddRange(paras.ToArray());
            ts = conn.BeginTransaction();
            cmd.Transaction = ts;
            adt.SelectCommand = cmd;
            try
            {
                rv.Message = adt.Fill(ds).ToString();
                ts.Commit();
            }
            catch (Exception ex)
            {
                ts.Rollback();
                rv.Result = false;
                rv.Message = ex.Message;
                return rv;
            }
            finally
            {
                cmd.Parameters.Clear();
            }

        } //end using
        rv.Output1 = ds;
        return rv;
    }


    public static ReturnValue<DataTable> ExecuteDataTableWithPager(
        string selectCommandPrefix,
        string selectCommand,
        string selectCommandSubfix,
        string orderbyColumns,
        bool asc,
        int skip,
        int take,
        params SqlParameter[] parameters)
    {
        var rv = new ReturnValue<DataTable>();
        //先做参数检查
        if (string.IsNullOrEmpty(orderbyColumns))
        {
            rv.Result = false;
            rv.Message = "order by Columns can't be null.";
            return rv;
        }

        string rowCondition = " WHERE ROWNUMBER BETWEEN {1} AND {2} ";
        string orderDirection = (asc ? "ASC" : "DESC");
        selectCommand = string.Format("SELECT * FROM (SELECT *,ROW_NUMBER() OVER (ORDER BY {0} {3}) AS ROWNUMBER FROM (" +
                                        selectCommand + ") a0) a" + rowCondition,
            orderbyColumns,
            skip + 1,
            skip + take,
            orderDirection);

        selectCommand = (selectCommandPrefix ?? string.Empty) +
            selectCommand +
            (selectCommandSubfix ?? string.Empty);

        return ExecuteDataTable(selectCommand, parameters);
    }
}