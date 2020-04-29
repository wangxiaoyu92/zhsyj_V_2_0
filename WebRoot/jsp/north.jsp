<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.DateUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
				 + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%	
	Sysuser sysuser = SysmanageUtil.getSysuser();
	String ls_userid = "";
	String ls_username = "";
	String ls_description = "";
	String ls_userkind = "";
	String ls_aaa027_4 = "";
	String ls_aaa027_6 = "";
	boolean isNeedChgPassWord = false;
	if(sysuser != null){
		ls_userid = StringHelper.showNull2Empty(sysuser.getUserid());
		ls_username = StringHelper.showNull2Empty(sysuser.getUsername());
		ls_description = StringHelper.showNull2Empty(sysuser.getDescription());
		ls_userkind = StringHelper.showNull2Empty(sysuser.getUserkind());
		ls_aaa027_4 = sysuser.getAaa027().substring(0,4);
		ls_aaa027_6 = sysuser.getAaa027().substring(0,6);

		isNeedChgPassWord = "e10adc3949ba59abbe56e057f20f883e".equals(sysuser.getPasswd());
		out.println(isNeedChgPassWord);
	}else{
		out.println("<script>alert('登录超时或者与服务器的连接中断，请重新登录！');top.location.href = '"
				+ contextPath + "/index.jsp';</script>");

	}
	String ls_head_logo = "/images/frame/toplogo/syjzhpt/head_logo_syjzhpt.png";
	String indexImg = StringHelper.showNull2Empty(SysmanageUtil.getAa01("INDEX_IMG").getAaa005());
	if (!"".equals(indexImg)){
		ls_head_logo = indexImg;
	}
	if ("zhongmou".equals(SysmanageUtil.g_wheresys)){
		ls_head_logo = "/images/frame/toplogo/zhongmou/head_logo_zhongmou2.png";
	}
	String datetime = "今天是" + DateUtil.getChineseDate(DateUtil.getCurrentDate()) + DateUtil.getChineseWeek();

%>
<script type="text/javascript" charset="utf-8">
	window.isNeedChgPassWord = <%=isNeedChgPassWord%>;
	// 锁屏
	var lockWindowFun = function() {		
		layer.open({
			type: 1
			,title: '锁屏输入'//不显示标题栏
			,closeBtn: false
			,area: '600px;'
			,shade: 0.8
			,id: 'LAY_loginDialog' //设定一个id，防止重复弹出
			,btn: ['确认登入']
			,btnAlign: 'c'
			,moveType: 1 //拖拽模式，0或者1
			,content:$('#loginDialog')
			,yes: function(){
				unlockWindow();
			}

		});
	};
	// 修改密码
	var modifyPwdFun = function() {
		layer.open({
			type: 1
			,title: '修改密码'//不显示标题栏
			,closeBtn: false
			,area: '600px;'
			,shade: 0.3
			,id: 'LAY_passwordDialog' //设定一个id，防止重复弹出
			,btn: ['确认修改', '取消']
			,btnAlign: 'c'
			,moveType: 1 //拖拽模式，0或者1
			,content:
					$('#passwordDialog')
			,yes: function(){
					modifyPwd();
			}
		});
	};
	// 手机app下载
	var downloadapp = function() {	

		layer.open({
			type: 1
			,title: 'APP下载'//不显示标题栏
			,closeBtn: false
			,area: '1000px;'
			,shade: 0.3
			,id: 'LAY_appdownDialog' //设定一个id，防止重复弹出
			,btn: ['确认', '取消']
			,btnAlign: 'c'
			,moveType: 1 //拖拽模式，0或者1
			,content:
					$('#appdownDialog').html()

		});
	};
	// 注销退出
	var logoutFun = function() {
		layer.confirm('信息是否已经保存，确实要退出系统吗？', {icon: 3, title:'提示'}, function(index){
			parent.window.location = '<%=contextPath%>/login/logout';
			layer.close(index);
		});
	};
    var jumpToDashboad = function() {
        var url = 'http://39.106.210.17/WebReport/ReportServer?formlet=%E6%99%BA%E6%85%A7%E9%A3%9F%E8%8D%AF%E7%9B%91%E5%A4%A7%E5%B1%8F.frm';
        window.open(url,'newwindow'+"智慧食药大数据",
            'height=900,width=2000,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,'
            + 'resizable=yes,location=no, status=no');


    };
	var refreshMenu = function(){
		parent.window.location = "<%=contextPath%>/login/gohome";
	};
</script>
<div class="layui-logo" style="position: absolute;">
	<img src="<%=contextPath + ls_head_logo%>" onclick="jumpToDashboad();"/>
</div>
<div class="layui-logo kit-logo-mobile"></div>
<div id="sessionInfoDiv2" style="position: absolute; right: 20px; top: 10px;">
	<font color="white">
		<%
			out.print(StringHelper.formateString("{0}",datetime));
		%>
	</font>
</div>
<ul class="layui-nav layui-layout-right kit-nav" style="padding-bottom: 0px;padding-top: 20px;">
	<% if ("410122".equals(ls_aaa027_6)){%>
	<li class="layui-nav-item">
		<a href="<%=contextPath%>/index_zhsyj_zm.jsp" target="_blank"><i class="iconfont icon-zhanghu"></i><cite>公众端</cite></a>
	</li>
	<%}%>
	<li class="layui-nav-item">
		<a href="javascript:lockWindowFun();"><i class="iconfont icon-lock1"></i><cite>锁屏</cite></a>
	</li>
	<li class="layui-nav-item">
		<a href="javascript:void(0);"><i class="iconfont icon-huanfu"></i>皮肤</a>
		<dl class="layui-nav-child skin">
			<dd>
				<a href="javascript:void(0);" data-skin="default" style="color:#393D49;">
					<i class="layui-icon">&#xe658;</i> 默认</a>
			</dd>
			<dd>
				<a href="javascript:void(0);" data-skin="orange" style="color:#ff6700;">
					<i class="layui-icon">&#xe658;</i> 橘子橙</a>
			</dd>
			<dd>
				<a href="javascript:void(0);" data-skin="green" style="color:#00a65a;">
					<i class="layui-icon">&#xe658;</i> 原谅绿</a></dd>
			<dd><a href="javascript:void(0);" data-skin="pink" style="color:#FA6086;">
				<i class="layui-icon">&#xe658;</i> 少女粉</a>
			</dd>
			<dd>
				<a href="javascript:void(0);" data-skin="blue.1" style="color:#00c0ef;">
					<i class="layui-icon">&#xe658;</i> 天空蓝</a>
			</dd>
			<dd>
				<a href="javascript:void(0);" data-skin="red" style="color:#dd4b39;">
					<i class="layui-icon">&#xe658;</i> 枫叶红</a>
			</dd>
		</dl>
	</li>
	<li class="layui-nav-item">
		<a href="javascript:;">
			<%=ls_username%>
		</a>
		<dl class="layui-nav-child">
			<dd>
				<a href="javascript:modifyPwdFun();">
					<span><i class="iconfont icon-zhanghu" data-icon="icon-zhanghu"></i> 修改密码</span>
				</a>
			</dd>
			<dd>
				<a href="javascript:downloadapp();">
					<span><i class="iconfont icon-shezhi1" data-icon="icon-shezhi1"></i> 手机app下载</span>
				</a></dd>
		</dl>
	</li>
	<li class="layui-nav-item">
		<a href="javascript:logoutFun();"><i class="iconfont icon-loginout"></i> 注销退出</a>
	</li>
</ul>