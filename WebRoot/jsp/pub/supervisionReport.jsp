<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <!-- 引入 ECharts 文件 -->
    <script src="<%=basePath%>jslib/jquery-1.9.1.js"></script>
    <script src="<%=basePath%>jslib/echarts/echarts_3.0.js"></script>
    <script src="<%=contextPath%>/jslib/jquery.json-2.4.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=contextPath%>/jslib/bootstrap-3.3.5/css/bootstrap.min.css" type="text/css">
    <script type="text/javascript" src="<%=contextPath%>/jslib/bootstrap-3.3.5/js/bootstrap.min.js"></script>

    <title>统计信息</title>
</head>

<body class="devpreview sourcepreview" style="min-height: 347px; cursor: auto; width: 100%;">
<div class="container">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th style="vertical-align:middle;text-align:center;">各乡所量化检查信息</th>
            </tr>
        </thead>
    </table>
    <table class="table table-bordered">
        <tbody>
            <tr class="warning">
                <td style="text-align: right;">查询年份</td>
                <td><input type="text" id="year" name="year" style="width: 80%;"
                           onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy'})"   class="Wdate"   />
                </td>
                <td><a href="javascript:void(0)" class="easyui-linkbutton"
                       iconCls="icon-search" onclick="query()"> 查 询 </a>
                </button>
                </td>
            </tr>
        </tbody>
    </table>
    <div class="jumbotron">
        <div class="row">
            <div id="containerDiv" style="height: 50%;"></div>
        </div>
    </div>
    <table class="table table-bordered">
        <thead>
        <tr class="success">
            <th style="vertical-align:middle;text-align:center;">各区域企业检查信息</th>
        </tr>
        </thead>
    </table>
    <table class="table table-bordered">
        <tbody>
        <tr class="warning">
            <td style="text-align: right;">查询年份</td>
            <td><input type="text" id="year2" name="year" style="width: 80%;"
                       onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy'})"   class="Wdate"   />
            </td>
            <td><a href="javascript:void(0)" class="easyui-linkbutton"
                   iconCls="icon-search" onclick="query2()"> 查 询 </a>
                </button>
            </td>
        </tr>
        </tbody>
    </table>
    <div class="jumbotron">
        <div class="row">
            <div id="containerDiv2" style="height: 50%;"></div>
        </div>
    </div>
    <script type="text/javascript">
        var toobars = {
            title : {
                text: '各乡所量化与检查'
            },
            tooltip : {trigger: 'axis'},
            legend: { data:[] }, //动态
            toolbox: {show : true,
                feature : {
                    dataView : {show: true, readOnly: false},
                    magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
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
        var dom = document.getElementById("containerDiv");
        var myChart = echarts.init(dom);
        myChart.showLoading({text: "图表数据正在努力加载..."});
        var options = toobars;
        $.ajax({
            type: "post",
            async: true,
            url: "<%=basePath%>api/supervision/getLhAndSupervisionEcharts",
            dataType: "json",
            success: function (result) {
                if(result.code == 0){
                    $('#year').val(result.year);
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

        function query(time){
            var dom = document.getElementById("containerDiv");
            $("#containerDiv").empty();
            var myChart = echarts.init(dom);
            myChart.showLoading({text: "图表数据正在努力加载..."});
            var year = $('#year').val();
            var options = toobars;
            //异步请求
            $.ajax({
                type: "post",
                async: true,
                url: "<%=basePath%>api/supervision/getLhAndSupervisionEcharts",
                dataType: "json",
                data:{ 'checkyear' : year },
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

        var toobars2 = {
            tooltip : {trigger: 'axis'},
            legend: { data:[] }, //动态
            toolbox: {show : true,
                feature : {
                    dataView : {show: true, readOnly: false},
                    magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
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
        var dom2 = document.getElementById("containerDiv2");
        var myChart2 = echarts.init(dom2);
        myChart2.showLoading({text: "图表数据正在努力加载..."});
        var options2 = toobars2;
        $.ajax({
            type: "post",
            async: true,
            url: "<%=basePath%>api/supervision/getComdaleiOfAaa027Echarts",
            dataType: "json",
            success: function (result) {
                if(result.code == 0){
                    $('#year2').val(result.year);
                    var data = result.data;
                    options2.xAxis[0].data = eval(data.category);
                    options2.series = eval(data.series);
                    options2.legend.data = eval(data.legend);
                    myChart2.hideLoading();
                    myChart2.setOption(options2);
                }
            },
            error: function (errorMsg) {
                alert("图表请求数据失败啦!");
            }
        });
        function query2(time){
            var dom = document.getElementById("containerDiv2");
            $("#containerDiv2").empty();
            var myChart = echarts.init(dom);
            myChart.showLoading({text: "图表数据正在努力加载..."});
            var year = $('#year2').val();
            var options = toobars2;
            //异步请求
            $.ajax({
                type: "post",
                async: true,
                url: "<%=basePath%>api/supervision/getComdaleiOfAaa027Echarts",
                dataType: "json",
                data:{ 'checkyear' : year },
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
</div>
</body>
</html>
