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
<title>检查计划管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var grid;
	var url ="<%=basePath%>/supervision/queryPlan";
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
		    idField: 'planid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				title: '计划id',
				field: 'planid',
				width : '100',
				hidden : true
			}]],			
			columns : [ [ {
				title: '名称',
				field: 'plantitle',
				width : '150',
				hidden : false
			},{
				title: '编号',
				field: 'plancode',
				width: '150'
			},{
				title: '检查类别',
				field: 'planchecktype',
				width: '150',
				formatter: function(value,row,index) { 
					if (value == "0") {
						return '<span style="color:blue">量化</span>';
					} else if (value == "1"){
						return '<span style="color:blue">日常</span>';
					} else {
						return '<span style="color:blue">量化</span>';
					}
				}
			},{
				title: '计划类型',
				field: 'plantype',
				width: '100',
				hidden : false,
				formatter: function(value,row,index) {
					if (value == "1") {
						return '<span style="color:blue">按类别</span>';
					}else if (value == "2"){
						return '<span style="color:blue">按区域</span>';
					} else {
						return '<span style="color:blue">按特定对象</span>';
					}
				}
			},{
				title: '开始时间',
				field: 'planstdate',
				width: '120',
				hidden : false
			},{
				title: '结束时间',
				field: 'planeddate',
				width: '100',
				hidden : false
			},{
				title: '经办时间',
				field: 'planoperatedate',
				width: '100',
				hidden : false
			},{
				title: '经办人',
				field: 'planoperator',
				width: '150',
				hidden : true
			}
			] ],
			toolbar: '#toolbar'
// 			onDblClickRow: function(){//双击事件 查看、修改等操作
// 				var row = $('#grid').datagrid('getSelected');
// 				if(row){
// 					updatePlan();	
// 				}
// 			}

		});
	});
	
	function query() {
		var plantype = $("#plantype").val(); 
		var planstdate = $('#planstdate').val();
	    var planeddate = $('#planeddate').val();
		var plantitle = $('#plantitle').val();
		var param = {
			'plantype': plantype,
			'planstdate': planstdate,
			'planeddate': planeddate,
			'plantitle': plantitle
		};
		$('#grid').datagrid('load', param);
		$('#grid').datagrid('clearSelections');	
	}
	
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	var addPlansIndex = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增计划信息',
			width :900,
				height :560,
			url : basePath + '/supervision/addPlansIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.savePlan(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};
	//编辑信息
	var updatePlansIndex = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var state = getResultNum(row.planid);
			if(!state){
				var dialog = parent.sy.modalDialog({
					title:'编辑计划信息',
					width:1200,
					height:560,
					url:basePath + '/supervision/updatePlansIndex?planid='+row.planid,
					buttons:[{
						text : '确定',
						handler:function(){
							dialog.find('iframe').get(0).contentWindow.savePlan(dialog,grid,parent.$);
						}
					},{
						text : '取消',
						handler : function(){
							dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
						}
					}]
				});
			}
		} else {
			$.messager.alert('提示','请先选择要修改的计划信息！','info');
		}
	};
	// 删除
	function delPlan() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var state = getResultNum(row.planid);
			if(!state){
				$.messager.confirm('警告', '您确定要删除该用户吗?',function(r) {
					if (r) {
						$.post(basePath + 'supervision/delPlan', {
							planid: row.planid
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
			}
		} else {
			$.messager.alert('提示', '请先选择要删除的用户！', 'info');
		}
	}  	
	//设置范围
	var setPlanScope = function(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var state = getResultNum(row.planid);
			if(!state){
				var dialog = parent.sy.modalDialog({
						title:'设置执行范围',
						width:1200,
						height:560,
						url:encodeURI(encodeURI(basePath + '/supervision/setPlanScope?planid='
								+row.planid+'&plancode='+row.plancode)),
						buttons:[{
							text : '确定',
							handler:function(){
								dialog.find('iframe').get(0).contentWindow.savePlan(dialog,grid,parent.$);
							}
						},{
							text : '取消',
							handler : function(){
								dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
							}
						}]
				});
			}
		} else {
			$.messager.alert('提示','请先选择要设置的计划信息！','info');
		}
	};
	
	//查看信息
	var showPlan = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看计划信息',
				width :1040,
				height :560,
				url : basePath +'/supervision/updatePlansIndex?op=view&planid='+row.planid,
				buttons : [{
					text : '取消',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		} else {
			$.messager.alert('提示','请先选择要查看的计划信息！','info');
		}
	};
	
	
	//获取计划列表（itemid 为企业类型）
	function getPlan(){
		var row = $('#grid').datagrid('getSelected');
			$.post(basePath + '/common/sjb/updateResultByid', {
					resultid: '2016061501195689126103926'
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata =result.data;
					alert(mydata);
	// 				alert(mydata.resultstate);
	// 				for(var i =0;i<mydata.length;i++){
	// 					alert(mydata[i].detailscore);
	// 					alert(mydata[i].itemname);
	// 					alert(mydata[i].contentid);
	// 					alert(mydata[i].content);
	// 				}
									
				} 
			}, 'json');
	}
// 	查看信息
// 	var checkPlan = function(){
// 		var row = $('#grid').datagrid('getSelected');
// 		if(row){
// 			var dialog = parent.sy.modalDialog({
// 				title : '审核计划信息',
// 				width :1040,
// 				height :670,
// 				url : basePath +'/supervision/viewPlansIndex?planid='+row.planid,
// 				buttons : [{
// 					text : '取消',
// 					handler:function(){
// 						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
// 					}
// 				}]
// 			});
			
// 			$.messager.prompt('My Title', 'Please type something', function(r){
// 				if (r){
// 					alert('you type: '+r);
// 				}
// 			});
			
			
// 		}else{
// 			$.messager.alert('提示','请先选择要审核的计划！','info');
// 		}
// 	};
	//审核窗口打开
	function checkPlan() {
		var row = $('#grid').datagrid('getSelected');
		if(row){
	 		$('#ReceiveFeedBackDialog').dialog('open');
		} else {
			$.messager.alert('提示','请先选择要审核的计划！','info');
		}
   
	}    
    //审核窗口关闭
	function closeDialog() {
    	$('#ReceiveFeedBackDialog').dialog('close');
	}	
	function formSubmit(){
		var row = $('#grid').datagrid('getSelected');
		var checkitem =$('#checkitem').val();
		//后台提交
		$.post(basePath + 'supervision/saveCheckPlan', {
				planid : row.planid,
				checkid : checkitem
		}, 
		function(result) {
			if (result.code=='0') {
				//刷新列表
			} 
		}, 'json');
	}


	// 计划结果
	var checkresult = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看计划结果信息',
				width :1040,
				height :670,
				url : basePath +'/supervision/checkresult/resultjsp?planid='+row.planid,
				buttons:[{
					text : '确定',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.savePlan(dialog,grid,parent.$);
					}
				},{
					text : '取消',
					handler : function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要查看的计划结果信息！','info');
		}
	};
	
	//查询计划下的结果个数
	function getResultNum(planid){
		var state =false;
		$.ajax({
			url: basePath + 'supervision/checkresult/getResultNumByPlanid',
            data:{planid:planid},
            dataType:'json',
            async : false,//必须同步，不然取不到成功之后返回值
            error : function() {  
        	   alert("网络连接异常");  
      		} ,
			success: function(result){
				if (result.code=='0') {
					var total = result.total;
					if(total>0){
						state = true;
						alert("本计划已经在实施中，不能对其相关信息操作");
					}
				}
			}
		 });
		 return state;
	}
	
	// 派发任务
	function setTaskByPlan(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var v_planid = row.planid;
		    var url = "<%=basePath%>jsp/supervision/setTaskByPlan.jsp";
			var dialog = parent.sy.modalDialog({
				title : '派发任务',
				param : {
					planid : v_planid,
					a : new Date().getMilliseconds()
				},
				width : 810,
				height : 600,
				url : url
			});
	    } else {
			$.messager.alert('提示', '请先选择要派发任务的检查计划！', 'info');
		}
	}
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>计划名称</nobr></td>
						<td><input id="plantitle" name="plantitle" style="width: 200px"/></td>						
						<td style="text-align:left;"><nobr>类型&nbsp;&nbsp;</nobr>
						<select name="plantype" id="plantype">
						<option value="">--请选择--</option>
						<option value="1">按类别</option>
						<option value="2" >按区域</option>
						<option value="3">按特定对象</option>
						</select></td>							
						
					</tr>
					
					<tr>
						<td style="text-align:right;">
						<nobr>执法时间</nobr>
				</td>
				<td>
					<input type="text" id="planstdate" name="planstdate"    onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'planeddate\')}',readOnly:true})" class="Wdate" readonly="readonly"/> 					
						&nbsp;-&nbsp; <input type="text" id="planeddate" name="planeddate"    onFocus="WdatePicker({minDate:'#F{$dp.$D(\'planstdate\')}',readOnly:true})" class="Wdate" readonly="readonly"/> 
					</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>				
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="检查计划列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addPlansIndex"
								iconCls="icon-add" plain="true" onclick="addPlansIndex()">增加</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updatePlansIndex"
								iconCls="icon-edit" plain="true" onclick="updatePlansIndex()">编辑</a>
							</td>  
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_setPlanScope"
								iconCls="icon-modify" plain="true" onclick="setPlanScope()">设置执行范围</a>
							</td>
<!-- 							<td><div class="datagrid-btn-separator"></div></td> -->
<!-- 							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_pcompanyFormIndex" -->
<!-- 								iconCls="icon-ok" plain="true" onclick="checkPlan()">审核</a> -->
<!-- 							</td> -->
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delPlan"
								iconCls="icon-remove" plain="true" onclick="delPlan()">删除</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showPlan"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showPlan()">查看</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_setTaskByPlan"
								iconCls="ext-icon-overlays" plain="true" onclick="setTaskByPlan()">派发任务</a>
							</td>
<!-- 							<td><div class="datagrid-btn-separator"></div></td>  -->
<!--  							<td><a href="javascript:void(0)" class="easyui-linkbutton"  -->
<!-- 								iconCls="ext-icon-report_magnify" plain="true" onclick="checkresult()">检查结果</a>  -->
<!-- 							</td>  -->
							
<!-- 							<td><div class="datagrid-btn-separator"></div></td> -->
<!-- 							<td><a href="javascript:void(0)" class="easyui-linkbutton" -->
<!-- 								iconCls="icon-remove" plain="true" onclick="getPlan()">得到信息</a> -->
<!-- 							</td>  -->
						</tr>
					</table>
				</div>
				<div id="grid"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
    
    <!-- 审核弹出框 -->
	<div id="ReceiveFeedBackDialog" class="easyui-dialog" closed="true" buttons="#dlg-buttons" title="审核信息" style="width:400px;height:30px;">
      <div align="center" style="width:350px;height:30px;">
      <input type="radio"  name="checkitem"  id="checkitem"  value="1" checked="checked" />通过
       <input type="radio" name="checkitem"  id="checkitem" value="0" />不通过
<!--       <select id="checktext" style="width:80px;" class="easyui-combobox" data-options="panelHeight:'auto' ,required:true" name="checktext" >             -->
<!--         <option value="">请选择</option>   -->
<!--         <option value="1">通过</option>   -->
<!--         <option value="2">不通过</option>   -->
<!--    </select> -->

 </div> 
</div> 
    <div id="dlg-buttons">
        <a href="#" class="easyui-linkbutton" onclick="formSubmit();">确定</a> 
        <a href="#" class="easyui-linkbutton" onclick="closeDialog();">关闭</a>
    </div>	
</body>
</html>