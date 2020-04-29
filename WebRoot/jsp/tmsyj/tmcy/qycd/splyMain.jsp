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
	    url: basePath +"/tmcy/cdgl/QuerySply", 
    	iconCls:'icon-ok',
    	pageSize:10,
    	pageList:[10,20,30],
    	nowrap:true,//True 就会把数据显示在一行里
    	striped:true,//奇偶行使用不同背景色
    	collapsible:true,
    	singleSelect:true,//True 就会只允许选中一行
    	fit:false,//让DATAGRID自适应其父容器
    	fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
    	pagination:true,//底部显示分页栏
    	rownumbers:true,//是否显示行号
    	idField: 'hsplyid', //该列是一个唯一列
    	loadMsg:'数据加载中,请稍后...',
        columns:[[
        {
          title:'留样id',
          field:'hsplyid',
          align:'left',
          width:150,
          hidden : true
          },{
          title:'留样品种',
          field:'splypz',
          align:'left',
          width:400 
          },{
          title:'留样餐次',
          field:'jcccinfo',
          align:'left',
          width:100 
          },{
          title:'留样人',
          field:'splyry',
          align:'left',
          width:100 
         
          },{ title:'留样时间',
          field:'splysj',
          align:'left',
          width:150  
          },{
          title:'操作时间',
          field:'aae036',
          align:'left',
          width:150 
          },{
          title:'操作员',
          field:'aae011',
          align:'left',
          width:150  
          }  
        ]]
     }); 
   })
   //新增食品留样
    var addsply=function(){
	     var dialog =  parent.sy.modalDialog({
			title : '添加食品留样',
			width : 640,
			height : 460,
			url : basePath + '/tmcy/cdgl/SplyFrom',
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
   //编辑食品留样
    var edit=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '编辑食品留样',
			width : 640,
			height : 460,
			url : basePath + '/tmcy/cdgl/SplyFrom?hsplyid='+row.hsplyid,
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
	//删除食品留样
    var delsply=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){ 
			$.messager.confirm('警告', '您确定要删除该条信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'tmcy/cdgl/DelSply', {
					 	hsplyid: row.hsplyid
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
	//查看食品留样
    var showsply=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '查看食品留样',
			width : 640,
			height : 460,
			url : basePath + '/tmcy/cdgl/SplyFrom?op=show&hsplyid='+row.hsplyid,
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
			var url = basePath + "/pub/pub/uploadFjViewIndexEasyui?folderName=company&fjwid="+row.hsplyid;

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
			var url = basePath + "/pub/pub/delFjViewIndexEasyui?fjwid="+row.hsplyid;
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
		<sicp3:groupbox title="食品留样列表">
			<div id="toolbar">
			<table> 
				<tr>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_SplyMainIndex" iconCls="icon-add" plain="true"
						onclick="addsply()">增加</a></td>
					<td>
					<div class="datagrid-btn-separator"></div></td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_archiveFormIndex" iconCls="icon-edit" plain="true"
						onclick="edit()" id="btn_SplyMainIndex">编辑</a></td>
					<td>
					<div class="datagrid-btn-separator"></div></td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						id="btn_archiveFormIndex" name="btn_archiveFormIndex" data="btn_archiveFormIndex"
						iconCls="ext-icon-application_form_magnify" plain="true" onclick="showsply()">查看</a>
					</td>
					<td>
					<div class="datagrid-btn-separator"></div></td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						id="btn_delArchive" name="btn_delArchive" data="btn_delArchive"
						iconCls="icon-remove" plain="true" onclick="delsply()">删除</a></td>
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
			<div id="grid" style="height:350px;overflow:auto;"></div>
		</sicp3:groupbox>
		</div>
    </div>            
</body>
</html>
