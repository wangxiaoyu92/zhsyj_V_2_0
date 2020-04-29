<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.utils.DateUtil" %>
<%@ page import="com.zzhdsoft.siweb.service.workflow.WorkflowService" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));	
	String getCurYear = StringHelper.showNull2Empty(request.getParameter("getCurYear"));
	if("".equals(getCurYear)){
		getCurYear = String.valueOf(DateUtil.getCurrentYear());	
	}	
	WorkflowService workflowService = new WorkflowService();
	boolean haveCurYearData = workflowService.isExistsWfworkday(getCurYear);
	String workdays = workflowService.getWorkdayByYear(getCurYear);
System.out.println("workdays "+workdays);	
%>
<!DOCTYPE html>
<html>
<head>
<base target='_self'/>
<title>工作日设置</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<link rel="stylesheet" href="jquery-ui-1.10.2.custom.min.css" />
<script type="text/javascript" src="jquery-ui-1.10.2.custom.min.js"></script>
<style>
body {
	background-color: rgb(243, 243, 243);
	list-style: none; margin: 0px; padding: 0px; font-family: 宋体; font-size: 12px; text-decoration: none;
}

/*覆盖默认的datepicker样式*/
.ui-datepicker-inline{
	width: 288px;
}
.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default{
    font-weight: normal;
    height: 30px;
    line-height: 30px;
}
.ui-widget-content .ui-dialog-titlebar-close{
	height: 16px;
}
.calendar td a{
	font-size: 12px;
	text-align: center;
}
.calendar .hasData a{
	background: url(calendarTd.png) center center transparent no-repeat;
}
.calendar .hasNoData a{
	/*background: url(one_circle.gif) center center transparent no-repeat;*/
}
</style>
<script type="text/javascript">
	var s = new Object();
	s.type = "ng";
	sy.setWinRet(s);
	var op = '<%=op %>';
	var getCurYear = '<%=getCurYear %>';
	var haveCurYearData = '<%=haveCurYearData %>';
	var curr_workdays = '<%=workdays%>';
	var curr_workdaysArr = curr_workdays.split(',');
	var layer; // 弹出层
	// 模态窗口中打开新窗口
	function go_to(url){
		window.location.href=url;
		//document.getElementById('goLocation').href = url;
		//document.getElementById('goLocation').click();
	}



$(function() {
	layui.use(['layer'], function(){
		layer = layui.layer;
	});
	//每次进入界面重新选择
	document.getElementById("restOneToFive").value = '';
	document.getElementById("workSixToSun").value = '';
	document.getElementById("oworkday").value = '';
	//工作日（周一至周五）
	var oworkday = document.getElementById("oworkday");
	//得到今年最后一个工作日（1-5）
	var oget12lastFive = get12lastFive();	
	var oarray = new Array(); 
	var global_now_year = getCurYear;
	$("#todayYear").html(getCurYear);	
	 
	//计算某年、某月的天数
	function calCountday(curYear, curMonth) {
		var dayCount = 30;
		switch (curMonth) {
		case 1:
			//大月31天 
			dayCount = 31;
			break;
		case 3:
			dayCount = 31;
			break;
		case 5:
			dayCount = 31;
			break;
		case 7:
			dayCount = 31;
			break;
		case 8:
			dayCount = 31;
			break;
		case 10:
			dayCount = 31;
			break;
		case 12:
			dayCount = 31;
			break;
		case 4:
			//小月30天 
			dayCount = 30;
			break;
		case 6:
			dayCount = 30;
			break;
		case 9:
			dayCount = 30;
			break;
		case 11:
			dayCount = 30;
			break;
		case 2:
			//2月特殊判断处理 
			//判断闰年：能被400整除，或者能被4整除而不能被100整除。
			if (0 == curYear % 4) {
				if (0 != curYear % 100) { //闰年2月29天 
					dayCount = 29;
				} else {
					dayCount = 28; //平年2月28天
				}
			} else if (0 == curYear % 400) {
				dayCount = 29;
			} else {
				dayCount = 28;
			}
			break;
		}
		return dayCount;
	}

	
	//得到今年最后一个工作日（1-5）
	function get12lastFive() {
		var ofive = "";
		var i = 1;
		for (i = 24; i <= 31; i++) {
			var dateText = getCurYear + '-12-' + getfillZero(i);
			var ogetdate = new Date(Date.parse(dateText.replace(/-/g, "/"))).getDay();
			if (ogetdate >= 1) {
				if (ogetdate <= 5) {
					ofive += dateText + ",";
				}
			}
		}
		ofive = ofive.substring(0, ofive.lastIndexOf(","));
		ofive = ofive.substring(ofive.lastIndexOf(",") + 1, ofive.length);
		return ofive;
	}
	
	
	//小于10的补零
	function getfillZero(text) {
		if (text < 10) {
			return "0" + text;
		} else {
			return text;
		}
	}
	
	/**
	* 获取日期数组
	* oinputObj是输入框对象（ID）
	* 得到日期数组
	*/
	function getArrayDate(oinputObj) {
		var arrayrest = oinputObj.value.substring(0, oinputObj.value.lastIndexOf(","));
		var getarrayarrayrest = arrayrest.split(",");
		return getarrayarrayrest;
	}
	
	/**
	* 把日期dateText追加到oinputObj对象中，或者从对象oinputObj中移除dateText
	* oinputObj是输入框对象（ID）
	* dateText是日期文本
	*/
	function f_appendOrRemoveCurrSelectDate(oinputObj, dateText) {
		var flag;
		if (typeof(oinputObj) != undefined) {
			flag = oinputObj.value.indexOf(dateText);
		}
		if (flag != undefined) {
			if (flag == -1) { //oinputObj中没有dateText时，追加进去
				var old_obj_val = oinputObj.value;
				if (old_obj_val.indexOf('end') < 0) { //无end
					oinputObj.value = old_obj_val + dateText + ",";
				} else { //有end时，加到end前面
					oinputObj.value = old_obj_val.substr(0, old_obj_val.indexOf('end')) + dateText 
						+ old_obj_val.substr(old_obj_val.indexOf('end') - 1, old_obj_val.length); // old_obj_val.+dateText+",";
				}
			} else { //已有时移除
				var clickText = dateText + ","; //再次点击时去掉
				var text = oinputObj.value.replace(clickText, "");
				oinputObj.value = text;
			}
		}
	}

	if(op=='update'){
		//工作日（周一至周五）
		var oworkday = document.getElementById("oworkday");
		oworkday.value = curr_workdays + "end";
	}
	/*############################初始化一年12个月的工作日#################################*/
	for (var i = 1; i <= 12; i++) { 
		//月最小日期
		var onewfrom = getCurYear + '-' + getfillZero(i) + '-01'; 
		//月最大日期
		var onewTo = getCurYear + '-' + getfillZero(i) + '-' + calCountday(getCurYear, i);
		if(op=='view'){
			$("#oyearup").attr('disabled',true);
			$("#oyeardown").attr('disabled',true);
			$("#olookup").attr('disabled',true);
			$("#datepicker" + i).datepicker({
				showOn: "button",
				dateFormat: 'yy-mm-dd',
				minDate: onewfrom,
				maxDate: onewTo,
				monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
				dayNamesMin: ['日', '一', '二', '三', '四', '五', '六'],
				beforeShowDay: function(date) { 
				//在日期控件显示面板之前，每个面板上的日期绑定时都触发此事件，参数为触发事件的日期。
				//用函数后，必须返回一个数组：[0]此日期是否可选(true/false)，[1]此日期的CSS样式名称(""表示默认)，[2]当鼠标移至上面出现一段提示的内容。
					var dateText = date.getFullYear() + "-" + getfillZero((date.getMonth() + 1)) 
						+ "-" + getfillZero(date.getDate()); 
					
					//加载时与原来数据库中的工作日比较
					var flag = curr_workdays.indexOf(dateText); //得到是否存在
					if (flag != -1) { //找到子字符串
						return [true, 'hasData', '工作日']; //oarray[1]="ui-state-disabled";
					} else {
						return [true, 'hasNoData', '非工作日']; //oarray[1]="ui-state-default";
					}

					return oarray;
				}
			});
		}
		if(op=='add'){
			$("#datepicker" + i).datepicker({
				showOn: "button",
				dateFormat: 'yy-mm-dd',
				minDate: onewfrom,
				maxDate: onewTo,
				monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
				dayNamesMin: ['日', '一', '二', '三', '四', '五', '六'],
				beforeShowDay: function(date) { 
				//在日期控件显示面板之前，每个面板上的日期绑定时都触发此事件，参数为触发事件的日期。用函数后，必须返回一个数组：
				//[0]此日期是否可选(true/false)，[1]此日期的CSS样式名称(""表示默认)，[2]当鼠标移至上面出现一段提示的内容。
					var dateText = date.getFullYear() + "-" + getfillZero((date.getMonth() + 1)) 
						+ "-" + getfillZero(date.getDate()); 
					//得到星期几对应的值：0和6是周日和周六
					var ogetdate = new Date(date).getDay();
					//休息日(周一至周五) 
					var orestOneToFive = document.getElementById("restOneToFive");
					//工作日(周六和周日)   
					var oworkSixToSun = document.getElementById("workSixToSun");
					//工作日（周一至周五）
					var oworkday = document.getElementById("oworkday");
					if (ogetdate >= 1 && ogetdate <= 5) { //是周一到周五
						//得到今年的最后一天
						var year_lastDay = new Date((getCurYear + '-12-' + calCountday(getCurYear, 12)).replace(/-/g, "/")); 
						//得到今年的第一天
						var year_firstDay = new Date((getCurYear + '-01-01').replace(/-/g, "/")); 
						//得到全年
						if (year_firstDay <= date) {
							if (date <= year_lastDay) { //第一天<= 当前天 <=最后一天
								var endFlag = oworkday.value.indexOf("end");
								var flagText = oworkday.value.indexOf(dateText); //工作日 中是否有该日期
								if (flagText == -1) { //没有该日期时，添加到工作日中，以逗号分隔
									if (endFlag == -1) { //且没有到达一年最后的5个工作日
										oworkday.value = oworkday.value + dateText + ",";
									}
									if (dateText == oget12lastFive) { //到达一年最后的5个工作日时末尾加end
										oworkday.value = oworkday.value + "end";
									}
								}
							}
						}
						
						var flag = document.getElementById("oworkday").value.indexOf(dateText); //得到是否存在
						if (flag != -1) { //找到子字符串
							return [true, 'hasData', '工作日']; //oarray[1]="ui-state-disabled";
						} else {
							return [true, 'hasNoData', '非工作日']; //oarray[1]="ui-state-default";
						}
					} else {								
						var flag = document.getElementById("oworkday").value.indexOf(dateText); //得到是否存在
						if (flag != -1) { //找到子字符串
							return [true, 'hasData', '工作日']; //oarray[1]="ui-state-disabled";
						} else {
							return [true, 'hasNoData', '非工作日']; //oarray[1]="ui-state-default";
						}								
					} 
					return oarray;
				},
				beforeShow: function(input) { //在日期控件显示面板之前，触发此事件，并返回当前触发事件的控件的实例对象
				},
				onSelect: function(dateText, inst) { //当在日期面板选中一个日期后触发此事件，参数为选择的日期和当前日期插件的实例
					//计算周几
					var ogetdate = new Date(Date.parse(dateText.replace(/-/g, "/"))).getDay();
					var orestOneToFive = document.getElementById("restOneToFive");
					var oworkSixToSun = document.getElementById("workSixToSun");
					var my_workday = document.getElementById("oworkday"); 
					//周一至周五
					if (ogetdate >= 1 && ogetdate <= 5) { 
						//添加--> 此项是工作日(周一至周五)
						f_appendOrRemoveCurrSelectDate(orestOneToFive, dateText);
					} else { 
						//添加--> 此项是休息日 (周六和周日)
						f_appendOrRemoveCurrSelectDate(oworkSixToSun, dateText);
					} 
					//添加或者移除到工作日
					f_appendOrRemoveCurrSelectDate(my_workday, dateText);
				}
			});
		}
		if(op=='update'){
			$("#datepicker" + i).datepicker({
				showOn: "button",
				dateFormat: 'yy-mm-dd',
				minDate: onewfrom,
				maxDate: onewTo,
				monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
				dayNamesMin: ['日', '一', '二', '三', '四', '五', '六'],
				beforeShowDay: function(date) { 
				//在日期控件显示面板之前，每个面板上的日期绑定时都触发此事件，参数为触发事件的日期。
				//用函数后，必须返回一个数组：[0]此日期是否可选(true/false)，[1]此日期的CSS样式名称(""表示默认)，[2]当鼠标移至上面出现一段提示的内容。
					var dateText = date.getFullYear() + "-" + getfillZero((date.getMonth() + 1)) 
						+ "-" + getfillZero(date.getDate()); 					
					
					//加载时与原来数据库中的工作日比较
					var flag = curr_workdays.indexOf(dateText); //得到是否存在
					if (flag != -1) { //找到子字符串
						return [true, 'hasData', '工作日']; //oarray[1]="ui-state-disabled";
					} else {
						return [true, 'hasNoData', '非工作日']; //oarray[1]="ui-state-default";
					}
				},
				beforeShow: function(input) { //在日期控件显示面板之前，触发此事件，并返回当前触发事件的控件的实例对象
				},
				onSelect: function(dateText, inst) { //当在日期面板选中一个日期后触发此事件，参数为选择的日期和当前日期插件的实例
					//计算周几
					var ogetdate = new Date(Date.parse(dateText.replace(/-/g, "/"))).getDay();
					var orestOneToFive = document.getElementById("restOneToFive");
					var oworkSixToSun = document.getElementById("workSixToSun");
					var my_workday = document.getElementById("oworkday"); 
					//周一至周五
					if (ogetdate >= 1 && ogetdate <= 5) { 
						//添加--> 此项是工作日(周一至周五)
						f_appendOrRemoveCurrSelectDate(orestOneToFive, dateText);
					} else { 
						//添加--> 此项是休息日 (周六和周日)
						f_appendOrRemoveCurrSelectDate(oworkSixToSun, dateText);
					} 
					//添加或者移除到工作日
					f_appendOrRemoveCurrSelectDate(my_workday, dateText);
				}
			});
		}
	}

	//上一年
	$("#oyearup").click(function() {
		$("#oyearup").attr("disabled", true);
		var oyearup = $("#todayYear").html();
		oyearup--;
		$("#todayYear").html(oyearup);
		getCurYear = oyearup; 
		//得到今年的最后一天
		var year_lastDay = getCurYear + '-12-' + calCountday(getCurYear, 12); 
		//得到今年的第一天
		var year_firstDay = getCurYear + '-01-01';
		var url = "wf_workdayForm.jsp?planNo=${planNo}"; 
	    //window.location.href=url+"&yearlastDay="+year_lastDay+"&yearfirstDay="+year_firstDay+"&getCurYear="+getCurYear;
		go_to(url + "&yearlastDay=" + year_lastDay + "&yearfirstDay=" + year_firstDay + "&getCurYear=" + getCurYear);
		getCurYear = '${getCurYear}';
	});
	
	//下一年
	$("#oyeardown").click(function() {
		$("#oyeardown").attr("disabled", true);
		var oyeardown = $("#todayYear").html();
		oyeardown++;
		$("#todayYear").html(oyeardown);
		getCurYear = oyeardown; 
		//得到今年的最后一天
		var year_lastDay = getCurYear + '-12-' + calCountday(getCurYear, 12); 
		//得到今年的第一天
		var year_firstDay = getCurYear + '-01-01';
		var url = "<%=basePath%>jsp/workflowcz/wf_workdayForm.jsp?planNo=${planNo}"; 
		//window.location.href=url+"&yearlastDay="+year_lastDay+"&yearfirstDay="+year_firstDay+"&getCurYear="+getCurYear;
		go_to(url + "&yearlastDay=" + year_lastDay + "&yearfirstDay=" + year_firstDay 
			+ "&getCurYear=" + getCurYear+"&time="+new Date().getMilliseconds());
		getCurYear = '${getCurYear}';
	});
	
	//工作日添加	 
	$("#olookup").click(function() {
		var url;		
		var tipMsg;
		if (haveCurYearData == "true") {
			url = basePath + '/workflow/updateWfworkday';
			tipMsg = '确定要修改【' + global_now_year + '】年度的工作日设置吗？';
		}else{
			url = basePath + '/workflow/addWfworkday';
			tipMsg = '确定要新增【' + global_now_year + '】年度的工作日设置吗？';
		}
		layer.confirm(tipMsg ,function(r) {
			if (r) {
				var osubrestOneToFive = document.getElementById("restOneToFive");
				var osubworkSixToSun = document.getElementById("workSixToSun");
				var osuboworkday = document.getElementById("oworkday"); 				
				$('#new_workday').val(osuboworkday.value);
				var new_workday = $('#new_workday').val(); 
				
				$.post(url, {
					curr_year: global_now_year,					
					new_workday: new_workday			
				},
				function(result) {
					if (result.code == '0') {
						layer.alert('操作成功！','info',function(){
							closeAndRefreshWindow();
		        		}); 
					} else {
						layer.alert( "操作失败：" + result.msg, 'error');
					}
				},
				'json');	
			}
		});	
	});
});

//关闭并刷新父窗口
function closeAndRefreshWindow(){
    s.type = "ok";
	sy.setWinRet(s);
	parent.layer.close(parent.layer.getFrameIndex(window.name));
} 

</script>
</head>
<body>
<div region="center" class="layui-fluid" style="overflow: false; width: 1000px;height: 600px;" border="false">
	<a href="" id="goLocation" style="display:none">不会打开新窗口哦</a>
		<div id="Mns">
			<div class="MnsTbsEdit">
				<div>
				</div>
				<div class="MnsTbsEdit3">

					<!--========重要参数定义======-->
					<div style="display: none">
						<textarea id="new_workday"></textarea>
						<!--此项是工作日(周一至周五) -->
						<input type="text" id="restOneToFive" size="180"
							style="display: none" />
						<!-- 此项是休息日(周六和周日) -->
						<input type="text" id="workSixToSun" size="180"
							style="display: none" />
						<!--周一至周五全年工作日-->
						<textarea rows="10" cols="180" id="oworkday" style="display: none"></textarea>
					</div>

<!-- 					<a href="#" id="oyearup" name="lookup" class="easyui-linkbutton">&lt;&lt;上一年</a> -->
						<span id="todayYear" style="color: #FF0000; font-weight: bold;"></span>
<!-- 					<a href="#" id="oyeardown" name="lookup" class="easyui-linkbutton">下一年&gt;&gt;</a> -->
						&nbsp;&nbsp;&nbsp;&nbsp;
					<button id="olookup" class="layui-btn">保存工作日设置</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
					<button class="layui-btn" onclick="closeAndRefreshWindow()">关闭返回</button>

					<table class="datepicker_table" style="padding: 0 0 0 0" border="0">
						<tr>
							<td>
								<span class="calendar" id="datepicker1"></span>
							</td>
							<td>
								<span class="calendar" id="datepicker2"></span>
							</td>
							<td>
								<span class="calendar" id="datepicker3"></span>
							</td>
							<td>
								<span class="calendar" id="datepicker4"></span>
							</td>
						</tr>
						<tr>
							<td>
								<span class="calendar" id="datepicker5"></span>
							</td>
							<td>
								<span class="calendar" id="datepicker6"></span>
							</td>
							<td>
								<span class="calendar" id="datepicker7"></span>
							</td>
							<td>
								<span class="calendar" id="datepicker8"></span>
							</td>
						</tr>
						<tr>
							<td>
								<span class="calendar" id="datepicker9"></span>
							</td>
							<td>
								<span class="calendar" id="datepicker10"></span>
							</td>
							<td>
								<span class="calendar" id="datepicker11"></span>
							</td>
							<td>
								<span class="calendar" id="datepicker12"></span>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
</div>
</body>
</html>