<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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
    <title>检验检测单位</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var page = 1; // 页面索引初始值
        var pageSize = 10; // 每页显示条数初始化
        var totalPage = 0; //总页数
        var layer;
        var element;
        $(function () {
            getCompanyInfo(page, pageSize);
            initPage();
        });

        // 获取公司信息
        function getCompanyInfo(pageIndex, limit) {
            page = pageIndex;
            pageSize = limit;
            $.ajax({
                type: "get",
                url: basePath + "jyjc/queryJyjcCompany",
                dataType: "json",
                data: {commc: $("#commc").val(), page: page, rows: pageSize},
                success: function (data) {
                    totalPage = data.total;
                    initPage();
                    for (var i = 0; i < data.rows.length; i++) {
                        var v_comid = "'" + data.rows[i].comid + "'";
                        var v_comfjpath = basePath + data.rows[i].comfjpath;
                        var img = "<li style='height:160px; width:130px; list-style-type:none;float:left;'>"
                                + "<div style='text-align: center; cursor: pointer; height:140px; width:110px;'"
                                + " onclick=showCompanyDetails(" + v_comid + ")>"
                                + "<img  src='" + v_comfjpath + "' height='140' width='110'><br/>"
                                + "<span>" + data.rows[i].commc + "</span>"
                                + "</div></li>";
                    }
                    $("#companyDiv #companyUl").append(img);
                }
            });
        }

        // 分页
        function initPage() {
            layui.use(['laypage', 'layer', 'element'], function (obj, first) {
                var laypage = layui.laypage;
                layer = layui.layer;
                element = layui.element;
                laypage.render({
                    elem: 'laypage',
                    curr: page,
                    count: totalPage,
                    limit: pageSize
                    , layout: ['prev', 'page', 'next', 'skip', 'count'],
                    jump: function (obj, first) {
                        if (!first) {
                            getCompanyInfo(obj.curr, obj.limit);
                        }
                    }

                })
            })
        }

    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" action="" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">企业名称：</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="commc" name="commc" placeholder="请输入企业名称"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline">
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                                lay-submit="">
                                            <i class="layui-icon" onclick="getCompanyInfo(page,pageSize)">&#xe615;</i>搜索
                                        </button>
                                        <button class="layui-btn layui-btn-sm layui-btn-normal"
                                                id="btn_reset">
                                            <i class="layui-icon">&#xe621;</i>重置
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
    <div class="layui-margin-top-15">
        <div id="companyDiv" style="height:350px;overflow:auto;">
            <ul id="companyUl"></ul>
        </div>
        <div id="layPage"></div>
    </div>
</div>
</body>
</html>