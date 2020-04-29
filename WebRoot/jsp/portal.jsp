<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="java.util.*,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var portal;
	var panels;
	$(function() {		
		panels = [ {
			id : 'p1',
			title : '平台介绍',
			height : 200,
			collapsible : true,
			href:'<%=contextPath%>/jsp/portal/about.jsp'
		}, {
			id : 'p2',
			title : '待办事项',
			height : 200,
			collapsible : true,
			href:'<%=contextPath%>/jsp/portal/work.jsp'
		}, {
			id : 'p3',
			title : '通知公告',
			height : 200,
			collapsible : true,
			href:'<%=contextPath%>/jsp/portal/notice.jsp'
		}, {
			id : 'p4',
			title : '证审提醒',
			height : 200,
			collapsible : true,
			href:'<%=contextPath%>/jsp/portal/warn.jsp'
		}];

		portal = $('#portal').portal({
			border : false,
			fit : true,
			onStateChange : function() {
				$.cookie('portal-state', getPortalState(), {
					expires : 7
				});
			}
		});
		var state = $.cookie('portal-state');
		if (!state) {
			state = 'p1,p2:p3,p4';/*冒号代表列，逗号代表行*/
		}
		addPanels(state);
		portal.portal('resize');

	});

	function getPanelOptions(id) {
		for ( var i = 0; i < panels.length; i++) {
			if (panels[i].id == id) {
				return panels[i];
			}
		}
		return undefined;
	}
	function getPortalState() {
		var aa=[];
		for(var columnIndex=0;columnIndex<2;columnIndex++) {
			var cc=[];
			var panels=portal.portal('getPanels',columnIndex);
			for(var i=0;i<panels.length;i++) {
				cc.push(panels[i].attr('id'));
			}
			aa.push(cc.join(','));
		}
		return aa.join(':');
	}
	function addPanels(portalState) {
		var columns = portalState.split(':');
		for (var columnIndex = 0; columnIndex < columns.length; columnIndex++) {
			var cc = columns[columnIndex].split(',');
			for (var j = 0; j < cc.length; j++) {
				var options = getPanelOptions(cc[j]);
				if (options) {
					var p = $('<div/>').attr('id', options.id).appendTo('body');
					p.panel(options);
					portal.portal('add', {
						panel : p,
						columnIndex : columnIndex
					});
				}
			}
		}
	}
</script>
<div id="portal" style="position:relative">
	<div></div>
	<div></div>
</div>