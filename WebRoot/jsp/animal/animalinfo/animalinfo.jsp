<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
	<title>动物信息</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

	<script type="text/javascript">
        //毛发颜色
        var haircolor = <%=SysmanageUtil.getAa10toJsonArray("HAIRCOLOR")%>;
        //养殖类型
        var culturestyle = <%=SysmanageUtil.getAa10toJsonArray("CULTURESTYLE")%>;
        //设备类型
        var equipmenttype = <%=SysmanageUtil.getAa10toJsonArray("EQUIPMENTTYPE")%>;

        var url ="<%=basePath%>/animal/queryAnimalinfo";
        var form;
        var table;
        var layer;
        var selectNodes;
        var element; //
        var selectTableDataId = '';
        $(function() {
            initData();
        });
        function initData() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                table.render({
                    elem: '#roleTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: url
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    ,cellMinWidth: 80 //全局定义常规单元格的最小宽度
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
                        {field: 'animalno', width: 120, title: '动物编号', event: 'trclick'}
                        ,{field: 'fencename', width: 120, title: '栅栏名称', event: 'trclick'}
                        ,{field: 'birthday', width: 150, title: '出生日期', event: 'trclick'}
                        , {field: 'sex',width: 80,  title: '动物性别'
                            ,templet: function (d) {
                                if (d.sex == "1" ) {
                                    return '<span >公</span>';
                                }
                                else{
                                    return '<span >母</span>';
                                }
                            }
                            ,event: 'trclick'}
                        ,
                        {field: 'haircolor', width: 80, title: '毛发颜色'
                            ,templet : function(d){
                                var userkind = d.id;
                                $.each(haircolor, function(i, n) {
                                    if (d.haircolor == n.id){
                                        userkind = n.text;
                                        return false; // 跳出本次循环
                                    }
                                });
                                return userkind;
                            },event: 'trclick'}
                        ,
                        {field: 'culturestyle',width: 80,  title: '养殖类型'
                            ,templet : function(d){
                                var userkind = d.id;
                                $.each(culturestyle, function(i, n) {
                                    if (d.culturestyle == n.id){
                                        userkind = n.text;
                                        return false; // 跳出本次循环
                                    }
                                });
                                return userkind;
                            },event: 'trclick'}
                        ,{field: 'weaningdate',width: 150,  title: '断奶日期', event: 'trclick'}
                        ,{field: 'weaningweight',width: 120,  title: '断奶体重', event: 'trclick'}
                        ,{field: 'deathdate', width: 150, title: '死亡日期', event: 'trclick'}
                        ,{field: 'deathweight',width: 120,  title: '死亡体重', event: 'trclick'}
                        ,
                        {field: 'equipmenttype',width: 120,  title: '设备类型'
                            ,templet : function(d){
                                var userkind = d.id;
                                $.each(equipmenttype, function(i, n) {
                                    if (d.equipmenttype == n.id){
                                        userkind = n.text;
                                        return false; // 跳出本次循环
                                    }
                                });
                                return userkind;
                            },event: 'trclick'}
					]]
				});
                // 监听工具条
                table.on('tool(paramgridfilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.id) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.id;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    showanimal: function () { // 查看结果明细
                        if (!table.singleData) {
                            layer.alert('请先选择要查看的动物信息！');
                        } else {
                            showanimal(table.singleData.animalinfoid);
                        }
                    }
                ,updateanimal: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择要修改的动物信息！');
                        } else {
                            updateanimal(table.singleData.animalinfoid);
                        }
                    },addanimal: function () {
                            addanimal();
                    }
                    ,delanimal: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择要删除的动物信息！');
                        } else {
                            delanimal(table.singleData.animalinfoid);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                //监听提交
                $("#btn_query").bind("click", function(){
                    query();
                    return false;
                });
			})
        };
		function query() {
            // 查询
            var animalno = $('#animalno').val();
            var fenceid = $('#fenceid').val();
            var param = {
                'animalno': animalno,
                'fenceid': fenceid
            }
            table.reload('roleTable', {
                url : basePath + '/animal/queryAnimalinfo'
                ,where: param //设定异步数据接口的额外参数
            });
		}


        function showanimal(animalinfoid) {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '查看动物信息'
                , content:basePath + '/animal/animalinfoFormIndex?op=view&animalinfoid='+animalinfoid
                , btn: ['关闭']
            });
        }

        function addanimal() {
            sy.modalDialog({
                title : '新增动物信息'
                ,content : basePath + '/animal/animalinfoFormIndex'
                , area: ['100%', '100%']
                ,btn : ['保存', '取消'] //可以无限个按钮
                ,btn1: function(index, layero){
                    window[layero.find('iframe')[0]['name']].saveFun();
                }
            },closeModalDialogCallback);
        }
        // 关闭窗口回掉函数
        function closeModalDialogCallback(dialogID){
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
			table.reload('roleTable', {
                    url : basePath + '/animal/queryAnimalinfo'
                });

        }
        function updateanimal(animalinfoid) {
            sy.modalDialog({
                title : '修改动物信息'
                ,content : basePath + '/animal/animalinfoFormIndex?animalinfoid='+animalinfoid
                , area: ['100%', '100%']
                ,btn : ['保存', '取消'] //可以无限个按钮
                ,btn1: function(index, layero){
                    window[layero.find('iframe')[0]['name']].saveFun();
                }
            },closeModalDialogCallback);
        }
        // 重置
        function reload() {
            table.reload('roleTable', {
                url : basePath + '/animal/queryAnimalinfo'
            });
        };
        function delanimal(animalinfoid) {
            layer.open({
                title : '警告'
                ,content : '你确定要删除该项动物信息么？'
                ,btn : ['确定', '取消'] //可以无限个按钮
                ,btn1: function(index, layero){
                    $.post(basePath + '/animal/delAnimalinfo', {
                            animalinfoid: animalinfoid
                    },
                        function(result) {
                            if (result.code == '0') {
                                layer.msg('删除成功', {time:1000},function(){
                                    table.reload('roleTable', {
                                        url : basePath + '/animal/queryAnimalinfo'
                                    });
                                    table.singleData = '';
                                    selectTableDataId = '';
                                });
                            } else {
                                layer.open({
                                    title : "提示",
                                    content : "删除失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        },
                        'json')
                }
			})

        }
        function myselectfence() {
            sy.modalDialog({
                title: '选择栅栏信息'
                , area: ['1000px', '470px']
                , content: '<%=basePath%>jsp/pub/pub/selectfence.jsp'
                , btn: ['确定'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == "") {
                    return;
                }
                if (obj.type == 'ok') {
                    var myrow = obj.data;
                    $("#fencename").val(myrow.fencename); //父编号
                    $("#fenceid").val(myrow.animalfenceid); //父id
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
			<div class="layui-colla-content layui-show" style="height: 40px">
				<form id="myqueryform" class="layui-form">
					<div class="layui-form-item">
						<label class="layui-form-label">动物编号</label>
						<div class="layui-input-inline">
							<input type="text" id="animalno" name="animalno"
								   autocomplete="off" class="layui-input">
						</div>
						<label class="layui-form-label">栅栏</label>
						<div class="layui-input-inline">
							<input type="text" id="fencename" name="fencename"
								   autocomplete="off" class="layui-input" onclick="myselectfence()">
							<input  id="fenceid" name="fenceid"
									type="hidden">
						</div>

						<div class="layui-input-inline" >
							<fieldset class="layui-elem-field site-demo-button" style="border: none;">
								<div>
									<button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
										<i class="layui-icon">&#xe615;</i>搜索
									</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal"
											id="btn_reset">
										<i class="layui-icon">&#xe621;</i>重置
									</button>
								</div>
							</fieldset>
						</div>
					</div>
				</form>
			</div>
				<fieldset class="layui-elem-field site-demo-button" style="width: 100%;border: none;padding-top: 8px;">
					<div class="layui-btn-group demoTable">
						<ck:permission biz="showanimala">
							<button class="layui-btn" data-type="showanimal" data="btn_showanimal">查看</button>
						</ck:permission>
						<ck:permission biz="updateanimala">
							<button class="layui-btn" data-type="updateanimal" data="btn_updateanimal">修改</button>
						</ck:permission>
						<ck:permission biz="addanimala">
							<button class="layui-btn" data-type="addanimal" data="btn_addanimal">添加</button>
						</ck:permission>
						<ck:permission biz="delanimala">
							<button class="layui-btn layui-btn-danger" data-type="delanimal" data="btn_delanimal">删除</button>
						</ck:permission>
					</div>
				</fieldset>

			</div>

	</div>
	<table class="layui-hide" id="roleTable" lay-filter="paramgridfilter"></table>
</div>
</body>
</html>