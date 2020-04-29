<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
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
    <title>执法人员</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
    <script type="text/javascript">
        var grid;
        var v_zfrylybm = <%=SysmanageUtil.getAa10toJsonArray("ZFRYLYBM")%>;
        var selectTableDataId = '';
        var singleData = '';
        var form;
        var table;
        var layer;
        var mask;//进度条
        $(function () {
            //执法领域下拉框
            intSelectData('zfrylybm', v_zfrylybm);
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                layer = layui.layer;
                table = layui.table;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#grid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/zfba/zfrygl/findZfry'
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
                        {field: 'userid', title: '用户ID', event: 'trclick'}
                        , {field: 'zfryid', width: 100, title: '执法人员ID', event: 'trclick'}
                        , {field: 'username', title: '用户名', event: 'trclick'}
                        , {field: 'description', title: '描述', event: 'trclick'}
                        , {field: 'zfrypym', width: 100, title: '姓名拼音码', event: 'trclick'}
                        , {field: 'zfryxb', title: '性别', event: 'trclick'}
                        , {field: 'zfrycsrq', title: '出生日期', event: 'trclick'}
                        , {field: 'zfrysfzh', title: '身份证号', event: 'trclick'}
                        , {field: 'zfryzjhm', title: '证件号码', event: 'trclick'}
                        , {field: 'mobile', title: '手机号', event: 'trclick'}
                        , {field: 'orgname', title: '机构名', event: 'trclick'}
                        , {field: 'zfryzflymc', title: '执法领域', event: 'trclick'}
                        , {field: 'zfryzw', width: 110, title: '执法人员职务', event: 'trclick'}
                        , {field: 'aaa027', width: 100, title: '统筹区编码', event: 'trclick'}
                        , {field: 'zfrybz', title: '备注', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(grid)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.userid) {
                            // 清除所有行的样式
                            $($("#grid").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#grid").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.userid;
                        } else { // 再次选中清除样式
                            $("#grid").next().find(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    updateZfry: function () {//修改
                        if (!table.singleData) {
                            parent.layer.alert('请选择要修改的信息！');
                        } else {
                            updateZfry(table.singleData.userid);
                        }
                    }
                    , showZfry: function () {//查看
                        if (!table.singleData) {
                            parent.layer.alert('请选择要查看的信息！');
                        } else {
                            showZfry(table.singleData);
                        }
                    }
                };
                //按钮监测
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            })
            //查询
            $('#btn_query').click(function () {
                query();
                return false;
            })
        });

        // 查询
        function query() {
            var mobile = $('#mobile').val();
            var v_zfrylybm2 = $('#zfrylybm').val();
            var param = {
                'mobile': mobile,
                'zfrylybm': v_zfrylybm2
            };
            table.reload('grid', {
                url: basePath + '/zfba/zfrygl/findZfry'
                , page: true
                , where: param //设定异步数据接口的额外参数
            });
        }
        //修改
        function updateZfry(userid) {
            var url = basePath + '/zfba/zfrygl/pzfryFormIndex?userid=' + userid;
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '编辑执法人员'
                , content: url
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].save();
                }
            }, closeModalDialogCallback);
        }
        //查看
        function showZfry(data) {
            var url = basePath + '/zfba/zfrygl/pzfryFormIndex?op=view&userid=' + data.userid + '&zfryid=' + data.zfryid;
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '查看执法人员'
                , content: url
                , btn: ['关闭']
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
                table.singleData = '';
                selectTableDataId = '';
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.reload('grid', {
                    url: basePath + '/zfba/zfrygl/findZfry'
                    , page: {
                        curr: curent //重新从第 1 页开始
                    }
                    , done: function (res, curr, count) {
                        layer.close(mask);
                    }
                });
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
                <form class="layui-form" id="fm" style="height: auto">
                    <input name="zfryzflybm" id="zfryzflybm" type="hidden"/>
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 100px">手机号/姓名/姓名简写/登陆号</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="mobile" name="mobile" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">执法领域</label>

                                    <div class="layui-input-inline">
                                        <select name="zfrylybm" id="zfrylybm"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

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
            <ck:permission biz="updateZfry">
                <button class="layui-btn" data-type="updateZfry" data="btn_updateZfry">修改
                </button>
            </ck:permission>
            <ck:permission biz="showZfry">
                <button class="layui-btn" data-type="showZfry" data="btn_showZfry">查看
                </button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="grid" lay-filter="grid"></table>
    </div>
</div>
</body>
</html>