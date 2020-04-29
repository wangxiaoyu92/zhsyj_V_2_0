package com.zzhdsoft.utils.hbthelper;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
//import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.nutz.dao.entity.annotation.Column;

public class GenBeanFromTableMySql {
    private String url = "jdbc:mysql://192.168.1.222:3306/zhsyj_zhongmou?useUnicode=true&amp;characterEncoding=UTF-8";//jdbc:oracle:thin:@192.168.0.80:1521:orcl
    private String driver = "com.mysql.jdbc.Driver";//oracle.jdbc.driver.OracleDriver
    private String user_name = "root";
    private String user_pwd = "123456";
	   
    public static void main(String[] args) throws Exception{
    	GenBeanFromTableMySql gbft = new GenBeanFromTableMySql();
//    	List dataList=gbft.getUserTablesName();
//    	if(null!=dataList && dataList.size()>0){
//    		for(int i=0;i<dataList.size();i++){
//    			gbft.GenEntityTool("com.xml.vo",dataList.get(i)+"");  
//    		}
//    	}
        gbft.GenEntityTool("com.zzhdsoft.siweb.entity.sysmanager","sysuserhuanxinfriend");
    } 
    
	private String upperTableName; // 大写的表名
    private String[] colnames; // 列名数组   
    private String[] colTypes; // 列的 原始类型数组   
    private int[] colSizes; // 列的 大小 数组   
    
    private String[] colComment; // 列注释 
    private String[] colPrimary; // 列是否主键
    String g_tablenameComment = ""; // 表注释
  
    private boolean f_util = false; // 是否需要导入包java.util.*   
    private boolean f_sql = true; // 是否需要导入包java.sql.*
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List getUserTablesName(){
    	List dataList = null;
    	Connection conn = null;
		Statement stmt = null;
//		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String tmpTableName = "";
    	try {
			Class.forName(driver);
			//获取数据库连接
			conn = DriverManager.getConnection(url,user_name,user_pwd);
			//--当前用户下的表
			String ls_sql = "SELECT * FROM USER_TABLES where table_name like 'BS_%' OR table_name like 'BT_%'";
			stmt = conn.createStatement();
//          pstmt = conn.prepareStatement(ls_sql);
//		   rs = pstmt.executeQuery(ls_sql);
			rs = stmt.executeQuery(ls_sql);
			dataList = new ArrayList();
			while(rs.next()){
				tmpTableName = rs.getString("table_name").toLowerCase();
				dataList.add(tmpTableName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
    	return dataList;
    }
    
    /**
     * 创建级联文件夹目录，即创建包
     * @param folders
     */
    public static  void CreateFolders(final String folders) {  
        StringTokenizer st = new StringTokenizer(folders, File.separator);  
        StringBuilder sb = new StringBuilder();  
        String osname = System.getProperty("os.name");  
        if (osname.compareToIgnoreCase("linux") == 0)  
            sb.append(File.separator);  
  
        while (st.hasMoreTokens()) {  
            sb.append(st.nextToken());  
            File file = new File(sb.toString());  
            if (!file.exists())  
                file.mkdir();  
            sb.append(File.separator);  
        }  
    }
    
    /** 
    * 解析处理(生成实体类主体代码) 
    */  
    private String parseTable(String packName, String tableName, String[] colNames, 
    		String[] colTypes, int[] colSizes, String[] colBeizhu, String tablenameBeiZhu) {
    	upperTableName = ConvertStr2Camel.convertStr2CamelName(tableName,true);
    	
        StringBuffer sb = new StringBuffer(); 
        sb.append("package " + packName.replace("\\", ".") + ";");
        sb.append("\r\n");
        sb.append("\r\n");
        
        sb.append("import org.nutz.dao.entity.annotation.Column;\r\n"); 
        sb.append("import org.nutz.dao.entity.annotation.Name;\r\n"); 
        sb.append("import org.nutz.dao.entity.annotation.Table;\r\n"); 
        sb.append("\r\n");
        
        if (f_util) {  
            sb.append("import java.util.Date;\r\n\r\n");  
        }  
        if (f_sql) {  
            sb.append("import java.sql.Date;\r\n");  
            sb.append("import java.sql.Timestamp;\r\n\r\n");
        }  
        
        // sb.append("public class " + upperTableName+ " implements java.io.Serializable {\r\n");
        if (tableName.equalsIgnoreCase(upperTableName)){
        	sb.append("@Table(value = \"" + upperTableName + "\")\r\n");
        }else{
        	sb.append("@Table(value = \"" + tableName + "\")\r\n");
        }
        //sb.append("@Table(value = \"" + v_realtablename + "\")\r\n");
        sb.append("public class " + upperTableName + " {\r\n");
        
        //gu20141010
        sb.append("/** " + tablenameBeiZhu + "  */\r\n"); //生成注释        
        
        makeClassAttribute(sb);  //生成属性
        makeClassMethod(sb);  //生成属性对应的get set 方法
        sb.append("}\r\n");  
//        System.out.println(sb.toString());  
        return sb.toString();  
  
    }  
  
    
    /** 
    * 生成类的属性 
    */  
    private void makeClassAttribute(StringBuffer sb) {
    	int len = colnames.length;
        for (int i = 0; i < len; i++) {  
        	sb.append("\t/** " + colnames[i] + " 的中文含义是：" + colComment[i] + "*/\r\n");
        	if (colPrimary[i].equalsIgnoreCase("PRI")){
        		sb.append("\t@Name\r\n");
        	}
        	String v_houcolname=ConvertStr2Camel.underscoreName(colnames[i]);
        	if (v_houcolname.equalsIgnoreCase(colnames[i])){
        	   sb.append("\t@Column\r\n");
        	}else{
        		sb.append("\t@Column(value=\""+colnames[i]+"\")\r\n");	
        	}
            sb.append("\tprivate " + sqlType2JavaType(colTypes[i]) + " "
            		+ ConvertStr2Camel.convertStr2CamelName(colnames[i],false) + ";\r\n");
            if(i==len-1)
            	sb.append("\r\n");
            sb.append("\r\n");
        }  
    }  
  
    /** 
    * 生成所有的方法 
    */  
    private void makeClassMethod(StringBuffer sb) {  
        for (int i = 0; i < colnames.length; i++) {
        	String upper = ConvertStr2Camel.convertStr2CamelName(colnames[i].toLowerCase(),true);
        	String lower = ConvertStr2Camel.convertStr2CamelName(colnames[i].toLowerCase(),false);
            sb.append("\tpublic void set" + upper + "(" + sqlType2JavaType(colTypes[i]) + " " 
            		+ ConvertStr2Camel.convertStr2CamelName(colnames[i],false)  + "){\r\n");  
            sb.append("\t\tthis." + lower + "=" + lower  + ";\r\n");
            sb.append("\t}\r\n\r\n");  
  
            sb.append("\tpublic " + sqlType2JavaType(colTypes[i].toLowerCase()) + " get" + upper + "(){\r\n");  
            sb.append("\t\treturn " + lower + ";\r\n");  
            sb.append("\t}\r\n\r\n");  
        }  
    }  

    /** 
    * 把输入字符串的首字母改成大写 
    * @param str 
    * @return 
    */  
    @SuppressWarnings("unused")
	private String initcap(String str) {  
        char[] ch = str.toCharArray();  
        if (ch[0] >= 'a' && ch[0] <= 'z') {  
            ch[0] = (char) (ch[0]-32);  
        }  
        return new String(ch);  
    }  
  
    private String sqlType2JavaType(String sqlType) {
//    	System.out.println(sqlType);
        if (sqlType.equalsIgnoreCase("bit")) {  
            return "Boolean";  
        } else if (sqlType.equalsIgnoreCase("tinyint") || sqlType.equalsIgnoreCase("TINYINT UNSIGNED")) {  
            return "Byte";  
        } else if (sqlType.equalsIgnoreCase("smallint")) {  
            return "Short";  
        } else if (sqlType.equalsIgnoreCase("int") || sqlType.equalsIgnoreCase("INT UNSIGNED")) {  
            return "Integer";  
        } else if (sqlType.equalsIgnoreCase("bigint")) {  
            return "Long";  
        } else if (sqlType.equalsIgnoreCase("number")) {//oralce nubmer
            return "Long";  
        } else if (sqlType.equalsIgnoreCase("float")) {  
            return "Float";  
        } else if (sqlType.equalsIgnoreCase("decimal")  
                || sqlType.equalsIgnoreCase("numeric")  
                || sqlType.equalsIgnoreCase("real")) {  
            return "BigDecimal";  
        } else if (sqlType.equalsIgnoreCase("money")  
                || sqlType.equalsIgnoreCase("smallmoney")) {  
            return "Double";  
        } else if (sqlType.equalsIgnoreCase("varchar2")  
                || sqlType.equalsIgnoreCase("varchar")  
                || sqlType.equalsIgnoreCase("char")  
                || sqlType.equalsIgnoreCase("nvarchar")  
                || sqlType.equalsIgnoreCase("nchar")) {  
            return "String";  
        } else if (sqlType.equalsIgnoreCase("date")) {  
            return "Date";  
        }else if (sqlType.equalsIgnoreCase("datetime") || sqlType.equalsIgnoreCase("TIMESTAMP") ) {  
            return "Timestamp";  
        }else if (sqlType.equalsIgnoreCase("image")) {  
            return "Blob";  
        } else if (sqlType.equalsIgnoreCase("text")) {  
            return "Clob";  
        }else if (sqlType.equalsIgnoreCase("blob")
        		||sqlType.equalsIgnoreCase("longblob")) {  
            return "String";  
        }else if (sqlType.equalsIgnoreCase("clob")) {  
            return "String";  
        }else if(sqlType.equalsIgnoreCase("integer")){
        	return "integer";
        };
        return null;  
    }  
    
    /*
     * 首字母转小写
     */
    public static String toLowerCaseFirstOne(String s){
        if(Character.isLowerCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString();
    }
    /*
     * 首字母转大写
     */
    public static String toUpperCaseFirstOne(String s){
        if(Character.isUpperCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toUpperCase(s.charAt(0))).append(s.substring(1)).toString();
    }

    
    @SuppressWarnings("unused")
	public void GenEntityTool(String packName,String tableName) throws Exception{
    	
		Connection conn = null;
		Statement stmt = null;
//		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet Colrs = null;
//		StringBuffer sb = new StringBuffer("{");
		try {
			packName = packName.replace(".","\\");
			tableName = tableName.toLowerCase(); // 全部转换成小写，方便后面处理
			if(tableName.indexOf("_") > 0)
				upperTableName = ConvertStr2Camel.convertStr2CamelName(tableName,true);
			else
				upperTableName = toUpperCaseFirstOne(tableName);//表名变成类，类的首字母大写
			Class.forName(driver);
			//获取数据库连接
			conn = DriverManager.getConnection(url, user_name, user_pwd);
			
			/*gu20141010获取表名*/
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);	
	        String ls_sql = " select a.table_name as tablename,a.TABLE_COMMENT as tablecomment from information_schema.TABLES a where a.table_name=upper('" + tableName+"')";
			
			rs = stmt.executeQuery(ls_sql);
			
			while (rs.next()){
				g_tablenameComment=rs.getString("tablecomment");
			}
			
	        ls_sql = " select a.column_name,a.column_comment,(case when (column_key=NULL OR column_key='') THEN 'no' ELSE column_key end) AS column_key from information_schema.COLUMNS a where a.table_name=upper('" + tableName+"')";
	        System.out.println(ls_sql);
	        boolean v_havecolComment = false;
	        Colrs = stmt.executeQuery(ls_sql);
	        if (Colrs.next())
	        	v_havecolComment = true;
			
	        ls_sql = "select * from " + tableName;
			stmt = conn.createStatement();
			
//	        pstmt = conn.prepareStatement(ls_sql);
//			rs = pstmt.executeQuery(ls_sql);
	        rs = stmt.executeQuery(ls_sql);
			ResultSetMetaData rsmd = rs.getMetaData();
	        
            int size = rsmd.getColumnCount(); // 共有多少列 
            colnames = new String[size]; //列名 
            colTypes = new String[size]; //列的原始类型
            colSizes = new int[size];//
            colComment = new String[size];//列注释
            colPrimary = new String[size];//是否主键
            
            String v_colname = "";
            
            for (int i = 0; i < rsmd.getColumnCount(); i++) {  
                colnames[i] = rsmd.getColumnName(i + 1);  
                colTypes[i] = rsmd.getColumnTypeName(i + 1);  
                System.out.println(colnames[i] + " " + colTypes[i]);
//                if (colTypes[i].equalsIgnoreCase("datetime") || colTypes[i].equalsIgnoreCase("date")) {  
//                    f_util = true; //需要导入java.util包
//                }  
//                if (colTypes[i].equalsIgnoreCase("image") || colTypes[i].equalsIgnoreCase("text")) {  
//                    f_sql = true; //需要导入java.sql包 
//                }
                colSizes[i] = rsmd.getColumnDisplaySize(i + 1);  
                v_colname = rsmd.getColumnName(i + 1);
                
                Colrs.first();                
                while (!Colrs.isAfterLast()){
                	if (Colrs.getString("column_name").equalsIgnoreCase(v_colname)){
                  	  colComment[i] = Colrs.getString("column_comment");
                  	  colPrimary[i] = Colrs.getString("column_key");
                  	}     
                	Colrs.next();
                }
                
//                if (v_havecolbeizhu) {
//                	if (Colrs.getString("column_name").equalsIgnoreCase(v_colname)){
//                	  colComment[i] = Colrs.getString("column_comment");
//                	}
//                	Colrs.next();
//                }else{
//                	colComment[i] = "";
//                }                
            }  
            String content = parseTable(packName,tableName, colnames, colTypes, colSizes, colComment, g_tablenameComment);
            
            //创建真实的文件夹，即包
            String path = System.getProperty("user.dir")+"\\src\\";
			
            CreateFolders(path+packName);
            String fullPath = path + packName + "\\" + upperTableName + ".java";
            
            //存在先删除
            if(new File(fullPath).exists()){
            	new File(fullPath).delete();
            }
            
            //if(!new File(fullPath).exists()){
            	//fullPath = packName+"\\"+upperTableName +"_new"+ ".java";
            System.out.println(fullPath);
	            FileWriter fw = new FileWriter(fullPath);  
	            PrintWriter pw = new PrintWriter(fw);  
	            pw.println(content);  
	            pw.flush();  
	            pw.close(); 
	//            System.out.println(packName);
	            System.out.println("恭喜,已经成功从表" + tableName + "生成" + packName.replace("\\", ".")
	            		+ "." + upperTableName + ".java");
	         //}else{
	        	 //System.out.println(packName.replace("\\", ".")+"."+upperTableName + ".java已经存在！");
            //}
	        } catch (Exception e) {  
	            e.printStackTrace();
	        }finally {
				try {
					if (rs != null) {
						rs.close();
						rs = null;
					}
					if (stmt != null) {
						stmt.close();
						stmt = null;
					}
					if (conn != null) {
						conn.close();
						conn = null;
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
	}
  
 
}  