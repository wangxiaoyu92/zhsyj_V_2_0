<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>检验检测统计图表</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include> 
<!-- 引入jscharts的js文件 -->
<script type="text/javascript" src="<%=contextPath%>/jslib/echarts/echarts.js"></script> 
<script type="text/javascript">
	//检测检验类别
	var v_jcjylb= <%=SysmanageUtil.getAa10toJsonArray("JCJYLB")%>;
	$(function() {
		//检测检验类别
		v_jcjylb= $('#jcjylb').combobox({
	    	data : v_jcjylb,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	});
	
	$(function(){
		//基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('chartcontainer'));
		$("#search").click(function(){
			var start = $("#startTime").datebox("getValue");
			var end = $("#endTime").datebox("getValue");
			myChart.clear;  //第二次请求时清除当前生成的图表
			if(start!="" && end!=""){
				if(start>end){
					//alert("开始日期应小于结束日期！");
					$.messager.alert("警告","开始日期应小于结束日期！");   
					return;
				}
			}
			myChart.showLoading();  //显示加载动画，用于网速不好的友好显示
				$.ajax({
					url: basePath+"jyjc/queryJyjctjtb",
					data: {
							startTime:start,
							endTime:end,
							jcjylb :$("#jcjylb").combobox('getValue')
							},
					type:'post',
					dataType:'json',
					success:function(result){
						var x_arr = [];
						var y_arr = [];
						for (var i = 0; i < result.rows.length; i++) {
							x_arr.push(result.rows[i].jyjcsc);
							y_arr.push(result.rows[i].hgl);
						}
				        // 指定图表的配置项和数据
				        var option = {
				        		//backgroundColor: '#2c343c',
				            title: {
				                text: '检验检测合格率'
				            },
				            tooltip: {
				            	trigger: 'axis',
				                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
				                    type : 'shadow'       // 默认为直线，可选为：'line' | 'shadow'
				                }
				            },
				            grid: {
				            	left: '8%',
				                //right: '4%',
				                //bottom: '3%',
				                top :'15%'
				            },
				            legend: {
				                data:['合格率']
				            },
				            xAxis: {
				            	type : 'category',
				                //splitLine: {show:false},
				                data: x_arr
				            },
				            yAxis: {
				            	type: 'value'
				            },
				            series: [{
				                name: '合格率',
				                //barWidth : 60  指定横轴宽
				                type:  $("#type").val(),
				                data: y_arr,
				                markLine : {
				                    lineStyle: {
				                        normal: {
				                            type: 'dashed'
				                        }
				                    }
				            }
				            }]
				        };
				        myChart.hideLoading();   //隐藏加载动画
				        // 使用刚指定的配置项和数据显示图表。
				        myChart.setOption(option);
					},
					error: function () {
						myChart.hideLoading();   //隐藏加载动画
						//alert("系统繁忙，请稍后重试！");
						$.messager.alert("提示","系统繁忙，请稍后重试！");   
	                }
					});
			});
		});
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="统计图表查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>检验检测类别</nobr></td>
						<td><input id="jcjylb" name="jcjylb" style="width: 150px;" class="easyui-combobox"/></td>						
						<!-- <td style="text-align:right;"><nobr>结束时间</nobr></td>
						<td><input id="endTime" name="endTime" style="width:200px" /></td>	 -->
						<td>报表类型:
							<select id="type">
								<option value="bar">柱状图</option>
								<option value="line">线型图</option>
								<option value="pie">饼状图</option>
							</select>
						</td>
						<td style="text-align:right;"><nobr>开始时间</nobr>
						<input id="startTime" name="startTime" style="width: 100px" class="easyui-datebox"/>结束时间
						<input id="endTime" name="endTime" style="width:100px" class="easyui-datebox"/>
						</td>
						<td>
							<input type="button" value="点击生成统计图表" id="search" />
						</td>	
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="统计图表信息">
        		<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
				<div id="chartcontainer" style="width: 700px;height:400px;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>				    
</body>
</html>