<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.service.AjdjService,com.zzhdsoft.siweb.entity.workflow.Wf_node" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    String did = StringHelper.showNull2Empty(request.getParameter("did"));
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>部门信息</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var mygrid;
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        $(function () {
            //cbo绑定ajdjajdl
            layui.use(['table', 'form', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                table.render({
                    elem: '#table'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/area/condition/queryareaCondition'
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
                        {field: 'aaa027', width: 250, title: '区域编码', event: 'trclick'}
                        , {field: 'text', width: 250, title: '描述', event: 'trclick'}
                        , {field: 'jdzb', width: 250, title: '经度坐标', event: 'trclick'}
                        , {field: 'wdzb', width: 250, title: '纬度坐标', event: 'trclick'}

                    ]]
                });
                // 监听工具条
                table.on('tool(DeptFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.did) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.did;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addDept: function () { // 添加
                        addDept();
                    }
                    , updateDept: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的区域描述信息！');
                        } else {
                            updateDept(table.singleData.aaa027);
                        }
                    }
                    , delDept: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的区域描述信息！');
                        } else {
                            delDept(table.singleData.aaa027);
                        }
                    }
                    , showDept: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要查看的区域描述信息');
                        } else {
                            showDept(table.singleData.aaa027);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
            //监听提交
            $("#btn_query").bind("click", function () {
                query();
                return false;
            });
        });////////////////

        //新增
        var addDept = function () {
            sy.modalDialog({
                title: '新增区域描述信息'
                , area: ['100%', '100%']
                , content: basePath + '/area/condition/areaConditionFormIndex?add=view'
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        };
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if(obj == null || obj ==''){
                return
            }
            sy.removeWinRet(dialogID);
            if (obj.type == "ok") {
                table.reload('table', {url: basePath + '/area/condition/queryareaCondition'});
                table.singleData = '';
                selectTableDataId = '';
            }
        }

        // 编辑
        function updateDept(aaa027) {
            sy.modalDialog({
                title: '修改区域描述信息'
                , area: ['100%', '100%']
                , content: basePath + '/area/condition/areaConditionFormIndex?aaa027=' + aaa027
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        ;

        // 查看
        function showDept(aaa027) {
            sy.modalDialog({
                title: '查看区域描述信息'
                , area: ['100%', '100%']
                , content: basePath + '/area/condition/areaConditionFormIndex?op=view&aaa027=' + aaa027
                ,btn:['取消']
            });
        }
        ;

        // 删除
        function delDept(aaa027) {
            layer.open({
                title: '警告'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/area/condition/delAreaCondition', {
                                aaa027: aaa027
                            },
                            function (result) {
                                if (result.code == '0') {
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        table.reload('table', {url: basePath + '/area/condition/queryareaCondition'});
                                        table.singleData = '';
                                        selectTableDataId = '';
                                    });
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "删除失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            },
                            'json');
                }
            });
        }
        //查询
        function query() {
            var aaa027 = $("#aaa027").val();
            var param = {
                'aaa027': aaa027,
                'page': 1
            };
            table.reload('table', {
                url: basePath + '/area/condition/queryareaCondition'
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
                <form class="layui-form" id="myqueryform" style="height: 40px">
                    <div class="layui-form-item" style="text-align:left ">
                        <label class="layui-form-label">区域编码</label>

                        <div class="layui-input-inline">
                            <input type="text" id="aaa027" name="aaa027" placeholder="请输入区域编码"
                                   autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-input-inline">
                            <fieldset class="layui-elem-field site-demo-button" style="border: none;">
                                <div>
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                                lay-submit="" data="btn_queryWfxw">
                                            <i class="layui-icon">&#xe615;</i>搜索
                                        </button>
                                    <button class="layui-btn layui-btn-sm layui-btn-normal"
                                            id="btn_reset">
                                        <i class="layui-icon">&#xe621;</i>重置
                                    </button>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
            <div class="layui-btn-group demoTable">
                    <button class="layui-btn" data-type="addDept" data="btn_addDept">增加</button>
                    <button class="layui-btn" data-type="updateDept" data="btn_updateDept">编辑</button>
                    <button class="layui-btn " data-type="showDept" data="btn_showDept">查看</button>
                    <button class="layui-btn layui-btn-danger" data-type="delDept" data="btn_delDept">删除</button>
            </div>
        <table class="layui-hide" id="table" lay-filter="DeptFilter"></table>
    </div>
</div>
</body>
</html>