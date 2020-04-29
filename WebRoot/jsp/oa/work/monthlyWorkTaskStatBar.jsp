<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null==basePath || "".equals(basePath)){
        basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>各科室主月进度统计图</title>
    <link rel="stylesheet" href="<%=contextPath%>/jslib/plib/layui-v2.2.5/css/layui.css" media="all" />
    <script>
        var basthPath = "<%=basePath%>";
        var contextPath = "<%=contextPath%>";
    </script>
    <script src="<%=contextPath%>/jslib/plib/layui-v2.2.5/layui.js" charset="utf-8"></script>

    <script src="<%=contextPath%>/jslib/echarts/echarts.min.4.0.4.js"></script>
    <script src="<%=contextPath%>/jslib/echarts/macarons.4.0.4.js"></script>
    <script src="<%=contextPath%>/jslib/jquery-1.9.1.js"></script>
    <link href="<%=contextPath%>/jslib/plib/kit_admin/build/css/font/iconfont.css"/>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <%--<link rel="stylesheet" href="//res.layui.com/layui/dist/css/layui.css"  media="all">--%>
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
    <style>


        @font-face {font-family: "iconfont";
            src: url('<%=contextPath%>/jslib/plib/kit_admin/build/css/font/iconfont.eot'); /* IE9*/
            src: url('<%=contextPath%>/jslib/plib/kit_admin/build/css/font/iconfont.eot#iefix') format('embedded-opentype'), /* IE6-IE8 */
            url('<%=contextPath%>/jslib/plib/kit_admin/build/css/font/iconfont.woff') format('woff'), /* chrome, firefox */
            url('<%=contextPath%>/jslib/plib/kit_admin/build/css/font/iconfont.ttf') format('truetype'), /* chrome, firefox, opera, Safari, Android, iOS 4.2+*/
            url('<%=contextPath%>/jslib/plib/kit_admin/build/css/font/iconfont.svg#iconfont') format('svg'); /* iOS 4.1- */
        }

        .iconfont {
            font-family:"iconfont" !important;
            font-size:35px;
            font-style:normal;
            -webkit-font-smoothing: antialiased;
            -webkit-text-stroke-width: 0.2px;
            -moz-osx-font-smoothing: grayscale;
        }

        .iconfont2 {
            font-family:"iconfont" !important;
            font-size:18px;
            font-style:normal;
            -webkit-font-smoothing: antialiased;
            -webkit-text-stroke-width: 0.2px;
            -moz-osx-font-smoothing: grayscale;
        }

        .signal-font {
            font-family:"iconfont" !important;
            font-size:25px;
            font-style:normal;
            -webkit-font-smoothing: antialiased;
            -webkit-text-stroke-width: 0.2px;
            -moz-osx-font-smoothing: grayscale;
        }
        /* æ …æ ¼ç¤ºä¾‹ */
        .grid-demo{padding: 10px;text-align: center; background-color: #ffffff; color: #000;}
        .grid-demo1 {padding: 10px; height: 110px; text-align: center; background-color: #ffffff; color: #000;}
        .grid-demo2 {text-align: center; background-color: #ffffff; color: #000;}
        .grid-demo2 div {text-align: center; background-color: #ffffff; color: #000;}
        .grid-line {text-align: center; background-color: #ffffff; color: #000;height: 51.3px}
        .grid-line2 {text-align: center; background-color: #ffffff; color: #000;height: 51.3px}
        .grid-line3 {text-align: center; background-color: #ffffff; color: #000;height: 51.3px}
        .grid-title {text-align: center; background-color: #ffffff; color: #000;height: 66px;fill-opacity: 0.1}
        .title {padding: 10px; line-height: 30px; text-align: left; background-color: #ffffff;     font-size: 15px;
            color: #393939;
            font-weight: 700;}

    </style>
</head>
<body>
    <div class="layui-fluid">
        </div>
        <div id="monthStickState" class="layui-col-md12 grid-demo2" style="height: 600px;">


        </div>
        <div id="monthOrgSumStickState" class="layui-col-md12 grid-demo2" style="height: 300px;">


        </div>
    </div>

    <script src="<%=contextPath%>/jslib/plib/layui-v2.2.5/layui.js" charset="utf-8"></script>
    <script>











    </script>

    <script>
        //注意进度条依赖 element 模块，否则无法进行正常渲染和功能性操作
        var element = null;
        layui.use('element', function(){
            element = layui.element;
        });
        $(document).ready(function(){

            $.post(
                    basthPath+"/work/task/queryStatbar",
                    {"flag":11},
                    function(data){
                        var myChart = echarts.init(document.getElementById('monthStickState'),"macarons");
                        var app = new Object();
                        var posList = [
                            'left', 'right', 'top', 'bottom',
                            'inside',
                            'insideTop', 'insideLeft', 'insideRight', 'insideBottom',
                            'insideTopLeft', 'insideTopRight', 'insideBottomLeft', 'insideBottomRight'
                        ];

                        app.configParameters = {
                            rotate: {
                                min: -90,
                                max: 90
                            },
                            align: {
                                options: {
                                    left: 'left',
                                    center: 'center',
                                    right: 'right'
                                }
                            },
                            verticalAlign: {
                                options: {
                                    top: 'top',
                                    middle: 'middle',
                                    bottom: 'bottom'
                                }
                            },
                            position: {
                                options: echarts.util.reduce(posList, function (map, pos) {
                                    map[pos] = pos;
                                    return map;
                                }, {})
                            },
                            distance: {
                                min: 0,
                                max: 100
                            }
                        };

                        app.config = {
                            rotate: 90,
                            align: 'left',
                            verticalAlign: 'middle',
                            position: 'insideBottom',
                            distance: 15,
                            onChange: function () {
                                var labelOption = {
                                    normal: {
                                        rotate: app.config.rotate,
                                        align: app.config.align,
                                        verticalAlign: app.config.verticalAlign,
                                        position: app.config.position,
                                        distance: app.config.distance
                                    }
                                };
                                myChart.setOption({
                                    series: [{
                                        label: labelOption
                                    }, {
                                        label: labelOption
                                    }, {
                                        label: labelOption
                                    }, {
                                        label: labelOption
                                    }]
                                });
                            }
                        };


                        var labelOption = {
                            normal: {
                                show: true,
                                position: app.config.position,
                                distance: app.config.distance,
                                align: app.config.align,
                                verticalAlign: app.config.verticalAlign,
                                rotate: app.config.rotate,
                                formatter: '',
                                fontSize: 16,
                                rich: {
                                    name: {
                                        textBorderColor: '#fff'
                                    }
                                }
                            }
                        };

                        option = {
                            color: ['#003366', '#006699', '#4cabce', '#e5323e'],
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {
                                    type: 'shadow'
                                }
                            },
                            legend: {
                                data:data.data.orgArray
                            },
                            toolbox: {
                                show: true,
                                orient: 'vertical',
                                left: 'right',
                                top: 'center',
                                feature: {
                                    mark: {show: true},
                                    dataView: {show: true, readOnly: false},
                                    magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                                    restore: {show: true},
                                    saveAsImage: {show: true}
                                }
                            },
                            calculable: true,
                            xAxis: [
                                {
                                    type: 'category',
                                    axisTick: {show: false},
                                    data: ['一月份','二月份','三月份','四月份','五月份','六月份','七月份','八月份','九月份','十月份','十一月份','十二月份']
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value'
                                }
                            ],
                            series:
                                [
                                    {
                                        data:data.data.dataArray,
                                        type:'pie'
                                    }
                                ],


                        };

                        myChart.setOption(option);

                    },
                    "json");
        })
    </script>
</body>
</html>