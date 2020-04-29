<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
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
	String name=SysmanageUtil.getSysuser().getUserid();
%>

<!DOCTYPE html>
<html>
<head>
<title>文档管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var form;
	var table;
	var layer;
	var element;
	var mask;
	var selectTableDataId = '';
    var v_type = [{"id":"","text":"请选择"},{"id":"0","text":"未读"},{"id":"1","text":"已读"}];
    var v_wc = [{"id":"","text":"请选择"},{"id":"0","text":"未完成"},{"id":"1","text":"已完成"},{"id":"2","text":"不能完成"}];
$(function() {
    intSelectData("havereadflag", v_type);
    intSelectData("completestate", v_wc);
	layui.use(['form', 'table', 'layer', 'element', 'laydate'], function () {
		form = layui.form, table = layui.table, layer = layui.layer,laydate = layui.laydate, element = layui.element;
		mask = layer.load('1', {shade: [0.1, '#393D49']});
        laydate.render({
            elem: '#endtime',
            type:'datetime'
        });
		table.render({
			elem: '#docTable'
			, url: basePath + '/work/task/querysdTaskZJ'
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
                {field:'taskcontent',title:'任务内容',align:'center',width:500,event: 'trclick',
                    templet: function (d) {
                        return '<a  href="javascript:show(\'' + d.oataskid + '\',\'' + d.oataskmanid + '\')" lay-event="detail">'  + '<span style="color:blue;">' + d.taskcontent + '</span></a>'
                    }
                }
				, {field: 'endtime', width: 150, title: '截止时间', event: 'trclick' }
                , {field: 'txr', width: 200, title: '阅读状态', event: 'trclick'},
                {
                    field: 'completestate',
                    width: 200,
                    title: '完成状态',
                    event: 'trclick',
                    templet: function (d) {
                        if(d.completestate == "1"){
                            return '<span style="color:red">未完成(已超时)</span>';
                        } else if(d.completestate == "2"){
                            return '<span style="color:red">未完成(今天为最后期限)</span>';
                        } else{
                            return '<span style="color:blue">'+d.completestate+'</span>';
                        }
                    }
                }
				, {field: 'aae011', width: 200, title: '发送人', event: 'trclick'}
				, {field: 'aae036', width: 200, title: '发送时间', event: 'trclick'}
			]]
			, done: function (res, curr, count) {
				layer.close(mask);
			}

		})
		// 监听工具条
		table.on('tool(tableFilter)', function (obj) {
			var data = obj.data;
			if (obj.event === 'trclick') { // 选中行
				if (selectTableDataId != data.oataskid) {
					// 清除所有行的样式
					$(".layui-table-body tr").each(function (k, v) {
						$(v).removeAttr("style");
					});
					$(obj.tr.selector).css("background", "#90E2DA");
					table.singleData = data;
					selectTableDataId = data.archiveid;
				} else { // 再次选中清除样式
					$(obj.tr.selector).attr("style", "");
					table.singleData = '';
					selectTableDataId = '';
				}
			}
		});
		var $ = layui.$, active = {


			editPcom: function () {
				if (!table.singleData) {
					layer.alert('请先选择要查看回复的工作任务！！');
				} else {
					editDoc(table.singleData);
				}
			},
			showPcom: function () {
				if (!table.singleData) {
					layer.alert("请先选择要查看的工作任务！")
				} else {
					showDoc(table.singleData);
				}
			},
            wcPcom: function () {
                if (!table.singleData) {
                    layer.alert("请先选择要完成的工作任务！")
                } else {
                    wcDoc(table.singleData);
                }
            },
            bnwcPcom: function () {
                if (!table.singleData) {
                    layer.alert("请先选择不能完成的工作任务！")
                } else {
                    bnwcDoc(table.singleData);
                }
            }

		}
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




	// 编辑
	function editDoc(data) {
        var oataskid=data.oataskid;
        url=basePath + 'work/task/gzrwhfydMainIndex?oataskid=' + oataskid
		sy.modalDialog({
			title: '回复记录'
			, area: ['100%', '100%']
			, content: url
			, btn: [ '关闭']
		}, closeModalDialogCallback);
	}
	// 查看
	function showDoc(data) {
        var oataskid=data.oataskid;
        var oataskmanid=data.oataskmanid;
        url=basePath + 'work/task/gzrwsdFormIndex?op=view&oataskid=' + oataskid+ '&oataskmanid='+oataskmanid

        sy.modalDialog({
			type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			, area: ['100%', '100%'] //
			, title: '查看工作任务'
			, content: url
            , btn: ['保存', '关闭']
            , btn1: function (index, layero) {
                window[layero.find('iframe')[0]['name']].submitForm();
            }
        }, query);

	}
    function wcDoc(data) {
        var oataskmanid=data.oataskmanid;

        /*sy.modalDialog({
            type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
            , area: ['100%', '100%'] //
            , title: '查看工作任务'
            , content: url
            , btn: ['保存', '关闭']
            , btn1: function (index, layero) {
                window[layero.find('iframe')[0]['name']].submitForm();
            }
        }, query);*/
        layer.open({
            title: '确认'
            , icon: '3'
            , content: '你确定要完成该项工作任务么？'
            , btn: ['确定', '取消'] //可以无限个按钮
            , btn1: function (index, layero) {
                $.post(basePath + 'work/task/wcoatsakman', {
                        oataskmanid: oataskmanid
                    },
                    function (result) {
                        if (result.code == '0') {
                            //保证不会重复删除
                            table.singleData = '';
                            selectTableDataId = '';
                            //本页的值
                            var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                            layer.msg('完成成功', {time: 1000}, function () {
                                //如果是本页最后一条数据 则返回上一页
                                if (table.cache.docTable.length == 1) {
                                    curent = curent - 1;
                                }
                                refresh('', curent);
                            });

                        } else {
                            layer.open({
                                title: "提示",
                                content: "完成失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    },
                    'json');
            }
        });
    }
    function bnwcDoc(data) {
        var oataskmanid=data.oataskmanid;
        url=basePath + 'work/task/bnwcFormIndex?op=view&oataskmanid='+oataskmanid

        sy.modalDialog({
            type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
            , area: ['500px', '300px'] //
            , title: '不能完成原因'
            , content: url
            , btn: ['保存', '关闭']
            , btn1: function (index, layero) {
                window[layero.find('iframe')[0]['name']].submitForm();
            }
        }, query);
    }


    function show(oataskid,oataskmanid) {
        url=basePath + 'work/task/gzrwsdFormIndex?op=view&oataskid=' + oataskid+ '&oataskmanid='+oataskmanid

        sy.modalDialog({
            type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
            , area: ['100%', '100%'] //
            , title: '查看工作任务'
            , content: url
            , btn: ['保存', '关闭']
            , btn1: function (index, layero) {
                window[layero.find('iframe')[0]['name']].submitForm();
            }
        }, query);

    }

	//根据参数查询
	function query() {
		var param = {
			'taskcontent': $('#taskcontent').val(),
			'endtime': $('#endtime').val(),
            'havereadflag': $('#havereadflag').val(),
            'completestate': $('#completestate').val()
		};
		/*mygrid.datagrid({
			url : basePath + '/egovernment/archive/queryArchive',
			queryParams : param
		});
		mygrid.datagrid('clearSelections');*/
		refresh(param, '');
	}
	// 刷新
	function refresh(param, cur) {
		table.singleData = '';
		selectTableDataId = '';
		//删除时 在本页面刷新
		if (cur == "") {
			curr = 1;
		} else {
			curr = cur;
		}
		//刷新的时候显示进度条
		mask = layer.load(1, {shade: [0.1, '#393D49']});
		table.reload('docTable', {
			url: basePath + '/work/task/querysdTaskZJ'
			, page: {
				curr: curr //重新从第 1 页开始
			}
			, where: param //设定异步数据接口的额外参数
			, done: function () {
				layer.close(mask);
			}
		});
		/*		parent.window.refresh();*/
	}


	function closeModalDialogCallback(dialogID) {
		var obj = sy.getWinRet(dialogID);
		sy.removeWinRet(dialogID);
		if (obj == null || obj == "") {
			return;
		}
		if (obj.type == "ok") {
			//其他在本页刷新
			var curent = $(".layui-laypage-skip input[class='layui-input']").val();
			refresh('', curent);
		} else {
			//saveOk 在第一页刷新
			refresh('', '');
		}
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
					<div class="layui-row">
						<div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
							<div class="layui-form-item">
								<label class="layui-form-label">任务内容</label>

								<div class="layui-input-inline">
									<input type="text" name="taskcontent" id="taskcontent" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
							<div class="layui-form-item">
								<label class="layui-form-label">截止时间</label>

								<div class="layui-input-inline">
									<input type="text" id="endtime" name="endtime"
										   autocomplete="off" class="layui-input">
								</div>
							</div>
						</div>
					</div>
					<div class="layui-row">
						<div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
							<div class="layui-form-item">
								<label class="layui-form-label">阅读状态</label>

								<div class="layui-input-inline">
									<select  name="havereadflag" id="havereadflag"></select>
								</div>
							</div>
						</div>
						<div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
							<div class="layui-form-item">
								<label class="layui-form-label">完成状态</label>

								<div class="layui-input-inline">
									<select id="completestate" name="completestate"
											autocomplete="off" ></select>
								</div>
							</div>
						</div>
						<div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
							<div class="layui-form-item">
								<label class="layui-form-label"></label>

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
			<button class="layui-btn " data-type="showPcom" data="btn_showPcom">阅读</button>
			<button class="layui-btn " data-type="editPcom" data="btn_editPcom">回复记录</button>
			<button class="layui-btn " data-type="wcPcom" data="btn_wcPcom">完成任务</button>
			<button class="layui-btn " data-type="bnwcPcom" data="btn_bnwcPcom">不能完成任务</button>
		</div>
		<table class="layui-hide" id="docTable" lay-filter="tableFilter">

		</table>
	</div>
</div>
</body>
</html>
