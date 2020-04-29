<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String aaa102 = StringHelper.showNull2Empty(request.getParameter("aaa102"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>机构信息</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var mygrid;
        var form;
        var table;
        var layer;
        var selectTableDataId = '';
        $(function () {
            initData();
            $('#btn_query').click(function () {
                query();
                return false;
            })
        })
        function initData() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.
                        table.render({
                            elem: '#roleTable'
                            , url: basePath + '/work/task/queryDepartment'
                            , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                            , page: true // 展示分页
                            , limit: 10 // 每页展示条数
                            , limits: [10, 20, 30] // 每页条数选择项
                            , cellMinWidth: 80 //全局定义常规单元格的最小宽度
                            , request: {
                                pageName: 'page' //页码的参数名称，默认：page
                                , limitName: 'rows' //每页数据量的参数名，默认：limit
                            }
                            , response: {
                                countName: 'total' //数据总数的字段名称，默认：count
                                , dataName: 'rows' //数据列表的字段名称，默认：data
                            }
                            , cols: [[
                                {field: 'orgid', title: '科室id', event: 'trclick'}
                                , {field: 'orgname', title: '科室名称', event: 'trclick'}
                                , {field: 'orgdesc', title: '科室描述', event: 'trclick'}
                                , {field: 'address', title: '科室地址', event: 'trclick'}
                            ]]
                        });

                // 监听工具条
                table.on('tool(paramgridfilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.comid) {
                            // 清除所有行的样式
                            $($("#roleTable").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#roleTable").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.comid;
                        } else { // 再次选中清除样式
                            $("#roleTable").next().find(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

            })
            //重置
            $('#reset').click(function () {
                reset();
                return false;
            })
        }

        //确定
        function queding() {
            if (table.singleData != null && table.singleData != '') {
                var obj = new Object();
                obj.data = table.singleData;
                obj.type = "ok";
                sy.setWinRet(obj);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            } else {
                layer.alert('请选择科室！');
            }
        }

        //重置
        function reset() {
            table.singleData = '';
            selectTableDataId = '';
            $('#orgname').val('');
            var param = {
                'orgname':''
            };
            table.reload('roleTable', {
                url: basePath + '/work/task/queryDepartment'
                , where: param //设定异步数据接口的额外参数
            });
        }
        //查询
        function query() {
            var param = {
                'orgname': $('#orgname').val()
            };
            table.reload('roleTable', {
                url: basePath + '/work/task/queryDepartment'
                , page: true
                , where: param //设定异步数据接口的额外参数
            });
        }


    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: 80px">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">科室名称</label>

                        <div class="layui-input-inline">
                            <input type="text" id="orgname" name="orgname"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 280px"></label>

                        <div class="layui-input-inline" style="margin-top: -45px;margin-left: 160px">
                            <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                <i class="layui-icon">&#xe615;</i>搜索
                            </button>
                            <button class="layui-btn layui-btn-sm layui-btn-normal" id="reset">
                                <i class="layui-icon">&#xe621;</i>重置
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="layui-margin-top-15">
            <table class="layui-hide" id="roleTable" lay-filter="paramgridfilter"></table>
        </div>
    </div>
</div>
</body>
</html>