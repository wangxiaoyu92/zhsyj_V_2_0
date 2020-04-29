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
<title>执法办案分析统计</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath %>/jslib/echarts/echarts.min3.js"></script>
<script type="text/javascript">

		var ajdjChart = null; // 案件登记受理情况分析
		var ajdjByDaleiChart = null; // 案件登记大类统计分析
		var ajdjComDalei = null; // 企业分类案件登记情况分析
		var ajdjAaa027 = null; // 案件登记统筹区统计分析
		$(function() {
			// 基于准备好的dom，初始化echarts实例
			ajdjChart = echarts.init(document.getElementById('ajdjmain'));
			reqData(ajdjChart, basePath + 'zfba/ajdj/ajdjtjCount', "执法办案受理情况统计");
			
			ajdjByDaleiChart = echarts.init(document.getElementById('ajdjfenlei'));
			reqData(ajdjByDaleiChart, basePath + 'zfba/ajdj/ajdjtjByDaleiCount', "执法办案分类情况统计");
			
			ajdjComDalei = echarts.init(document.getElementById('ajdjcomfenlei'));
			reqData(ajdjComDalei, basePath + 'zfba/ajdj/ajdjtjByComDaleiCount', "企业分类案件情况统计");
			ajdjComDalei.setOption({legend:{show:false}});
			
			ajdjAaa027 = echarts.init(document.getElementById('ajdjaaa027'));
			reqData(ajdjAaa027, basePath + 'zfba/ajdj/ajdjtjByAaa027Count', "各地区执法办案情况统计");
			ajdjAaa027.setOption({legend:{show:false}});
		});
		
		function innitConfig(chart, data, name){
		 	var nameArray = new Array();
		 	
			for(var i = 0; i < data.length; i++){
				nameArray.push(data[i].name);
			}
			
			// 指定图表的配置项和数据
		    var option = {
		        title : {
		            text : name,
		            subtext : '',
		            x : 'center'
		        },
		        tooltip : {
		            trigger : 'item',
		            formatter : "{a} <br/>{b} : {c} ({d}%)"
		        },
		        legend : {
		            orient : 'vertical',
		            left : 'left',
		            data : nameArray
		        },
		        toolbox : {
			        show : true,
			        feature : {
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
		        series : [
		            {
		                name : name,
		                type : 'pie',
		                radius : '55%',
		                center : ['50%', '60%'],
		                data : data,
		                itemStyle : {
		                    emphasis : {
		                        shadowBlur : 10,
		                        shadowOffsetX : 0,
		                        shadowColor : 'rgba(0, 0, 0, 0.5)'
		                    }
		                }
		            }
		        ]
		    };
		    // 使用刚指定的配置项和数据显示图表。
		    chart.setOption(option);
		}
		
		
		function reqData(chart, url, name){
			$.post(url, null, 
					function(result) {
						if (result.code == '0') {
							innitConfig(chart, result.rows, name);
						} else {
							parent.$.messager.alert('提示', '查询失败：' + result.msg,'error');
			            }	
						parent.$.messager.progress('close');
					}, 'json');
		}
</script>
</head>
  
<body>
	<div id="ajdjmain" style="float:left;width: 500px;height:400px;display:inline;"></div>
	<div id="ajdjfenlei" style="float:left;width: 500px;height:400px;display:inline;"></div>
	<br/>
	<div id="ajdjcomfenlei" style="float:left;width: 500px;height:400px;display:inline;"></div>
	<div id="ajdjaaa027" style="float:left;width: 500px;height:400px;display:inline;"></div>
</body>
</html>
