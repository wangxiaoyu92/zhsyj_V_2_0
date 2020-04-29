<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>统计</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath %>/jslib/echarts/echarts.min3.js"></script>
<script type="text/javascript">

		var myChart = null;
		var myChart2 = null;
		$(function() {
			// 基于准备好的dom，初始化echarts实例
			myChart = echarts.init(document.getElementById('main'));
			
			reqData(myChart,basePath + '/supervision/checkinfo/xxzttjfxCount',"执法办案");
			myChart2 = echarts.init(document.getElementById('main2'));
			reqData(myChart2,basePath + '/supervision/checkinfo/aqjgCount',"安全监管");
		});
		
		function innitConfig(chart,data,name){
		 	var nameArray = new Array();
		 	
			for(var i=0;i<data.length;i++){
				nameArray.push(data[i].name);
			}
			
			// 指定图表的配置项和数据
		    var option = {
		        title : {
		            text: name,
		            subtext: '',
		            x:'center'
		        },
		        tooltip : {
		            trigger: 'item',
		            formatter: "{a} <br/>{b} : {c} ({d}%)"
		        },
		        legend: {
		            orient: 'vertical',
		            left: 'left',
		            data: nameArray
		        },
		        series : [
		            {
		                name: name,
		                type: 'pie',
		                radius : '55%',
		                center: ['50%', '60%'],
		                data:data,
		                itemStyle: {
		                    emphasis: {
		                        shadowBlur: 10,
		                        shadowOffsetX: 0,
		                        shadowColor: 'rgba(0, 0, 0, 0.5)'
		                    }
		                }
		            }
		        ]
		    };
		    // 使用刚指定的配置项和数据显示图表。
		    chart.setOption(option);
		}
		
		
		function reqData(chart,url,name){
			$.post(url,null, 
					function(result) {
						if (result.code=='0') {
							innitConfig(chart,result.rows,name);
						} else {
							parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
			            }	
						parent.$.messager.progress('close');
					}, 'json');
		}
</script>
</head>
  
<body>
  	<!-- 为 ECharts 准备一个具备大小（宽高）的Dom -->
	<div id="main" style="float:left;width: 600px;height:400px;display:inline;"></div>

	<div id="main2" style="float:left;width: 600px;height:400px;display:inline;"></div>

</body>
</html>
