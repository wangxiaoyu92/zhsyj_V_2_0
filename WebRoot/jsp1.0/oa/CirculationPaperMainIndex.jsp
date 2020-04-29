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
<title>公文管理--传阅信息管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var state;
	// 状态
	var v_ckzt = <%=SysmanageUtil.getAa10toJsonArray("CYCKZT")%>;
	var grid;
	$(function() { 
		state=$('#paperstate').combobox({
		    	data : v_ckzt,      
		        valueField : 'id',   
		        textField : 'text',
		        required : false,
		        editable : false,
		        panelHeight : 'auto' 
	   		 });
		grid = $('#grid').datagrid({
			//title: '传阅信息列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + 'egovernment/circulationPaper/queryCirculationPaper',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度		
		    idField: 'paperid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ 
				{
					width : '200',
					title : '传阅id',
					field : 'paperid',
					hidden : true
				},
				{
					width : '200',
					title : '归档id',
					field : 'fileid',
					hidden : true
				},
				{
					width : '200',
					title : '传阅者id',
					field : 'paperuserid',
					hidden : true
				},
				{
					width : '200',
					title : '传阅者的名字',
					field : 'paperusername',
					hidden : false
				},
				{
					width : '200',
					title : '接受者id',
					field : 'recuserid',
					hidden : true
				},
				{
					width : '200',
					title : '接受者的名字',
					field : 'recusername',
					hidden : false
				},
				{
					width : '200',
					title : '查看状态',
					field : 'paperstate',
					hidden : false,
					formatter: function(value,row,index) { 
					if (value == "0") {
							return '<span style="color:blue">未查看</span>';
						}else if(value == "1"){
							return '<span style="color:red">已查看</span>';
						} 
					}
				},
				{
					width : '200',
					title : '公文标题',
					field : 'filetitle',
					hidden : false
				},
			] ]
		});
	}); 
</script>
<script type="text/javascript">
	function query() {
		var param = { 
			paperusername:$("#paperusername").val(),   //传阅者的名字 
			recusername:$("#recusername").val(),   //接受者的名字
			paperstate:$("#paperstate").combobox('getValue'),   //查看状态  0是未查看   1是查看
			filetitle:$("#filetitle").val()  //公文标题								
		};
		grid.datagrid({
			url : basePath + 'egovernment/circulationPaper/queryCirculationPaper',			
			queryParams : param
		}); 
		grid.datagrid('clearSelections'); 
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	function addCirculationPaper() {
		var dialog = parent.sy.modalDialog({
			title : '新增传阅信息',
			width : 800,
			height : 450,
			url : basePath + 'egovernment/circulationPaper/editCirculationPaperFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog,grid,parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	} 

	// 编辑
	function updateCirculationPaper() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var paperid=row.paperid;
			var cfmMsg= "确定要更新传阅状态为已查看吗?";
			var v_url=encodeURI(encodeURI("<%=basePath%>egovernment/circulationPaper/updateCirculationpaper?paperid="+paperid));
			$.messager.confirm('确认', cfmMsg, function (r) {
		    	if(r){
		    		$.ajax({
					url:v_url,
					type:'post',
					async:true,
					cache:false,
					timeout: 100000,
					error:function(){
						alert("服务器繁忙，请稍后再试！");
					},
			        success: function(result){
			        	result = $.parseJSON(result);  
					 	if (result.code=='0'){
					 		$("#grid").datagrid('reload');
					 		parent.$.messager.alert('提示','已查看！','info',function(){
			        		}); 	                        	                     
		              	} else {
		              		parent.$.messager.alert('提示','更新状态失败：'+result.msg,'error');
		               	 }
		               	 }
		               	 });	
			        	} 
			      
		    	}
			);    
		} 
	}
 
	
	// 删除
	function delCirculationPaper() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var id = row.id;
			$.messager.confirm('警告', '您确定要删除该传阅信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'egovernment/circulationPaper/delCirculationPaper', {
						paperid: row.paperid
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
			$.messager.alert('提示', '请先选择要删除的传阅信息！', 'info');
		}
	}  	
	// 查看
	function showArchive() {
		var row = $('#grid').datagrid('getSelected');
		var url="<%=basePath%>egovernment/archive/archiveFormIndex";
		if (row) {
			var dialog = parent.sy.modalDialog({
				title:'查看',
				param : {
				yop:"view",
				archiveid :row.fileid
				},
				width:950,
				height:580,
				url:url,
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);//不可缺少
				if (obj!=null && "ok"==obj){
				$("#grid").datagrid("reload");
			}
			})
		}else{
			$.messager.alert('提示', '请先选择要查看的文档！', 'info');
		}
	} 
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        	<table class="table" style="width: 99%;">
        		<tr>
					<td style="text-align:right;"><nobr>传阅者的名字</nobr></td>
					<td><input id="paperusername" name="paperusername" style="width: 200px"/></td>
					<td style="text-align:right;"><nobr>接受者的名字</nobr></td>
					<td><input id="recusername" name="recusername" style="width: 200px"/></td>
					
				</tr>
				<tr>			
					<td style="text-align:right;"><nobr>查看状态</nobr></td>
					<td><input id="paperstate" name="paperstate" style="width: 200px"/></td> 	
					<td colspan="2">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="query()"> 查 询 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
					</td>
				</tr>
			</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="传阅信息列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
									id="btn_archiveFormIndex" name="btn_archiveFormIndex" data="btn_archiveFormIndex"
									iconCls="ext-icon-application_form_magnify" plain="true" onclick="showArchive()">查看</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delCirculationPaper"
								iconCls="icon-remove" plain="true" onclick="delCirculationPaper()">删除</a>
							</td>  
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateCirculationPaper" 
								id="btn_updateCirculationPaper" name="btn_updateCirculationPaper"
								iconCls="icon-ok" plain="true" onclick="updateCirculationPaper()">已查看</a> 
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