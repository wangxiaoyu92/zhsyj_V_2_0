<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>检查结果管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var layer;
        var table;
        var form;
        var element;
        var laydate;
        var mask;//进度条
        var url = "<%=basePath%>/supervision/checkresult/jcsbresultlist";
        var selectTableId = "";
        $(function () {
            layui.use(['form', 'layer', 'table', 'element', 'laydate'], function () {
                layer = layui.layer, form = layui.form, table = layui.table, element = layui.element, laydate = layui.laydate;
                laydate.render({
                    elem: '#jckssj'
                })
                laydate.render({
                    elem: '#jcjssj'
                })
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#jscbTable',
                    url: url,
                    page: true
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    },
                    cols: [[
                        {
                            field: 'resultstate',
                            width: 100,
                            title: '全部检查完毕',
                            event: 'trclick',
                            template: function (d) {
                                if (d.resultstate == "1") {
                                    return '<span style="color:red">全部检查未完毕</span>';
                                } else if (d.resultstate == "2") {
                                    return '<span style="color:green">全部检查完毕</span>';
                                }
                                else {
                                    return '<span style="color:blue">结果只读</span>';
                                }
                            }
                        },
                        {field: 'plantitle', width: 100, title: '计划名称', event: 'trclick'},
                        {
                            field: 'planchecktype',
                            width: 100,
                            title: '检查类别',
                            event: 'trclick',
                            template: function (d) {
                                if (d.planchecktype == "0") {
                                    return '<span style="color:blue">量化</span>';
                                } else if (d.planchecktype == "1") {
                                    return '<span style="color:blue">日常</span>';
                                }
                                else {
                                    return '<span style="color:blue">量化</span>';
                                }
                            }
                        },
                        {field: 'jcsbjbrxm', width: 100, title: '检查对象', event: 'trclick'},
                        {field: 'checkednum', width: 100, title: '已完成检查项数', event: 'trclick'},
                        {field: 'checknum', width: 100, title: '总检查项数', event: 'trclick'},
                        {field: 'operatedate', width: 100, title: '经办时间', event: 'trclick'},
                        {field: 'resultdate', width: 100, title: '结束时间', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        layer.close(mask);
                    }
                })
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event == "trclick") {
                        if (selectTableId != data.resultid) {
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableId = data.resultid;
                        } else {
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = "";
                            selectTableId = "";
                        }
                    }
                })
                var $ = layui.$, active = {
                    viewResult: function () {
                        if (selectTableId != "") {
                            viewResult();
                        } else {
                            layer.alert('请先选择要查看的结果信息！')
                        }
                    },
                    uploadFuJian: function () {
                        if (selectTableId != "") {
                            uploadFuJian();
                        } else {
                            layer.alert('请先选择要操作的记录！')
                        }
                    }

                }
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                //监听提交
                $("#btn_query").bind("click", function () {
                    query();
                    return false;
                });
            })
        });
    </script>
    <script type="text/javascript">
        function refresh(param, cur) {
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('jscbTable', {
                url: url
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData = '';
                    selectTableId = '';
                    layer.close(mask);
                }
            });
        }

        // 查询
        function query() {
            var jcsbjbrxm = $('#jcsbjbrxm').val();
            var jckssj = $('#jckssj').val();
            var jcjssj = $('#jcjssj').val();
            var plantitle = $('#plantitle').val();
            var param = {
                'plantitle': plantitle,
                'jckssj': jckssj,
                'jcjssj': jcjssj,
                'jcsbjbrxm': jcsbjbrxm
//			'commc': commc
            };
            refresh(param, '');
        }

        //查看结果明细
        var viewResult = function () {
            var row = table.singleData;
            //固化
            if (row.resultstate == "3") {
                parent.sy.modalDialog({
                    title: '查看检查结果',
                    area: ['100%', '100%'],
                    content: basePath + '/supervision/checkresult/viewResult?resultid='
                    + row.resultid + '&resultstate=' + row.resultstate + '&checkgroupstate='
                    + row.checkgroupstate + '&planchecktype=' + row.planchecktype,
                    btn: ['关闭'] //可以无限个按钮
                })
            } else if (row.resultstate == "1") {
                parent.sy.modalDialog({
                    title: '查看检查结果',
                    area: ['100%', '100%'],
                    url: basePath + '/supervision/checkresult/jcsbresultDetail?resultid='
                    + row.resultid + '&resultstate=' + row.resultstate + '&checkgroupstate='
                    + row.checkgroupstate + '&planchecktype=' + row.planchecktype,
                    btn: ['保存', '取消'],
                    btn1: function (index, layero) {
                        window[layero.find('iframe')[0]['name']].saveDetail();
                    }
                }, closeModalDialogCallback);
            } else {
                parent.sy.modalDialog({
                    title: '查看检查结果',
                    area: ['100%', '100%'],
                    url: basePath + '/supervision/checkresult/jcsbresultDetail?resultid='
                    + row.resultid + '&resultstate=' + row.resultstate + '&planchecktype=' + row.planchecktype,
                    btn: ['保存', '取消'],
                    btn1: function (index, layero) {
                        window[layero.find('iframe')[0]['name']].saveDetail();
                    }
                }, closeModalDialogCallback);
            }

        };


        //附件管理
        function uploadFuJian() {
            var row = table.singleData;
            var v_ajdjid = row.resultid;
            var v_fjcsdlbh = "SYJGFJ";//附件参数大类编号：
            var v_dmlb = "SPJGFJ";//附件参数小类编号：
            var url = basePath + 'pub/pub/pubUploadFjListIndex?ajdjid='
                    + v_ajdjid + '&dmlb=' + v_dmlb + '&fjcsdlbh=' + v_fjcsdlbh + '&time=' + new Date().getMilliseconds();
            parent.sy.modalDialog({
                title: '附件管理',
                area: ['100%', '100%'],
                url: url
            });

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
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myf" action="">
                    <div class="layui-form-item">
                        <label class="layui-form-label">计划信息:</label>

                        <div class="layui-input-inline">
                            <input type="text" id="plantitle" name="plantitle" autocomplete="off" class="layui-input"/>
                        </div>
                        <label class="layui-form-label" style="padding-left: 275px">检查对象:</label>

                        <div class="layui-input-inline">
                            <input type="text" id="jcsbjbrxm" name="jcsbjbrxm" autocomplete="off" class="layui-input"/>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">检查开始时间:</label>

                        <div class="layui-input-inline">
                            <input type="text" id="jckssj" name="jckssj" autocomplete="off" class="layui-input"/>
                        </div>
                        <div class="layui-form-mid">--</div>
                        <div class="layui-input-inline">
                            <input type="text" id="jcjssj" name="jcjssj" autocomplete="off" class="layui-input"/>
                        </div>
                        <div class="layui-input-inline" style="padding-left: 153px">
                            <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                    lay-submit="">
                                <i class="layui-icon">&#xe615;</i>查询
                            </button>
                            <button class="layui-btn layui-btn-sm layui-btn-normal"
                                    id="btn_reset">
                                <i class="layui-icon">&#xe621;</i>重置
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="viewResult">
                <button class="layui-btn" data-type="viewResult" data="btn_viewResult">查看结果明细</button>
            </ck:permission>
            <ck:permission biz="uploadJcsbFuJian">
                <button class="layui-btn" data-type="uploadFuJian" data="btn_uploadFuJian">附件管理</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="jscbTable" filter="tableFilter">
            <input type="hidden" name="resultid" id="resultid">
            <input type="hidden" name="comid" id="comid">
            <input type="hidden" name="checkgroupstate" id="checkgroupstate">
            <input type="hidden" name="planid" id="planid">
        </table>
    </div>
</div>
</body>
</html>