<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page
        import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://"
                + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath()
                + "/";
    }
%>
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String jcjgid = StringHelper.showNull2Empty(request
            .getParameter("jcjgid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测品种</title>
    <style type="text/css">
        * {
            padding: 0;
            margin: 0;
            font-family: "Microsoft YaHei", "Lucida Grande", "Lucida Sans Unicode",
            "Lucida Sans", "DejaVu Sans", Verdana, sans-serif;
            font-size: 14px;
            color: #333;
        }

        #dd {

            width: 98px;
            height: 98px;
            margin: 10px;
        }

        #jcypmc {
            text-align: center;
            width: 110px;
        }

        #tupianSize {
            width: 940px;
            margin: 30px auto;
            overflow: hidden;
            border: solid 1px #95c7c4;
            background-color: #ebf1ff;
        }

        #tupianSize dl {
            float: left;
            border-right: 2px solid #fff;
            border-bottom: 2px solid #fff;
            width: 115px;
        }


    </style>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        //总条数
        var pageTotal = 0;
        //显示每页的条数
        var displaySize = 10;
        //当前页
        var displayIndex = 1;

        var layer;
        $(function () {
            //初始化数据条数
            reqTOBankend(displayIndex, displaySize);
            load();
        });
        //请求后台
        function reqTOBankend(pageIndex, pageSize) {
            displaySize = pageSize;
            displayIndex = pageIndex;
            $.post(
                    basePath + '/jyjc/queryJyjcpzDTO', {
                        page: displayIndex,
                        rows: displaySize
                    },
                    function (result) {
                        if (result.code == '0') {
                            var aa = result.rows;
                            pageTotal = result.total;
                            var allImgDiv = '';
                            load();
                            for (var i = 0; i < aa.length; i++) {
                                myrow = aa[i];
                                allImgDiv += " <dl  onclick=tu('"
                                + myrow.jcypid
                                + "')><dt><img id='dd' src='" + basePath + aa[i].sppicpath + "'/></dt><dd><p id='jcypmc'" + i + ">" + aa[i].jcypmc + "</p></dd></dl>";
                            }
                            $('#tupianSize').html(allImgDiv);
                        } else {
                            layer.alert('查询失败:' + result.msg, {icon: 2});
                        }
                    }, 'json');
        }
        //根据点击的检验检测名称   查出检验检测的数据
        function tu(v_jcypid) {
            //var fu = $('#' + jcypmc).val();
            var v_url = encodeURI(encodeURI(basePath
            + '/jyjc/jyjcpzFormIndex?jcypid=' + v_jcypid));
            sy.modalDialog({
                title: '查看检验检测结果',
                area: ['100%', '100%'],
                content: v_url
                , btn: ['关闭'] //可以无限个按钮
            });
        }
        //初始化分页工具条
        function load() {
            layui.use(['laypage', 'layer'], function () {
                var laypage = layui.laypage;
                layer = layui.layer;
                //执行一个laypage实例
                laypage.render({
                    elem: 'layPage' //注意，这里的 layPage 是 ID，不用加 # 号
                    , limit: displaySize //每页显示数
                    , count: pageTotal
                    , layout: ['prev', 'page', 'next', 'skip', 'count']
                    , curr: displayIndex
                    , jump: function (obj, first) {
                        if (!first) {
                            reqTOBankend(obj.curr, obj.limit);
                        }
                    }
                });
            });
        }
    </script>
</head>
<body>
<form id="fm" method="post">
    <div id="tupianSize"></div>
    <div id="layPage" style="padding-left: 200px"></div>
</form>
</body>
</html>