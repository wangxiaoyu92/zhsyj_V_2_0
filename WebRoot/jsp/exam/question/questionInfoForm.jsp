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
	// 试题id
	String v_qsnInfoId = StringHelper.showNull2Empty(request.getParameter("qsnInfoId"));  
%>
<!DOCTYPE html>
<html>
<head>
<title>试题信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var v_qsnInfoType = <%=SysmanageUtil.getAa10toJsonArrayXz("QSNLX")%>; // 试题类型
	// 试题选项排序号
	var optionArr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"]; 
	var blankOrderNum = 0; // 填空题选项初试排序号
	$(function() {
		// 试题知识点
		$("#qsnInfoTrade").combotree({
			url : basePath + 'exam/question/queryQsnTrade', 
			valueField : 'id',   
	        textField : 'text',
	        required : true, // 设置为必选项
	        editable : false, // 不可编辑
	        multiple : true, // 显示复选框
	        cascadeCheck : false // 串联选择
	    });
	    // 试题类型
		$("#qsnInfoType").combobox({
	    	data : v_qsnInfoType,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto',
	        onSelect: function(rec){  
	        	$("#addOptionBtn").show(); 
	        	// $("#pointsRule").hide();
	        	var selectId = rec.id;
	        	if (selectId == "4") { // 填空
	        		blankOrderNum = 0; // 填空选项排序号
	        		loadBlankItem(); // 加载填空选项
	        		$("#addOptionBtn").unbind().bind("click", addBlankItem);
	        	} else if (selectId == "3") { // 判断
	        		$("#addOptionBtn").hide();
	        		loadJudgeItem();  
	        	} else if (selectId == "5") { // 简答 addAnswerItem
	        		loadAnswerItems(); // 加载简答
	        		$("#addOptionBtn").unbind().bind("click", addAnswerItem);
	        	} else { // 选择
	        		loadSelectItems(); // 加载选择选项
	        		$("#addOptionBtn").unbind().bind("click", addSelectItem);
	        	}
        	}  
	    });
	    // 试题状态
		$("#qsnInfoState").combobox({
	    	data : [{"id":"0","text":"禁用"},{"id":"1","text":"启用"}],      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
	    // 加载试题内容
	    if ($('#qsnInfoId').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + 'exam/question/queryQuestionInfoObj', {
				qsnInfoId : $('#qsnInfoId').val()
			}, 
			function(result) {
				if (result.code == '0') {
					var mydata = result.info;					
					$('form').form('load', mydata);
					var tradeArr = mydata.qsnInfoTrade.split(",");
					if (tradeArr.length > 0) {
						for (var i = 0; i < tradeArr.length; i++) {
							var t = $('#qsnInfoTrade').combotree('tree'); // 获取tree对象
							var node = t.tree("find", tradeArr[i]);
							t.tree('select', node.target); // node为要选中的节点
						}
						$("#qsnInfoTrade").combotree('setValues', tradeArr);
					}
					var v_type = mydata.qsnInfoType;
					$("#addOptionBtn").show(); 
		        	// $("#pointsRule").hide();
		        	if (v_type == "4") { // 填空
		        		blankOrderNum = 0; // 填空选项排序号
		        		loadBlankItem(result.dataList); // 加载填空选项
		        		$("#addOptionBtn").unbind().bind("click", addBlankItem);
		        	} else if (v_type == "3") { // 判断
		        		$("#addOptionBtn").hide();
		        		loadJudgeItem(result.dataList);  
		        	} else if (v_type == "5") { // 简答 addAnswerItem
		        		loadAnswerItems(result.dataList); // 加载简答
		        		$("#addOptionBtn").unbind().bind("click", addAnswerItem);
		        	} else { // 选择
		        		loadSelectItems(result.dataList); // 加载选择选项
		        		$("#addOptionBtn").unbind().bind("click", addSelectItem);
		        	}
				} else {
					parent.$.messager.alert('提示', '查询失败：' + result.msg,'error');
	            }	
				parent.$.messager.progress('close');
			}, 'json');
		}
	    var ckeditor = $("textarea");
		for(var i = 0; i < ckeditor.length; i++){
			CKEDITOR.replace(ckeditor.get(i), { height: '40px', width: '99%', allowedContent: true });
		} 
		if (!$('#qsnInfoId').val()) { 
		    $("#qsnInfoType").combobox("select", "1"); // 试题类型下拉框默认选中第一条（单选题）
		    $("#qsnInfoState").combobox("select", "1"); // 试题大类下拉框默认选中第一条（单选题）
		    $("#addOptionBtn").bind("click", addSelectItem); // 默认绑定添加选项事件
		}
	});
	// 加载选择题选项
	function loadSelectItems(v_data) {
		$("#optionsWarpper").empty(); // 首先清空div内容
		var type = "'radio'";
		var v_type = $("#qsnInfoType").combobox('getValue');
		if (v_type == "1") { // 单选
			type = "'radio'";
		} else if (v_type == "2") { // 多选
			type = "'checkbox'";
		}
		if (v_data) {
			for (var i = 0; i < v_data.length; i++) {
				var checkedstr = " ";
				if (v_data[i].qsnDataIsanswer == 1) {
					checkedstr = "checked='checked'";
				}
				var optionContentId = "optionContent_" + uuid(32);
				$("#optionsWarpper").append("<div name='optionBody'>"  
					+ "<span name='qsnDataOption'>" + v_data[i].qsnDataOption + "</span>" 
					+ "<span>.<input style='width: 20px;' name='qsnDataSort' value='"
					+ v_data[i].qsnDataSort + "' />"
					+ "<a href='javascript:void(0)' onclick='delItem(this)'>删除</a>"
					+ "<input name='isanswer' style='width: 20px;' " + checkedstr + " type=" + type +" /></span>"
					+ "<div style='overflow: auto;'><textarea class='ckeditor' id='" 
					+ optionContentId + "' name='qsnDataOptiondesc' ></textarea></div></div>");
				CKEDITOR.replace(optionContentId, { height: '40px', width: '99%', allowedContent: true }).setData(v_data[i].qsnDataOptiondesc);
			}
		} else {
			for (var i = 0; i < 4; i++) {
				var optionContentId = "optionContent_" + uuid(32);
				$("#optionsWarpper").append("<div name='optionBody'>"  
					+ "<span name='qsnDataOption'>" + optionArr[i] + "</span>" 
					+ "<span>.<input style='width: 20px;' name='qsnDataSort'/>"
					+ "<a href='javascript:void(0)' onclick='delItem(this)'>删除</a>"
					+ "<input name='isanswer' style='width: 20px;' type=" + type + " /></span>"
					+ "<div style='overflow: auto;'><textarea class='ckeditor' id='" 
					+ optionContentId + "' name='qsnDataOptiondesc' ></textarea></div></div>");
				CKEDITOR.replace(optionContentId, { height: '40px', width: '99%', allowedContent: true });
			}
		}
	}
	// 加载判断题选项
	function loadJudgeItem(v_data) {
		var checkedstr = ["", ""];
		if (v_data) {
			if (v_data[0].qsn_data_isanswer == "1") {
				checkedstr[0] = "checked='checked'";
				checkedstr[1] = "";
			} else {
				checkedstr[0] = "";
				checkedstr[1] = "checked='checked'";
			}
		}
		$("#optionsWarpper").empty(); // 首先清空div内容
		$("#optionsWarpper").append("<span name='qsnDataOption'>A</span><span>.<input name='isanswer'" 
			+ "style='width: 20px;' type='radio' " + checkedstr[0] 
			+ "/><input type='hidden' value='1' name='qsnDataSort'/></span>"
			+ "<span name='qsnDataOptiondesc'>对</span></br>");
		$("#optionsWarpper").append("<span name='qsnDataOption'>B</span><span>.<input name='isanswer'" 
			+ "style='width: 20px;' type='radio' " + checkedstr[1]
			+ " /><input type='hidden' value='2' name='qsnDataSort'/></span>"
			+ "<span name='qsnDataOptiondesc'>错</span>");
	}
	// 加载填空题
	function loadBlankItem(v_data) {
		$("#optionsWarpper").empty(); // 首先清空div内容
		if (v_data) {
			for (var i = 0; i < v_data.length; i++) {
				var addItem = "<div name='optionBody'>" 
					+ "<span name='qsnDataOption'>" + v_data[i].qsnDataOption + "</span>" 
					+ "<span>.<input style='width: 80px;' readonly='readonly' value='options" 
					+ v_data[i].qsnDataOption + "' />" 
					+ "<a href='javascript:void(0)' onclick='delItem(this)'>删除</a>"
					+ "<input name='qsnDataOptiondesc' style='width: 200px;' value='" 
					+ v_data[i].qsnDataOptiondesc + "'  /></span></div>";
				$(addItem).appendTo("#optionsWarpper");
			}
			reloadItemOrder();
		}
		/* // 得分方式
		$('#pointStyle').combobox({
	    	data : [{"id":"0","text":"按空算分"},{"id":"1","text":"全队得分"}],      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    }); */
	    // 区分顺序
		/* $('#diffOrder').combobox({
	    	data : [{"id":"0","text":"区分答案顺序"},{"id":"1","text":"不区分答案顺序"}],      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    }); */
	    // 区分大小写
	    /* $('#diffCase').combobox({
	    	data : [{"id":"0","text":"区分大小写"},{"id":"1","text":"不区分大小写"}],      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    }); */
	    // $("#pointsRule").show();
	}
	// 删除选项
	function delItem(_this){
		$(_this).parent().parent().remove();
		var v_type = $("#qsnInfoType").combobox('getValue');
		if (v_type == "4") { // 是否为填空题型
			var data = CKEDITOR.instances.qsnInfoDesc.getData(); // 获取当前文本域内容
			var curBlankArr = splitCkeditoData(data); // 将文本拆分为数组
			if (curBlankArr.length > 0) {
				var newBlankArr = reloadBlankArr($(_this).prev().val(), curBlankArr);
				var newData = ""; // 重新赋值
				for (var i = 0; i < newBlankArr.length; i++) {
					newData += newBlankArr[i];
				}
				CKEDITOR.instances.qsnInfoDesc.setData(newData); // 重新赋值
			}
		} else {
			for ( instance in CKEDITOR.instances ){
				CKEDITOR.instances[instance].updateElement(); 
			}
			reloadItemOrder();
		}
	}
	// 重新排序选项编号 
	function reloadItemOrder(){
		var v_type = $("#qsnInfoType").combobox('getValue');
		var num = $("span[name='qsnDataOption']").length;
		for (var i = 0; i < num; i++) {
			$("span[name='qsnDataOption']").get(i).innerHTML = optionArr[i];
		}
	}
	// 添加选择题选项
	function addSelectItem(){
		var type = "'radio'";
		var v_type = $("#qsnInfoType").combobox('getValue');
		if (v_type == "1") {
			type = "'radio'";
		} else if (v_type == "2") {
			type = "'checkbox'";
		}
		var num = $("div[name='optionBody']").length;
		var optionContentId = "optionContent_" + uuid(32);
		var addItem = "<div name='optionBody'>"  
				+ "<span name='qsnDataOption'>" + optionArr[num] + "</span>" 
				+ "<span>.<input style='width: 20px;' name='qsnDataSort'/>"
				+ "<a href='javascript:void(0)' onclick='delItem(this)'>删除</a>"
				+ "<input name='isanswer' style='width: 20px;' type=" + type + " /></span>"
				+ "<div style='overflow: auto;'><textarea class='ckeditor' id='" 
				+ optionContentId + "' name='qsnDataOptiondesc' ></textarea></div></div>"; 
		$(addItem).appendTo("#optionsWarpper");
		CKEDITOR.replace(optionContentId, { height: '40px', width: '99%', allowedContent: true });
		reloadItemOrder();
	} 
	// 添加填空题选项
	function addBlankItem(){
		blankOrderNum++;
		var addItem = "<div name='optionBody'>" 
				+ "<span name='qsnDataOption'>" + blankOrderNum + "</span>" 
				+ "<span>.<input style='width: 80px;' readonly='readonly' value='options" + blankOrderNum + "' />" 
				+ "<a href='javascript:void(0)' onclick='delItem(this)'>删除</a>"
				+ "<input name='qsnDataOptiondesc' style='width: 200px;' /></span></div>";
		$(addItem).appendTo("#optionsWarpper");
		var data = CKEDITOR.instances.qsnInfoDesc.getData(); // 首先获取文本域内的内容
		var options = "<input id='options" + blankOrderNum 
			+ "' readonly='readonly' style='width: 80px;' value='options" + blankOrderNum + "' />"; // 要给文本域拼接的内容
        CKEDITOR.instances.qsnInfoDesc.setData(data + options); // 重新赋值qsnInfoDesc
        reloadItemOrder();
	} 
	// 添加简答题答案
	function addAnswerItem(){
		var num = $("div[name='optionBody']").length;
		var optionContentId = "optionContent_" + uuid(32);
		var addItem = "<div name='optionBody'>" 
				+ "<span name='qsnDataOption'>" + optionArr[num] + "</span>" 
				+ "<span>.<a href='javascript:void(0)' onclick='delItem(this)'>删除</a></span>"
				+ "<div style='overflow: auto;'><textarea class='ckeditor' id='" 
				+ optionContentId + "' name='qsnDataOptiondesc' ></textarea></div></div>";
		$(addItem).appendTo("#optionsWarpper");
		CKEDITOR.replace(optionContentId, { height: '40px', width: '99%', allowedContent: true });
		reloadItemOrder();
	}
	// 加载简答题答案
	function loadAnswerItems(v_data) {
		$("#optionsWarpper").empty(); // 首先清空div内容
		if (v_data) {
			for (var i = 0; i < v_data.length; i++) {
				var optionContentId = "optionContent_" + uuid(32);
				$("#optionsWarpper").append("<div name='optionBody'>"  
					+ "<span name='qsnDataOption'>" + v_data[i].qsnDataOption + "</span>" 
					+ "<span>.<a href='javascript:void(0)' onclick='delItem(this)'>删除</a></span>"
					+ "<div style='overflow: auto;'><textarea class='ckeditor' id='" 
					+ optionContentId + "' name='qsnDataOptiondesc' ></textarea></div></div>");
				CKEDITOR.replace(optionContentId, { height: '40px', width: '99%', allowedContent: true }).setData(v_data[i].qsnDataOptiondesc);
			}
		} else {
			var optionContentId = "optionContent_" + uuid(32);
			$("#optionsWarpper").append("<div name='optionBody'>"  
				+ "<span name='qsnDataOption'>" + optionArr[0] + "</span>" 
				+ "<span>.<a href='javascript:void(0)' onclick='delItem(this)'>删除</a></span>"
				+ "<div style='overflow: auto;'><textarea class='ckeditor' id='" 
				+ optionContentId + "' name='qsnDataOptiondesc' ></textarea></div></div>");
			CKEDITOR.replace(optionContentId, { height: '40px', width: '99%', allowedContent: true });
		}
	}
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = "ok";      
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");     
	}
	// 将填空题试题描述拆分为数组
	function splitCkeditoData(v_data) {
		var currBlankArr = [];
		var index = v_data.indexOf("<input");
		while (index >= 0) {
			currBlankArr.push(v_data.substring(0, index));
			v_data = v_data.substring(index);
			index = v_data.indexOf("/>");
			currBlankArr.push(v_data.substring(0, index + 2));
			v_data = v_data.substring(index + 2);
			index = v_data.indexOf("<input");
		}
		currBlankArr.push(v_data);
		return currBlankArr;
	}
	// 删除填空题选项后，重新生成填空数组
	function reloadBlankArr(delObjVal, oldBlankArr) {
		var newBlankArr = [];
		for (var i = 0; i < oldBlankArr.length; i++) {
			if (oldBlankArr[i].indexOf(delObjVal) > 0) {
				continue;
			}
			newBlankArr.push(oldBlankArr[i]);
		}
		return newBlankArr;
	}
	// uuid
	function uuid(len, radix) {
		var chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
		var uuid = [], i;
		radix = radix || chars.length;
	 
		if (len) {
			for (i = 0; i < len; i++) uuid[i] = chars[0 | Math.random()*radix];
	    } else {
			var r;
	      	uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';
	      	uuid[14] = '4';
	      	for (i = 0; i < 36; i++) {
	      		if (!uuid[i]) {
	        		r = 0 | Math.random()*16;
	          		uuid[i] = chars[(i == 19) ? (r & 0x3) | 0x8 : r];
	        	}
	      	}
	    }
	    return uuid.join('');
	} 
	// 保存试题信息
	function saveQustionInfo() {
		var fromData = getFormData();
		// 试题描述验证
		var v_qsnInfoDesc = CKEDITOR.instances.qsnInfoDesc.getData();
		if (!v_qsnInfoDesc) {
			$.messager.alert('提示','试题描述不能为空！','info');
			return;
		}
		$.messager.progress();	// 显示进度条
		var isValid = $("#fm").form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
		if(!isValid){
			$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
			alert( "填写数据不符合规范");
			return;
		}
		$.ajax({
		   type : "POST",
		   url : basePath + "exam/question/saveQuestionInfo",
		   data : fromData,
		   traditional : true,
		   success : function(result){
		   		$.messager.progress('close');// 隐藏进度条  
		   		result = eval('(' + result + ')');
			 	if (result.code == '0'){
			 		$.messager.alert('提示','保存成功！','info',function(){
						  closeAndRefreshWindow();
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
		   }
		}); 
	}
	
	// 获取表单数据
	function getFormData() {
		var isAnswers; // 是否答案
		var dataSort; // 试题选项排序
		var v_type = $("#qsnInfoType").combobox('getValue');
		// 如果是选择题或判断题，获取选择结果
		if (v_type == "1" || v_type == "2" || v_type == "3") {
			isAnswers = getDataIsanswerStr();
			dataSort = getDataSortStr();
		} else { // 默认全部是答案（非选择题或判断题）
			isAnswers = "1";
		}
		var optiondescArr = getOptiondescArr(); // 试题选项集合
		var formData = {
			"qsnInfoId" : $("#qsnInfoId").val(), // 试题id
			"qsnInfoTrade" : $("#qsnInfoTrade").combotree('getValues'), // 试题类别
			"qsnInfoType" : $("#qsnInfoType").combobox('getValue'), // 试题类型
			"qsnInfoState" : $("#qsnInfoState").combobox('getValue'), // 试题状态
			"qsnInfoDesc" : CKEDITOR.instances.qsnInfoDesc.getData(), // 试题描述
			"qsnInfoExplain" : CKEDITOR.instances.qsnInfoExplain.getData(), // 试题答案解析
			"aae013" : $("#aae013").val(), // 备注
			"isanswersStr" : isAnswers, // 是否答案
			"optionsStr" : getDataOptionStr(), // 试题选项
			"qsnDataOptiondescArr" : optiondescArr, // 试题选项描述
			"qsnDataSort" : dataSort // 试题选项排序
		};
		return formData;
	}
	
	// 获取选项选择结果字符串
	function getDataIsanswerStr() {
		var isAnswers = $("input[name='isanswer']");
		var isAnswersArr = [];
		for (var i = 0; i < isAnswers.length; i++) {
			if (isAnswers[i].checked) { // 选中状态
				isAnswersArr.push(1); 
			} else {
				isAnswersArr.push(0);
			}
		}
		return isAnswersArr.join(",");
	}
	// 获取选项字符串
	function getDataOptionStr() {
		var options = $("span[name='qsnDataOption']");
		var optionsArr = [];
		for (var i = 0; i < options.length; i++) {
			optionsArr.push(options[i].firstChild.data);
		}
		if (optionsArr.length == 0) {
			return "";
		}
		return optionsArr.join(",");
	}
	// 获取选项排序字符串
	function getDataSortStr() {
		var sorts = $("input[name='qsnDataSort']");
		var sortsArr = [];
		for (var i = 0; i < sorts.length; i++) {
			if (!sorts[i].value) {
				sortsArr.push(i + 1);
			} else {
				sortsArr.push(sorts[i].value);
			}
		}
		return sortsArr.join(",");
	}
	// 获取选项描述数组
	function getOptiondescArr() {
		var optiondescArr = []; // 试题选项集合
		var v_type = $("#qsnInfoType").combobox('getValue');
		if (v_type == "4") { // 填空题
			// 试题选项描述
			var desc = $("input[name='qsnDataOptiondesc']");
			for(var i = 0; i < desc.length; i++){
				optiondescArr.push(desc[i].value);
			}
		} else if (v_type == "3") { // 判断题
			// 试题选项描述
			var desc = $("span[name='qsnDataOptiondesc']");
			for(var i = 0; i < desc.length; i++){
				optiondescArr.push(desc[i].firstChild.data);
			}
		} else {
			// 试题选项描述
			var ckeditor = $("textarea[name='qsnDataOptiondesc']");
			for(var i = 0; i < ckeditor.length; i++){
				optiondescArr.push(CKEDITOR.instances[ckeditor[i].id].getData());
			}
		}
		return optiondescArr;
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: auto;" border="false">
        	<form id="fm" method="post" >	
        		<input id="qsnInfoId" name="qsnInfoId" type="hidden" value="<%=v_qsnInfoId%>"/>
        		<sicp3:groupbox title="试题属性">
        			试题知识点：<input id="qsnInfoTrade" name="qsnInfoTrade" class="easyui-combotree" style="width: 200px;"/>
				</sicp3:groupbox>
				<sicp3:groupbox title="试题数据">
        			试题类型：<input id="qsnInfoType" name="qsnInfoType" style="width: 200px;"/>
        			试题状态：<input id="qsnInfoState" name="qsnInfoState" style="width: 200px;"/>
				</sicp3:groupbox>
				<sicp3:groupbox title="试题描述">
        			<div style="overflow: auto;">
			        	<textarea class="ckeditor" name="qsnInfoDesc" id="qsnInfoDesc"></textarea>
					</div>
				</sicp3:groupbox>
				<%-- <div id="pointsRule" style="display: none;">
					<sicp3:groupbox title="判分选项">
	        			<span>
	        				<input id="pointStyle" name="pointStyle" style="width: 150px;"/>
	        				说明：答对一个空给一个空的分，答错的不给分。
	        				<input id="diffOrder" name="diffOrder" style="width: 150px;"/>
	        				说明：此选项针对如：“中国由_____等34个省组成”情况
	        				<input id="diffCase" name="diffCase" style="width: 150px;"/>
	        			</span>
					</sicp3:groupbox>
				</div> --%>
				<sicp3:groupbox title="试题选项">
					<a href="javascript:void(0)" class="easyui-linkbutton" id="addOptionBtn"
						iconCls="icon-add" plain="true">增加</a>
					<div id="optionsWarpper"></div>
				</sicp3:groupbox>
				<sicp3:groupbox title="答案解析">
        			<div style="overflow: auto;">
			        	<textarea class="ckeditor" name="qsnInfoExplain" id="qsnInfoExplain"></textarea>
					</div><br>
					备注：<input id="aae013" name="aae013" style="width: 880px;"/>
				</sicp3:groupbox>
			</form>
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="saveQustionInfo()" id="btnSave">保存 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-undo" onclick="closeAndRefreshWindow()" id="btnUndo">取消</a>
	        </div>
		</div>
	</div>
</body>
</html>