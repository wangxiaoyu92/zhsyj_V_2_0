<%@page import="com.zzhdsoft.siweb.entity.sysmanager.Sysoperatelog"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,java.util.List" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 试卷内容信息
	List paperInfoList = (List)request.getAttribute("paperInfoList");
%>
<!DOCTYPE html>
<html>
<head>
<title>试卷预览</title>
<style>
	.box{ margin-bottom: 20px; margin-left: 20px;}
	.chose{font-size: 15px; margin-left: 40px; margin-right: 35px; background-color: #fff; 
		border: 1px solid #ccc; padding:20px 30px;
		box-shadow: 0px 2px 3px #B1C6C7;
	}
	.title{ font-size: 18px; font-weight:bold; color: #000;}
	.chose_con{ line-height: 20px;margin-left: 10px;}
	.data_con{ margin-left: 20px;}
	.explain{ font-weight: bold;}
</style>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var v_info = <%=paperInfoList%>;
	$(function() {
		for (var i = 0; i < v_info.length; i++) {
			// 大题类型（及每题分数）
			var paperTypeInfo = "<div class='title'><span>" + v_info[i].paperQsnType.qsnTypeTitle + "</span>"
				+ "<span>(每题" + v_info[i].paperQsnType.qsnPoint + "分)</span></div>" ;
			var questionInfo = ""; // 试题信息
			// 每类大题包含内容
			var paperQsnInfo = v_info[i].qsnInfoList;
			for (var j = 0; j < paperQsnInfo.length; j++) {
				// 试题题干内容
				var qsnInfo = paperQsnInfo[j].qsnInfo;
				// 试题类型
				var v_type = qsnInfo.qsnInfoType;
				var qsnInfoDesc = qsnInfo.qsnInfoDesc; // 试题描述
				if (v_type == '4') { // 如果试题类型为填空题
					qsnInfoDesc = emptyBlankOption(qsnInfoDesc);
				}
				questionInfo += "<div class='chose'><span>" + (j+1) + ".</span>"
					+ "<span class='chose_con'>" + qsnInfoDesc + "</span></br>";
				
				var qsnDataInfo = ""; // 试题内容信息
				// 试题内容数据
				var qsnData = paperQsnInfo[j].qsnDataList;
				if (v_type == "1" || v_type == "2" || v_type == "3") {
					var type = "'radio'";
					if (v_type == "1" || v_type == "3") { // 单选或判断
						type = "'radio'";
					} else if (v_type == "2") { // 多选
						type = "'checkbox'";
					}
					for (var k = 0; k < qsnData.length; k++) {
						if (qsnData[k].qsnDataIsanswer == "1") {
							qsnDataInfo += "<span class='data_con'>" + String.fromCharCode(64 + parseInt(k+1)) + ".</span>" 
								+ "<span><input name='" + qsnInfo.qsnInfoId + "' type=" 
								+ type + " checked='checked' /></span>"
								+ "<span>" + qsnData[k].qsnDataOptiondesc + "</span></br>";
						} else {
							qsnDataInfo += "<span class='data_con'>" + String.fromCharCode(64 + parseInt(k+1)) + ".</span>" 
								+ "<span><input name='" + qsnInfo.qsnInfoId + "' type=" + type + " /></span>"
								+ "<span>" + qsnData[k].qsnDataOptiondesc + "</span></br>";
						}
					}
				} else {
					for (var k = 0; k < qsnData.length; k++) {
						qsnDataInfo += "<span class='data_con'>" + (k+1) + ".</span>&nbsp;" 
							+ "<span>" + qsnData[k].qsnDataOptiondesc + "</span></br>";
					}
				}
				questionInfo = questionInfo + qsnDataInfo + "<span class='explain'>答案解析：</span>" 
								+"<span>" + qsnInfo.qsnInfoExplain + "</span></div></br>";
			}
			$("#paperInfo").append("<div class='box'>" + paperTypeInfo + questionInfo + "</div>");
		}
	});
	// 清空填空题填空框内容
	function emptyBlankOption(v_data) {
		var qsnInfoDesc = "";
		var index = v_data.indexOf("<input");
		while (index >= 0) {
			qsnInfoDesc += v_data.substring(0, index) + "(&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)";
			v_data = v_data.substring(index);
			index = v_data.indexOf("/>");
			v_data = v_data.substring(index + 2);
			index = v_data.indexOf("<input");
		}
		qsnInfoDesc += v_data;
		return qsnInfoDesc;
	}
</script>
</head>
<body>
	<div region="center" style="left: 20px;" border="false">
		<input id="paperInfoId" type="hidden" value="${paperInfo.paperInfoId}"/>
		<input id="paperInfoState" type="hidden" value="${paperInfo.paperInfoState}"/>
		<h3 align="center">${paperInfo.paperInfoName}</h3>
		<div id="paperInfo" style="min-height: 100px;"></div>
 		<br/>
		<span style="font-weight: bold; font-size: 15px; margin-left: 20px;">备注：</span>${paperInfo.aae013}
		<br/>
	</div>
</body>
</html>