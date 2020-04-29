<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.service.AjdjService" %>
<%@ page import="com.zzhdsoft.siweb.entity.workflow.Wf_node" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
    AjdjService v_AjdjService = new AjdjService();
    Wf_node v_wf_node = v_AjdjService.getStartNodeFromYwpym("zfbalc");
    String v_psbh = "";
    String v_nodeid = "";
    String v_nodename = "";
    if (v_wf_node != null) {
        v_psbh = v_wf_node.getPsbh();
        System.out.println(v_wf_node.getNodeid().toString());
        v_nodeid = v_wf_node.getNodeid().toString();
        v_nodename = v_wf_node.getNodename();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>检查结果管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var v_resultstate = [{"id": "", "text": ""}, {"id": "1", "text": "全部检查未完毕"}, {
            "id": "2",
            "text": "全部检查完毕"
        }, {"id": "3", "text": "结果只读"}, {"id": "4", "text": "全部"}];
        var form;
        var table;
        var layer;
        var selectNodes;
        var selectTableDataId = '';
        var grid;
        var mask;//进度条
        var url = "<%=basePath%>/supervision/checkresult/resultlist";
        $(function () {
            initSelectData();
            initData();
        });

        function initData() {
            layui.use(['form', 'table', 'layer', 'laydate', 'element'], function () {
                form = layui.form;
                var element = layui.element;
                var laydate = layui.laydate;
                table = layui.table;
                layer = layui.layer;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#roleTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: url
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
                        {
                            field: 'resultstate', width: 120, title: '检查状态'
                            , templet: function (d) {
                            if (d.resultstate == "1" || d.resultstate == "0") {
                                return '<span style="color:red">全部检查未完毕</span>';
                            } else if (d.resultstate == "2") {
                                return '<span style="color:green">全部检查完毕</span>';
                            }
                            else {
                                return '<span style="color:blue">结果只读</span>';
                            }
                        }
                            , event: 'trclick'
                        }
                        , {field: 'plantitle', width: 150, title: '计划名称', event: 'trclick'}
                        , {
                            field: 'planchecktype', width: 80, title: '检查类别'
                            , templet: function (d) {
                                if (d.resultstate == "0") {
                                    return '<span style="color:blue">量化</span>';
                                } else if (d.resultstate == "1") {
                                    return '<span style="color:blue">日常</span>';
                                }
                                else {
                                    return '<span style="color:blue">日常</span>';
                                }
                            }
                            , event: 'trclick'
                        }
                        , {field: 'commc', width: 150, title: '检查对象', event: 'trclick'}
                        , {field: 'checkednum', width: 120, title: '已完成检查项数', event: 'trclick'}
                        , {field: 'checknum', width: 120, title: '总检查项数', event: 'trclick'}
                        , {field: 'operateperson', width: 100, title: '经办人', event: 'trclick'}
                        , {field: 'location', width: 150, title: '位置', event: 'trclick'}
                        , {field: 'operatedate', width: 150, title: '经办时间', event: 'trclick'}
                        , {field: 'resultdate', width: 160, title: '结束时间', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                var start = {
                    elem: '#operatedate',
                    type: 'date',
                    show: true,
                    closeStop: '#operatedate'

                };
                var end = {
                    elem: '#operateenddate',
                    type: 'date',
                    show: true,
                    closeStop: '#operateenddate'
                };
                lay('#operatedate').on('click', function (e) {
                    if ($('#operateenddate').val() != null && $('#operateenddate').val() != undefined && $('#operateenddate').val() != '') {
                        start.max = $('#operateenddate').val();
                    }
                    laydate.render(start);
                });
                lay('#operateenddate').on('click', function (e) {
                    if ($('#operatedate').val() != null && $('#operatedate').val() != undefined && $('#operatedate').val() != '') {
                        end.min = $('#operatedate').val();
                    }
                    laydate.render(end);
                });
                // 监听工具条
                table.on('tool(paramgridfilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.resultid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.resultid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });


                var $ = layui.$, active = {
                    viewResult: function () { // 查看结果明细
                        if (!table.singleData) {
                            layer.alert('请先选择要查看的结果信息！');
                        } else {
                            viewResult(table.singleData);
                        }
                    }
                    , viewResultinfo: function () { // 查看信息结果
                        if (!table.singleData) {
                            layer.alert('请先选择要查看的结果信息！');
                        } else {
                            viewResultinfo(table.singleData);
                        }
                    }
                    , uploadFuJian: function () { // 附件管理
                        if (!table.singleData) {
                            layer.alert('请先选择要管理的结果信息！');
                        } else {
                            uploadFuJian(table.singleData);
                        }
                    }
                    , ws: function () { // 文书管理
                        if (!table.singleData) {
                            layer.alert('请先选择要管理的结果信息！');
                        } else {
                            ws(table.singleData);
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

            })
        }


        //初始化下拉框选项数据
        function initSelectData() {
            var typeOptions = '';
            for (var i = 0; i < v_resultstate.length; i++) {
                typeOptions += '<option value=\'' + v_resultstate[i].id + '\' >' + v_resultstate[i].text + '</option>';
            }
            $("#resultstate").append(typeOptions);
        }

    </script>
    <script type="text/javascript">
        function refresh() {
            parent.window.refresh();
        }

        // 重置
        function reload() {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('roleTable', {
                url: basePath + basePath + 'supervision/checkresult/resultlist'
                , done: function (res, curr, count) {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }

        // 查询
        function query() {
            var commc = $('#commc').val();
            var operatedate = $('#operatedate').val();
            var operateenddate = $('#operateenddate').val();
            var plantitle = $('#plantitle').val();
            var resultstate = $("#resultstate").val();

            var param = {
                'plantitle': plantitle,
                'operatedate': operatedate,
                'operateenddate': operateenddate,
                'commc': commc,
                'resultstate': resultstate
            };
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('roleTable', {
                url: basePath + 'supervision/checkresult/resultlist'
                , page: true
                , where: param //设定异步数据接口的额外参数
                , done: function (res, curr, count) {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }
        //查看结果明细
        function viewResult(singleData) {
            var row = singleData;
            if (row) {
                if (row.resultstate == "1") {//未检查完毕
                    sy.modalDialog({
                        title: '查看结果明细'
                        , area: ['100%', '100%']
                        , content: basePath + '/supervision/checkresult/resultdetail',
                        param: {
                            resultid: row.resultid,
                            resultstate: row.resultstate,
                            planchecktype: row.planchecktype,
                            comdalei: row.comdalei
                        }
                        , btn: ['关闭'] //可以无限个按钮
                    });
                }//固化
                else {
                    sy.modalDialog({
                        title: '查看结果明细'
                        , area: ['100%', '100%']
                        , content: basePath + '/supervision/checkresult/viewResult',
                        param: {
                            resultid: row.resultid,
                            resultstate: row.resultstate,
                            planchecktype: row.planchecktype
                        }
                        , btn: ['关闭'] //可以无限个按钮
                    });
                }
            }
        }
        ;


        //查看结果信息
        function viewResultinfo(singleData) {
            var row = singleData;
            if (row) {
                //除未完成
                if (row.resultstate == "4") {//结果固化
                    sy.modalDialog({
                        title: '查看检查结果'
                        , area: ['100%', '100%']
                        , content: basePath + 'supervision/checkresult/viewResultinfo',
                        param: {
                            resultid: row.resultid,
                            resultstate: row.resultstate,
                            planchecktype: row.planchecktype
                        }
                        , btn: ['关闭'] //可以无限个按钮
                    });
                } else if (row.resultstate == "5") {//完毕
                    sy.modalDialog({
                        title: '查看检查结果'
                        , area: ['100%', '100%']
                        , content: basePath + 'supervision/checkresult/viewResultinfo',
                        param: {
                            resultid: row.resultid,
                            resultstate: row.resultstate,
                            planchecktype: row.planchecktype
                        }
                        , btn: ['关闭'] //可以无限个按钮
                    });
                } else {
                    layer.msg('还没有核查完毕无法查看核查结果信息！');
                }
            }
        }
        ;


        //附件管理
        function uploadFuJian(singleData) {
            var row = singleData;
            if (row) {
                var v_ajdjid = row.resultid;
                var v_fjcsdlbh = "SYJGFJ";//附件参数大类编号：
                var v_dmlb = "SPJGFJ";//附件参数小类编号：
                var url = basePath + 'pub/pub/pubUploadFjListIndex?ajdjid=' + v_ajdjid + '&dmlb=' + v_dmlb + '&fjcsdlbh=' + v_fjcsdlbh + '&time=' + new Date().getMilliseconds();
                sy.modalDialog({
                    title: '附件管理'
                    , area: ['100%', '100%']
                    , content: url
                    , btn: ['关闭']
                });
            }
        }
        //文书管理
        function ws(singleData) {
            var row = singleData;
            var v_ajdjid = row.resultid;
            var v_fjcsdlbh = "SYJGFJ";//附件参数大类编号：
            var v_dmlb = "SPJGFJ";//附件参数小类编号：
            var url = basePath + "/pub/wsgldy/pubWsglIndex";
            sy.modalDialog({
                title: '文书管理'
                , area: ['100%', '100%']
                , content: url
                ,param:{
                    ajdjid: v_ajdjid,
                    comid:row.comid,
                    operatetype:'mobilecheck',
                    psbh: '<%=v_psbh%>',
                    nodeid: '<%=v_nodeid%>',
                    nodename: encodeURI(encodeURI('<%=v_nodename%>'))
                }
                , btn: ['关闭']
            });
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">检查项目信息</h2>

            <div class="layui-colla-content layui-show">
                <form id="myqueryform" class="layui-form" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">计划名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="plantitle" name="plantitle"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">检查对象</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="commc" name="commc"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">检查状态</label>

                                    <div class="layui-input-inline">
                                        <select id="resultstate" name="resultstate" lay-verify="required">
                                        </select>
                                    </div>

                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">检查开始时间</label>

                                    <div class="layui-inline">
                                        <input id="operatedate" name="operatedate" class="layui-input test-item"
                                               placeholder="yyyy-MM-dd" type="text">
                                    </div>
                                    &nbsp;-&nbsp;
                                    <div class="layui-inline">
                                        <input id="operateenddate" name="operateenddate" class="layui-input test-item"
                                               placeholder="yyyy-MM-dd" type="text">
                                    </div>

                                </div>
                            </div>
                            <div class="layui-col-md2 layui-col-xs6 layui-col-sm4 layui-col-sm-offset3 layui-col-xs-offset3 ">
                                <div class="layui-form-item">
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
        <div class="layui-btn-group demoTable">
            <ck:permission biz="viewResult">
                <button class="layui-btn" data-type="viewResult" data="btn_viewResult">查看结果明细</button>
            </ck:permission>
            <ck:permission biz="uploadSuperFuJian">
                <button class="layui-btn" data-type="uploadFuJian" data="btn_uploadFuJian">附件管理</button>
            </ck:permission>
            <ck:permission biz="viewResultinfo">
                <button class="layui-btn" data-type="viewResultinfo" data="btn_viewResultinfo">查看结果信息
                </button>
            </ck:permission>
            <ck:permission biz="ws">
                <button class="layui-btn" data-type="ws" data="btn_ws">文书</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="roleTable" lay-filter="paramgridfilter"></table>
    </div>
</div>

</body>
</html>