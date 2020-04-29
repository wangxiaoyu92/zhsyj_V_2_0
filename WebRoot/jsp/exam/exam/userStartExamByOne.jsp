<%@page import="com.zzhdsoft.siweb.entity.sysmanager.Sysoperatelog"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig, net.sf.json.JSONObject, com.askj.exam.entity.OtsExamsMate" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 试卷内容信息
	JSONObject paperInfo = (JSONObject)request.getAttribute("paperInfo");
	// 考试功能信息
	OtsExamsMate oem = (OtsExamsMate)request.getAttribute("examMate");
%>
<!DOCTYPE html>
<html>
<head>
<title>用户考试</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var examTimer; // 考试计时器
	var v_info = <%=paperInfo%>.paperQsnType; // 试卷大题类型
	var examMode = <%=oem%>.examMode; // 考试方式,1=整卷,2=逐题
	var examModePrev = <%=oem%>.examModePrev; // 逐题模式，是否允许查看上一题0=不允许，1=允许
	var examModeAnswer = <%=oem%>.examModeAnswer; // 逐题查看答案（0-不允许，1-允许）
	var currQsnTypeIndex = 0; // 当前的大题类型所处试卷位置
	var currQsnIndex = 0; // 当前小题所处大题试题位置
	var duration = <%=oem%>.duration; // 考试限时，0等于不限时
	var typeNum = []; // 初始化试卷每类大题所包含的试题数组
	var submitAnswers = {}; // 提交的答案
	var qsnInfoIdArr = []; // 所有的试题id集合
	var cardFlag = true; // 答题卡选项是否打开标记（默认打开）
	$(function() {
		$("#submitDiv").hide(); // 提交按钮隐藏
		if (examModeAnswer == 0) {
			$("#btnShow").hide(); // 查看答案按钮隐藏
		}
		for (var i = 0; i < v_info.length; i++) {
			 typeNum[i] = v_info[i].qsnInfo.length;
		}
		showQsnOneByOne(); // 逐题展示试题
		// 考试计时
		if (duration == 0) { // 当考试不限时的时候, 考试结束时间为交卷时间
			var currData = new Date(); // 当前时间
			var endTime = new Date(<%=oem%>.endTime.substring(0, 19).replace(/-/g,"/")); // 考试结束时间
			var date = (endTime.getTime() - currData.getTime()) / 1000; // 两日期相差的秒数
			examTimer(date);
		} else {
			examTimer(duration * 60); // 因为是限时分钟
		}
		getPaperQsnId(); // 
		createAnswerCard(); // 生成答题卡
	});
	// 获取试卷所有的试题id(为提交答案准备)
	function getPaperQsnId() {
		for (var i = 0; i < v_info.length; i++) {
			// 每类大题类型包含小题
			var paperQsnInfo = v_info[i].qsnInfo;
			for (var j = 0; j < paperQsnInfo.length; j++) {
				// 试题题干内容
				var qsnInfo = paperQsnInfo[j];
				qsnInfoIdArr.push(qsnInfo.qsnInfoId); 
			}
		}
	}
	// 考试计时器
	function examTimer(times){
	    examTimer = window.setInterval(function(){
		    var day=0, hour=0,  minute=0, second=0;//时间默认值        
		    if(times > 0){
		        day = Math.floor(times / (60 * 60 * 24)); // 天
		        hour = Math.floor(times / (60 * 60)) - (day * 24); // 小时
		        minute = Math.floor(times / 60) - (day * 24 * 60) - (hour * 60); // 分钟
		        second = Math.floor(times) - (day * 24 * 60 * 60) - (hour * 60 * 60) - (minute * 60); // 秒
		    }
		    if (hour <= 9) {
		    	hour = '0' + hour;
		    }
		    if (minute <= 9) {
		    	minute = '0' + minute;
		    }
		    if (second <= 9) {
		    	second = '0' + second;
	    	}
	    	$("#examTime").html(day + "天" + hour + ":" + minute + ":" + second);
		    if (times == 0) {
		    	 window.clearInterval(examTimer); // 清除计时器
		    	 $.messager.alert('提示', "考试时间结束！", 'info', function(){
		    	 	submitExam();
					window.returnValue = "ok";
					window.close(); 
        		});
		    }
		    times--;
	    }, 1000);
	}
	// 逐题展示试题
	function showQsnOneByOne() {
		$("#submitDiv").hide();
		if (examModePrev == 0) {
			$("#btnPre").hide(); // 查看上一题按钮隐藏
			$("#answerCardTabs").hide(); // 答题卡隐藏
			$("#showOrCloseAnswerCard").hide(); // 答题卡隐藏
		}
		$("#btnNext").show(); // 下一题按钮显示
		$("#paperInfo").empty();
		// 如果该试题为最后一题，隐藏下一题按钮
		if ((currQsnTypeIndex + 1 == typeNum.length) && (currQsnIndex + 1 == typeNum[currQsnTypeIndex])) {
			$("#btnNext").hide(); // 下一题按钮隐藏
			$("#submitDiv").show(); // 提交按钮显示
		}
		// 如果该试题为第一题，隐藏上一题按钮
		if ((currQsnTypeIndex == 0) && (currQsnIndex == 0)) {
			$("#btnPre").hide(); // 上一题按钮隐藏
		}
		// 逐题展示试题
		// 大题类型（及每题分数）
		var paperTypeInfo = "<div name='paperQsnType'><span name='qsnTypeTitle' style='font-size: 15px; color: blue;'>" 
			+ v_info[currQsnTypeIndex].qsnTypeTitle + "</span>"
			+ "<span style='font-size: 14px;'>(每题</span><span name='qsnPoint'>" 
			+ v_info[currQsnTypeIndex].qsnPoint + "</span><span style='font-size: 14px;'>分)</span>"
			+ "<input name='qsnType' type='hidden' value='" + v_info[currQsnTypeIndex].qsnType + "' /></div>" ;
		var questionInfo = ""; // 试题信息
		// 答案解析
		var answerExplainInfo = "<div id='answerExplainDiv' style='display: none;'><span style='font-size: 15px;'>答案：</span>"; 
		// 每类大题所包含的试题数
		var qsnNum = typeNum[currQsnTypeIndex];
		// 试题题干内容
		var qsnInfo = v_info[currQsnTypeIndex].qsnInfo[currQsnIndex];
		// 试题类型
		var v_type = qsnInfo.qsnInfoType;
		var qsnInfoDesc = qsnInfo.qsnInfoDesc; // 试题描述
		if (v_type == '4') { // 如果试题类型为填空题
			qsnInfoDesc = emptyBlankOption(qsnInfoDesc);
		}
		questionInfo += "<div name='qsnInfoList' style='font-size: 15px; margin-left: 50px;' id='" 
			+ qsnInfo.qsnInfoId + "'>"
			+ "<span style='font-size: 15px; font-weight: bold;'>" + (currQsnIndex + 1) + ".</span>"
			+ "<span name='qsnInfoDesc' style='font-size: 14px; font-weight: bold;'>" + qsnInfoDesc
			+ "</span><input type='button' onclick='signQsn()' value='标记' style='width:40px;color: white;" 
			+ "background-color:#0066CC; margin-right: 50px;float:right;' /><br>";
		// 试题内容数据
		var qsnData = qsnInfo.qsnDataList;
		var qsnDataInfo = ""; // 试题内容信息
		var answers = []; // 填空或者简答题的答案
		if (v_type == "1" || v_type == "2" || v_type == "3") {
			var qsnDataId = "";
			var type = "'radio'";
			if (v_type == "1" || v_type == "3") { // 单选或判断
				type = "'radio'";
				// 判断之前是否已作答
				if (submitAnswers[qsnInfo.qsnInfoId]) {
					qsnDataId = eval("("+submitAnswers[qsnInfo.qsnInfoId]+")").qsnDataId.toString();
				}
			} else if (v_type == "2") { // 多选
				type = "'checkbox'";
				// 判断之前是否已作答
				if (submitAnswers[qsnInfo.qsnInfoId]) {
					qsnDataId = eval("("+submitAnswers[qsnInfo.qsnInfoId]+")").qsnDataIds.toString();
				}
			}
			for (var k = 0; k < qsnData.length; k++) {
				if (qsnDataId.indexOf(qsnData[k].qsnDataId) > -1) {
					qsnDataInfo += "<div name='qsnDataList' id='" + qsnData[k].qsnDataId + "'><span>" 
						+ String.fromCharCode(64 + parseInt(k+1)) + ".</span>" 
						+ "<input name='" + qsnInfo.qsnInfoId + "' type=" + type + " value='" 
						+ qsnData[k].qsnDataId + "' checked='checked' />"
						+ "<span>" + qsnData[k].qsnDataOptiondesc + "</span></div>";
				} else {
					qsnDataInfo += "<div name='qsnDataList' id='" + qsnData[k].qsnDataId + "'><span>" 
						+ String.fromCharCode(64 + parseInt(k+1)) + ".</span>" 
						+ "<input name='" + qsnInfo.qsnInfoId + "' type=" + type + " value='" 
						+ qsnData[k].qsnDataId + "' />"
						+ "<span>" + qsnData[k].qsnDataOptiondesc + "</span></div>";
				}
				// 答案解析
				if (qsnData[k].qsnDataIsanswer == 1) {
					answerExplainInfo += String.fromCharCode(64 + parseInt(k+1)) + "&nbsp;&nbsp;&nbsp;";
				}
			}
		} else {
			for (var k = 0; k < qsnData.length; k++) {
				// 判断之前是否已作答
				if (submitAnswers[qsnInfo.qsnInfoId]) {
					answers = eval("("+submitAnswers[qsnInfo.qsnInfoId]+")").answers;
				}
				$("#" + qsnData[k].qsnDataId).remove();
				qsnDataInfo += "<span>" + (k+1) + ".</span><div style='overflow: auto;'>" 
					+ "<textarea class='ckeditor' name='answerArea' id='" + qsnData[k].qsnDataId + "'></textarea></div>";
				answerExplainInfo +=  "<div><span>" + (k+1) + ".</span>&nbsp;" + qsnData[k].qsnDataOptiondesc + "</div>";
			}
			
		}
		questionInfo = questionInfo + qsnDataInfo + "</div>";
		answerExplainInfo += "<br><span style='font-size: 15px;'>答案解析：" + qsnInfo.qsnInfoExplain + "</span></div>";
		$("#paperInfo").append("<div style='margin-left: 20px; min-height: 500px;'>" 
			+ paperTypeInfo + questionInfo + answerExplainInfo + "</div>");
		var ckeditor = $("textarea");
		for(var i = 0; i < ckeditor.length; i++){
			if (CKEDITOR.instances[ckeditor.get(i).id]) {
		        CKEDITOR.remove(CKEDITOR.instances[ckeditor.get(i).id]);
		    }
			CKEDITOR.replace(ckeditor.get(i).id, { height: '40px', width: '930px' }); 
		}
		if (answers.length > 0) {
			for (var i = 0; i < answers.length; i++) {
				CKEDITOR.instances[answers[i].qsnDataId].setData(answers[i].answer);
			}
		}
	}
	// 查看上一题 
	function preQusetion () {
		// 在查看上一题前，对改题进行答题卡标记
		var qsnButId = "qsnBtn" + currQsnTypeIndex + "-" + currQsnIndex;
		// 在查看上一题之前，记录该题答案
		var flag = getCurrQsnData();
		if (flag) {
			$("#" + qsnButId).css("background-color", "#28FF28");
		} else {
			$("#" + qsnButId).css("background-color", "yellow");
		}
		// 每类大题所包含的试题数
		var qsnNum = typeNum[currQsnTypeIndex];
		// 如果当前试题所在大题位置小于该大题试题数
		if (currQsnIndex > 0) {
			currQsnIndex--;
		} else if (currQsnTypeIndex > 0) {
			currQsnTypeIndex--;
			currQsnIndex = typeNum[currQsnTypeIndex] - 1;
		}  
		showQsnOneByOne();
		$("#answerCardTabs").tabs('select', currQsnTypeIndex); // 默认选中大题选项
	}
	// 查看下一题
	function nextQusetion () {
		// 在查看上一题前，对改题进行答题卡标记
		var qsnButId = "qsnBtn" + currQsnTypeIndex + "-" + currQsnIndex;
		// 在查看上一题之前，记录该题答案
		var flag = getCurrQsnData();
		if (flag) {
			$("#" + qsnButId).css("background-color", "#28FF28");
		} else {
			$("#" + qsnButId).css("background-color", "yellow");
		}
		// 每类大题所包含的试题数
		var qsnNum = typeNum[currQsnTypeIndex];
		// 如果当前试题所在大题位置小于该大题试题数(数组下标从0开始，所以剪1)
		if (qsnNum - 1 > currQsnIndex) {
			currQsnIndex++;
		} else if (currQsnTypeIndex < typeNum.length - 1) { // 如果当前大题所处试卷位置小于大题类型数
			currQsnTypeIndex++;
			currQsnIndex = 0;
		}  
		showQsnOneByOne();
		$("#answerCardTabs").tabs('select', currQsnTypeIndex); // 默认选中大题选项
	}
	// 提交试卷
	function submitExam() {
		// 在提交这一题之前，记录该题答案
		getCurrQsnData();
		var fromData = getFormData();
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
	}
	// 获取要提交的表单数据
	function getFormData(){
		var formData = [];
		for (var i = 0; i < qsnInfoIdArr.length; i++) {
			formData.push(submitAnswers[qsnInfoIdArr[i]]);
		}
		var fomData = {
			paperInfoId : $("#paperInfoId").val(), // 试卷id
			paperInfoPass : $("#paperInfoPass").val(), // 试卷及格分数
			points : $("#points").val(), // 试卷总分
			examsInfoId : $("#examsInfoId").val(), // 对应考试id
			submitData : "[" + formData + "]", // 提交的试卷答案
			paperInfoData : JSON.stringify(<%=paperInfo%>), // 试卷内容
			examsName : <%=oem%>.examsName, // 考试名称
			resultMateId : $("#resultMateId").val() // 用户考试信息表id
		};
		return fomData;
	}
	// 获取当前试题提交的答案
	function getCurrQsnData() {
		var flag = false;
		// 当前试题大题类型
		var qsnType = $("div[name='paperQsnType']").eq(0).find("input[name='qsnType']").val();
		// 每类大题的分数（每一题）
		var qsnPoint = $("div[name='paperQsnType']").eq(0).find("span[name='qsnPoint']")[0].firstChild.data;
		// 每类大题包含的试题数据
		var qsnInfoList = $("div[name='paperQsnType']").eq(0).nextAll("div[name='qsnInfoList']");
		if (qsnType == 1) { // 单选题
			flag = getRadioAnswers(qsnInfoList, qsnPoint, qsnType);
		} else if (qsnType == 2) { // 多选题
			flag = getCheckAnswers(qsnInfoList, qsnPoint, qsnType);
		}  else if (qsnType == 3) { // 判断题
			flag = getJudjeAnswers(qsnInfoList, qsnPoint, qsnType);
		} else if (qsnType == 4 || qsnType == 5) { // 填空题、简答题
			flag = getBlankAnswers(qsnInfoList, qsnPoint, qsnType);
		} 
		return flag;
	}
	// 获取单选题选择结果(返回是为了确定该题是否已作答)
	function getRadioAnswers(qsnInfoList, qsnPoint, qsnType) {
		// 获取每道题的试题id
		var qsnInfoId = qsnInfoList.eq(0).attr("id");
		// 获取选中的选项id
		var qsnDataId = $("input:radio[name='" + qsnInfoId + "']:checked").val();
		var radioAnswers = {
			qsnInfoId : qsnInfoId,
			qsnDataId : qsnDataId ? qsnDataId : "",
			qsnPoint : qsnPoint,
			qsnType : qsnType
		};
		submitAnswers[qsnInfoId] = $.toJSON(radioAnswers);
		if (qsnDataId) {
			return true;
		} else {
			return false;
		}
	}
	// 获取判断题选择结果(返回是为了确定该题是否已作答)
	function getJudjeAnswers(qsnInfoList, qsnPoint, qsnType) {
		// 获取每道题的试题id
		var qsnInfoId = qsnInfoList.eq(0).attr("id");
		// 获取选中的选项id
		var qsnDataId = $("input:radio[name='" + qsnInfoId + "']:checked").val();
		var judjeAnswers = {
			qsnInfoId : qsnInfoId,
			qsnDataId : qsnDataId ? qsnDataId : "",
			qsnPoint : qsnPoint,
			qsnType : qsnType
		};
		submitAnswers[qsnInfoId] = $.toJSON(judjeAnswers);
		if (qsnDataId) {
			return true;
		} else {
			return false;
		}
	}
	// 获取多选题选择结果(返回是为了确定该题是否已作答)
	function getCheckAnswers(qsnInfoList, qsnPoint, qsnType) {
		// 获取每道题的试题id
		var qsnInfoId = qsnInfoList.eq(0).attr("id");
		// 获取选中的选项id
		var qsnDataIds = [];
		$("input:checkbox[name='" + qsnInfoId + "']:checked").each(function(){ 
			qsnDataIds.push({qsnDataId : $(this).val()}); 
		});
		var checkAnswers = {
			qsnInfoId : qsnInfoId,
			qsnDataIds : qsnDataIds,
			qsnPoint : qsnPoint, 
			qsnType : qsnType
		}; 
		submitAnswers[qsnInfoId] = $.toJSON(checkAnswers);
		if (qsnDataIds.length > 0) {
			return true;
		} else {
			return false;
		}
	}
	// 获取填空题（简答题）回答结果 (返回是为了确定该题是否已作答)
	function getBlankAnswers(qsnInfoList, qsnPoint, qsnType) {
		var flag = false;
		var blankAnswersArr = [];
		// 获取每道题的试题id
		var qsnInfoId = qsnInfoList.eq(0).attr("id");
		var answers = [];
		var answersArr = qsnInfoList.eq(0).find("textarea[name='answerArea']");
		for (var j = 0; j < answersArr.length; j++) {
			var qsnDataId = answersArr.eq(j).attr("id");
			var qsnDataVal = CKEDITOR.instances[answersArr.eq(j).attr("id")].getData();
			if (qsnDataVal) {
				flag = true;
			}
			answers.push({qsnDataId : qsnDataId, answer : qsnDataVal});
		}
		var blankAnswers = {
			qsnInfoId : qsnInfoId,
			answers : answers,
			qsnPoint : qsnPoint,
			qsnType : qsnType
		};
		submitAnswers[qsnInfoId] = $.toJSON(blankAnswers);
		return flag;
	}
	// 查看答案
	function showAnswer () {
		$("#answerExplainDiv").show();
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
	// 打开或者关闭答题卡
	function showOrCloseAnswerCard() {
		// 如果为打开状态，点击后关闭
		if (cardFlag) {
			$("#showOrCloseAnswerCard").css("background-color", "#009393"); 
			$("#answerCardTabs").hide();
			cardFlag = false;
		} else {
			$("#showOrCloseAnswerCard").css("background-color", "highlight"); 
			$("#answerCardTabs").show();
			cardFlag = true;
		}
	}
	// 生成答题卡
	function createAnswerCard() {
		for (var i = 0; i < v_info.length; i++) {  
			var curQsnType = v_info[i]; // 当前的试题类型
			var qsninfos = curQsnType.qsnInfo; // 当前试题类型包含多少试题
			var qsnCard = ""; // 试题选项
			for (var j = 0; j < qsninfos.length; j++) { 
				qsnCard += "<input type='button' onclick='turnQsn(" + i + "," + j + ")' value='"+ (j + 1) 
					+ "' style='width:30px; margin-right: 10px;' id='qsnBtn" + i + "-" + j + "' />";
			} 
			$("#answerCardTabs").tabs("add", {
				title : curQsnType.qsnTypeTitle,
	 			content : qsnCard
			});
		}
		$("#answerCardTabs").tabs('select', 0); // 默认选中第一项
	}
	// 跳转试题
	function turnQsn(qsnTypeIndex, qsnIndex) {
		// 在跳转试题前，对该题进行答题卡标记
		var qsnButId = "qsnBtn" + currQsnTypeIndex + "-" + currQsnIndex;
		// 查看该题是否已作答
		var flag = getCurrQsnData();
		if (flag) {
			$("#" + qsnButId).css("background-color", "#28FF28");
		} else {
			$("#" + qsnButId).css("background-color", "yellow");
		}
		currQsnTypeIndex = qsnTypeIndex;
		currQsnIndex = qsnIndex;
		showQsnOneByOne();
	}
	// 标记试题
	function signQsn() {
		var qsnButId = "qsnBtn" + currQsnTypeIndex + "-" + currQsnIndex;
		$("#" + qsnButId).css("background-color", "yellow");
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">    
		<div region="center" style="overflow: auto;" border="false">
			<div align="right">
				<span style="background-color:yellow; width: 100%; height: 20px; display: block;">
					<span style="background-color: highlight; font-size: 16px; padding-right:5px; 
						padding-left:5px; " id="showOrCloseAnswerCard" onclick="showOrCloseAnswerCard()">答题卡</span>
					<span style="background-color: green; font-size: 16px; padding-right:5px; 
						padding-left:5px; margin-right: 30px;">考试剩余时间：
						<span id="examTime" style="background-color: green; font-size: 16px;"></span>
					</span>
				</span>
			</div>
			<div align="left" id="answerCardTabs" class="easyui-tabs" style="width: 1045px;;height: 60px;"></div>
			<div align="center">
				<span style="background-color:yellow; width: 100%; 
					height: 20px; display: block;">${examMate.examsNotice}
				</span>
			</div>
			<form id="fm" method="post" >
				<input id="paperInfoId" type="hidden" value="${paperInfo.paperInfoId}"/>
				<input id="paperInfoPass" type="hidden" value="${paperInfo.paperInfoPass}"/>
				<input id="examsInfoId" type="hidden" value="${paperInfo.examsInfoId}"/>
				<input id="points" type="hidden" value="${paperInfo.points}"/>
				<input id="resultMateId" type="hidden" value="${resultMateId}"/>
				<div style="text-align: center; " align="center"><h3>${paperInfo.paperInfoName}</h3></div>
				<div id="paperInfo" style="min-height: 100px;"></div>
			</form>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="preQusetion()" id="btnPre">上一题</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="showAnswer()" id="btnShow">查看答案</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="nextQusetion()" id="btnNext">下一题</a>
	        </div>
			<br/>
			<div style="text-align:center;" id="submitDiv">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="submitExam()" id="btnSave">提交</a>
	        </div>
		</div>
	</div>
</body>
</html>