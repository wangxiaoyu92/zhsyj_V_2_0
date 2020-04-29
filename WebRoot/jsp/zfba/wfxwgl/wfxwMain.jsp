<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.service.AjdjService,com.zzhdsoft.siweb.entity.workflow.Wf_node" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    String pwfxwcsid = StringHelper.showNull2Empty(request.getParameter("pwfxwcsid"));
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>违法行为管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var mygrid;
        var v_ajdjajdl = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;//进度条
        $(function () {
            //cbo绑定ajdjajdl
            intSelectData('ajdjajdl', v_ajdjajdl);
            layui.use(['table', 'form', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#table'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/zfba/wfxw/queryWfxw'
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
                        {field: 'wfxwbh', width: 150, title: '违法行为编号', event: 'trclick'}
                        , {field: 'wfxwms', width: 300, title: '违法行为描述', event: 'trclick'}
                        , {field: 'wfxwwffg', width: 150, title: '违反法规', event: 'trclick'}
                        , {field: 'wfxwcffg', width: 200, title: '触犯法规', event: 'trclick'}
                        , {field: 'wfxwcffgtk', width: 200, title: '触犯法规条款', event: 'trclick'}
                        , {field: 'wfxwbz', width: 150, title: '备注', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(WfxwFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.pwfxwcsid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.pwfxwcsid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addWfxw: function () { // 添加
                        addWfxw();
                    }
                    , updateWfxw: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的违法行为！');
                        } else {
                            updateWfxw(table.singleData.pwfxwcsid);
                        }
                    }
                    , delWfxw: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的违法行为！');
                        } else {
                            delWfxw(table.singleData.pwfxwcsid);
                        }
                    }
                    , showWfxw: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要查看的违法行为');
                        } else {
                            showWfxw(table.singleData.pwfxwcsid);
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
        var addWfxw = function () {
            sy.modalDialog({
                title: '新增违法行为'
                , area: ['100%', '100%']
                , content: basePath + 'zfba/wfxw/wfxwFormIndex'
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        };
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == '') {
                return
            }
            sy.removeWinRet(dialogID);
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh('', curent);
            } else {
                //saveOk 在第一页刷新
                refresh('', '');
            }
        }

        // 编辑
        function updateWfxw(pwfxwcsid) {
            sy.modalDialog({
                title: '修改违法行为'
                , area: ['100%', '100%']
                , content: basePath + '/zfba/wfxw/wfxwFormIndex?op=edit&&pwfxwcsid=' + pwfxwcsid
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        // 查看
        function showWfxw(pwfxwcsid) {
            sy.modalDialog({
                title: '查看违法行为'
                , area: ['100%', '100%']
                , content: basePath + '/zfba/wfxw/wfxwFormIndex?op=view&pwfxwcsid=' + pwfxwcsid
                , btn: ['关闭']
            });
        }
        ;

        // 删除
        function delWfxw(pwfxwcsid) {
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该违法行为吗？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/zfba/wfxw/delWfxw', {
                                pwfxwcsid: pwfxwcsid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    //保证不会重复删除
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    //本页的值
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.table.length == 1) {
                                            curent = curent - 1;
                                        }
                                        refresh('', curent);
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
        // 刷新
        function refresh(param, cur) {
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('table', {
                url: basePath + '/zfba/wfxw/queryWfxw'
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
            /*		parent.window.refresh();*/
        }
        //查询
        function query() {
            var wfxwbh = $("#wfxwbh").val();
            var ajdjajdl = $("#ajdjajdl").val();
            var param = {
                'wfxwbh': wfxwbh,
                'ajdjajdl': ajdjajdl
            };
            refresh(param, '');
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">违法编号</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="wfxwbh" name="wfxwbh" placeholder="请输入违法编号"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">案件大类</label>

                                    <div class="layui-input-inline">
                                        <select name="ajdjajdl" id="ajdjajdl">
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline">
                                        <ck:permission biz="queryWfxw">
                                            <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                                    lay-submit="" data="btn_queryWfxw">
                                                <i class="layui-icon">&#xe615;</i>搜索
                                            </button>
                                        </ck:permission>
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
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addWfxw">
                <button class="layui-btn" data-type="addWfxw" data="btn_addWfxw">增加</button>
            </ck:permission>
            <ck:permission biz="updateWfxw">
                <button class="layui-btn" data-type="updateWfxw" data="btn_updateWfxw">编辑</button>
            </ck:permission>
            <ck:permission biz="showWfxw">
                <button class="layui-btn " data-type="showWfxw" data="btn_showWfxw">查看</button>
            </ck:permission>
            <ck:permission biz="delWfxw">
                <button class="layui-btn layui-btn-danger" data-type="delWfxw" data="btn_delWfxw">删除</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="table" lay-filter="WfxwFilter"></table>
    </div>
</div>
</body>
</html>