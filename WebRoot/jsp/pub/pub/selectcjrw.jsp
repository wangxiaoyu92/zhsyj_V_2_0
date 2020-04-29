<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>选择任务</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <%--<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>--%>
    <script type="text/javascript">
        var v_cjjgrwjsbz = <%=SysmanageUtil.getAa10toJsonArray("CJJGRWJSBZ")%>;
        var v_jcrwzxzt = <%=SysmanageUtil.getAa10toJsonArray("JCRWZXZT")%>;
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#cjrwTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'jyjc/queryCjrw'
                    , where: {
                        'querytype': 'jyjc'
                    }
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
                        {field: 'jyjccjrwbid', width: 210, title: '检验检测抽检任务表id', event: 'trclick'}
                        , {field: 'commc', width: 150, title: '抽检单位id', event: 'trclick'}
                        , {field: 'jcrwmc', width: 100, title: '抽检任务名称', event: 'trclick'}
                        , {field: 'jcrwms', width: 120, title: '抽检任务描述', event: 'trclick'}
                        , {field: 'jcrwkssj', width: 110, title: '抽检任务开始时间', event: 'trclick'}
                        , {field: 'jcrwjssj', width: 110, title: '抽检任务结束时间', event: 'trclick'}
                        , {field: 'cjjgcomid', width: 100, title: '承检机构id', event: 'trclick'}
                        , {
                            field: 'cjjgrwjsbz', width: 100, title: '承检机构任务接受标志',
                            templet: function (d) {
                                return sy.formatGridCode(v_cjjgrwjsbz, d.cjjgrwjsbz);
                            }, event: 'trclick'
                        }
                        , {field: 'cjjgrwbjsyy', width: 100, title: '承检机构任务不接受原因说明', event: 'trclick'}
                        , {
                            field: 'jcrwzxzt', width: 100, title: '任务执行状态',
                            templet: function (d) {
                                return sy.formatGridCode(v_jcrwzxzt, d.jcrwzxzt);
                            }, event: 'trclick'
                        }
                        , {field: 'aae011', width: 100, title: '经办人', event: 'trclick'}
                        , {field: 'aae036', width: 100, title: '经办时间', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.jyjccjrwbid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.jyjccjrwbid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                });
                //监听提交
                $("#btn_query").bind("click", function () {
                    query();
                    return false;
                });
            });
        });

        //确定
        function queding() {
            if (table.singleData != null && table.singleData != '') {
                var obj = new Object();
                obj.data = table.singleData;
                obj.type = "ok";
                sy.setWinRet(obj);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            } else {
                layer.alert('请选择任务！');
            }
        }

        function query() {
            var comid = $('#comid').val();
            var param = {
                'comid': comid
            };
            refresh(param, '');
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
            table.reload('cjrwTable', {
                url: basePath + 'jyjc/queryCjrw'
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }
        //选择抽检机构名称
        function myselectcom() {
            parent.sy.modalDialog({
                title: '选择抽检单位'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#commc").val(myrow.commc); //公司名称
                    $("#comid").val(myrow.comid); //公司代码
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
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">被抽检单位:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="comid" name="comid" readonly
                                               autocomplete="off" class="layui-input">
                                        <input id="commc" name="commc" type="hidden">
                                    </div>
                                    <div class="layui-input-inline" style="width: auto">
                                        <a href="javascript:void(0)" class="layui-btn"
                                           iconCls="icon-search" onclick="myselectcom()">选择被抽检单位 </a>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline">
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
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
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <table class="layui-hide" id="cjrwTable" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>