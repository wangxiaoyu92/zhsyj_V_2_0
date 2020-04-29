<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.workflow.Wf_node_trans" %>
<%@ page import="java.util.List,com.zzhdsoft.siweb.service.workflow.WorkflowService,java.net.URLDecoder" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ywbh"));
	//String v_ywlcid = StringHelper.showNull2Empty(request.getParameter("ywlcid"));
	String v_psbh = StringHelper.showNull2Empty(request.getParameter("psbh"));
	//String v_transfrom=StringHelper.showNull2Empty(request.getParameter("nodeid"));
	String v_nodename=URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("nodename")),"UTF-8");
	String v_nodeid = StringHelper.showNull2Empty(request.getParameter("nodeid"));
	String v_fjcsdmlb = StringHelper.showNull2Empty(request.getParameter("fjcsdmlb"));
	String v_fjcsdlbh = StringHelper.showNull2Empty(request.getParameter("fjcsdlbh"));
	String v_ywbh = StringHelper.showNull2Empty(request.getParameter("ywbh"));
		
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
sy.setWinRet(s);

var layer;
var form;
var table;


$(function(){

	layui.use(['form', 'table', 'layer', 'element'], function () {
		form = layui.form;
		table = layui.table;
		layer = layui.layer;
	});
	var v_wenshuguanliURL=encodeURI(encodeURI("<%=basePath%>jsp/pub/zfba/zfbaws/pubWsgl.jsp?ajdjid=<%=v_ajdjid%>&psbh=<%=v_psbh%>&nodeid=<%=v_nodeid%>&nodename=<%=v_nodename %>"));
	$("#wenshuguanli").attr("src",v_wenshuguanliURL); 
	var v_fujianguanliURL=encodeURI(encodeURI("<%=basePath%>jsp/pub/pub/pubUploadFjList.jsp?ajdjid=<%=v_ajdjid%>&dmlb=<%=v_fjcsdmlb%>&fjcsdlbh=<%=v_fjcsdlbh%>&gridwidth=800&gridheight=280"));
	$("#fujianguanli").attr("src",v_fujianguanliURL); 
});

//查看案件详情
function chakanAjxq(){	 	
    var url = basePath + 'jsp/pub/zfba/zfbalc/ajdjjbxx.jsp';
	parent.sy.modalDialog({
		title : '查看',
		param : {
			ajdjid : "<%=v_ajdjid%>",
			time : new Date().getMilliseconds()
		},
		 area:[ '100%','100%'],
		 content : url
		 ,btn:['关闭']
	},function(dialogID) {
		sy.removeWinRet(dialogID);//不可缺少
	});
}

//查看案件办理日志
function chakanAjblrz(){	 	
    var url = basePath + 'jsp/workflowyewu/wfywlclog.jsp';
	parent.parent.sy.modalDialog({
		title : '查看',
		param : {
			ywbh : "<%=v_ywbh%>",
			time : new Date().getMilliseconds()
		},
		area:[ '100%','100%'],
		content : url
		,btn:['关闭']
	},function(dialogID) {
		sy.removeWinRet(dialogID);//不可缺少
	});
}
</script>
</head>
<body>
	<div style="text-align: center;">
		<div class="grouphead" >当前流程环节：<%=v_nodename %> &nbsp;&nbsp;
			<a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" onclick="chakanAjxq()"
	              data-options="iconCls:'ext-icon-application_view_columns'">案件基本信息</a>&nbsp;&nbsp;
			<a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" onclick="chakanAjblrz()"
	              data-options="iconCls:'ext-icon-calendar_link'">案件办理日志</a>&nbsp;&nbsp;			              	
		</div>
	    <iframe id="wenshuguanli" name="wenshuguanli" src=""  width="100%" height="440px;" 
	    	scrolling="no" frameborder="0" ></iframe>
    	<br/>
    	<sicp3:groupbox title="">    
		    <iframe id="fujianguanli" name="fujianguanli" src=""  width="100%" height="360px;" 
		    	scrolling="no" frameborder="0" ></iframe>
    	</sicp3:groupbox>
    	<br/>	    	    		
	</div>
</body>
</html>



