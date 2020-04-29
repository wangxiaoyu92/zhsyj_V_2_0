<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
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
<title>检查结果管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
		var grid;
	var url ="<%=basePath%>/supervision/checkresult/jcsbresultlist";
	$(function() {
		grid = $('#grid').datagrid({
			url :url,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'resultid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				title: '公司id',
				field: 'comid',
				width : '100',
				hidden : true
			},{title: '聚餐标识',
				field: 'checkgroupstate',
				width : '100',
				hidden : true
			},{
				title: '计划id',
				field: 'planid',
				width : '100',
				hidden : true
			},{
				title: '全部检查完毕',
				field: 'resultstate',
				width : '100',
				hidden : false,
				formatter: function(value,row,index) {
					if (value == "1") {
						return '<span style="color:red">全部检查未完毕</span>';
					}else if(value == "2"){
						return '<span style="color:green">全部检查完毕</span>';
					}
					else{
						return '<span style="color:blue">结果只读</span>';
					}
				}
			}]],			
			columns : [ [ {
				title: '计划名称',
				field: 'plantitle',
				width : '150',
				hidden : false 
			},{
				title: '检查类别',
				field: 'planchecktype',
				width : '150',
				hidden : false ,
				formatter: function(value,row,index) {
					if (value == "0") {
						return '<span style="color:blue">量化</span>';
					}else if(value == "1"){
						return '<span style="color:blue">日常</span>';
					}
					else{
						return '<span style="color:blue">量化</span>';
					}
				}
			},{
				title: '结果id',
				field: 'resultid',
				width : '100',
				hidden : true
			},{
				title: '检查对象',
				field: 'jcsbjbrxm',
				width: '260'
			}
			,{
				title: '已完成检查项数',
				field: 'checkednum',
				width: '100'
			}
			,{
				title: '总检查项数',
				field: 'checknum',
				width: '100'
			}
			,{
				title: '经办时间',
				field: 'operatedate',
				width: '160',
				hidden : false
			},{
				title: '结束时间',
				field: 'resultdate',
				width: '160',
				hidden : false
			}
			] ],
			toolbar: '#toolbar'
		});
	});
</script>
<script type="text/javascript">
	function refresh(){
		parent.window.refresh();	
	} 
	
	// 查询
	function query() {
		var jcsbjbrxm = $('#jcsbjbrxm').val(); 
		var operatedate = $('#operatedate').val();
	    var planeendddate = $('#planeendddate').val();
		var plantitle = $('#plantitle').val();
		var param = {
			'plantitle': plantitle,
			'operatedate': operatedate,
			'planeendddate': planeendddate,
			'commc': commc
		};
		$('#grid').datagrid('load', param);
		$('#grid').datagrid('clearSelections');
	}
	//查看结果明细
	var viewResult = function() {
	var row = $("#grid").datagrid('getSelected');
	if(row){
	//固化
	if(row.resultstate=="3"){
	var dialog = parent.sy.modalDialog({
				title : '查看检查结果',
				width :1040,
				height :670,
				url : basePath +'/supervision/checkresult/viewResult?resultid='
					+row.resultid+'&resultstate='+row.resultstate+'&checkgroupstate='
					+row.checkgroupstate+'&planchecktype='+row.planchecktype,
				buttons : [{
					text : '取消',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
	}else if(row.resultstate=="1"){
	var dialog = parent.sy.modalDialog({
			title : '查看检查结果',
			width :1040,
		    height :670,
			url : basePath + '/supervision/checkresult/jcsbresultDetail?resultid='
				+row.resultid+'&resultstate='+row.resultstate+'&checkgroupstate='
				+row.checkgroupstate+'&planchecktype='+row.planchecktype,
			buttons : [ 
			//没有完成去除保存
			{
				text : '保存',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.saveDetail(dialog, grid, parent.$);
				}
			},
			{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	}else{
		var dialog = parent.sy.modalDialog({
			title : '查看检查结果',
			width :1040,
		    height :670,
			url : basePath + '/supervision/checkresult/jcsbresultDetail?resultid='
				+row.resultid+'&resultstate='+row.resultstate+'&planchecktype='+row.planchecktype,
			buttons : [ 
			{
				text : '保存',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.saveDetail(dialog, grid, parent.$);
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
		$.messager.alert('提示','请先选择要查看的结果信息！','info');
		}
	};


//查看结果信息
	var viewResultinfo = function() {
	var row = $("#grid").datagrid('getSelected');
	if(row){
	//除未完成
	if(row.resultstate!="1"){
	var dialog = parent.sy.modalDialog({
				title : '查看检查结果',
				width :1040,
				height :670,
				url : basePath +'/supervision/checkresult/viewResultinfo?resultid='
					+row.resultid+'&resultstate='+row.resultstate+'&planchecktype='+row.planchecktype,
				buttons : [{
					text : '取消',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
	}else{
	$.messager.alert('提示','还没有核查完毕无法查看核查结果信息！','info');
	}
		}else{
		$.messager.alert('提示','请先选择要查看的结果信息！','info');
		}
	};
//附件管理
	function uploadFuJian(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var v_ajdjid = row.resultid;		    
		    var v_fjcsdlbh = "SYJGFJ";//附件参数大类编号：
		    var v_dmlb = "SPJGFJ";//附件参数小类编号：
		    var url = basePath + 'pub/pub/pubUploadFjListIndex?ajdjid='
		    	+v_ajdjid+'&dmlb='+v_dmlb+'&fjcsdlbh='+v_fjcsdlbh+'&time='+new Date().getMilliseconds();
			var dialog = parent.sy.modalDialog({
				title : '附件管理',
				width :900,
				height :500,
				url : url
			});
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}	 	
	}
</script>
</head>
<body>
<div class="easyui-layout" fit="true">   
        <div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="检查项目信息">    
	        <form id="fm" name="fm" method="post">		
				<table class="table" style="width: 80%;">
					<tr>
						<td style="text-align:right;" ><nobr>计划信息</nobr></td>
						<td><input id="plantitle" name="plantitle"  style="width: 200px;" /></td>	
						<td style="text-align:right;" ><nobr>检查对象</nobr></td>		
							<td><input id="jcsbjbrxm" name="jcsbjbrxm"  style="width: 200px;" /></td>									
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>检查开始时间</nobr></td>
						<td><input type="text" id="operatedate" name="operatedate"    
							onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'operateenddate\')}',readOnly:true})" 
							class="Wdate" readonly="readonly"/> 					
						&nbsp;-&nbsp; <input type="text" id="operateenddate" name="operateenddate"    
						onFocus="WdatePicker({minDate:'#F{$dp.$D(\'operatedate\')}',readOnly:true})" 
						class="Wdate" readonly="readonly"/> 
					</td><td style="text-align:right;"></td>	
						<td >
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
			</form>
			
	        </sicp3:groupbox>
	        <sicp3:groupbox title="检查结果列表">
	        <div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_viewResult"
								iconCls="ext-icon-report_magnify" plain="true" onclick="viewResult()">查看结果明细</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_uploadFuJian"
								iconCls="icon-upload" plain="true" onclick="uploadFuJian()">附件管理</a>
							</td>
<!-- 							<td>    -->
<!-- 								<div class="datagrid-btn-separator"></div> -->
<!--  							</td>   -->
<!-- 							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_savePcompany" -->
<!-- 								iconCls="ext-icon-report_magnify" plain="true" onclick="viewResultinfo()">查看核查结果信息</a>  -->
<!-- 							</td> -->
<!-- 							<td>   -->
<!-- 								<div class="datagrid-btn-separator"></div> -->
<!-- 							</td>  -->
<!-- 							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_savePcompany" -->
<!-- 								iconCls="icon-edit" plain="true" onclick="editContent()">编辑</a> -->
<!-- 							</td> -->
<!-- 							<td>   -->
<!-- 								<div class="datagrid-btn-separator"></div> -->
<!-- 							</td>  -->
<!-- 							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delPcompany" -->
<!-- 								iconCls="icon-remove" plain="true" onclick="delContent()">删除</a> -->
<!-- 							</td> -->
<!-- 							<td>   -->
<!-- 								<div class="datagrid-btn-separator"></div> -->
<!-- 							</td>   -->
<!-- 							<td>   -->
<!-- 								<div class="datagrid-btn-separator"></div> -->
<!-- 							</td>  -->
<!-- 							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_pcompanyFormIndex" -->
<!-- 								iconCls="ext-icon-report_magnify" plain="true" onclick="viewContent()">查看</a> -->
<!-- 							</td> -->
<!-- 							<td>   -->
<!-- 								<div class="datagrid-btn-separator"></div> -->
<!-- 							</td> -->
						</tr>
					</table>
				</div>
	        <div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>
    </div>    	
</body>
</html>