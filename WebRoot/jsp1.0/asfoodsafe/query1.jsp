<%@ page language="java" import="java.util.*,com.xml.dto.ProductDto,com.xml.service.com.BsSymService" pageEncoding="UTF-8"%>
<%@ include file="query_head.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String sym=null==request.getParameter("sym")?"":request.getParameter("sym").toString();
BsSymService service=null;
ProductDto bean=null;
String sym_state="";
if(!"".equals(sym)){
	service=new BsSymService();
	sym_state=service.checkSym(sym);
	if("ok".equals(sym_state)){
		bean=service.getProductBasicInfo(sym);
	}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>二维码溯源查询</title>
    <script>
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
		 <tbody>
		   <tr>
			 <th>溯源码</th>
			 <td><%=sym.substring(0,15) %><br/><%=sym.substring(15,sym.length()) %></td>
			 <th>商品</th>
			 <td><%=bean.getProPm() %></td>
		   </tr>
		   <tr>
			 <th>生产厂家</th>
			 <td><%=bean.getProSccj()%></td>
			 <th>厂家网址</th>
			 <td><a href="<%=bean.getComWeb() %>" data-rel="external"><%=bean.getComWeb() %></a></td>
		   </tr>
		   <tr>
			 <th>批次</th>
			 <td><%=bean.getPpPc()%></td>
			  <th>产地</th>
			 <td><%=bean.getProCdjd()%></td>
		   </tr>
		    <tr>
			 <th>商品条码</th>
			 <td><%=bean.getProSptm()%></td>
			<th>产品标准代号</th>
			 <td><%=bean.getProCpbzh()%></td>
		   </tr>
		     <tr>
		      <th>生产日期</th>
			 <td><%=bean.getPpScrq2()%></td>
			 <th>保质期</th>
			 <td><%=bean.getProBzq()%><%=bean.getProBzqdwMc()%></td>
			
		   </tr>
		    <tr>
			  <th>规格型号</th>
			 <td><%=bean.getProGg()%></td>
			 <th>包装规格</th>
			 <td><%=bean.getProBzgg()%></td>
		   </tr>
		   <tr>
			 <th>配料信息</th>
			 <td colspan=3><%=bean.getProPlxx()%></td>
			 
		   </tr>
			</tbody>
		</table>        
	</div>
	 
<%@ include file="query_footer.jsp"%>
</body>
</html>