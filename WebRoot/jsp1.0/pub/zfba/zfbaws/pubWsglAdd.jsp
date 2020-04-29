<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    //String v_dmlb = StringHelper.showNull2Empty(request.getParameter("dmlb"));
%>
<!DOCTYPE html>
<html>
<head>
<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
var v_ajzt = <%=SysmanageUtil.getAa10toJsonArray("AJZT")%>;
var v_AJDJAJLY = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;

var obj = new Object(); 
$(function() {
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/pub/wsgldy/queryAjwsParamlist',
		    queryParams:{
			    ajdjid:'<%=v_ajdjid%>'
			},
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 100,
			pageList : [ 100, 200, 300 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'fjcsid', //该列是一个唯一列  
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '附件参数表ID',
				field : 'fjcsid',
				hidden : false,
				checkbox:'true'
			},{
				width : '100',
				title : '代码类别',
				field : 'fjcsdmlb',
				hidden : true
			},{
				width : '100',
				title : '代码类别名称',
				field : 'fjcsdmlbmc',
				hidden : true
			},{
				width : '500',
				title : '执法文书名称',
				field : 'fjcsdmmc',
				hidden : false
			},{
				width : '100',
				title : '代码值',
				field : 'fjcsdmz',
				hidden : false
			} 
			] ]
		});
		

		
		
})////////////////

function queding(){
	var rows=mygrid.datagrid('getSelections'); 
	sy.setWinRet(rows);  
	parent.$("#"+sy.getDialogId()).dialog("close");//有入参$dialog的关闭方法     
} 
//文书排序
function wspx(){
	var _basepath = "<%=basePath%>";
    var url=_basepath+"pub/wsgldy/pubWsglAddOrderIndex?a="+new Date().getMilliseconds();
    var dialog = parent.sy.modalDialog({
		title : '文书排序',
		width : 800,
		height : 650,
		url : url
	});  
    $("#mygrid").datagrid("reload");
}   
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="">
        		<table class="table" style="width: 99%;">
					<tr>
					  	<td >
					  	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="queding()"> 确定</a>
								
					  	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="wspx()">文书排序</a>
																
						</td>	
					</tr>
				</table>
	        </sicp3:groupbox>
	                
        	<sicp3:groupbox title="执法办案文书列表">
				<div id="mygrid" style="height:500px;width: 750px;"></div>
	        </sicp3:groupbox>
        </div>
        </form>         
    </div>   
		    

</body>
</html>