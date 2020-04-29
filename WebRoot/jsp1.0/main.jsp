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
	String menuData = (String)SysmanageUtil.getMenuData();
	Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();	
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
	
	String v_downloadAppPic = "";
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
%>
<%
	String systemcode = StringHelper.showNull2Empty(request.getSession().getAttribute("systemcode"));		
	if(!"".equals(systemcode)){
		menuData = (String)SysmanageUtil.getMenuDataBySystemcode(menuData,systemcode);
	}
	
	String pwflag = StringHelper.showNull2Empty(request.getSession().getAttribute("passwordflag"));
%>
<!DOCTYPE html>
<html>
<head>
<title>食药监局综合监管信息平台</title>
<jsp:include page="${contextPath}/inc_nr.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script src="<%=contextPath%>/pages.js/main.js" type="text/javascript" ></script>
<script type="text/javascript">
	var setting = {
		view: {
			showLine: false
		},	
		data: {
			simpleData: {						
				enable: true,
				idKey: "functionid",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "title"
			}
		},
		callback: {
			onClick: onClick
		}
	};

	//单击节点列表
	function onClick(event, treeId, treeNode) {          
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = zTree.getSelectedNodes();
		var title = nodes[0].title;		
		var url = nodes[0].location;
		var target = nodes[0].target;	 							
		if(url != '' && url != null && url != 'undefined'){										
			if (target != '' && target != null && target != 'undefined') {
				if(sy.startWith(url,'http:')){
					window.open(url,'newwindow'+title,
					'height=2000,width=2000,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,' 
					+ 'resizable=yes,location=no, status=no');
				}else{
					window.open(contextPath + url,'newwindow'+title,
					'height=2000,width=2000,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,' 
					+ 'resizable=yes,location=no, status=no');
				}
			} else {
				addTab(title,url,'ext-icon-html');
			}			
		}
	}

	//初始化菜单树
	function refreshZTree(){		
		//准备zTree数据
		var zNodes = eval(menus);
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	}				
</script>
<script type="text/javascript">	 
	var menus = <%=menuData %>;//<!-- 创建accordion之前必须先准备好【菜单权限数据 】-->
	var pwflag = "<%=pwflag %>";
	window.onload = function(){
		$('#loading-mask').fadeOut();
	};
	      	
	var onlyOpenTitle = '欢迎使用';
	var mainTabs;	
	$(function() {	
		$('#appdownDialog').show().dialog({
			modal : true,
			closable : false,
			width : 820,
			heigth : 500,
			iconCls : 'ext-icon-phone',
			buttons : [{
				text : '关闭',
				handler : function() {
					$('#appdownDialog').dialog('close');
				}
			}  ]
		}).dialog('close');
		
		//'center'面板被缩放后触发
		$('#mainLayout').layout('panel', 'center').panel({
			onResize : function(width, height) {
				sy.setIframeHeight('centerIframe', $('#mainLayout').layout('panel', 'center').panel('options').height - 5);
			}
		});
		
		mainTabs = $('#mainTabs').tabs({
			fit : true,
			border : false,
			tools : [ {
				iconCls : 'ext-icon-arrow_up',
				handler : function() {
					mainTabs.tabs({
						tabPosition : 'top'
					});
				}
			}, {
				iconCls : 'ext-icon-arrow_left',
				handler : function() {
					mainTabs.tabs({
						tabPosition : 'left'
					});
				}
			}, {
				iconCls : 'ext-icon-arrow_down',
				handler : function() {
					mainTabs.tabs({
						tabPosition : 'bottom'
					});
				}
			}, {
				iconCls : 'ext-icon-arrow_right',
				handler : function() {
					mainTabs.tabs({
						tabPosition : 'right'
					});
				}
			}, {
				text : '刷新',
				iconCls : 'ext-icon-arrow_refresh',
				handler : function() {
					var panel = mainTabs.tabs('getSelected').panel('panel');
					var frame = panel.find('iframe');
					try {
						if (frame.length > 0) {
							for (var i = 0; i < frame.length; i++) {
								frame[i].contentWindow.document.write('');
								frame[i].contentWindow.close();
								frame[i].src = frame[i].src;
							}
							if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
								try {
									CollectGarbage();
								} catch (e) {
								}
							}
						}
					} catch (e) {
					}
				}
			}, {
				text : '关闭',
				iconCls : 'ext-icon-cross',
				handler : function() {
					var index = mainTabs.tabs('getTabIndex', mainTabs.tabs('getSelected'));
					var tab = mainTabs.tabs('getTab', index);
					if (tab.panel('options').closable) {
						mainTabs.tabs('close', index);
					} else {
						$.messager.alert('提示', '[' + tab.panel('options').title + ']页面不可以被关闭！', 'error');
					}
				}
			} ]

		});///////
		
		initLeftMenu();
		tabMenuEvent();
		
        mainTabs.tabs({
			onSelect : function(title){
				if(title=='待办任务'){ 
					if(daibanrenwuframe.window.myrefreshdaiban){
						daibanrenwuframe.window.myrefreshdaiban();  
					}
			    } 
			}   
		});
		
		if(pwflag=='1'){
			$('#passwordDialog').dialog('open');
		}	
	});

	//初始化左侧菜单
	function initLeftMenu() {
		if(easyuiMenu=='tree'){
			refreshZTree();
		}else{
			$("#nav").accordion({
				animate:false,
				fit:true,
				border:false
			});
	
			var menulist = '';		
		    $.each(menus, function(i, n) {
		    	if(n.childnum>0){//找父类		
		    		$.each(menus, function(ii, ch) {//找子类
		    			if (ch.parent==n.functionid){
		    				menulist += '<li><div><a ref="'+ch.functionid+'" href="javascript:void(0);" rel="' 
		    					+ ch.location + '" targets="' + ch.target 
		    					+ '" ><span class="icon icon-nav" >&nbsp;</span><span class="nav">' 
		    					+ ch.title + '</span></a></div> </li>';
		    			}
		    		});			
					menulist = '<ul class="navlist">'+menulist+"</ul>";
	
		    		$('#nav').accordion('add', {
		    			title: n.title,
		    			iconCls: 'ext-icon-ruby',
		    			content: menulist,
		    			border:false	
		    		});
	
		    		menulist="";
				}		
		    });
	
		    //$('#nav').accordion('select',0);
		    
			$('.navlist li a').click(function(){
				var title = $(this).children('.nav').text();
				var url = $(this).attr("rel");
				var target = $(this).attr("targets");
				if(url != '' && url != null && url != 'undefined'){										
					if (target != '' && target != null && target != 'undefined') {
						if(sy.startWith(url,'http:')){
							window.open(url,'newwindow'+title,
							'height=2000,width=2000,top=0,left=0,toolbar=no,menubar=no,'
							+ 'scrollbars=no, resizable=yes,location=no, status=no');
						}else{
							window.open(contextPath + url,'newwindow'+title,
							'height=2000,width=2000,top=0,left=0,toolbar=no,menubar=no,'
							+ 'scrollbars=no, resizable=yes,location=no, status=no');
						}
					} else {
						addTab(title,url,'ext-icon-html');
					}			
				}			
				
				$('.navlist li div').removeClass("selected");
				$(this).parent().addClass("selected");
			}).hover(function(){
				$(this).parent().addClass("hover");
			},function(){
				$(this).parent().removeClass("hover");
			});
		}
	}
	
	//添加选项卡
	function addTab(tabTitle,url,icon){		
		if (mainTabs.tabs('exists', tabTitle)) {
			mainTabs.tabs('select', tabTitle);
			/*
			var currentTab = mainTabs.tabs('getSelected');
			mainTabs.tabs('update', {
	            tab: currentTab,
	            options: {
	                content: createFrame(url)
	            }
	        }); */   
		} else {
			mainTabs.tabs('add', {
				title : tabTitle,
				closable : true,
				iconCls : 'ext-icon-html',
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
		var s = sy.formatString('<iframe src="{0}" allowTransparency="true"' 
			+ 'style="border:0;width:100%;height:99%;" frameBorder="0"></iframe>', contextPath + url);
		return s;
	}
	function createFrame2(src)
	{   
		var s = sy.formatString('<iframe src="{0}" allowTransparency="true"' 
			+ 'style="border:0;width:100%;height:99%;" frameBorder="0"></iframe>', src);
		return s;
	}

	//关闭选项卡
	function tabMenu(){
		/*双击关闭TAB选项卡*/
		$(".tabs-inner").dblclick(function(){
			var subtitle = $(this).children(".tabs-closable").text();
			mainTabs.tabs('close',subtitle);
		});
		/*为选项卡绑定右键菜单*/
		$(".tabs-inner").bind('contextmenu',function(e){
			$('#mm').menu('show', {
				left: e.pageX,
				top: e.pageY
			});

			var subtitle =$(this).children(".tabs-closable").text();
			$('#mm').data("currtab",subtitle);
			mainTabs.tabs('select',subtitle);
			return false;
		});
	}


	//绑定右键菜单事件
	function tabMenuEvent() {
	    $('#mm').menu({
	        onClick: function (item) {
	            closeTab(item.id);
	        }
	    });

	    return false;
	}

	function closeTab(action){
	    var alltabs = mainTabs.tabs('tabs');
	    var currentTab = mainTabs.tabs('getSelected');
		var allTabtitle = [];
		$.each(alltabs,function(i,n){
			allTabtitle.push($(n).panel('options').title);
		});

	    switch (action) {
	        case "refresh":
	            var iframe = $(currentTab.panel('options').content);
	            var src = iframe.attr('src');
	            mainTabs.tabs('update', {
	                tab: currentTab,
	                options: {
	                    content: createFrame2(src)
	                }
	            });
	            break;
	        case "close":
	            var currtab_title = currentTab.panel('options').title;
	            if (currtab_title != onlyOpenTitle){
	            	mainTabs.tabs('close', currtab_title);
	            }
	            break;
	        case "closeall":
	            $.each(allTabtitle, function (i, n) {
	                if (n != onlyOpenTitle){
	                    mainTabs.tabs('close', n);
					}
	            });
	            break;
	        case "closeother":
	            var currtab_title = currentTab.panel('options').title;
	            $.each(allTabtitle, function (i, n) {
	                if (n != currtab_title && n != onlyOpenTitle){
	                    mainTabs.tabs('close', n);
					}
	            });
	            break;
	        case "closeright":
	            var tabIndex = mainTabs.tabs('getTabIndex', currentTab);
	            if (tabIndex == alltabs.length - 1){
	                return false;
	            }
	            $.each(allTabtitle, function (i, n) {
	                if (i > tabIndex) {
	                    if (n != onlyOpenTitle){
	                        mainTabs.tabs('close', n);
						}
	                }
	            });
	            break;
	        case "closeleft":
	            var tabIndex = mainTabs.tabs('getTabIndex', currentTab);
	            if (tabIndex == 1) {
	                return false;
	            }
	            $.each(allTabtitle, function (i, n) {
	                if (i < tabIndex) {
	                    if (n != onlyOpenTitle){
	                        mainTabs.tabs('close', n);
						}
	                }
	            });
	            break;
	        case "exit":
	            $('#mm').menu('hide');
	            break;
	    }
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
	<div id="loading-mask" style="position:absolute;top:0px; left:0px; width:100%; 
		height:100%; background:#D2E0F2; z-index:20000">
		<div id="pageloading" style="position:absolute; top:50%; left:50%; 
			margin:-120px 0px 0px -120px; text-align:center;  border:2px solid #8DB2E3; 
			width:200px; height:40px;  font-size:14px;padding:10px; 
			font-weight:bold; background:#fff; color:#15428B;">
			<img src="<%=contextPath%>/images/frame/loading.gif" align="absmiddle" /> 正在加载中,请稍候...</div>
	</div>
	<noscript>
		<div style="position:absolute; z-index:100000; height:2046px;top:0px;left:0px; 
		width:100%; background:white; text-align:center;">
		    <img src="<%=contextPath%>/images/frame/noscript.gif" alt='抱歉，请开启脚本支持！' />
		</div>
	</noscript>
	
	<div data-options="region:'north',href:'<%=basePath%>jsp/north.jsp'" 
		style="height: 70px; overflow: hidden; background:url(<%=contextPath%>/images/frame/head_bg.jpg) repeat-x; " ></div>
	<div data-options="region:'west',split:true" title="导航" style="width: 200px;overflow: hidden; ">
		<div id="nav"></div>		
		<ul id="treeDemo" class="ztree" ></ul> 
	</div>
	<div data-options="region:'center'" style="overflow: hidden;">
		<div id="mainTabs" >
<%--			<div title="待办任务" data-options="iconCls:'ext-icon-heart'">--%>
<%--				<iframe id="daibanrenwuframe" name="daibanrenwuframe" 
						src="<%=basePath%>jsp/workflowyewu/wfyw_daiban.jsp" allowTransparency="true" 
						style="border: 0; width: 100%; height: 99%;" frameBorder="0"></iframe>--%>
<%--			</div>		--%>
			<div title="欢迎使用" data-options="iconCls:'ext-icon-heart'">
				<iframe src="<%=basePath%>jsp/welcome.jsp" allowTransparency="true" 
				style="border: 0; width: 100%; height: 99%;" frameBorder="0"></iframe>
			</div>
		</div>
	</div>
	<div data-options="region:'south',href:'<%=basePath%>jsp/south.jsp',border:false" 
		style="height: 30px; overflow: hidden;"></div>

	<div id="loginDialog" title="解锁登录" style="display: none;">
		<form id="fm" method="post" class="form" >
			<table class="table">
				<tr>
					<th width="50">登录名</th>
					<td><input id="userName" name="userName"  value="<%=ls_username %>" 
						style="width: 200px;" readonly="readonly" class="input_readonly" /></td>
				</tr>
				<tr>
					<th>密码</th>
					<td><input id="userPwd" name="userPwd" type="password" style="width: 200px;" 
						class="text-input validate[required]"/></td>
				</tr>
				<tr>
				    <th>验证码</th>
        			<td>
        				<input id="yzm" name="yzm" style="width:60px" class="text-input validate[required]" />
        				<img src="<%=contextPath%>/servlet/CodeServlet" id="yzmimg" 
        					border="0" onclick="changeImage(this)" style="cursor:pointer" />
        			</td>
        		</tr>
        		<input id="userkind" name="userkind" value="<%=ls_userkind %>" type="hidden"/>
			</table>
		</form>
	</div>

	<div id="passwordDialog" title="修改密码" style="display: none;">
		<form id="fm2" method="post" class="form" >
			<table class="table">
				<tr>
					<th>原密码</th>
					<td><input id="passwd" name="passwd" type="password" class="text-input validate[required]"/></td>
				</tr>
				<tr>
					<th>新密码</th>
					<td><input id="passwd2" name="passwd2" type="password" 
						class="text-input validate[required,minSize[1],maxSize[20]]" /></td>
				</tr>
				<tr>
					<th>确认新密码</th>
					<td><input id="passwd3" name="passwd3" type="password" 
						class="text-input validate[condRequired[passwd2],equals[passwd2]]"/></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="appdownDialog" title="手机app下载" style="display: none;">
	    <div align="center">
	    <img height="400" width="800" id="appdownimg" name="appdownimg" 
	    	alt="" src="<%=basePath %>app/appdownpic/<%=v_downloadAppPic%>">
	    <br>
	</div>		
	<div id="mm" class="easyui-menu" style="width:150px;">
		<div id="refresh">刷新</div>
		<div class="menu-sep"></div>
		<div id="close">关闭</div>
		<div id="closeall">关闭全部</div>
		<div id="closeother">关闭其他</div>
		<div class="menu-sep"></div>
		<div id="closeright">关闭右侧标签</div>
		<div id="closeleft">关闭左侧标签</div>
		<div class="menu-sep"></div>
		<div id="exit">退出</div>
	</div>
</body>
</html>