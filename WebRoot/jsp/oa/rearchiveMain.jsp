<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
	}
%>

<!DOCTYPE html>
<html>
<head>
<title>文档管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
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
             ,url: basePath + '/egovernment/archive/queryRearchive'
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
                {field: 'rcarchivecode', width: 150, title: '公文编码', event: 'trclick'}
                , {field: 'rcarchivetitle', width: 150, title: '公文标题', event: 'trclick'}
                , {field: 'rcarchiveremark', width: 150, title: '备注', event: 'trclick'}
                , {field: 'rcarchiveopperuser', width: 150, title: '操作人', event: 'trclick'}
                , {field: 'rcarchiveopperdate', width: 150, title: '操作时间', event: 'trclick'}
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
                if (selectTableDataId != data.rcarchiveid) {
                    // 清除所有行的样式
                    $(".layui-table-body tr").each(function (k, v) {
                        $(v).removeAttr("style");
                    });
                    $(obj.tr.selector).css("background", selectTableBackGroundColor);
                    table.singleData = data;
                    selectTableDataId = data.rcarchiveid;
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
                    layer.alert('请选择要查看的收文信息！');
                } else {
                    showArchive(table.singleData.archiveid,table.singleData.messagetype);
                }
            }
            , delRearchive: function () { // 删除
                if (!table.singleData) {
                    layer.alert('请选择要删除的收文信息！');
                } else {
                    delRearchive(table.singleData.rcarchiveid);
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









}); 
	//根据参数查询
	function query() {
		var param = {
			'rcarchivetitle': $('#rcarchivetitle').val(),
			'rcarchiveopperuser': $('#rcarchiveopperuser').val()
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
        url: basePath + '/egovernment/archive/queryRearchive'
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
	// 查看
	function showArchive(archiveid,messagetype) {
        if(messagetype=="2") {
            sy.modalDialog({
                title: '查看收文信息'
                , area: ['100%', '100%']
                , content: basePath + 'egovernment/archive/archiveswEditFormIndex?op=view&archiveid=' + archiveid
                , btn: ['关闭']
            });
        }else{
            sy.modalDialog({
                title: '查看收文信息'
                , area: ['100%', '100%']
                , content: basePath + 'egovernment/archive/archiveFormIndex?op=view&archiveid=' + archiveid
                , btn: ['关闭']
            });
		}
	}
	//删除
	function  delRearchive(rcarchiveid) {
        layer.open({
            title: '警告'
            , content: '你确定要删除该项记录么？'
            , btn: ['确定', '取消'] //可以无限个按钮
            , btn1: function (index, layero) {
                $.post(basePath + '/egovernment/archive/delRearchive', {
                        rcarchiveid: rcarchiveid
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
										<label class="layui-form-label">标题</label>

										<div class="layui-input-inline">
											<input type="text" id="rcarchivetitle" name="rcarchivetitle"
												   autocomplete="off" class="layui-input">
										</div>
									</div>
								</div>
								<div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
									<div class="layui-form-item">
										<label class="layui-form-label">操作员</label>
										<div class="layui-input-inline">
											<input type="text" id="rcarchiveopperuser" name="rcarchiveopperuser"
												   autocomplete="off" class="layui-input">
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
				<ck:permission biz="showArchive">
					<button class="layui-btn" data-type="showArchive" data="btn_archiveFormIndex">查看</button>
				</ck:permission>
				<ck:permission biz="delRearchive">
					<button class="layui-btn layui-btn-danger" data-type="delRearchive" data="btn_delRearchive">删除</button>
				</ck:permission>
			</div>
			<table class="layui-hide" id="grid" lay-filter="tableFilter">
			</table>
		</div>
	</div>
</body>
</html>
