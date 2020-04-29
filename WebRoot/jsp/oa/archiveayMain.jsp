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

$(function() {
	layui.use(['form', 'table', 'layer', 'element'], function () {
		form = layui.form, table = layui.table, layer = layui.layer, element = layui, element;
		mask = layer.load('1', {shade: [0.1, '#393D49']});
		table.render({
			elem: '#docTable'
			, url: basePath + '/egovernment/archive/queryArchive'
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
				{field: 'archivecode', width: 200, title: '公文编码', event: 'trclick'}
				, {field: 'archivetitle', width: 200, title: '公文标题', event: 'trclick'}
				, {field: 'archiveremark', width: 200, title: '备注', event: 'trclick'}
				, {field: 'archiveopperuser', width: 200, title: '操作人', event: 'trclick'}
				, {field: 'archiveopperdate', width: 200, title: '操作时间', event: 'trclick'}
                , {
                    field: 'messagetype', title: '收发文',width: 150
                    , templet: function (d) {
                        if (d.messagetype == "1") {
                            return '<span style="color:blue;">发文</span>';
                        } else if (d.messagetype == "2") {
                            return '<span style="color:red;">收文</span>';
                        } else {
                            return '';
                        }
                    }
                    , event: 'trclick'
                }
			]]
			, done: function (res, curr, count) {
				layer.close(mask);
			}

		})
		// 监听工具条
		table.on('tool(tableFilter)', function (obj) {
			var data = obj.data;
			if (obj.event === 'trclick') { // 选中行
				if (selectTableDataId != data.archiveid) {
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
			delPcom: function () {
				if (!table.singleData) {
					layer.alert('请先选择要删除的文档！！');
				} else {
					delDoc(table.singleData.archiveid);
				}
			},
			addPcom: function () {
					addDoc();

			},
			addSWPcom: function () {
				addSWDoc();

			},
            addSBPcom: function () {
                addSBDoc();

            },
			editPcom: function () {
				if (!table.singleData) {
					layer.alert('请先选择要修改的文档！！');
				} else {
					editDoc(table.singleData);
				}
			},
			showPcom: function () {
				if (!table.singleData) {
					layer.alert("请先选择要查看的文档！")
				} else {
					showDoc(table.singleData);
				}
			},
			swPcom: function () {
				if (!table.singleData) {
					layer.alert("请先选择要收文受理的文档！")
				} else {
					shouwenkaishishouli(table.singleData);
				}
			},
			fwPcom: function () {
				if (!table.singleData) {
					layer.alert("请先选择要发文受理的文档！")
				} else {
					fawenkaishishouli();
				}
			},
			slrzPcom: function () {
				if (!table.singleData) {
					layer.alert("请先选择要查看受理日志的文档！")
				} else {
					shoulirizhi();
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

	// 删除
	function delDoc(archiveid) {
		layer.open({
			title: '警告'
			, icon: '3'
			, content: '你确定要删除该项记录么？'
			, btn: ['确定', '取消'] //可以无限个按钮
			, btn1: function (index, layero) {
				$.post(basePath + '/egovernment/archive/delArchive', {
							archiveid: archiveid
						},
						function (result) {
							if (result.code == '0') {
								//保证不会重复删除
								table.singleData = '';
								selectTableDataId = '';
								//本页的值
								var curent = $(".layui-laypage-skip input[class='layui-input']").val();
								layer.msg('删除成功', {time: 1000}, function () {
									//如果是本页最后一条数据 则返回上一页
									if (table.cache.docTable.length == 1) {
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

	//新增
	function addDoc() {
		sy.modalDialog({
			title: '新增发文公文信息'
			, area: ['100%', '100%']
			, content: basePath + 'egovernment/archive/archiveayFormIndex?op=add'
			, btn: ['保存', '取消'] //可以无限个按钮
			, btn1: function (index, layero) {
				window[layero.find('iframe')[0]['name']].saveFun();
			}
		}, closeModalDialogCallback);
	}
	//新增收文
	function addSWDoc() {
        var name='<%=name%>';
            sy.modalDialog({
                title: '新增收文公文信息'
                , area: ['100%', '100%']
                , content: basePath + 'egovernment/archive/archiveayswFormIndex'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveFun();
                }
            }, closeModalDialogCallback);


	}
    //上报公文
    function addSBDoc() {
            sy.modalDialog({
                title: '新增上报公文信息'
                , area: ['100%', '100%']
                , content: basePath + 'egovernment/archive/archiveaysbFormIndex'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveFun();
                }
            }, closeModalDialogCallback);


    }
	// 编辑
	function editDoc(data) {
	    var archiveid=data.archiveid;
	    var type=data.messagetype;
	    var url;
	    if(type=="2"){
	        url=basePath + 'egovernment/archive/archiveayswEditFormIndex';
		}else {
            url=basePath + 'egovernment/archive/archiveayFormIndex';
		}
		sy.modalDialog({
			title: '编辑公文信息'
			, area: ['100%', '100%']
			, content: url
			, param: {
				archiveid: archiveid,
				type:type
			}
			, btn: ['保存', '关闭']
			, btn1: function (index, layero) {
				window[layero.find('iframe')[0]['name']].saveFun();
			}
		}, closeModalDialogCallback);
	}
	// 查看
	function showDoc(data) {
        var archiveid=data.archiveid;
        var type=data.messagetype;
        var url;
        if(type=="2"){
            url=basePath + 'egovernment/archive/archiveayswEditFormIndex?op=view&archiveid=' + archiveid
        }else {
            url=basePath + 'egovernment/archive/archiveayFormIndex?op=view&archiveid=' + archiveid
        }
		layer.open({
			type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			, area: ['100%', '100%'] //
			, title: '查看公文信息'
			, content: url
			, btn: ['关闭']
		});
	}

	//根据参数查询
	function query() {
		var param = {
			'archivetitle': $('#archivetitle').val(),
			'archiveopperuser': $('#archiveopperuser').val()
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
			url: basePath + '/egovernment/archive/queryArchive'
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

	//收文受理
	function shouwenkaishishouli(){

			var v_archiveid=table.singleData.archiveid;
			console.log(table.singleData);
			var v_comdm="11";
			var v_commc="[收文]"+table.singleData.archivetitle;

			var cfmMsg= "确定要受理申请编号为【"+v_archiveid+"】的记录吗?";

			var v_yewumcpym="gwglswlc";
			var v_transval="";
			var v_yewutablename="egarchiveinfo";
			var v_yewucolname="archiveid";

			var v_url=encodeURI(encodeURI("<%=basePath%>workflow/beginWfprocess?"+
			"ywbh="+v_archiveid+
			"&comdm="+v_comdm+
			"&commc="+v_commc+
			"&yewumcpym="+v_yewumcpym+
			"&transval="+v_transval+
			"&yewutablename="+v_yewutablename+
			"&yewucolname="+v_yewucolname+
			"&time="+new Date().getMilliseconds()));
		layer.open({
			title: '确认'
			, content: cfmMsg
			, btn: ['确定', '取消'] //可以无限个按钮
			, btn1: function (index, layero) {
				$.post(v_url, {
						},
						function (result) {
							if (result.code == '0') {
								layer.msg('受理成功！', {time: 1000
								}, function () {
									/*table.reload('monthlyWorkTask', {url: basePath + '/work/task/queryMonthlyWorkTask'});*/
									query();
									table.singleData = '';
									selectTableDataId = '';
								});
							} else {
								layer.open({
									title: "提示",
									content: "受理失败：" + result.msg //这里content是一个普通的String
								});
							}
						},
						'json');
			}
		});

	}
    //发文受理
	function fawenkaishishouli(){
        var messagetype=table.singleData.messagetype;
        if(messagetype=='2'){
            var v_archiveid=table.singleData.archiveid;
            console.log(table.singleData);
            var v_comdm="11";
            var v_commc="[收文]"+table.singleData.archivetitle;

            var v_yewumcpym="gwglswlc";
            var v_transval="";
            var v_yewutablename="egarchiveinfo";
            var v_yewucolname="archiveid";
            var type="sw";
            var v_url=encodeURI(encodeURI("<%=basePath%>jsp/oa/archiveswslForm.jsp?"+
                "ywbh="+v_archiveid+
                "&comdm="+v_comdm+
                "&commc="+v_commc+
                "&yewumcpym="+v_yewumcpym+
                "&transval="+v_transval+
                "&yewutablename="+v_yewutablename+
                "&type="+type+
                "&yewucolname="+v_yewucolname+
                "&time="+new Date().getMilliseconds()));
            layer.open({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                , title: '收文受理'
                , content: v_url
                , btn: ['保存', '关闭']
                , btn1: function (index, layero) {
                   /* var v_archiveid=table.singleData.archiveid;
                    console.log(table.singleData);
                    var v_comdm="11";
                    var v_commc="[收文]"+table.singleData.archivetitle;

                    var cfmMsg= "确定要受理申请编号为【"+v_archiveid+"】的记录吗?";

                    var v_yewumcpym="gwglswlc";
                    var v_transval="";
                    var v_yewutablename="egarchiveinfo";
                    var v_yewucolname="archiveid";
                    var type="2";
                    var v_url=encodeURI(encodeURI("<%=basePath%>workflow/beginWfprocess?"+
                        "ywbh="+v_archiveid+
                        "&comdm="+v_comdm+
                        "&commc="+v_commc+
                        "&yewumcpym="+v_yewumcpym+
                        "&transval="+v_transval+
                        "&yewutablename="+v_yewutablename+
                        "&type="+type+
                        "&yewucolname="+v_yewucolname+
                        "&time="+new Date().getMilliseconds()));
                    layer.open({
                        title: '确认'
                        , content: cfmMsg
                        , btn: ['确定', '取消'] //可以无限个按钮
                        , btn1: function (index, layero) {
                            $.post(v_url, {
                                },
                                function (result) {
                                    if (result.code == '0') {
                                        layer.msg('受理成功！', {time: 1000
                                        }, function () {
                                            /!*table.reload('monthlyWorkTask', {url: basePath + '/work/task/queryMonthlyWorkTask'});*!/
                                            query();
                                            table.singleData = '';
                                            selectTableDataId = '';
                                        });
                                    } else {
                                        layer.open({
                                            title: "提示",
                                            content: "受理失败：" + result.msg //这里content是一个普通的String
                                        });
                                    }
                                },
                                'json');
                        }
                    });*/
                    window[layero.find('iframe')[0]['name']].closeWindow();
                }
            });
		}else {

            var v_archiveid = table.singleData.archiveid;
            var v_comdm = "11";
            var v_commc = "[发文]" + table.singleData.archivetitle;
            ;

            var cfmMsg = "确定要受理申请编号为【" + v_archiveid + "】的记录吗?";

            var v_yewumcpym = "gwglfwlc";
            var v_transval = "";
            var v_yewutablename = "egarchiveinfo";
            var v_yewucolname = "archiveid";

            var v_url=encodeURI(encodeURI("<%=basePath%>jsp/oa/archiveswslForm.jsp?"+
                "ywbh="+v_archiveid+
                "&comdm="+v_comdm+
                "&commc="+v_commc+
                "&yewumcpym="+v_yewumcpym+
                "&transval="+v_transval+
                "&yewutablename="+v_yewutablename+
                "&type="+type+
                "&yewucolname="+v_yewucolname+
                "&time="+new Date().getMilliseconds()));
            layer.open({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                , title: '发文受理'
                , content: v_url
                , btn: ['保存', '关闭']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].closeWindowfw();
                }
            });
                }
            /*
                "ywbh=" + v_archiveid +
                "&comdm=" + v_comdm +
                "&commc=" + v_commc +
                "&yewumcpym=" + v_yewumcpym +
                "&transval=" + v_transval +
                "&yewutablename=" + v_yewutablename +
                "&yewucolname=" + v_yewucolname +
                "&time=" + new Date().getMilliseconds()));
            $.messager.confirm('确认', cfmMsg, function (r) {
                if(r){
                    $.messager.progress({
                        text : '正在提交....'
                    });
                    $.post(v_url, {},
                        function (result) {
                            $.messager.progress('close');
                            if (result.code == '0') {
                                layer.msg('受理成功！', {
                                    time: 1000
                                }, function () {
									/!*table.reload('monthlyWorkTask', {url: basePath + '/work/task/queryMonthlyWorkTask'});*!/
                                    query();
                                    table.singleData = '';
                                    selectTableDataId = '';
                                });
                            } else {
                                layer.open({
                                    title: "提示",
                                    content: "受理失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        },
                        'json');
                }
            });*/

	}

	//受理日志
	function shoulirizhi(){

		var url=basePath+'workflow/wfywlclogIndex';

			/*var dialog = parent.sy.modalDialog({
				title:'受理日志',
				param : {
				ywbh:table.singleData.archiveid,
				time :new Date().getMilliseconds()
				},
				width:1200,
				height:600,
				url:url,
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);//不可缺少
				if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){ //传递回的type为ok的时候才刷新页面。
				//window.location.reload();
				//shuaxindata();
				}
			})*/
		sy.modalDialog({
			title: '受理日志'
			, area: ['100%', '100%']
			, param: {
				ywbh: table.singleData.archiveid
			}
			, content: url
			, btn: [ '关闭']
		}, function (dialogID) {
			var obj = sy.getWinRet(dialogID);//不可缺少
			if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok') { //传递回的type为ok的时候才刷新页面。
				//window.location.reload();
				//shuaxindata();

			}
		});

	}

	function closeModalDialogCallback(dialogID) {
		var obj = sy.getWinRet(dialogID);
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
								<label class="layui-form-label">标题</label>

								<div class="layui-input-inline">
									<input type="text" name="archivetitle" id="archivetitle" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
							<div class="layui-form-item">
								<label class="layui-form-label">操作员</label>

								<div class="layui-input-inline">
									<input type="text" id="archiveopperuser" name="archiveopperuser"
										   autocomplete="off" class="layui-input">
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
            <ck:permission biz="queryArchive">
			<button class="layui-btn " data-type="addPcom" data="btn_addPcom">增加发文</button>
			</ck:permission>
            <ck:permission biz="delArchive">
			<button class="layui-btn " data-type="addSWPcom" data="btn_addSWPcom">添加收文</button>
			</ck:permission>
			<ck:permission biz="archiveFormIndex">
				<button class="layui-btn " data-type="addSBPcom" data="btn_addSBPcom">上报公文</button>
			</ck:permission>
			<button class="layui-btn " data-type="editPcom" data="btn_editPcom">编辑</button>

				<button class="layui-btn " data-type="showPcom" data="btn_showPcom">查看</button>

				<button class="layui-btn layui-btn-danger" data-type="delPcom" data="btn_delPcom">删除</button>
            <ck:permission biz="fwPcom">
			<button class="layui-btn " data-type="fwPcom" data="btn_fwPcom" >受理</button>
			</ck:permission>
			<button class="layui-btn " data-type="slrzPcom" data="btn_slrzPcom" >受理日志</button>


		</div>
		<table class="layui-hide" id="docTable" lay-filter="tableFilter">

		</table>
	</div>
</div>
	<%--<div class="easyui-layout" fit="true">
		<form id="myqueryfm" method="post">
			<div region="center" style="overflow: true;" border="false">
				<sicp3:groupbox title="查询条件">
					<table class="table" style="width: 99%;">
						<tr>
							<td style="text-align:right;"><nobr>标题</nobr>
							</td>
							<td><input id="archivetitle" name="archivetitle"
								style="width: 200px" /></td>
							<td style="text-align:right;"><nobr>操作员</nobr>
							</td>
							<td><input id="archiveopperuser" name="archiveopperuser"
								style="width:200px" />
							</td>
						</tr>
						<tr>
							<td style="text-align:center;" colspan="4"><a
								href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0)"
								class="easyui-linkbutton" iconCls="icon-reload"
								onclick="refresh()"> 重 置 </a></td>
						</tr>


					</table>
				</sicp3:groupbox>
				<sicp3:groupbox title="文档列表">
					<div id="toolbar">
						<table>
							<tr>
								<td><a href="javascript:void(0)" class="easyui-linkbutton"
									data="btn_addArchive" iconCls="icon-add" plain="true"
									onclick="addArchive()">增加</a></td>
								<td>
									<div class="datagrid-btn-separator"></div></td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton"
									data="btn_archiveFormIndex" iconCls="icon-edit" plain="true"
									onclick="updateArchive()" id="btn_editArchive">编辑</a></td>
								<td>
									<div class="datagrid-btn-separator"></div></td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton"
									id="btn_delArchive" name="btn_delArchive" data="btn_delArchive"
									iconCls="icon-remove" plain="true" onclick="delArchive()">删除</a></td>
								<td>
									<div class="datagrid-btn-separator"></div></td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton"
									id="btn_archiveFormIndex" name="btn_archiveFormIndex" data="btn_archiveFormIndex"
									iconCls="ext-icon-application_form_magnify" plain="true" onclick="showArchive()">查看</a></td>
								<td>
								<td>
									<div class="datagrid-btn-separator"></div></td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_shouliAjdj" id="btn_shouliArchive" name="btn_shouliArchive"
									   iconCls="icon-ok" plain="true" onclick="fawenkaishishouli()">发文受理</a>
								</td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_shouliAjdj" id="btn_shouliArchive" name="btn_shouliArchive"
									   iconCls="icon-ok" plain="true" onclick="shouwenkaishishouli()">收文受理</a>
								</td>
								<td>
									<div class="datagrid-btn-separator"></div>
								</td>
								<td><a href="javascript:void(0)"  class="easyui-linkbutton" data="btn_shoulirizhiAjdj"
									   id="btn_shoulirizhiArchive"
									   iconCls="ext-icon-overlays" plain="true" onclick="shoulirizhi()">受理日志</a>
								</td>
								<td>
									<div class="datagrid-btn-separator"></div>
								</td>
							</tr>
						</table>
					</div>
					<div id="mygrid" style="height:350px;overflow:auto;"></div>
				</sicp3:groupbox>
			</div>
		</form>
	</div>--%>
</body>
</html>
