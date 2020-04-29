<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>
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
<title>进货管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var mygrid;
	$(function() {
		   mygrid = $('#mygrid').datagrid({
			//title: '进货主表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url : basePath + '/tmsyjhtgl/queryJianceyiqi',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'hjcjgjcyqbid', //该列是一个唯一列
		    nowrap:false,	
		    onLoadSuccess:function(data){
		    	mygrid.datagrid("unselectAll"); 
		    },
			columns : [ [
	        {
				width : '100',
				title : '检测机构检测仪器表id',
				field : 'hjcjgjcyqbid',
				hidden : true
			},{
				width : '90',
				title : '监管主体id',
				field : 'hviewjgztid',
				hidden : true				
			},{
				width : '160',
				title : '检测机构名称',
				field : 'jgztmc',
				hidden : false				
			},{
				width : '100',
				title : '检测仪器名称',
				field : 'jcyqmc',
				hidden : false				
			},{
				width : '130',
				title : '检测仪器型号',
				field : 'jcyqxh',
				hidden : false
			},{
				width : '150',
				title : '检测仪器序列号',
				field : 'jcyqxlh',
				hidden : false
			},{
				width : '120',
				title : '检测仪器购买日期',
				field : 'jcyqgmrq',
				hidden : false
			},{
				width : '130',
				title : '检测仪器生产日期',
				field : 'jcyqscrq',
				hidden : false
			},{
				width : '160',
				title : '检测仪器生产厂家',
				field : 'jcyqsccj',
				hidden : false
			},{
				width : '160',
				title : '检测仪器检测项目',
				field : 'jcyqjcxm',
				hidden : false
			},{
				width : '160',
				title : '检测仪器产品用途',
				field : 'jcyqcpyt',
				hidden : false			
			},{
				width : '120',
				title : '操作员',
				field : 'aae011',
				hidden : false
			},{
				width : '130',
				title : '操作时间',
				field : 'aae036',
				hidden : false
			}						
			]],
			toolbar: '#toolbar'
		});
	});/////////////////////////////////////////
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	// 新增
	function addJianceyiqi() {
		var dialog = parent.sy.modalDialog({
			title : '新增进货',
			width : 900,
			height : 440,
			url : basePath + 'tmsyjhtgl/jianceyiqiFormIndex?op=add',
			buttons : [{
				text : '保存',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mygrid, parent.$);
				}
			},{
				text : '关闭',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	} 
	
	// 编辑
	function editJianceyiqi() {
		var row = $('#mygrid').datagrid('getSelected');
		if(row){
			var v_hjcjgjcyqbid=row.hjcjgjcyqbid;
			var dialog = parent.sy.modalDialog({
				title : '编辑',
				width : 900,
				height : 440,
				url : basePath + 'tmsyjhtgl/jianceyiqiFormIndex?op=edit&hjcjgjcyqbid='+v_hjcjgjcyqbid,
				buttons : [{
					text : '保存',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mygrid, parent.$);
					}
				},{
					text : '关闭',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
			
		}else{
			$.messager.alert('提示','请先选择要修改的检测仪器信息！','info');
		}
	} 
	
	// 查看
	function viewJianceyiqi() {
		var row = $('#mygrid').datagrid('getSelected');
		if(row){
			var v_hjcjgjcyqbid=row.hjcjgjcyqbid;
			var dialog = parent.sy.modalDialog({
				title : '查看',
				width : 900,
				height : 440,
				url : basePath + 'tmsyjhtgl/jianceyiqiFormIndex?op=view&hjcjgjcyqbid='+v_hjcjgjcyqbid,
				buttons : [{
					text : '关闭',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
			
		}else{
			$.messager.alert('提示','请先选择要查看的检测仪器信息！','info');
		}
	} 	
	
	// 删除
	function delJianceyiqi() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var v_hjcjgjcyqbid=row.hjcjgjcyqbid;
			$.messager.confirm('警告', '您确定要删除该条记录吗?',function(r) {
				if (r) {
					$.post(basePath + 'tmsyjhtgl/delJianceyiqi', 
					{hjcjgjcyqbid: v_hjcjgjcyqbid},
					function(result){
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#mygrid').datagrid('reload'); 
			        		});    	
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	} 	
	
	// 查询企业信息
	function myquery() {
		mygrid.datagrid('reload');
	}	
	
	</script>
</head>

<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td colspan="2" style="text-align: right">						  
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myquery()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>						   	
						</td>						
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="检测仪器列表">
	        <div id="toolbar">
	        		<table>
						<tr>
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" 
							    data=""
								iconCls="icon-add" plain="true" onclick="addJianceyiqi()">新增</a> 
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-edit" plain="true" onclick="editJianceyiqi()">编辑</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="ext-icon-report_magnify" plain="true" onclick="viewJianceyiqi()">查看</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td>			
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-remove" plain="true" onclick="delJianceyiqi()">删除</a>
							</td>
					    </tr>
					</table>
				</div>
				        	
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>
        </form>         
    </div>  
</body>
</html>