<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.utils.DateUtil" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));	
	String wdyear = StringHelper.showNull2Empty(request.getParameter("wdyear"));
	if("".equals(wdyear)){
		wdyear = String.valueOf(DateUtil.getCurrentYear());	
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>工作日设置</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<link rel="stylesheet" href="jquery-ui-1.10.2.custom.min.css" />
<script type="text/javascript" src="jquery-ui-1.10.2.custom.min.js"></script>
<script type="text/javascript">
	window.onload = function(){
		$('#loading-mask').fadeOut();
	};
	      	
	var onlyOpenTitle = '欢迎使用';
	var mainTabs;	
	$(function() {				  		
		//'center'面板被缩放后触发
		$('#mainLayout').layout('panel', 'center').panel({
			onResize : function(width, height) {
				sy.setIframeHeight('centerIframe', $('#mainLayout').layout('panel', 'center').panel('options').height - 5);
			}
		});
	});

	
	//添加选项卡
	function addTab(tabTitle,url,icon){		
		if (mainTabs.tabs('exists', tabTitle)) {
			mainTabs.tabs('select', tabTitle);
		} else {
			mainTabs.tabs('add', {
				title : tabTitle,
				closable : true,
				iconCls : icon,
				content : createFrame(url),
				border : false,
				fit : true
			});
		}
		tabMenu();
	}

	//创建iframe
	function createFrame(url)
	{   
		var s = sy.formatString('<iframe src="{0}" allowTransparency="true" style="border:0;width:100%;height:99%;" frameBorder="0"></iframe>', contextPath + url);
		return s;
	}
	function createFrame2(src)
	{   
		var s = sy.formatString('<iframe src="{0}" allowTransparency="true" style="border:0;width:100%;height:99%;" frameBorder="0"></iframe>', src);
		return s;
	}


	//刷新页面
	function refresh(){
	    var currentTab = mainTabs.tabs('getSelected');
		var iframe = $(currentTab.panel('options').content);
        var src = iframe.attr('src');
        mainTabs.tabs('update', {
            tab: currentTab,
            options: {
                content: createFrame2(src)
            }
        });
	}

  	
</script>
</head>
<body id="mainLayout" class="easyui-layout">
	<div id="loading-mask" style="position:absolute;top:0px; left:0px; width:100%; height:100%; background:#D2E0F2; z-index:20000">
		<div id="pageloading" style="position:absolute; top:50%; left:50%; margin:-120px 0px 0px -120px; text-align:center;  border:2px solid #8DB2E3; width:200px; height:40px;  font-size:14px;padding:10px; font-weight:bold; background:#fff; color:#15428B;"><img src="<%=contextPath%>/images/frame/loading.gif" align="absmiddle" /> 正在加载中,请稍候...</div>
	</div>
	<noscript>
		<div style="position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
		    <img src="<%=contextPath%>/images/frame/noscript.gif" alt='抱歉，请开启脚本支持！' />
		</div>
	</noscript>
	
	<div data-options="region:'north'" style="height: 40px; overflow: hidden;" >
		
	</div>
	<div data-options="region:'center'" style="overflow: hidden;">
		<div id="mainTabs" >
			<div title="欢迎使用" data-options="iconCls:'ext-icon-heart'">
				<iframe src="<%=basePath%>jsp/workflowcz/wf_workdayForm.jsp" allowTransparency="true" style="border: 0; width: 100%; height: 800;" frameBorder="0"></iframe>
			</div>
		</div>
	</div>
	<div data-options="region:'south',href:'<%=basePath%>jsp/south.jsp',border:false" style="height: 30px; overflow: hidden;"></div>
</body>
</html>
