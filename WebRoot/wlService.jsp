<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="java.sql.Timestamp"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<% 
	Timestamp date = SysmanageUtil.currentTime();
%>
<!DOCTYPE html>
<html>
<head>
<title>webservice接口测试</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表		
	function query(){
		var sql = $("#sql").val();
		var inParams = $("#inParams").val();  
		$.post("<%=contextPath%>/common/dataModule/wlService",{
			sql: sql,
			param: inParams
		},function(data,status){
		  		$("#result").val(data);
		});
	}

	function reset2(){
		$('#fm').form('clear');
	}		
</script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" >			
	       	<sicp3:groupbox title="测试区">
	       		<table class="table" style="width: 99%;">       	
					<tr>
						<td style="text-align:right;"><nobr><font color="red">业务代码：</font></nobr></td>
						<td><textarea id="sql" name="sql" rows="5" cols="150"></textarea>						
							<a href="javascript:void(0)" class="easyui-linkbutton" 
								iconCls="icon-save" plain="false" onclick="query()">提交</a>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<a href="javascript:void(0)" class="easyui-linkbutton" 
								iconCls="icon-reload" plain="false" onclick="reset2()">重置</a>
						</td>									
					</tr>
					<tr>					
						<td style="text-align:right;"><nobr><font color="red">入参数据：</font></nobr></td>
						<td><textarea id="inParams" name="inParams" rows="15" cols="200"></textarea></td>	
					</tr>
					<tr>					
						
					</tr>	
					<tr>					
						<td style="text-align:right;"><nobr><font color="red">执行结果：</font></nobr></td>
						<td><textarea id="result" name="result" rows="15" cols="200"></textarea></td>	
					</tr>
																														
				</table>
	        </sicp3:groupbox>
    	</form>
    </div>    
</body>
</html>