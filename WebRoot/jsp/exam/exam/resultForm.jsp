<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig, com.askj.exam.entity.OtsResultInfo,net.sf.json.JSONObject" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 考试结果信息id
	String resultInfoId = (String)request.getAttribute("resultInfoId");
	// 考试结果信息
	OtsResultInfo resultInfo = (OtsResultInfo) request.getAttribute("resultInfo");
	JSONObject paparInfo = null;
	// 
	if (!"".equals(resultInfo.getPaperdata())) {
		paparInfo = JSONObject.fromObject(resultInfo.getPaperdata());
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>考试结果信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var v_info = <%=paparInfo%>; // 使用的卷子数据   
	v_info = $.parseJSON(v_info);
	$(function() {
		showQusetions();
	});
	// 展示试题
	function showQusetions(){
	console.log(v_info);
		for (var i = 0; i < v_info.length; i++) {
			// 大题类型（及每题分数）
			var paperTypeInfo = "<div name='paperQsnType'><span name='qsnTypeTitle' style='font-size: 15px; color: blue;'>" 
				+ v_info[i].qsnTypeTitle + "</span><span style='font-size: 14px;'>(每题</span><span name='qsnPoint'>" 
				+ v_info[i].qsnPoint + "</span><span style='font-size: 14px;'>分)</span><input name='qsnType' type='hidden' value='"
				+ v_info[i].qsnType + "' /></div>" ;
			var questionInfo = ""; // 试题信息
			// 每类大题类型包含小题
			var paperQsnInfo = v_info[i].qsnInfo;
			for (var j = 0; j < paperQsnInfo.length; j++) {
				// 试题题干内容
				var qsnInfo = paperQsnInfo[j];
				// 试题类型
				var v_type = qsnInfo.qsnInfoType;
				var qsnInfoDesc = qsnInfo.qsnInfoDesc; // 试题描述
				if (v_type == '4') { // 如果试题类型为填空题
					qsnInfoDesc = emptyBlankOption(qsnInfoDesc);
				}
				questionInfo += "<div name='qsnInfoList' style='font-size: 15px; margin-left: 40px;margin-right: 35px;' id='" 
					+ qsnInfo.qsnInfoId + "'>"
					+ "<span style='font-size: 15px; font-weight: bold;'>" + (j+1) + ".</span>"
					+ "<span name='qsnInfoDesc' style='font-size: 14px; font-weight: bold;margin-left: 10px;'>" 
					+ qsnInfoDesc + "</span></br>";
				
				var qsnDataInfo = ""; // 试题内容信息
				// 试题内容数据
				var qsnData = qsnInfo.qsnDataList;
				if (v_type == "1" || v_type == "2" || v_type == "3") {
					var type = "'radio'";
					if (v_type == "1" || v_type == "3") { // 单选或判断
						type = "'radio'";
					} else if (v_type == "2") { // 多选
						type = "'checkbox'";
					}
					for (var k = 0; k < qsnData.length; k++) {
						qsnDataInfo += "<div name='qsnDataList' style='margin-left: 10px;' id='" + qsnData[k].qsnDataId 
							+ "'><span>" + String.fromCharCode(64 + parseInt(k+1)) + ".</span>" 
							+ "<input name='" + qsnInfo.qsnInfoId + "' type=" + type + " value='" 
							+ qsnData[k].qsnDataId + "' />"
							+ "<span>" + qsnData[k].qsnDataOptiondesc + "</span></div>";
					}
				} else {
					for (var k = 0; k < qsnData.length; k++) {
						qsnDataInfo += "<span>" + (k+1) + ".</span><div style='overflow: auto;'>" 
							+ "<textarea class='ckeditor' name='answerArea' id='" + qsnData[k].qsnDataId + "'></textarea></div>";
					}
				}
				questionInfo = questionInfo + qsnDataInfo + "</div>";
			}
			$("#resultInfo").append("<div style='margin-left: 20px;'>" + paperTypeInfo + questionInfo + "</div>");
		}
		var ckeditor = $("textarea");
		for(var i = 0; i < ckeditor.length; i++){
			CKEDITOR.replace(ckeditor.get(i), { height: '40px', width: '930px' });
		}
	}
	// 
	/* function submitExam() {
		var fromData = getSubmitData();
		$.messager.progress();	// 显示进度条
		$.ajax({
			type : "POST",
		   	url : basePath + "exam/result/submitExam",
		   	data : fromData,
		   	traditional : true,
		   	success : function(result){
				$.messager.progress('close');// 隐藏进度条  
				result = eval('(' + result + ')'); 
			 	if (result.code == "0"){
			 		var info = "<span>试卷满分：" + $("#points").val() + "</span></br>"
			 			+ "<span>试卷及格分：" + $("#paperInfoPass").val() + "</span></br>"
			 			+ "<span>本次得分：" + result.score + "</span>";
			 		$.messager.alert('提示', info, 'info', function(){
						 window.returnValue = "ok";
						 window.close(); 
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','提交失败：'+result.msg,'error');
                }
		   }
		}); 
	} */
	// 获取提交的数据
	/* function getSubmitData() {
		
		var submitData = [];
		// 试卷所包含的大题类型
		var paperQsnType = $("div[name='paperQsnType']");
		for (var i = 0; i < paperQsnType.length; i++) {
			// 每类大题的类型
			var qsnType = $("div[name='paperQsnType']").eq(i).find("input[name='qsnType']").val();
			// 每类大题的分数（每一题）
			var qsnPoint = $("div[name='paperQsnType']").eq(i).find("span[name='qsnPoint']")[0].firstChild.data;
			// 每类大题包含的试题数据
			var qsnInfoList = $("div[name='paperQsnType']").eq(i).nextAll("div[name='qsnInfoList']");
			if (qsnType == 1) { // 单选题
				var radioAnswers = getRadioAnswers(qsnInfoList, qsnPoint, qsnType);
				submitData = submitData.concat(radioAnswers);
			} else if (qsnType == 2) { // 多选题
				var checkAnswers = getCheckAnswers(qsnInfoList, qsnPoint, qsnType);
				submitData = submitData.concat(checkAnswers);
			}  else if (qsnType == 3) { // 判断题
				var checkAnswers = getJudjeAnswers(qsnInfoList, qsnPoint, qsnType);
				submitData = submitData.concat(checkAnswers);
			} else if (qsnType == 4 || qsnType == 5) { // 填空题、简答题
				var blankAnswers = getBlankAnswers(qsnInfoList, qsnPoint, qsnType);
				submitData = submitData.concat(blankAnswers);
			} 
		}
		var fomData = {
		};
		return fomData;
	} */
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
		<div region="center" style="overflow: auto;" border="false">
			<form id="fm" method="post" >
				<input id="resultInfoId" type="hidden" value="${resultInfo.resultInfoId}"/>
				<input id="examInfoId" type="hidden" value="${resultInfo.examInfoId}"/>
				<div style="text-align: center; " align="center"><h3>${resultInfo.resultInfoName}</h3></div>
				<span>考试总分：</span>${resultInfo.resultInfoPoints}
				<span>考试得分：</span>${resultInfo.resultInfoScores}
				<span>考试及格分：</span>${resultInfo.resultInfoPass}
				<span>考试时间：</span>${resultInfo.startTime}~${resultInfo.endTime}
				<span>考试总评</span><textarea>${resultInfo.remark}</textarea>
				<div id="resultInfo" style="min-height: 100px;"></div>
			</form>
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="submitResult()" id="btnSave">提交并算分</a>
	        </div>
		</div>
	</div>
</body>
</html>