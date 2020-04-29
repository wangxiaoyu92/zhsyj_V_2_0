<%@ page language="java" import="java.util.*,java.io.ByteArrayOutputStream,java.io.PrintStream" isErrorPage="true" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <title>404</title>
<meta http-equiv="Refresh" content="3;url=index.jsp"/> 
<style>
body {
	margin:0 auto;padding:0;font-size:12px;text-align:center;
}
p{text-align:center;color:#d04d1f;line-height:25px;font-size:14px;}
p span{font-weight:800;font-size:18px;}
</style>
</head>
<body>

<hr width=80%>   
<h2><font color=#DB1260>JSP Error Page</font></h2>   
  
<p>An exception was thrown: <b> <%=exception.getClass()%>:<%=exception.getMessage()%></b></p>   
<%   
System.out.println("Header....");   
Enumeration<String> e = request.getHeaderNames();   
String key;   
while(e.hasMoreElements()){   
  key = e.nextElement();   
  System.out.println(key+"="+request.getHeader(key));   
}   
System.out.println("Attribute....");   
e = request.getAttributeNames();   
while(e.hasMoreElements()){   
  key = e.nextElement();   
  System.out.println(key+"="+request.getAttribute(key));   
}   
  
System.out.println("arameter....");   
e = request.getParameterNames();   
while(e.hasMoreElements()){   
  key = e.nextElement();   
  System.out.println(key+"="+request.getParameter(key));   
}   
%>   
111<%=request.getAttribute("javax.servlet.forward.request_uri") %>   
  
<%=request.getAttribute("javax.servlet.forward.servlet_path") %>   
  
<p>With the following stack trace:</p>   
<pre>   
<%exception.printStackTrace();   
      ByteArrayOutputStream ostr = new ByteArrayOutputStream();   
      exception.printStackTrace(new PrintStream(ostr));   
      out.print(ostr);   
    %>   
</pre>   
<hr width=80%> 
</body>
</html>