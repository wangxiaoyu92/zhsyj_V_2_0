<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
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

	<title>指派负责人</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

	<script type="text/javascript">
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;//进度条
        var element;
        var selectTableDataId='';
        var selectTableData=new Array();
        var selectFzTableData;
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#qyTable'
                    , url: basePath + 'jk/jkgl/queryJkcomList'
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
                        {type:'checkbox'}
                        , {field: 'commc', width: 250, title: '公司名称', event: 'trclick'}
                        , {field: 'comdz', width: 230, title: '公司地址', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        layer.close(mask);
                    }
                });
                table.on('checkbox(ryTable)', function(obj){
                    $("#comid").val(obj.comid);
                    selectTableData.push(obj.data);
                    queryJkcomFzr(obj.comid); // 查询负责人
                });
                table.render({
                    elem: '#fzTable'
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
                        {field: 'description', width: 250, title: '姓名', event: 'trclick',edit:'text'}
                        , {field: 'orgname', width: 230, title: '所属部门', event: 'trclick',edit:'text'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                //监听单元格编辑数据
                table.on('edit(fzTable)', function(obj){ //注：edit是固定事件名，test是table原始容器的属性 lay-filter="对应的值"
                    selectFzTableData=obj;
                });
                // 监听工具条
                table.on('tool(fzTable)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.jkqyfzrid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.jkqyfzrid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    addPcom: function () { // 添加
                        if(selectTableData.length!=0){
                            addJkFzr();
                        }else{
                            layer.alert('请先选择要监控的企业！')
                        }
                    }
                    ,delPcom:function () {
                        if(!table.singleData){
                            layer.alert('请先选择要删除的负责人！')
                        }else{
                            mydatagrid_remove(table.singleData);
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
        });

        // 查询负责人
        function queryJkcomFzr(v_comid) {
            var param = {
                'comid': v_comid
            };
            // 负责人
            table.reload('fzTable', {
                url:basePath + 'jk/jkgl/queryJkfzrList'
                , page: {
                    curr: 1//重新从第 1 页开始
                },
                param:param
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }

        // 添加检查人员
        function addJkFzr() {
            var url = "<%=basePath%>jsp/pub/pub/selectuser.jsp";
            parent.sy.modalDialog({
                title: '选择企业',
                param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true"
                },
                area:['100%','100%'],
                content: url,
                btn:['确定','取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);//不可缺少
                if (obj == null || obj == "") {
                    return;
                }
                sy.removeWinRet(dialogID);
                if (obj.type == "ok") {
                    selectFzTableData=obj.data;
                    //刷新的时候显示进度条
                    var mask = layer.load(1, {shade: [0.1, '#393D49']});
                    table.reload('fzTable', {
                        data:selectFzTableData
                        , page: {
                            curr: 1//重新从第 1 页开始
                        }
                        , done: function () {
                            table.singleData = '';
                            selectTableDataId = '';
                            layer.close(mask);
                        }
                    });
                }
            })
        }


        //删除一行
        function mydatagrid_remove(rows) {
            var obj=table.cache.fzTable;
            for(var i=0;i<obj.length;i++){
                if(obj[i].userid==rows.userid){
                    obj.remove(obj[i]);
                }
            }
            //刷新的时候显示进度条
            var mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('fzTable', {
                data:obj
                , page: {
                    curr: 1//重新从第 1 页开始
                }
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }

        /**
         * 保存
         */
        var lock = true;// 锁住表单   这里定义一把锁
        function mysave() {
            var url = basePath + 'jk/jkgl/saveJkFzr';
            // 获取选中的公司
            var v_comArr = [];
            for (var i = 0; i < selectTableData.length; i++) {
                v_comArr.push({'comid': selectTableData[i].comid});
            }
            $('#comgrid_rows').val($.toJSON(v_comArr));
            // 获取添加的监管人员
            $('#rygrid_rows').val($.toJSON(selectFzTableData));
            if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                return false;
            }
            lock = false  //进来后，立马把锁锁住
            $('#myform').form('submit', {
                url: url,
                success: function (result) {
                    result = $.parseJSON(result);
                    if (result.code == '0') {
                        layer.msg("保存成功！",{time:1000},function () {
                            var obj = new Object();
                            obj.type = "ok";
                            sy.setWinRet(obj);
                            window.location.reload();
                        });
                    } else {
                        layer.open({
                            title: "提示",
                            content: "保存失败：" + result.msg //这里content是一个普通的String
                        })
                        lock = true;//业务逻辑执行失败了，打开锁
                    }
                }
            });
        }

        // 所属统筹区树
        function showMenu_aaa027() {
            var url = basePath + 'jsp/pub/pub/selectAaa027.jsp';
            var obj = new Object();
            parent.sy.modalDialog({
                title: '所属统筹区树',
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

        // 查询
        function query() {
            var commc = $('#commc').val();
            var aaa027 = $('#aaa027').val();
            var param = {
                'commc': commc,
                'aaa027': aaa027
            };
            table.reload('fzTable', {
                url:basePath+'jk/jkgl/queryJkcomList'
                , page: {
                    curr: 1//重新从第 1 页开始
                },
                param:param
                , done: function () {
                    layer.close(mask);
                }
            });
            table.reload('fzTable', {
                page: {
                    curr: 1//重新从第 1 页开始
                }
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
//            v_comgrid.datagrid('reload', param);
//            v_comgrid.datagrid('clearSelections');
//            v_rygrid.datagrid('loadData', {total: 0, rows: []});
        }

	</script>
</head>
<body>
<div class="layui-fluid">
	<div class="layui-collapse">
		<div class="layui-colla-item">
			<h2 class="layui-colla-title">查询条件</h2>
			<div class="layui-colla-content layui-show">
				<form class="layui-form" id="myqueryform" style="height:auto">
					<div class="layui-container">
						<div class="layui-row">
							<div class="layui-form-item">
								<label class="layui-form-label">所属统筹区：</label>
								<div class="layui-input-inline">
									<input type="text" id="aaa027name" name="aaa027name" readonly
										   autocomplete="off" class="layui-input" onclick="showMenu_aaa027()">
									<input name="aaa027" id="aaa027" type="hidden"/>
									<div id="menuContent_aaa027" class="menuContent"
										 style="display:none; position: absolute;">
										<ul id="treeDemo_aaa027" class="ztree"
											style="margin-top:0px;width:150px;height:450px;"></ul>
									</div>
								</div>

								<label class="layui-form-label" style="width:200px;">监控企业名称：</label>
								<div class="layui-input-inline">
									<input type="text" id="commc" name="commc" placeholder="请输入监控企业名称"
										   autocomplete="off" class="layui-input">
								</div>
								<div class="layui-input-inline" style="margin-left: 122px">
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
	<form name="myform" id="myform" method="post">
		<div class="layui-row">
			<div style="width: 45%;float: left;margin-top:10px">
				<div class="layui-collapse">
					<div class="layui-colla-item">
						<h2 class="layui-colla-title">监控企业</h2>
						<div class="layui-colla-content layui-show">
							<input type="hidden" id="comgrid_rows" name="comgrid_rows"/>
							<table id="qyTable" class="layui-hide" name="qyTable" lay-filter="qyTable">
								<input type="hidden" id="comid" name="comid"/>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div style="width: 45%;float: right;margin-top: 10px">
				<div class="layui-collapse">
					<div class="layui-colla-item">
						<h2 class="layui-colla-title">负责人表</h2>
						<div class="layui-colla-content layui-show">
							<div class="layui-btn-group demoTable">
								<ck:permission biz="addPcom">
									<button class="layui-btn" type="button" data-type="addPcom" data="btn_addPcom">添加负责人</button>
								</ck:permission>
								<ck:permission biz="delPcom">
									<button class="layui-btn layui-btn-danger" type="button" data-type="delPcom" data="btn_delPcom">删除</button>
								</ck:permission>
							</div>
							<input type="hidden" id="rygrid_rows" name="rygrid_rows"/>
							<table id="fzTable" class="layui-hide" name="fzTable" lay-filter="fzTable">
								<input type="hidden" id="jkqyfzrid" name="jkqyfzrid"/>
								<input type="hidden" id="comid" name="comid"/>
								<input type="hidden" id="userid" name="userid"/>
								<input type="hidden" id="orgid" name="orgid"/>
							</table>
						</div>
					</div>
				</div>
			</div>

		</div>
	</form>
</div>
</body>
</html>