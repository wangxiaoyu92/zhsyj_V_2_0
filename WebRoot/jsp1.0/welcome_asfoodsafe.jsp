<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.DateUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser,com.askj.baseinfo.service.pub.PubService" %>
<%@ page import="com.askj.baseinfo.dto.DaibanshixiangDTO,com.zzhdsoft.siweb.dto.PagesDTO" %>

<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
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
	}

	String datetime = "今天是" + DateUtil.getChineseDate(DateUtil.getCurrentDate()) + " " + DateUtil.getChineseWeek();

	//gu20161015add
	//DaibanshixiangDTO v_dto=new DaibanshixiangDTO();
	//PagesDto v_pd= new PagesDto();
	//PubService v_PubService= new PubService();
	//DaibanshixiangDTO v_getDaibanshixiangDTO = (DaibanshixiangDTO)v_PubService.queryDaibanshixiang(v_dto, v_pd);	
%>
<!DOCTYPE html>
<html>
<head>
<title>欢迎页面</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<style type="text/css">		
	/*右下角弹出信息框样式*/
	#pop{width:260px;background:#cfdef5;border:1px solid #95b8e7;font-size:12px;
		position: fixed;right:10px;bottom:10px;}
	#popHead{line-height:32px;background:#CEDEF3;border-bottom:1px solid #95b8e7;
		position:relative;font-size:12px;padding:0 0 0 10px;}
	#popHead h2{color:#1a2950;font-size:14px;line-height:32px;height:32px;}/*弹出信息最上面提示标题*/
	#popHead #popClose{color:#1a2950;color:red;position:absolute;right:10px;top:1px;}/*关闭*/
	#popHead a#popClose:hover{color:red;cursor:pointer;}/*关闭HOVER时*/
	#popContent{padding:5px 10px;}/*弹出信息内容*/
	#popTitle a{color:#333;line-height:24px;font-size:14px;font-family:'微软雅黑';
		font-weight:bold;text-decoration:none;}/*消息提醒标题*/
	#popTitle a:hover{color:#f60;}/*消息提醒标题HOVER时*/
	#popIntro{text-indent:0px;line-height:160%;margin:5px 0;color:#1a2950;}/*内容详情text-indent:24px;*/
	#popMore{text-align:right;border-top:1px dotted #ccc;line-height:24px;margin:8px 0 0 0;}/*查看*/
	#popMore a{color:#f40;text-decoration:none}/*查看a*/
	#popMore a:hover{color:#f00;}/*查看 »a:hover*/
</style>
</head>
<script type="text/javascript" src="<%=contextPath%>/jslib/yanue.pop.js"></script>
<script type="text/javascript" charset="utf-8">
	$(function(){		 		
		//loadSjqdrs();
		//loadSjzstx();
		//var id = setInterval('loadSjqdrs()',6000);
		getbqsx();
	});

	//待办事项
	function loadSjqdrs(){
		$.post(basePath + '/common/sjb/querySjqd', {
			aae016 : '0'
		},
		function(result) {
			if (result.code == '0') {
				$('#sjqdrs').html('0');	
				$('#sjqdrs').html(result.count);	
			} else {
				$('#p3').html("获取未复核司机签到记录失败：" + result.msg);
			}
		},'json');	  	
	}
	//证审提醒
	function loadSjzstx(){
	    $.post(basePath + '/common/sjb/querySjzstx', {

		},
		function(result) {
			if (result.code == '0') {
				$("#jsz").html('0');	
				$("#xsz").html('0');	
				$("#yyz").html('0');	
				$("#ew").html('0');	
				$("#jqx").html('0');	
				$("#syx").html('0');	
				$("#jsz").html(result.jsz);	
				$("#xsz").html(result.xsz);	
				$("#yyz").html(result.yyz);	
				$("#ew").html(result.ew);	
				$("#jqx").html(result.jqx);	
				$("#syx").html(result.syx);	
			} else {
				$("#p4").html("获取证审提醒信息失败：" + result.msg);
			}
		},'json');		
	}
	//查看证审提醒详细信息
	function loadSjzstxDetail(txlx){		
		var dialog = parent.sy.modalDialog({
			title : '查看预警信息',
			width : 800,
			height : 500,
			url : basePath + '/common/sjb/sjzstxIndex?op=' + txlx,
			buttons : [ {
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		},function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		});   
	}

	//弹出提示窗口
	function showMessage(){
		$.post(basePath + '/common/sjb/querySjqd', {
			aae016 : '0'
		},
		function(result) {
			if (result.code == '0') {
				var pop = new Pop("","标题连接网址","你有【<font style='color:red;font-weight:bold'>"+result.count+"</font>】条司机签到记录未审核，请及时处理！<br/>");	
			} else {
				$.messager.alert('提示', "操作失败：" + result.msg, 'error');
			}
		},'json');	  
	}
	
	//报请 已阅  
	function baoqingchuli(){	 
	   	var url = basePath + 'pub/pub/baoqingchuliIndex';
		var dialog = parent.sy.modalDialog({
				title : '报请',
				width : 1000,
				height : 560,
				url : url
		},function(dialogID) {
			getbqsx();
		    sy.removeWinRet(dialogID);//不可缺少
		}); 
	}
	
	function getbqsx(){
		$.post(basePath + '/pub/pub/queryDaibanshixiang', {
		}, 
		function(result) {
			if (result.code=='0') {
				var mydata = result.data;	
				$('#baoqingsx').val(mydata.baoqingsx);			
			} else {
				parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
            }	
			parent.$.messager.progress('close');
		}, 'json');	  	
	}
	
</script>
<body>
	<div region="center" border="false">
		<table style="width: 100%;">
			<tr align="center" >				
				<td width="50%" valign="top" height="100%">
					<div id="p1" class="easyui-panel" title="平台介绍"     
				        style="width:500px;height:220px;padding:10px;background:#fafafa;"   
				        data-options="iconCls:'ext-icon-flag_blue',closable:false,    
				                collapsible:true,minimizable:false,maximizable:false">   
					    <p>欢迎使用安盛食品安全溯源监管平台！</p>   
					    <p>
							<%
								out.print(StringHelper.formateString("欢迎您，{0}！",ls_username));
							%>
						</p>   
					    <p>
							<%
								out.print(StringHelper.formateString("{0}",datetime));
							%>
						</p>   
					</div> 	        
				</td>
				<td width="50%" valign="top" height="100%">
					<div id="p2" class="easyui-panel" title="通知公告"     
				        style="width:500px;height:220px;padding:10px;background:#fafafa;"   
				        data-options="iconCls:'ext-icon-bell',closable:false,    
				                collapsible:true,minimizable:false,maximizable:false">   
					    <p><font style='color:red;font-weight:bold' id="notice">
					    	安盛食品安全溯源监管平台上线测试，如有问题请联系系统管理员！</font></p>     
					</div> 													
				</td>						
			</tr>
			<tr align="center" >				
				<td width="50%" valign="top" height="100%">
					<div id="p3" class="easyui-panel" title="待办事项"     
				        style="width:500px;height:220px;padding:10px;background:#fafafa;"   
				        data-options="iconCls:'ext-icon-clock_red',closable:false,    
				                collapsible:true,minimizable:false,maximizable:false">   
					    <p>你有【<font style='color:red;font-weight:bold' id="sjqdrs">
					    	<input type="text" id="baoqingsx" name="baoqingsx" 
					    	style="border: none;width: 20px;background:none;"></input>
					    	</font>】项报请事项，请及时处理！<a href="javascript:baoqingchuli();">查看或处理</a>
				    	</p>     
					</div> 	        
				</td>
				<td width="50%" valign="top" height="100%">
					<div id="p4" class="easyui-panel" title="证审提醒"     
				        style="width:500px;height:220px;padding:10px;background:#fafafa;"   
				        data-options="iconCls:'ext-icon-sound',closable:false,    
				                collapsible:true,minimizable:false,maximizable:false">   
					    <p>《许可证》即将到期<a onclick="loadSjzstxDetail('querySjjszdqtx')" style="cursor:hand;">
					    	【<font style='color:red;font-weight:bold' id="jsz">0</font>】</a>人，请及时处理！</p>     
					</div> 													
				</td>						
			</tr>
     	</table>	               	
		
	</div>

	<!-- 消息提示框 -->
	<div id="pop" style="display:none;">
		<div id="popHead">
			<a id="popClose" title="关闭">关闭</a>
			<h2>温馨提示</h2>
		</div>
		<div id="popContent">
			<dl>
				<!--<dt id="popTitle"><a href="http://yanue.info/" target="_blank">消息提醒标题参数</a></dt>-->
				<dd id="popIntro">消息提醒内容参数</dd>
			</dl>
			<!-- <p id="popMore"><a href="http://yanue.info/" target="_blank">查看>></a></p> -->
		</div>
	</div>
</body>
</html>