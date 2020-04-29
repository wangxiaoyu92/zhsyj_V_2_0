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
        var layer;
        var laydate;
        var myChart = null;
        $(function() {
            layui.use(['laydate','layer'],function(){
                laydate = layui.laydate;
                layer=layui.layer;
                laydate.render({
                    elem: '#sqjctjstdate'
                });
                laydate.render({
                    elem: '#sqjctjeddate'
                });
            });
            // 基于准备好的dom，初始化echarts实例
            myChart = echarts.init(document.getElementById('main'));

            reqData(myChart,basePath + '/jyjc/ndwjypCount',"检测样品统计");
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
                    orient: 'horizontal',
                    x: 'center',
                    y:'40px',
                    data: nameArray
                },
                series : [
                    {
                        name: name,
                        type: 'pie',
                        radius : '60%',
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
        function query(){
            var sqjctjstdate = $('#sqjctjstdate').val();
            var sqjctjeddate = $('#sqjctjeddate').val();
            if(sqjctjstdate && sqjctjeddate){
                if(sqjctjstdate>=sqjctjeddate){
                    layer.alert('开始时间必须小于结束时间');
                    return false;
                }
            }

            var param = {
                'sqjctjstdate': sqjctjstdate,
                'sqjctjeddate': sqjctjeddate
            };
            var url=basePath + '/jyjc/ndwjypCount';
            var name="检测样品统计";
            var chart=myChart;
            $.post(url,param,
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
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <div class="layui-colla-content layui-show">
                <div class="layui-form-item" style="top: 100px">
                    <label class="layui-form-label">检查开始时间:</label>

                    <div class="layui-input-inline">
                        <input type="text" id="sqjctjstdate" name="sqjctjstdate" autocomplete="off" class="layui-input"/>
                    </div>
                    <div class="layui-form-mid">--</div>
                    <div class="layui-input-inline">
                        <input type="text" id="sqjctjeddate" name="sqjctjeddate" autocomplete="off" class="layui-input"/>
                    </div>
                    <a id="query" href="javascript:void(0)" class="layui-btn" onclick="query()">查询</a>
                </div>
            </div>
        </div>
    </div>
    <!-- 为 ECharts 准备一个具备大小（宽高）的Dom -->
    <div id="main" style="float:left;width: 1000px;height:400px;display:inline;"></div>
</div>

</body>
</html>
