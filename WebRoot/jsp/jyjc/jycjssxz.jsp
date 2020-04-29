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
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>抽检实施细则</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;//进度条
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#jycjssxzTable'
//                ,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/jyjc/queryjycjssxz'
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项jyjc
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'cjcpamc', width: 120, title: '抽检产品种类', event: 'trclick'}
                        ,
                        {
                            field: 'syfw', width: 100, title: '适用范围', event: 'trclick'
                        }
                        , {field: 'cpzl', width: 100, title: '产品种类', event: 'trclick'}
                        , {field: 'jyjj', width: 100, title: '检验依据', event: 'trclick'}
                        , {field: 'cyxhhgg', width: 120, title: '抽样型号或规格', event: 'trclick'}
                        , {field: 'cyffjsl', width: 120, title: '抽样方法及数量', event: 'trclick'}
                        , {field: 'fyhypyszc', width: 140, title: '封样和样品运输贮存', event: 'trclick'}
                        , {field: 'pdyzyjl', width: 120, title: '判断原则与结论', event: 'trclick'}
                        , {field: 'aae011', width: 100, title: '操作人', event: 'trclick'}
                        , {field: 'aae036', width: 100, title: '操作时间', event: 'trclick'}
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
                        if (selectTableDataId != data.jycjssxzid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.jycjssxzid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addPcom: function () { // 增
                        addPcom();
                    }
                    , delPcom: function () { // 删
                        if (!table.singleData) {
                            layer.alert('请选择要删除的抽检实施细则！');
                        } else {
                            delPcom(table.singleData.jycjssxzid);
                        }
                    }
                    , editPcom: function () { // 改
                        if (!table.singleData) {
                            layer.alert('请先选择要修改的抽检实施细则！');
                        } else {
                            editPcom(table.singleData.jycjssxzid);
                        }
                    }
                    , showPcom: function () { // 显示
                        if (!table.singleData) {
                            layer.alert('请选择要查看的抽检实施细则！');
                        } else {
                            showPcom(table.singleData.jycjssxzid);
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
        // 新增企业
        function addPcom() {
            sy.modalDialog({
                title: '新增抽检实施细则'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jycjssxzFormIndex'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveFun();
                }
            }, closeModalDialogCallback);
        }
        // 删除
        function delPcom(jycjssxzid) {
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'jyjc/delJycjssxz', {
                                jycjssxzid: jycjssxzid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.jycjssxzTable.length == 1) {
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
        //改
        function editPcom(jycjssxzid) {
            sy.modalDialog({
                title: '编辑抽检实施细则'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jycjssxzFormIndex'
                , param: {
                    jycjssxzid: jycjssxzid
                }
                , btn: ['保存', '关闭']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveFun();
                }
            }, closeModalDialogCallback);
        }
        //查看信息
        function showPcom(jycjssxzid) {
            sy.modalDialog({
                title: '查看抽检实施细则'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jycjssxzFormIndex'
                , param: {
                    op: 'view',
                    jycjssxzid: jycjssxzid
                }
                , btn: ['关闭']
            });
        }
        // 查询检验检测样品
        function query() {
            var viewjycjcpflid = $('#viewjycjcpflid').val();
            var cpzl=$('#cpzl').val();
            var param = {
                'viewjycjcpflid': viewjycjcpflid,
                'cpzl': cpzl
            };
            refresh(param, '');
        }
        // 刷新
        function refresh(param, cur) {
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('jycjssxzTable', {
                url: basePath + 'jyjc/queryjycjssxz'
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


        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == "") {
                return;
            }
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh('', curent);
            } else {
                //saveOk 在第一页刷新
                refresh('', '');
            }
        }

        function showMenu_aaa027() {

            sy.modalDialog({
                title: '选择抽检产品分类'
                , area: ['300px', '400px']
                , content: basePath + 'jsp/pub/pub/selectjycjcpfl.jsp'
            }, function (dialogID) {
                var k = sy.getWinRet(dialogID);
                if (typeof(k.type) != "undefined" && k.type != null && k.type == 'ok') {
                    $('#viewjycjcpflid').val(k.viewjycjcpflid);
                    $('#viewjycjcpflname').val(k.viewjycjcpflname);
                }
                sy.removeWinRet(dialogID);
            });
        }

        function showMenu_aaa027new() {

            sy.modalDialog({
                title: '选择检测项目'
                , area: ['300px', '400px']
                , content: basePath + 'jsp/pub/pub/selectjycjjcxm.jsp'
            }, function (dialogID) {
                var k = sy.getWinRet(dialogID);
                if (typeof(k.type) != "undefined" && k.type != null && k.type == 'ok') {
                    $('#jyxmdesc').val(k.jyxmdesc);
                    $('#jyxmdescname').val(k.jyxmdescname);
                }
                sy.removeWinRet(dialogID);
            });
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
                layer.alert('请选择抽检实施细则！');
            }
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
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 90px">抽检产品分类:</label>

                                    <div class="layui-input-inline">
                                        <input name="viewjycjcpflname" id="viewjycjcpflname"  onclick="showMenu_aaa027();"
                                               readonly="readonly" class="layui-input" lay-verify="required"/>
                                        <input name="viewjycjcpflid" id="viewjycjcpflid" type="hidden"/>
                                    </div>
                                    <div id="menuContent_aaa027" class="layui-side layui-bg-gray" style="display:none; position: absolute;">
                                        <div class="layui-side-scroll" style="width:250px;">
                                            <ul id="treeDemo_aaa027" class="ztree"></ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 90px">产品种类:</label>

                                    <div class="layui-input-inline">
                                        <input name="cpzl" id="cpzl"
                                                class="layui-input" />

                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
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
    <% if (!"select".equalsIgnoreCase(op)) {%>
    <fieldset class="layui-elem-field site-demo-button" style="width: 100%;border: none;padding-top: 8px;">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addPcom">
                <button class="layui-btn" data-type="addPcom" data="btn_addPcom">增加</button>
            </ck:permission>
            <ck:permission biz="updatePcom">
                <button class="layui-btn" data-type="editPcom" data="btn_editPcom">编辑</button>
            </ck:permission>
            <ck:permission biz="delPcom">
                <button class="layui-btn layui-btn-danger" data-type="delPcom" data="btn_delPcom">删除</button>
            </ck:permission>
            <ck:permission biz="showPcom">
                <button class="layui-btn " data-type="showPcom" data="btn_showPcom">查看</button>
            </ck:permission>
        </div>
    </fieldset>
    <%} %>
    <table class="layui-hide" id="jycjssxzTable" lay-filter="tableFilter">

    </table>
</div>
</body>
</html>