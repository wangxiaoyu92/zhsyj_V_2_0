<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <!-- 引入 ECharts 文件 -->
    <script src="<%=basePath%>jslib/echarts/echarts_3.0.js"></script>
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
<script>
var v_slbz = <%=SysmanageUtil.getAa10toJsonArray("slbz")%>;
var v_ajjsbz = [{"id":"","text":"==请选择=="},{"id":"0","text":"否"},{"id":"1","text":"是"}];
  	// 基于准备好的dom，初始化echarts实例
	$(function() {
		$('#slbz').combobox({
	    	data : v_slbz,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto',
	        onSelect: function(rec){    
	            ajax_select();    
        	} 
	    });
	    $('#ajjsbz').combobox({
	    	data : v_ajjsbz,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto', 
	        onSelect: function(rec){    
	            ajax_select();    
        	}
	    });
	});
</script>
</head>
<body>
	<div align="center" style="width: 100%; height: 10%; margin-top: 10px; ">
		<p>案件受理标记:<input id="slbz" name="slbz" style="width: 200px; margin-right: 300px;"/>
	                   案件结束标记:<input id="ajjsbz" name="ajjsbz" style="width: 200px"/> 
	    </p>
   </div>
<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
	<div id="container" style="height: 90%"></div>
    	<script type="text/javascript">
     	var dom = document.getElementById("container");
    	var myChart = echarts.init(dom);
    	myChart.showLoading({text: "图表数据正在努力加载..."});
		var options = {
    		title : {
        		text: '执法办案案件情况统计',
        		textAlign:'left'
    		},
    		tooltip : {
        		trigger: 'axis'
		    },
		    legend: {
		        data:[]//动态
		    },
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
		//异步请求
		$.ajax({
            type : "post",
            async : true,
            url : "<%=basePath%>zfba/ajdj/getEcharts",
            dataType : "json",
            success : function (result) {
                if (result.code == 0) {
                	var data = result.data;
                    options.xAxis[0].data = eval(data.category);
                    options.series = eval(data.series);
                    options.legend.data = eval(data.legend);
                    myChart.hideLoading();
                    myChart.setOption(options);
                    parent.$.messager.progress('close');
                    // 绑定图表点击事件
                    myChart.on('click', function (params) {
			 			var url = basePath + 'jsp/zfba/report/resultList.jsp';
						var dialog = parent.sy.modalDialog({
								title : '查看',
								param : {
									a : new Date().getMilliseconds(),
									aaa027name : params.name,
									slbz : $('#slbz').combobox("getValue"),
									ajjsbz : $('#ajjsbz').combobox("getValue")
								},
								width : 1200,
								height : 600,
								url : url
						},function(dialogID) {
						    sy.removeWinRet(dialogID);//不可缺少
						});
					});
                }
            },
            error: function (errorMsg) {
                alert("图表请求数据失败啦!");
            }
        });
        // 根据选择条件，重新加载图表数据
		function ajax_select(){
			var slbz = $('#slbz').combobox("getValue"); // 受理标识
			var ajjsbz = $('#ajjsbz').combobox("getValue"); // 案件结束标识
			myChart.showLoading({text: "图表数据正在努力加载..."});
			//异步请求
			$.ajax({
            	type : "post",
            	async : true,
            	url : "<%=basePath%>zfba/ajdj/getEcharts",
            	dataType : "json",
            	data : {slbz : slbz, ajjsbz : ajjsbz},
            	success : function (result) {
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
