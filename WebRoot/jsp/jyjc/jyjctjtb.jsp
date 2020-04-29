<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测统计图表</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript" src="<%=contextPath%>/jslib/echarts/echarts.js"></script>
    <script type="text/javascript">
        //检测检验类别
        var v_jcjylb = <%=SysmanageUtil.getAa10toJsonArray("JCJYLB")%>;
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        var mask;//进度条
        $(function () {
            layui.use(['form', 'table', 'layer', 'element', 'laydate'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#startTime'
                });
                laydate.render({
                    elem: '#endTime'
                });
//                table.render();

            });
            intSelectData('jcjylb', v_jcjylb);
        })
        $(function () {
            //基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('chartcontainer'));
            $("#search").click(function () {
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                var start = $("#startTime").val();
                var end = $("#endTime").val();
                myChart.clear;  //第二次请求时清除当前生成的图表
                if (start != "" && end != "") {
                    if (start > end) {
                        //alert("开始日期应小于结束日期！");
                        layer.msg("开始日期应小于结束日期！");
                        return;
                    }
                }
//                myChart.showLoading();  //显示加载动画，用于网速不好的友好显示
                $.ajax({
                    url: basePath + "jyjc/queryJyjctjtb",
                    data: {
                        startTime: start,
                        endTime: end,
                        jcjylb: $("#jcjylb option:selected").val()
                    },
                    type: 'post',
                    dataType: 'json',
                    success: function (result) {
                        layer.close(mask);
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
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'       // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            grid: {
                                left: '8%',
                                //right: '4%',
                                //bottom: '3%',
                                top: '15%'
                            },
                            legend: {
                                data: ['合格率']
                            },
                            xAxis: {
                                type: 'category',
                                //splitLine: {show:false},
                                data: x_arr
                            },
                            yAxis: {
                                type: 'value'
                            },
                            series: [{
                                name: '合格率',
                                //barWidth : 60  指定横轴宽
                                type: $("#type").val(),
                                data: y_arr,
                                markLine: {
                                    lineStyle: {
                                        normal: {
                                            type: 'dashed'
                                        }
                                    }
                                }
                            }]
                        };
                        //隐藏加载动画
                        // 使用刚指定的配置项和数据显示图表。
                        myChart.setOption(option);
                    },
                    error: function () {
                        layer.close(mask);
                        myChart.hideLoading();   //隐藏加载动画
                        //alert("系统繁忙，请稍后重试！");
                        $.messager.alert("提示", "系统繁忙，请稍后重试！");
                    }
                });
            });
        });
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">统计表查询条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 100px">检验检测类别：</label>

                                    <div class="layui-input-inline">
                                        <select id="jcjylb" name="jcjylb">

                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 100px">报表类型：</label>

                                    <div class="layui-input-inline">
                                        <select id="type" name="type">
                                            <option value="bar">柱状图</option>
                                            <option value="line">线型图</option>
                                            <option value="pie">饼状图</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 100px">开始时间:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="startTime" name="startTime"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 100px">结束时间:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="endTime" name="endTime"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm8 layui-col-md-offset4 layui-col-xs-offset0 layui-col-sm-offset2">
                                <div class="layui-form-item">
                                    <div class="layui-input-inline">
                                        <button type="button" class="layui-btn" value="点击生成统计图表" id="search">点击生成统计图表
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%--<table class="layui-hide" id="jyjcsjcxTable" lay-filter="tableFilter">--%>
    <%--&lt;%&ndash;&lt;%&ndash;<input type="hidden" id="jcjgid" name="jcjgid">&ndash;%&gt;&ndash;%&gt;--%>
    <%--&lt;%&ndash;<input type="hidden" id="comid" name="comid">&ndash;%&gt;--%>
    <%--</table>--%>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div class="layui-row">
        <div class="layui-col-md8 layui-col-xs8 layui-col-sm8 layui-col-md-offset2 layui-col-xs-offset2 layui-col-sm-offset2">
            <div id="chartcontainer" style="width: auto;height:400px;"></div>
        </div>
    </div>
</div>
</body>
</html>