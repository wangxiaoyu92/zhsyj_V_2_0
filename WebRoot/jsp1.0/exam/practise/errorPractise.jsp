<%@page import="com.zzhdsoft.siweb.entity.sysmanager.Sysoperatelog"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>错题练习</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<style>
	.box{ margin-bottom: 20px; margin-left: 20px;}
	.chose{font-size: 15px; margin-left: 25px;margin-right: 25px; background-color: #fff; 
		border: 1px solid #ccc; padding:20px 30px;margin-top: 10px;
		box-shadow: 0px 2px 3px #B1C6C7;
	}
	.chose_con{ line-height: 20px;margin-left: 10px;}
</style>
<script type="text/javascript">
	var v_type; // 试题类型
	var currQsnIndex = 1; // 当前试题位置
	var qsnInfoList; // 试题列表信息
	var qsnInfo; // 试题信息
	var dataList; // 试题选项信息
	var total; // 试题总数
	var v_result = []; // 答案
	var v_submitResult = []; // 提交答案
	var errorItem; // 错误选项
	var currPage = 1; // 获取试题当前页
	var pageSize = 10; // 每页查询试题数
	var continueFlag = "1"; // 是否继续上次答题 1 继续 0 重新
	var v_answeredQsn = []; // 回答过的试题
	$(function() {
		if (confirm("是否重新开始答题？")) {
			continueFlag = "0";
		}
		queryQuestionInfo();
	});
	// 查询试题信息
	function queryQuestionInfo() {
		var param = { "page" : currPage, "rows" : pageSize, "continueFlag" : continueFlag };
		$.ajax({
			type : "POST",
		   	url : basePath + "exam/practise/queryErrorQuestions",
		   	data : param,
		   	traditional : true,
		   	success : function(result) {
				result = eval('(' + result + ')'); 
				if (result.code == "0"){
					qsnInfoList = result.qsnList;
					if (currQsnIndex % pageSize == 0) {
						v_type = result.qsnList[qsnInfoList.length - 1].info.qsnInfoType;
						qsnInfo = result.qsnList[qsnInfoList.length - 1].info;
						dataList = result.qsnList[qsnInfoList.length - 1].dataList;
						errorItem = result.qsnList[qsnInfoList.length - 1].info.qsnErrorItem;
					} else if (currQsnIndex % pageSize != 0) { // 为了删除错题时，继续跳转到当前位置
						v_type = result.qsnList[currQsnIndex % pageSize - 1].info.qsnInfoType;
						qsnInfo = result.qsnList[currQsnIndex % pageSize - 1].info;
						dataList = result.qsnList[currQsnIndex % pageSize - 1].dataList;
						errorItem = result.qsnList[currQsnIndex % pageSize - 1].info.qsnErrorItem;
					} else {
						v_type = result.qsnList[0].info.qsnInfoType;
						qsnInfo = result.qsnList[0].info;
						dataList = result.qsnList[0].dataList;
						errorItem = result.qsnList[0].info.qsnErrorItem;
					}
					total = result.total;
					showQsnOneByOne(); // 逐题展示试题
              	} else {
              		$.messager.alert('提示','获取试题信息失败：' + result.msg,'error');
                }
		   }
		});
	}
	
	// 逐题展示试题
	function showQsnOneByOne() {
		$("#qsnIndex").html(currQsnIndex + "/" + total);
		$("#errorAnswerInfo").hide(); // 将错误原因隐藏
		v_result = []; // 将答案清空
		$("#qsnAnswerInfo").hide(); // 隐藏答案
		$("#btnNext").show(); // 下一题按钮显示
		$("#btnPre").show();
		$("#qsnInfo").empty(); // 试题内容清空
		$("#qsnAnswerInfo").empty(); // 试题答案清空
		$("#errorAnswerInfo").empty(); // 错误信息清空
		$("#errorId").val(qsnInfo.errorId);
		// 如果该试题为最后一题，隐藏下一题按钮
		if (currQsnIndex == total) {
			$("#btnNext").hide(); // 下一题按钮隐藏
		}
		// 如果该试题为第一题，隐藏上一题按钮
		if (currQsnIndex == 1) {
			$("#btnPre").hide(); // 上一题按钮隐藏
		}
		var questionInfo = ""; // 试题信息
		// 答案解析
		var answerExplainInfo = "<div class='chose_con'><span style='font-size: 15px;'>答案：</span>"; 
		// 试题题干内容
		var qsnInfoDesc = qsnInfo.qsnInfoDesc; // 试题描述
		if (v_type == '4') { // 如果试题类型为填空题
			qsnInfoDesc = emptyBlankOption(qsnInfoDesc);
		}
		questionInfo += "<div name='qsnInfoList' style='font-size: 15px; margin-left: 10px;' id='" 
			+ qsnInfo.qsnInfoId + "'>"
			+ "<span name='qsnInfoDesc' style='font-size: 14px; font-weight: bold;'>" + qsnInfoDesc
			+ "</span><br>";
		// 试题内容数据
		var qsnData = dataList;
		var qsnDataInfo = "<div class='chose'>"; // 试题内容信息
		if (v_type == "1" || v_type == "2" || v_type == "3") {
			var type = "'radio'";
			if (v_type == "1" || v_type == "3") { // 单选或判断
				type = "'radio'";
			} else if (v_type == "2") { // 多选
				type = "'checkbox'";
			}
			for (var k = 0; k < qsnData.length; k++) {
				qsnDataInfo += "<div name='qsnDataList' id='" + qsnData[k].qsnDataId + "'><span class='chose_con'>" 
					+ String.fromCharCode(64 + parseInt(k+1)) + "</span>." 
					+ "<input name='" + qsnInfo.qsnInfoId + "' type=" + type + " value='" 
					+ qsnData[k].qsnDataId + "' />"
					+ "<span class='chose_con'>" + qsnData[k].qsnDataOptiondesc + "</span></div>";
				// 答案解析
				if (qsnData[k].qsnDataIsanswer == 1) {
					answerExplainInfo += String.fromCharCode(64 + parseInt(k+1)) + "&nbsp;&nbsp;&nbsp;";
					v_result.push(qsnData[k].qsnDataId);
				}
			}
		} else {
			for (var k = 0; k < qsnData.length; k++) {
				$("#" + qsnData[k].qsnDataId).remove();
				qsnDataInfo += "<span>" + (k+1) + ".</span><div style='overflow: auto;'>" 
					+ "<textarea name='answerArea' id='" + qsnData[k].qsnDataId + "'></textarea></div>"; // class='ckeditor' 
				answerExplainInfo +=  "<div><span>" + (k+1) + ".</span>&nbsp;" + qsnData[k].qsnDataOptiondesc + "</div>";
				v_result.push(qsnData[k].qsnDataOptiondesc);
			}
			
		}
		questionInfo = questionInfo + qsnDataInfo + "</div></div>";
		answerExplainInfo += "<br><span style='font-size: 15px;'>答案解析：" + qsnInfo.qsnInfoExplain + "</span></div>";
		$("#qsnInfo").append("<div>" + questionInfo + "</div>");
		$("#qsnAnswerInfo").append(answerExplainInfo);
	}
	// 查看上一题 
	function preQusetion () {
		if ((currQsnIndex % pageSize == 1) && (currPage > 1)) {
			--currPage;
			--currQsnIndex;
			queryQuestionInfo();
		} else {
			--currQsnIndex;
			if (qsnInfoList[(currQsnIndex % 10) - 1]) {
				v_type = qsnInfoList[(currQsnIndex % 10) - 1].info.qsnInfoType;
				qsnInfo = qsnInfoList[(currQsnIndex % 10) - 1].info;
				dataList = qsnInfoList[(currQsnIndex % 10) - 1].dataList;
				errorItem = qsnInfoList[(currQsnIndex % 10) - 1].info.qsnErrorItem;
			}
			showQsnOneByOne();
		}
	}
	// 查看下一题
	function nextQusetion () {
		var maxQsnNo = currPage * pageSize; // 当前最大试题数
		if (currQsnIndex < maxQsnNo) {
			if (qsnInfoList[currQsnIndex % pageSize]) {
				v_type = qsnInfoList[currQsnIndex % pageSize].info.qsnInfoType;
				qsnInfo = qsnInfoList[currQsnIndex % pageSize].info;
				dataList = qsnInfoList[currQsnIndex % pageSize].dataList;
				errorItem = qsnInfoList[currQsnIndex % pageSize].info.qsnErrorItem;
			}
			if (currQsnIndex < total) {
				++currQsnIndex;
				showQsnOneByOne();
			} else {
				$.messager.alert('提示','已是最后一题！', 'info');
			}
			
		} else {
			++currPage;
			if (currQsnIndex < total) {
				++currQsnIndex;
			}
			queryQuestionInfo();
		}
	}
	// 提交试题
	function submitQsn() {
		v_answeredQsn.push(qsnInfo.errorId);
		if (v_type == 4 || v_type == 5) {
			$.messager.alert('提示','请自行对比答案', 'info');
			return;
		}
		var flag = judgeCurrQsnRight();
		if (!flag) {
			if (confirm("回答错误，是否放入错题库？")) {
				$.ajax({
					type : "POST",
				   	url : basePath + "exam/practise/saveErrorQuestion",
				   	data : { "qsnInfoId" : qsnInfo.qsnInfoId, "qsnErrorItem" : v_submitResult },
				   	traditional : true,
				   	success : function(result){
						result = eval('(' + result + ')'); 
						if (result.code == "0"){
							$.messager.alert('提示','保存成功！', 'info');
		              	}
				   }
				});
			}
		} else {
			nextQusetion();
		}
	}
	// 判断当前试题是否正确
	function judgeCurrQsnRight() {
		v_submitResult = []; // 将所提交答案清空
		var flag = false;
		if (v_type == 1) { // 单选题
			flag = judgeRadioAnswer();
		} else if (v_type == 2) { // 多选题
			flag = judgeCheckAnswer();
		}  else if (v_type == 3) { // 判断题
			flag = judgeJudjeAnswer();
		}
		return flag;
	}
	// 判断当前单选题是否正确
	function judgeRadioAnswer() {
		// 获取选中的选项id
		var qsnDataId = $("input:radio[name='" + qsnInfo.qsnInfoId + "']:checked").val();
		v_submitResult.push(qsnDataId);
		if (qsnDataId == v_result[0]) {
			return true;
		} else {
			return false;
		}
	}
	// 判断当前判断题是否正确
	function judgeJudjeAnswer() {
		// 获取选中的选项id
		var qsnDataId = $("input:radio[name='" + qsnInfo.qsnInfoId + "']:checked").val();
		if (qsnDataId == v_result[0]) {
			return true;
		} else {
			return false;
		}
	}
	// 判断当前多选题是否正确
	function judgeCheckAnswer() {
		var flag = false;
		// 获取选中的选项id
		$("input:checkbox[name='" + qsnInfo.qsnInfoId + "']:checked").each(function(){ 
			v_submitResult.push($(this).val());
		});
		if (v_submitResult.length > 0 && v_submitResult.length == v_result.length) {
			for (var i = 0; i < v_submitResult.length; i++) {
				if (v_submitResult[i] == v_result[i]) {
					flag = true;
				} else {
					return false;
				}
			}
		}
		return flag;
	}
	// 查看答案
	function showAnswer () {
		v_answeredQsn.push(qsnInfo.errorId);
		$("#qsnAnswerInfo").show();
	}
	// 移出错题库
	function deleteOutOfError () {
		var param = { "errorId" : $("#errorId").val() };
		$.ajax({
			type : "POST",
		   	url : basePath + "exam/practise/deleteOutOfError",
		   	data : param,
		   	success : function(result) {
				result = eval('(' + result + ')'); 
				if (result.code == "0"){
					$.messager.alert('提示','操作成功！', 'info');
					queryQuestionInfo();
              	} else {
              		$.messager.alert('提示','操作失败' + result.msg,'error');
                }
		   }
		});
	}
	// 查看错误原因
	function showErrorItem() {
		if (errorItem) {
			var errorItemArr = errorItem.split(",");
			var errInfo = "正确答案：";
			for (var i = 0; i < v_result.length; i++) {
				errInfo += $("#" + v_result[i]).find("span")[0].firstChild.data + "&nbsp;&nbsp;";
			}
			errInfo += "<br/>错误答案：";
			for (var i = 0; i < errorItemArr.length; i++) {
				errInfo += $("#" + errorItemArr[i]).find("span")[0].firstChild.data + "&nbsp;&nbsp;";
			}
			$("#errorAnswerInfo").append(errInfo);
			$("#errorAnswerInfo").show();
		}
		
	}
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
	// 刷新页面，离开页面触发函数
	function flushOrLeave() {
		$.ajax({
			type : "POST",
		   	url : basePath + "exam/practise/saveAnsweredQuestion",
		   	data : { "qsnInfoId" : v_answeredQsn, "answerType" : "3" },
		   	traditional : true,
		   	success : function(result){
				console.log("记录回答试题成功");
		   	}
		});
	}
</script>
</head>
<body onunload="flushOrLeave()">
	<div class="easyui-layout" fit="true">    
		<div region="center" style="overflow: auto;" border="false">
			<input type="hidden" id="errorId" name="errorId">
			<div align="right">
				<span style="background-color:yellow; width: 100%; height: 20px; display: block;">
					<span style="font-size: 16px; padding-right:5px; padding-left:30px; ">试题：</span>
					<span style="color: blue;padding-left:20px;" id="qsnIndex"></span>
				</span>
			</div>
			<div class="box">
				<div id="qsnInfo"></div>
			</div>
			<div id="qsnAnswerInfo" class="chose" style="display: none;">
	        </div>
	        <div id="errorAnswerInfo" class="chose" style="display: none;">
	        </div>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="preQusetion()" id="btnPre">上一题</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="submitQsn()" id="btnSave">提交答案</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="showErrorItem()" id="btnSave">查看错误原因</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="deleteOutOfError()" id="btnSave">移出错题库</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="showAnswer()" id="btnShow">查看答案</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="nextQusetion()" id="btnNext">下一题</a>
	        </div>
		</div>
	</div>
</body>
</html>