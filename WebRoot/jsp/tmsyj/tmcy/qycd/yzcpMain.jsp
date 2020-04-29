<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>透明餐饮</title>
    <jsp:include page="${contextPath}/inc_easyui.jsp"></jsp:include>
    <script type="text/javascript">
       var grid;
	 $(function  (){  	
  grid=$("#grid").datagrid({
	   // title:'采集信息查询',
    	toolbar : '#toolbar',
	    url: basePath +"/tmcy/cdgl/QueryYzcp", 
		striped : true,// 奇偶行使用不同背景色
		singleSelect : true,// True只允许选中一行
		checkOnSelect : false,
		selectOnCheck : false,			
		pagination : true,// 底部显示分页栏
		pageSize : 20,
		pageList : [ 10, 20, 30 ],
		rownumbers : true,// 是否显示行号
		fitColumns : false,// 列自适应宽度	
    	idField: 'hyzcpid', //该列是一个唯一列
    	sortOrder: 'desc',
        columns:[[
        {
          title:'菜谱id',
          field:'hyzcpid',
          align:'left',
          width:150,
          hidden : true
          },{
          title:'菜谱名称',
          field:'cpmc',
          align:'left',
          width:400 
          },{
          title:'就餐餐次',
          field:'jcccinfo',
          align:'left',
          width:100 
          },{
          title:'菜谱日期',
          field:'cprq',
          align:'left',
          width:150,
          sortable:true 
          },{
          title:'菜谱星期',
          field:'cpxq',
          align:'left',
          width:150 ,
          formatter :function (value, rec){
          		if(value==0){
          		   return rec.cpxq="星期日";
          		}else if(value==1){
          		   return rec.cpxq="星期一";
          		}else if(value==2){
          		   return rec.cpxq="星期二";
          		}else if(value==3){
          		   return rec.cpxq="星期三";
          		}else if(value==4){
          		   return rec.cpxq="星期四";
          		}else if(value==5){
          		   return rec.cpxq="星期五";
          		}else if(value==6){
          		   return rec.cpxq="星期六";
          		}
          }
          },{
          title:'操作员',
          field:'aae011',
          align:'left',
          width:150
          },{ 
          title:'操作时间',
          field:'aae036',
          align:'left',
          width:150  
          }  
        ]]
     }); 
   })
   //新增菜谱
    var addcp=function(){
	     var dialog =  parent.sy.modalDialog({
			title : '添加菜谱',
			width : 640,
			height : 360,
			url : basePath + '/tmcy/cdgl/YzcpFrom',
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
   //编辑菜谱
    var edit=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '编辑菜谱',
			width : 640,
			height : 360,
			url : basePath + '/tmcy/cdgl/YzcpFrom?hyzcpid='+row.hyzcpid,
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
			$.messager.alert('提示', '请先选择要查看的信息！', 'info');
		}
	};
	//删除菜谱 
    var delcp=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	   // var id = row.hyzcpid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'tmcy/cdgl/DelYzcp', {
						hyzcpid: row.hyzcpid
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
			$.messager.alert('提示', '请先选择要检查的企业！', 'info');
		}
	};
	//查看菜谱
    var showcp=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '查看菜谱',
			width : 640,
			height : 360,
			url : basePath + '/tmcy/cdgl/YzcpFrom?op=show&hyzcpid='+row.hyzcpid,
			buttons : [ {
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
		}else{
			$.messager.alert('提示', '请先选择要检查的企业！', 'info');
		}
	};
	
	// 上传图片附件
	function uploadFjView(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + "/pub/pub/uploadFjViewIndexEasyui?folderName=company&fjwid="+row.hyzcpid;

			//创建模态窗口
			var dialog = parent.sy.modalDialog({
				title : '上传附件',
				width : 900,
				height : 700,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少

				if(obj != null){
					if(obj.type == 'ok'){
						//
					}
				}
			});

		}else{
			$.messager.alert('提示', '请先选择要上传附件的记录！', 'info');
		}
	};	
	
	// 删除图片附件
	function delFjView(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + "/pub/pub/delFjViewIndexEasyui?fjwid="+row.hyzcpid;
			//创建模态窗口
			var dialog = parent.sy.modalDialog({
				title : '附件信息',
				width : 900,
				height : 700,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少

				if(obj != null){
					if(obj.type == 'ok'){
						//
					}
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除附件的记录！', 'info');
		}
	};	
	
    </script>
  </head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">		 
		<sicp3:groupbox title="菜谱列表">
			<div id="toolbar">
				<table> 
					<tr>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							data="btn_CdMainIndex" iconCls="icon-add" plain="true"
							onclick="addcp()">增加</a></td>
						<td>
						<div class="datagrid-btn-separator"></div></td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							data="btn_archiveFormIndex" iconCls="icon-edit" plain="true"
							onclick="edit()" id="btn_CdMainIndex">编辑</a></td>
						<td>
						<div class="datagrid-btn-separator"></div></td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							id="btn_archiveFormIndex" name="btn_archiveFormIndex" data="btn_archiveFormIndex"
							iconCls="ext-icon-application_form_magnify" plain="true" onclick="showcp()">查看</a>
						</td>
						<td>
						<div class="datagrid-btn-separator"></div></td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							id="btn_delArchive" name="btn_delArchive" data="btn_delArchive"
							iconCls="icon-remove" plain="true" onclick="delcp()">删除</a></td>
						<td>
						<div class="datagrid-btn-separator"></div>
						</td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-upload" plain="true" onclick="uploadFjView()">上传图片</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-no" plain="true" onclick="delFjView()">管理图片</a>
							</td>   
							<td>
								<div class="datagrid-btn-separator"></div>
							</td> 
					</tr>
				</table>
			</div> 
			<div id="grid" style="height:500px;overflow:auto;"></div>
		</sicp3:groupbox>
		</div>
    </div>            
</body>
</html>
