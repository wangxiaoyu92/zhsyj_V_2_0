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
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
       var grid;
	 $(function  (){  	
  		grid=$("#grid").datagrid({
	   // title:'采集信息查询',
	    url: basePath +"/tmcy/cdgl/QueryCd", 
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
    	idField: 'hcycdid', //该列是一个唯一列
    	loadMsg:'数据加载中,请稍后...',
        columns:[[
        {
          title:'菜品id',
          field:'hcycdid',
          align:'left',
          width:100,
          hidden : true
          },{
         /*  title:'企业名称',
          field:'commc',
          align:'left',
          width:100 
          },{ */
          title:'菜名',
          field:'cpmc',
          align:'left',
          width:100 
          },{
          title:'简称',
          field:'cpjc',
          align:'left',
          width:100 
         
          },{ title:'上市时间',
          field:'cpsssj',
          align:'left',
          width:100 
          },{
          title:'上架标识',
          field:'sjbz',
          align:'left',
          width:100 ,
          formatter :function (value, rec){
          		if(value==1){
          		   return rec.sjbz="已上架";
          		}else if(value==2){
          		   return rec.sjbz="未上架";
          		}else if(value==0){
          		   return rec.sjbz="已下架";
          		} 	
          }
          },{
          title:'菜系',
          field:'caixiinfo',
          align:'left',
          width:100 
          },{
          title:'归类',
          field:'caipinglinfo',
          align:'left',
          width:100 
          },{
          title:'价格',
          field:'cpjg',
          align:'left',
          width:100
          },{
          title:'操作员',
          field:'aae011',
          align:'left',
          width:100 
          },{
          title:'操作时间',
          field:'aae036',
          align:'left',
          width:130
          },{
          title:'简介',
          field:'cpjj',
          align:'left',
          width:100  
          }  
        ]]
     }); 
   })
   //新增菜品
    var addcd=function(){
	     var dialog =  parent.sy.modalDialog({
			title : '添加菜品',
			width : 640,
			height : 360,
			url : basePath + '/tmcy/cdgl/CdFrom',
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
   //编辑菜品
    var edit=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '编辑菜品',
			width : 640,
			height : 360,
			url : basePath + '/tmcy/cdgl/CdFrom?hcycdid='+row.hcycdid,
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
    var delcp=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	   // var id = row.hcycdid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'tmcy/cdgl/DelCd', {
						hcycdid: row.hcycdid
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
	//查看菜品
    var showcp=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '查看菜品',
			width : 640,
			height : 360,
			url : basePath + '/tmcy/cdgl/CdFrom?op=show&hcycdid='+row.hcycdid,
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
			var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=company&fjwid="+row.hcycdid; 

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
	}	
	
	// 删除图片附件
	function delFjView(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + "/pub/pub/delFjViewIndex?fjwid="+row.hcycdid;
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
		<sicp3:groupbox title="菜品列表">
			<div id="toolbar">
			<table> 
				<tr>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_CdMainIndex" iconCls="icon-add" plain="true"
						onclick="addcd()">增加</a></td>
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
			<div id="grid" style="height:350px;overflow:auto;"></div>
		</sicp3:groupbox>
		</div>
    </div>            
</body>
</html>
