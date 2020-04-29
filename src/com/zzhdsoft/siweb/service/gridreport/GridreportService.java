package com.zzhdsoft.siweb.service.gridreport;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidPooledConnection;
import com.lbs.leaf.exception.BusinessException;
import com.zzhdsoft.siweb.service.BaseService;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import java.util.zip.DeflaterOutputStream;
import java.io.*;

@IocBean
public class GridreportService extends BaseService{
	private static final Logger log = Logger.getLogger(GridreportService.class);
	
	@Inject
	private Dao dao;
	@Inject
	private  static DruidDataSource dataSource;	
	
	private  static DruidPooledConnection myconn;
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//以下枚举指定报表数据的格式类型
public enum ResponseDataType
{
PlainText, //报表数据为XML或JSON文本，在调试时可以查看报表数据。数据未经压缩，大数据量报表采用此种方式不合适
ZipBinary, //报表数据为XML或JSON文本经过压缩得到的二进制数据。此种方式数据量最小(约为原始数据的1/10)，但用Ajax方式加载报表数据时不能为此种方式
ZipBase64, //报表数据为将 ZipBinary 方式得到的数据再进行 BASE64 编码的数据。此种方式适合用Ajax方式加载报表数据
};

public static void mygetConnection() throws SQLException{
	if (dataSource!=null){
		if (myconn==null){
			myconn=dataSource.getConnection();
		}
	}else{
		throw new BusinessException("获取数据库连接出错");
	}
}
//指定报表的默认数据类型，便于统一定义整个报表系统的数据类型
//在报表开发调试阶段，通常指定为 ResponseDataType.PlainText, 以便在浏览器中查看响应的源文件时能看到可读的文本数据
//在项目部署时，通常指定为 ResponseDataType.ZipBinary 或 ResponseDataType.ZipBase64，这样可以极大减少数据量，提供报表响应速度
public static ResponseDataType DefaultReportDataType = ResponseDataType.PlainText;  //PlainText ZipBinary ZipBase64

	/*
	public void mytestgridreport() {
		if (dataSource!= null ){
			System.out.println("kkkkkkk   ");
			try {
				myconn=dataSource.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if (myconn!= null ){
			System.out.println("kkkkkkk222   ");
		}else{
			return;
		}
		
	    try
	    {
	        //Class.forName(mysql_jdbc_param.driver); // Class.forName 装载驱动程序 
	        Statement stmt=myconn.createStatement(); //用于发送简单的SQL语句
	        
	        ResultSet rs=stmt.executeQuery("select * from aa01 ");
	        while( rs.next() ) {
	        	System.out.println(rs.getString(1));
	        	System.out.println(rs.getString(2));
	        }
	        rs.close();
	        stmt.close();
	    }
	    catch(Exception e)
	    {
            e.printStackTrace();
	    }		
	}*/
	
	public static void XML_GenOneRecordset(HttpServletResponse response, String QuerySQL)
	{
	    XML_GenOneRecordset(response, QuerySQL, DefaultReportDataType);
	}
	
	public static void XML_GenOneRecordset(HttpServletResponse response, String QuerySQL, ResponseDataType DataType)
	{
	    try
	    {
	    	mygetConnection();
	    	
	        //Class.forName(mysql_jdbc_param.driver); // Class.forName 装载驱动程序 
	        //Connection con=DriverManager.getConnection(mysql_jdbc_param.url, mysql_jdbc_param.user, mysql_jdbc_param.password); //用适当的驱动程序类与 DBMS 建立一个连接
	        Statement stmt=myconn.createStatement(); //用于发送简单的SQL语句
	        
	        StringBuffer XmlText = new StringBuffer ("<xml>\n");
			
	        DoGenOneRecordsetText(XmlText, QuerySQL, "row", stmt);
	        XmlText.append("</xml>\n");
	        
	        stmt.close();
	        myconn.close();
	        
	        ResponseText(response, XmlText.toString(), DataType);
	    }
	    catch(Exception e)
	    {
	        try
	        {
	            //output error message
	            PrintWriter pw = response.getWriter();
	            pw.print(e.toString());
	        } 
	        catch(Exception e2) {}
	    }
	}
	
	private static void DoGenOneRecordsetText(StringBuffer XmlText, String QuerySQL, String RecordsetName, Statement stmt)
	{
	    try
	    {
	        ResultSet rs=stmt.executeQuery(QuerySQL);

	        ResultSetMetaData rsmd = rs.getMetaData();
	        int ColCount = rsmd.getColumnCount();
	        
	        while( rs.next() ) 
	        {
	            //XmlText.append("<row>");
	            XmlText.append('<'); 
	            XmlText.append(RecordsetName); 
	            XmlText.append('>'); 
	            for (int i=1; i<=ColCount; i++)
	            {
	                XmlText.append('<');
	                XmlText.append(rsmd.getColumnLabel(i)); //getColumnName
	                XmlText.append('>');
	                
	                int ColType = rsmd.getColumnType(i);
	                if (ColType == Types.LONGVARBINARY || ColType == Types.VARBINARY || ColType == Types.BINARY || ColType == Types.BLOB)
	                {
	                    byte[] BinData = rs.getBytes(i);
	                    if ( !rs.wasNull() )
	                        XmlText.append( (new sun.misc.BASE64Encoder()).encode( BinData ) );
	                }
	                else
	                {
	                    String Val = rs.getString(i);
	                    if ( !rs.wasNull() )
	                    {
	                        if ( HasSpecialChar(Val) )
	                            XmlText.append( HTMLEncode(Val) );
	                        else
	                            XmlText.append(Val);
	                    }
	                }
	                
	                XmlText.append("</");
	                XmlText.append(rsmd.getColumnLabel(i)); //getColumnName
	                XmlText.append('>');
	            }
	            //XmlText.append("</row>\n");
	            XmlText.append("</"); 
	            XmlText.append(RecordsetName); 
	            XmlText.append(">\n"); 
	        }
	    
	        rs.close();
	        //stmt.close();
	    }
	    catch(Exception e)
	    {
	    }
	}
	
	private static void DoGenOneRecordsetText(StringBuffer JsonText, String QuerySQL, String RecordsetName, Statement stmt, boolean LastRecordset)
	{
	    try
	    {
	        ResultSet rs=stmt.executeQuery(QuerySQL);

	        ResultSetMetaData rsmd = rs.getMetaData();
	        int ColCount = rsmd.getColumnCount();
	        
	        //StringBuffer JsonText = new StringBuffer("{\"Recordset\":[\n");
	        JsonText.append('"');
	        JsonText.append(RecordsetName);
	        JsonText.append("\":[\n");
	        boolean First = true;
	        while( rs.next() ) 
	        {
	            if (First)
	                First = false;
	            else
	                JsonText.append(",\n");
	            JsonText.append('{');
	            for (int i=1; i<=ColCount; i++)
	            {
	                JsonText.append('"');
	                JsonText.append(rsmd.getColumnLabel(i));
	                JsonText.append("\":\"");
	                
	                int ColType = rsmd.getColumnType(i);
	                if (ColType == Types.LONGVARBINARY || ColType == Types.VARBINARY || ColType == Types.BINARY || ColType == Types.BLOB)
	                {
	                    byte[] BinData = rs.getBytes(i);
	                    if ( !rs.wasNull() )
	                        JsonText.append( (new sun.misc.BASE64Encoder()).encode( BinData ) );
	                }
	                else
	                {
	                    String Val = rs.getString(i);
	                    if ( !rs.wasNull() )
	                    {
	                        if ( JSON_HasSpecialChar(Val) )
	                            JsonText.append( JSON_Encode(Val) );
	                        else
	                            JsonText.append(Val);
	                    }
	                }
	                
	                JsonText.append('"');
	                if (i < ColCount)
	                    JsonText.append(',');
	            }
	            JsonText.append('}');
		    }
	        JsonText.append("\n]");
	        if ( !LastRecordset )
	            JsonText.append(',');
	        JsonText.append('\n');
	        
	        rs.close();
	    }
	    catch(Exception e)
	    {
	    }
	}
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//判断是否包含特殊字符
public static boolean HasSpecialChar(String text)
{
if (text == null) 
return false;

boolean ret = false;     
int len = text.length();
for (int i = 0; i < len; ++i)
{
char c = text.charAt(i);
if (c == '&' ||  c == '<' || c == '>' || c == '"')
{
ret = true;
break;
}
}

return ret;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//将产生的报表文本数据(XML文本 或 JSON文本)发送给客户端，可以对数据进行压缩
public static void ResponseText(HttpServletResponse response, 
		String DataText, 
		ResponseDataType DataType) throws Exception
{
response.resetBuffer();

if (DataType == ResponseDataType.PlainText)
{
PrintWriter pw = response.getWriter();
pw.print(DataText);
pw.close();  //终止后续不必要内容输出
}
else
{
byte[] RawData = DataText.getBytes("UTF-8"); //byte[] RawData = DataText.getBytes();

//写入特有的压缩头部信息，以便报表客户端插件能识别数据
response.addHeader("gr_zip_type", "deflate");                           //指定压缩方法
response.addIntHeader("gr_zip_size", RawData.length);                   //指定数据的原始长度
response.addHeader("gr_zip_encode", response.getCharacterEncoding());   //指定数据的编码方式 utf-8 utf-16 ...

if (DataType == ResponseDataType.ZipBinary)
{
//压缩数据并输出
ServletOutputStream bos = response.getOutputStream();
DeflaterOutputStream zos = new DeflaterOutputStream(bos);
zos.write(RawData);
zos.close();
bos.flush();
}
else
{
ByteArrayOutputStream baos = new ByteArrayOutputStream();
DeflaterOutputStream zos = new DeflaterOutputStream(baos);
zos.write(RawData);
zos.close();
baos.close();

PrintWriter pw = response.getWriter();
pw.print( (new sun.misc.BASE64Encoder()).encode( baos.toByteArray() ) );
//pw.print( encodeBASE64( baos.toByteArray() ) );
pw.close();  //终止后续不必要内容输出
}
}
}
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//对数据中的特殊字符进行编码
public static String HTMLEncode(String text)
{
int len = text.length();
StringBuffer results = new StringBuffer(len + 20);
char[] orig = text.toCharArray();

int beg = 0;
for (int i = 0; i < len; ++i)
{
char c = text.charAt(i);
switch (c) 
{
case '&':
if (i > beg) 
results.append(orig, beg, i - beg);
beg = i + 1;
results.append("&amp;");
break;
case '<':
if (i > beg) 
results.append(orig, beg, i - beg);
beg = i + 1;
results.append("&lt;");
break;
case '>':
if (i > beg) 
results.append(orig, beg, i - beg);
beg = i + 1;
results.append("&gt;");
break;
case '"':
if (i > beg) 
results.append(orig, beg, i - beg);
beg = i + 1;
results.append("&quot;");
break;
}
}

results.append(orig, beg, len - beg);

return results.toString();
}


//判断是否包含JSON特殊字符
public static boolean JSON_HasSpecialChar(String text)
{
    if (text == null) 
        return false;
    
    boolean ret = false;     
    int len = text.length();
    for (int i = 0; i < len; ++i)
    {
        char ch = text.charAt(i);
        if (ch == '"' || ch == '\\' || ch == '\r' || ch == '\n' || ch == '\t')
        {
            ret = true;
            break;
        }
    }
    
    return ret;
}

//判断是否包含JSON特殊字符
public static String JSON_Encode(String text)
{
    int len = text.length();
    StringBuffer results = new StringBuffer(len + 20);
    
    for (int i = 0; i < len; ++i)
    {
        char ch = text.charAt(i);
        if (ch == '"' || ch == '\\' || ch == '\r' || ch == '\n' || ch == '\t')
        {
            results.append( '\\');
            if (ch == '"' || ch == '\\')
                results.append( ch  );
            else if (ch == '\r')
                results.append( 'r' );
            else if (ch == '\n')
                results.append( 'n' );
            else if (ch == '\t')
                results.append( 't' );
        }
        else
        {
            results.append( ch  );
        }
    }
    
    return results.toString();
}

}
