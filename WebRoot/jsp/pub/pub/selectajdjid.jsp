<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.service.AjdjService,com.zzhdsoft.siweb.entity.workflow.Wf_node" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
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
    String commc = StringHelper.showNull2Empty(request.getParameter("commc"));
%>
<!DOCTYPE html>
<html>
<head>

    <title>案件登记</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        // 案件状态
        var v_ajzt = <%=SysmanageUtil.getAa10toJsonArray("AJZT")%>;
        // 案件登记案件来源
        var v_AJDJAJLY = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
        // 案件受理标志
        var v_slbz = <%=SysmanageUtil.getAa10toJsonArray("SLBZ")%>;
        // 案件结束标志
        var V_AJJSBZ = <%=SysmanageUtil.getAa10toJsonArray("AJJSBZ")%>;
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;
        var selectTableDataId = '';
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                intSelectData('slbz', v_slbz);
                intSelectData('ajjsbz', V_AJJSBZ);
                form.render();
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#ajdjTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/zfba/ajdj/queryAjdj'
                    , where: {'commc': '<%=commc%>'}
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
                        {field: 'ajdjid', width: 150, title: '案件登记ID', event: 'trclick'}
                        , {field: 'commc', width: 150, title: '企业名称', event: 'trclick'}
                        , {field: 'comdz', width: 150, title: '企业地址', event: 'trclick'}
                        , {field: 'comfrhyz', width: 80, title: '企业法人', event: 'trclick'}
                        , {field: 'comfrsfzh', width: 130, title: '企业法人身份证号', event: 'trclick'}
                        , {field: 'comyddh', width: 120, title: '联系电话', event: 'trclick'}
                        , {field: 'ajdjafsj', width: 100, title: '案发时间', event: 'trclick'}
                        , {field: 'ajdjay', width: 150, title: '案由', event: 'trclick'}
                        , {
                            field: 'ajdjajly', width: 150, title: '案件来源'
                            , templet: function (d) {
                                return formatGridColData(v_AJDJAJLY, d.ajdjajly);
                            }
                            , event: 'trclick'
                        }
                        , {
                            field: 'slbz', width: 90, title: '受理标志'
                            , templet: function (d) {
                                return formatGridColData(v_slbz, d.slbz);
                            }
                            , event: 'trclick'
                        }
                        , {
                            field: 'ajjsbz', width: 80, title: '结束标志'
                            , templet: function (d) {
                                return formatGridColData(V_AJJSBZ, d.ajjsbz);
                            }
                            , event: 'trclick'
                        }
                        , {field: 'slczy', width: 100, title: '受理人', event: 'trclick'}
                        , {field: 'slsj', width: 100, title: '受理时间', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(AjdjFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.ajdjid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.ajdjid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
            $("#btn_query").click(function () {
                query();
                return false;
            })
        });
        // 窗口关闭回掉函数
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
        //查询
        function query() {
            var param = {
                'comdm': $('#comdm').val(),
                'commc': $('#commc').val(),
                'slbz': $('#slbz').val(),
                'ajjsbz': $('#ajjsbz').val()
            };
            refresh(param, '');
        }
        // 刷新
        function refresh(param, cur) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            table.reload('ajdjTable', {
                url: basePath + '/zfba/ajdj/queryAjdj'
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

        function queding(){
            if (table.singleData != null && table.singleData != '') {
                var obj = new Object();
                obj.data = table.singleData;
                obj.type = "ok";
                sy.setWinRet(obj);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            } else {
                layer.alert('请选择任务！');
            }
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show">
                <%--<form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">企业编号:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="comdm" name="comdm" readonly
                                               autocomplete="off" class="layui-input">
                                    </div>
                                    <div class="layui-input-inline" style="width: auto">
                                        <a href="javascript:void(0)" class="layui-btn"
                                           iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">企业名称:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="commc" name="commc"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">受理标志:</label>

                                    <div class="layui-input-inline">
                                        <select id="slbz" name="slbz"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">案件结束标志:</label>

                                    <div class="layui-input-inline">
                                        <select id="ajjsbz" name="ajjsbz"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs2 layui-col-sm2">
                                <div class="layui-form-item">
                                </div>
                            </div>
                            <div class="layui-col-md2 layui-col-xs4 layui-col-sm4">
                                <div class="layui-form-item">
                                    <div class="layui-input-inline" style="width: auto">
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
                </form>--%>
                待定.....
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <table class="layui-hide" id="ajdjTable" lay-filter="AjdjFilter"></table>
    </div>
</div>
</body>
</html>