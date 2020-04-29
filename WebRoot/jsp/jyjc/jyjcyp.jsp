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
    //商品数据类型aaa100=spsjlx0商品1生产企业产品2生产企业原材料*/
    String v_spsjlx = StringHelper.showNull2Empty(request.getParameter("spsjlx"));//商品数据类型
    if (v_spsjlx == null || "".equals(v_spsjlx)) {
        v_spsjlx = "0";
    }
    String v_spsjlxmc = "商品";
    if ("1".equals(v_spsjlx)) {
        v_spsjlxmc = "产品";
    } else if ("2".equals(v_spsjlx)) {
        v_spsjlxmc = "原材料";
    }
    Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
    String v_userid = vSysUser.getUserid();
%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测样品</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        var jcyplb = <%=SysmanageUtil.getAa10toJsonArray("JCYPLB")%>;
        var jcypgl = <%=SysmanageUtil.getAa10toJsonArray("JCYPGL")%>;
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
                    elem: '#jyjcypTable'
//                ,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'jyjc/queryJyjcyp?spsjlx=<%=v_spsjlx%>'
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
//                        { field : 'jcypid', width : 100, title: '检测样品ID' ,event: 'trclick'}
                        {
                            field: 'jcyplb', width: 100, title: '类别', event: 'trclick'
                            , templet: function (d) {
                            return sy.formatGridCode(jcyplb, d.jcyplb);
                        }
                        }
                        , {field: 'jcypmc', width: 100, title: '名称', event: 'trclick'}
                        , {
                            field: 'jcypgl', width: 100, title: '归类', event: 'trclick'
                            , templet: function (d) {
                                return sy.formatGridCode(jcypgl, d.jcypgl);
                            }
                        }
                        , {field: 'jcypsspp', width: 100, title: '所属品牌', event: 'trclick'}
                        , {field: 'impcpgg', width: 100, title: '规格', event: 'trclick'}
                        , {field: 'spsb', width: 100, title: '商标', event: 'trclick'}
                        , {field: 'spggxh', width: 100, title: '规格型号', event: 'trclick'}
                        , {field: 'spjldw', width: 100, title: '计量单位', event: 'trclick'}
                        , {field: 'spzxbzh', width: 100, title: '执行标准号', event: 'trclick'}
                        , {field: 'spbzq', width: 100, title: '保质期', event: 'trclick'}
                        , {field: 'jcypczy', width: 100, title: '操作员', event: 'trclick'}
                        , {field: 'jcypczsj', width: 100, title: '操作时间', event: 'trclick'}
//					, {fixed: 'right', width : 200, align: 'center', toolbar: '#paramgridbtn'}
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
                        if (selectTableDataId != data.jcypid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.jcypid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    saveJyjcyp: function () { // 添加
                        saveJyjcyp();
                    }
                    , updateJyjcyp: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的检验检测样品！');
                        } else {
                            updateJyjcyp(table.singleData.jcypid);
                        }
                    }
                    , delPcomJyjc: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的检验检测样品！');
                        } else {
                            delPcom(table.singleData);
                        }
                    }
                    , showJyjcyp: function () { // 显示
                        if (!table.singleData) {
                            layer.alert('请选择要查看的检验检测样品！');
                        } else {
                            showJyjcyp(table.singleData.jcypid);
                        }
                    }
                    , JyjcypFjsc: function () { // 附件上传
                        if (!table.singleData) {
                            layer.alert('请选择要上传附件的检验检测样品！');
                        } else {
                            JyjcypFjsc(table.singleData.jcypid);
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
            intSelectData('jcyplb', jcyplb);
        });
        // 查询检验检测样品
        function query() {
            var param = {
                'jcyplb': $('#jcyplb').val(),
                'jcypmc': $('#jcypmc').val(),
                'jcypczy': $('#jcypczy').val()
            };
            refresh(param, '');
        }
        //图片上传
        function JyjcypFjsc(jcypid) {
            sy.modalDialogLayui({
                title: '附件上传'
                , area: ['100%', '100%']
                , content: "<%=basePath%>pub/pub/uploadFjViewIndex?folderName=jyjc&fjtype=8&fjwid=" + jcypid
                , btn: ['关闭']
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
            table.reload('jyjcypTable', {
                url: basePath + 'jyjc/queryJyjcyp?spsjlx=<%=v_spsjlx%>'
                , page: {
                    curr: cur
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

        // 新增检验检测样品
        function saveJyjcyp() {
            sy.modalDialog({
                title: '新增检验检测样品'
                , area: ['100%', '100%']
                , content: basePath + 'jyjc/jyjcypFormIndex?spsjlx=<%=v_spsjlx%>'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }


        //查看检验检测样品
        function showJyjcyp(jcypid) {
            layer.open({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                , title: '查看检验检测样品'
                , content: basePath + 'jyjc/jyjcypFormIndex?op=view&spsjlx=<%=v_spsjlx%>&jcypid=' + jcypid
                , shade: [0.8, 'gray'] // 遮罩
                , btn: ['关闭']
            });
        }
        //编辑信息
        function updateJyjcyp(jcypid) {
            sy.modalDialog({
                title: '编辑检验检测样品'
                , area: ['100%', '100%']
                , content: basePath + 'jyjc/jyjcypFormIndex?op=edit&spsjlx=<%=v_spsjlx%>&jcypid=' + jcypid
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
        function delPcom(row) {
            var jcypid = row.jcypid;
            var userid = row.userid;
            if (userid != '<%=v_userid%>') {
                layer.msg('不是自己添加的商品不能删除，商品信息是公用的');
                return false;
            }
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'jyjc/delJyjcyp', {
                                jcypid: jcypid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.jyjcypTable.length == 1) {
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
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height:auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">类别：</label>

                                    <div class="layui-input-inline">
                                        <select id="jcyplb" name="jcyplb" autocomplete="off"
                                                class="layui-input"></select>
                                        <%--<input type="text" id="jcyplb" name="jcyplb" placeholder="请输入类别名称"--%>
                                        <%--autocomplete="off" class="layui-input">--%>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">名称：</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="jcypmc" name="jcypmc" placeholder="请输入商品名称"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">操作员：</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="jcypczy" name="jcypczy" placeholder="请输入操作员名称"
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
            <ck:permission biz="saveJyjcyp">
                <button class="layui-btn" data-type="saveJyjcyp" data="btn_saveJyjcyp">增加</button>
            </ck:permission>
            <ck:permission biz="updateJyjcyp">
                <button class="layui-btn" data-type="updateJyjcyp" data="btn_updateJyjcyp">修改</button>
            </ck:permission>
            <ck:permission biz="delJyjcyp">
                <button class="layui-btn layui-btn-danger" data-type="delJyjcyp" data="btn_delJyjcyp">删除</button>
            </ck:permission>
            <ck:permission biz="showJyjcyp">
                <button class="layui-btn " data-type="showJyjcyp" data="btn_showJyjcyp">查看</button>
            </ck:permission>
            <ck:permission biz="JyjcypFjsc">
                <button class="layui-btn " data-type="JyjcypFjsc" data="btn_JyjcypFjsc">附件上传</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="jyjcypTable" lay-filter="tableFilter">
            <input type="hidden" id="jcypid" name="jcypid">
            <input type="hidden" id="userid" name="userid">
        </table>
    </div>
</div>
</body>
</html>