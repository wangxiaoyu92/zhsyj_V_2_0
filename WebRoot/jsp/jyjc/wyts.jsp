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
    String userkind = sysuser.getUserkind();

%>
<!DOCTYPE html>
<html>
<head>
    <title>投诉举报</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        var selectTableDataId;
        var v_sfgk = <%=SysmanageUtil.getAa10toJsonArray("SHIFOUBZ")%>;
        var mask;
        $(function () {
            layui.use(['form', 'table', 'layer', 'element', 'laydate'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                laydate = layui.laydate;
                var element = layui.element;
                laydate.render({
                    elem: '#sqstdate'
                });
                laydate.render({
                    elem: '#sqeddate'
                });
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#sqjccxTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'tmsyjhtgl/queryAqjgWyts'
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
                        {field: 'commc', title: '被投诉企业名称', event: 'trclick'}
                        , {
                            field: 'tsrmc', title: '投诉人名称', templet: function (d) {
                                if (d.tsrmc) {
                                    return d.tsrmc;
                                } else {
                                    return "匿名";
                                }
                            }, event: 'trclick'
                        }
                        , {field: 'tsnr', title: '投诉内容', event: 'trclick'}
                        , {field: 'tssj', title: '投诉时间', event: 'trclick'}
                        , {
                            field: 'sfsl', title: '是否受理'
                            , templet: function (d) {
                                return formatGridColData(v_sfgk, d.sfsl);
                            }, event: 'trclick'
                        }
                        , {field: 'slrxm', title: '受理人姓名', event: 'trclick'}
                        , {field: 'slyj', title: '受理意见', event: 'trclick'}
                        , {field: 'slsj', title: '受理时间', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.pcomtousuid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.pcomtousuid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    shouli: function () { // 受理
                        if (!table.singleData) {
                            layer.alert('请选择要受理的投诉！');
                        } else {
                            shouli(table.singleData.pcomtousuid, table.singleData.sfsl);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                //监听查询
                $("#btn_query").bind("click", function () {
                    query();
                    return false;
                });
            });
        });
        // 查询检测方法
        function query() {
            var param = {
                'comid': $('#comid').val()
            };
            table.reload('sqjccxTable', {
                url: basePath + 'tmsyjhtgl/queryAqjgWyts'
                , page: true
                , where: param //设定异步数据接口的额外参数
            });
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
            table.reload('sqjccxTable', {
                url: basePath + 'tmsyjhtgl/queryAqjgWyts'
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    layer.close(mask);
                }
            });
        }

        //受理
        function shouli(pcomtousuid, sfsl) {
            if (sfsl === '0') {
                layer.prompt({title: '请输入受理意见'}, function (value, index, elem) {
                    $.ajax({
                        url: basePath + "tmsyjhtgl/addAqjgWyts",
                        type: "post",
                        dataType: 'json',
                        data: {
                            slyj: value,
                            pcomtousuid: pcomtousuid
                        },
                        success: function (result) {
                            if (result.code == '0') {
                                layer.close(index);
                                layer.alert('受理成功', function (index) {
                                    layer.close(index);
                                    refresh();
                                })
                            } else {
                                layer.alert(result.msg);
                            }
                        }
                    });

                });
            } else {
                layer.alert("该投诉已被受理")
            }
        }
        //选择企业名称
        function myselectcom() {
            sy.modalDialog({
                title: '选择企业'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#commc").val(myrow.commc); //公司名称
                    $("#comid").val(myrow.comid); //公司代码
                }
            });
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
                    <div class="layui-row">
                        <div class="layui-col-md9 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">被投诉企业:</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="commc" name="commc" placeholder="请选择企业" readonly
                                           autocomplete="off" class="layui-input">
                                    <input type="hidden" id="comid" name="comid">
                                </div>
                                <div class="layui-input-inline" style="width: auto">
                                    <a href="javascript:void(0)" class="layui-btn"
                                       iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
                                </div>
                            </div>

                        </div>
                        <div class="layui-col-md3 layui-col-xs12 layui-col-sm6 ">
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
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="shouli">
                <button class="layui-btn" data-type="shouli" data="btn_shouli">受理</button>
            </ck:permission>
        </div>
    </div>
    <table class="layui-hide" id="sqjccxTable" lay-filter="tableFilter"></table>
</div>
</body>
</html>