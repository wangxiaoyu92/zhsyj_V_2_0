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
	<title>监控企业监管员管理</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<script type="text/javascript">
        var ishavejgy = [{"id": "", "text": "==请选择=="}, {"id": "0", "text": "否"}, {"id": "1", "text": "是"}];
        var v_ishavejgy;
        // 是否指派监管员
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;
        var element;
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#jkyglTable'
//                ,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/jk/jkgl/queryJkqy'
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
//                        { field : 'jcypid', width : 100, title: '检测样品ID' ,event: 'trclick'}
                        {
                            field: 'jkqybh', width: 200, title: '监控企业ID', event: 'trclick'
                        }
                        , {
                            field: 'jkqymc', width: 200, title: '监控企业名称', event: 'trclick'

                        }
                        , {field: 'comdz', width: 200, title: '监控企业地址', event: 'trclick'}
                        , {
                            field: 'ishavejgy', width: 200, title: '监管人', event: 'trclick'
                            , templet: function (d) {
                                if (d.ishavejgy == "0") {
                                    return '<span style=color:red>暂未指派监管人</span>';
                                } else {
                                    return '<span style=color:green>已指派监管人</span>';
                                }
                            }
                        }

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
                        if (selectTableDataId != data.jkid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.jkid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    fzrJky: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择相应的监管企业！');
                        } else {
                            fzrJky(table.singleData);
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
            intSelectData('ishavejgy', ishavejgy);
        });

        // 查询
        function query() {
            var jkqybh = $('#jkqybh').val(); // 监控企业编号
            var jkqymc = $('#jkqymc').val(); // 监控企业名称
            var aaa027 = $('#aaa027').val(); // 监控企业统筹区
            var ishavejgy = $('#ishavejgy').val(); // 监控企业统筹区
            var param = {
                'jkqybh': jkqybh,
                'jkqymc': jkqymc,
                'aaa027': aaa027,
                'ishavejgy': ishavejgy
            };
            refresh(param, '');
        }

        // 刷新
        function refresh(param, cur) {
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('jkyglTable', {
                url: basePath + '/jk/jkgl/queryJkqy'
                , page: {
                    curr: curr
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

        // 指派负责人
        var fzrJky = function (row) {
            var url = "<%=basePath%>jsp/jk/jkqyfzr.jsp";
            sy.modalDialog({
                title: '指派负责人',
                param: {
                    comid: row.jkqybh,
                    a: new Date().getMilliseconds()
                },
                area: ['100%', '100%'],
                content: url,
                btn:['关闭'],
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);//不可缺少
                if (typeof(obj.type) != "undefined" && obj.type != null && obj.type == 'ok') {
                    refresh()
                }
                sy.removeWinRet(dialogID);//不可缺少
            })
        }

        function showMenu_aaa027() {
            var url = basePath + 'jsp/pub/pub/selectAaa027.jsp';
            sy.modalDialog({
                title: '监控',
                area: ['300px', '400px'],
                content: url
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);//不可缺少
                if (typeof(obj.type) != "undefined" && obj.type != null && obj.type == 'ok') {
                    $('#aaa027').val(obj.aaa027);
                    $('#aaa027name').val(obj.aaa027name);
                }
                sy.removeWinRet(dialogID);//不可缺少
            })
        }
	</script>
</head>
<body>
<div class="layui-fluid">
	<div class="layui-collapse">
		<div class="layui-colla-item">
			<h2 class="layui-colla-title">查询条件</h2>
			<div class="layui-colla-content layui-show">
				<form class="layui-form" id="myf" action="">
					<div class="layui-form-item">
						<label class="layui-form-label">所属统筹区:</label>
						<div class="layui-input-inline">
							<input class="layui-input" id="aaa027name" onclick="showMenu_aaa027();" readonly/>
							<input name="aaa027" id="aaa027" type="hidden"/>
							<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
								<ul id="treeDemo_aaa027" class="ztree"
									style="margin-top:0px;width:150px;height:450px;"></ul>
							</div>
						</div>
						<label class="layui-form-label" style="width: 160px">监控企业名称:</label>
						<div class="layui-input-inline">
							<input class="layui-input" id="jkqymc" name="jkqymc" autocomplete="off"
								   placeholder="请输入监控企业名称">
						</div>
						<label class="layui-form-label" style="width: 160px">监控企业编号:</label>
						<div class="layui-input-inline">
							<input class="layui-input" id="jkqybh" name="jkqybh" autocomplete="off"
								   placeholder="请输入监控企业编号">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">监控源编号:</label>
						<div class="layui-input-inline">
							<input class="layui-input" id="jkybh" name="jkybh" autocomplete="off"
								   placeholder="请输入监控源编号">
						</div>
						<label class="layui-form-label" style="width: 160px">是否指派监管员:</label>
						<div class="layui-input-inline">
							<select id="ishavejgy" name="ishavejgy" autocomplete="off"
									class="layui-input"></select>
						</div>
						<div class="layui-input-inline" style="padding-left: 101px">
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
				</form>
			</div>
		</div>
	</div>
	<div class="layui-margin-top-15">
		<div class="layui-btn-group demoTable">
			<ck:permission biz="fzrjgl">
				<button class="layui-btn " data-type="fzrJky" data="btn_fzrJgl">指派监管员</button>
			</ck:permission>
		</div>
		<table class="layui-hide" id="jkyglTable" lay-filter="tableFilter">

		</table>
	</div>
</div>
</body>
</html>