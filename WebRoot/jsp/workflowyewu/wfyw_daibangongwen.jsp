<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>待办业务</title>
<jsp:include page="${contextPath}/inc.jsp">
	<jsp:param name="isLayUIString" value="true"></jsp:param>
</jsp:include>
<script type="text/javascript">
	//下拉框列表
	var sfqygzl = <%=SysmanageUtil.getAa10toJsonArray("SFQYGZL")%>;
	var cb_sfqygzl;
	var grid;

	$(function() {
//		cb_sfqygzl = $('#sfqygzl').combobox({
//	    	data : sfqygzl,
//	        valueField : 'id',
//	        textField : 'text',
//	        required : false,
//	        editable : false,
//	        panelHeight : 'auto'
//	    });

		layui.use(['form', 'table', 'layer', 'element'], function () {
			form = layui.form;
			table = layui.table;
			layer = layui.layer;
			var element = layui.element;
//			intSelectData('slbz', v_slbz);
//			intSelectData('ajjsbz', V_AJJSBZ);
			form.render();
			mask = layer.load(1, {shade: [0.1, '#393D49']});
			table.render({
				elem: '#ajdjTable'
				, method: 'post' // 如果无需自定义HTTP类型，可不加该参数
				, url: basePath + '/workflow/queryWfywgongwenDaiban'
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
					{field:'opt',title:'操作',align:'center',width:280,
                        templet: function (d) {
                            if(d.psbh=='WF2018070400359') {
                                return '<a class="layui-btn layui-btn-danger" href="javascript:showYwbllog(\'' + d.ywbh + '\')" lay-event="detail">' + d.nodename + '</a>'
                            }else{
                                return '<a class="layui-btn layui-btn-xs" href="javascript:wfywbl(\'' + d.ywlcid + '\',\'' + d.psbh + '\',\'' + d.nodeid + '\',\'' + d.nodename + '\',\'' + d.nodeurl + '\',\'' + d.ywbh + '\',\'' + d.nodename + '\',\'' + d.fjcsdmlb + '\',\'' + d.fjcsdlbh + '\')" lay-event="detail">' + d.nodename + '</a>' +
                                    '<a class="layui-btn layui-btn-primary layui-btn-xs" href="javascript:htdsyb(\'' + d.ywlcid + '\',\'' + d.psbh + '\',\'' + d.nodeid + '\',\'' + d.nodename + '\',\'' + d.ywbh + '\')" lay-event="edit">回退到上一步</a>';
                            }
                        }
					}
					, {field: 'psmc', width: 150, title: '工作流名称', event: 'trclick'}
					, {field: 'ywbh', width: 80, title: '业务编号', event: 'trclick'}
					, {field: 'commc', width: 130, title: '待办事项', event: 'trclick'}
					, {field: 'nodename', width: 120, title: '节点名称', event: 'trclick'}
					, {field: 'fjcsdmlb', width: 100, title: '附件参数代码类别', event: 'trclick'}
					, {field: 'fjcsdlbh', width: 150, title: '附件参数大类编号', event: 'trclick'}
					, {
						field: 'sxzt', width: 150, title: '时限状态'
						, templet: function (d) {
							var sxzt = d.id;
							$.each(sfqygzl, function (i, n) {
								if (d.sxzt == n.id) {
									sxzt = n.text;
									return false; // 跳出本次循环
								}
							});
							return sxzt;
						}
//						, templet: function (d) {
//							return formatGridColData(v_AJDJAJLY, d.ajdjajly);
//						}
						, event: 'trclick'
					}
				]]
				, done: function (res, curr, count) {
					table.singleData = '';
					selectTableDataId = '';
					layer.close(mask);
				}
			});
			// 监听工具条
			table.on('tool(AjdjFilter)', function (obj) {
				var data = obj.data;
				if (obj.event === 'trclick') { // 选中行
					if (selectTableDataId != data.ywlcid) {
						// 清除所有行的样式
						$(".layui-table-body tr").each(function (k, v) {
							$(v).removeAttr("style");
						});
						$(obj.tr.selector).css("background", "#90E2DA");
						table.singleData = data;
						selectTableDataId = data.ywlcid;
					} else { // 再次选中清除样式
						$(obj.tr.selector).attr("style", "");
						table.singleData = '';
						selectTableDataId = '';
					}
				}
			});

			var $ = layui.$, active = {
				doWfprocess: function () { // 查看执法办案流程图
					doWfprocess();
				}
				, showYwbllog: function () { // 查看办理日志
					if (!table.singleData) {
						layer.alert('请选择要查看办理日志！');
					} else {
						showYwbllog(table.singleData.ywbh);
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



	//查询
	function query() {
		var ywbh = $('#ywbh').val();
//		alert(ywbh);
		var param = {
			'ywbh': ywbh
		};
		refresh(param,'');
	}


	function wfywbl(v_ywlcid,v_psbh,v_nodeid,v_nodename,v_nodeurl,v_ywbh,v_nodename,v_fjcsdmlb,v_fjcsdlbh){
		//var v_ywlcid = row.ywlcid;
		//var v_ywbh = row.ywbh;
		//var v_psbh = row.psbh;
		//var v_nodeid = row.nodeid;
		//var v_nodename = row.nodename;
		//var v_nodeurl = row.nodeurl;
//		alert(v_nodename);

		var cfmMsg= "确定要【"+v_nodename+"】业务编号为【"+v_ywbh+"】的记录吗?";

//		var row = grid.datagrid('getSelected');
		if (v_nodename) {
			$.messager.confirm('警告', cfmMsg, function(r) {
				if (r) {
					//if(retVal != null){
					//	if(retVal.type == 'ok'){
					//		grid.datagrid('load');
					//	}
					//}
					var url = contextPath + v_nodeurl;
					sy.modalDialog({
						title : '',
						param : {
							ywlcid : v_ywlcid,
							ywbh : v_ywbh,
							psbh : v_psbh,
							nodeid : v_nodeid,
							nodename : v_nodename,
							fjcsdmlb : v_fjcsdmlb,
							fjcsdlbh : v_fjcsdlbh
						},
						area:[ '1000px','600px'],
						url : url,
						btn: [ '取消'] //可以无限个按钮
						,btn1: function(){
							layer.closeAll();
						}
					}, closeModalDialogCallback);
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}
	}


	function closeModalDialogCallback(dialogID) {
		var obj = sy.getWinRet(dialogID);
		sy.removeWinRet(dialogID);

		if (obj == null || obj == '') {
			return;
		}
		if (obj.type == "ok") {
			var curent = $(".layui-laypage-skip input[class='layui-input']").val();
			refresh('', curent);
		} else {
			refresh('', '');
		}
	}

	// 刷新
	function refresh(param,cur) {
		//删除时 在本页面刷新
		if(cur==""){
			curr=1;
		}else{
			curr=cur;
		}
		//刷新的时候显示进度条
		mask = layer.load(1, {shade: [0.1, '#393D49']});
		table.reload('ajdjTable', {
			url: basePath +  '/workflow/queryWfywgongwenDaiban'
			, page: {
				curr: curr //重新从第 1 页开始
			}
			, where: param //设定异步数据接口的额外参数
			,done:function () {
				table.singleData = '';
				selectTableDataId = '';
				layer.close(mask);
			}
		});
		/*		parent.window.refresh();*/
	}



	function doWfprocess() {
		var url = basePath + 'jsp/workflowyewu/wfyw_zfbalct.jsp';
		layer.open({
			type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			, area: ['1000px', '550px'] //
			, title: '查看信息'
			, content: url
			, btn: ['关闭']
		});
	}

		function showYwbllog(_ywbh){
			var url = basePath + 'workflow/wfywlclogIndex';
			var dialog = sy.modalDialog({
				title : '查看日志',
				param : {
						ywbh : _ywbh,
						time : new Date().getMilliseconds()
				},
				area:[ '1000px','550px'],
				content : url
			},function(dialogID) {
				var obj = sy.getWinRet(dialogID);
				if (obj != null && "ok"==obj){
					$("#grid").datagrid("reload");
				}
				sy.removeWinRet(dialogID);//不可缺少
			});
		}

//		var dialog = parent.sy.modalDialog({
//				title : '查看',
//				width : 900,
//				height : 600,
//				url : url,
//			    maximizable:true
//		},function(dialogID) {
//		    sy.removeWinRet(dialogID);//不可缺少
//		});


	function wfywbl(v_ywlcid,v_psbh,v_nodeid,v_nodename,v_nodeurl,v_ywbh,v_nodename,v_fjcsdmlb,v_fjcsdlbh){
		//var v_ywlcid = row.ywlcid;
		//var v_ywbh = row.ywbh;
		//var v_psbh = row.psbh;
		//var v_nodeid = row.nodeid;
		//var v_nodename = row.nodename;
		//var v_nodeurl = row.nodeurl;

		var cfmMsg= "确定要【"+v_nodename+"】业务编号为【"+v_ywbh+"】的记录吗?";

		//var row = grid.datagrid('getSelected');
		if (true) {
			$.messager.confirm('警告', cfmMsg, function(r) {
				if (r) {
					var url = contextPath + v_nodeurl;
			sy.modalDialog({
				title: '流程处理'
				, area: ['830px', '550px']
				, content: url
				,param : {
					ywlcid : v_ywlcid,
					ywbh : v_ywbh,
					psbh : v_psbh,
					nodeid : v_nodeid,
					nodename : v_nodename,
					fjcsdmlb : v_fjcsdmlb,
					fjcsdlbh : v_fjcsdlbh
				},
				btn: [ '关闭']
				, btn1: function (index, layero) {
						//当前页面刷新
					layer.close(index);

					refresh();
					}
				}, function (dialogID) {
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少
				if (obj!=null && "ok"==obj){
				}
				});

				}
			});
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}
		}
	function htdsyb(v_ywlcid,v_psbh,v_nodeid,v_nodename,v_ywbh){

		var cfmMsg= "确定要回退【"+v_nodename+"】业务编号为【"+v_ywbh+"】的记录吗?";
		var v_url=encodeURI(encodeURI(basePath+"/workflow/huituiWfprocess?ywlcid="
			+v_ywlcid+"&ywbh="+v_ywbh+"&psbh="+v_psbh+"&nodeid="+v_nodeid));

		 $.messager.confirm('确认', cfmMsg, function (r) {
			    if(r){
					parent.$.messager.progress({
						text : '开始受理....'
					});
					$.ajax({
						url:v_url,
						type:'post',
						async:true,
						cache:false,
						timeout: 100000,
						//data:formData,
						error:function(){
						    parent.$.messager.progress('close');
							alert("服务器繁忙，请稍后再试！");
						},
				        success: function(result){
				        	result = $.parseJSON(result);
						 	if (result.code=='0'){
//						 		$("#grid").datagrid('reload');
						 		parent.$.messager.progress('close');
						 		parent.$.messager.alert('提示','回退成功！','info',function(){
                                    window.location.href = window.location.href;
				        		});
			              	} else {
			              		parent.$.messager.progress('close');
			              		parent.$.messager.alert('提示','回退失败：'+result.msg,'error');
                                window.location.href = window.location.href;
			                }
				        }
					});
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
			<div class="layui-colla-content layui-show">
				<form class="layui-form" id="myqueryform" >

					<div class="layui-form-item" style="text-align:left ">
						<label class="layui-form-label">业务编号:</label>

						<div class="layui-input-inline">
							<input type="text" id="ywbh" name="ywbh"
								   autocomplete="off" class="layui-input">
						</div>

						<label class="layui-form-label" style="width: 100px"></label>

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
				</form>
			</div>
		</div>
	</div>
	<div class="layui-margin-top-15">
		<div class="layui-btn-group demoTable">
			<ck:permission biz="doWfprocess">
				<button class="layui-btn" data-type="doWfprocess" data="btn_doWfprocess">查看执法办案流程图</button>
			</ck:permission>
			<ck:permission biz="showYwbllog">
				<button class="layui-btn" data-type="showYwbllog" data="btn_showYwbllog" >查看办理日志
				</button>
			</ck:permission>

		</div>
		<table class="layui-hide" id="ajdjTable" lay-filter="AjdjFilter"></table>
	</div>
</div>


</body>
</html>