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
<style>
	.box{ margin-bottom: 20px; margin-left: 20px;}
	.chose{font-size: 15px; margin-left: 40px;margin-right: 35px; background-color: #fff; 
		border: 1px solid #ccc; padding:20px 30px;margin-top: 20px;
		box-shadow: 0px 2px 3px #B1C6C7;
	}
	.title{ font-size: 18px; font-weight:bold; color: #000;}
	.chose_con{ line-height: 20px;margin-left: 10px;}
</style>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var examTimer; // 考试计时器
	var duration = <%=oem%>.duration; // 考试限时，0等于不限时
	var examModeAnswer = <%=oem%>.examModeAnswer; // 逐题查看答案（0-不允许，1-允许）
	var v_info = <%=paperInfo%>.paperQsnType; // 试卷大题类型
	$(function() {
		showQusetions();
		// 考试计时
		if (duration == 0) { // 当考试不限时的时候, 考试结束时间为交卷时间
			var currDate = new Date(); // 当前时间
			var endTime = new Date(<%=oem%>.endTime.substring(0, 19).replace(/-/g,"/")); // 考试结束时间
			var date = (endTime.getTime() - currDate.getTime()) / 1000; // 两日期相差的秒数
			examTimer(date);
		} else {
			examTimer(duration * 60); // 因为是限时分钟
		}
	});
	// 展示试题
	function showQusetions(){
		for (var i = 0; i < v_info.length; i++) {
			// 大题类型（及每题分数）
			var paperTypeInfo = "<div class='title' name='paperQsnType'><span name='qsnTypeTitle'>" 
				+ v_info[i].qsnTypeTitle + "</span><span>(每题</span><span name='qsnPoint'>" 
				+ v_info[i].qsnPoint + "</span><span>分)</span><input name='qsnType' type='hidden' value='"
				+ v_info[i].qsnType + "' /></div>" ;
			var questionInfo = ""; // 试题信息
			var answerExplainInfo = ""; // 答案解析
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
				questionInfo += "<div name='qsnInfoList' class='chose' id='" 
					+ qsnInfo.qsnInfoId + "'><span>" + (j+1) + ".</span>"
					+ "<span name='qsnInfoDesc' class='chose_con'>"  + qsnInfoDesc; 
				if (examModeAnswer == 1) { // 逐题查看答案（0-不允许，1-允许）
					questionInfo += "</span><input type='button' onclick='showAnswer(\"" + qsnInfo.qsnInfoId + "\")'"
						+ "value='查看答案' style='width:70px;color: white;"  
						+ "background-color:#0066CC; margin-right: 50px;float:right;' /><br>";
				} else {
					questionInfo += "</span><br>";
				}
				answerExplainInfo += "<div id='" + qsnInfo.qsnInfoId + "AnswerDiv' style='display:none;'><span style='font-size: 15px;'>答案：</span>";
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
						// 答案解析
						if (qsnData[k].qsnDataIsanswer == 1) {
							answerExplainInfo += String.fromCharCode(64 + parseInt(k+1)) + "&nbsp;&nbsp;&nbsp;";
						}
					}
				} else {
					for (var k = 0; k < qsnData.length; k++) {
						qsnDataInfo += "<span>" + (k+1) + ".</span><div style='overflow: auto;'>" 
							+ "<textarea class='ckeditor' name='answerArea' id='" + qsnData[k].qsnDataId + "'></textarea></div>";
						answerExplainInfo +=  "<div><span>" + (k+1) + ".</span>&nbsp;" + qsnData[k].qsnDataOptiondesc + "</div>";
					}
				}
				answerExplainInfo += "<br><span style='font-size: 15px;'>答案解析：" + qsnInfo.qsnInfoExplain + "</span></div>";
				questionInfo = questionInfo + qsnDataInfo + answerExplainInfo + "</div>";
			}
			$("#paperInfo").append("<div class='box'>" + paperTypeInfo + questionInfo + "</div>");
		}
		var ckeditor = $("textarea");
		for(var i = 0; i < ckeditor.length; i++){
			CKEDITOR.replace(ckeditor.get(i), { height: '40px', width: '930px' });
		}
	}
	// 查看试题答案
	function showAnswer(qsnId) {
		$("#" + qsnId + "AnswerDiv").show();
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
	// 提交试卷
	function submitExam() {
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
						closeAndRefreshWindow();
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','提交失败：'+result.msg,'error');
                }
		   }
		}); 
	}
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = "ok";      
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");    
	}
	
	// 获取提交的数据
	function getSubmitData() {
		
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
			paperInfoId : $("#paperInfoId").val(), // 试卷id
			paperInfoPass : $("#paperInfoPass").val(), // 试卷及格分数
			points : $("#points").val(), // 试卷总分
			examsInfoId : $("#examsInfoId").val(), // 对应考试id
			submitData : "[" + submitData + "]", // 提交的试卷答案
			paperInfoData : JSON.stringify(<%=paperInfo%>), // 试卷内容
			examsName : <%=oem%>.examsName, // 考试名称
			resultMateId : $("#resultMateId").val() // 用户考试信息表id
		};
		return fomData;
	}
	// 获取单选题选择结果
	function getRadioAnswers(qsnInfoList, qsnPoint, qsnType) {
		var radioAnswersArr = [];
		for (var i = 0; i < qsnInfoList.length; i++) {
			// 获取每道题的试题id
			var qsnInfoId = qsnInfoList.eq(i).attr("id");
			// 获取选中的选项id
			var qsnDataId = $("input:radio[name='" + qsnInfoId + "']:checked").val();
			// radioAnswers[qsnInfoId] = qsnDataId;
			var radioAnswers = {
				qsnInfoId : qsnInfoId,
				qsnDataId : qsnDataId ? qsnDataId : "",
				qsnPoint : qsnPoint,
				qsnType : qsnType
			};
			radioAnswersArr.push($.toJSON(radioAnswers));
		}
		return radioAnswersArr;
	}
	// 获取判断题选择结果
	function getJudjeAnswers(qsnInfoList, qsnPoint, qsnType) {
		var radioAnswersArr = [];
		for (var i = 0; i < qsnInfoList.length; i++) {
			// 获取每道题的试题id
			var qsnInfoId = qsnInfoList.eq(i).attr("id");
			// 获取选中的选项id
			var qsnDataId = $("input:radio[name='" + qsnInfoId + "']:checked").val();
			// radioAnswers[qsnInfoId] = qsnDataId;
			var radioAnswers = {
				qsnInfoId : qsnInfoId,
				qsnDataId : qsnDataId ? qsnDataId : "",
				qsnPoint : qsnPoint,
				qsnType : qsnType
			};
			radioAnswersArr.push($.toJSON(radioAnswers));
		}
		return radioAnswersArr;
	}
	// 获取多选题选择结果
	function getCheckAnswers(qsnInfoList, qsnPoint, qsnType) {
		var checkAnswersArr = [];
		for (var i = 0; i < qsnInfoList.length; i++) {
			// 获取每道题的试题id
			var qsnInfoId = qsnInfoList.eq(i).attr("id");
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
			checkAnswersArr.push($.toJSON(checkAnswers));
		}
		return checkAnswersArr;
	}
	// 获取填空题（简答题）回答结果
	function getBlankAnswers(qsnInfoList, qsnPoint, qsnType) {
		var blankAnswersArr = [];
		for (var i = 0; i < qsnInfoList.length; i++) {
			// 获取每道题的试题id
			var qsnInfoId = qsnInfoList.eq(i).attr("id");
			var answers = [];
			var answersArr = qsnInfoList.eq(i).find("textarea[name='answerArea']");
			for (var j = 0; j < answersArr.length; j++) {
				var qsnDataId = answersArr.eq(j).attr("id");
				var qsnDataVal = CKEDITOR.instances[answersArr.eq(j).attr("id")].getData();
				answers.push({qsnDataId : qsnDataId, answer : qsnDataVal});
			}
			var blankAnswers = {
				qsnInfoId : qsnInfoId,
				answers : answers,
				qsnPoint : qsnPoint,
				qsnType : qsnType
			};
			blankAnswersArr.push($.toJSON(blankAnswers));
		}
		return blankAnswersArr;
	}
	// 清空填空题填空框
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
	<div class="easyui-layout" fit="true" style="background-color:#F3F3F3;">                  
		<div region="center" style="overflow: auto;" border="false">
			<div align="right">
				<span style="background-color:yellow; width: 100%; height: 20px; display: block;">
					<span style="background-color: green; font-size: 16px; padding-right:5px; 
						padding-left:5px; margin-right: 30px;">考试剩余时间：
						<span id="examTime" style="background-color: green; font-size: 16px;"></span>
					</span>
				</span>
			</div>
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
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="submitExam()" id="btnSave">提交</a>
	        </div>
		</div>
	</div>
</body>
</html>