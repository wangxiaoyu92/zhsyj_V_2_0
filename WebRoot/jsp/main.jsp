<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="java.util.*,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}	
	
%>
<%
	String menuData = SysmanageUtil.getMenuData();
	Sysuser sysuser = SysmanageUtil.getSysuser();
	String v_cur_userkind=sysuser.getUserkind();//gu20180602
	String ls_userid = "";
	String ls_username = "";
	String ls_description = "";
	String ls_userkind = "";
	String ls_aaa027_4 = "";
	String ls_aaa027_6 = "";
	String ls_now = new Date().toLocaleString();
	if(sysuser != null){
		ls_userid = StringHelper.showNull2Empty(sysuser.getUserid());
		ls_username = StringHelper.showNull2Empty(sysuser.getUsername());
		ls_description = StringHelper.showNull2Empty(sysuser.getDescription());
		ls_userkind = StringHelper.showNull2Empty(sysuser.getUserkind());	  	  
	    ls_aaa027_4 = sysuser.getAaa027().substring(0,4);
	    ls_aaa027_6 = sysuser.getAaa027().substring(0,6);
		SysmanageUtil.getSessionContext().remove(request.getSession().getId());
	}else{
		out.println("<script>alert('登录超时或者与服务器的连接中断，请重新登录！');top.location.href = '" 
			+ contextPath + "/index.jsp';</script>");
	}
	
	String v_downloadAppPic = "app_tangyin.jpg"; // 默认为汤阴
	String v_downloadAppTitle = "";
	
	if (ls_aaa027_4 != null && "4117".equalsIgnoreCase(ls_aaa027_4)){
		v_downloadAppPic = "app_zhumadian.jpg";
		v_downloadAppTitle = "驻马店手机APP下载";		
	}
	if (ls_aaa027_4 != null && "4114".equalsIgnoreCase(ls_aaa027_4)){
		v_downloadAppPic = "app_shangqiu.jpg";
		v_downloadAppTitle = "商丘手机APP下载";		
	}
	if (ls_aaa027_6 != null && "410523".equalsIgnoreCase(ls_aaa027_6)){
		v_downloadAppPic = "app_tangyin.jpg";
		v_downloadAppTitle = "汤阴手机APP下载";
	}

	if (ls_aaa027_6 != null && "411282".equalsIgnoreCase(ls_aaa027_6)){
		v_downloadAppPic = "app_lingbao.jpg";
		v_downloadAppTitle = "灵宝手机APP下载";			
	}
	
	if (ls_aaa027_6 != null && "410482".equalsIgnoreCase(ls_aaa027_6)){
		v_downloadAppPic = "app_ruzhou.jpg";
		v_downloadAppTitle = "汝州手机APP下载";			
	}
	
	if (ls_aaa027_6 != null && "410122".equalsIgnoreCase(ls_aaa027_6)){
		v_downloadAppPic = "app_zhongmou.jpg";
		v_downloadAppTitle = "中牟手机APP下载";			
	}
	if (ls_aaa027_6 != null && "410500".equalsIgnoreCase(ls_aaa027_6)){
		v_downloadAppPic = "app_anyang.jpg";
		v_downloadAppTitle = "安阳手机APP下载";
	}
%>
<%
	String systemcode = StringHelper.showNull2Empty(request.getSession().getAttribute("systemcode"));		
	if(!"".equals(systemcode)){
		menuData = SysmanageUtil.getMenuDataBySystemcode(menuData, systemcode);
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>食药监局综合监管信息平台</title>
<jsp:include page="${contextPath}/inc_nr.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script src="<%=contextPath%>/pages.js/main.js" type="text/javascript" ></script>
<script type="text/javascript">
	var menus = <%=menuData%>;//<!-- 创建accordion之前必须先准备好【菜单权限数据 】-->
	var message;
	var v_cur_userkind="<%=v_cur_userkind%>";
	var v_base=basePath + 'jslib/plib/kit_admin/build/js/';
	if (v_cur_userkind=="30"||v_cur_userkind=="20"||v_cur_userkind=="21"||v_cur_userkind=="6"||v_cur_userkind=="7"||v_cur_userkind=="8"){
        v_base=basePath + 'jslib/plib/kit_admin/build/js_net/';
	}
	$(function() {
		initLeftMenu();
		layui.config({
			base: v_base,
			version: '1.0.1'
		}).use(['app', 'message'], function() {
			var app = layui.app,
				$ = layui.jquery,
				layer = layui.layer;
			// 将message设置为全局以便子页面调用
			message = layui.message;
			//主入口
			app.set({
				type: 'iframe'
			}).init();
			$('dl.skin > dd').on('click', function() {
				var $that = $(this);
				var skin = $that.children('a').data('skin');
				switchSkin(skin);
			});
			var setSkin = function(value) {
						layui.data('kit_skin', {
							key: 'skin',
							value: value
						});
					},
					getSkinName = function() {
						return layui.data('kit_skin').skin;
					},
					switchSkin = function(value) {
						var _target = $('link[kit-skin]')[0];
						_target.href = _target.href.substring(0, _target.href.lastIndexOf('/') + 1)
							+ value + _target.href.substring(_target.href.lastIndexOf('.'));
						setSkin(value);
					},
					initSkin = function() {
						var skin = getSkinName();
						switchSkin(skin === undefined ? 'default' : skin);
					}();
		});
		if(window.isNeedChgPassWord){
			modifyPwdFun();
		}
	});

	//初始化左侧菜单
	function initLeftMenu() {
		var menulist = '';
		$.each(menus, function(i, n) {
			if(n.childnum > 0){ // 找父类
				$.each(menus, function(ii, ch) { // 找子类
					if (ch.parent == n.functionid){
						menulist += '<dd><a href="javascript:void(0);" kit-target data-options='
							+ '"{url:\'' + ch.location + '\',title:\'' + ch.title + '\',id:\''
							+ ch.functionid + '\',target:\'' + ch.target + '\'}"><span>'
							+ ch.title + '</span></a></dd>';
					}
				});
				var icon = n.imageurl ? n.imageurl : "&#xe658";
				menulist = '<li class="layui-nav-item">'
					+ '<a href="javascript:void(0);"><i class="layui-icon">' + icon + '</i><span>' + n.title + '</span></a>'
					+ '<dl class="layui-nav-child">' + menulist + '</dl></li>';
				$("#leftMenu").append(menulist);
				menulist = '';
			}
		});
	}
</script>
</head>
<body class="kit-theme">
	<div class="layui-layout layui-layout-admin kit-layout-admin">
		<div class="layui-header">
			<jsp:include page="${contextPath}/jsp/north.jsp"></jsp:include>
		</div>
		<div class="layui-side layui-bg-black kit-side">
			<div class="layui-side-scroll">
				<div class="kit-side-fold"><i class="fa fa-navicon" aria-hidden="true"></i></div>
				<ul id="leftMenu" class="layui-nav layui-nav-tree" lay-filter="kitNavbar" kit-navbar>
				</ul>
			</div>
		</div>
		<div class="layui-body" id="container" style="padding-top: 24px;">
			<div>
				<i class="layui-icon layui-anim layui-anim-rotate layui-anim-loop">&#xe63e;</i>
				请稍等...
			</div>
		</div>
		<div class="layui-footer">
			<!-- 底部固定区域 -->
			版权所有@<a href="http://www.hnaskj.com" target="_blank">河南安盛科技股份有限公司</a>
		</div>
	</div>
	<div id="loginDialog" title="解锁登录" style="display: none;">
		<form id="fm" method="post" class="form" >
			<label class="layui-form-label">登录名</label>
			<div class="layui-input-block">
				<input id="userName" name="userName" type="text" value="<%=ls_username %>" style="width: 200px;" readonly="readonly" class="layui-input">
			</div>
			<label class="layui-form-label">密码</label>
			<div class="layui-input-block">
				<input id="userPwd" name="userPwd" type="password" style="width: 200px;" class="layui-input">
			</div>
			<label class="layui-form-label">确认新密码</label>
			<div class="layui-input-block">
				<input id="yzm" name="yzm" type="text" style="width:60px" class="layui-input">
				<img src="<%=contextPath%>/servlet/CodeServlet" id="yzmimg"
					 border="0" onclick="changeImage(this)" style="margin-left: 80px;cursor:pointer;margin-top: -50px"/>
			</div>
		</form>
	</div>
	<div id="passwordDialog" title="修改密码" style="display: none;">
		<form id="fm2" method="post" class="form" >
			<label class="layui-form-label">原密码</label>
			<div class="layui-input-block">
				<input id="passwd" name="passwd" type="password" autocomplete="off" class="layui-input">
			</div>
			<label class="layui-form-label">新密码</label>
			<div class="layui-input-block">
				<input id="passwd2" name="passwd2" type="password" autocomplete="off" class="layui-input">
			</div>
			<label class="layui-form-label">确认新密码</label>
			<div class="layui-input-block">
				<input id="passwd3" name="passwd3" type="password" autocomplete="off" class="layui-input">
			</div>
		</form>
	</div>
	<div id="appdownDialog" title="手机app下载" style="display: none;">
		<div align="center">
			<img height="400" width="800" id="appdownimg" name="appdownimg"
				 alt="" src="<%=basePath%>app/appdownpic/<%=v_downloadAppPic%>">
			<br>
		</div>
	</div>
</body>
</html>