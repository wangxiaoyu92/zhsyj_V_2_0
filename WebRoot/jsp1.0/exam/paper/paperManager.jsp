<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig, com.zzhdsoft.utils.SysmanageUtil" %>
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
<title>试卷管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var grid;
	// 试卷状态
	var v_paperInfoState = [{"id":"","text":"===请选择==="},{"id":"0","text":"禁用"},{"id":"1","text":"启用"}]; 
	$(function() {
	    // 试卷状态
		$("#paperInfoState").combobox({
	    	data : v_paperInfoState,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
	    // 试卷表格
		grid = $('#grid').datagrid({
			toolbar : '#toolbar',
			url : basePath + 'exam/paper/queryPapers',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'paperInfoId', //该列是一个唯一列
		    sortOrder: 'desc',
			columns : [ [ {
				title : '试卷id',
				field : 'paperInfoId',
				width : '100',
				hidden : true
			},{
				title : '试卷状态',
				field : 'paperInfoState',
				width : '100',
				hidden : false,
				formatter : function(value,row){
					return sy.formatGridCode(v_paperInfoState, value);
				}
			},{
				title : '试卷名称',
				field : 'paperInfoName',
				width : '300',
				hidden : false,
				formatter: function(value, row, index) {
					return "<a href='javascript:void(0)' onclick='showPaperInfo(" + "\"" 
						+ row.paperInfoId + "\"" + ")' title='" + value + "'>" 
						+ value + "</a>";
				}
			},{
				title : '试卷总分',
				field : 'points',
				width : '100',
				hidden : false
			},{
				title : '试题总数',
				field : 'total',
				width : '100',
				hidden : false
			},{
				title : '及格分数',
				field : 'paperInfoPass',
				width : '100',
				hidden : false
			},{
				title : '创建人',
				field : 'aae011',
				width : '100',
				hidden : false
			},{
				title : '最后更新时间',
				field : 'aae036',
				width : '150',
				hidden : false
			},{
				title : '备注',
				field : 'aae013',
				width : '100',
				hidden : true
			}] ]
		});
	});
	// 查询试卷
	function query() {
		var v_paperInfoState = $('#paperInfoState').combobox('getValue'); // 试卷状态
		var v_paperInfoName = $('#paperInfoName').val(); // 试卷名称
		var param = {
			'paperInfoState' : v_paperInfoState,
			'paperInfoName' : v_paperInfoName
		};
		$('#grid').datagrid('load', param);
		grid.datagrid('clearSelections');
	}
	// 重置
	function refresh(){
		parent.window.refresh();	
	} 
	// 新增，跳转到新增页面
	function addPaper() {
		var url=basePath + "exam/paper/paperInfoFormIndex";
		var dialog = parent.sy.modalDialog({
			title : '添加试卷',
			width : 700,
			height : 600,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			if(obj != null){
			if(obj == 'ok'){
				grid.datagrid('reload');
			}
		}
		sy.removeWinRet(dialogID);//不可缺少
		})
	} 		
	// 编辑试卷
	function editPaper() {		
		var row = $('#grid').datagrid('getSelected');
		var url=basePath + "exam/paper/paperInfoFormIndex";
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑试卷',
				param : {
					paperInfoId:row.paperInfoId
				},
				width : 700,
				height : 600,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);//不可缺少
				if(obj != null && obj == "ok"){
				grid.datagrid('reload');
			}
			sy.removeWinRet(dialogID);//不可缺少
			})
		}else{
			$.messager.alert('提示', '请先选择要修改的试卷！', 'info');
		}
	} 
	// 删除试卷
	function delPaper() {
		var rows = grid.datagrid("getSelections");
		if (rows) {
			var JsonStr = $.toJSON(rows);
			var param = {
				'JsonStr' : JsonStr
			};  
			$.post(basePath + 'exam/paper/delPaperInfos', param, function(result) {
				if (result.code == '0'){
	        		$.messager.alert('提示','操作成功！','info',function(){
	        			$('#grid').datagrid('reload'); 
	        		}); 	                        	                     
	             	} else {
	             		$.messager.alert('提示','操作失败：' + result.msg,'error');
	               }
			}, 'json');
		} else {
			$.messager.alert('提示', '请先选择要删除的试卷！', 'info');
		}
	} 
	// 查看试卷
	function showPaperInfo(infoId){
		var url=basePath + "exam/paper/showPaperInfo";
		var row = $('#grid').datagrid('getSelected');
		if (row || infoId) {
			var paperInfoId = infoId ? infoId : row.paperInfoId;
			var dialog = parent.sy.modalDialog({
				title : '添加试卷',
				param : {
					paperInfoId:paperInfoId
				},
				width : 600,
				height : 550,
				url : url
			})
			var obj = new Object();
		} else {
			$.messager.alert('提示', '请先选择要查看的试卷！', 'info');
		}
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>试卷状态</nobr></td>
						<td><input id="paperInfoState" name="paperInfoState" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>试卷名称</nobr></td>
						<td><input id="paperInfoName" name="paperInfoName" style="width: 200px" /></td>							
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="试卷列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	   
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showPaperInfo"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showPaperInfo()">预览</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>    		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addPaper"
								iconCls="icon-add" plain="true" onclick="addPaper()">增加</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_editPaper"
								iconCls="icon-edit" plain="true" onclick="editPaper()">编辑</a>
							</td>  
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delPaper"
								iconCls="icon-remove" plain="true" onclick="delPaper()">删除</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
						</tr>
					</table>
				</div>
				<div id="grid"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>