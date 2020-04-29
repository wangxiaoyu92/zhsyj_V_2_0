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
<title>车辆维修管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var clcd = <%=SysmanageUtil.getAa10toJsonArray("CLCD")%>;
	var cllx = <%=SysmanageUtil.getAa10toJsonArray("CLLX")%>;
	var clrllx = <%=SysmanageUtil.getAa10toJsonArray("CLRLLX")%>;
	var clsf = <%=SysmanageUtil.getAa10toJsonArray("CLSF")%>;
	var cb_cllx;
	var cb_clrllx;
	var cb_clsf;
	var grid;
	
	$(function() {
		cb_cllx = $('#cllx').combobox({
	    	data : cllx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_clrllx = $('#clrllx').combobox({
	    	data : clrllx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_clsf = $('#clsf').combobox({
	    	data : clsf,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
			url: '',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'clwxid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '100',
				title : '车辆ID',
				field : 'clid',
				hidden : false
			},{
				width : '100',
				title : '车牌号',
				field : 'clcph',
				hidden : false
			}]],				
			columns : [ [ {
				width : '100',
				title : '维修ID',
				field : 'clwxid',
				hidden : false
			},{
				width : '200',
				title : '维修原因',
				field : 'clwxyy',
				hidden : false
			},{
				width : '200',
				title : '维修地点',
				field : 'clwxdd',
				hidden : false
			},{
				width : '100',
				title : '送修里程（公里）',
				field : 'clsylc',
				hidden : false
			},{
				width : '100',
				title : '送修日期',
				field : 'clsxrq',
				hidden : false
			},{
				width : '100',
				title : '预计取车日期',
				field : 'clyjqcrq',
				hidden : false
			},{
				width : '150',
				title : '取车日期',
				field : 'clqcrq',
				hidden : false
			},{
				width : '100',
				title : '维修单据号',
				field : 'clwxdjh',
				hidden : false
			},{
				width : '100',
				title : '维修费用（元）',
				field : 'clwxfy',
				hidden : false
			},{
				width : '200',
				title : '备注',
				field : 'bz',
				hidden : false
			} ] ]
		});
	});

	//查询
	function query() {
		var clid = $('#clid').val();
		if (clid.length>0) {		
			$('#grid').datagrid({
				url : basePath + '/zy/clgl/queryClwx',			
				queryParams : { 'clid':clid }
			});
			$('#grid').datagrid('clearSelections');
		}else{
			$.messager.alert('提示', '请先查询车辆！', 'info');
		}
	}

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 

	//查询车辆
	function queryCl() {
		var form = $('#fm');
		var clcph = $('#clcph').val();		
		var dialog = parent.sy.modalDialog({
			title : '车辆信息',
			iconCls : 'ext-icon-monitor',
			width : 800,
			height : 600,
			url : basePath + '/common/sjb/clIndex?clcph=' + clcph,
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.getDataInfo(dialog, form, parent.$); 
				}
			},{
				text : '取消',
				handler : function() {
					dialog.dialog('close');
				}
			} ]
		});
		
	}
	
	function queryClDTO() {		
		var clcph = $('#clcph').val();	
		if(clcph != null && clcph != ''){						
			$.post(basePath + '/common/sjb/queryClDTO', {
				'clcph': clcph
			},
			function(result) {
				if (result.code=='0'){
					var mydata = result.data;
					if(mydata==null){						
						//设置默认值
						$('#fm').form('load',{
							//clcph : '',
							clid : '',
					    	clcd : '',
					    	clzz : '',
					    	cllx : '',
					    	clrllx : '',
					    	clsf : ''
					    });
					}else{
						$('#fm').form('load',mydata);
					}
				} else {
              		$.messager.alert('提示','查询失败：'+result.msg,'error');
                }						
			},
			'json');	
		}		
	}
	

	// 新增
	var addClwx = function() {
		var clid = $('#clid').val();
		if (clid.length>0) {
			var dialog = parent.sy.modalDialog({
				title : '新增车辆维修记录',
				width : 800,
				height : 500,
				url : basePath + '/zy/clgl/clwxFormIndex?clid='+clid,
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
			$.messager.alert('提示', '请先查询车辆！', 'info');
		}
	};
	// 编辑
	var updateClwx = function() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '修改车辆维修记录',
				width : 800,
				height : 500,
				url : basePath + '/zy/clgl/clwxFormIndex?clwxid=' + row.clwxid,
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
			$.messager.alert('提示', '请先选择要修改的车辆维修记录！', 'info');
		}
	};
	// 删除
	var delClwx = function() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗，这将删除对应的车辆维修记录信息，且不可恢复！',function(r) {
				if (r) {
					$.post(basePath + '/zy/clgl/delClwx', {
						clwxid: row.clwxid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','删除成功！','info',function(){
								//$('#grid').datagrid('reload');
								query(); 
			        		}); 
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的车辆维修记录！', 'info');
		}
	} 
</script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
       	<form id="fm" method="post" >
        	<sicp3:groupbox title="车辆信息">
	       		<table class="table" style="width: 99%;">	       			
					<tr>
						<td style="text-align:right;"><nobr>车牌号</nobr></td>
						<td>
							<input id="clcph" name="clcph" style="width: 175px;"  class="easyui-validatebox"  data-options="required:true" onblur="queryClDTO();"/>
							<input type="button" id="clcph_rbtn" value="..." onclick="queryCl();"/>
							<input name="clid" id="clid"  type="hidden"/>
						</td>						
						<td style="text-align:right;"><nobr>车辆长度（米）</nobr></td>
						<td><input name="clcd" id="clcd" style="width: 175px; "  /></td>
						<td style="text-align:right;"><nobr>车辆载重（吨）</nobr></td>
						<td><input name="clzz" id="clzz" style="width: 175px; " /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>车辆类型</nobr></td>
						<td><input name="cllx" id="cllx"  style="width: 175px; " /></td>			
						<td style="text-align:right;"><nobr>车辆燃料类型</nobr></td>
						<td><input name="clrllx" id="clrllx" style="width: 175px; "   /></td>
						<td style="text-align:right;"><nobr>车辆身份</nobr></td>
						<td><input name="clsf" id="clsf"  style="width: 175px; "  /></td>				
					</tr>
					<tr>				
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
			<sicp3:groupbox title="维修记录">
				<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton"  data="btn_addClwx"
								iconCls="icon-add" plain="true" onclick="addClwx()">增加</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateClwx"
								iconCls="icon-edit" plain="true" onclick="updateClwx()">修改</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delClwx"
								iconCls="icon-remove" plain="true" onclick="delClwx()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  										
						</tr>
					</table>
				</div>
				<div id="grid"></div>
			</sicp3:groupbox>
		</form>				              
    </div>    
</body>
</html>