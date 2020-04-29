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
<title>诚信评定结果</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	//红黑榜等级
	var djcshh = <%=SysmanageUtil.getAa10toJsonArray("DJCSHH")%>;
	//生成方式
	var pdjgscfs = <%=SysmanageUtil.getAa10toJsonArray("PDJGSCFS")%>
	var cb_djcshh;
	var cb_pdjgscfs;
	var grid;
	$(function() {
		cb_djcshh = $('#djcshh').combobox({
			data : djcshh,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight : 180,
			panelWidth : 280
		});
		cb_pdjgscfs = $('#pdjgscfs').combobox({
			data : pdjgscfs,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable : false,
			panelHeight : 180,
			panelWidth : 280
		});
		grid = $('#grid').datagrid({
			//title: '诚信评定结果表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + 'zx/zxpdjg/queryZxpdjg',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'pdjgid', //该列是一个唯一列
		    sortOrder: 'asc',
		    frozenColumns :[[ {
				width : '100',
				title : '评定结果ID',
				field : 'pdjgid',
				hidden : true
			},{
				width : '100',
				title : '企业ID',
				field : 'comid',
				hidden : false
			},{
				width : '100',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '100',
				title : '年度',
				field : 'niandu',
				hidden : false
			},{
				width : '100',
				title : '得分',
				field : 'pdjgdf',
				hidden : false
			},{
				width : '150',
				title : '等级编码',
				field : 'djcsbm',
				hidden : false
			},{
				width : '150',
				title : '等级红黑',
				field : 'djcshh',
				hidden : false,
				formatter : function(value,row){
					return sy.formatGridCode(djcshh, value);
				}
			}] ],
			columns : [ [ 
			{
				width : '100',
				title : '操作员姓名',
				field : 'czyxm',
				hidden : false
			},{
				width : '150',
				title : '操作时间',
				field : 'czsj',
				hidden : false
			},{
				width : '150',
				title : '产生方式',
				field : 'pdjgscfs',
				hidden : false,
				formatter : function(value,row){
					return sy.formatGridCode(pdjgscfs, value);
				}
			},{
				width : '100',
				title : '备注',
				field : 'beizhu',
				hidden : false
			}] ]
		});
	});
	
	//页面加载完成自动生成年度信息
	$(function(){
		var year = new Date().getFullYear();
		for(var i = year;i>2010;i--){
			var temp = '<option value='+(i)+'>'+i+'</option>';
			//设置value的值和列表参数
			var $time = $(temp);
			$("#niandu").append($time);
		}
	});
	//查询企业诚信评定结果
	function query() {
		var param = {
			'commc': $('#commc').val(),  
			'djcshh': $('#djcshh').combobox('getValue'),
			'niandu':$('#niandu').val() 
		};
		grid.datagrid({
			url : basePath + '/zx/zxpdjg/queryZxpdjg',			
			queryParams : param
		});
		grid.datagrid('clearSelections');  
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增企业评定信息
	var addZxpdjg = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增诚信评定信息',
			width : 900,
			height : 400,
			url : basePath + '/zx/zxpdjg/zxpdjgFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.saveZxpdjg(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};

	//编辑企业评定信息
	var updateZxpdjg = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title:'编辑诚信评定信息',
				width:900,
				height:400,
				url:basePath + '/zx/zxpdjg/zxpdjgFormIndex?pdjgid='+row.pdjgid,
				buttons:[{
					text : '确定',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.saveZxpdjg(dialog,grid,parent.$);
					}
				},{
					text : '取消',
					handler : function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要修改的企业评定信息！','info');
		}
	}
	
	// 删除企业评定信息
	function delZxpdjg() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var pdjgid = row.pdjgid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'zx/zxpdjg/delZxpdjg', {
						pdjgid: row.pdjgid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#grid').datagrid('reload'); 
			        		});    	
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的企业评定信息！', 'info');
		}
	}  	
	
	//查看企业评定信息
	var showZxpdjg = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看企业诚信评定信息',
				width :900,
				height :400,
				url : basePath +'/zx/zxpdjg/zxpdjgFormIndex?op=view&pdjgid='+row.pdjgid,
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
	
	//查询企业信息
	function querySelectcom() {
		var v_form = $('#myqueryfm');
		var dialog = parent.sy.modalDialog({
			title : '企业信息',
			iconCls : 'ext-icon-monitor',
			width : 800,
			height : 600,
			url : basePath + 'pub/selectcomIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.getDataInfo(dialog, v_form, parent.$); 
				}
			},{
				text : '取消',
				handler : function() {
					dialog.dialog('close');
				}
			} ]
		});
		
	}
	
	//查询企业信息
	function querySelectcom2() {
		var v_form = $('#ajdjAddDlgfm');
		var dialog = parent.sy.modalDialog({
			title : '企业信息',
			iconCls : 'ext-icon-monitor',
			width : 800,
			height : 600,
			url : basePath + 'pub/selectcomIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.getDataInfo(dialog, v_form, parent.$); 
				}
			},{
				text : '取消',
				handler : function() {
					dialog.dialog('close');
				}
			} ]
		});
	}
	
	//从单位信息表中读取
	function myselectcom(){
		var url = "<%=basePath%>pub/pub/selectcomIndex?a="+new Date().getMilliseconds();

		var dialog = parent.sy.modalDialog({
			title : ' ',
			param : {
				singleSelect : true
			},
			width : 800,
			height : 600,
			url : url
		},function(dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);
			if (obj!=null && obj.length>0){
				for (var k=0;k<=obj.length-1;k++){
					var myrow=obj[k];
					$("#commc").val(myrow.commc); //公司名称
					$("#comid").val(myrow.comid); //公司代码
				}
			}
		});
	}
/* 	//打印
	function print(){	 
		sy.doPrint('siweb/sysuser.cpt','')
	}  */	
	
	// 保存诚信评定信息 
	function scZxpdjg() {
		var v_niandu=$("#niandu").val();
		if (v_niandu==null || v_niandu==""){
			alert("请选择年度");
			return false;
		}

		$.messager.confirm('警告', '您确定要根据该年度采集的信息生成年度征信评定结果吗?',function(r) {
			if (r) {
				$.post(basePath + '/zx/zxpdjg/scZxpdjgFromCjxx', {
					niandu: v_niandu
				},
				function(result) {
					if (result.code == '0') {
						$.messager.alert('提示','生成成功！','info',function(){
							$('#grid').datagrid('reload'); 
		        		});    	
					} else {
						$.messager.alert('提示', "生成失败：" + result.msg, 'error');
					}
				},
				'json');
			}
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
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="commc" name="commc" style="width: 200px"/></td>						
<!-- 						<td><input id="comid" name="comid" style="width: 200px"/>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
						</td>						 -->
						<td style="text-align:right;"><nobr>企业红黑</nobr></td>
						<td><input id="djcshh" name="djcshh" style="width: 200px" />
						</td>								
					</tr>
					<tr><td style="text-align:right;"><nobr>年度</nobr></td>
						<td>
							<select id="niandu" name="niandu" style="width: 200px">
								<option value="">==请选择==</option>
							</select>
						</td>				
						<td colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="ext-icon-image_add" onclick="scZxpdjg()">生成征信评定结果</a>								
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="诚信评定结果表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveZxpdjg"
								iconCls="icon-add" plain="true" onclick="addZxpdjg()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveZxpdjg"
								iconCls="icon-edit" plain="true" onclick="updateZxpdjg()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delZxpdjg"
								iconCls="icon-remove" plain="true" onclick="delZxpdjg()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_zxpdjgFormIndex"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showZxpdjg()">查看</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>