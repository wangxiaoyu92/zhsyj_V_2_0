/**
 *    功能说明:        数据库连接池管理类     参数文件读取
 *    作者:                     孙建
 *    编写日期:    2001/04/11--2001/04/12    lastmodify:2009-05-08
 **/

package com.zzhdsoft.utils.hbthelper;

import java.io.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.naming.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.*;


/**
 * 管理类DBConnManager支持对一个或多个由属性文件定义的数据库连接
 * 池的访问.客户程序可以调用getInstance()方法访问本类的唯一实例.
 */
public class DBConnManager extends HttpServlet {

    static private DBConnManager instance; // 唯一实例
    static boolean haveReadConfig = false; //是否已经读过配置
    static private int clients;

    static private Log log = null;
    static private Log logSql = null; //记录SQL的日志类
    static private Properties conf = new Properties(); //配置文件读取
    static public String logFile = null; //日志文件名
    static public String logFileSql = null; //日志文件名.SQL执行记录,只记录insert,update,delete等执行类
//    static private PrintStream logStream=null;    //日志流

    static public String logFileChat = null; //日志文件名,记录聊天信息 add by lijianyu 2006/3/22
    static private Log logChat = null; //记录聊天信息 add by lijianyu 2006/3/22
    static private final String DEFLOGFILECHAT = "chat.log"; //聊天记录日志 add by lijianyu 2006/3/22

    static private final String DEFLOGFILESql = "db.log";
    static private final String DEFLOGFILE = "log";
//    static private int usedConnCount = 0;  //已用连接数
    static private String datasource = null; //数据库连接资源, 默认连接池名称
    static private Hashtable project = new Hashtable(); //存放工程全局变量
    static private String app_dir = null;
    static private String app_name = null;
    static private Context ic = null;
    static private DataSource s = null;

    static final String JDBCDATASOURCEHEAD = ""; //java:comp/env/jdbc/";
    static public boolean initmaxid = false;
    static public Hashtable maxid = new Hashtable();
    static public boolean DEBUG = true;
    static public boolean SQL_WRITELOG = true; //记录日志
    static public String substring = "substring";
    static public boolean to_date = true; //是否为oracle 即是否进行日期转换
    static public boolean usesign = false; //是否使用电子签名
    static public boolean startcommserver = false; //是否使用FTP通迅服务器

    static public Vector connectList = new Vector();
    static public String DB_CURR_USER = null; //当前数据库连接用户,schma //oracle=select user from dual
    static private boolean bGetDBCurrUser = false; //是否已经取到当前数据库连接用户
    static boolean fromServlet = false;

    public static int SlowSqlLogSecond = 3; //SQL执行慢SQL的记录开始秒数,如为0时表示所有都不记录

    /**3.0 new edit 3.0版本存储图片需要的路径以及文件*/
     public static final String chatPhotoPath="chat/";
     public static final String photoMainURL="http://wapxo.cn/client/photo/";
     public static final String photoMainSaveFile="savePhoto.jsp";
     public static final String photoMainPath="E:/web/wap.autothink.cn/client/photo/";
     public static final String albumPath="photo/";
     /**3.0 end*/

    public DBConnManager() {
        System.out.println("new DBconnManager");
//        logStream = System.out;
        instance = this;
    }

    public void init(ServletConfig sc) throws ServletException {
        try {
            fromServlet = true;
            app_dir = sc.getServletContext().getRealPath("/");
            System.out.println("RealPath=" + app_dir);
            dbrun();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 返回唯一实例.如果是第一次调用此方法,则创建实例
     *
     * @return DBConnManager 唯一实例
     */
    public static synchronized DBConnManager getInstance() {
        if (instance == null) {
            new DBConnManager();
        }
        instance.dbrun();
        clients++;
        return instance;
    }

    public void dbstart() {
        //数据库连接初始化
        try {
            writeLog("dbstart.fromServlet=" + fromServlet);

            ic = new InitialContext();

           if (!fromServlet){
              writeLog("没有使用系统连接池,切换到使用apache BasicDataSource");

              org.apache.commons.dbcp.BasicDataSource dataSource = new org.apache.commons.dbcp.BasicDataSource();
              dataSource.setDriverClassName(getParam("db_driver"));
              dataSource.setUrl(getParam("db_url"));
              dataSource.setUsername(getParam("db_user"));
              dataSource.setPassword(getParam("db_password"));
              //最大活动连接数
              dataSource.setMaxActive(getParamInt("dbmaxconncount",10));
              //最多空闲连接数
              dataSource.setMaxIdle(4);
              //最长空闲等待时间, -1表示无限时
              dataSource.setMaxWait(-1);
              s = dataSource;
            } else{
            	s = (DataSource) ic.lookup(datasource);
            }
            freeConnection(getConnection());
        } catch (Exception e) {
            writeLog("没有找到JDBC数据源" + datasource + "的配制信息");
        }
    }

    public void dbrun() {
        if (haveReadConfig)
            return;
        haveReadConfig = true;
        //System.out.println("dbrun");
        if (log == null)
            log = new Log();
        readConfig(); //读取配置文件

        dbstart();
        System.out.println("DBConnmanager started.");
//      System.out.println("ServerServlet run.");
    }

    public void run() {
        getInstance();
    }

    /**
     * 取日志流
     */
//    public PrintStream getLogStream(){
//      return this.logStream;
//    }

    /*
     * 取默认上传路径
     */
    public static String getUploadPath() {
        return getParam("ftppath", app_dir + "/WEB-INF/upload");
    }

    /**
     *取连接(用连接池)
     */
    public static Connection getConnection() {
    	  try {
              Connection con = s.getConnection();
              if (con != null && DB_CURR_USER == null && to_date &&
                  !bGetDBCurrUser) { //取当前数据库用户 //add by 2007-11-3
                  bGetDBCurrUser = true;
                  try {
                      writeLog("正在取当前数据库连接用户...");
                      ResultSet rs = con.createStatement().executeQuery(
                              "select user from dual");
                      if (rs.next()) {
                          DB_CURR_USER = rs.getString(1);
                      }
                      writeLog("当前数据库连接用户为:" + DB_CURR_USER);

                  } catch (Exception e) {
                      writeLog("取当前数据库连接用户失败!");
                  }
              }
              connectList.add(con);
              if (connectList.size() > 20) {
                  writeLog("连接池已使用:" + connectList.size());
                  freeConnectionAll();
              }
              return con;
          } catch (Exception e) {

              writeLog("不能建立数据库" + datasource + "连接_1!" + e.getMessage());
          }
          //重试2
          try {
              s = (DataSource) ic.lookup(datasource);
          } catch (Exception e) {
              writeLog("没有找到JDBC数据源" + datasource + "的配制信息");
          }
          try {
              Connection con = s.getConnection();
              connectList.add(con);
              if (connectList.size() > 20) {
                  writeLog("连接池已使用:" + connectList.size());
                  freeConnectionAll();
              }
              return con;
          } catch (Exception e) {
              writeLog("不能建立数据库" + datasource + "连接_2_重试!" + e.getMessage());
              return null;
          }
    }

    /**
     *取连接(不用默认连接池,用其它连接池)
     *@param 要连接的数据源
     */
    public static Connection getConnection(String otherdatasource) {
        try {
            DataSource s2 = (DataSource) ic.lookup(otherdatasource);

            Connection con = s2.getConnection();
            connectList.add(con);
            writeLog("C/S/S已使用连接:" + connectList.size());
            if (connectList.size() >= 100) {
                writeLog("连接池已使用:" + otherdatasource + connectList.size());
                freeConnectionAll();
            }
            return con;
        } catch (Exception e) {

            writeLog("不能建立数据库" + datasource + "_other_连接!" + e.getMessage());
            return null;
        }
    }

    /**
     * freeConnectionAll
     */
    public static void freeConnectionAll() {
    	while (connectList.size() > 5) {
            try {
                Connection cl = (Connection) connectList.elementAt(0);
                connectList.remove(0);
                try {
                    cl.close();
                } catch (Exception e) {}
            } catch (Exception e) {}
        }
    }

    /**
     *释放数据库连接
     *@param 要释放的数据库的连接
     */
    public static void freeConnection(Connection c) {
    	  try {
              if (c != null) {
                  connectList.remove(c);
                  c.close();
              }
          } catch (Exception e) {
              writeLog("连接已关闭!不能释放数据库连接!" + e.getMessage());
          }
    }

    /**
     *取工程配制信息
     *@return 返回Hashtable工程变量
     */
    public static Hashtable getProject() {
        return project;
    }

    /**
     *取最大ID并设定此最大ID,即当前的最大ID加1,调用此函数不会执行加1操作.
     *@param idname 最大ID名称
     */
    public synchronized int getMaxId(String idname) {
        String max = String.valueOf(PubFunc.parseInt(maxid.get(idname)) + 1);
        maxid.put(idname, max);
        return Integer.parseInt(max);
    }

    /**
     *取当前的最大ID,调用此函数不会执行加1操作.
     */
    public static int getLastId(String idname) {
        return PubFunc.parseInt(maxid.get(idname));
    }

    /**
     *取License文件名称,此名称包括路径名
     */
    public static String getLicenseFile() {
        return app_dir + "/WEB-INF/classes/license";
    }

    /**
     *取日志文件名称,此名称包括路径名
     */
    public static String getLogFile() {
        return logFile;
    }

    /**
     *取此WEB应用工程所在的根路径
     */
    public static String getRootPath() {
        return app_dir;
    }

    /**
     *取默认数据库的连接池的资源名称
     */
    public static String getDataSource() {
        return datasource;
    }

    /**
     *取默认每页显示记录数
     */
    public static int getDispCountPerPage() {
        return getParamInt("dispcount", 10);
    }

    /**
     *取默认多行录入时每页显示记录数
     */
    public static int getInputDispCountPerPage() {
        return getParamInt("input_dispcount", 200);
    }

    /**
     *用于判断客户端版本 -1 为不判断
     */
    public static int getMinLowVersion(){
      return getParamInt("MinLowVersion", 0);
    }

    /**
     *取默认多行录入时每页显示记录数
     */
    public static int getSlowSqlLogSecond() {
        return getParamInt("log_slowsqlsecond", 3);
    }

    /**
     *取是否使用外部邮件
     */
    public boolean getMailUse() {
        return "true".equalsIgnoreCase(PubFunc.toString(conf.get("mail_use")));
    }

    /**
     *取默认的邮件SMTP服务器地址或名称
     */
    public static String getSmtpServer() {
        return getParam("smtp_server");
    }

    /**
     *取默认的邮件SMTP服务器smtp认证方式
     */
    public static boolean getSmtpUseAuth() {
        return "true".equalsIgnoreCase(PubFunc.toString(conf.get(
                "smtp_use_auth")));
    }

    /**
     *取默认的邮件SMTP服务器smtp登录用户
     */
    public static String getSmtpUser() {
        return getParam("smtp_user");
    }

    /**
     *取默认的邮件SMTP服务器smtp登录密码
     */
    public static String getSmtpPass() {
        return getParam("smtp_pass");
    }

    /**
     *取默认的当前WEB应用工程名称
     */
    public static String getApp_name() {
        return app_name;
    }

    /**
     *取失效时间
     */
    public static int getInvalid_time() {
        return PubFunc.parseInt(conf.get("invalid_time"), 10) * getReload_time();
    }

    /**
     *取自动刷新的时间 单位为秒
     */
    public static int getReload_time() {
        return PubFunc.parseInt(conf.get("reload_time"), 60) * 1000;
    }

    /**
     *取用户间隔时间 单位为秒
     */
    public static int getUserDelay() {
        return PubFunc.parseInt(conf.get("userdelay"), 300) * 1000;
    }

    /**
     *取数据库的物理名称
     */
    public static String getDatabaseName() {
        return getParam("database", app_name);
    }

    /**
     *取数据库的用户名称
     */
    public static String getDatabaseUser() {
        return PubFunc.toString(conf.get("user"));
    }

    /**
     *取数据库的间隔访问时间 单位为秒
     */
    public static int getDelay() {
        return getParamInt("delay", 120) * 1000;
    }

    /**
     *取数据库用户的所属者
     */
    public static String getOwner(String username) {
        if (username.equals("sa")) //超级用户除外
            return "dbo";
        else
            return username;
    }

    /**
     *取字符集,默认为GB2312
     */
    public static String getCharset() {
        return getParam("charset", "GB2312");
    }

    /**
     *取用户登录认证类型 默认为数据库认证,还可为域认证domain
     */
    public static String getAuthType() {
        return getParam("authtype", "database");
    }

    /**
     *取系统登录页
     */
    public static String getLoginPage() {
        return getParam("loginpage", "/" + app_name + "/login/loginpage.jsp");
    }

    /**
     *取用户默认根目录
     */
    public static String getUserHome() {
        return getParam("userhome", app_dir + "/WEB-INF/user_home/");
    }

    /**
     *取系统配制参数值(带默认值)
     */
    public static String getParam(String paramName, String def) {
        return PubFunc.toString(conf.get(paramName), def);
    }

    /**
     * 取系统配制参数值
     */
    public static String getParam(String paramName) {
        return PubFunc.toString(conf.get(paramName));
    }

    /**
     * 取整型参数值(带默认值)
     */
    public static int getParamInt(String paramName, int def) {
        return PubFunc.parseInt(conf.get(paramName), def);
    }

    /**
     * 取整型参数值
     */
    public static int getParamInt(String paramName) {
        return PubFunc.parseInt(conf.get(paramName));
    }

    /**
     * 重新读配置文件
     */
    public void reload() {
        readConfig();
    }

    /**
     * 读取属性完成初始化
     */
    private void readConfig() {
        try {
            conf.load(getClass().getResourceAsStream("/db.config")); //xiaoao用的不是这个，是db.conf,一定要注意!!!
        } catch (Exception e) {
            System.out.println("读配置文件出错!" + e.getMessage() + e);
        }

        //server ip
//        try {
//            conf.put("commserver",5
//                     java.net.InetAddress.getLocalHost().getHostAddress());
//        } catch (Exception ue) {}8

        //通用参数
        DEBUG = "true".equals(conf.getProperty("DEBUG"));

        if (app_name == null)
            app_name = (String) conf.get("app_name");

        if (app_dir == null && !("".equals(app_dir)))
            app_dir = (String) conf.get("app_dir");

        if (app_dir != null && !("".equals(app_dir)))
            app_dir = PubFunc.replace(app_dir, "\\", "/");

        if (app_dir != null && !("".equals(app_dir))) {
            String c = "/";
            int endpos = app_dir.lastIndexOf(c);
            if (endpos < 1) {
                endpos = app_dir.lastIndexOf("\\");
                c = "\\";
            }
            app_dir = app_dir.substring(0, endpos);
            if (app_name == null)
                app_name = app_dir.substring(app_dir.lastIndexOf(c) + 1);
        } else {
            String classPath = this.getClass().getResource("/").getPath();
            System.out.println("Path:" + classPath); //类的根路径
//            if (classPath.length()>0 && classPath.indexOf(":")>0 && classPath.charAt(0)=='/')
//              classPath = classPath.substring(1);
            int WebInfPos = classPath.indexOf("/WEB-INF");
            if (WebInfPos > 0)
                app_dir = classPath.substring(0, WebInfPos);
            System.out.println("Path_AppRoot:" + app_dir); //类的根路径
        }
        if (app_name == null)
            app_name = "";

        String logf = (String) conf.get("logfile");
        if (app_dir == null && logf!=null)
            logFile = logf.trim();
        else
        if ((logf == null) || (logf.trim().length() == 0))
            logFile = app_dir + "/WEB-INF/classes/" + DEFLOGFILE;
        else
        if (logf.indexOf("/") < 0 && logf.indexOf("\\") < 0)
            logFile = app_dir + "/WEB-INF/classes/" + logf.trim();

        if (app_dir != null) { //Sql脚本记录  modify by lijianyu 2006/3/22
            logFileSql = app_dir + "/WEB-INF/classes/" + DEFLOGFILESql;
            logFileChat = app_dir + "/WEB-INF/classes/" + DEFLOGFILECHAT;
        }

        initLog(true); //初始化日志记录,默认增加模式

        //数据库连接源
        datasource = (String) conf.get("datasource");
        System.out.println("datasource.conf=" + datasource);
        if (datasource == null)
            datasource = app_name; //默认
        datasource = JDBCDATASOURCEHEAD + datasource;
        //oracle转换
        String dbtype = (String) conf.get("dbtype");
        if ("oracle".equals(dbtype)) //默认不是oracle 为mssql
            to_date = true;
        else
            to_date = "true".equals(conf.get("to_date"));
        //数据库substring函数名
        if (to_date) //oracle
            substring = "substr";
        else
            substring = "substring";
        //使用电子签名 默认为false
        usesign = "true".equals(conf.get("usesign"));
        //是否使用FTP服务器并启动它
        startcommserver = "true".equals(conf.get("startcommserver"));

    }

    /**
     * 初始化日志文件
     */
    public static void initLog(boolean append) { //modify by lijianyu 2006/3/22 增加了聊天日志的初始化
//        if (useLog)
        log = new Log(logFile, append);
        logSql = new Log(logFileSql, append);
//        logChat = new Log(logFileChat, append);
//      logStream = log.getLogStream();
    }

    /**
     * 关闭日志文件
     */
    public static void closeLog() { //modify by lijianyu 2006/3/22 增加了聊天日志的初始化
        if (log != null)
            log.close();
        if (logSql != null)
            logSql.close();
        if (logChat != null)
            logChat.close();
    }

    //add by lijianyu 2006/3/22 增加了聊天日志的初始化
    public static void writeChatLog(String msg) {
        if (logChat != null) {
            logChat.println(msg);
        }
    }

    /**
     * 将文本信息写入日志文件
     */
    public static void writeLog(String msg) {
        if (log != null) {
            log.println(msg);
        } else
            System.out.println(msg);
    }

    /**
     * 将文本信息写入日志文件
     */
    public static void writeLog(String msg, Throwable e) {
        if (log != null) {
            log.println(e, msg);
        } else
            System.out.println(msg + e.getMessage());
    }

    /**
     * 将文本信息写入日志文件
     */
    public void log(String msg) {
        writeLog(msg);
    }

    /**
     * 将文本信息写入日志文件
     */
    public void log(String msg, Throwable e) {
        writeLog(e, msg);
    }

    /**
     * 将SQL执行脚本（update,insert,delete等,不含select）文本信息写入日志文件
     */
    public static void writeLogSQL(String msg) {
        if (DEBUG)
            System.out.println("DEBUG_ExecSQL:" + msg);
        if (logSql != null && SQL_WRITELOG) {
            logSql.println(msg);
        }
    }

    public static PrintStream getLogStream() {
        if (log == null)
            return System.err;
        else
            return log.log;
    }

    /**
     * 将文本信息与异常写入日志文件
     */
    public static void writeLog(Throwable e, String msg) {
        if (log != null) {
            log.println(e, msg);
//            if (log.curSize > 640)
//                initLog(true);
        } else
            System.out.println(msg + e);
    }

}


/////////////////////////////////////////////////////
//    功能说明:     日志记录类                            //
//    作者:                     孙建                                //
//    编写日期:    2001/04/11--2001/04/12    lastmodify:2006/03/13改为一天一个日志文件                    //
///////////////////////////////////////////////////////

class Log {
    String datePattern = "'.'yyyy-MM-dd";
    SimpleDateFormat sdf;


    protected PrintStream log;
    private boolean WriteLog = true; //日志记录入文件
    public static boolean debug = DBConnManager.DEBUG; //显示调试信息
    public int curSize = 0; //日志文件大小
    public String curFileName;
    public String logFileName;
    /**
     * 构造日志类（为空时日志为System.err）
     *                    (不为空时为所传的文件名)
     **/
    public Log() {
        log = System.err;
    }

    public Log(String logFile, boolean append) {
        debug = DBConnManager.DEBUG; //显示调试信息

        //暂时放在控制台输出
//         log = new PrintWriter(System.err);
        this.sdf = new SimpleDateFormat(datePattern);
        this.logFileName = logFile;
        this.curFileName = logFileName +
                           sdf.format(new java.util.Date(System.currentTimeMillis()));
        init(curFileName, append);
    }

    public PrintStream getLogStream() {
        return log;
    }

    /**
     * 将文本信息写入日志文件
     */
    public void println(String msg) {
        if (msg == null)
            return;
        //加入按日期的文件名日志
        String nextFileName = logFileName +
                              sdf.format(new java.util.Date(System.
                currentTimeMillis()));
        if (!nextFileName.equals(curFileName)) {
            curFileName = nextFileName;
            close();
            init(curFileName, true);
        }

        Calendar now = Calendar.getInstance();
        if (log != null) {
            log.print(now.get(Calendar.HOUR_OF_DAY));
            log.print(':');
            log.print(now.get(Calendar.MINUTE));
            log.print(':');
            log.print(now.get(Calendar.SECOND));
            log.print(' ');
            log.println(msg);
        }
        if (debug)
            System.err.println(msg);
        curSize += msg.length();
    }

    /**
     * 将文本信息与异常写入日志文件
     */
    public void println(Throwable e, String msg) {
        println(msg);
        e.printStackTrace(log);
    }

    /**
     * 初始化日志文件
     **/
    private void init(String tlogFile, boolean append) {
        try {

            if (WriteLog) {
                System.out.println("Log Start.FileName=" + tlogFile);
                log = new PrintStream(new BufferedOutputStream(new
                        FileOutputStream(tlogFile, append), 102400), true);
                if (!debug && DBConnManager.logFile != null &&
                    tlogFile.indexOf(DBConnManager.logFile) > -1) {
                    System.setOut(new PrintStream(new BufferedOutputStream(new
                            FileOutputStream(tlogFile + ".out", append), 102400), true));
                    System.setErr(new PrintStream(new BufferedOutputStream(new
                            FileOutputStream(tlogFile + ".err", append), 102400), true));
                }
            } else {
                log = System.out;
            }
        } catch (IOException e) {
            System.err.println("无法打开日志文件: " + tlogFile + "," + e.getMessage());

            log = System.err;
        }
    }

    /**
     * 关闭日志文件
     **/
    public void close() {
        log.close();
    }

}
