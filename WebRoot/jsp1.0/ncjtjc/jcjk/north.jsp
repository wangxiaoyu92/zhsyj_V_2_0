<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.DateUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String menuData = (String)SysmanageUtil.getMenuData();		
	Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();	
	String ls_userid = "";
	String ls_username = "";
	String ls_description = "";
	String ls_userkind = "";
	String ls_now = new Date().toLocaleString();
	if(sysuser!=null){
		ls_userid = sysuser.getUserid()==null?null:sysuser.getUserid().toString();
		ls_username = sysuser.getUsername();
		ls_description = sysuser.getDescription();
		ls_userkind = sysuser.getUserkind();	  
	}

	String datetime = "今天是" + DateUtil.getChineseDate(DateUtil.getCurrentDate()) + DateUtil.getChineseWeek();
%>
<div style="position: absolute; left 80px; top: 0px;">
	<img src="<%=contextPath%>/images/frame/wl/head_logo_jk.png"/>
</div>
<div id="sessionInfoDiv" style="position: absolute; right: 20px; top: 5px;">
	<font color="white">
	<%
		out.print(StringHelper.formateString("欢迎您，{0}",ls_username));
	%>
	</font>
</div>
<div id="sessionInfoDiv2" style="position: absolute; right: 20px; top: 25px;">
	<font color="white">
	<%
		out.print(StringHelper.formateString("{0}",datetime));
	%>
	</font>
</div>
<div style="position: absolute; right: 0px; bottom: 0px;">
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_pfMenu',iconCls:'ext-icon-rainbow'"><font color="white">更换皮肤</font></a> 
</div>
<div id="layout_north_pfMenu" style="width: 100px; display: none;">
	<div data-options="iconCls:'ext-icon-color_swatch'" onclick="sy.changeTheme('default');" id="default" title="default">default</div>
	<div data-options="iconCls:'ext-icon-color_swatch'" onclick="sy.changeTheme('gray');" id="gray" title="gray">gray</div>
	<div data-options="iconCls:'ext-icon-color_swatch'" onclick="sy.changeTheme('metro');" id="metro" title="metro">metro</div>
	<div data-options="iconCls:'ext-icon-color_swatch'" onclick="sy.changeTheme('bootstrap');" id="bootstrap" title="bootstrap">bootstrap</div>
	<div data-options="iconCls:'ext-icon-color_swatch'" onclick="sy.changeTheme('black');" id="black" title="black">black</div>
	<div class="menu-sep"></div>
	<div data-options="iconCls:'ext-icon-color_swatch'" onclick="sy.changeTheme('metro-blue');" id="metro-blue" title="metro-blue">metro-blue</div>
	<div data-options="iconCls:'ext-icon-color_swatch'" onclick="sy.changeTheme('metro-gray');" id="metro-gray" title="metro-gray">metro-gray</div>
	<div data-options="iconCls:'ext-icon-color_swatch'" onclick="sy.changeTheme('metro-green');" id="metro-green" title="metro-green">metro-green</div>
	<div data-options="iconCls:'ext-icon-color_swatch'" onclick="sy.changeTheme('metro-orange');" id="metro-orange" title="metro-orange">metro-orange</div>
	<div data-options="iconCls:'ext-icon-color_swatch'" onclick="sy.changeTheme('metro-red');" id="metro-red" title="metro-red">metro-red</div>
</div>