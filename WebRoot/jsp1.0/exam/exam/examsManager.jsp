<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig, com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>考试管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var grid;
	$(function() {
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
			url : basePath + 'exam/exam/queryExamInfos',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'examsInfoId', //该列是一个唯一列
		    sortOrder: 'desc',
			columns : [[{
				title: '考试id',
				field: 'examsInfoId',
				width : '100',
				hidden : true
			},{
				title: '考试状态',
				field: 'examsInfoState',
				width: '100',
				hidden : false,
				formatter: function(value, row, index) {
					if (value == "0") {
						return '<span>禁用</span>';
					} else if ((value == "1")) {
						return '<span>启用</span>';
					} 
				}
			},{
				title: '考试名称',
				field: 'examsInfoName',
				width : '300',
				hidden : false
			},{
				title: '创建人',
				field: 'aae011',
				width: '100',
				hidden : false
			},{
				title: '最后更新时间',
				field: 'aae036',
				width: '150',
				hidden : false
			}] ]
		});
	});
	// 查询考试
	function query() {
		var v_examName = $('#examName').val();
		var param = {
			'examsInfoName' : v_examName
		};
		$('#grid').datagrid('load', param);
		grid.datagrid('clearSelections');
	}
	// 重置
	function refresh(){
		parent.window.refresh();	
	} 
	// 新增，跳转到新增页面
	function addExam() {
		var url=basePath + "exam/exam/examInfoFormIndex";
		var dialog = parent.sy.modalDialog({
			title : '人员考试页面',
			width : 750,
			height : 700,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			if (obj != null) {
			if (obj == 'ok') {
				grid.datagrid('reload');
			}
		}
		sy.removeWinRet(dialogID);//不可缺少
		})
	} 		
	// 编辑考试
	function editExamInfo() {		
		var row = $('#grid').datagrid('getSelected');
		var url=basePath + "exam/exam/examInfoFormIndex";
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑考试',
				param : {
				examsInfoId : row.examsInfoId
				},
				width : 750,
				height : 700,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);//不可缺少
				if(obj != null && obj == "ok"){
					$('#grid').datagrid('reload');
				}
				sy.removeWinRet(dialogID);//不可缺少
			});
		} else {
			$.messager.alert('提示', '请先选择要修改的记录！', 'info');
		}
	} 
	// 删除考试
	function delExamInfos() {
		var rows = grid.datagrid("getSelections");
		if (rows) {
			var JsonStr = $.toJSON(rows);
			var param = {
				'JsonStr' : JsonStr
			};  
			$.post(basePath + 'exam/exam/delExamInfos', param, function(result) {
				//result = eval('(' + result + ')'); 
				if (result.code == '0'){
	        		$.messager.alert('提示','操作成功！','info',function(){
	        			$('#grid').datagrid('reload'); 
	        		}); 	                        	                     
             	} else {
             		$.messager.alert('提示','操作失败：' + result.msg,'error');
               }
			}, 'json');
		} else {
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	} 
	// 考试人员管理
	function userManager(){
		var url=basePath + 'exam/exam/examUsersIndex';
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var v_examsInfoId = "'" + row.examsInfoId + "'";	// 小组id
			if (row.examsInfoState == "0") {
				$.messager.alert('提示', '该考试还未启用！', 'info');
				return;
			}
			var dialog = parent.sy.modalDialog({
				title:'编辑考试人员',
				param : {
				examsInfoId:v_examsInfoId,
				time:new Date().getMilliseconds()
				},
				width:800,
				height:500,
				url:url
			})
		} else {
			$.messager.alert('提示', '请先选择相应的考试！', 'info');
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
						<td style="text-align:right;"><nobr>考试名称</nobr></td>
						<td><input id="examName" name="examName" style="width: 200px" /></td>							
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
        	<sicp3:groupbox title="试题列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addExam"
								iconCls="icon-add" plain="true" onclick="addExam()">增加</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_editExamInfo"
								iconCls="icon-edit" plain="true" onclick="editExamInfo()">编辑</a>
							</td>  
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delExamInfos"
								iconCls="icon-remove" plain="true" onclick="delExamInfos()">删除</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" id="btn_userManagers"
								iconCls="ext-icon-group_gear" plain="true" onclick="userManager()">考试人员管理</a>
							</td>   
							
						</tr>
					</table>
				</div>
				<div id="grid"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>