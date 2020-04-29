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
	<title>监控源管理</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<script type="text/javascript">
        //下拉框列表
        var state = <%=SysmanageUtil.getAa10toJsonArray("AAA104")%>;
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
                    , url: basePath + '/jk/jkgl/queryJky'
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
                            field: 'jkid', width: 100, title: '监控源ID', event: 'trclick'
                        }
                        , {field: 'jkqybh', width: 100, title: '监控企业编号', event: 'trclick'}
                        , {
                            field: 'jkqymc', width: 100, title: '监控企业名称', event: 'trclick'

                        }
                        , {
                            field: 'ishavejgy', width: 100, title: '监管人', event: 'trclick'
                            , templet: function (d) {
                                if (d.ishavejgy == "0") {
                                    return '<span style=color:red>暂未指派监管人</span>';
                                } else {
                                    return '<span style=color:green>已指派监管人</span>';
                                }
                            }
                        }
                        , {field: 'jkybh', width: 100, title: '监控源编号', event: 'trclick'}
                        , {field: 'jkymc', width: 100, title: '监控源名称', event: 'trclick'}
                        , {field: 'jklx', width: 100, title: '监控类型', event: 'trclick'}
                        , {field: 'orderno', width: 100, title: '显示顺序', event: 'trclick'}
                        , {field: 'aaa027name', width: 100, title: '统筹区', event: 'trclick'}

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
                    addPcom: function () { // 添加
                        addPcom();
                    }
                    , updatePcom: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请先选择要修改的记录！');
                        } else {
                            updatePcom(table.singleData.jkid);
                        }
                    }
                    , delPcom: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的记录！');
                        } else {
                            delPcom(table.singleData);
                        }
                    }
                    , fzrJky: function () {
                        fzrJky();
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
            intSelectData('state', state);

            var vSysUser ='<%=SysmanageUtil.getSysuser().getUsername()%>';
            //删除权限
            //导入功能（admin 才有）
            if (vSysUser == "admin" || vSysUser == "tygly") {
                $('.delete').css('display', '');
            }


        });

        // 查询
        function query() {
            var jkqybh = $('#jkqybh').val();
            var jkqymc = $('#jkqymc').val();
            var jkybh = $('#jkybh').val();
            var state = $('#state').val();
            var param = {
                'jkqybh': jkqybh,
                'jkqymc': jkqymc,
                'jkybh': jkybh,
                'state': state
            };
            refresh(param, "");
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
                url: basePath + '/jk/jkgl/queryJky'
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

        // 新增
        function addPcom() {
            sy.modalDialog({
                title: '新增监控源',
                area: ['100%', '100%'],
                content: basePath +'/jk/jkgl/jkyglFormIndex'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
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

        // 编辑
        function updatePcom() {
            sy.modalDialog({
                title: '编辑监控源',
                area: ['100%', '100%'],
                url: basePath + '/jk/jkgl/jkyglFormIndex?jkid=' + row.jkid,
                btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        };


        // 删除
        function delPcom(row) {
            var jkid=row.jkid;
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/jk/jkgl/delJky', {
                            jkid: jkid
                        },
                        function (result) {
                            if (result.code == '0') {
                                table.singleData = '';
                                selectTableDataId = '';
                                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                layer.msg('删除成功', {time: 1000}, function () {
                                    //如果是本页最后一条数据 则返回上一页
                                    if (table.cache.jkyglTable.length == 1) {
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

        // 指派负责人
        function fzrJky() {
            var url = "<%=basePath%>jsp/jk/selectFzr.jsp";
            sy.modalDialog({
                title: '指派负责人',
                param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true"
                },
                area:['100%','100%'],
                content: url,
                btn:['保存','关闭'],
                btn1:function (index, layero) {
                    window[layero.find('iframe')[0]['name']].mysave();
                }
            },function () {
                refresh();
            })
        }
        // 导入
        var jkydrIndex = function () {
            sy.modalDialog({
                title: '导入监控源',
                area:['100%','100%'],
                content: basePath + '/jg/jkgl/jkydrIndex',
                btn:['关闭']
            });
        };

        function showMenu_aaa027() {
            var url = basePath + 'jsp/pub/pub/selectAaa027.jsp';
            sy.modalDialog({
                title: '监控',
                area:['300px','400px'],
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
						<label class="layui-form-label" style="width: 160px">在线状态:</label>
						<div class="layui-input-inline">
							<select id="state" name="state" autocomplete="off"
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
			<ck:permission biz="addPcom">
				<button class="layui-btn" data-type="addPcom" data="btn_addPcom">增加</button>
			</ck:permission>
			<ck:permission biz="updatePcom">
				<button class="layui-btn" data-type="updatePcom" data="btn_updatePcom">修改</button>
			</ck:permission>
			<ck:permission biz="delPcom">
				<button class="layui-btn layui-btn-danger" data-type="delPcom" data="btn_delPcom">删除</button>
			</ck:permission>
			<ck:permission biz="fzrJky">
				<button class="layui-btn " data-type="fzrJky" data="btn_fzrJky">指派负责人</button>
			</ck:permission>
		</div>
		<table class="layui-hide" id="jkyglTable" lay-filter="tableFilter">

		</table>
	</div>
</div>
</body>
</html>