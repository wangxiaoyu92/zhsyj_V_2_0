<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String id = StringHelper.showNull2Empty(request.getParameter("cydjid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检验单列表</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;//进度条
        var v_cydjrwlb = <%=SysmanageUtil.getAa10toJsonArray("CYDJRWLB")%>;//任务类别
        var v_cydjqylx = <%=SysmanageUtil.getAa10toJsonArray("CYDJQYLX")%>;//区域类别
        var v_cyypbz = <%=SysmanageUtil.getAa10toJsonArray("CYYPBZ")%>;//抽样样品包装
        var v_cyfs = <%=SysmanageUtil.getAa10toJsonArray("CYFS")%>;//抽样方式
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#jyjccydTable'
//                ,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/jyjc/queryJyjccyd_zm'
                    , where: {
                        'cydjid': '<%=id%>'
                    }
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
                         {field: 'cydbh', width: 120, title: '抽样单编号', event: 'trclick'}
                        , {field: 'cydjrwly', width: 100, title: '任务来源', event: 'trclick'}
                        , {
                            field: 'cydjrwlb', width: 100, title: '任务类别'
                            , templet: function (d) {
                                return formatGridColData(v_cydjrwlb, d.cydjrwlb);
                            }, event: 'trclick'
                        }
                        , {
                            field: 'cydjqylx', width: 80, title: '区域类型'
                            , templet: function (d) {
                                return formatGridColData(v_cydjqylx, d.cydjqylx);
                            }, event: 'trclick'
                        }
                        , {field: 'commc', width: 200, title: '被抽样单位名称', event: 'trclick'}
                        , {field: 'cydwmc', width: 200, title: '检测机构名称', event: 'trclick'}
                        , {field: 'jcypmc', width: 110, title: '检测样品名称', event: 'trclick'}
                        , {field: 'zxbzjswj', width: 150, title: '执行标准∕技术文件', event: 'trclick'}
                        , {
                            field: 'cyypbz', width: 110, title: '抽样样品包装'
                            , templet: function (d) {
                                return formatGridColData(v_cyypbz, d.cyypbz);
                            }, event: 'trclick'
                        }
                        , {
                            field: 'cyfs', width: 100, title: '抽样方式'
                            , templet: function (d) {
                                return formatGridColData(v_cyfs, d.cyfs);
                            }, event: 'trclick'
                        }

                        , {field: 'beizhu', width: 100, title: '备注', event: 'trclick'}
                        , {field: 'cydwgzrq', width: 100, title: '抽样单位盖章日期', event: 'trclick'}
                        , {field: 'aae011', width: 150, title: '操作员', event: 'trclick'}
                        , {field: 'aae036', width: 150, title: '操作时间', event: 'trclick'}

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
                        if (selectTableDataId != data.jyjccydid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.jyjccydid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addCyd: function () { // 增
                        addCyd();
                    }
                    , delCyd: function () { // 删
                        if (!table.singleData) {
                            layer.alert('请选择要删除的检验单！');
                        } else {
                            delCyd(table.singleData.jyjccydid);
                        }
                    }
                    , editCyd: function () { // 改
                        if (!table.singleData) {
                            layer.alert('请先选择要修改的检验单！');
                        } else {
                            editCyd(table.singleData.jyjccydid);
                        }
                    }
                    , showCyd: function () { // 显示
                        if (!table.singleData) {
                            layer.alert('请选择要查看的检验单！');
                        } else {
                            showCyd(table.singleData.jyjccydid);
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
        // 新增
        function addCyd() {
            parent.sy.modalDialog({
                title: '添加'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jyjccydFormIndex_zm'
                , param: {
                    cydjid: '<%=id%>'
                }
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        // 删除
        function delCyd(cydjid) {
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该检验单吗？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'jyjc/delJyjccyd_zm', {
                                jyjccydid: cydjid
                            },
                            function (result) {
                                console.log(result)
                                if (result.code == '0') {
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.jyjccydTable.length == 1) {
                                            curent = curent - 1;
                                        }
                                        var param = {
                                            'cydjid': '<%=id%>'
                                        };
                                        refresh(param, curent);
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
        function editCyd(jyjccydid) {
            parent.sy.modalDialog({
                title: '编辑'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jyjccydFormIndex_zm'
                , param: {
                    op: "edit",
                    jyjccydid: jyjccydid
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        //查看信息
        function showCyd(jyjccydid) {
            parent.sy.modalDialog({
                title: '查看'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jyjccydFormIndex_zm'
                , param: {
                    op: 'view',
                    jyjccydid: jyjccydid
                }
                , btn: ['关闭']
            });
        }
        // 查询检验检测样品
        function query() {
            var cydbh = $('#cydbh').val();
            var param = {
                'cydbh': cydbh,
                'cydjid': '<%=id%>'
            };
            refresh(param, '');
        }
        //从单位信息表中读取
        function myselectcom() {
            parent.sy.modalDialog({
                title: '选择企业'
                , area: ['100%', '100%']
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true",
                    comjyjcbz: "1"
                }
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return false;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#bcydw").val(myrow.comdm); //公司名称
                    $("#comid").val(myrow.comid);//公司id
                }
            });
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
            table.reload('jyjccydTable', {
                url: basePath + 'jyjc/queryJyjccyd_zm'
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


        function closeModalDialogCallback(dialogID) {
            var param = {
                'cydjid': '<%=id%>'
            };
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == "") {
                return;
            }
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh(param, curent);
            } else {
                //saveOk 在第一页刷新
                refresh(param, '');
            }
        }
    </script>
</head>
<body>
<div class="layui-fluid">
<%--    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <input type="hidden" id="cydjid" name="cydjid" value="<%=id%>">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">抽样单编号：</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="cydbh" name="cydbh"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm8">
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
    </div>--%>
    <fieldset class="layui-elem-field site-demo-button" style="width: 100%;border: none;padding-top: 8px;">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addCyd">
                <button class="layui-btn" data-type="addCyd" data="btn_addCyd">增加</button>
            </ck:permission>
            <ck:permission biz="editCyd">
                <button class="layui-btn" data-type="editCyd" data="btn_editCyd">编辑</button>
            </ck:permission>
            <ck:permission biz="delCyd">
                <button class="layui-btn layui-btn-danger" data-type="delCyd" data="btn_delCyd">删除</button>
            </ck:permission>
            <ck:permission biz="showCyd">
                <button class="layui-btn " data-type="showCyd" data="btn_showCyd">查看</button>
            </ck:permission>
        </div>
    </fieldset>
    <table class="layui-hide" id="jyjccydTable" lay-filter="tableFilter"></table>
</div>
</body>
</html>