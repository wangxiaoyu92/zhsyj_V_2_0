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
    String v_userdalei = sysuser.getUserdalei();//1非企业用户2企业用户

%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测项目</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;//进度条
        // 企业大类
        var comdalei = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
        $(function () {
            //刷新的时候显示进度条
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#jyjcxmTable'
                    , url: basePath + 'jyjc/queryJyjcxm'
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
                        {field: 'jcxmbh', width: 230, title: '检测项目编号', event: 'trclick'}
                        , {field: 'jcxmmc', width: 250, title: '检测项目名称', event: 'trclick'}
                        , {field: 'jcxmbzz', width: 230, title: '检测项目标准值', event: 'trclick'}
                        , {field: 'jcxmczy', width: 230, title: '操作员', event: 'trclick'}
                        , {field: 'jcxmczsj', width: 250, title: '操作时间', event: 'trclick'}
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
                        if (selectTableDataId != data.jcxmid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.jcxmid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addPcom: function () { // 添加
                        addPcom();
                    }
                    , updatePcom: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的检测项目！');
                        } else {
                            updatePcom(table.singleData.jcxmid);
                        }
                    }
                    , delPcom: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的检测项目！');
                        } else {
                            delPcom(table.singleData.jcxmid);
                        }
                    }
                    , showPcom: function () { // 显示
                        if (!table.singleData) {
                            layer.alert('请选择要查看的检测项目！');
                        } else {
                            showPcom(table.singleData.jcxmid);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                //监听提交
                $("#btn_query").bind("click", function () {
                    query();
                    return false;
                });
            });

        });
        // 查询企业信息
        function query() {
            var param = {
                'jcxmbh': $('#jcxmbh').val(),
                'jcxmmc': $('#jcxmmc').val(),
                'jcxmczy': $('#jcxmczy').val()
            };
            refresh(param, '');
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
            table.reload('jyjcxmTable', {
                url: basePath + 'jyjc/queryJyjcxm'
                , page: {
                    curr: cur//重新从第 1 页开始
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

        // 新增项目
        function addPcom() {
            sy.modalDialog({
                title: '添加检测项目'
                , area: ['100%', '100%']
                , content: basePath + 'jyjc/jyjcxmFormIndex'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }


        //查看项目信息
        function showPcom(jcxmid) {
            layer.open({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                , title: '查看检测项目'
                , content: basePath + 'jyjc/jyjcxmFormIndex?op=view&jcxmid=' + jcxmid
                , shade: [0.8, 'gray'] // 遮罩
                , btn: ['关闭']
            });
        }
        //编辑企业信息
        function updatePcom(jcxmid) {
            sy.modalDialog({
                title: '修改检测项目'
                , area: ['100%', '100%']
                , content: basePath + 'jyjc/jyjcxmFormIndex?op=edit&&jcxmid=' + jcxmid
                , btn: ['保存', '关闭']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == "") {
                return;
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
        // 删除
        function delPcom(jcxmid) {
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'jyjc/delJyjcxm', {
                                jcxmid: jcxmid
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
                                        if (table.cache.jyjcxmTable.length == 1) {
                                            curent = curent - 1;
                                        }
                                        refresh('', curent);
                                    });
                                    //如果删除本页的最后一条数据时 则查询上一页的数据而不是让他在本页无数据的状态

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
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>
            <div class="layui-colla-content layui-show" style="height: auto">
                <form id="myqueryform" class="layui-form">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">检测项目编号</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="jcxmbh" id="jcxmbh" class="layui-input">
                                    </div>
                                    <label class="layui-form-label">名称</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="chinaname" id="chinaname" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">检测项目名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="jcxmmc" name="jcxmmc"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">操作员</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="jcxmczy" name="jcxmczy"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6 layui-col-md-offset4">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

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
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addPcom">
                <button class="layui-btn" data-type="addPcom" data="btn_addPcom">增加</button>
            </ck:permission>
            <ck:permission biz="updatePcom">
                <button class="layui-btn" data-type="updatePcom" data="btn_updatePcom">修改</button>
            </ck:permission>
            <ck:permission biz="delPcom">
                <button class="layui-btn layui-btn-danger" data-type="delPcom" data="btn_delPcom">删除</button>
            </ck:permission>
            <ck:permission biz="showPcom">
                <button class="layui-btn " data-type="showPcom" data="btn_showPcom">查看</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="jyjcxmTable" lay-filter="tableFilter">
            <input type="hidden" name="jcxmid" id="jcxmid">
        </table>
    </div>
</div>
</body>
</html>