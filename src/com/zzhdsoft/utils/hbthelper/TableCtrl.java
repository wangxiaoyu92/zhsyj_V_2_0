/////////////////////////////////////////////////////
//  功能说明:    数据库表读写格式的管理模块类  //
//  作者:           孙建                //
//  编写日期:  2001/04/16--2001/04/17  lastmodify:2007/11/14,support hbm filelen  //
///////////////////////////////////////////////////////
package com.zzhdsoft.utils.hbthelper;

import java.io.*;
import java.util.*;
import java.sql.*;


public class TableCtrl
{
    private boolean autoCommit = true; //是否自动提交
    private Connection conn = null; //当前使用的连接
    private boolean connected = false; //是否已经连接上数据库
    public int rowcount = 0; //结果集的总数 //分页的为总行数,不是每页的总数
    private DBConnManager cm; //连接管理句柄
    private String datasource = null; //数据库连接数据源
    public String error = ""; //SQL执行错误信息
    public String sql = ""; //上次执行的SQL
    private DBQuery bqry = null; //执行批处理的DBQuery

    private String[] fieldlistname = null; //字段名称列表为小写
    private int[] fieldlisttype = null; //字段类型 0=为字符串类,1=日期,2=数字类
    private static String sqlSplitSign = ";\n";
    public String DB_CURR_USER = null; //当前数据库连接用户,schma //oracle=select user from dual

    private String TableInfoSql = null;
    final int MaxCountLog = 5001; //大于记录数的提示
    /**
     *构造方法
     */
    public TableCtrl() {
        cm = DBConnManager.getInstance();
        DB_CURR_USER = cm.DB_CURR_USER;
    }

    /*
     *不使用默认连接的构造方法
     */
    public TableCtrl(Connection c) {
        cm = DBConnManager.getInstance();
        conn = c;
        connected = true;
    }

    /**
     * 增加方法,结果集的解码
     */
    public String autoDecode(String str) {
        if (str == null)
            return "";
        if (DBQuery.defCharset.equals(cm.getCharset()))
            return str;
        else
            return PubFunc.decodeGB(str, cm.getCharset());
    }

    /** 设置连接数据源,不使用默认连接池 */
    public void setDataSource(String sdatasource) {
        datasource = sdatasource;
    }

    /** 取最大ID */
    public int getNewId(String idname) {
        return cm.getMaxId(idname);
    }

    /** 开始事务,设置为不自动提交 */
    public boolean beginTransaction() {
        try {
            getNewConn();
            conn.setAutoCommit(false);
            autoCommit = false;
            return true;
        } catch (SQLException e) {
            return false;
        }
    }

    /**  取自动提交值 */
    public boolean getAutoCommit() {
        return this.autoCommit;
    }

    /** 取是否连接 */
    public boolean getIsConnected() {
        return this.connected;
    }

    /** 事务提交 */
    public boolean commit() {
        try {
            conn.commit();
            conn.setAutoCommit(true);
            autoCommit = true;
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** 事务回滚 */
    public boolean rollback() {
        try {
            conn.rollback();
            conn.setAutoCommit(true);
            autoCommit = true;
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** 取连接管理器 */
    public DBConnManager getDBConnManager() {
        return cm;
    }

    /** 取连接 */
    private Connection getNewConn() {
        if (!connected) {
            //if (datasource == null)
                conn = cm.getConnection();
           // else
             //   conn = cm.getConnection(datasource);
            if (conn == null) {
                error = "不能获取数据库连接." + datasource;
                cm.writeLog(error);
            } else {
                connected = true;
            }
        }
        return conn;
    }

    /** 取连接 */
    public Connection getConn() {
    	//wxs
    	System.out.println("得到一个连接....wxs" );
        return getNewConn();
    }

    /** 关闭数据库连接 */
    public void freeConn() {
    	try{
    		//wxs
        	System.out.println("释放连接------wxs");
	        if (connected) {
	            if (!autoCommit) {
	                rollback();
	                cm.writeLog("您没有执行提交或回滚,数据库将自动回滚!");
	            }
	            cm.freeConnection(conn);
	            conn = null;
	            bqry = null;
	            connected = false;
	        }
    	}catch(Exception e){
    		//wxs
        	System.out.println(e.getMessage());
    	}
    }

    /**
     * 返回最后执行的SQL
     * @return String
     */
    public String getSQLLast() {
        return this.autoDecode(sql);
    }

    /** 根椐类型生成值 */
    private String getSqlFieldValueByType(String ftype, String fvalue) {
        if (fvalue==null || fvalue.equals(""))  //add fix by V309
            return null;

        String values;
//        if (fvalue!=null)
//          fvalue = fvalue.trim();
        if (ftype.equals("varchar") || ftype.equals("text") ||
            ftype.equals("char") || ftype.equals("datetime")
            || ftype.equals("varchar2") || ftype.equals("long") ||
            (ftype.equals("date") && !cm.to_date) || ftype.equals("clob"))
            values = "'" + PubFunc.toSqlStr(fvalue) + "'";
        else
        if (fvalue != null && !fvalue.equals("") && ftype.equals("date") &&
            cm.to_date) //转换日期
            values = charToDate(fvalue);
        else
            values = ((fvalue == null || fvalue.equals("")) ? "null" : fvalue);
        return values;

    }

    //根椐类型生成值
    private String getSqlFieldValueByType(int ftype, String fvalue) {
        if (fvalue==null || fvalue.equals("")) //add by V309
          return null;

        String fieldset;
//        if (fvalue!=null)
//          fvalue = fvalue.trim();
        if (ftype == 0 || ftype == 3)
            fieldset = PubFunc.toSqlStr(fvalue, 1); //转换并加引号
        else
        if (ftype == 1 && !fvalue.equals("")) //转换日期
            fieldset = charToDate(fvalue);
        else if (ftype == 2 && !fvalue.equals(""))
            fieldset = fvalue;
        else
            fieldset = "null";
        return fieldset;

    }

    /** 根椐类型生成赋值表达式 */
    private String getSqlFieldSetByType(String ftype, String fieldname,
                                        String fvalue) {
        return fieldname + "=" + getSqlFieldValueByType(ftype, fvalue);
    }

    /** 根椐类型生成赋值表达式 */
    private String getSqlFieldSetByType(int ftype, String fieldname,
                                        String fvalue) {
        return fieldname + "=" + getSqlFieldValueByType(ftype, fvalue);
    }

    /** 取SQL语句读取的用Insert表示的SQL数据,用于把现在数据生成标准sql语句 */
    public String getInsertSql(String tablename, String selectsql) {
        String inssql = "";
        Vector vec = open(selectsql);
        if (vec.size() > 0)
            getTableInfo(tablename, selectsql);
        String fnames = null;
        for (int i = 0; i < fieldlistname.length; i++) {
            if (fnames == null)
                fnames = fieldlistname[i];
            else
                fnames += ", " + fieldlistname[i];
        }
        for (int i = 0; i < vec.size(); i++) {
            String[] fieldsvalue = (String[]) vec.elementAt(i);
            inssql += getInsertRowSql(tablename, fnames, fieldsvalue) + sqlSplitSign;
        }
        return inssql;
    }

    /** 取insertRow预执行生成的SQL */
    public String getInsertRowSql(String tablename, String fieldnames,
                                  String[] fieldsvalue) {
        try {
            String fieldset = null;
            for (int i = 0; i < fieldlisttype.length; i++) {
                String fvalue = fieldsvalue[i]; //当前字段值
                //if (fvalue != null) //error bug fixed
                {
                    int ftype = fieldlisttype[i];
                    if (fieldset == null)
                        fieldset = this.getSqlFieldValueByType(ftype, fvalue);
                    else
                        fieldset += ", " +
                                this.getSqlFieldValueByType(ftype, fvalue);
                }
            }
            if (fieldset != null) {
                String strSql = "insert into " + tablename + "(" + fieldnames +
                                ") values (" + fieldset + ")";
                return strSql;
            }
        } catch (Exception e) {
            cm.writeLog("取表插入数据时出错:" + e.getMessage());
        }
        return "";
    }

    /** 取返回的SQL 字段列表 */
    public String[] getSqlFieldList(String sql) {
        getNewConn();
        if (conn == null) {
            return new String[0];
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        String names = null; //插入字段列表
        String values = null; //插入字段值列表
        try {
            if (sql.toLowerCase().indexOf(" where ") < 0)
                sql += " where 1=2";
            else
                sql = PubFunc.replace(sql, " where ", " where 1=2 and ");
            ResultSet rs = myQuery.openSQL(sql);
            error = myQuery.error;
            sql = myQuery.sql;
            ResultSetMetaData rsmt = rs.getMetaData();
            int ColumnCount = rsmt.getColumnCount();
            String fieldlist[] = new String[ColumnCount];
            String fieldtype[] = new String[ColumnCount];
            for (int i = 0; i < ColumnCount; i++) {
                fieldlist[i] = rsmt.getColumnName(i + 1).toLowerCase(); //当前字段名
                fieldtype[i] = rsmt.getColumnTypeName(i + 1).toLowerCase();

            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
            return fieldlist;
        } catch (Exception e) {
            cm.writeLog("取字段名称列表时出错:" + e.getMessage());
        }
        return new String[0];

    }

    /** 取insertRow预执行生成的SQL */
    public String getInsertRowSql(String tablename, Hashtable fieldsvalue) {
        if (!getTableInfo(tablename))
            return "";

          String names = null; //插入字段列表
          String values = null; //插入字段值列表
          for (int i = 0; i < this.fieldlistname.length; i++) {
              String fvalue = (String) fieldsvalue.get(fieldlistname[i]); //当前字段值
              if (fvalue!=null)
              {
                if (names == null) {
                  names = fieldlistname[i];
                  values = getSqlFieldValueByType(fieldlisttype[i], fvalue);
                }
                else {
                  names += ", " + fieldlistname[i];
                  values += ", " +
                      getSqlFieldValueByType(fieldlisttype[i], fvalue);
                }
              }
          }
          if (names != null) {
              String strSql = " insert into " + tablename + " (" + names +
                              ") values (" + values + ")";
              return strSql;
          }
          return "";

        /*
        getNewConn();
        if (conn == null) {
            return "";
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        String names = null; //插入字段列表
        String values = null; //插入字段值列表
        try {
            ResultSet rs = myQuery.openSQL("select * from " + tablename +
                                           " where 1=2");
            error = myQuery.error;
            sql = myQuery.sql;
            ResultSetMetaData rsmt = rs.getMetaData();
            int ColumnCount = rsmt.getColumnCount();
            for (int i = 0; i < ColumnCount; i++) {
                String fieldname = rsmt.getColumnName(i + 1).toLowerCase(); //当前字段名
                Object fo = fieldsvalue.get(fieldname.toLowerCase());
                String fvalue = (String) fo; //当前字段值
                String ftype = rsmt.getColumnTypeName(i + 1).toLowerCase();
                //        if (ftype.equals("text") || ftype.equals("long"))
                //          fvalue = PubFunc.native2Unicode(PubFunc.unicode2Native(fvalue));
                if (names == null) {
                    names = fieldname;
                    values = getSqlFieldValueByType(ftype, fvalue);
                } else {
                    names += ", " + fieldname;
                    values += ", " + getSqlFieldValueByType(ftype, fvalue);
                }
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
            if (names != null) {
                String strSql = " insert into " + tablename + " (" + names +
                                ") values (" + values + ")";
                return strSql;
            }
        } catch (Exception e) {
            cm.writeLog("执行表插入时出错:" + e.getMessage());
        }
        return ""; */
    }

    /** 日期字段转换 */
    public String charToDate(String data_value) {
        String ret = "";
        if (data_value.equals(""))
            return "null";

        if (getDBConnManager().to_date) {
            String sign = "";
            if (data_value.indexOf("/") > -1)
                sign = "/";
            else
            if (data_value.indexOf("-") > -1)
                sign = "-";
            if (data_value.length() == 8)
                ret = "to_date('" + data_value + "','yyyymmdd')";
            else
            if (data_value.length() == 20 && data_value.indexOf("T") > 0) { //20用于delphi.datapacket.dateTime格式yyyymmddThh24:mi:ssmmm
                data_value = data_value.replace('T', ' ').substring(0, 17);
                ret = "to_date('" + data_value + "','yyyy" + sign +
                      "mm" + sign + "dd hh24:mi:ss')";
            } else
            if (data_value.length() > 10) { //日期时间
                ret = "to_date('" + PubFunc.getDate(data_value) + "','yyyy" +
                      sign +
                      "mm" + sign + "dd hh24:mi:ss')";
            } else
            if (data_value.length() == 10)
                ret = "to_date('" + PubFunc.getDateStr(data_value) + "','yyyy" +
                      sign + "mm" + sign + "dd')";
        } else
            ret = "'" + PubFunc.getDate(data_value) + "'";
        return ret;
    }


    /** 执行SQL并释放数据库连接 */
    public int exec(String strSql) {
        getNewConn();
        if (conn == null) {
            return -1;
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();

        int d = myQuery.execSQL(strSql);
        error = myQuery.error;
        if (error != null && !error.equals("")) {
            //cm.writeLog("SQL执行出错:" + myQuery.error);
            System.err.println("执行SQL出错! " + error);
        }
        sql = myQuery.sql;
        return d;
    }


    /** 执行SQL把ResultSet转到Vector中并释放数据库连接 */
    public Vector open(String strSql) {
        rowcount = 0;
        getNewConn();
        Vector vec = new Vector();
        if (conn == null) {
            return vec;
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        //    boolean encode = (!myQuery.defCharset.equals(myQuery.charset.toUpperCase()));
        try {
            ResultSet rs = myQuery.openSQL(strSql);
            error = myQuery.error;
            sql = myQuery.sql;
            ResultSetMetaData rsmt = rs.getMetaData();
            int ColumnCount = rsmt.getColumnCount();
            //CLOB类型特殊处理,DATE特殊处理。
            int[] curFieldType = new int[ColumnCount];
            for (int i = 0; i < ColumnCount; i++) {
                String ctype = rsmt.getColumnTypeName(i + 1);
                if (ctype.equalsIgnoreCase("CLOB"))
                    curFieldType[i] = 3;
                else
                if (ctype.equalsIgnoreCase("DATE"))
                    curFieldType[i] = 1;
                else
                if (ctype.equalsIgnoreCase("IMAGE"))
                    curFieldType[i] = -1;
                else
                if (ctype.equalsIgnoreCase("BLOB"))
                    curFieldType[i] = -2;
                else
                    curFieldType[i] = 0;
            }

            while (rs.next()) {
                if (rowcount==MaxCountLog) //add by 2009-3-8
                {
                    cm.writeLog("SQL记录数太多,建议使用客户端分页:"+strSql);
                }

                rowcount++;
                String[] arr = new String[ColumnCount];
                for (int i = 0; i < ColumnCount; i++) {
                    //            if (encode)
                    //             arr[i] = PubFunc.decodeGB(rs.getString(i+1),myQuery.charset);
                    //           else
                    if (curFieldType[i] == -1) { //image
                        if (rs.getBinaryStream(i + 1) == null)
                            arr[i] = "";
                        else
                            arr[i] = "[IMAGE]";
                    } else
                    if (curFieldType[i] == -2) { //blob
                        Blob b = rs.getBlob(i + 1);
                        if (b == null || b.length() <= 0)
                            arr[i] = "";
                        else
                            arr[i] = "[BLOB]";
                    } else
                    if (curFieldType[i] == 3) { //CLOB
                        Clob clob = rs.getClob(i + 1);
                        if (clob == null || clob.length() == 0)
                            arr[i] = "";
                        else
                            arr[i] = autoDecode(clob.getSubString(1,
                                    (int) clob.length()));
                    } else
                    if (curFieldType[i] == 1) //DATE
                        arr[i] = PubFunc.nullToStr(PubFunc.getDate(rs.getDate(i +
                                1)));
                    else
                        arr[i] = autoDecode(rs.getString(i + 1));
                }
                vec.addElement(arr);
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
        } catch (Exception e) {
            cm.writeLog("读取数据出错:" + e.getMessage());
        }
        return vec;
    }

    /** 执行SQL把ResultSet转到Vector中并释放数据库连接,返回Hashtable记录 */
    public Vector open(String strSql, int retHasktable) {
        rowcount = 0;
        getNewConn();
        Vector vec = new Vector();
        if (conn == null) {
            return vec;
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        //    boolean encode = (!myQuery.defCharset.equals(myQuery.charset.toUpperCase()));
        try {
            ResultSet rs = myQuery.openSQL(strSql);
            error = myQuery.error;
            sql = myQuery.sql;
            ResultSetMetaData rsmt = rs.getMetaData();

            int ColumnCount = rsmt.getColumnCount();
            //CLOB类型特殊处理,DATE特殊处理。
            int[] curFieldType = new int[ColumnCount];
            String[] curFieldName = new String[ColumnCount];
            for (int i = 0; i < ColumnCount; i++) {
                String ctype = rsmt.getColumnTypeName(i + 1).toLowerCase();
                curFieldName[i] = rsmt.getColumnName(i + 1).toLowerCase();
                //重复字段名加"_1"
                if (PubFunc.inStr(curFieldName, curFieldName[i], i))
                    curFieldName[i] = curFieldName[i] + "_1";
                if (ctype.equalsIgnoreCase("clob"))
                    curFieldType[i] = 3;
                else
                if (ctype.equalsIgnoreCase("date"))
                    curFieldType[i] = 1;
                else
                if (ctype.equalsIgnoreCase("IMAGE"))
                    curFieldType[i] = -1;
                else
                if (ctype.equalsIgnoreCase("BLOB"))
                    curFieldType[i] = -2;
                else
                    curFieldType[i] = 0;
            }
            while (rs.next()) {
                if (rowcount==MaxCountLog) //add by 2009-3-8
                {
                    cm.writeLog("SQL记录数太多,建议使用客户端分页:"+strSql);
                }
                rowcount++;
                Hashtable arr = new Hashtable();
                for (int i = 0; i < ColumnCount; i++) {
                    //                if (encode)
                    //                 arr.put(curFieldName[i],PubFunc.decodeGB(rs.getString(i+1)));
                    //                else
                    if (curFieldType[i] == -2) { //blob
                        Blob b = rs.getBlob(i + 1);
                        if (b == null || b.length() <= 0)
                            arr.put(curFieldName[i], "");
                        else
                            arr.put(curFieldName[i], "BLOB");
                    } else
                    if (curFieldType[i] == -1) { //image
                        arr.put(curFieldName[i], "");
                        if (rs.getBinaryStream(i + 1) == null)
                            arr.put(curFieldName[i], "");
                        else
                            arr.put(curFieldName[i], "[IMAGE]");
                    } else
                    if (curFieldType[i] == 3) { //CLOB
                        Clob clob = rs.getClob(i + 1);
                        if (clob == null || clob.length() == 0)
                            arr.put(curFieldName[i], "");
                        else
                            arr.put(curFieldName[i],
                                    autoDecode(clob.
                                               getSubString(1, (int) clob.length())));
                    } else
                    if (curFieldType[i] == 1) //DATE
                        arr.put(curFieldName[i],
                                PubFunc.nullToStr(PubFunc.
                                                  getDate(rs.getDate(i + 1))));
                    else
                        arr.put(curFieldName[i], autoDecode(rs.getString(i + 1)));
                }
                vec.addElement(arr);
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
        } catch (Exception e) {
            cm.writeLog("读取数据出错:" + e.getMessage());
        }
        return vec;
    }

    /** 把执行过的ResultSet转到Vector中并释放数据库连接,返回Hashtable记录 */
    public Vector openResultSet(ResultSet rs, int retHasktable) {
        rowcount = 0;
        Vector vec = new Vector();
        if (conn == null) {
            return vec;
        }
        try {
            ResultSetMetaData rsmt = rs.getMetaData();

            int ColumnCount = rsmt.getColumnCount();
            //CLOB类型特殊处理,DATE特殊处理。
            int[] curFieldType = new int[ColumnCount];
            String[] curFieldName = new String[ColumnCount];
            for (int i = 0; i < ColumnCount; i++) {
                String ctype = rsmt.getColumnTypeName(i + 1).toLowerCase();
                curFieldName[i] = rsmt.getColumnName(i + 1).toLowerCase();
                //重复字段名加"_1"
                if (PubFunc.inStr(curFieldName, curFieldName[i], i))
                    curFieldName[i] = curFieldName[i] + "_1";
                if (ctype.equalsIgnoreCase("clob"))
                    curFieldType[i] = 3;
                else
                if (ctype.equalsIgnoreCase("date"))
                    curFieldType[i] = 1;
                else
                if (ctype.equalsIgnoreCase("IMAGE"))
                    curFieldType[i] = -1;
                else
                if (ctype.equalsIgnoreCase("BLOB"))
                    curFieldType[i] = -2;
                else
                    curFieldType[i] = 0;
            }
            while (rs.next()) {
                if (rowcount==MaxCountLog) //add by 2009-3-8
                {
                    cm.writeLog("SQL记录数太多,建议使用客户端分页.");
                }
                rowcount++;
                Hashtable arr = new Hashtable();
                for (int i = 0; i < ColumnCount; i++) {
                    //                if (encode)
                    //                 arr.put(curFieldName[i],PubFunc.decodeGB(rs.getString(i+1)));
                    //                else
                    if (curFieldType[i] == -2) { //blob
                        Blob b = rs.getBlob(i + 1);
                        if (b == null || b.length() <= 0)
                            arr.put(curFieldName[i], "");
                        else
                            arr.put(curFieldName[i], "BLOB");
                    } else
                    if (curFieldType[i] == -1) { //image
                        arr.put(curFieldName[i], "");
                        if (rs.getBinaryStream(i + 1) == null)
                            arr.put(curFieldName[i], "");
                        else
                            arr.put(curFieldName[i], "[IMAGE]");
                    } else
                    if (curFieldType[i] == 3) { //CLOB
                        Clob clob = rs.getClob(i + 1);
                        if (clob == null || clob.length() == 0)
                            arr.put(curFieldName[i], "");
                        else
                            arr.put(curFieldName[i],
                                    autoDecode(clob.
                                               getSubString(1, (int) clob.length())));
                    } else
                    if (curFieldType[i] == 1) //DATE
                        arr.put(curFieldName[i],
                                PubFunc.nullToStr(PubFunc.
                                                  getDate(rs.getDate(i + 1))));
                    else
                        arr.put(curFieldName[i], autoDecode(rs.getString(i + 1)));
                }
                vec.addElement(arr);
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
        } catch (Exception e) {
            cm.writeLog("读取数据出错:" + e.getMessage());
        }
        return vec;
    }


    /** 是否支持limit */
    public boolean supportsLimit() {
        return true;
    }

    /** 取Limit.SQL串 注意:目前只支持ORACLE和mysql */
    public String getLimitString(String sql, boolean AutoDisplayRowNo,
                                 int dispCount, int pageNo) {
        if (dispCount < 1 || pageNo < 0)
            return sql;
        if (cm.to_date) //Oracle
            return this.getLimitStringOracle(sql, AutoDisplayRowNo, dispCount,
                                             pageNo);
        else //mySQL
            return this.getLimitStringMySQL(sql,AutoDisplayRowNo, dispCount, pageNo);
    }

    /** 取limit.Mysql串 */
    public String getLimitStringMySQL(String sql, boolean AutoDisplayRowNo, int dispCount, int pageNo) {
        StringBuffer pagingSelect = new StringBuffer(100);
        pagingSelect.append(sql);
        pagingSelect.append(" limit ");
        pagingSelect.append(pageNo * dispCount);
        pagingSelect.append(",");
        pagingSelect.append(dispCount);
        return pagingSelect.toString();
    }

    /** 取Limit串Oracle */
    public String getLimitStringOracle(String sql, boolean AutoDisplayRowNo,
                                       int dispCount, int pageNo) {
        StringBuffer pagingSelect = new StringBuffer(100);
        if (AutoDisplayRowNo) {
            pagingSelect.append(
                    "select * from ( select rownum rowno_, row_.* from ( ");
            pagingSelect.append(sql);
            pagingSelect.append(" ) row_ where rownum <= ");
            pagingSelect.append((pageNo + 1) * dispCount);
            pagingSelect.append(") where rowno_ > ");
            pagingSelect.append(pageNo * dispCount);
        } else {
            pagingSelect.append("select * from ( select row_.*, rownum rowno_ from ( ");
            pagingSelect.append(sql);
            pagingSelect.append(" ) row_ where rownum <= ");
            pagingSelect.append((pageNo + 1) * dispCount);
            pagingSelect.append(") where rowno_ > ");
            pagingSelect.append(pageNo * dispCount);
        }
        return pagingSelect.toString();
    }


    /** 分页执行SQL把ResultSet转到Vector中并释放数据库连接 */
    public Vector open(String strSql, int dispCount, int pageNo) {
        rowcount = 0;
        getNewConn();
        Vector vec = new Vector();
        if (conn == null) {
            return vec;
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        //    boolean encode = (!myQuery.defCharset.equals(myQuery.charset.toUpperCase()));
        try {
            ResultSet rs = myQuery.openSQL(getLimitString(strSql, false,
                    dispCount, pageNo));
            error = myQuery.error;
            sql = myQuery.sql;
            ResultSetMetaData rsmt = rs.getMetaData();
            int ColumnCount = rsmt.getColumnCount();
            if (cm.to_date && dispCount > 0) //oracle的limit不显示行号的特殊处理
              ColumnCount--;
            //CLOB类型特殊处理,DATE特殊处理。
            int[] curFieldType = new int[ColumnCount];
            for (int i = 0; i < ColumnCount; i++) {
                String ctype = rsmt.getColumnTypeName(i + 1);
                if (ctype.equalsIgnoreCase("CLOB"))
                    curFieldType[i] = 3;
                else
                if (ctype.equalsIgnoreCase("DATE"))
                    curFieldType[i] = 1;
                else
                if (ctype.equalsIgnoreCase("IMAGE"))
                    curFieldType[i] = -1;
                else
                if (ctype.equalsIgnoreCase("BLOB"))
                    curFieldType[i] = -2;
                else
                    curFieldType[i] = 0;
            }
            while (rs.next()) {
                if (rowcount==MaxCountLog) //add by 2009-3-8
                {
                    cm.writeLog("SQL记录数太多,建议使用客户端分页:"+strSql);
                }
                rowcount++;
                String[] arr = new String[ColumnCount];
                for (int i = 0; i < ColumnCount; i++) {
                    //                  if (encode)
                    //                    arr[i] = PubFunc.decodeGB(rs.getString(i+1),myQuery.charset);
                    //                  else
                    if (curFieldType[i] == -1) { //image
                        if (rs.getBinaryStream(i + 1) == null)
                            arr[i] = "";
                        else
                            arr[i] = "[IMAGE]";
                    } else
                    if (curFieldType[i] == -2) { //blob
                        Blob b = rs.getBlob(i + 1);
                        if (b == null || b.length() <= 0)
                            arr[i] = "";
                        else
                            arr[i] = "[BLOB]";
                    } else
                    if (curFieldType[i] == 3) { //CLOB
                        Clob clob = rs.getClob(i + 1);
                        if (clob == null || clob.length() == 0)
                            arr[i] = "";
                        else
                            arr[i] = autoDecode(clob.getSubString(1,
                                    (int) clob.length()));
                    } else
                    if (curFieldType[i] == 1) //DATE
                        arr[i] = PubFunc.nullToStr(PubFunc.getDate(rs.getDate(i +
                                1)));
                    else
                        arr[i] = autoDecode(rs.getString(i + 1));
                }
                vec.addElement(arr);
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
        } catch (Exception e) {
            cm.writeLog("读取数据出错:" + e.getMessage());
        }
        return vec;
    }

    /** 分页执行SQL把ResultSet转到Vector中并释放数据库连接,返回Hashtable记录 */
    public Vector open(String strSql, int retHasktable, int dispCount,
                       int pageNo) {
        rowcount = 0;
        getNewConn();
        Vector vec = new Vector();
        if (conn == null) {
            return vec;
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        //    boolean encode = (!myQuery.defCharset.equals(myQuery.charset.toUpperCase()));
        try {
            ResultSet rs = myQuery.openSQL(getLimitString(strSql, false,
                    dispCount, pageNo));
            error = myQuery.error;
            sql = myQuery.sql;
            ResultSetMetaData rsmt = rs.getMetaData();

            int ColumnCount = rsmt.getColumnCount();
            if (cm.to_date && dispCount > 0) //oracle的limit不显示行号的特殊处理
              ColumnCount--;

            //CLOB类型特殊处理,DATE特殊处理。
            int[] curFieldType = new int[ColumnCount];
            String[] curFieldName = new String[ColumnCount];
            for (int i = 0; i < ColumnCount; i++) {
                String ctype = rsmt.getColumnTypeName(i + 1).toLowerCase();
                curFieldName[i] = rsmt.getColumnName(i + 1).toLowerCase();
                //重复字段名加"_1"
                if (PubFunc.inStr(curFieldName, curFieldName[i], i))
                    curFieldName[i] = curFieldName[i] + "_1";

                if (ctype.equalsIgnoreCase("clob"))
                    curFieldType[i] = 3;
                else
                if (ctype.equalsIgnoreCase("date"))
                    curFieldType[i] = 1;
                else
                if (ctype.equalsIgnoreCase("IMAGE"))
                    curFieldType[i] = -1;
                else
                if (ctype.equalsIgnoreCase("BLOB"))
                    curFieldType[i] = -2;
                else
                    curFieldType[i] = 0;
            }
            while (rs.next()) {
                if (rowcount==MaxCountLog) //add by 2009-3-8
                {
                    cm.writeLog("SQL记录数太多,建议使用客户端分页:"+strSql);
                }
                rowcount++;
                Hashtable arr = new Hashtable();
                for (int i = 0; i < ColumnCount; i++) {
                    //                  if (encode)
                    //                   arr.put(rsmt.getColumnName(i+1).toLowerCase(),PubFunc.decodeGB(rs.getString(i+1)));
                    //                  else
                    if (curFieldType[i] == -2) { //blob
                        Blob b = rs.getBlob(i + 1);
                        if (b == null || b.length() <= 0)
                            arr.put(curFieldName[i], "");
                        else
                            arr.put(curFieldName[i], "[BLOB]");
                    } else
                    if (curFieldType[i] == -1) { //image
                        arr.put(curFieldName[i], "");
                        if (rs.getBinaryStream(i + 1) == null)
                            arr.put(curFieldName[i], "");
                        else
                            arr.put(curFieldName[i], "[IMAGE]");
                    } else
                    if (curFieldType[i] == 3) { //CLOB
                        Clob clob = rs.getClob(i + 1);
                        if (clob == null || clob.length() == 0)
                            arr.put(curFieldName[i], "");
                        else
                            arr.put(curFieldName[i],
                                    autoDecode(clob.
                                               getSubString(1,
                                    (int) clob.length())));
                    } else
                    if (curFieldType[i] == 1) //DATE
                        arr.put(curFieldName[i],
                                PubFunc.nullToStr(PubFunc.
                                                  getDate(rs.getDate(i + 1))));
                    else
                        arr.put(curFieldName[i],
                                autoDecode(rs.getString(i + 1)));
                }
                vec.addElement(arr);
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
        } catch (Exception e) {
            cm.writeLog("读取数据出错:" + e.getMessage());
        }
        return vec;
    }


    /** 分页执行SQL把ResultSet转到Vector中并释放数据库连接,返回Hashtable记录的向量集合,add for 并返回字段名及字段类型长度信息 */
    public Vector open(String strSql, boolean AutoDisplayRowNo,
                       int retHasktable, int dispCount, int pageNo,
                       Vector vecReturnFieldNameTypeList) {
        rowcount = 0;
        getNewConn();
        Vector vec = new Vector();
        if (conn == null) {
            return vec;
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        //    boolean encode = (!myQuery.defCharset.equals(myQuery.charset.toUpperCase()));
        try {
            ResultSet rs = myQuery.openSQL(getLimitString(strSql,
                    AutoDisplayRowNo, dispCount, pageNo));
            error = myQuery.error;
            sql = myQuery.sql;
            ResultSetMetaData rsmt = rs.getMetaData();

            int ColumnCount = rsmt.getColumnCount();
            if (cm.to_date && dispCount > 0 && !AutoDisplayRowNo) //oracle的limit不显示行号的特殊处理
              ColumnCount--;

            boolean firstDisplayRowNo_ = false; //是否显示行号
            int start = 0;
            if (dispCount <= 0 && AutoDisplayRowNo) { //显示行号
                firstDisplayRowNo_ = true;
                start = 1;
            }
            //CLOB类型特殊处理,DATE特殊处理。
            int[] curFieldType = new int[ColumnCount + start];
            String[] curFieldName = new String[ColumnCount + start];

            if (firstDisplayRowNo_) { //显示行号
                curFieldName[0] = "rowno_";
                curFieldType[0] = 0;
                Hashtable hashReturnFieldNameTypeCol = new Hashtable();
                hashReturnFieldNameTypeCol.put("fieldname", curFieldName[0]);
                hashReturnFieldNameTypeCol.put("fieldtype", "i4");
                hashReturnFieldNameTypeCol.put("fieldlen", "0");
                hashReturnFieldNameTypeCol.put("fieldlenHbm", "4");
                vecReturnFieldNameTypeList.add(hashReturnFieldNameTypeCol);
            }

            for (int x = 0; x < ColumnCount; x++) {
                int col = start + x;
                Hashtable hashReturnFieldNameTypeCol = new Hashtable();
                String ctype = rsmt.getColumnTypeName(x + 1).toLowerCase();
                curFieldName[col] = rsmt.getColumnName(x + 1).toLowerCase();

                if (curFieldName[col] != null &&
                    curFieldName[col].length() >= 30)
                    curFieldName[col] = curFieldName[col].substring(0, 29);

                //重复字段名加"_1"
                if (PubFunc.inStr(curFieldName, curFieldName[col], col))
                    curFieldName[col] = curFieldName[col] + "_1";

                hashReturnFieldNameTypeCol.put("fieldname", curFieldName[col]);
                String fieldtype = "string";
                int fieldlen = 0;
                int fieldlenHbm = 0; //disp len
                if (ctype.equals("clob") || ctype.equals("long")) {
                    curFieldType[col] = 3;
                    fieldlen = 255;
                    fieldtype = "string";
                } else
                if (ctype.equals("date")) {
                    curFieldType[col] = 1;
                    if (getDBConnManager().to_date)//这里注意zjf
                        fieldtype = "dateTime";
                    else
                        fieldtype = "date";
                    fieldlen = 0;
                    fieldlenHbm = 7;
                } else
                if (ctype.equals("image")) {
                    curFieldType[col] = -1;
                    fieldtype = "string";
                    fieldlen = 10;
                    fieldlenHbm = 10;
                } else
                if (ctype.equals("blob")) {
                    curFieldType[col] = -2;
                    fieldtype = "string";
                    fieldlen = 10;
                    fieldlenHbm = 10;
                } else
                if (ctype.indexOf("char") > -1) { //字符类型
                    curFieldType[col] = 0;
                    fieldtype = "string";
                    fieldlen = rsmt.getColumnDisplaySize(x + 1);
                    fieldlenHbm = fieldlen;
                    if (fieldlen<1)
                      fieldlen = 1;
                } else
                if (ctype.indexOf("int") > -1 ||
                    col == 0 && curFieldName[col].equals("rowno_")) { //字符类型
                    curFieldType[col] = 0;
                    fieldtype = "i4";
                    fieldlen = 0;
                    fieldlenHbm = 8;
                } else
                if (ctype.indexOf("number") > -1 || ctype.indexOf("numer") > -1 ||
                    ctype.indexOf("float") > -1 || ctype.indexOf("double") > -1) { //浮点型
                    int slen = rsmt.getScale(x + 1);
                    int plen=rsmt.getPrecision(x+1);
                    fieldlen = 0;
                    if (slen > 0 || plen==0) { //小数点右边的位数
                        curFieldType[col] = 8; //modify by 2007-10-10 支持长整型和double
                        fieldtype = "r8";
                    } else {                    	
	                   		if(plen > 8 ){
	                    		 curFieldType[col] = 9; //支持LONG
	                             fieldtype = "l10";
	                    	}else{
	                            curFieldType[col] = 7; //支持Integer
	                            fieldtype = "i4";
	                    	}  
                    	
                    }
                    
                    
                    fieldlenHbm = rsmt.getPrecision(x + 1) + slen;
                } else
                if (ctype.indexOf("bool") > -1) { //字符类型
                    curFieldType[col] = 0;
                    fieldtype = "boolean";
                    fieldlen = 0;
                    fieldlenHbm = 1;
                } else {
                    curFieldType[col] = 0;
                    fieldtype = "string";
                    fieldlen = rsmt.getColumnDisplaySize(x + 1);
                    if (fieldlen<1)
                      fieldlen = 1;
                    fieldlenHbm = fieldlen;
                }

                hashReturnFieldNameTypeCol.put("fieldtype", fieldtype);
                hashReturnFieldNameTypeCol.put("fieldlen",
                                               String.valueOf(fieldlen));
                hashReturnFieldNameTypeCol.put("fieldlenHbm",
                                               String.valueOf(fieldlenHbm));
                vecReturnFieldNameTypeList.add(hashReturnFieldNameTypeCol);

            }
            while (rs.next()) {
                if (rowcount==MaxCountLog) //add by 2009-3-8
                {
                    cm.writeLog("SQL记录数太多,建议使用客户端分页:"+strSql);
                }
                rowcount++;
                Hashtable arr = new Hashtable();
                if (start > 0)
                    arr.put("rowno_", String.valueOf(rowcount));
                for (int x = 0; x < ColumnCount; x++) {
                    //                  if (encode)
                    //                   arr.put(rsmt.getColumnName(i+1).toLowerCase(),PubFunc.decodeGB(rs.getString(i+1)));
                    //                  else
                    int col = x + start;
                    if (curFieldType[col] == -2) { //blob
                        Blob b = rs.getBlob(x + 1);
                        if (b == null || b.length() <= 0)
                            arr.put(curFieldName[col], "");
                        else
                            arr.put(curFieldName[col], "[BLOB]");
                    } else
                    if (curFieldType[col] == -1) { //image
                        arr.put(curFieldName[col], "");
                        if (rs.getBinaryStream(x + 1) == null)
                            arr.put(curFieldName[col], "");
                        else
                            arr.put(curFieldName[col], "[IMAGE]");
                    } else
                    if (curFieldType[col] == 3) { //CLOB
                        Clob clob = rs.getClob(x + 1);
                        if (clob == null || clob.length() == 0)
                            arr.put(curFieldName[col], "");
                        else
                            arr.put(curFieldName[col],
                                    autoDecode(clob.
                                               getSubString(1,
                                    (int) clob.length())));
                    } else
                    if (curFieldType[col] == 1) { //DATE
//                    arr.put(curFieldName[col],
//                            PubFunc.nullToStr(PubFunc.getDate(rs.getDate(x+1))));
                        Timestamp dt = rs.getTimestamp(x + 1);
                        if (dt == null)
                            arr.put(curFieldName[col], "");
                        else {
                            Calendar d = Calendar.getInstance();
                            d.setTimeInMillis(dt.getTime());
                            String sd = PubFunc.getDate(d);
                            if (sd.endsWith(" 00:00:00")) { //不带时间的
                                sd = sd.substring(0, 10);
                            }
                            //delphi.datapacket.dateTime格式yyyymmddThh24:mi:ssmmm
                            arr.put(curFieldName[col],
                                    PubFunc.replace(PubFunc.replace(sd, "/", ""),
                                    " ", "T"));

                        }
                    } else
                    if (curFieldType[col] == 8) { //float,numer(x,y) y>0
                        String curnumber = PubFunc.toString(rs.getString(x + 1));
                        if (curnumber.indexOf("E") > -1)
                            curnumber = String.valueOf(rs.getDouble(x + 1));
                        arr.put(curFieldName[col], curnumber);
                    } else
                    if (curFieldType[col] == 7) { //number,
                        String curnumber = PubFunc.toString(rs.getString(x + 1));
                        if (curnumber.indexOf("E") > -1)
                            curnumber = String.valueOf(rs.getLong(x + 1));
                        arr.put(curFieldName[col], curnumber);
                    } else
                        arr.put(curFieldName[col],
                                autoDecode(rs.getString(x + 1)));
                }
                vec.addElement(arr);
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
        } catch (Exception e) {
            cm.writeLog("读取数据出错:" + e.getMessage());
        }
        return vec;
    }


    /** 分页执行SQL把ResultSet转到Vector中并释放数据库连接,返回Hashtable记录的向量集合,add for 并返回字段名及字段类型长度信息 */
    public Vector open(String strSql, boolean AutoDisplayRowNo,
                       int retHasktable, Vector vecReturnFieldNameTypeList) {
        return open(strSql, AutoDisplayRowNo, retHasktable, -1, -1,
                    vecReturnFieldNameTypeList);
    }


    /**插入表,注:fieldsvalue在赋值时字段名要小写 return (1=success,-1,0=fail)
     *example:
     *  Hashtable row = new Hashtable();
     *  row.put("a","a"); //char
     *  row.put("b","dfaa"); //varchar
     *  row.put("c","dfsafsa\nfkjsdalk\nfdsk"); //text
     *  row.put("d",PubFunc.getNow()); //datetime
     *  row.put("e",String.valueOf(2)); //int
     *  row.put("f",String.valueOf(5.25)); //float
     *  int ret = db.insertRow("test",row);
     */
    public int insertRow(String tablename, Hashtable fieldsvalue) {
        String sql = getInsertRowSql(tablename, fieldsvalue);
        if (sql!=null && !sql.equals(""))
          return exec(sql);
        else
          return 0;
        /*
        getNewConn();
        if (conn == null) {
            return -1;
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        String names = null; //插入字段列表
        String values = null; //插入字段值列表
        try {
            ResultSet rs = myQuery.openSQL("select * from " + tablename +
                                           " where 1=2");
            error = myQuery.error;
            sql = myQuery.sql;
            ResultSetMetaData rsmt = rs.getMetaData();
            int ColumnCount = rsmt.getColumnCount();
            for (int i = 0; i < ColumnCount; i++) {
                String fieldname = rsmt.getColumnName(i + 1).toLowerCase(); //当前字段名
                Object fo = fieldsvalue.get(fieldname.toLowerCase());
                String fvalue = (String) fo; //当前字段值
                String ftype = rsmt.getColumnTypeName(i + 1).toLowerCase();
                //        if (ftype.equals("text") || ftype.equals("long"))
                //          fvalue = PubFunc.native2Unicode(PubFunc.unicode2Native(fvalue));
                if (names == null) {
                    names = fieldname;
                    values = this.getSqlFieldValueByType(ftype, fvalue);
                } else {
                    names += ", " + fieldname;
                    values += ", " + this.getSqlFieldValueByType(ftype, fvalue);
                }
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
            if (names != null) {
                String strSql = " insert into " + tablename + " (" + names +
                                ") values (" + values + ")";
                int r = myQuery.execSQL(strSql);
                error = myQuery.error;
                sql = myQuery.sql;
                return r;
            }
        } catch (Exception e) {
            cm.writeLog("执行表插入时出错:" + e.getMessage());
        }
        return -1; */
    }

    /** 取通过Hashtable条件生成字符串条件 */
    public String getCondition(String tablename, Hashtable fieldsvalue) {
        if (!this.getTableInfo(tablename))
            return null;
          String cond = null; //删除字段条件列表
          for (int i = 0; i < this.fieldlistname.length; i++) {

              String fvalue = (String) fieldsvalue.get(fieldlistname[i]); //当前字段值
              if (fvalue != null && !fvalue.equals("")) {
//              if (fieldlisttype[i]==1) //日期的条件跳过 //bug fix by 329
//                  continue;
                if (fieldlisttype[i] == 1) { //日期的不判断时间,只判断日期 //bug fix by 329
                  //19981231T00:00:00000
                  if (fvalue.length() == 20 && fvalue.indexOf("T") > 0) //20用于delphi.datapacket.dateTime格式yyyymmddThh24:mi:ssmmm
                    fvalue = fvalue.substring(0, 8); //去除日期中的时间
                  else
                  if (fvalue.length() > 10) {
                    fvalue = fvalue.substring(0, 10); //去除日期中的时间
                    fvalue = fvalue.substring(0, 4) + fvalue.substring(6, 7) +
                        fvalue.substring(9, 10);
                  }
                  if (getDBConnManager().to_date) //oracle的处理,其它数据库的条件未处理
                  {
                    if (cond == null)
                      cond = "to_char(" + fieldlistname[i] + ",'yyyymmdd')='" +
                          fvalue + "'";
                    else
                      cond += " and to_char(" + fieldlistname[i] +
                          ",'yyyymmdd')='" + fvalue + "'";
                  }
                  else // @todo oracle的处理,其它数据库的条件未处理
                  {

                  }

                }
                else {

                  if (cond == null)
                    cond = getSqlFieldSetByType(fieldlisttype[i],
                                                fieldlistname[i], fvalue);
                  else
                    cond += " and " +
                        getSqlFieldSetByType(fieldlisttype[i], fieldlistname[i],
                                             fvalue);
                }
              }
          }
          return cond;


      /*
        getNewConn();
        if (conn == null) {
            return null;
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        try {
            ResultSet rs = myQuery.openSQL("select * from " + tablename +
                                           " where 1=2");
            error = myQuery.error;
            sql = myQuery.sql;
            ResultSetMetaData rsmt = rs.getMetaData();
            String cond = null; //删除字段条件列表
            int ColumnCount = rsmt.getColumnCount();
            for (int i = 0; i < ColumnCount; i++) {
                String fieldname = rsmt.getColumnName(i + 1).toLowerCase(); //当前字段名
                String fieldtype = rsmt.getColumnTypeName(i + 1).toUpperCase(); //当前字段类型;
                if ("DATE".equals(fieldtype) || "DATETIME".equals(fieldtype)) //日期的条件跳过
                    continue;

                String fvalue = (String) fieldsvalue.get(fieldname.toLowerCase()); //当前字段值

                if (fvalue != null) {
                    String ftype = rsmt.getColumnTypeName(i + 1).toLowerCase();
                    if (fvalue != null && !fvalue.equals("")) {
                        if (cond == null)
                            cond = this.getSqlFieldSetByType(ftype, fieldname,
                                    fvalue);
                        else
                            cond += " and " +
                                    this.getSqlFieldSetByType(ftype, fieldname,
                                    fvalue);
                    }
                }
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
            return cond;
        } catch (Exception e) {
            return null;
        }*/
    }

    //取删除的条件
    public String getDeleteRowSql(String tablename, Hashtable fieldsvalue)
    {
      String cond = getCondition(tablename, fieldsvalue);
      if (cond != null) {
          String strSql = "delete from " + tablename + " where " + cond + "";
          return strSql;
      }
      return "";
    }

    /** 删除表中符合条件行 */
    public int deleteRow(String tablename, Hashtable fieldsvalue) {
        String sql = getDeleteRowSql(tablename, fieldsvalue);
        if (sql != null && !sql.equals("")) {
            return exec(sql);
        }
        return 0;
    }

    /** 删除表中符合条件行,按关键字取条件 */
    public int deleteRow(String tablename, Hashtable condvalue,
                         Vector primaryKeys) {
        if (primaryKeys == null || primaryKeys.size() == 0)
            return deleteRow(tablename, condvalue);
        Hashtable condition = new Hashtable();
        for (int i = 0; i < primaryKeys.size(); i++) {
            String fieldname = PubFunc.toString(primaryKeys.elementAt(i));
            Object value = condvalue.get(fieldname);
            if (value != null)
                condition.put(fieldname, value);
        }
        return deleteRow(tablename, condition);
    }

    /** 更新long,image字段 mssql=image, oracle=long,long raw */
    public int updateFileField(String tablename, String fieldname,
                               String blobfile, String condition) {
        getNewConn();
        if (conn == null) {
            return -1;
        }
        try {
            File file = new File(blobfile);
            FileInputStream inputstream = new FileInputStream(file);
            return updateFileField(tablename, fieldname,
                                   (InputStream) inputstream, (int) file.length(),
                                   condition);
        } catch (Exception e) {
            cm.writeLog("执行表LOB字段更新时出错:" + e.getMessage());
        }
        return -1;
    }

    /** 更新image/long字段 mssql=image, oracle=long,long raw */
    public int updateFileField(String tablename, String fieldname,
                               InputStream inputstream, int size,
                               String condition) {
        getNewConn();
        if (conn == null) {
            return -1;
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        try {
            PreparedStatement stmt = conn.prepareStatement(
                    "update " + tablename + " set " + fieldname + " = ? where " +
                    condition);

            stmt.setBinaryStream(1, inputstream, size);
            return stmt.executeUpdate();
        } catch (Exception e) {
            cm.writeLog("执行表LOB字段更新时出错:" + e.getMessage());
        }
        return -1;
    }


    /** 更新image/long字段 mssql=image, oracle=long,long raw */
    public int updateFileFieldContent(String tablename, String fieldname,
                                      String filecontent, String condition) {
        getNewConn();
        if (conn == null) {
            return -1;
        }
        try {
            byte[] b = filecontent.getBytes();
            ByteArrayInputStream inputstream = new ByteArrayInputStream(b);
            return updateFileField(tablename, fieldname,
                                   (InputStream) inputstream, b.length,
                                   condition);
        } catch (Exception e) {
            cm.writeLog("执行表LOB字段更新时出错:" + e.getMessage());
        }
        return -1;
    }

    /** 读取文本型IMAGE文本字段的值//mssql=image, oracle=long,long raw*/
    public String getFileFieldContent(String tablename, String filefieldname,
                                      String condition) {
        ByteArrayOutputStream o = new ByteArrayOutputStream(65535);
        if (getFileField((OutputStream) o, tablename, filefieldname, condition) >
            0)
            return o.toString();
        else
            return "";
    }

    /** 读image/long字段 mssql=image, oracle=long,long raw */
    public int getFileField(String tablename, String filefieldname,
                            String filename, String condition) {
        getNewConn();
        if (conn == null) {
            return -1;
        }
        try {
            File file = new File(filename);
            FileOutputStream outputstream = new FileOutputStream(file);
            int ret = getFileField(outputstream, tablename, filefieldname,
                                   condition);
            outputstream.close();
            return ret;
        } catch (Exception e) {
            cm.writeLog("读取二进制字段时出错:" + e.getMessage());
        }
        return -1;

    }

    //输出文件型字段的内容
    public int getFileField(OutputStream outputstream, String tablename,
                            String filefieldname, String condition) {
        getNewConn();
        if (conn == null) {
            return -1;
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        try {
            ResultSet rs = myQuery.openSQL("select " + filefieldname + " from " +
                                           tablename + " where " + condition);
            error = myQuery.error;
            sql = myQuery.sql;
            if (rs.next()) {
                InputStream is = rs.getBinaryStream(1);
                byte[] b = new byte[128 * 1024];
                if (is == null)
                    return 0;
                int len = is.read(b);
                while (len > 0) {
                    outputstream.write(b, 0, len);
                    len = is.read(b);
                }
                try {
                    rs.close();
                } catch (Exception eers) {
                }
                return 1;
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
            return 0;
        } catch (Exception e) {
            cm.writeLog("读取二进制字段时出错:" + e.getMessage());
        }
        return -1;
    }

    /*    //输出文件型字段的内容
        public int getBlobField(OutputStream outputstream, String tablename, String filefieldname, String condition)
        {
            getNewConn();
            if (conn == null) {
              return -1;
            }
            DBQuery myQuery=new DBQuery(cm, conn);
            myQuery.charset = cm.getCharset();
            try
            {
              ResultSet rs=myQuery.openSQL("select "+filefieldname+" from "+tablename+" where "+condition);
              error = myQuery.error;
              sql = myQuery.sql;
              if (rs.next())
              {
                Blob blob = rs.getBlob(1);
                byte[] b = new byte[128*1024];
                if (blob == null)
                  return 0;
                InputStream is = blob.getBinaryStream();
                while (true)
                {
                  int readsize = is.read(b);
                  if (readsize>0)
                    outputstream.write(b, 0, readsize);
                  else
                    break;
                }

                try
                {
                    rs.close();
                }catch(Exception eers)
                {
                }
                return 1;
              }
              try
              {
                  rs.close();
              }catch(Exception eers)
              {
              }
              return 0;
            }
            catch(Exception e)
            {
              cm.writeLog("读取二进制字段时出错:"+e.getMessage());
            }
            return -1;
        }
     */
    /** 更新表记录,fieldsvalue 为更新的值,condition为条件 */
    public int updateRow(String tablename, Hashtable fieldsvalue,
                         String condition) {
        sql = getUpdateRowSql(tablename, fieldsvalue, condition);
        return exec(sql);
    }

    /** 取表中的关键字列表 */
    public Vector getPrimaryKeys(String tablename) {
        Vector vec = new Vector();
        getNewConn();
        if (conn == null) {
            return vec;
        }
        try {

            String TABLE_SCHEM = DB_CURR_USER; //默认为当前用户,空时取所有用户(SCHEMA)的关键字
            int pos = tablename.indexOf(".");
            if (pos > 0) {
                TABLE_SCHEM = tablename.substring(0, pos).toUpperCase();
                tablename = tablename.substring(pos + 1);
            }

            ResultSet rs = conn.getMetaData().getPrimaryKeys(null, TABLE_SCHEM,
                    tablename.toUpperCase()); //conn.getCatalog(),null,tablename
            while (rs.next()) {
                String column_name = rs.getString("COLUMN_NAME");
                if (column_name != null && vec.indexOf(column_name)<0) { //fix 2007.11.14
                    vec.add(column_name.toLowerCase());
                }
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
            return vec;
        } catch (Exception e) {
            cm.writeLog("取表关键字段列表出错:" + e.getMessage());
            return vec;
        }
    }

    /** 更新表记录,条件是通过fieldsvalue中的关键字值条件获取的 */
    public int updateRow(String tablename, Hashtable fieldsvalue,
                         Hashtable condvalue, Vector primaryKeys) {
        if (primaryKeys == null || primaryKeys.size() == 0)
            return this.updateRow(tablename, fieldsvalue, condvalue);
        Hashtable condition = new Hashtable();
        try {
            for (int i = 0; i < primaryKeys.size(); i++) {
                String fieldname = PubFunc.toString(primaryKeys.elementAt(i));
                Object value = condvalue.get(fieldname);
                if (value != null)
                    condition.put(fieldname, value);
            }
            return this.updateRow(tablename, fieldsvalue, condition);
        } catch (Exception e) {
            cm.writeLog("在更新表时出错:" + e.getMessage());
            return -1;
        }
    }

    /** 取更新字符串 */
    public String getUpdateRowSql(String tablename, Hashtable fieldsvalue,
                                  String condition) {
        if (this.getTableInfo(tablename))
            return getUpdateRowSql2(tablename, fieldsvalue, condition);
        else
            return "";
      /*
        getNewConn();
        if (conn == null) {
            return "";
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        try {
            ResultSet rs = myQuery.openSQL("select * from " + tablename +
                                           " where 1=2");
            error = myQuery.error;
            sql = myQuery.sql;
            ResultSetMetaData rsmt = rs.getMetaData();
            String fieldset = null; //更新字段列表
            int ColumnCount = rsmt.getColumnCount();
            for (int i = 0; i < ColumnCount; i++) {
                String fieldname = rsmt.getColumnName(i + 1).toLowerCase(); //当前字段名
                String fvalue = (String) fieldsvalue.get(fieldname.toLowerCase()); //当前字段值
                if (fvalue != null) {
                    String ftype = rsmt.getColumnTypeName(i + 1).toLowerCase();
                    if (fieldset == null)
                        fieldset = this.getSqlFieldSetByType(ftype, fieldname,
                                fvalue);
                    else
                        fieldset += ", " +
                                this.getSqlFieldSetByType(ftype, fieldname,
                                fvalue);
                }
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
            if (fieldset != null) {
                String strSql = "update " + tablename + " set " + fieldset +
                                " where " + condition;
                return strSql;
            }
        } catch (Exception e) {
            cm.writeLog("执行表更新时出错:" + e.getMessage());
        }
        return ""; */
    }

    /** 批更新开始 取表结构信息 */
    public boolean getTableInfo(String tablename) {
        return getTableInfo(tablename,
                            "select * from " + tablename + " where 1=2");
    }

    /** 批更新开始 取表结构信息 */
    public boolean getTableInfo(String tablename, String sql) {
        getNewConn();
        if (conn == null) {
            return false;
        }

        if (TableInfoSql!=null && TableInfoSql.equals(sql)) //加入cache V308
          return true;
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        try {
            ResultSet rs = myQuery.openSQL(sql);
            error = myQuery.error;
            sql = myQuery.sql;
            ResultSetMetaData rsmt = rs.getMetaData();
            String fieldset = null; //更新字段列表
            int ColumnCount = rsmt.getColumnCount();
            fieldlistname = new String[ColumnCount]; //字段名称列表为小写
            fieldlisttype = new int[ColumnCount]; //字段类型 0=为字符串类,1=日期,2=数字类
            for (int i = 0; i < ColumnCount; i++) {
                fieldlistname[i] = rsmt.getColumnName(i + 1).toLowerCase(); //当前字段名

                String ftype = rsmt.getColumnTypeName(i + 1).toLowerCase();
                if (ftype.equals("varchar") || ftype.equals("text") ||
                    ftype.equals("char") || ftype.equals("datetime")
                    || ftype.equals("varchar2") || ftype.equals("long") ||
                    (ftype.equals("date") && !cm.to_date) ||
                    ftype.equals("clob"))
                    fieldlisttype[i] = 0;
                else
                if (ftype.equals("date") && cm.to_date) //转换日期
                    fieldlisttype[i] = 1;
                else
                    fieldlisttype[i] = 2;
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
            TableInfoSql = sql; //放入cache中 V309
            return true;
        } catch (Exception e) {
            cm.writeLog("取表结构信息出错:" + e.getMessage());
        }
        return false;
    }

    /** 批更新结束 */
    public void endUpdate() {
        fieldlistname = null; //字段名称列表为小写
        fieldlisttype = null; //字段类型 0=为字符串类,1=日期,2=数字类
    }

    /*批更新*/
    public int updateRow2(String tablename, Hashtable fieldsvalue,
                          String condition) {
        if (fieldlistname == null) {
            boolean ret = getTableInfo(tablename);
            if (!ret)
                return -1;
        }
        sql = getUpdateRowSql2(tablename, fieldsvalue, condition);
        return exec(sql);
    }

    /** 取更新字符串 */
    public String getUpdateRowSql2(String tablename, Hashtable fieldsvalue,
                                   String condition) {
        try {
            String fieldset = null;
            for (int i = 0; i < fieldlistname.length; i++) {
                String fvalue = (String) fieldsvalue.get(fieldlistname[i]); //当前字段值
                if (fvalue != null) {
                    int ftype = fieldlisttype[i];
                    if (fieldset == null)
                        fieldset = this.getSqlFieldSetByType(ftype, fieldlistname[i],
                                fvalue);
                    else
                        fieldset += ", " +
                                this.getSqlFieldSetByType(ftype, fieldlistname[i],
                                fvalue);
                }
            }
            if (fieldset != null) {
                String strSql = "update " + tablename + " set " + fieldset +
                                " where " + condition;
                return strSql;
            }
        } catch (Exception e) {
            cm.writeLog("执行表更新时出错:" + e.getMessage());
        }
        return "";
    }

    /** 取更新的sql字符串 */
    public String getUpdateRowSql(String tablename, Hashtable fieldsvalue,
                                  Hashtable condition) {
        String cond = getCondition(tablename, condition);
        if (cond != null)
            return getUpdateRowSql(tablename, fieldsvalue, cond);
        else
            return "";
    }


    /** 更新表 */
    public int updateRow(String tablename, Hashtable fieldsvalue,
                         Hashtable condition) {
        String cond = getCondition(tablename, condition);
        if (cond != null)
            return updateRow(tablename, fieldsvalue, cond);
        return 0;
    }

    /** 更新表 */
    public int updateRow(String tablename, String fieldset, Hashtable condition) {
        String cond = getCondition(tablename, condition);
        if (cond != null)
            return exec("update " + tablename + " set" + fieldset + " where " +
                        cond);
        return 0;
    }

    /** 删除指定的记录 */
    public int del(String prop_tableName, String prop_key, int ID) {
        return exec("delete " + prop_tableName + " where " + prop_key + " = " +
                    String.valueOf(ID));
    }

    /** 删除所有的记录 */
    public int delAll(String prop_tableName) {
        return exec("truncate table " + prop_tableName);
    }

    /** 修改指定的记录 */
    public int update(String prop_tableName, String prop_key, int ID,
                      String fieldset) {
        return exec("update " + prop_tableName + " set " + fieldset +
                    " where " + prop_key + " = " + String.valueOf(ID));
    }

    /** 修改指定的记录按条件 */
    public int update(String prop_tableName, String fieldset, String condition) {
        return exec("update " + prop_tableName + " set " + fieldset +
                    " where " + condition);
    }

    /** 查询指定的记录 */
    public Vector select(String prop_tableName, String prop_key, int ID) {
        return open("select * from " + prop_tableName + " where " + prop_key +
                    " = " + String.valueOf(ID));
    }

    /** 取查询语句的记录总数- 已有连接 */
    private int getRowCount(Connection c, String sql) {
        DBQuery myQuery = new DBQuery(cm, c);
        myQuery.charset = cm.getCharset();

        String s;
        if (cm.to_date)                 //V310 ,bug fix
        {
          s = "select count(*) from ("+sql+")";
        }
        else
        {
          s = sql.toLowerCase();
          if (s.indexOf("from")!=s.lastIndexOf("from") || sql.indexOf("group by")>0)
           //fix by 2009-05-11 sj 带子查询的 转为 这种，支持mysql 4.1及以上
               s = "select count(*) from ("+sql+") as acount";
          else
          {
              int i = s.lastIndexOf("order by");
              if (i > 0)
                  s = "select count(*) " +
                      sql.substring(s.indexOf("from"),
                                    s.lastIndexOf("order by"));
              else
                  s = "select count(*) " + sql.substring(s.indexOf("from"));
          }

        }
        try {
            ResultSet rs = myQuery.openSQL(s);
            error = myQuery.error;
            sql = myQuery.sql;

            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return 0;
            }
        } catch (Exception E) {
            return -1;
        }
    }

    /** 取查询语句的记录总数- 没有连接 */
    public int getRowCount(String sql) {
        getNewConn();
        if (conn == null) {
            return 0;
        }
        return getRowCount(conn, sql);
    }

    /** 取指定字段的查询值 */
    public String getFieldValue(String prop_tableName, String field,
                                String condition) {
        getNewConn();
        if (conn == null) {
            return "";
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        String s = "";
        try {
            ResultSet rs = myQuery.openSQL("select " + field + " from " +
                                           prop_tableName + " where " +
                                           condition);
            error = myQuery.error;
            sql = myQuery.sql;
            if (rs.next()) {
                s = autoDecode(rs.getString(1));
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
        } catch (Exception E) {}
        return s;
    }

    /** 取指定字段的查询值 */
    public String getFieldValue(String osql) {
        getNewConn();
        if (conn == null) {
            return "";
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        String s = "";
        try {
            ResultSet rs = myQuery.openSQL(osql);
            error = myQuery.error;
            sql = myQuery.sql;
            if (rs.next()) {
                s = autoDecode(rs.getString(1));
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
        } catch (Exception E) {}
        return s;
    }

    /** 取指定字段的查询值 desc = 倒排序 */
    public String getFieldValue(String prop_tableName, String field,
                                String cond, boolean desc) {
        getNewConn();
        if (conn == null) {
            return "";
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        String s = "";
        try {
            ResultSet rs = myQuery.openSQL("select " + field + " from " +
                                           prop_tableName + " where " + cond +
                                           " order by " + field + " DESC");
            error = myQuery.error;
            sql = myQuery.sql;
            if (rs.next()) {
                s = autoDecode(rs.getString(1));
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
        } catch (Exception E) {}
        return s;
    }

    /** 取指定字段的查询值 */
    public String getFieldValue(String prop_tableName, String prop_key, int ID,
                                String field) {
        getNewConn();
        if (conn == null) {
            return "";
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        String s = "";
        try {
            ResultSet rs = myQuery.openSQL("select " + field + " from " +
                                           prop_tableName + " where " +
                                           prop_key + " = " + String.valueOf(ID));
            error = myQuery.error;
            sql = myQuery.sql;
            if (rs.next()) {
                s = autoDecode(rs.getString(1));
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
        } catch (Exception E) {}
        return s;
    }

    /** 取指定字段的查询值 */
    public String getFieldValue(String prop_tableName, String prop_key,
                                String ID, String field) {
        getNewConn();
        if (conn == null) {
            return "";
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        String s = "";
        try {
            ResultSet rs = myQuery.openSQL("select " + field + " from " +
                                           prop_tableName + " where " +
                                           prop_key + " = '" + ID + "'");
            error = myQuery.error;
            sql = myQuery.sql;
            if (rs.next()) {
                s = autoDecode(rs.getString(1));
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
        } catch (Exception E) {}
        return s;
    }

    /**  增加批处理 */
    public void addBatch(String bsql) {
        if (bsql==null || bsql.equals("") || bsql.equals(";"))
          return;
        getNewConn();
        if (conn == null) {
            return;
        }
        if (bqry == null) {
            bqry = new DBQuery(cm, conn);
            bqry.charset = cm.getCharset();
        }
        bqry.addBatch(bsql);
    }

    /**  清空批处理 */
    public void clearBatch() {
        if (conn == null || bqry == null) {
            return;
        }
        bqry.clearBatch();
    }

    /**  执行批处理 */
    public int execBatch() {
        if (conn == null || bqry == null) {
            return -1;
        }
        int ret = bqry.execBatch();
        error = bqry.error;
        return ret;
    }

    /** 取表结构信息 */
    public String getTableStru(String tablename) {
        getNewConn();
        if (conn == null) {
            return null;
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        String fields = null; //字段列表
        String keys = null; //关键字列表
        try {
            ResultSet rs = myQuery.openSQL("select * from " + tablename +
                                           " where 1=2");
            error = myQuery.error;
            sql = myQuery.sql;
            ResultSetMetaData rsmt = rs.getMetaData();
            int ColumnCount = rsmt.getColumnCount();
            for (int i = 0; i < ColumnCount; i++) {
                String fname = rsmt.getColumnName(i + 1).toLowerCase(); //当前字段名
                String ftype = rsmt.getColumnTypeName(i + 1).toLowerCase();
                int fnull = rsmt.isNullable(i + 1);
                if (fields == null) {
                    //有长度,有小数点
                    if (ftype.equals("number") || ftype.equals("numeric")) {
                        int flen = rsmt.getPrecision(i + 1);
                        int fpointlen = rsmt.getScale(i + 1);
                        fields = fname + " " + ftype + "(" + flen + "," +
                                 fpointlen + ") " +
                                 (fnull == rsmt.columnNoNulls ? "not null" :
                                  "null");
                    } else
                    //有长度,无小数点
                    if (ftype.equals("char") || ftype.equals("varchar") ||
                        ftype.equals("varchar2")) {
                        int flen = rsmt.getPrecision(i + 1);
                        fields = fname + " " + ftype + "(" + flen + ") " +
                                 (fnull == rsmt.columnNoNulls ? "not null" :
                                  "null");
                    } else
                        //无长度 //text,datetime,date,long,clob,int etc.
                        fields = fname + " " + ftype + " " +
                                 (fnull == rsmt.columnNoNulls ? "not null" :
                                  "null");
                } else {
                    fields += ",\n";
                    //有长度,有小数点
                    if (ftype.equals("number") || ftype.equals("numeric")) {
                        int flen = rsmt.getPrecision(i + 1);
                        int fpointlen = rsmt.getScale(i + 1);
                        fields += fname + " " + ftype + "(" + flen + "," +
                                fpointlen + ") " +
                                (fnull == rsmt.columnNoNulls ? "not null" :
                                 "null");
                    } else
                    //有长度,无小数点
                    if (ftype.equals("char") || ftype.equals("varchar") ||
                        ftype.equals("varchar2")) {
                        int flen = rsmt.getPrecision(i + 1);
                        fields += fname + " " + ftype + "(" + flen + ") " +
                                (fnull == rsmt.columnNoNulls ? "not null" :
                                 "null");
                    } else
                        //无长度 //text,datetime,date,long,clob,int etc.
                        fields += fname + " " + ftype + " " +
                                (fnull == rsmt.columnNoNulls ? "not null" :
                                 "null");
                }
            }
            fields = "create table " + tablename + "(\n" + fields + "\n)";
            try {
                rs.close();
            } catch (Exception eers) {
            }
            return fields;
        } catch (Exception e) {
            cm.writeLog("取表结构出错:" + e.getMessage());
        }
        return null;
    }

    /** 取最大ID号 */
    public int maxId(String prop_tableName, String prop_key) {
        getNewConn();
        if (conn == null) {
            return -1;
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        String s = "";
        try {
            ResultSet rs = myQuery.openSQL("select max(" + prop_key + ") from " +
                                           prop_tableName);
            error = myQuery.error;
            sql = myQuery.sql;
            if (rs.next()) {
                s = autoDecode(rs.getString(1));
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
        } catch (Exception E) {
            cm.writeLog(E, E.getMessage());
        }
        if (!s.equals(""))
            return Integer.parseInt(s);
        else
            return 0;
    }

    /** 取最大ID号 */
    public int maxId(String prop_tableName, String prop_key, String cond) {
        getNewConn();
        if (conn == null) {
            return -1;
        }
        DBQuery myQuery = new DBQuery(cm, conn);
        myQuery.charset = cm.getCharset();
        String s = "";
        try {
            ResultSet rs = myQuery.openSQL("select max(" + prop_key + ") from " +
                                           prop_tableName + " where " + cond);
            error = myQuery.error;
            sql = myQuery.sql;
            if (rs.next()) {
                s = autoDecode(rs.getString(1));
            }
            try {
                rs.close();
            } catch (Exception eers) {
            }
        } catch (Exception E) {
            cm.writeLog(E, E.getMessage());
        }
        if (!s.equals(""))
            return Integer.parseInt(s);
        else
            return 0;
    }

    /** 记录日志 */
    public void log(String s) {
        cm.writeLog(s);
    }

    /** 记录insert,update,delete等系统日志 */
    public void logSQL(String s) {
        cm.writeLogSQL(s);
    }

    /**
     * 建宇加的方式
     * @param s String
     * @return ArrayList
     */

    public ArrayList openAsArrayList(String s) {
        ArrayList arraylist;
        DBQuery dbquery;
        rowcount = 0;
        getNewConn();
        arraylist = new ArrayList();
        if (conn == null)
            return arraylist;
        try {
            dbquery = new DBQuery(cm, conn);
            dbquery.charset = cm.getCharset();
            ResultSet rs = dbquery.openSQL(s);
            error = dbquery.error;
            sql = dbquery.sql;
            ResultSetMetaData resultsetmetadata = rs.getMetaData();
            int i = resultsetmetadata.getColumnCount();
            int ai[] = new int[i];
            for (int j = 0; j < i; j++) {
                String s1 = resultsetmetadata.getColumnTypeName(j + 1);
                if (s1.equalsIgnoreCase("CLOB")) {
                    ai[j] = 3;
                    continue;
                }
                if (s1.equalsIgnoreCase("DATE")) {
                    ai[j] = 1;
                    continue;
                }
                if (s1.equalsIgnoreCase("IMAGE")) {
                    ai[j] = -1;
                    continue;
                }
                if (s1.equalsIgnoreCase("BLOB"))
                    ai[j] = -2;
                else
                    ai[j] = 0;
            }

            String as[];
            for (; rs.next(); arraylist.add(as)) {
                rowcount++;
                as = new String[i];
                for (int k = 0; k < i; k++) {
                    if (ai[k] == -1) {
                        if (rs.getBinaryStream(k + 1) == null)
                            as[k] = "";
                        else
                            as[k] = "[IMAGE]";
                        continue;
                    }
                    if (ai[k] == -2) {
                        Blob blob = rs.getBlob(k + 1);
                        if (blob == null || blob.length() <= 0L)
                            as[k] = "";
                        else
                            as[k] = "[BLOB]";
                        continue;
                    }
                    if (ai[k] == 3) {
                        Clob clob = rs.getClob(k + 1);
                        if (clob == null || clob.length() == 0L)
                            as[k] = "";
                        else
                            as[k] = PubFunc.nullToStr(clob.getSubString(1L,
                                    (int) clob.length()));
                        continue;
                    }
                    if (ai[k] == 1)
                        as[k] = PubFunc.nullToStr(PubFunc.getDate(rs.
                                getDate(k + 1)));
                    else
                        as[k] = PubFunc.nullToStr(rs.getString(k + 1));
                }

            }
            try {
                rs.close();
            } catch (Exception eers) {
            }

        } catch (Exception exception) {
            DBConnManager.writeLog("读取数据出错:" + exception.getMessage());
        }

        return arraylist;
    }

    public void outPut(Writer writer, String s, char c, int i, int j) throws
            IOException {
        DBQuery dbquery;
        rowcount = 0;
        getNewConn();
        if (conn == null)
            writer.write("没有连接");
        try {
            dbquery = new DBQuery(cm, conn);
            dbquery.charset = cm.getCharset();
            ResultSet resultset = dbquery.openSQL(s);
            error = dbquery.error;
            s = dbquery.sql;
            ResultSetMetaData resultsetmetadata = resultset.getMetaData();
            int k = resultsetmetadata.getColumnCount();
            int ai[] = new int[k];
            for (int l = 0; l < k; l++) {
                String s1 = resultsetmetadata.getColumnTypeName(l + 1);
                if (s1.equalsIgnoreCase("CLOB")) {
                    ai[l] = 3;
                    continue;
                }
                if (s1.equalsIgnoreCase("DATE")) {
                    ai[l] = 1;
                    continue;
                }
                if (s1.equalsIgnoreCase("IMAGE")) {
                    ai[l] = -1;
                    continue;
                }
                if (s1.equalsIgnoreCase("BLOB"))
                    ai[l] = -2;
                else
                    ai[l] = 0;
            }

            StringBuffer stringbuffer = new StringBuffer(0x100000);
            int i1 = 0;
            do {
                if (!resultset.next())
                    break;
                i1++;
                if (i <= i1 && rowcount < j) {
                    rowcount++;
                    for (int j1 = 0; j1 < k; j1++) {
                        if (ai[j1] == -1) {
                            if (resultset.getBinaryStream(j1 + 1) == null) {
                                stringbuffer.append("");
                                stringbuffer.append(c);
                            } else {
                                stringbuffer.append("[IMAGE]");
                                stringbuffer.append(c);
                            }
                            continue;
                        }
                        if (ai[j1] == -2) {
                            Blob blob = resultset.getBlob(j1 + 1);
                            if (blob == null || blob.length() <= 0L) {
                                stringbuffer.append("");
                                stringbuffer.append(c);
                            } else {
                                stringbuffer.append("[BLOB]");
                                stringbuffer.append(c);
                            }
                            continue;
                        }
                        if (ai[j1] == 3) {
                            Clob clob = resultset.getClob(j1 + 1);
                            if (clob == null || clob.length() == 0L) {
                                stringbuffer.append("");
                                stringbuffer.append(c);
                            } else {
                                stringbuffer.append(PubFunc.nullToStr(clob.
                                        getSubString(1L, (int) clob.length())));
                                stringbuffer.append(c);
                            }
                            continue;
                        }
                        if (ai[j1] == 1) {
                            stringbuffer.append(PubFunc.nullToStr(PubFunc.
                                    getDate(resultset.getDate(j1 + 1))));
                            stringbuffer.append(c);
                        } else {
                            stringbuffer.append(PubFunc.nullToStr(resultset.
                                    getString(j1 + 1)).trim());
                            stringbuffer.append(c);
                        }
                    }

                    stringbuffer.append('\r');
                    if (stringbuffer.length() >= 0x100000) {
                        writer.write(stringbuffer.toString());
                        stringbuffer = new StringBuffer(0x100000);
                    }
                }
            } while (true);

            try {
                resultset.close();
            } catch (Exception eee) {}
            writer.write(stringbuffer.toString());
        } catch (Exception exception) {
            DBConnManager.writeLog("读取数据出错:" + exception.getMessage());
        }
    }


    /**  类信息说明 */
    public String getClassInfo() {
        return
                "pub.TableCtrl Information. written by sunjian lastModify:2009-05-11";
    }

    //当此类释放时把数据库连接也关闭掉
    protected void finalize() {
        freeConn();
    }

}


class DBQuery {
    protected String sql; //当前sql串
    protected String batchsqls; //当前batchsql串
    private Connection c; //当前连接
    private DBConnManager cm;
    private String connName;
    public static String defCharset = "GB2312"; //默认字符集
    public String charset = "ISO-8859-1"; //默认字符集
    public String error = ""; //错误信息
    private Statement stat = null; //批处理的statement;
    private int batchcount = 0;
    //构造类
    private DBQuery() {
    }

    public DBQuery(DBConnManager dbcm, Connection strConnName) {
        cm = dbcm;
        c = strConnName;
        batchsqls = "";
    }

    //构造带sql串的类,
    public DBQuery(DBConnManager dbcm, Connection strConnName, String s) {
        cm = dbcm;
        c = strConnName;
        setSQL(s);
    }

    //清空SQL串值
    public void clearSQL() {
        sql = "";
    }

    //设置SQL串值
    public void setSQL(String s) {
        if (defCharset.equals(charset))
            sql = s;
        else
            sql = PubFunc.encodeGB(s, charset);
    }

    //执行当前SQL并返回结果集
    public ResultSet openSQL() {
        try {
            if (c == null) {
                return null;
            }
            long sqlstart = System.currentTimeMillis();
//            if (cm.DEBUG)
//              System.out.println(sql);
            ResultSet rs = c.createStatement().executeQuery(sql);
            int sqlexecsec = (int)((System.currentTimeMillis() - sqlstart)/1000); //秒,sql执行的秒数
            if (sqlexecsec>cm.getSlowSqlLogSecond())
              log("执行[open]SQL语句时间较长:"+sqlexecsec+",建议优化,SQL=["+sql+"]");
            return rs;
        } catch (SQLException E) {
            error = "执行(open)SQL语句[" + sql + "]出错:" + E.getMessage();
            log(error);
            return null;
        }
    }

/*    //执行当前SQL并返回结果集[用于可更新的结果集]
    public ResultSet openSQL(boolean scrollable) {
        //    if (!updatable)
        //    return openSQL();
        //else
        try {
            if (c == null) {
                return null;
            }
            ResultSet rs = c.createStatement(ResultSet.TYPE_FORWARD_ONLY,
                                             ResultSet.CONCUR_READ_ONLY).
                           executeQuery(sql);
            return rs;
        } catch (SQLException E) {
            error = "执行(open)SQL语句[" + sql + "]出错:" + E.getMessage();
            log(error);
            return null;
        }
    }
*/
    // 增加批处理
    public void addBatch(String bsql) {
        try {
            if (c == null) {
                return;
            }
            if (stat == null)
                stat = c.createStatement();
            setSQL(bsql);
            stat.addBatch(sql);

            if (batchsqls==null)
              batchsqls = "";
            batchsqls += sql+";\n";

            batchcount++;
        } catch (SQLException E) {
            error = "执行(addBatch[" + bsql + "])SQL语句出错:" + E.getMessage();
            log(error);
            return;
        }
    }

    // 清空批处理
    public void clearBatch() {
        try {
            if (c == null) {
                return;
            }
            if (stat != null) {
                stat.clearBatch();
                stat = null;
                batchcount = 0;
                batchsqls = "";
            }
        } catch (SQLException E) {
            error = "执行(clearBatch)SQL语句出错:" + E.getMessage();
            log(error);
            return;
        }
    }

    // 执行批处理
    public int execBatch() {
        try {
            if (c == null) {
                return -1;
            }

            //DEBUG时把SQL都记录下来 //add by 2007/11/28
            cm.writeLogSQL(batchsqls);

            if (batchcount > 0)
            {
              if (stat != null) {
                stat.executeBatch();
                return 1;
              }
              else
                return -1;
            } else
                return 0;
        } catch (SQLException E) {
            error = "执行(execBatch)SQL语句出错:"+E.getMessage();//+",SQL=["+batchsqls+"]";
            log(error);
            return -1;
        }
    }

    //执行当前SQL并返回更新数据的条数
    public int execSQL() {
        try {
            if (c == null) {
                return -1;
            }
            if (sql==null || sql.trim().length()==0) //bug fix 2007.12.3
              return 0;
            long sqlstart = System.currentTimeMillis();
            int ret = c.createStatement().executeUpdate(sql);
            int sqlexecsec = (int)((System.currentTimeMillis() - sqlstart)/1000); //秒,sql执行的秒数
            if (sqlexecsec>cm.getSlowSqlLogSecond())
              log("执行[exec]SQL语句时间较长:"+sqlexecsec+",建议优化,SQL=["+sql+"]");
            if (ret < 0)
                return 0;
            else
                return ret;
        } catch (SQLException E) {
//          if (!(E.getMessage().startsWith("ORA-01476"))) //除零
//          {
//            error = "执行(exec)SQL语句["+sql+"]出错:"+E.getMessage();
//            log(error);
//          }
            error = "执行(exec)SQL语句出错:"+E.getMessage()+",SQL=["+sql+"]";
            log(error);
            return -1;
        }
    }

    //执行当前SQL并返回更新数据的条数
    public int execSQL(String s) {
        //DEBUG时把SQL都记录下来
        cm.writeLogSQL(s);
        setSQL(s);
        return execSQL();
    }

    //执行当前SQL并返回结果集
    public ResultSet openSQL(String s) {
        setSQL(s);
        return openSQL();
    }
/*
    //执行当前SQL并返回结果集
    public ResultSet openSQL(String s, boolean updatable) {
        setSQL(s);
        return openSQL(updatable);
    }
*/

    // 将文本信息写入日志文件
    private void log(String msg) {
        cm.writeLog(msg);
    }


}

