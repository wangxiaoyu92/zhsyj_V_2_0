<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
    String userkind = sysuser.getUserkind();

%>
<!DOCTYPE html>
<html>
<head>
    <title>申请检测查询</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        var v_sfgk = <%=SysmanageUtil.getAa10toJsonArray("SHIFOUBZ")%>;
        var v_ryxb = <%=SysmanageUtil.getAa10toJsonArray("RYXB")%>;
        var mask;
        $(function () {
            intSelectData('sfgk', v_sfgk);
            intSelectData('ryxb', v_ryxb);
            layui.use(['form', 'table', 'layer', 'element', 'laydate'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                laydate = layui.laydate;
                var element = layui.element;
                laydate.render({
                    elem: '#sqstdate'
                });
                laydate.render({
                    elem: '#sqeddate'
                });
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                            elem: '#sqjccxTable'
                            , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                            , url: basePath + 'api/tmsyj/querySqjccx'
                            , page: true // 展示分页
                            , limit: 10 // 每页展示条数
                            , limits: [10, 20, 30] // 每页条数选择项
                            , request: {
                                pageName: 'page' //页码的参数名称，默认：page
                                , limitName: 'rows' //每页数据量的参数名，默认：limit
                            }
                            , response: {
                                countName: 'total' //数据总数的字段名称，默认：count
                                , dataName: 'rows' //数据列表的字段名称，默认：data
                            }
                            , cols: [[
                                {field: 'mc', width: 100, title: '商品名称', event: 'trclick'}
                                , {field: 'commc', width: 200, title: '希望检测的商家', event: 'trclick'}
                                , {field: 'jcreason', width: 150, title: '希望检测的原因', event: 'trclick'}
                                , {
                                    field: 'sfgk', width: 80, title: '是否公开'
                                    , templet: function (d) {
                                        return formatGridColData(v_sfgk, d.sfgk);
                                    }, event: 'trclick'
                                }
                                , {field: 'sqrxm', width: 100, title: '申请人姓名', event: 'trclick'}
                                , {
                                    field: 'ryxb', width: 120, title: '申请人员性别',
                                    templet: function (d) {
                                        return formatGridColData(v_ryxb, d.ryxb);
                                    }, event: 'trclick'
                                }
                                , {field: 'sqrtel', width: 130, title: '申请人电话', event: 'trclick'}
                                , {field: 'sqsj', width: 100, title: '申请时间', event: 'trclick'}
                            ]]
                            , done: function (res, curr, count) {
                                layer.close(mask);
                            }
                        }
                );
                //监听提交
                $("#btn_query").bind("click", function () {
                    query();
                    return false;
                });
            });
        });
        // 查询检测方法
        function query() {
            var sqjctjstdate = $('#sqstdate').val();
            var sqjctjeddate = $('#sqeddate').val();
            if(sqjctjstdate && sqjctjeddate){
                if(sqjctjstdate>=sqjctjeddate){
                    layer.alert('开始时间必须小于结束时间');
                    return false;
                }
            }
            var param = {
                'mc': $('#mc').val(),
                'sqstdate': $('#sqstdate').val(),
                'sqeddate': $('#sqeddate').val()
            };
            table.reload('sqjccxTable', {
                url: basePath + 'api/tmsyj/querySqjccx'
                , page: true
                , where: param //设定异步数据接口的额外参数
            });
            //gu20180531 refresh(param, '');
        }
        // 刷新
        function refresh(param, cur) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            table.reload('sqjccxTable', {
                url: basePath + 'api/tmsyj/querySqjccx'
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    layer.close(mask);
                }
            });
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-row">
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">商品名称</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="mc" name="mc" placeholder="请输入商品名称" style="width:120px"
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md5 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label">申请时间:</label>

                                <div class="layui-input-inline" style="width: auto">
                                    <input type="text" id="sqstdate" name="sqstdate" autocomplete="off"
                                           style="width:120px"
                                           class="layui-input"/>
                                </div>
                                <div class="layui-form-mid">--</div>
                                <div class="layui-input-inline" style="width: auto">
                                    <input type="text" id="sqeddate" name="sqeddate" autocomplete="off"
                                           style="width:120px"
                                           class="layui-input"/>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3 layui-col-xs12 layui-col-sm6 ">
                            <div class="layui-form-item" >
                                <div class="layui-input-inline">
                                    <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                            lay-submit="">
                                        <i class="layui-icon">&#xe615;</i>搜索
                                    </button>
                                    <button class="layui-btn layui-btn-sm layui-btn-normal"
                                            id="btn_reset">
                                        <i class="layui-icon">&#xe621;</i>重置
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <table class="layui-hide" id="sqjccxTable" lay-filter="tableFilter"></table>
</div>
</body>
</html>