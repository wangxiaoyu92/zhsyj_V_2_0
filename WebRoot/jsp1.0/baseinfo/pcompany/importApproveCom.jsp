<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
<title>审批企业导入</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var importGrid; // 导入数据表格
	var errorDataGrid; // 错误数据表格
		
	$(function() {
		importGrid = $('#importGrid').datagrid({
			toolbar : '#toolbar',
			striped : true,// 奇偶行使用不同背景色
			nowrap : true,// True数据长度超出列宽时将会自动截取
			singleSelect : false,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,		
			pagination : false,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
			idField: 'orderno', //该列是一个唯一列
			sortOrder: 'asc',
			columns : [ [{
				width : '80',
				title : '序号',
				field : 'orderno',
				hidden : false
			},{
				width : '200',
				title : '经济性质',
				field : 'comqyxz',
				hidden : false
			},{
				width : '200',
				title : '经营者姓名',
				field : 'commc',
				hidden : false
			},{
				width : '100',
				title : '营业执照号',
				field : 'comyyzzh',
				hidden : false
			},{
				width : '120',
				title : '法定代表人/业主',
				field : 'comfrhyz',
				hidden : false
			},{
				width : '150',
				title : '住所',
				field : 'frhyzzs',
				hidden : false
			},{
				width : '200',
				title : '经营场所',
				field : 'comdz',
				hidden : false
			},{
				width : '90',
				title : '经营面积',
				field : 'comzmj',
				hidden : false
			},{
				width : '150',
				title : '主体业态',
				field : 'comxkzztyt',
				hidden : false
			},{
				width : '100',
				title : '经营项目',
				field : 'comxkfw',
				hidden : false
			},{
				width : '150',
				title : '经营类别',
				field : 'comdmlx',
				hidden : false
			},{
				width : '100',
				title : '许可证号',
				field : 'comxkzbh',
				hidden : false
			},{
				width : '150',
				title : '监管机构',
				field : 'orgname',
				hidden : false
			},{
				width : '150',
				title : '监管人员',
				field : 'comrcjdglry',
				hidden : false
			},{
				width : '100',
				title : '发证日期',
				field : 'comxkyxqq',
				hidden : false
			},{
				width : '100',
				title : '有效期至',
				field : 'comxkyxqz',
				hidden : false
			},{
				width : '100',
				title : '发证机关',
				field : 'xkzorg',
				hidden : false
			},{
				width : '100',
				title : '联系电话',
				field : 'comyddh',
				hidden : false
			},{
				width : '100',
				title : '受理日期',
				field : 'comslrq',
				hidden : false
			}] ]
		});

		errorDataGrid = $('#errorDataGrid').datagrid({
			toolbar : '#toolbar2',
			striped : true,// 奇偶行使用不同背景色
			nowrap : false,// True数据长度超出列宽时将会自动截取
			singleSelect : false,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : false,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
			idField: 'orderno', //该列是一个唯一列
			sortOrder: 'asc',
			columns : [[{
				width : '80',
				title : '序号',
				field : 'orderno',
				hidden : false
			},{
				width : '200',
				title : '经济性质',
				field : 'comqyxz',
				hidden : false
			},{
				width : '200',
				title : '经营者姓名',
				field : 'commc',
				hidden : false
			},{
				width : '100',
				title : '营业执照号',
				field : 'comyyzzh',
				hidden : false
			},{
				width : '120',
				title : '法定代表人/业主',
				field : 'comfrhyz',
				hidden : false
			},{
				width : '150',
				title : '住所',
				field : 'frhyzzs',
				hidden : false
			},{
				width : '200',
				title : '经营场所',
				field : 'comdz',
				hidden : false
			},{
				width : '90',
				title : '经营面积',
				field : 'comzmj',
				hidden : false
			},{
				width : '150',
				title : '主体业态',
				field : 'comxkzztyt',
				hidden : false
			},{
				width : '100',
				title : '经营项目',
				field : 'comxkfw',
				hidden : false
			},{
				width : '150',
				title : '经营类别',
				field : 'comdmlx',
				hidden : false
			},{
				width : '100',
				title : '许可证号',
				field : 'comxkzbh',
				hidden : false
			},{
				width : '150',
				title : '监管机构',
				field : 'orgname',
				hidden : false
			},{
				width : '150',
				title : '监管人员',
				field : 'comrcjdglry',
				hidden : false
			},{
				width : '100',
				title : '发证日期',
				field : 'comxkyxqq',
				hidden : false
			},{
				width : '100',
				title : '有效期至',
				field : 'comxkyxqz',
				hidden : false
			},{
				width : '100',
				title : '发证机关',
				field : 'xkzorg',
				hidden : false
			},{
				width : '100',
				title : '联系电话',
				field : 'comyddh',
				hidden : false
			},{
				width : '100',
				title : '受理日期',
				field : 'comslrq',
				hidden : false
			},{
				width : '200',
				title : '错误信息',
				field : 'message',
				hidden : false
			}] ]
		});

		var pager = errorDataGrid.datagrid('getPager');// 得到datagrid的pager对象
		pager.pagination({  
		    showPageList:false,  
		    buttons:[{  
		        iconCls:'icon-excel',  
		        handler:function(){  
		    		exportToExcel('上传的错误数据'); 
		        }  
		    }]  
		}); 
	});
	
	// 错误数据导出到excel
	function exportApproveToExcel (filename) {	
		var rows = errorDataGrid.datagrid("getRows");		
		if (rows.length > 0) {
			var errorJsonStr = $.toJSON(rows);
			$('#fm').form('submit',{  
		    	url : basePath + '/pcompany/exportApproveToExcel?filename=' + filename + '&errorJsonStr=' + errorJsonStr,
		        onSubmit: function(){ 
		        	// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
			    	var isValid = $(this).form('validate'); 
					return isValid;	
		        },  
		        success: function(result){ 
		        	//	
		        }  
		    });
		}else{
			$.messager.alert('提示', '不存在需要导出的记录!', 'warning');
			return;
		}			  
	}

	// 下载模版
	function downLoadExcel(){
		$('#fm').form('submit',{  
	    	url : basePath + '/pcompany/downLoadApproveExcel',
	        onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				return isValid;	
	        },  
	        success: function(result){ 
	        	//	
	        }  
	    });
	}
	
	// 导入上传
	function upLoadApproveComExcel(){
		if(!checkFile()){
			return;
		}
		//提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: basePath + '/pcompany/upLoadApproveComExcel',
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}	
				return isValid;
	        },
	        success: function(result){
	        	$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code == '0') {
					$.messager.alert('提示', '操作成功', 'info');
					var succList = $.parseJSON(result.succList);
					var errorList = $.parseJSON(result.errorList);
					importGrid.datagrid('loadData',succList);		        
					errorDataGrid.datagrid('loadData',errorList);								
				} else {
					$.messager.alert('提示', '操作失败:' + result.msg, 'error');		
				}
	        }    
		});		
	}

	//校验文件
	function checkFile(){
		var str = $('#filepath').val();
		if(str == "" || str == null){
			$.messager.alert('提示', '请选择需要导入的文件!', 'info');
			return false;
		}
		if(str.substr(str.length - 4, 4) != ".xls"){
			$.messager.alert('提示', '上传文件格式必须为.xls!', 'error');
			$('#filepath').focus();
       		$('#filepath').select();
			return false;
		}
		return true;
	}

	// 导入保存
	function saveApprovePcompanydr() {
		var rows = importGrid.datagrid("getRows");		
		if(rows.length > 0){
			var succJsonStr = $.toJSON(rows);
			$.messager.confirm('提示', '确定保存吗?',function(r) {
				if (r) {
					//下面的例子演示了如何提交一个有效并且避免重复提交的表单
					$.messager.progress();	// 显示进度条
					$.ajax({
						cache: true,
						type: "POST",
						url:basePath + '/pcompany/saveApprovePcompanydr',
						data:{succJsonStr:succJsonStr},
						async: false,
						error: function(request) {
							$.messager.alert('提示', '操作失败:' + request, 'error');
						},
						success: function(result) {
							$.messager.progress('close');// 隐藏进度条
							result = $.parseJSON(result);
							if (result.code == '0') {
								$.messager.alert('提示', '操作成功', 'info',function(){
									refresh();
								});
							} else {
								$.messager.alert('提示', '操作失败:' + result.msg, 'error');
							}
						}
					});

				}
			});
		}else{
			$.messager.alert('提示', '不存在需要保存的记录！', 'warning');
			return;
		}		
	}

	// 重置刷新
	function refresh(){
		$('#fm').form('clear');
		importGrid.datagrid('loadData',{"total":0,"rows":[]});
		errorDataGrid.datagrid('loadData',{"total":0,"rows":[]});		
	}

	// 关闭窗口
	function closeWindow($dialog, $grid, $pjq) {
		$grid.datagrid('load');
		$dialog.dialog('destroy');
	}
</script>
</head>
<body>
	<form id="fm" method="post" target="hideWin" enctype='multipart/form-data'>
		<sicp3:groupbox title="操作区">
			<table class="table" style="width: 99%;">
				<th><a href="javascript:void(0);" onclick="downLoadExcel()">
					    <font color="red">下载模版文件</font>
					    <img src="<%=contextPath%>/images/frame/download.gif"/>
				    </a>
				</th>
	    		<tr>    
					<td style="text-align:right;"><nobr>选择上传文件</nobr></td>
					<td><input id="filepath" name="filepath" type="file"  
						onchange ="checkFile()" style="width:300px"/></td>
					<td style="text-align:right;">
						<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_upLoadApproveComExcel"
							iconCls="icon-upload" onclick="upLoadApproveComExcel()"> 导入上传 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
					</td>
				</tr>
				<tr>
					<input id="succJsonStr" name="succJsonStr" type="hidden"/>
					<input id="errorJsonStr" name="errorJsonStr" type="hidden"/>
				</tr>
			</table>
		</sicp3:groupbox>
	</form>
    <br/>
	<sicp3:groupbox title="上传的正确数据">
		<div id="importGrid" style="width:900px;height: 300px;overflow:auto;"></div>
		<div id="toolbar">
			<table>
				<tr>
					<td>
						<a href="javascript:void(0);" class="easyui-linkbutton"  data="btn_saveApprovePcompanydr"
							iconCls="icon-save" plain="true" onclick="saveApprovePcompanydr()">保存</a>
					</td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
			</table>
		</div>
	</sicp3:groupbox>
	<br/>
	<sicp3:groupbox title="上传的错误数据">
		<div id="errorDataGrid" style="width:900px;height:200px;overflow:auto;"></div>	
		<div id="toolbar2">
			<table>
				<tr>
					<td>
						<a href="javascript:void(0);" class="easyui-linkbutton"
							iconCls="icon-excel" plain="true" data="btn_exportApproveToExcel"
							onclick="exportApproveToExcel('上传的错误数据')">导出</a>
					</td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
				</tr>
			</table>
		</div>
	</sicp3:groupbox>
</body>
</html>
