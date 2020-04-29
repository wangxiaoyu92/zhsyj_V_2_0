<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 考试id
	String v_examsInfoId = StringHelper.showNull2Empty(request.getParameter("examsInfoId"));  
%>
<!DOCTYPE html>
<html>
<head>
<title>考试信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var examPaperGrid; // 考试试卷表格
	var v_examWay = [{"id":"1","text":"线上"}]; // 考试方式（线上、线下）,{"id":"0","text":"线下"}
	var v_maxTimes = [{"id":"0","text":"不限"},{"id":"1","text":"限制每人最多参加次数"}]; // 最大参考次数，默认=0不限次数
	var v_examMode = [{"id":"1","text":"显示完整试卷"},{"id":"2","text":"显示每一道题"}]; // 考试方式,1=整卷,2=逐题
	var v_duration = [{"id":"0","text":"不限"},{"id":"1","text":"限制时长"}]; // 考试限时，0等于不限时
	var v_unityPoint = [{"id":"0","text":"试题分数累加"}]; // 统一总分,0=使用卷面总分 ,{"id":"1","text":"折算试卷分数"}
	var v_unityDuration = [{"id":"0","text":"从进入考试开始算时"}]; // 统一考试时间,0=从进入考试开始算时,1=以考试开始时间算时 ,{"id":"1","text":"以考试开始时间算时"}
	var v_examsInfoState = [{"id":"0","text":"禁用"},{"id":"1","text":"启用"}]; // 考试状态,0=禁用,1=启用（可用）
	var v_examsType = [{"id":"0","text":"练习"},{"id":"1","text":"考试"}]; // 考试类型,0=练习,1=考试
	var v_examModeAnswer = [{"id":"0","text":"不允许"},{"id":"1","text":"允许"}]; // 逐题查看答案（0-不允许，1-允许）
	// var v_isSurveillance = [{"id":"0","text":"不开启"},{"id":"1","text":"开启"}]; // 是否启用考试监控,0=不开起,1=启用
	$(function() {
		loadCombobox(); // 加载页面下拉选择框
		/*************是否需要考试报名***************/
	    /* $("#isNeedSignUpDiv").hide();
	    $("#isNeedSignUp").bind("click", function(){
		  if ($("#isNeedSignUp").prop("checked")) {
		  	$("#isNeedSignUpDiv").show();
		  } else {
		  	$("#isNeedSignUpDiv").hide();
		  }
		}); */ 
		/*************是否需要考试报名***************/
		/*************考试成绩发布***************/
		$("#resultPublishTime").hide();
	    $("input[name='isResultPublish']").bind("click", function(){
		  if ($("input[name='isResultPublish']").eq(2).prop("checked")) {
		  	$("#resultPublishTime").show();
		  } else {
		  	$("#resultPublishTime").hide();
		  }
		});
		/*************考试成绩发布***************/
		
		/*************指定限制ip***************/
		/* $("#isAllowIpDiv").hide();
	    $("input[name='isAllowIp']").bind("click", function(){
		  if ($("input[name='isAllowIp']").eq(1).prop("checked")) {
		  	$("#isAllowIpDiv").show();
		  } else {
		  	$("#isAllowIpDiv").hide();
		  }
		}); */
		/*************考试成绩发布***************/
	    loadExamPaperGird(); // 加载试卷试题类型表格 
	    // 如果试卷id不为空
	    if ($('#examsInfoId').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + 'exam/exam/queryExamInfoObj', {
				examsInfoId : $('#examsInfoId').val()
			}, 
			function(result) {
				if (result.code == '0') {
					var mydata = result.examMate;					
					$('form').form('load', mydata);
					setComboboxAndCheckboxData(result.examInfo, mydata); // 设置下拉框与选择框的值
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg, 'error');
	            }	
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
	// 设置下拉框与选择框的值
	function setComboboxAndCheckboxData(v_info, v_data) {
		$("#examWay").combobox("select", v_data.examWay); // 考试方式（1线上、0线下)
		$("#maxTimesCombobox").combobox("select", v_data.maxTimes); // 最大参考次数，默认=0不限次数
		$("#examMode").combobox("select", v_data.examMode); // 考试方式,1=整卷,2=逐题
		if (v_data.duration == 0) {
			$("#durationCombobox").combobox("select", "0"); // 考试限时，0等于不限时
		} else {
			$("#durationCombobox").combobox("select", "1"); // 考试限时，0等于不限时
			$("#duration").val(v_data.duration);
		}
		
		$("#unityPointCombobox").combobox("select", v_data.unityPoint); // 统一总分,0=使用卷面总分
		$("#unityDuration").combobox("select", v_data.unityDuration); // 统一考试时间,0=从进入考试开始算时,1=以考试开始时间算时
		$("#examsInfoState").combobox("select", v_info.examsInfoState); // 考试状态,0=禁用,1=启用（可用）
		$("#examsType").combobox("select", v_data.examsType); // 考试类型,0=练习,1=考试
		$("#isSurveillance").combobox("select", v_data.isSurveillance); // 是否启用考试监控,0=不开起,1=启用
		// 设置下拉框与选择框选中状态
		if (v_data.examModePrev == '1') {
			 $("#examModePrev").attr("checked", true); // 逐题模式，是否允许查看上一题0=不允许，1=允许
		}
		/* if (v_data.signUpStartTime != "1970-01-01 00:00:00") {
			 $("#isNeedSignUp").attr("checked", true); // 考试是否需要报名
			 $("#isNeedSignUpDiv").show();
		} */
		/* if (v_data.isAntiCheat == "1") {
			 $("#isAntiCheat").attr("checked", true); // 是否防作弊,0=开卷考试,1=防作弊考试
		} */
		/* if (v_data.unPass == "1") {
			 $("#unPass").attr("checked", true); // 及格后不能再考，0=不限制，1及格后不能再考
		} */
		/* if (v_data.publishAnswerFlg == "1") {
			 $("#publishAnswerFlg").attr("checked", true); // 是否允许考生查看答案(1:是;0:否;)
		} */
		/* if (v_data.noAll == "1") {
			 $("#noAll").attr("checked", true); // 禁止右键、剪切、复制、粘贴
		} */
		/* if (v_data.isQuestionsRandom == "1") {
			 $("#isQuestionsRandom").attr("checked", true); // 是否随机显示试题,0=正常显示,1=随机显示
		} */
		/* if (v_data.isResultRank == "1") {
			 $("#isResultRank").attr("checked", true); // 是否显示排行榜,0=不显示,1=显示
		} */
		// 考试结果发布时间,"1970-01-01 00:00:00"为永不发布“1970-01-01 01:01:01”=交卷后立即发布
		if (v_data.resultPublishTime.indexOf("1970-01-01 00:00:00") >= 0) {
			 $("input[name='isResultPublish']").eq(0).attr("checked", true); 
		} else if (v_data.resultPublishTime.indexOf("1970-01-01 01:01:01") >= 0) {
			 $("input[name='isResultPublish']").eq(1).attr("checked", true); 
		} else {
			 $("input[name='isResultPublish']").eq(2).attr("checked", true); 
			 $("#resultPublishTime").show();
		}
		// 是否限制ip
		/* if (v_data.allowIp != "no") {
			 $("input[name='isAllowIp']").eq(0).attr("checked", true); 
		} else {
			 $("input[name='isAllowIp']").eq(1).attr("checked", true); 
			 $("#isAllowIpDiv").show();
		} */
		
	}
	// 加载页面下拉框
	function loadCombobox() {
		// 考试方式（1线上、0线下)
		$("#examWay").combobox({
	    	data : v_examWay,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#examWay").combobox("select", "1");
        	},
        	onSelect: function(rec){  
	        	// $("#downLine").hide();
	        	var selectId = rec.id;
	        	if (selectId == "1") { 
	        		// $("#downLine").hide();
	        		$("#maxTimesCombobox").combobox('enable',true); // 参考次数
	        		$("#examMode").combobox('enable',true); // 答卷模式
	        		$("#unityPointCombobox").combobox('enable',true); // 考试分数
	        		//$("#offlineScore").val(0); // 线下总分 
					//$("#offlinePass").val(0); // 及格分
	        	} 
	        	/* else if (selectId == "0") { 
	        		$("#downLine").show();
	        		$("#maxTimesCombobox").combobox("select", "0").combobox('disable',true); // 参考次数
	        		$("#examMode").combobox("select", "1").combobox('disable',true); // 答卷模式
	        		$("#unityPointCombobox").combobox("select", "0").combobox('disable',true); // 考试分数
	        	} */
        	}
	    });
	    // 最大参考次数，默认=0不限次数
	    $("#maxTimesCombobox").combobox({
	    	data : v_maxTimes,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#maxTimesCombobox").combobox("select", "0");
        	},
        	onSelect: function(rec){  
	        	$("#maxTimesSpan").hide();
	        	$("#maxTimes").val(0);
	        	var selectId = rec.id;
	        	if (selectId == "1") { 
	        		$("#maxTimesSpan").show();
	        	} else if (selectId == "0") { 
	        		$("#maxTimesSpan").hide();
	        	}
        	}
	    });
	    // 考试方式,1=整卷,2=逐题 
		$("#examMode").combobox({
	    	data : v_examMode,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#examMode").combobox("select", "1");
        	},
        	onSelect: function(rec){  
	        	$("#examModePrevSpan").hide();
	        	var selectId = rec.id;
	        	if (selectId == "2") { 
	        		$("#examModePrevSpan").show();
	        	} else if (selectId == "1") { 
	        		$("#examModePrevSpan").hide();
	        	}
        	}
	    });
	    // 考试限时，0等于不限时
	    $("#durationCombobox").combobox({
	    	data : v_duration,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#durationCombobox").combobox("select", "0");
        	},
        	onSelect: function(rec){  
	        	$("#duration").hide();
	        	$("#duration").val(0);
	        	var selectId = rec.id;
	        	if (selectId == "1") { 
	        		$("#duration").show();
	        	} else if (selectId == "0") { 
	        		$("#duration").hide();
	        	}
        	}
	    });
	    // 统一总分,0=使用卷面总分
		$("#unityPointCombobox").combobox({
	    	data : v_unityPoint,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#unityPointCombobox").combobox("select", "0");
        	},
        	onSelect: function(rec){  
	        	$("#unityPointSpan").hide();
	        	var selectId = rec.id;
	        	if (selectId == "1") { 
	        		$("#unityPointSpan").show();
	        	} else if (selectId == "0") { 
	        		$("#unityPointSpan").hide();
	        	}
        	}
	    });
	    // 统一考试时间,0=从进入考试开始算时,1=以考试开始时间算时
		$("#unityDuration").combobox({
	    	data : v_unityDuration,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#unityDuration").combobox("select", "0");
        	}
	    });
	    // 考试状态,0=禁用,1=启用（可用）
		$("#examsInfoState").combobox({
	    	data : v_examsInfoState,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#examsInfoState").combobox("select", "1");
        	}
	    });
	    // 考试类型,0=练习,1=考试
		$("#examsType").combobox({
	    	data : v_examsType,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#examsType").combobox("select", "1");
        	}
	    });
	    // 逐题查看答案（0-不允许，1-允许）
		$("#examModeAnswer").combobox({
	    	data : v_examModeAnswer,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#examModeAnswer").combobox("select", "0");
        	}
	    });
	    /* // 是否启用考试监控,0=不开起,1=启用
		$("#isSurveillance").combobox({
	    	data : v_isSurveillance,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#isSurveillance").combobox("select", "0");
        	}
	    }); */
	}
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = "ok";      
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");    
	}
	// 加载考试试卷表格
	function loadExamPaperGird() {
		var v_examsInfoId = $("#examsInfoId").val();
		if (v_examsInfoId == "" || v_examsInfoId == null) {
			v_examsInfoId = "null";
		}
		examPaperGrid = $('#examPaperGrid').datagrid({
			toolbar: '#toolbar',
			url : basePath + 'exam/exam/queryExamPapers',
			queryParams : { examsInfoId : v_examsInfoId },
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : false,// 底部显示分页栏
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'examsDataId', //该列是一个唯一列
		    sortOrder: 'desc',
			columns : [ [ {
				title: 'ID',
				field: 'examsDataId',
				width : '100',
				hidden : true
			},{
				title: '关联考试信息ID',
				field: 'examsInfoId',
				width : '100',
				hidden : true
			},{
				title: '所使用的试卷ID',
				field: 'paperInfoId',
				width : '100',
				hidden : true
			},{
				title: '试卷名称',
				align:'center',
				field: 'paperInfoName',
				width: '200',
				hidden: false
			},{
				title: '试卷总分',
				field: 'points',
				width: '100',
				hidden: false
			},{
				title: '试题总数',
				field: 'total',
				width: '100',
				hidden : false
			},{
				title: '及格分数',
				field: 'paperInfoPass',
				align: 'center',
				width: '100',
				hidden : false
			}] ]
		});
	}
	// 添加试卷
		// 添加试卷
	function selectPaper() {
		var url=basePath + "jsp/exam/exam/selectPaper.jsp";
		var dialog = parent.sy.modalDialog({
			title : '添加试卷',
			width : 600,
			height : 500,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			if(obj != null){
			for (var i = 0; i < obj.length; i++) {
				var paperInfo = obj[i];
				var flag = checkPaperIsExit(paperInfo.paperInfoId);
				if (!flag) {
						examPaperGrid.datagrid('insertRow',{
						row: {
							examsInfoId : $("#examsInfoId").val(), // 关联考试信息id
							paperInfoId : paperInfo.paperInfoId, // 所使用试卷id
							paperInfoName : paperInfo.paperInfoName, // 试卷名称
							points : paperInfo.points, // 试卷总分
							total : paperInfo.total, // 试卷总数
							paperInfoPass : paperInfo.paperInfoPass // 及格分数
						}
					});
				}
				}
			}
		});
		}
	// 检验试卷是否已存在
	function checkPaperIsExit(paperId) {
		var flag = false; // 默认所选试卷在该考试中不存在
		var papers = examPaperGrid.datagrid('getRows'); // 当前加载的所有试卷
		for (var i = 0; i < papers.length; i++) {
			if (papers[i].paperInfoId == paperId) {
				flag = true;
			}
		}
		return flag;
	}
	// 删除试卷
	function delPaper() {
		var row = examPaperGrid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除该试卷吗?', function(r) {
				if (r) {
					var rowIndex = examPaperGrid.datagrid('getRowIndex', row);
					examPaperGrid.datagrid('deleteRow', rowIndex); // 移除数据
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的试卷！', 'info');
		}
	}
	// 保存试卷信息
	function saveExamInfo() {
		var fromData = getFormData();
		$.messager.progress();	// 显示进度条
		var isValid = $("#fm").form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
		if (!isValid) {
			$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
			alert( "填写数据不符合规范");
			return;
		}
		$.ajax({
		   type : "POST",
		   url : basePath + "exam/exam/saveExamInfo",
		   data : fromData,
		   traditional : true,
		   success : function(result){
		   		$.messager.progress('close');// 隐藏进度条  
		   		result = eval('(' + result + ')');
			 	if (result.code == '0'){
			 		$.messager.alert('提示', '保存成功！', 'info', function(){
						 closeAndRefreshWindow();
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：' + result.msg, 'error');
                }
		   }
		}); 
	}
	// 获取表单信息
	function getFormData() {
		// 考试所包含试卷信息
		var v_examPapers = examPaperGrid.datagrid('getRows');
		// 最大参考次数，默认=0不限次数 
		var v_maxTimes = 0; 
		if ($("#maxTimesCombobox").combobox('getValue') == "1") {
			v_maxTimes = $("#maxTimes").val();
		}
		// 统一总分,0=使用卷面总分
		var v_unityPoint = 0; 
		if ($("#unityPointCombobox").combobox('getValue') == "1") {
			v_unityPoint = $("#unityPoint").val();
		}
		var v_duration = 0; // 考试限时，0等于不限时 
		if ($("#durationCombobox").combobox('getValue') == "1") {
			v_duration = $("#duration").val();
		}
		// 考试结果发布时间,"1970-01-01 00:00:00"为永不发布“1970-01-01 01:01:01”=交卷后立即发布
		var v_resultPublishTime = "1970-01-01 00:00:00"; 
		if ($("input[name='isResultPublish']").eq(2).prop("checked")) { // 指定发布时间
			v_resultPublishTime = $("#resultPublishTime").val();
		} else if ($("input[name='isResultPublish']").eq(1).prop("checked")) { // 交卷后立即发布
			v_resultPublishTime = "1970-01-01 01:01:01";
		} else if ($("input[name='isResultPublish']").eq(0).prop("checked")) { // 永不发布
			v_resultPublishTime = "1970-01-01 00:00:00";
		}
		// 是否显示排行榜,0=不显示,1=显示
		/* var v_isResultRank = "0";
		if ($("#isResultRank").prop("checked")) {
			v_isResultRank = "1";
		} */
		// 是否防作弊,0=开卷考试,1=防作弊考试
		/* var v_isAntiCheat = "0";
		if ($("#isAntiCheat").prop("checked")) {
			v_isAntiCheat = "1";
		} */
		// 是否随机显示试题,0=正常显示,1=随机显示
		/* var v_isQuestionsRandom = "0";
		if ($("#isQuestionsRandom").prop("checked")) {
			v_isQuestionsRandom = "1";
		} */
		// 及格后不能再考，0=不限制，1及格后不能再考
		/* var v_unPass = "0";
		if ($("#unPass").prop("checked")) {
			v_unPass = "1";
		} */
		// 是否允许考生查看答案(1:是;0:否;)
		/* var v_publishAnswerFlg = "0";
		if ($("#publishAnswerFlg").prop("checked")) {
			v_publishAnswerFlg = "1";
		} */
		// 逐题模式，是否允许查看上一题0=不允许，1=允许
		var v_examModePrev = "0";
		if ($("#examModePrev").prop("checked")) {
			v_examModePrev = "1";
		}
		// 禁止右键、剪切、复制、粘贴
		/* var v_noAll = "0";
		if ($("#noAll").prop("checked")) {
			v_noAll = "1";
		} */
		// 报名开始时间
		var v_signUpStartTime = null;
		if ($("#signUpStartTime").val() != "" && $("#signUpStartTime").val() != null) {
			v_signUpStartTime = $("#signUpStartTime").val();
		} else {
			v_signUpStartTime = "1970-01-01 00:00:00";
		}
		// 报名结束时间 
		var v_signUpEndTime = null;
		if ($("#signUpEndTime").val() != "" && $("#signUpEndTime").val() != null) {
			v_signUpEndTime = $("#signUpEndTime").val();
		} else {
			v_signUpEndTime = "1970-01-01 00:00:01";
		}
		var formData = {
			"examsInfoId" : $("#examsInfoId").val(), // 考试信息id
			"examsName" : $("#examsName").val(), // 考试名称
			"examsInfoState" : $("#examsInfoState").combobox('getValue'), // 考试状态,0=禁用,1=启用（可用）
			"examsType" : $("#examsType").combobox('getValue'), // 考试类型（练习/考试）
			"examsNotice" : $("#examsNotice").val(), // 考试须知
			"examsCategory" : "TODO", // 考试分类(与基本信息表关联) TODO
			"duration" : v_duration, // 考试限时
			"startTime" : $("#startTime").val(), // 考试开始时间
			"endTime" : $("#endTime").val(), // 考试结束时间
			"examMode" : $("#examMode").combobox('getValue'), // 考试方式,1=整卷,2=逐题
			"maxTimes" : v_maxTimes, // 最大参考次数
			"unityPoint" : v_unityPoint, // 统一总分,0=使用卷面总分 
			"resultPublishTime" : v_resultPublishTime, // 考试结果发布时间
			"allowIp" : "no", // 限制学习IP段,''ip1-ip2,ip3-ip4'' TODO
			"unityDuration" : $("#unityDuration").combobox('getValue'), // 统一考试时间,0=从进入考试开始算时,1=以考试开始时间算时
			"isResultRank" : "0", // v_isResultRank, // 是否显示排行榜,0=不显示,1=显示 TODO
			"isAntiCheat" : "0",//v_isAntiCheat, // 是否防作弊,0=开卷考试,1=防作弊考试 TODO
			"isListShow" : "1", // 是否在考试列表中显示,0=不显示,1=显示 TODO
			"isQuestionsRandom" : "0", // v_isQuestionsRandom, // 是否随机显示试题,0=正常显示,1=随机显示 TODO
			"isSurveillance" : "0", // 是否启用考试监控,0=不开起,1=启用  TODO
			"signUpStartTime" : v_signUpStartTime, // 报名结束时间
			"signUpEndTime" : v_signUpEndTime, // 考试结束时间
			"disableExam" : $("#disableExam").val()?$("#disableExam").val():0, // 禁止进入考场时间(m),0=不限制
			"disablesubmit" : $("#disablesubmit").val()?$("#disablesubmit").val():0, // 禁止提前交卷时间
			"credit" : "0", // 考试所需金额 TODO
			"unPass" : "0", // v_unPass, // 及格后不能再考，0=不限制，1及格后不能再考 TODO
			"publishAnswerFlg" : "1", // v_publishAnswerFlg, // 是否允许考生查看答案(1:是;0:否;) TODO
			"examModePrev" : v_examModePrev, // 逐题模式，是否允许查看上一题0=不允许，1=允许
			"examManual" : "0", // 是否需要人工评卷 TODO
			"isDisableUserInfo" : "0", // 评卷时是否屏蔽考生信息 TODO
			"examWay" : $("#examWay").combobox('getValue'), // 考试方式（线上/线下）
			"offlineScore" :"0",//$("#offlineScore").val(), // 线下总分  TODO
			"offlinePass" : "0",//$("#offlinePass").val(), // 线下及格分  TODO
			"coverImg" : "图片路径", // 考试封面 TODO
			"examModeAnswer" : $("#examModeAnswer").combobox('getValue'), // 逐题查看答案（0-不允许，1-允许）
			"noAll" : "0", // v_noAll, // 禁止右键、剪切、复制、粘贴 TODO
			"examPapers" :  $.toJSON(v_examPapers) // 试题数据
		};
		return formData;
	}
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">                  
		<div region="center" style="overflow: auto;" border="false">
			<form id="fm" method="post" >	
				<input id="examsInfoId" name="examsInfoId" type="hidden" value="<%=v_examsInfoId%>"/>
        		<sicp3:groupbox title="考试设置">
				<table class="table" style="width:98%;height: 98%">
					<tr><td width="10%"></td><td width="40%"></td><td width="10%"></td><td width="40%"></td></tr> 
	        		<tr>
	                	<td style="text-align:right;"><nobr>考试名称:</nobr></td>
						<td colspan="3"><input id="examsName" name="examsName" 
							style="width: 600px" class="easyui-validatebox" data-options="required:true" /></td>
					</tr>
					<tr>
	                	<td style="text-align:right;"><nobr>考试类型:</nobr></td>
						<td colspan="3"><input id="examWay" name="examWay" style="width: 200px" 
							class="easyui-combobox" data-options="required:true"/></td>
					</tr>
					<tr>
                        <td style="text-align:right;"><nobr>考试须知:</nobr></td>
						<td colspan="3"><textarea id="examsNotice" name="examsNotice" 
							style="width: 600px; height: 50px;" data-options="required:true"></textarea></td>
					</tr>   
					<tr>
						<td style="text-align:right;"><nobr>参考次数:</nobr></td>
						<td><input id="maxTimesCombobox" name="maxTimesCombobox" 
							style="width: 200px" class="easyui-combobox" />
							<span id="maxTimesSpan"><input id="maxTimes" name="maxTimes" style="width: 30px"/>次</span></td>
						<td style="text-align:right;"><nobr>考试时间:</nobr></td>
						<td><input name="startTime" id="startTime" class="Wdate easyui-validatebox"
				 				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"  
				 				style="width: 100px;" data-options="required:true"/>~
			 				<input name="endTime" id="endTime"class="Wdate easyui-validatebox"
			 				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"  
			 				style="width: 100px;" data-options="required:true"/>
			 			</td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>答卷模式:</nobr></td>
						<td><input id="examMode" name="examMode" style="width: 200px" class="easyui-combobox"/>
							<span id="examModePrevSpan"><input id="examModePrev" name="examModePrev" type="checkbox"/>显示上一题</span>
						</td>
						<td style="text-align:right;"><nobr>答卷时长:</nobr></td>
						<td><input id="durationCombobox" name="durationCombobox" 
							style="width: 200px" class="easyui-combobox" />
							<input id="duration" name="duration" style="width: 30px"/>分钟</td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>考试分数:</nobr></td>
						<td><input id="unityPointCombobox" name="unityPointCombobox" style="width: 200px" class="easyui-combobox"/>
							<span id="unityPointSpan"><input id="unityPoint" name="unityPoint" style="width: 30px"/></span></td>
						<td style="text-align:right;"><nobr>计时方式:</nobr></td>
						<td><input id="unityDuration" name="unityDuration" 
							style="width: 200px" class="easyui-combobox" />
						</td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>考试状态:</nobr></td>
						<td><input id="examsInfoState" name="examsInfoState" style="width: 200px" class="easyui-combobox"/></td>
						<td style="text-align:right;"><nobr>考试类型:</nobr></td>
						<td><input id="examsType" name="examsType" style="width: 200px" class="easyui-combobox"/></td>
					</tr> 
					<tr>
						<td style="text-align:right;"><nobr>逐题查看答案:</nobr></td>
						<td><input id="examModeAnswer" name="examModeAnswer" style="width: 200px" class="easyui-combobox"/></td>
						<td style="text-align:right;"></td>
						<td></td>
					</tr>
					<!-- <tr>
						<td style="text-align:right;"><nobr>是否监控:</nobr></td>
						<td><input id="isSurveillance" name="isSurveillance" style="width: 200px" class="easyui-combobox"/></td>
						<td style="text-align:right;"></td>
						<td></td>
					</tr> --> 
					<!-- <tr id="downLine">
						<td style="text-align:right;"><nobr>线下总分:</nobr></td>
						<td><input id="offlineScore" name="offlineScore" style="width: 200px" class="easyui-validatebox"/></td>
						<td style="text-align:right;"><nobr>及格分:</nobr></td>
						<td><input id="offlinePass" name="offlinePass" style="width: 200px" class="easyui-validatebox"/></td>
					</tr> --> 
				</table>
				</sicp3:groupbox>
				<sicp3:groupbox title="考试属性">
				<table class="table" style="width:98%;height: 98%">
					<tr><td width="50%"></td><td width="50%"></td></tr> 
	        		<!-- <tr>
						<td colspan="2"><input id="isNeedSignUp" name="isNeedSignUp" type="checkbox"/>考试需要报名
						<div id="isNeedSignUpDiv" style="float: right;">
							报名时间：<input name="signUpStartTime" id="signUpStartTime"class="Wdate"
				 				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"  
				 				style="width: 175px;"/>~
			 				<input name="signUpEndTime" id="signUpEndTime"class="Wdate"
			 				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"  
			 				style="width: 175px;"/>
		 				</div>
						</td>
					</tr> -->
					<!-- <tr>
	                	<td><input id="isAntiCheat" name="isAntiCheat" type="checkbox"/>是否防作弊</td>
	                	<td><input id="noAll" name="noAll" type="checkbox"/>禁用复制/粘贴/剪切和鼠标右键 </td>
					</tr> -->
					<!-- <tr>
                        <td><input id="unPass" name="unPass" type="checkbox"/>及格后不能再考</td>
                        <td><input id="isQuestionsRandom" name="isQuestionsRandom" type="checkbox"/>是否随机显示试题</td>
					</tr> -->
					<!-- <tr>
                        <td><input id="publishAnswerFlg" name="publishAnswerFlg" type="checkbox"/> 发布后允许查看试卷和答案</td>
                        <td><input id="isResultRank" name="isResultRank" type="checkbox"/>显示排名</td>
					</tr> -->    
					<tr>
						<td colspan="2">成绩发布：<input name="isResultPublish" type="radio"/>永不发布
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input name="isResultPublish" type="radio"/>交卷后立刻发布
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input name="isResultPublish" type="radio"/> 指定发布时间 
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input name="resultPublishTime" id="resultPublishTime"class="Wdate"
			 				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"  
			 				style="width: 175px;"/>
						</td>
					</tr>
					<tr>
						<td>开始考试<input id="disableExam" name="disableExam" style="width: 50px;"
							class="easyui-validatebox" data-options="validType:'integer'"/>分钟后禁止考生参加</td>
                        <td>开始考试<input id="disablesubmit" name="disablesubmit" style="width: 50px;"
                        	class="easyui-validatebox" data-options="validType:'integer'"/>分钟内禁止考生交卷</td>
					</tr>
					<!-- <tr>
						<td colspan="2">限制ip：<input name="isAllowIp" type="radio"/>不限制
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input name="isAllowIp" type="radio"/>指定ip段：
							<div id="isAllowIpDiv">
								从<input name="allowIp" />class="easyui-validatebox" data-options="validType:'ip'" 
		  						到<input name="allowIp" />class="easyui-validatebox" data-options="validType:'ip'" 
							</div>
						</td>
					</tr> -->
				</table>
				</sicp3:groupbox>
				<sicp3:groupbox title="试卷">
					<div id="toolbar">
		        		<table>
							<tr>	        		
								<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_selectPaper"
										iconCls="icon-add" plain="true" onclick="selectPaper()">选择试卷</a>
								</td>
								<td><div class="datagrid-btn-separator"></div></td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delPaper"
										iconCls="icon-remove" plain="true" onclick="delPaper()">删除</a>
								</td>  
								<td><div class="datagrid-btn-separator"></div></td>
							</tr>
						</table>
					</div>
					<div id="examPaperGrid"></div>
				</sicp3:groupbox>
			</form>
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="saveExamInfo()" id="btnSave">保存 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-undo" onclick="closeAndRefreshWindow()" id="btnUndo">取消</a>
	        </div>
		</div>
	</div>
</body>
</html>