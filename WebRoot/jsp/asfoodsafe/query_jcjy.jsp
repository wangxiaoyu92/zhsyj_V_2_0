<%@ page language="java" import="java.util.*,com.xml.vo.BsProductJc,com.xml.service.com.BsSymService" pageEncoding="UTF-8"%>
<%@ include file="query_head.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String sym=null==request.getParameter("sym")?"":request.getParameter("sym").toString();
BsSymService service=null;
List dataList=null;
BsProductJc bean=null;
String sym_state="";
if(!"".equals(sym)){
	service=new BsSymService();
	sym_state=service.checkSym(sym);
	if("ok".equals(sym_state)){
		dataList=service.getProductJcjyInfo(sym);
	}else{
		
	}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>二维码溯源查询</title>
<script type="text/javascript">	
	var sym='<%=sym%>';
	var sym_state='<%=sym_state%>';
	if(sym.length==0){
		alert('请输入追溯码！');
		top.location.href='index.jsp';
	}
	if(sym.length>0 && sym_state!="ok"){
	    alert('不好意思，系统平台查询不到此追溯码，请输入有效的追溯码！');
		top.location.href='index.jsp';
	}
</script>
  </head>
<body>
	<div role="main" class="ui-content"> 
		<table width="100%" class="table_border mytable" bordercolor="#000000" cellspacing="0" border="1" cellpadding="0">
		 <thead>
		   <tr>
			 <th data-priority="2">检测项目</th>
			 <th>检测结果</th>
			 <th data-priority="3">检测单位</th>
			 <th data-priority="1">检测时间</th>
			 <th data-priority="5">批次号</th>
		   </tr>
		 </thead>
		 <tbody>
		 <% 
		if(null!=dataList && dataList.size()>0){
			for(int i=0;i<dataList.size();i++){
				bean=(BsProductJc)dataList.get(i);
				out.println("<tr>");
				out.println("<td>"+bean.getJcItem()+"</td>");
				out.println("<td>"+bean.getJcJg()+"</td>");
				out.println("<td>"+bean.getJcJg()+"</td>");
				out.println("<td>"+bean.getJcSj()+"</td>");
				out.println("<td>"+bean.getJcPc()+"</td>");
				out.println("</tr>");
			}
		}else{
			out.println("<tr><td colspan=\"5\">暂无检测信息</td></tr>");
		}
		%>
			</tbody>
		</table>        
	</div>
	 
<%@ include file="query_footer.jsp"%>
</body>
</html>