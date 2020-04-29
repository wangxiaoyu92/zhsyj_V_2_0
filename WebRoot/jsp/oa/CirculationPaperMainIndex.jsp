<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
	<title>诚信评定结果</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
	<script type="text/javascript">
        // 状态
        var v_ckzt = <%=SysmanageUtil.getAa10toJsonArray("CYCKZT")%>;
        var grid;
        var form;
        var table;
        var layer;
        var selectTableDataId = '';
        var mask;
        $(function() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                orm = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#grid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    ,url: basePath + 'egovernment/circulationPaper/queryCirculationPaper'
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数queryZxpdjg
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
                        {field: 'paperusername', width: 150, title: '传阅者姓名', event: 'trclick'}
                        , {field: 'recusername', width: 150, title: '接受者姓名', event: 'trclick'}
                        , {
                            field: 'paperstate', title: '查看者状态',width: 150
                            , templet: function (d) {
                                if (d.paperstate == "0") {
                                    return '<span style="color:blue;">未查看</span>';
                                } else if (d.paperstate == "1") {
                                    return '<span style="color:red;">已查看</span>';
                                } else {
                                    return '';
                                }
                            }
                            , event: 'trclick'
                        }
                        , {field: 'filetitle', width: 300, title: '公文标题', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                })
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.paperid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.paperid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    showArchive: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的传阅信息！');
                        } else {
                            showArchive(table.singleData.fileid);
                        }
                    }
                    , delCirculationPaper: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的传阅信息！');
                        } else {
                            delCirculationPaper(table.singleData.paperid);
                        }
                    }
                    , updateCirculationPaper: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的传阅信息！');
                        } else {
                            updateCirculationPaper(table.singleData.paperid);
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
            })
            intSelectData('paperstate', v_ckzt);
        });
	</script>
	<script type="text/javascript">
        function query() {
            var param = {
                paperusername:$("#paperusername").val(),   //传阅者的名字
                recusername:$("#recusername").val(),   //接受者的名字
                paperstate:$("#paperstate").val(),   //查看状态  0是未查看   1是查看
//                filetitle:$("#filetitle").val()  //公文标题
            };
            refresh(param);
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
            table.reload('grid', {
                url: basePath + 'egovernment/circulationPaper/queryCirculationPaper'
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
			/*    parent.window.refresh();*/
        }




        // 新增
        function addCirculationPaper() {
            var dialog = parent.sy.modalDialog({
                title : '新增传阅信息',
                width : 800,
                height : 450,
                url : basePath + 'egovernment/circulationPaper/editCirculationPaperFormIndex',
                buttons : [ {
                    text : '确定',
                    handler : function() {
                        dialog.find('iframe').get(0).contentWindow.submitForm(dialog,grid,parent.$);
                    }
                },{
                    text : '取消',
                    handler : function() {
                        dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
                    }
                } ]
            });
        }



        // 编辑
        function updateCirculationPaper(paperid) {

            var cfmMsg = "确定要更新传阅状态为已查看吗?";
            var v_url=encodeURI(encodeURI("<%=basePath%>egovernment/circulationPaper/updateCirculationpaper?paperid="+paperid));
            layer.open({
                title: '确认'
                , content: cfmMsg
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(v_url, {

                        },
                        function (result) {
                            if (result.code == '0') {
                                layer.msg('已查看！', {time: 500}, function () {
                                    refresh('', '');
                                });
                            } else {
                                layer.open({
                                    title: "提示",
                                    content: "查看查看失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        },
                        'json');
                }
            });
        }

        // 删除
        function delCirculationPaper(paperid) {
            layer.open({
                title: '警告'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'egovernment/circulationPaper/delCirculationPaper', {
                            paperid: paperid
                        },
                        function (result) {
                            if (result.code == '0') {
                                table.singleData = '';
                                selectTableDataId = '';
                                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                layer.msg('删除成功', {time: 1000}, function () {
                                    //如果是本页最后一条数据 则返回上一页
                                    if (table.cache.grid.length == 1) {
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
        // 查看
        function showArchive(fileid) {
            sy.modalDialog({
                title: '查看传阅信息'
                , area: ['100%', '100%']
                , content:  url=basePath + 'egovernment/archive/archiveFormIndex?op=view&archiveid=' + fileid
                , btn: ['关闭']
            });
        }
	</script>
</head>
<body>
<div class="layui-fluid">
	<div class="layui-collapse">
		<div class="layui-colla-item">
			<h2 class="layui-colla-title">查询条件</h2>
			<div class="layui-colla-content layui-show" style="height: auto">
				<form id="myqueryform" class="layui-form">
					<div class="layui-container">
						<div class="layui-row">
							<div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
								<div class="layui-form-item">
									<label class="layui-form-label">传阅者的名字</label>

									<div class="layui-input-inline">
										<input type="text" id="paperusername" name="paperusername"
											   autocomplete="off" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
								<div class="layui-form-item">
									<label class="layui-form-label">接受者的名字</label>

									<div class="layui-input-inline">
										<input type="text" id="recusername" name="recusername"
											   autocomplete="off" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
								<div class="layui-form-item">
									<label class="layui-form-label">查看状态</label>

									<div class="layui-input-inline">
										<select name="paperstate" id="paperstate"></select>
									</div>
								</div>
							</div>
							<div class="layui-col-md2 layui-col-xs10 layui-col-sm6 layui-col-md-offset5">
								<div class="layui-form-item">

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
			<ck:permission biz="showArchive">
				<button class="layui-btn" data-type="showArchive" data="btn_archiveFormIndex">查看</button>
			</ck:permission>
			<ck:permission biz="delCirculationPaper">
				<button class="layui-btn" data-type="delCirculationPaper" data="btn_delCirculationPaper">删除</button>
			</ck:permission>
			<ck:permission biz="updateCirculationPaper">
				<button class="layui-btn layui-btn-danger" data-type="updateCirculationPaper" data="btn_updateCirculationPaper">已查看
				</button>
			</ck:permission>
		</div>
		<table class="layui-hide" id="grid" lay-filter="tableFilter">
		</table>
	</div>
</div>

</body>
</html>