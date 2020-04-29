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
<title>两员导入</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var lysfzjlx = <%=SysmanageUtil.getAa10toJsonArray("AAC058")%>;
	var lyxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
	var lywhcd = <%=SysmanageUtil.getAa10toJsonArray("AAC011")%>;
	var lycynx = <%=SysmanageUtil.getAa10toJsonArray("CYNX")%>;
	var lyjkzm = <%=SysmanageUtil.getAa10toJsonArray("JKZM")%>;
	var lypxqk = <%=SysmanageUtil.getAa10toJsonArray("PXQK")%>;
	var cb_lysfzjlx;
	var cb_lyxb;
	var cb_lywhcd;
	var cb_lycynx;
	var cb_lyjkzm;
	var cb_lypxqk;  
	var grid;
	var grid2;
		
	$(function() {
		grid = $('#grid').datagrid({
			//title : '两员列表',
			//iconCly : 'icon-tip',
			//collapsible : true,
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
			idField: 'lysfzjhm', //该列是一个唯一列
		    sortOrder: 'desc',			
		    frozenColumns : [[ {
				width : '100',
				title : '姓名',
				field : 'lyxm',
				hidden : false
			}]],				
			columns : [ [ {
				width : '100',
				title : '姓名拼音码',
				field : 'lypym',
				hidden : false
			},{
				width : '100',
				title : '性别',
				field : 'lyxb',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lyxb,value);
				}
			},{
				width : '100',
				title : '出生日期',
				field : 'lylyrq',
				hidden : false
			},{
				width : '200',
				title : '身份证件类型',
				field : 'lysfzjlx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lysfzjlx,value);
				}
			},{
				width : '200',
				title : '身份证号',
				field : 'lysfzjhm',
				hidden : false
			},{
				width : '100',
				title : '手机号',
				field : 'lysjh',
				hidden : false
			},{
				width : '150',
				title : '邮箱',
				field : 'lyyx',
				hidden : true
			},{
				width : '150',
				title : 'QQ号',
				field : 'lyqq',
				hidden : true
			},{
				width : '150',
				title : '微信号',
				field : 'lywx',
				hidden : true
			},{
				width : '100',
				title : '文化程度',
				field : 'lywhcd',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lywhcd,value);
				}
			},{
				width : '100',
				title : '从业年限',
				field : 'lycynx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lycynx,value);
				}
			},{
				width : '100',
				title : '健康证明',
				field : 'lyjkzm',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lyjkzm,value);
				}
			},{
				width : '100',
				title : '培训情况',
				field : 'lypxqk',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lypxqk,value);
				}
			},{
				width : '200',
				title : '家庭住址',
				field : 'lyjtzz',
				hidden : false
			},{
				width : '200',
				title : '户口所在地',
				field : 'lyhkszd',
				hidden : false
			},{
				width : '200',
				title : '备注',
				field : 'aae013',
				hidden : false
			}] ]
		});

		grid2 = $('#grid2').datagrid({
			//title : '两员列表',
			//iconCly : 'icon-tip',
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
		    idField: 'lysfzjhm', //该列是一个唯一列
		    sortOrder: 'desc',			
		    frozenColumns : [[ {
				width : '100',
				title : '姓名',
				field : 'lyxm',
				hidden : false
			}]],				
			columns : [ [ {
				width : '100',
				title : '姓名拼音码',
				field : 'lypym',
				hidden : false
			},{
				width : '100',
				title : '性别',
				field : 'lyxb',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lyxb,value);
				}
			},{
				width : '100',
				title : '出生日期',
				field : 'lylyrq',
				hidden : false
			},{
				width : '200',
				title : '身份证件类型',
				field : 'lysfzjlx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lysfzjlx,value);
				}
			},{
				width : '200',
				title : '身份证号',
				field : 'lysfzjhm',
				hidden : false
			},{
				width : '100',
				title : '手机号',
				field : 'lysjh',
				hidden : false
			},{
				width : '150',
				title : '邮箱',
				field : 'lyyx',
				hidden : true
			},{
				width : '150',
				title : 'QQ号',
				field : 'lyqq',
				hidden : true
			},{
				width : '150',
				title : '微信号',
				field : 'lywx',
				hidden : true
			},{
				width : '100',
				title : '文化程度',
				field : 'lywhcd',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lywhcd,value);
				}
			},{
				width : '100',
				title : '从业年限',
				field : 'lycynx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lycynx,value);
				}
			},{
				width : '100',
				title : '健康证明',
				field : 'lyjkzm',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lyjkzm,value);
				}
			},{
				width : '100',
				title : '培训情况',
				field : 'lypxqk',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lypxqk,value);
				}
			},{
				width : '200',
				title : '家庭住址',
				field : 'lyjtzz',
				hidden : false
			},{
				width : '200',
				title : '户口所在地',
				field : 'lyhkszd',
				hidden : false
			},{
				width : '200',
				title : '备注',
				field : 'aae013',
				hidden : false
			},{
				width : '200',
				title : '错误信息',
				field : 'message',
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
		    	url : basePath + '/ncjtjc/lygl/exportToExcel?filename=' + filename + '&errorJsonStr=' + errorJsonStr,   
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
	    	url : basePath + '/ncjtjc/lygl/downLoadExcel',  
	        onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				return isValid;	
	        },  
	        success: function(result){ 
	        	//	
	        }  
	    });
	}; 

	//上传模版
	var upLoadExcel = function(){
		if(!checkFile()){
			return;
		}
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: basePath + '/ncjtjc/lygl/upLoadExcel',
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
	var saveLydr = function() {

		var rows = grid.datagrid("getRows");
		if(rows.length>0){
			var succJsonStr = $.toJSON(rows);
			$.messager.confirm('提示', '确定保存吗?',function(r) {
				if (r) {
					//下面的例子演示了如何提交一个有效并且避免重复提交的表单
					$.messager.progress();	// 显示进度条
					var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
					if(!isValid){
						$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
						return;
					}
					$.post(basePath + '/ncjtjc/lygl/saveLydr', {
								data: succJsonStr
							},
							function(result) {
								$.messager.progress('close');// 隐藏进度条
								result = $.parseJSON(result);
								if (result.code == '0') {
									$.messager.alert('提示', '操作成功', 'info',function(){
										refresh();
									});
								} else {
									$.messager.alert('提示', '操作失败:' + result.msg, 'error');
								}
							},
							'json');

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
	<form id="fm" method="post" enctype="multipart/form-data">	    
		<sicp3:groupbox title="操作区">
			<table class="table" style="width: 99%;">
				<th><a href="javascript:void(0);" onclick="downLoadExcel();">
					    <font color="red">下载模版文件</font>
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
	<sicp3:groupbox title="上传的正确数据">
		<div id="grid" style="overflow:auto;"></div>
		<div id="toolbar">
			<table>
				<tr>
					<td>
						<a href="javascript:void(0);" class="easyui-linkbutton"  data="btn_saveLydr"
							iconCls="icon-save" plain="true" onclick="saveLydr();">保存</a>
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
		<div id="grid2" style="overflow:auto;"></div>	
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
