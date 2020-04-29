<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
			+ request.getServerPort() + request.getContextPath() + "/";
	} 
	Sysuser Vsuer= (Sysuser) SysmanageUtil.getSysuser();
	String userid=Vsuer.getUserid();
	String v_aaz001=Vsuer.getAaz001();
%>
<!DOCTYPE html>
<html>
<head>
<title>企业产品和材料管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include> 
<script type="text/javascript">
var mytab;
var v_cphycl = [{id:'',text:'==请选择=='},{id:'1',text:'产品'},{id:'2',text:'材料'}];
	$(function() {  	
		// 产品或原材料
	    $('#cphyclbz').combobox({
	    	data : v_cphycl,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
		mytab = $('#mytab').datagrid({  
			toolbar: '#toolbar',
			url:'<%=basePath%>spsy/productin/queryProductin?procomid=<%=v_aaz001%>',
			striped:true, // 奇偶行使用不同背景色
		    singleSelect:true, // True 就会只允许选中一行
		    pagination:true, // 底部显示分页栏
		    pageSize:10,
		    pageList:[10,15,20],
		    rownumbers:true, // 是否显示行号
		    fitColumns : false, // 列自适应宽度
		    sortOrder:'desc',
		    columns:[[
				{title:'产品id',field:'proid',align:'center',width:100,hidden:'true'},	
				{title:'类型',field:'cphyclbz',align:'center',width:60, 
					 formatter: function(value,row,index){
			  				if (value=="1"){
			  					return "产品"; 
			  				} else if(value=="2"){
			  					return "材料";
			  				}
			  			}
				},	
				{title:'产品名称',field:'proname',align:'left',width:130},
				{title:'商品条码',field:'prosptm',align:'left',width:110},
				{title:'品名',field:'propm',align:'left',width:100},
				{title:'规格型号',field:'progg',align:'left',width:80},
				{title:'价格',field:'proprice',align:'left',width:80},
				{title:'保质期单位代码',field:'probzqdwCode',align:'left',hidden:'true'},
				{title:'保质期单位名称',field:'probzqdwMc',align:'left',hidden:'true'},
				{title:'保质期',field:'probzq',align:'left',width:60,
						formatter:function(value,rec){
					       if(rec.probzqdwmc=='月'){
						  		return value+'个'+rec.probzqdwmc;
					       }else{
					       		return value+rec.probzqdwmc;
						   }
					}
				},
				{title:'产地/基地名称',field:'procdjd',align:'left',width:150},
				{title:'配料信息',field:'proplxx',align:'left',width:100},
				{title:'产品标准号',field:'procpbzh',align:'left',width:80},
				{title:'产品种类',field:'prozlstr',align:'left',width:130},
				{title:'产品溯源码',field:'progtin14',align:'left',width:80},
				{title:'包装溯源码',field:'bzgtin14',align:'left',width:80},
				{title:'包装规格',field:'probzgg',align:'left',width:80,hidden:'true'}
			]] 
		});  
	}); 
 
	//添加产品
	function addProductin(){
		var dialog =  parent.sy.modalDialog({
			title : '添加产品',
			width : 950,
			height : 600,
			url : basePath + "spsy/productin/productinaddIndex",
			buttons : [{
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mytab, parent.$);
				} 
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				} 
			}]
		});   
	} 
	//添加材料
	function addcl(){
		$.messager.prompt('添加材料', '请输入材料名称', function(r){
			if (r) { 
				if('' != r.trim()){
					$.ajax({
						url : basePath + 'spsy/productin/addProductin',
						data : {"proname":r, "cphyclbz":"2"},
						dataType : "json",
						success : function (result) {
							if (result.code=='0') {
							 $.messager.alert('提示','保存成功！','info',function(){
								 $('#mytab').datagrid('reload'); 
				        		}); 
							} else {
								$.messager.alert('提示', "删除失败：" + result.msg, 'error');
							}
						}
					}); 
				}else{
					alert("请输入材料名称");
				}
			} 
		});  
	} 
	//更新
	function edit() {
		var row = $('#mytab').datagrid('getSelected');
		if (row) {
			if(row.cphyclbz=='2'){//判断是材料
				$.messager.prompt('更新材料', '请输入材料名称', function(r){
						if (r){ 
							if(''!=r.trim()){//添加材料
								$.ajax({
									url : basePath + 'spsy/productin/addProductin',
									data : {"proname":r,"cphyclbz":"2","proid":row.proid},
									dataType : "json",
									success : function (result) {
										if (result.code=='0') {
										 $.messager.alert('提示','保存成功！','info',function(){
											 $('#mytab').datagrid('reload'); 
							        		}); 
										} else {
											$.messager.alert('提示', "保存失败：" + result.msg, 'error');
										}
									}
								}); 
							}else{
								alert("请输入材料名称");
							}
						} 
					}); 
				} else {
					var dialog = parent.sy.modalDialog({
						title : '编辑信息',
						param : {
							proid : row.proid
						},
						width : 870,
						height : 500,
						url : basePath + '/spsy/productin/productinaddIndex',
						buttons : [ {
							text : '确定',
							handler : function() {
								dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mytab, parent.$);
							}
						},{
							text : '取消',
							handler : function() {
								dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
							}
						} ]
					});
			}
		 }else{
				$.messager.alert('提示', '请先选择要修改的消息！', 'info');
		 }
	}
	//查看
	var queryProductinDTO = function () {
		var row = $('#mytab').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看信息',
				param : {
					op : "view",
					proid : row.proid
				},
				width : 870,
				height : 500,
				url : basePath + '/spsy/productin/productinaddIndex',
				buttons : [{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		} else {
			$.messager.alert('提示', '请先选择要修改的消息！', 'info');
		}
	};
	// 删除
	 var delProductin = function () {
		var row = $('#mytab').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗，这将删除对应的企业的相关信息，且不可恢复！', function(r) {
				if (r) {
				 $.post(basePath + 'spsy/productin/delProductin', {
						proid: row.proid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','删除成功！','info', function(){
								$('#mytab').datagrid('reload'); 
			        		}); 
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					}, 'json');
				}
			});
		} else {
			$.messager.alert('提示', '请先选择要删除的企业！', 'info');
		}
	};
	// 查询台账信息
	function query() {
		var param = {
			'proname': $('#proname').val(),
			'cphyclbz':$('#cphyclbz').combobox('getValue'),
			'procomid':'<%=v_aaz001%>'
		};
		mytab.datagrid({
			url:'<%=basePath%>spsy/productin/queryProductin',			
			queryParams : param
		});
		mytab.datagrid('clearSelections');  
	}
	
	function refresh(){
		parent.window.refresh();	
	} 

	// 上传图片附件
	function uploadFjView(){
		var row = $('#mytab').datagrid('getSelected');
		if (row) {
			var url = basePath + "pub/pub/uploadFjViewIndex";
			var dialog = parent.sy.modalDialog({
					title : '上传附件',
					param : {
						folderName : "sycp",
						fjwid : row.proid
					},
					width : 900,
					height : 700,
					url : url
			},closeModalDialogCallback);
		} else {
			$.messager.alert('提示', '请先选择要上传附件的记录！', 'info');
		}
	}
	
	// 上传产品视频
	function uploadFjVideo(){
		var row = $('#mytab').datagrid('getSelected');
		if (row) {
			var url = basePath + "pub/pub/uploadFjViewIndex";
			var dialog = parent.sy.modalDialog({
					title : '上传产品视频',
					param : {
						folderName : "sycpvideo",
						fjtype : "14",
						fjext : "video",
						fjwid : row.proid,
						uploadOne : "yes"
					},
					width : 900,
					height : 700,
					url : url
			}, closeModalDialogCallback);
		} else{
			$.messager.alert('提示', '请先选择要上传附件的记录！', 'info');
		}
	}	
	
	// 删除图片附件
	function delFjView(){
		var row = $('#mytab').datagrid('getSelected');
		if (row) {
			var url = basePath + "pub/pub/delFjViewIndex";
			var dialog = parent.sy.modalDialog({
					title : '管理产品图片',
					param : {
						fjwid : row.proid
					},
					width : 900,
					height : 700,
					url : url
			}, closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择要删除附件的记录！', 'info');
		}
	}
	
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		sy.removeWinRet(dialogID);//不可缺少		
	}
</script>
</head>
<body> 
<div class="easyui-layout" fit="true"> 
	<div region="center" style="overflow: true;" border="false">
		<input type="hidden"  name="comoutid" id="comoutid"/> 
		<sicp3:groupbox title="查询条件">
       		<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:right;"><nobr>产品或材料名称</nobr></td>
					<td><input id="proname" name="proname" style="width: 200px"/></td>						
					<td style="text-align:right;"><nobr>类型</nobr></td>
					<td><input id="cphyclbz" name="cphyclbz" style="width:200px" /></td>	
				</tr>
				<tr>
					<td style="text-align:center;" colspan="4">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="query()"> 查 询 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
					</td>
				</tr>
			</table>
        </sicp3:groupbox>
		<sicp3:groupbox title="企业产品和材料列表">
			<div id="toolbar">
				<table>
					<tr>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							data="btn_addProductin" iconCls="icon-add" plain="true"
							onclick="addProductin()">增加产品</a>
						</td>
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							data="btn_addcl" iconCls="icon-add" plain="true"
							onclick="addcl()">增加材料</a>
						</td>
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							data="btn_edit" iconCls="icon-edit" plain="true"
							onclick="edit()">编辑</a>
						</td>
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							data="btn_queryProductinDTO" iconCls="ext-icon-report_magnify" plain="true"
							onclick="queryProductinDTO()">查看</a>
						</td>
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							data="btn_delProductin" iconCls="icon-remove" plain="true"
							onclick="delProductin()">删除</a>
						</td>
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_uploadFjView"
							iconCls="icon-upload" plain="true" onclick="uploadFjView()">上传产品图片</a>
						</td>
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delFjView"
							iconCls="icon-no" plain="true" onclick="delFjView()">管理产品图片</a>
						</td>   
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>  
						<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_uploadFjVideo"
							iconCls="ext-icon-television" plain="true" onclick="uploadFjVideo()">上传产品视频</a>
						</td>						 
					</tr>
				</table>
			</div>
			<div id="mytab" style="height:350px;overflow:auto;"></div>
		</sicp3:groupbox>
	</div> 
</div>         
</body>
</html>