<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String aaa102 = StringHelper.showNull2Empty(request.getParameter("aaa102"));
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String querytype = StringHelper.showNull2Empty(request.getParameter("querytype"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>企业信息</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>

    <script type="text/javascript">
        var mygrid;
        var singleSelect = sy.getUrlParam("singleSelect");
        var v_singleSelect = (singleSelect == "true");
        var v_comjyjcbz = sy.IsNull(sy.getUrlParam("comjyjcbz"));

        var form;
        var table;
        var layer;
        var selectTableDataId = '';
        var mask;//进度条
        var mc = '企业';
        $(function () {
            if ("jyjc" == '<%=querytype%>') {
                mc = '机构'
            }
            var a = $(".layui-form-label");
            for (var i = 0; i < a.length; i++) {
                var b = a.eq(i).text();
                if (b) {
                    a.eq(i).text(mc + b);
                }
            }
            initData();
            $('#btn_query').click(function () {
                query();
                return false;
            })
            $('#btn_queding').click(function () {
                queding();
                return false;
            })
            if ('<%=op%>' == 'view') {
                $('#btn_queding').show();
                $('#reset').hide();
            } else {
                $('#btn_queding').hide();
            }
        })
        function initData() {
            var param;
            if ('jyjc' == '<%=querytype%>') {
                param = {comdalei: '106001', comjyjcbz: '1'}
            } else {
                param = {};
            }
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                var element = layui.
                        table.render({
                            elem: '#roleTable'
                            , url: basePath + '/pub/pub/querySelectcom'
                            , where: param
                            , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                            , page: true // 展示分页
                            , limit: 10 // 每页展示条数
                            , limits: [10, 20, 30] // 每页条数选择项
                            , cellMinWidth: 80 //全局定义常规单元格的最小宽度
                            , request: {
                                pageName: 'page' //页码的参数名称，默认：page
                                , limitName: 'rows' //每页数据量的参数名，默认：limit
                            }
                            , response: {
                                countName: 'total' //数据总数的字段名称，默认：count
                                , dataName: 'rows' //数据列表的字段名称，默认：data
                            }
                            , cols: [[
//                                {type: 'checkbox'}
                                {field: 'comid', title: mc + 'id', event: 'trclick'}
                                , {field: 'comdm', title: mc + '代码', event: 'trclick'}
                                , {field: 'commc', title: mc + '名称', width: 260, event: 'trclick'}
//                                , {field: 'comdalei', title: mc + '大类', event: 'trclick'}
                                , {field: 'comdaleistr', title: mc + '大类', event: 'trclick'}
                                , {field: 'comxkzbh', title: '许可证编号', event: 'trclick'}
                                , {field: 'comfrhyz', title: mc + '法人/业主', event: 'trclick'}
                                , {field: 'comfrsfzh', title: mc + '法人/业主身份证号', event: 'trclick'}
                                , {field: 'comfzr', title: mc + '负责人', event: 'trclick'}
                                , {field: 'comgddh', title: '固定电话', event: 'trclick'}
                                , {field: 'comyddh', title: '移动电话', event: 'trclick'}
                                , {field: 'comdz', title: mc + '地址', event: 'trclick'}
                            ]]
                            , done: function (res, curr, count) {
                                table.singleData = '';
                                selectTableDataId = '';
                                layer.close(mask);
                            }
                        });
                // 监听工具条
                table.on('tool(paramgridfilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.comid) {
                            // 清除所有行的样式
                            $($("#roleTable").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#roleTable").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.comid;
                        } else { // 再次选中清除样式
                            $("#roleTable").next().find(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
//                //监听复选框
//                table.on('checkbox(paramgridfilter)', function (obj) {
//                    var checkStatus = table.checkStatus('roleTable');
//                    xz = checkStatus.data.length;//获取被选中的个数
//                    paramgridfilterData = checkStatus.data;//获取被选中的数据
//                });

//                var $ = layui.$, active = {
//                    viewResult: function () { //获取选中数据
//                        var checkStatus = table.checkStatus('roleTable')
//                                , data = checkStatus.data;
//                        if (data != "") {
//                            viewResult(data);
//                        } else {
//                            layer.alert("请选择企业信息");
//                        }
//
//                    }
//                };
//                $('.demoTable .layui-btn').on('click', function () {
//                    var type = $(this).data('type');
//                    active[type] ? active[type].call(this) : '';
//                });

            })
            //重置
            $('#reset').click(function () {
                reset();
                return false;
            })
        }

        //确定
        function queding() {
            if (table.singleData != null && table.singleData != '') {
                var obj = new Object();
                obj.data = table.singleData;
                obj.type = "ok";
                sy.setWinRet(obj);
                if ('<%=op%>' == 'view') {
                    parent.$("#" + sy.getDialogId()).dialog("close");
                } else {
                    parent.layer.close(parent.layer.getFrameIndex(window.name));
                }
            } else {
                layer.alert('请选择' + mc + '信息！');
            }
        }

        //重置
        function reset() {
            table.singleData = '';
            selectTableDataId = '';
            $('#comdm').val('');
            $('#commc').val('');
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            if ('jyjc' == '<%=querytype%>') {
                var param = {
                    comdalei: '106001',
                    comjyjcbz: '1',
                    comdm: '',
                    commc: ''
                }
            } else {
                var param = {
                    'comdm': '',
                    'commc': '',
                    'comjyjcbz': ''
                };
            }

            table.reload('roleTable', {
                url: basePath + '/pub/pub/querySelectcom'
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }
        //查询
        function query() {
            if ('jyjc' == '<%=querytype%>') {
                var param = {
                    comdalei: '106001',
                    comjyjcbz: '1',
                    'comdm': $('#comdm').val(),
                    'commc': $('#commc').val()
                }
            } else {
                var param = {
                    'comdm': $('#comdm').val(),
                    'commc': $('#commc').val(),
                    'comjyjcbz': ''
                };
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('roleTable', {
                url: basePath + '/pub/pub/querySelectcom'
                , page: true
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
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
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label">名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="commc" name="commc"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label">编号</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="comdm" name="comdm"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline">
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                            <i class="layui-icon">&#xe615;</i>搜索
                                        </button>
                                        <button id="btn_queding" class="layui-btn layui-btn-sm layui-btn-normal">
                                            <i class="layui-icon">&#xe615;</i>确定
                                        </button>
                                        <button class="layui-btn layui-btn-sm layui-btn-normal" id="reset">
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
        <table class="layui-hide" id="roleTable" lay-filter="paramgridfilter"></table>
    </div>
</div>
</body>
</html>