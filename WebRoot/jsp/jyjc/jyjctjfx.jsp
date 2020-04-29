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
%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测统计分析</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        //检测检验类别
        var v_jcjylb = <%=SysmanageUtil.getAa10toJsonArray("JCJYLB")%>;
        // 检验检测结论
        var v_jyjcjl = <%=SysmanageUtil.getAa10toJsonArray("JYJCJL")%>;
        //检测检验审核标志
        var v_shbz = <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
        var jclb;
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;//进度条
        var laydate;
        var element;
        layui.use(['form', 'table', 'layer', 'element', 'laydate'], function () {
            form = layui.form;
            table = layui.table;
            layer = layui.layer;
            laydate = layui.laydate;
            element = layui.element;
            laydate.render({
                elem: '#ksSj'
            });
            laydate.render({
                elem: '#jssj'
            });
            function query() {
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                var jcjylb = $("#jcjylb option:selected").val();
                var param = {
                    'comid': $('#comid').val(),
                    'jcjylb': jcjylb,
                    'kssj': $('#ksSj').val(),
                    'jssj': $('#jssj').val()
                };
                if ($('#ksSj').val() > $('#jssj').val()) {
                    layer.msg('开始日期不能大于结束日期！')
                    return;
                }
                if (jcjylb == 'jcypmc') {
                    table.render({
                        elem: '#jyjcsjcxTable'
//                ,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                        , url: basePath + 'jyjc/queryJyjctjfx'
                        , page: true // 展示分页
                        , where: param
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
//                        { field : 'jcypid', width : 100, title: '检测样品ID' ,event: 'trclick'},
                            {field: 'ypmc', width: 200, title: '样品名称', event: 'trclick'}
                            , {field: 'jccs', width: 200, title: '检查次数', event: 'trclick'}
                            , {field: 'hgcs', width: 200, title: '合格次数', event: 'trclick'}
                            , {field: 'cbcs', width: 200, title: '超标次数', event: 'trclick'}
                            , {field: 'hgl', width: 200, title: '合格率', event: 'trclick'}
                            , {field: 'cbl', width: 200, title: '超标率', event: 'trclick'}
                        ]]
                        , done: function (res, curr, count) {
                            layer.close(mask);
                        }
                    });
                } else if (jcjylb == 'jcxmmc') {
                    table.render({
                        elem: '#jyjcsjcxTable'
//                ,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                        , url: basePath + 'jyjc/queryJyjctjfx'
                        , page: true // 展示分页
                        , where: param
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
//                        { field : 'jcypid', width : 100, title: '检测样品ID' ,event: 'trclick'},
                            {field: 'jcxmmc', width: 200, title: '项目名称', event: 'trclick'}
                            , {field: 'jccs', width: 200, title: '检查次数', event: 'trclick'}
                            , {field: 'hgcs', width: 200, title: '合格次数', event: 'trclick'}
                            , {field: 'cbcs', width: 200, title: '超标次数', event: 'trclick'}
                            , {field: 'hgl', width: 200, title: '合格率', event: 'trclick'}
                            , {field: 'cbl', width: 200, title: '超标率', event: 'trclick'}
                        ]]
                        , done: function (res, curr, count) {
                            layer.close(mask);
                        }
                    });
                }
            }

            // 监听工具条
            /*table.on('tool(tableFilter)', function (obj) {
             var data = obj.data;
             if (obj.event === 'trclick') { // 选中行
             if (selectTableDataId != data.comid) {
             // 清除所有行的样式
             $(".layui-table-body tr").each(function (k, v) {
             $(v).removeAttr("style");
             });
             $(obj.tr.selector).css("background", "#90E2DA");
             table.singleData = data;
             selectTableDataId = data.comid;
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
             });*/
            //监听提交
            $("#btn_query").bind("click", function () {
                query();
                return false;
            });
        });
        //		function query() {
        //
        //            table.reload('jyjgiTable', {
        //                url: basePath + 'jyjc/queryJyjctjfx'
        //                , page: {
        //                    curr: 1 //重新从第 1 页开始
        //                }
        //                , where: param //设定异步数据接口的额外参数
        //            });
        //        }
        //从单位信息表中读取
        function myselectcom() {
            sy.modalDialog({
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
                    $("#commc").val(myrow.commc); //公司名称
                    $("#comdm").val(myrow.comdm); //公司代码
                    $("#comid").val(myrow.comid);//公司id
                }
            });
        }
        // 刷新
        function refresh(param) {
            table.singleData = '';
            selectTableDataId = '';
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('jyjgiTable', {
                url: basePath + 'jyjc/queryJyjcjg'
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    layer.close(mask);
                }
            });
            /*		parent.window.refresh();*/
        }


        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == "") {
                return;
            }
            sy.removeWinRet(dialogID);
            if (obj.type == "ok") {
                refresh();
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
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">选择类别：</label>

                                    <div class="layui-input-inline">
                                        <select id="jcjylb" name="jcjylb">
                                            <option value="jcypmc">样品种类</option>
                                            <option value="jcxmmc">项目种类</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">企业编号:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="comdm" readonly name="comdm"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                    <div class="layui-input-inline" style="width: auto">
                                        <a href="javascript:void(0)" class="layui-btn"
                                           iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">检测日期:</label>

                                    <div class="layui-input-inline" style="width: auto">
                                        <input type="text" id="ksSj" name="ksSj"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid">--</div>
                                    <div class="layui-input-inline" style="width: auto">
                                        <input type="text" id="jssj" name="jssj"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
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
    <table class="layui-hide" id="jyjcsjcxTable" lay-filter="tableFilter">
        <%--<input type="hidden" id="jcjgid" name="jcjgid">--%>
        <input type="hidden" id="comid" name="comid">
    </table>
</div>
</body>
</html>