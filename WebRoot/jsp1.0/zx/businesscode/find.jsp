<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>查询</title>
 <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
 <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
  <script type="text/javascript">
  $(function(){
   		loading();
   });
   
   function loading(){
     $("#aaa").datagrid({
      title:'',
    	iconCls:'icon-ok',
    	height:450,
    	pageSize:25,
    	pageList:[10,25,40],
    	nowrap:true,//True 就会把数据显示在一行里
    	striped:true,//奇偶行使用不同背景色
    	collapsible:true,
    	singleSelect:true,//True 就会只允许选中一行
    	fit:false,//让DATAGRID自适应其父容器
    	fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
    	pagination:true,//底部显示分页栏
    	rownumbers:true,//是否显示行号
    	loadMsg:'数据加载中,请稍后...',
        url:  basePath + '/zx/BusinessCode/queryBusinessCode',  
        columns:[[
          {title:'id',field:'bcid',align:'center',width:32} ,
          {title:'姓名',field:'bcname',align:'center',width:80},
          {title:'等级',field:'bclevel',align:'center',width:120},
          {title:'是否启用',field:'bcenable',align:'center',width:60},
        ]]
     });
     }
      </script>
  
  </head>
  
  <body> 
   <body>
      <div style="overflow:scroll; width:100%;height:100%;">
  <table id="aaa" class="easyui-datagrid" style="width:600px;height:400px">
 </div>
</table> 

  </body>
</html>