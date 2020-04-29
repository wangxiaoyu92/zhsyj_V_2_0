<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
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
<title>检验检测结果</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include> 
<script type="text/javascript">
	//检测检验类别
	var v_jcjylb= <%=SysmanageUtil.getAa10toJsonArray("JCJYLB")%>;
	// 检验检测结论
	var v_jyjcjl= <%=SysmanageUtil.getAa10toJsonArray("JYJCJL")%>;
	//检测检验审核标志
	var v_shbz= <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
	var grid;
	$(function(){
		grid=$("#grid").datagrid({
			//title: '检验检测项目',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + 'jyjc/queryJyjcjg',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcjgid', //该列是一个唯一列
		    sortOrder: 'asc',
			columns :[[{
				width : '100',
				title : '检测结果ID',
				field : 'jcjgid',
				hidden : true
			},{
				width : '150',
				title : '检测检验类别',
				field : 'jcjylb',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_jcjylb,value);
				}
			},{
				width : '150',
				title : '检测样品名称',
				field : 'jcypmc',
				hidden : false
			},{
				width : '230',
				title : '受检单位名称',
				field : 'commc',
				hidden : false
			},{
				width : '150',
				title : '检测项目名称',
				field : 'jcxmmc',
				hidden : false
			},{
				width : '150',
				title : '标准值',
				field : 'jcxmbzz',
				hidden : false
			},{
				width : '150',
				title : '结果值',
				field : 'imphl',
				hidden : false
			},{
				width : '150',
				title : '复检结果',
				field : 'fjjg',
				hidden : false
			},{
				width : '150',
				title : '结论',
				field : 'impjcjg',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_jyjcjl,value);
				}
			},{
				width : '150',
				title : '检测日期',
				field : 'impjcsj',
				hidden : false
			},{
				width : '150',
				title : '检验员',
				field : 'impjcry',
				hidden : false
			},{
				width : '150',
				title : '处理结果',
				field : 'jcjycljg',
				hidden : false
			},{
				width : '150',
				title : '审核标志',
				field : 'jcjyshbz',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_shbz,value);
				}
			}
			
			]]
		});
	});
	//查询检验检测项目
	function query() {
		var param = {
			'comdm': $('#comdm').val(),
			'impjcry':$('#impjcry').val() 
		};
		grid.datagrid({
			url : basePath + 'jyjc/queryJyjcjg',			
			queryParams : param
		}); 
		grid.datagrid('clearSelections');
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	}   
	//新增检验检测项目
	var addJyjcjg = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增检验检测结果',
			width : 800,
			height : 400,
			url : basePath + '/jyjc/jyjcjgFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};

	//编辑诚信评定等级参数信息
	var updateJyjcjg = function(){
		var row = $('#grid').datagrid('getSelected');
		var url=basePath + '/jyjc/jyjcjgFormIndex';
		if(row){
			var dialog = parent.sy.modalDialog({
				title:'编辑检验检测结果',
				param : {
				jcjgid:row.jcjgid
				},
				width:900,
				height:600,
				url:url,
				buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
		}else{
			$.messager.alert('提示','请先选择要修改的检验检测结果信息！','info');
		}
	}
	
	// 删除检验检测结果信息
	function delJyjcjg() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var jcjgid = row.jcjgid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?该操作将不可恢复',function(r) {
				if (r) {
					$.post(basePath + '/jyjc/delJyjcjg', {
						jcjgid: jcjgid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#grid').datagrid('reload'); 
			        		});    	
						} else {
							$.messager.alert('提示', '删除失败：' + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的检验检测项目信息！', 'info');
		}
	}  	
	
	//查看检验检测项目
	var showJyjcjg = function(){
		var row = $('#grid').datagrid('getSelected');
		var url=basePath +'/jyjc/jyjcjgFormIndex';
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看检验检测结果',
				param : {
				op:"view",
				jcjgid:row.jcjgid
				},
				width :900,
				height :600,
				url : url,
				buttons : [{
					text : '关闭',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要查看的信息！','info');
		}
	}
	//从单位信息表中读取
	function myselectcom(){
		var url = "<%=basePath%>pub/pub/selectcomIndex";
		var dialog = parent.sy.modalDialog({
		title : '选择企业',
		param : {
		a : new Date().getMilliseconds(),
		singleSelect:"true",
		comjyjcbz : "1"
		},
		width : 800,
		height : 600,
		url : url
		},function (dialogID){
		var obj = sy.getWinRet(dialogID);//不可缺少
		if (obj!=null && obj.length>0){
		 for (var k=0;k<=obj.length-1;k++){
		 var myrow=obj[k];
	      $("#commc").val(myrow.commc); //公司名称   
	      $("#comdm").val(myrow.comdm); //公司代码     
		 }
		}
		sy.removeWinRet(dialogID);//不可缺少	
		});
	}
		
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>企业编号</nobr></td>
						<td><input id="comdm" name="comdm" style="width: 200px"/>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectcom()">选择企业 </a>						
						</td>						
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="commc" name="commc" style="width:200px" /></td>	
					</tr>
					<tr><td style="text-align:right;"><nobr>检验员</nobr></td>
						<td><input id="impjcry" name="impjcry" style="width: 200px"/></td>					
						<td colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="检测结果信息">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveJyjcjg"
								iconCls="icon-add" plain="true" onclick="addJyjcjg()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveJyjcjg"
								iconCls="icon-edit" plain="true" onclick="updateJyjcjg()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delJyjcjg"
								iconCls="icon-remove" plain="true" onclick="delJyjcjg()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_jyjcjgFormIndex"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showJyjcjg()">查看</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<!-- <td><a href="javascript:void(0)" class="easyui-linkbutton" 
								iconCls="icon-print" plain="true" onclick="print()">打印</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>    -->
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>