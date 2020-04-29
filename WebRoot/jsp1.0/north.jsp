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
	Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();	
	String ls_userid = "";
	String ls_username = "";
	String ls_description = "";
	String ls_userkind = "";
	String ls_aaa027_4 = sysuser.getAaa027().substring(0,4);
	String ls_aaa027_6 = sysuser.getAaa027().substring(0,6);

	String ls_head_logo = "syjzhpt/head_logo_syjzhpt.png";

	if (ls_aaa027_4!=null && "4117".equalsIgnoreCase(ls_aaa027_4)){
		ls_head_logo="zhumadian/head_logo_zmd.png";
	}
	if (ls_aaa027_4!=null && "4114".equalsIgnoreCase(ls_aaa027_4)){
		ls_head_logo="shangqiu/head_logo_sq.png";
	}
	if (ls_aaa027_6!=null && "410523".equalsIgnoreCase(ls_aaa027_6)){
		ls_head_logo="tangyin/head_logo_ty.png";
	}

	if (ls_aaa027_6!=null && "411282".equalsIgnoreCase(ls_aaa027_6)){
		ls_head_logo="lingbao/head_logo_lb.png";
	}
	
	if (ls_aaa027_6!=null && "410482".equalsIgnoreCase(ls_aaa027_6)){
		ls_head_logo="ruzhou/head_logo_rz.png";
	}	
	//ls_head_logo="zhyq/head_logo_zhyq.png";
	
	String ls_now = new Date().toLocaleString();
	if(sysuser!=null){
		ls_userid = StringHelper.showNull2Empty(sysuser.getUserid());
		ls_username = StringHelper.showNull2Empty(sysuser.getUsername());
		ls_description = StringHelper.showNull2Empty(sysuser.getDescription());
		ls_userkind = StringHelper.showNull2Empty(sysuser.getUserkind());	  
	}

	String datetime = "今天是" + DateUtil.getChineseDate(DateUtil.getCurrentDate()) + DateUtil.getChineseWeek();
%>
<script type="text/javascript" charset="utf-8">
	var lockWindowFun = function() {		
		$('#loginDialog').dialog('open');
	};
	var modifyPwdFun = function() {		
		$('#passwordDialog').dialog('open');
	};
	
	var downloadapp = function() {	
		$('#appdownDialog').dialog('open');
	};
	
	var logoutFun = function() {
		$.messager.confirm('提示', '信息是否已经保存，确实要退出系统吗？', function(r){
			if (r){
				parent.window.location = '<%=contextPath%>/login/logout';
			}
		});			
	};

    var jumpToDashboad = function() {
        var url = 'http://39.106.210.17/WebReport/ReportServer?formlet=%E6%99%BA%E6%85%A7%E9%A3%9F%E8%8D%AF%E7%9B%91%E5%A4%A7%E5%B1%8F.frm';
        window.open(url,'newwindow'+"领导视窗",
            'height=900,width=2000,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,'
            + 'resizable=yes,location=no, status=no');


    };

	var refreshMenu = function(){
		parent.window.location = "<%=contextPath%>/login/gohome";
	};
</script>
<div style="position: absolute; left 80px; top: 0px;">
	<img src="<%=contextPath%>/images/frame/toplogo/<%=ls_head_logo %>"/>
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
	<a href="javascript:void(0);" class="easyui-menubutton" onclick="jumpToDashboad()" data-options="iconCls:'ext-icon-color_swatch'" target="_blank" ><font color="white">领导视窗</font></a>
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_fgMenu',iconCls:'ext-icon-layout'"><font color="white">主题风格</font></a> 
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_pfMenu',iconCls:'ext-icon-rainbow'"><font color="white">更换皮肤</font></a> 
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_kzmbMenu',iconCls:'ext-icon-cog'"><font color="white">控制面板</font></a> 
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_zxMenu',iconCls:'ext-icon-disconnect'"><font color="white">注销</font></a>
</div>
<div id="layout_north_fgMenu" style="width: 100px; display: none;">
	<div data-options="iconCls:'ext-icon-application_side_tree'" onclick="sy.changeMenu('tree');refreshMenu();">树状菜单</div>
	<div class="menu-sep"></div>
	<div data-options="iconCls:'ext-icon-application_tile_vertical'" onclick="sy.changeMenu('accordion');refreshMenu();">伸缩面板</div>
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
<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
	<div data-options="iconCls:'ext-icon-user_edit'" onclick="modifyPwdFun();">修改密码</div>
	<div data-options="iconCls:'ext-icon-phone'" onclick="downloadapp();">手机APP下载</div>
</div>
<div id="layout_north_zxMenu" style="width: 100px; display: none;">
	<div data-options="iconCls:'ext-icon-lock'" onclick="lockWindowFun();">锁定窗口</div>
	<div class="menu-sep"></div>
	<div data-options="iconCls:'ext-icon-door_out'" onclick="logoutFun();">退出系统</div>
</div>