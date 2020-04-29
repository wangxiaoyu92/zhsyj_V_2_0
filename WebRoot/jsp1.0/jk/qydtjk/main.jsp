<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="java.util.*,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
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
	String ls_now = new Date().toLocaleString();
	if(sysuser!=null){
		ls_userid = StringHelper.showNull2Empty(sysuser.getUserid());
		ls_username = StringHelper.showNull2Empty(sysuser.getUsername());
		ls_description = StringHelper.showNull2Empty(sysuser.getDescription());
		ls_userkind = StringHelper.showNull2Empty(sysuser.getUserkind());	  	  
	}else{
	  	out.println("<script>alert('登录超时或者与服务器的连接中断，请重新登录！');top.location.href = '" + contextPath + "/index.jsp';</script>");
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>企业地图监控</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
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
		});
		mainTabs.tabs({
			onSelect : function(title){
				if(title!='欢迎使用'){    
					refresh();    
			    } 
			}   
		});		
		tabMenuEvent();				
	});

	
	//添加选项卡
	function addTab(tabTitle,url,icon){		
		if (mainTabs.tabs('exists', tabTitle)) {
			//mainTabs.tabs('select', tabTitle);
			var currentTab = mainTabs.tabs('getSelected');
			mainTabs.tabs('update', {
	            tab: currentTab,
	            options: {
	                content: createFrame(url)
	            }
	        });    
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
	<div id="loading-mask" style="position:absolute;top:0px; left:0px; width:100%; height:100%; background:#D2E0F2; z-index:20000">
		<div id="pageloading" style="position:absolute; top:50%; left:50%; margin:-120px 0px 0px -120px; text-align:center;  border:2px solid #8DB2E3; width:200px; height:40px;  font-size:14px;padding:10px; font-weight:bold; background:#fff; color:#15428B;"><img src="<%=contextPath%>/images/frame/loading.gif" align="absmiddle" /> 正在加载中,请稍候...</div>
	</div>
	<noscript>
		<div style="position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
		    <img src="<%=contextPath%>/images/frame/noscript.gif" alt='抱歉，请开启脚本支持！' />
		</div>
	</noscript>
	
<%--	<div data-options="region:'north',href:'<%=contextPath%>/jsp/ncjtjc/jcjk/north.jsp'" style="height: 70px; overflow: hidden; background:url(<%=contextPath%>/images/frame/head_bg.jpg) repeat-x; " ></div>--%>
	<div data-options="region:'west',href:'<%=contextPath%>/jsp/jk/qydtjk/west.jsp',split:true" title="导航" style="width: 300px; ">		
	</div>
	<div data-options="region:'center'" style="overflow: hidden;">
		<div id="mainTabs" >
			<div title="欢迎使用" data-options="iconCls:'ext-icon-heart'">
				<iframe src="<%=contextPath%>/jk/jkgl/qydtjkmonitorIndex" allowTransparency="true" style="border: 0; width: 100%; height: 99%;" frameBorder="0"></iframe>
			</div>
		</div>
	</div>
	<div data-options="region:'south',href:'<%=contextPath%>/jsp/south.jsp',border:false" style="height: 30px; overflow: hidden;"></div>

	
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
