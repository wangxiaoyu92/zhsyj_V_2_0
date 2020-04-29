<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig, net.sf.json.JSONArray" %>
<%@ page import="java.util.List, com.askj.exam.entity.OtsQuestionsInfo" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 试题信息
	OtsQuestionsInfo v_info = (OtsQuestionsInfo)request.getAttribute("qsnInfo");
	// 试题选项信息
	JSONArray dataList = JSONArray.fromObject(request.getAttribute("dataList"));
%>
<!DOCTYPE html>
<html>
<head>
<title>试题预览</title>
<style>
	.chose{font-size: 15px; margin-left: 25px;margin-right: 25px; background-color: #fff; 
		border: 1px solid #ccc; padding:20px 30px;margin-top: 10px;
		box-shadow: 0px 2px 3px #B1C6C7;
	}
	.title{ font-size: 18px; font-weight:bold; color: #000;}
	.chose_con{ line-height: 20px;margin-left: 10px;}
</style>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var v_type = '<%=v_info.getQsnInfoType()%>';
	var v_dataList = <%=dataList%>;
	$(function() {
		if (v_type == '1' || v_type == '2' || v_type == '3') {
			var type = 'radio';
			if (v_type == '1' || v_type == '3') { // 单选或判断
				type = 'radio';
			} else if (v_type == '2') { // 多选
				type = 'checkbox';
			}
			var toAppendInfo = ""; // 要拼接的内容
			for (var i = 0; i < v_dataList.length; i++) {
				if (v_dataList[i].qsnDataIsanswer == '1') {
					toAppendInfo += "<span>" + String.fromCharCode(64 + parseInt(i+1)) + ".</span>" 
						+ "<span><input name='isanswer' type=" + type + " checked='checked' /></span>"
						+ "<span class='chose_con'>" + v_dataList[i].qsnDataOptiondesc + "</span></br>";
				} else {
					toAppendInfo += "<span>" + String.fromCharCode(64 + parseInt(i+1)) + ".</span>" 
						+ "<span><input name='isanswer' type=" + type + " /></span>"
						+ "<span class='chose_con'>" + v_dataList[i].qsnDataOptiondesc + "</span></br>";
				}
			}
			$("#optionsWarpper").append("<div class='chose'>" + toAppendInfo + "</div>");
		} else {
			if (v_type == '4') { // 填空
				var qsnInfoDesc = $("#qsnInfoDesc").html();
				emptyBlankOption(qsnInfoDesc);
			}
			for (var i = 0; i < v_dataList.length; i++) {
				$("#optionsWarpper").append("<div class='chose'><span>" + parseInt(i+1) + ".</span>&nbsp;" 
					+ "<span class='chose_con'>" + v_dataList[i].qsnDataOptiondesc + "</span></div></br>");
			}
		}
	});
	// 清空填空题填空框
	function emptyBlankOption(v_data) {
		var qsnInfoDesc = "";
		var index = v_data.indexOf("<input");
		while (index >= 0) {
			qsnInfoDesc += v_data.substring(0, index) + "(&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)";
			v_data = v_data.substring(index);
			index = v_data.indexOf(">");
			v_data = v_data.substring(index + 1);
			index = v_data.indexOf("<input");
		}
		qsnInfoDesc += v_data;
		$("#qsnInfoDesc").html(qsnInfoDesc);
	}
	
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = new Object();      
		s.type = "ok";
		window.returnValue = s;   
		window.close();    
	}
</script>
</head>
<body>
	<div region="center" border="false">
		<input id="qsnInfoId" type="hidden" value="${qsnInfo.qsnInfoId}"/>
		<input id="qsnInfoType" type="hidden" value="${qsnInfo.qsnInfoType}"/>
		<div class="box">
			<span style="font-weight: bold; font-size: 15px;margin-left: 20px;margin-right: 20px;">
				${qsnInfo.qsnInfoDesc}
			</span>
			<div id="optionsWarpper"></div>
		</div>
		<br>
		<span style="font-weight: bold; font-size: 12px;margin-left: 20px;margin-right: 20px;">答案解析：</span>
		<div class="chose">
			<span class='chose_con'>${qsnInfo.qsnInfoExplain}</span>
		</div>
 		<br>
		<span style="font-weight: bold; font-size: 15px;margin-left: 20px;margin-right: 20px;">备注：</span>
		<div class="chose">
			<span class='chose_con'>${qsnInfo.aae013}</span>
		</div>
		<br/>
	</div>
	<!-- <div style="text-align:center">
      	<a href="javascript:void(0)" class="easyui-linkbutton"
		iconCls="icon-undo" onclick="closeAndRefreshWindow()" id="btnUndo">关闭</a>
	</div> -->
</body>
</html>