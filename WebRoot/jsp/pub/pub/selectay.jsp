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
    <title>案件登记</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        // 案件登记案件大类
        var v_aae140 = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var selectTableDataId = '';
        $(function () {
            initSelectList();
            layui.use(['table', 'form', 'element', 'layer'], function () {
                table = layui.table;
                form = layui.form;
                layer = layui.layer;
                var element = layui.element;
                table.render({
                    elem: '#table'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/pub/pub/querySelectay'
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
                            field: 'ajdjajdl', width: 80, title: '案件大类'
                            , templet: function (d) {
                            return sy.formatGridCode(v_aae140, d.ajdjajdl);
                        }, event: 'trclick'
                        }
                        , {field: 'wfxwms', width: 380, title: '违法行为描述', event: 'trclick'}
                        , {field: 'wfxwwffg', width: 130, title: '违反法规', event: 'trclick'}
                        , {field: 'wfxwwftk', width: 150, title: '违反条款', event: 'trclick'}
                        , {field: 'wfxwwftknr', width: 300, title: '违反条款内容', event: 'trclick'}
                        , {field: 'wfxwcffg', width: 120, title: '处罚法规', event: 'trclick'}
                        , {field: 'wfxwcffgtk', width: 150, title: '处罚法规条款', event: 'trclick'}
                        , {field: 'wfxwcffgtknr', width: 150, title: '处罚法规条款内容', event: 'trclick'}
                        , {field: 'wfxwcfnr', width: 150, title: '处罚内容', event: 'trclick'}
                        , {field: 'wfxwbz', width: 150, title: '备注', event: 'trclick'}
                    ]]
                });
                // 监听工具条
                table.on('tool(AyFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.pwfxwcsid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.pwfxwcsid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

//		var $ = layui.$, active = {
//			queding: function () { // 添加
//				if (!table.singleData) {
//					parent.layer.alert('请先选择违法行为信息！！');
//				} else {
//					queding(table.singleData);
//				}
//			}
//		};
//		$('.demoTable .layui-btn').on('click', function () {
//			var type = $(this).data('type');
//			active[type] ? active[type].call(this) : '';
//		});
            });
            $("#btn_query").click(function () {
                query();
                return false;
            })
        });
        function initSelectList() {
            var aae140Options = '';
            for (var i = 0; i < v_aae140.length; i++) {
                aae140Options += '<option value=\'' + v_aae140[i].id + '\' >' + v_aae140[i].text + '</option>';
            }
            $("#aae140").append(aae140Options)
        }
        // 查询
        function query() {
            var param = {
                'wfxwbh': $('#wfxwbh').val(),
                'wfxwms': $('#wfxwms').val(),
                'wfxwwftk': $('#wfxwwftk').val(),
                'ajdjajdl': $('#aae140').val()
            };
            table.reload('table', {
                url: basePath + '/pub/pub/querySelectay'
                , where: param //设定异步数据接口的额外参数
            });
        }

        //确定
        function queding() {
            if (table.singleData != null && table.singleData != '') {
                var obj = new Object();
                obj.data = table.singleData;
                obj.type = "ok";
                sy.setWinRet(obj);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            } else {
                layer.alert('请选择案由！');
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
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <input type="text" id="wfxwbh" name="wfxwbh" hidden="hidden">

                    <div class="layui-form-item">
                        <label class="layui-form-label">违法行为描述</label>

                        <div class="layui-input-inline">
                            <input type="text" id="wfxwms" name="wfxwms"
                                   autocomplete="off" class="layui-input">
                        </div>
                        <label class="layui-form-label">案件大类</label>

                        <div class="layui-input-inline">
                            <select id="aae140" name="aae140"></select>
                        </div>
                        <label class="layui-form-label">违反条款</label>

                        <div class="layui-input-inline">
                            <input type="text" id="wfxwwftk" name="wfxwwftk"
                                   autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-input-inline">
                            <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                <i class="layui-icon">&#xe615;</i>搜索
                            </button>
                            <button class="layui-btn layui-btn-sm layui-btn-normal">
                                <i class="layui-icon">&#xe621;</i>重置
                            </button>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <%--<label class="layui-form-label">违反条款</label>

                        <div class="layui-input-inline">
                            <input type="text" id="wfxwwftk" name="wfxwwftk"
                                   autocomplete="off" class="layui-input">
                        </div>
                        <label class="layui-form-label"></label>
                        <div class="layui-input-inline">
                            <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                <i class="layui-icon">&#xe615;</i>搜索
                            </button>
                            <button class="layui-btn layui-btn-sm layui-btn-normal">
                                <i class="layui-icon">&#xe621;</i>重置
                            </button>
                        </div>--%>
                        <%--<div class="layui-btn-group demoTable">--%>
                        <%--<div>--%>
                        <%--<button id="btn_query" class="layui-btn layui-btn-sm">查询</button>--%>
                        <%--<button class="layui-btn layui-btn-sm" id="btn_reset">重置</button>--%>
                        <%--</div>--%>
                        <%--</div>--%>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <table class="layui-hide" id="table" lay-filter="AyFilter"></table>
    </div>
</div>
</body>
</html>