<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
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
<title>表格样式设置</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var grid;
	$(function() { 
		 grid = $('#grid').datagrid({
				//title: '法律法规条款条款',
				//iconCls: 'icon-tip',
				toolbar: '#toolbar',
				 url: basePath + '/supervision/checkTbodyinfo/getTbodyinfoList',  //调用后台的方法
				striped : true,// 奇偶行使用不同背景色
				singleSelect : true,// True只允许选中一行
				checkOnSelect : false,
				selectOnCheck : false,			
				pagination : true,// 底部显示分页栏
				pageSize : 10,
				pageList : [ 10, 20, 30 ],
				rownumbers : true,// 是否显示行号
				fitColumns : false,// 列自适应宽度			
			    idField: 'tbodyid', //该列是一个唯一列
			    sortOrder: 'asc',
			    columns :[[
			    {
					width : '150',
					title : 'id',
					field : 'tbodyid',
					hidden : true
				},{
					width : '220',
					title : '表格类别',
					field : 'tbodytype',
					hidden : false
				},
				{
					width : '100',
					title : '计划类别',
					field : 'tbodycode',
					hidden : false
				},
// 				{
// 					width : '100',
// 					title : '表头数据信息',
// 					field : 'tbodyinfo',
// 					hidden : false
// 				}
// 				,{
// 					width : '100',
// 					title : '表头固定信息',
// 					field : 'tbody',
// 					hidden : false
// 				},
				{
					width : '100',
					title : '表尾信息',
					field : 'tfootinfo',
					formatter: function(value,row,index){
			          return "<a  onclick='viewTbdoy("+row.tbodyid+")'>111</a>";
			         }
				}
				] ]
			});
		
	}); 
	
</script>
	
<script type="text/javascript">
	function refresh(){
		parent.window.refresh();	
	} 
	
	// 查询
	function query() {
		var itemid = $("#itemid").val();
		var aaa100 = $("#aaa100").val();
		var aaa102 = $("#aaa102").combobox("getValue");
		var param = {
			'itemid': itemid,
			'aaa102':aaa102,
			'aaa100':aaa100
		};
		$('#grid').datagrid({
			url:basePath + '/supervision/checkTbodyinfo/getcheckAndTypeList',
			queryParams : param
		});
		$('#grid').datagrid('clearSelections');	
	}
	
	// 新增项目内容
	var saveTbdoyinfo = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增项目内容',
			width : 800,
			height : 600,
			url : basePath + '/supervision/checkTbodyinfo/tosaveTbodyInfo?op=add',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.saveContent(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};

	//编辑项目内容
	var editTbdoyinfo = function(){
		var row = $("#grid").datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				 title : '编辑项目内容',    
				 width : 900,    
				 height : 600,      
				 url :  basePath+'/supervision/checkTbodyinfo/tosaveTbodyInfo?op=edit&tbodyid='+row.tbodyid,     
				 buttons:[{
						text:'确定',
						handler:function(){
							dialog.find('iframe').get(0).contentWindow.saveContent(dialog,grid,parent.$);
						}
					},{
						text:'取消',
						handler:function(){
							dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
						}
					}]

			});
		}else{
			$.messager.alert('提示','请先选择要修改的项目内容信息！','info');
		}
	};
	
	//查看
	var viewTbdoyinfo = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看项目内容',
				width :900,
				height :600,
				url : basePath+'/supervision/checkTbodyinfo/tosaveTbodyInfo?op=view&tbodyid='+row.tbodyid,
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
	};
	
	//删除项目内容
	var delTbdoyinfo = function(){
		var row = $("#grid").datagrid('getSelected');
		if(row){
			$.messager.confirm('警告', '您确定要删除该条信息吗?', function(r){
				if (r){
					//异步删除
					$.post(basePath+'/supervision/checkTbodyinfo/delCheckAndType',{
						basetype : row.basetype,
						itemtype : row.itemtype.trim()
					},function(result){
						if(result.code=='0'){
							$.messager.alert('提示','删除成功！','info',function(){
								$("#grid").datagrid('reload');
							});
						}else{
							$.messager.alert('提示','删除失败：'+result.msg,'error');
						}
					},'json');
				}
			});
		}else{
			$.messager.alert('提示','请先选择要删除的项目内容信息！','info');
		}
	};
	
	
	
	//查看表格各种信息
	var viewTbdoy = function(value){
			var dialog = parent.sy.modalDialog({
				title : '查看项目内容',
				width :900,
				height :600,
				url : basePath+'/supervision/checkTbodyinfo/toTbodyInfo?op=view&tbodyid='+value,
				buttons : [{
					text : '关闭',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
	};
</script>

</head>
<body>
<div class="easyui-layout" fit="true">   
        <div region="center" style="overflow: hidden;" border="false">
	        <sicp3:groupbox title="检查内容管理">
	        <div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveTbdoyinfo"
								iconCls="icon-add" plain="true" onclick="saveTbdoyinfo()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_editTbdoyinfo"
								iconCls="icon-edit" plain="true" onclick="editTbdoyinfo()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_viewTbdoyinfo"
								iconCls="ext-icon-report_magnify" plain="true" onclick="viewTbdoyinfo()">查看</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
						</tr>
					</table>
				</div>
	        <div id="grid" style="height:350px;overflow:auto;" ></div>
	        </sicp3:groupbox>
        </div>
        <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
			<ul id="treeDemo2" class="ztree" style="margin-top:0px;width:205px;height:230px;"></ul>
		</div>         
    </div>    	
</body>
</html>