<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 监控企业id
	String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>指派监控人</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
	<script type="text/javascript">
        //var obj = new Object();
        //obj.type = 'ok';
        //window.returnValue = obj;
        //	var grid; // 用户信息表
        var jkqyfzrgrid; // 小组成员关系表
        // 组织结构树
        var setting = {
            async: {
                enable: true, //启用异步加载
                url: basePath + '/sysmanager/sysorg/querySysorgZTreeAsync',  //调用后台的方法
                autoParam: ["orgid"], //向后台传递的参数
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "orgid",
                    pIdKey: "parent",
                    rootPId: 0
                },
                key: {
                    name: "orgname"
                }
            },
            callback: {
                onClick: onClick
            }
        };

        $(function () {
            refreshZTree();
        });

        //初始化zTree树
        function refreshZTree() {
            $.fn.zTree.init($("#treeDemo"), setting);
        }

        // 数据过滤
        function ajaxDataFilter(treeId, parentNode, responseData) {
            var array = [];
            var zNodes = eval(responseData.orgData);//获取后台传递的数据
            return zNodes;
        }

        //单击节点事件
        function onClick(event, treeId, treeNode) {
//		grid.datagrid({
//			url : basePath + '/sysmanager/sysuser/querySysuser',
//			queryParams : {'orgid':treeNode.orgid}
//		});
//		grid.datagrid('unselectAll');
            var param = {
                'orgid': treeNode.orgid
            }
            refresh(param, '');
        }

        var selectTyTableData= new Array();
        var selectQyTableData= new Array();
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
                    elem: '#ryTable'
//                ,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
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
                        {type: 'checkbox'},
                        {
                            field: 'username', width: 200, title: '用户', event: 'trclick'
                        }
                        , {
                            field: 'description', width: 200, title: '用户描述', event: 'trclick'

                        }
                        , {field: 'mobile2', width: 200, title: '手机号', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        layer.close(mask);
                    }
                });
                table.render({
                    elem: '#qyjgrTable',
                    url: basePath + 'jk/jkgl/queryJkfzrList'
//                ,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    ,where:{
                        comid : '<%=v_comid%>'
                    }
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
                        {type: 'checkbox'},
                        {
                            field: 'username', width: 200, title: '用户', event: 'trclick'
                        }
                        , {
                            field: 'mobile2', width: 200, title: '手机号', event: 'trclick'

                        }
                        , {field: 'bmmc', width: 200, title: '部门名称', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                table.on('checkbox(ryTable)', function(obj){
                    selectTyTableData.push(obj.data);
                });
                table.on('checkbox(qyTable)', function(obj){
                    selectQyTableData.push(obj.data);
                });
                var $ = layui.$, active = {
                    addJdr: function () {
                        if(selectTyTableData.length==0){
                            layer.alert("您未选择任何数据!")
                        }else{
                            addUserToJkqyFzr(selectTyTableData);
                        }
                    }
                    ,delJdr:function () {
                        if(selectQyTableData.length==0){
                            layer.alert("您未选择任何数据!")
                        }else{
                            delJkqyFzr(selectQyTableData);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                //监听提交
                $("#btn_query").bind("click", function () {
                    return false;
                });
            });

        });


        // 添加用户到监管人(多选)
        function addUserToJkqyFzr(rows) {
            var rygrid_rows = $.toJSON(rows);
            var param = {
                'rygrid_rows': rygrid_rows,
                'comgrid_rows': $.toJSON([{comid: '<%=v_comid%>'}])
            };
            $.post(basePath + 'jk/jkgl/saveJkFzr', param, function (result) {
                if (result.code == '0') {
                    layer.msg('操作成功', {time: 1000},function () {
                        //刷新的时候显示进度条
                        var mask = layer.load(1, {shade: [0.1, '#393D49']});
                        table.reload('qyjgrTable', {
                            url: basePath + 'jk/jkgl/queryJkfzrList'
                            , page: {
                                curr: 1
                            }
                            , done: function () {
                                selectTyTableData=new Array();
                                layer.close(mask);
                            }
                        });
                    });
                } else {
                    layer.open({
                        title: '提示'
                        , content: '操作失败' + result.msg
                    });
                }
            }, 'json');
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
            table.reload('ryTable', {
                url: basePath + '/sysmanager/sysuser/querySysuser'
                , page: {
                    curr: curr
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    layer.close(mask);
                }
            });
            /*		parent.window.refresh();*/
        }

        // 移除
        function delJkqyFzr(rows) {
            var rygrid_rows = $.toJSON(rows);
            var param = {
                'rygrid_rows': rygrid_rows,
                'comid': '<%=v_comid%>'
            };
            $.post(basePath + 'jk/jkgl/delJkqyFzr', param, function (result) {
                if (result.code == '0') {
                    layer.msg('操作成功', {time: 1000},function () {
                        //刷新的时候显示进度条
                        var mask = layer.load(1, {shade: [0.1, '#393D49']});
                        table.reload('qyjgrTable', {
                            url: basePath + 'jk/jkgl/queryJkfzrList'
                            , page: {
                                curr: 1
                            }
                            , done: function () {
                                selectQyTableData=new Array();
                                layer.close(mask);
                            }
                        });
                    });
                } else {
                    layer.open({
                        title: '提示'
                        , content: '操作失败' + result.msg
                    });
                }
            }, 'json');
        }
	</script>
</head>
<body class="layui-layout-body">
<div class="content_wrap">
	<div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree" style="height: 600px"></ul>
	</div>
</div>
<div class="layui-body" style="margin-left: 55px; width: 79%;">
	<div class="layui-collapse">
		<div class="layui-colla-item">
			<h2 class="layui-colla-title">人员信息列表</h2>
			<div class="layui-colla-content layui-show">
				<div class="layui-btn-group demoTable" style="margin-top: 10px">
					<ck:permission biz="addJdr">
						<button class="layui-btn " data-type="addJdr" data="btn_addJdr">添加监督人</button>
					</ck:permission>
				</div>
				<table class="layui-hide" id="ryTable" lay-filter="ryTable">
					<input type="hidden" id="userid" name="userid">
					<input type="hidden" id="aaa027" name="aaa027">
				</table>
			</div>
		</div>
	</div>
	<div class="layui-collapse">
		<div class="layui-colla-item">
			<h2 class="layui-colla-title">企业监管人列表</h2>
			<div class="layui-colla-content layui-show">
				<div class="layui-btn-group demoTable" style="margin-top: 10px">
					<ck:permission biz="delJdr">
						<button class="layui-btn layui-btn-danger" data-type="delJdr" data="btn_delJdr">删除</button>
					</ck:permission>
				</div>
				<table class="layui-hide" id="qyjgrTable" lay-filter="qyTable">
					<input type="hidden" id="jkqyfzrid" name="jkqyfzrid">
					<input type="hidden" id="comid" name="comid">
					<input type="hidden" id="userid" name="userid">
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>