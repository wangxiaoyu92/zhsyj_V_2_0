<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() 
		+ ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <!-- 引入 ECharts 文件 -->
    <script src="<%=basePath%>jslib/echarts/echarts_3.0.js"></script>
    <title>区域检查统计</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
   	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<script type="text/javascript">
	$(function() {
		parent.$.messager.progress({ text : '数据加载中....' });
	});
	</script>
</head>
<body>
	<p>年份:<input type="text" id="year" name="year" onchange="ajax_select()"    
  		onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy'})" class="Wdate"   />
	</p>
   	<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
    <div id="container" style="height: 100%"></div>
    <script type="text/javascript">
		var toobars = {
			title : { text : '检查统计', textAlign : 'left' },
		    tooltip : { trigger : 'axis' },
		    legend: { data:[] }, // 动态
		    toolbox: { 
		    	show : false,
		        feature : {
		            dataView : {show: true, readOnly: false},
		            magicType : {show: true, type: ['line', 'bar']},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            data : []//动态
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : []
		};
	    var dom = document.getElementById("container");
	    var myChart = echarts.init(dom);
	    myChart.showLoading({text: "图表数据正在努力加载..."});
		var options = toobars;
		//异步请求
		$.ajax({
            type : "post",
            async : true,
            url : "<%=basePath%>/supervision/checkPalnresultReport/getAreaReportPlanEcharts",
            dataType : "json",
            success : function (result) {
				if (result.code == 0) {
                	$('#year').val(result.year);
               		var data = result.data;
                    options.xAxis[0].data = eval(data.category);
                    options.series = eval(data.series);
                    options.legend.data = eval(data.legend);
                    myChart.hideLoading();
                    myChart.setOption(options);
                    parent.$.messager.progress('close');
                }
            },
            error: function (errorMsg) { 
                alert("图表请求数据失败啦!");
            }
        });

		function ajax_select(){
			var dom = document.getElementById("container");
		 	$("#container").empty();
		 	var myChart = echarts.init(dom);
		 	myChart.showLoading({text: "图表数据正在努力加载..."});
		 	var year = $('#year').val();
		 	var options = toobars;
			//异步请求
			$.ajax({
	            type: "post",
	            async: true,
	            url: "<%=basePath%>/supervision/checkPalnresultReport/getAreaReportPlanEcharts",
	            dataType: "json",
	            data:{ checkyear : year },
	            success: function (result) {
                	if(result.code == 0){
                		var data = result.data;
	                    options.xAxis[0].data = eval(data.category);
	                    options.series = eval(data.series);
	                    options.legend.data = eval(data.legend);
	                    myChart.hideLoading();
	                    myChart.setOption(options);
                     
                	}
            	},
	            error: function (errorMsg) {
	                alert("图表请求数据失败啦!");
	            }
        	});
		}
	</script>
</body>
</html>
