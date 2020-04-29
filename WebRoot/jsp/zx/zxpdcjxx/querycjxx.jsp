<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
    <title>诚信评定结果</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var form;
        var table;
        var layer;
        var selectTableDataId = '';
        var mask;//进度条
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#zxpdjgTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'zx/zxpdcjxx/queryDTO'
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
                        {field: 'niandu', width: 150, title: '年度', event: 'trclick'}
                        , {field: 'xmcsdm', width: 150, title: '项目评定代码', event: 'trclick'}
                        , {field: 'commc', width: 150, title: '企业名称', event: 'trclick'}
                        , {field: 'czyxm', width: 150, title: '操作员姓名', event: 'trclick'}
                        , {field: 'czsj', width: 150, title: '操作时间', event: 'trclick'}
                        , {
                            field: 'sjly', width: 150, title: '数据来源', event: 'trclick'
                            , templet: function (d) {
                                if (d.sjly == "1") {
                                    return "手工添加";
                                    //return value;
                                } else {
                                    return "系统添加";
                                }
                            }
                        }
                        , {field: 'cjdf', width: 150, title: '采集得分', event: 'trclick'}
                        , {field: 'beizhu', width: 150, title: '备注', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                form.render();
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.cjid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.cjid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    add: function () { // 添加
                        add();
                    }
                    , edit: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的信息！');
                        } else {
                            edit(table.singleData.cjid);
                        }
                    }
                    , del: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的信息！');
                        } else {
                            del(table.singleData.cjid);
                        }
                    }
                    , show: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的信息！');
                        } else {
                            show(table.singleData.cjid);
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
        })
        //页面加载完成自动生成年度信息
        $(function () {
            var year = new Date().getFullYear();
            for (var i = year; i > 2010; i--) {
                var temp = '<option value=' + (i) + '>' + i + '</option>';
                //设置value的值和列表参数
                var $time = $(temp);
                $("#niandu").append($time);
            }
        });
        //查询企业诚信评定结果
        function query() {
            var commc = $('#commc').val();
            var niandu = $('#niandu').val();
            var param = {
                'commc': commc,
                'niandu': niandu
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
            table.reload('zxpdjgTable', {
                url: basePath + 'zx/zxpdcjxx/queryDTO'
                , page: {
                    curr: cur //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
            /*    parent.window.refresh();*/
        }
        function add() {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '新增'
                , content: basePath + '/zx/zxpdcjxx/cjxxIndex'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        function del(cjid) {
            layer.open({
                title: '警告',
                icon: '3'
                , content: '您确定要删除这条记录吗，这将删除对应的企业的相关信息，且不可恢复！'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/zx/zxpdcjxx/delcjxx', {
                                cjid: cjid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.zxpdjgTable.length == 1) {
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
        function edit(cjid) {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '编辑'
                , content: basePath + '/zx/zxpdcjxx/cjxxIndex?cjid=' + cjid + '&op=edit'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        function show(cjid) {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '查看'
                , content: basePath + '/zx/zxpdcjxx/cjxxIndex?op=view&cjid=' + cjid
                , btn: ['关闭'] //可以无限个按钮
            })
        }
        //选择企业
        function myselectcom() {
            sy.modalDialog({
                title: '选择企业'
                , area: ['100%', '100%']
                , param: {
                    a: new Date().getMilliseconds()
                    , singleSelect: "true"
//                    , comjyjcbz: "1"
                }
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == "") {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#commc").val(myrow.commc); //公司名称
                    $("#comdm").val(myrow.comdm); //公司代码
                    $("#comid").val(myrow.comid);
                }
            });
        }
        //子页面返回参数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
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


    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show" style="height: auto">
                <form id="myqueryform" class="layui-form">
                    <input type="hidden" id="cjid" name="cjid">
                    <input type="hidden" id="comid" name="comid">

                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">企业:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="commc" name="commc"
                                               autocomplete="off" readonly class="layui-input">
                                    </div>
                                    <div class="layui-input-inline" style="width: auto">
                                        <a href="javascript:void(0)" class="layui-btn"
                                           iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">年度</label>

                                    <div class="layui-input-inline">
                                        <select name="niandu" id="niandu">
                                            <option value="">==请选择==</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md2 layui-col-xs8 layui-col-sm4 layui-col-md-offset5 layui-col-xs-offset2 layui-col-sm-offset4">
                                <div class="layui-form-item">
                                    <div class="layui-input-inline">
                                        <ck:permission biz="queryNews">
                                            <button id="btn_query"
                                                    class="layui-btn layui-btn-sm layui-btn-normal">
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
            <ck:permission biz="add">
                <button class="layui-btn" data-type="add" data="btn_add">增加</button>
            </ck:permission>
            <ck:permission biz="edit">
                <button class="layui-btn" data-type="edit" data="btn_edit">修改</button>
            </ck:permission>
            <ck:permission biz="del">
                <button class="layui-btn layui-btn-danger" data-type="del" data="btn_del">删除
                </button>
            </ck:permission>
            <ck:permission biz="show">
                <button class="layui-btn" data-type="show" data="btn_show">查看</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="zxpdjgTable" lay-filter="tableFilter">
            <input type="hidden" id="pdjgid" name="pdjgid"/>
        </table>
    </div>
</div>
</body>
</html>