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
	    url: basePath +"/tmcy/cdgl/QueryXxjl", 
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
    	idField: 'hcyjxxjlid', //该列是一个唯一列
    	loadMsg:'数据加载中,请稍后...',
        columns:[[
        {
          title:'洗消记录id',
          field:'hcyjxxjlid',
          align:'left',
          width:150,
          hidden : true
         /*  },{
          title:'企业名称',
          field:'commc',
          align:'left',
          width:100  */
          },{
          title:'餐具名称',
          field:'cjmc',
          align:'left',
          width:150 
          },{
          title:'消毒方式',
          field:'xdfsinfo',
          align:'left',
          width:150 
         
          },{ title:'温/浓度',
          field:'wnd',
          align:'left',
          width:100 
          },{
          title:'消毒开始时间',
          field:'xdkssj',
          align:'left',
          width:150 
          },{
          title:'消毒结束时间',
          field:'xdjssj',
          align:'left',
          width:150 
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
   //新增洗消记录
    var addxxjl=function(){
	     var dialog =  parent.sy.modalDialog({
			title : '新增洗消记录',
			width : 640,
			height : 360,
			url : basePath + '/tmcy/cdgl/XxjlFrom',
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
   //编辑洗消记录
    var edit=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '编辑洗消记录',
			width : 640,
			height : 360,
			url : basePath + '/tmcy/cdgl/XxjlFrom?hcyjxxjlid='+row.hcyjxxjlid,
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
	//删除菜品 
    var delxxjl=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	   // var id = row.hcyjxxjlid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'tmcy/cdgl/DelXxjl', {
						 hcyjxxjlid: row.hcyjxxjlid
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
	//查看洗消记录
    var showxxjl=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '查看洗消记录',
			width : 640,
			height : 360,
			url : basePath + '/tmcy/cdgl/XxjlFrom?op=show&hcyjxxjlid='+row.hcyjxxjlid,
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
			var url = basePath + "/pub/pub/uploadFjViewIndexEasyui?folderName=company&fjwid="+row.hcyjxxjlid;

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
			var url = basePath + "/pub/pub/delFjViewIndexEasyui?fjwid="+row.hcyjxxjlid;
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
	}	
	
    </script>
  </head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">		 
		<sicp3:groupbox title="洗消记录列表">
			<div id="toolbar">
				<table> 
					<tr>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							data="btn_XxjlMainIndex" iconCls="icon-add" plain="true"
							onclick="addxxjl()">增加</a></td>
						<td>
						<div class="datagrid-btn-separator"></div></td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							data="btn_archiveFormIndex" iconCls="icon-edit" plain="true"
							onclick="edit()" id="btn_XxjlMainIndex">编辑</a></td>
						<td>
						<div class="datagrid-btn-separator"></div></td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							id="btn_archiveFormIndex" name="btn_archiveFormIndex" data="btn_archiveFormIndex"
							iconCls="ext-icon-application_form_magnify" plain="true" onclick="showxxjl()">查看</a>
						</td>
						<td>
						<div class="datagrid-btn-separator"></div></td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							id="btn_delArchive" name="btn_delArchive" data="btn_delArchive"
							iconCls="icon-remove" plain="true" onclick="delxxjl()">删除</a></td>
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