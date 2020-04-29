<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
<title>企业导入</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var grid;
	var grid2;
		
	$(function() {
		grid = $('#grid').datagrid({
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
			idField: 'impbh', //该列是一个唯一列
			sortOrder: 'asc',
			columns : [ [{
				width : '100',
				title : '仪器类别',
				field : 'impyqlb',
				hidden : false
			},{
				width : '60',
				title : '编号',
				field : 'impbh',
				hidden : false
			},{
				width : '100',
				title : '样品种类',
				field : 'impypzl',
				hidden : false
			},{
				width : '100',
				title : '样品名称',
				field : 'impypmc',
				hidden : false
			},{
				width : '100',
				title : '检测项目',
				field : 'impjcxm',
				hidden : false
			},{
				width : '80',
				title : '含量',
				field : 'imphl',
				hidden : false
			},{
				width : '70',
				title : '检测结果',
				field : 'impjcjg',
				hidden : false
			},{
				width : '70',
				title : '所属区域',
				field : 'impssqy',
				hidden : false
			},{
				width : '100',
				title : '用户名称',
				field : 'impyhmc',
				hidden : false
			},{
				width : '120',
				title : '被检企业',
				field : 'impbjqy',
				hidden : false
			},{
				width : '80',
				title : '产品商标',
				field : 'impcpsb',
				hidden : false
			},{
				width : '100',
				title : '产品批次',
				field : 'impcppc',
				hidden : false
			},{
				width : '80',
				title : '产品规格',
				field : 'impcpgg',
				hidden : false
			},{
				width : '100',
				title : '生产厂家',
				field : 'impsccj',
				hidden : false
			},{
				width : '100',
				title : '抽样时间',
				field : 'impcysj',
				hidden : false
			},{
				width : '100',
				title : '检测时间',
				field : 'impjcsj',
				hidden : false
			},{
				width : '100',
				title : '检测人员',
				field : 'impjcry',
				hidden : false
			},{
				width : '100',
				title : '备注',
				field : 'impbz',
				hidden : false
			},{
				width : '70',
				title : '补充1',
				field : 'impbc1',
				hidden : false
			},{
				width : '70',
				title : '补充2',
				field : 'impbc2',
				hidden : false
			},{
				width : '130',
				title : '入库日期',
				field : 'imprkrq',
				hidden : false
			}] ]
		});

		grid2 = $('#grid2').datagrid({
			//title : '厨师列表',
			//iconCcs : 'icon-tip',
			//collapsible : true,
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
			idField: 'impbh', //该列是一个唯一列
			sortOrder: 'asc',
			columns : [ [{
				width : '100',
				title : '仪器类别',
				field : 'impyqlb',
				hidden : false
			},{
				width : '60',
				title : '编号',
				field : 'impbh',
				hidden : false
			},{
				width : '100',
				title : '样品种类',
				field : 'impypzl',
				hidden : false
			},{
				width : '100',
				title : '样品名称',
				field : 'impypmc',
				hidden : false
			},{
				width : '100',
				title : '检测项目',
				field : 'impjcxm',
				hidden : false
			},{
				width : '80',
				title : '含量',
				field : 'imphl',
				hidden : false
			},{
				width : '70',
				title : '检测结果',
				field : 'impjcjg',
				hidden : false
			},{
				width : '70',
				title : '所属区域',
				field : 'impssqy',
				hidden : false
			},{
				width : '100',
				title : '用户名称',
				field : 'impyhmc',
				hidden : false
			},{
				width : '120',
				title : '被检企业',
				field : 'impbjqy',
				hidden : false
			},{
				width : '80',
				title : '产品商标',
				field : 'impcpsb',
				hidden : false
			},{
				width : '100',
				title : '产品批次',
				field : 'impcppc',
				hidden : false
			},{
				width : '80',
				title : '产品规格',
				field : 'impcpgg',
				hidden : false
			},{
				width : '100',
				title : '生产厂家',
				field : 'impsccj',
				hidden : false
			},{
				width : '100',
				title : '抽样时间',
				field : 'impcysj',
				hidden : false
			},{
				width : '100',
				title : '检测时间',
				field : 'impjcsj',
				hidden : false
			},{
				width : '100',
				title : '检测人员',
				field : 'impjcry',
				hidden : false
			},{
				width : '100',
				title : '备注',
				field : 'impbz',
				hidden : false
			},{
				width : '70',
				title : '补充1',
				field : 'impbc1',
				hidden : false
			},{
				width : '70',
				title : '补充2',
				field : 'impbc2',
				hidden : false
			},{
				width : '130',
				title : '入库日期',
				field : 'imprkrq',
				hidden : false
			}] ]
		});

		var pager = grid2.datagrid('getPager');// 得到datagrid的pager对象
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
	
	//导出excel
	var exportToExcel = function(filename){	
		var rows = grid2.datagrid("getRows");		
		if(rows.length>0){
			var errorJsonStr = $.toJSON(rows);
			$('#fm').form('submit',{  
		    	url : basePath + '/pcompany/exportToExcel?filename=' + filename + '&errorJsonStr=' + errorJsonStr,
		        onSubmit: function(){ 
			    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
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
	}; 

	//下载模版
	var downLoadExcel = function(){
		$('#fm').form('submit',{  
	    	url : basePath + '/jyjc/jyjcDownLoadExcel',
	        onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				return isValid;	
	        },  
	        success: function(result){ 
	        	//	
	        }  
	    });
	}; 

	//导入上传
	var upLoadExcel2 = function(){
		if(!checkFile()){
			return;
		}
		$.post(basePath + '/jyjc/jyjcUpLoadExcel',{
					'filepath': $("#filepath").val()
				},
			function(result) {
				if (result.code == '0') {
					$.messager.alert('提示', '操作成功', 'info');
					var succList = $.parseJSON(result.succList);
					var errorList = $.parseJSON(result.errorList);
					grid.datagrid('loadData',succList);		        
					grid2.datagrid('loadData',errorList);								
				} else {
					$.messager.alert('提示', '操作失败:' + result.msg, 'error');		
				}
			},
		'json');
	};
	
	var upLoadExcel = function(){
		if(!checkFile()){
			return;
		}
		//提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: basePath + '/jyjc/jyjcUpLoadExcel',
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
					grid.datagrid('loadData',succList);		        
					grid2.datagrid('loadData',errorList);								
				} else {
					$.messager.alert('提示', '操作失败:' + result.msg, 'error');		
				}
	        }    
		});		
	};

	//校验文件
	var checkFile = function(){
		var str = $('#filepath').val();
		if(str=="" || str==null){
			$.messager.alert('提示', '请选择需要导入的文件!', 'info');
			return false;
		}
		if(str.substr(str.length-4,4)!=".xls"){
			$.messager.alert('提示', '上传文件格式必须为.xls!', 'error');
			$('#filepath').focus();
       		$('#filepath').select();
			return false;
		}
		return true;
	}


	// 导入保存
	var saveCsdr = function() {
		var rows = grid.datagrid("getRows");		
		if(rows.length>0){
			$.messager.progress();	// 显示进度条
			var succJsonStr = $.toJSON(rows);
			$("#succJyjcUploadExcelJsonStr").val(succJsonStr);
			$("#myform").form('submit',{
				url:basePath + '/jyjc/saveJyjcUploadExcel',		
				onSubmit: function(){ 
					var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
					if(!isValid){
						$pjq.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
					}					
					return isValid;
		        },
		        success: function(result){
		        	$.messager.progress('close');// 隐藏进度条
		        	result = $.parseJSON(result);  
				 	if (result.code=='0'){
						$.messager.alert('提示', '操作成功', 'info',function(){
							refresh();
		        		}); 	                        	                     
	              	} else {
	              		$.messager.alert('提示', '操作失败:' + result.msg, 'error');
	                }
		        }    
			});
		}else{
			$.messager.alert('提示', '不存在需要保存的记录！', 'warning');
			return;
		}		
	};


	function refresh(){
		$('#fm').form('clear');
		grid.datagrid('loadData',{"total":0,"rows":[]});
		grid2.datagrid('loadData',{"total":0,"rows":[]});		
	}

	// 关闭窗口
	var closeWindow = function($dialog, $grid, $pjq) {
		$grid.datagrid('load');
		$dialog.dialog('destroy');
	};  
</script>
</head>
<body>
	<form id="fm" method="post" target="hideWin" enctype='multipart/form-data'  >
		<sicp3:groupbox title="操作区">
			<table class="table" style="width: 99%;">
				<th><a href="javascript:void(0);" onclick="downLoadExcel();">
					    <font color="red">下载模版文件1</font>
					    <img src="<%=contextPath%>/images/frame/download.gif"/>
				    </a>
				</th>
	    		<tr>    
					<td style="text-align:right;"><nobr>选择上传文件</nobr></td>
					<td><input id="filepath" name="filepath" type="file"  onchange ="checkFile();" style="width:300px"/></td>
					<td style="text-align:right;">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-upload" onclick="upLoadExcel();"> 导入上传 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-reload" onclick="refresh();"> 重 置 </a>
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
    <form id="myform" method="post">
       <input type="hidden" id="succJyjcUploadExcelJsonStr" name="succJyjcUploadExcelJsonStr">
    </form>
	<sicp3:groupbox title="上传的正确数据">
		<div id="grid" style="width: 2000px;"></div>
		<div id="toolbar">
			<table>
				<tr>
					<td>
						<a href="javascript:void(0);" class="easyui-linkbutton"  data="btn_saveCsdr"
							iconCls="icon-save" plain="true" onclick="saveCsdr();">上传保存</a>
					</td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
				</tr>
			</table>
		</div>
	</sicp3:groupbox>
	
	<br/>
	<sicp3:groupbox title="上传的错误数据">
		<div id="grid2" style="width: 2000px;"></div>	
		<div id="toolbar2">
			<table>
				<tr>
					<td>
						<a href="javascript:void(0);" class="easyui-linkbutton"
							iconCls="icon-excel" plain="true"
							onclick="exportToExcel('上传的错误数据');">导出</a>
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
