<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String id = StringHelper.showNull2Empty(request.getParameter("id"));
%>
<!DOCTYPE html>
<html>
<head>
<title>采集信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript"> 
var grid ;
	$(function(){
		if($('#cydjid').val().length > 0){
			parent.$.messager.progress({
					text : '数据加载中....'
				});
				$.post(basePath + '/jyjc/queryJyjccydj', {
					cydjid : $('#cydjid').val()
				}, 
				function(result) {
					if (result.code=='0') {
						var mydata = result.data; 			
						$("#bcydw").val(mydata.bcydw); 
						$("#tel").val(mydata.tel); 
						$("#bcydwdz").val(mydata.bcydwdz); 
						$("#bcydwfl").val(mydata.bcydwfl); 
						$("#cybh").val(mydata.cybh); 
						$("#ypmc").val(mydata.ypmc); 
						$("#ypbh").val(mydata.ypbh); 
						$("#cysj").val(mydata.cysj); 
						$("#countcy").val(mydata.countcy); 
						$("#scdw").val(mydata.scdw); 
						$("#cyjsr").val(mydata.cyjsr); 
						$("#cyfl").val(mydata.cyfl); 
						$("#aae036").val(mydata.aae036); 
						$("#aae011").val(mydata.aae011); 
						loadjcxm();
		                $("#fm").hide();
					} else {
						parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	               }	
					parent.$.messager.progress('close');
				}, 'json');
		 /* loadjcxm();
		 $("#fm").hide(); */
		}   
	});
    // 加载检查项目
	function loadjcxm(){
	var _toolbar = [//工具栏
		{iconCls: 'icon-add', text: '增加', handler: function() { mydatagrid_append(grid); }},
		'-', 
		{ iconCls: 'icon-edit', text: '修改', handler: function() { mydatagrid_edit(grid);}},
		'-', 
		{ iconCls: 'icon-remove', text: '删除', handler: function() {
		     var row =  grid.datagrid('getSelected');
				 if(row.jyjcbgxmid=='' || row.jyjcbgxmid==null){
					 mydatagrid_remove(grid);
				 }else{
					 deljyjcxm();
				 }
			}
		},
		'-', 
		{ iconCls: 'icon-undo', text: '取消', handler: function() { mydatagrid_reject(grid); }},
		'-', 
		{iconCls: 'icon-save',text: '保存',
			handler: function() {
				if(mydatagrid_endEditing(grid)){
					savejyjcxm();
				}
			}
		}
	];
	grid = $('#grid').datagrid({
		   url:  basePath + '/jyjc/queryjcxm?cydjid='+"<%=id%>", 
		       toolbar: _toolbar,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,
			pagination : true,// 底部显示分页栏
			pageSize : 3,
			pageList : [3,6,9,12,15],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度 
			idField: 'jyjcbgxmid', //该列是一个唯一列
			sortOrder: 'desc', 
			onLoadSuccess: function (data) {//在数据加载成功的时候触发
	            if(data.total > 0){  //若数据加载>0才显示from  加载from数据
		            $("#fm").show();
		            loadjcbg();
	            }else{             //若加载为0 隐藏from
	                $("#fm").hide();
	            }
	     	},
			columns : [ [ 
			{ width : '100', title : 'id', field : 'jyjcbgxmid', hidden : true },
			{ width : '100', title : '检查项目名称', field : 'jxjcxmmc', hidden : false,
				editor : {
				type : 'validatebox',
					options : {
						required : true
					}
				}
			},
			{ width : '100', title : '标准值', field : 'bzz', hidden : false,
				editor : {
				type : 'validatebox',
					options : {
						required : true
					}
				}
			},
			{ width : '100', title : '单位', field : 'dw', hidden : false,
				editor : {
				type : 'validatebox',
					options : {
						required : true
					}
				}
			}, 
			{ width : '100', title : '检验检测结果', field : 'jyjcjg', hidden : false,
				editor :'text'
			}, 
			{ width : '100', title : '是否合格', field : 'sfhg', hidden : false,
				editor :'text'   
			},
			{ width : '100', title : '移交情况', field : 'yjqk', hidden : false,
				editor :'text'  
			} 
			] ] 
		}); 
	};
   // 加载报告
	 function loadjcbg(){
		 parent.$.messager.progress({
		 text : '数据加载中....'
	 });
	 $.post(basePath + '/jyjc/queryjcbg', {
	 	cydjid : $('#cydjid').val()
	 }, 
	 function(result) {
		 if (result.code=='0') {
		 	var mydata = result.data;		
		 	$('form').form('load', mydata); 
		 } else {
		 	parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
		 }	
	 		parent.$.messager.progress('close');
	 }, 'json'); 
	}  
  
  // 提交保存检查项目
	var savejyjcxm = function() { 
		var rows = grid.datagrid("getRows");
		if(rows.length>0){
			var succJsonStr = $.toJSON(rows);
			$.messager.progress();	// 显示进度条
			$.post(basePath + '/jyjc/savejcxm', {
				cydjid : $('#cydjid').val(),
				succJsonStr : succJsonStr
			}, 
			function(result) {
				if (result.code == '0') {
					$.messager.alert('提示', '操作成功', 'info',
						function(){
							 grid.datagrid('reload');
						});
				} else {
					$.messager.alert('提示', '操作失败:' + result.msg, 'error');
				}
				$.messager.progress('close');
			}, 'json');
		}else{
			$.messager.alert('提示', '没有要保存的记录！', 'info');
		}
	};

	// 删除
	var deljyjcxm = function() {
		var row =  grid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗?',function(r) {
				if (r) {
					$.post(basePath + '/jyjc/deljcxm', {
						jyjcbgxmid: row.jyjcbgxmid
					},
						function(result) {
							if (result.code == '0') {
								$.messager.alert('提示','删除成功！','info',function(){ 
							    	grid.datagrid('reload'); 
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
	
	
	//保存报告
	var submitForm = function($dialog, $grid, $pjq) { 
		var rows = grid.datagrid("getRows");
		if (rows.length == 0) { //若检查项目为空不让保存报告   直接关闭该页
			$dialog.dialog('destroy');
		}
		var url = basePath + 'jyjc/savejcbg'; 
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
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
			 	if (result.code=='0'){
			 		$.messager.alert('提示','保存成功！','info',function(){
						 $grid.datagrid('load');
	        			$dialog.dialog('destroy'); 
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	};
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
     	$dialog.dialog('destroy');
	 };  
  </script>
</head>
<body> 
	<sicp3:groupbox title="抽样信息">
			<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:right;"><nobr>被抽样单位:</nobr></td>
					<td><input id="bcydw" name="bcydw" style="width: 200px" readonly="readonly" /> </td>
					<td style="text-align:right;"><nobr>被抽样单位联系电话:</nobr></td>
					<td><input id="tel" name="tel" style="width: 200px" readonly="readonly" /></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>被抽样单位地址:</nobr></td>
					<td><input id="bcydwdz" name="bcydwdz" style="width: 200px"  readonly="readonly"/></td>
					<td style="text-align:right;"><nobr>被抽样单位分类:</nobr></td>
					<td><input id="bcydwfl" name="bcydwfl" style="width: 200px"  readonly="readonly"/></td>
				</tr> 
				<tr>
					<td style="text-align:right;"><nobr>抽样编号:</nobr></td>
					<td><input id="cybh" name="cybh" style="width: 200px"  readonly="readonly"/></td>
					<td style="text-align:right;"><nobr>样品名称:</nobr></td>
					<td><input id="ypmc" name="ypmc" style="width: 200px"  readonly="readonly"/></td>
				</tr> 
				<tr>
					<td style="text-align:right;"><nobr>样品批号或生产日期:</nobr></td>
					<td><input id="ypbh" name="ypbh" style="width: 200px"  readonly="readonly"/></td>
					<td style="text-align:right;"><nobr>抽样时间:</nobr></td>
					<td><input id="cysj" name="cysj" style="width: 200px" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /></td>
				</tr> 
				<tr>
					<td style="text-align:right;"><nobr>抽样数量:</nobr></td>
					<td><input id="countcy" name="countcy" style="width: 200px" readonly="readonly"/></td>
					<td style="text-align:right;"><nobr>生产单位:</nobr></td>
					<td><input id="scdw" name="scdw" style="width: 200px"  readonly="readonly"/></td>
				</tr> 
				<tr>
					
					<td style="text-align:right;"><nobr>抽样经手人:</nobr></td>
					<td><input id="cyjsr" name="cyjsr" style="width: 200px"  readonly="readonly" /></td>
					<td style="text-align:right;"><nobr>抽样分类:</nobr></td>
					<td><input id="cyfl" name="cyfl" style="width: 200px"  readonly="readonly"/></td>
				</tr> 
				<tr>
				    <td style="text-align:right;"><nobr>经办时间:</nobr></td>
					<td><input id="aae036" name="aae036" style="width: 200px"  readonly="readonly" /></td>
					<td style="text-align:right;"><nobr>经办人:</nobr></td>
					<td><input id="aae011" name="aae011" style="width: 200px"  readonly="readonly"/></td>
				</tr> 
			</table>
		</sicp3:groupbox>	
    <sicp3:groupbox title="检查项目列表"> 
    <div id="grid"></div> 
    </sicp3:groupbox>
    <sicp3:groupbox title="检查报告内容">
	<form id="fm" method="post" >
		<input type="hidden" id="cydjid" name="cydjid" value="<%=id%>"/>  <!-- 抽样登记id -->
		<input type="hidden" id="bgid" name="bgid" />  <!-- 报告ID -->
		<input type="hidden" id="jcdwid" name="jcdwid" />  <!-- 检测单位ID --> 
		<table class="table" style="width:98%;height: 98%"> 
			<tr>
				<td style="text-align:right;"><nobr>报告书编号:</nobr></td>
				<td><input id="bgbh" name="bgbh" style="width: 200px" 
				     class="easyui-validatebox" data-options="required:true"/></td>
				<td style="text-align:right;"><nobr>立案号:</nobr></td>
				<td><input id="lah" name="lah" style="width: 200px" /></td>	
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>收到报告日期:</nobr></td>
				<td ><input id="jsbgrq" name="jsbgrq" style="width: 200px" class="Wdate"
				      onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
				<td style="text-align:right;"><nobr>送达报告日期:</nobr></td>
				<td><input id="bgsdrq" name="bgsdrq" style="width: 200px" class="Wdate"
			          onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /></td>						
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>检测日期开始:</nobr></td>
				<td><input id="jcrqks" name="jcrqks" style="width: 200px" class="Wdate"
			          onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
				<td style="text-align:right;"><nobr>检测日期结束:</nobr></td>
				<td><input id="jcrqjs" name="jcrqjs" style="width: 200px" class="Wdate"
			          onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
			</tr> 
			<tr>
				<td style="text-align:right;"><nobr>经办时间:</nobr></td>
				<td><input id="aae036" name="aae036" style="width: 200px" class="Wdate"
			        onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" disabled="disabled" /></td>						
				<td style="text-align:right;"><nobr>检测单位名称:</nobr></td>
				<td><input id="jcdwmc" name="jcdwmc" style="width: 200px" /></td>						
			</tr>  
			<tr> 					
				<td style="text-align:right;"><nobr>经办人:</nobr></td>
				<td><input id="aae011" name="aae011" style="width: 200px" disabled="disabled" /></td>						
			</tr> 
		</table>	
  </form>
  </sicp3:groupbox>			 		
</body>
</html>