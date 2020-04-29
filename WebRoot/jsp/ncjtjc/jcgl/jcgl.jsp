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
<title>聚餐管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var jcsbjcgm = <%=SysmanageUtil.getAa10toJsonArray("JCSBJCGM")%>;
	var jcsbjclx = <%=SysmanageUtil.getAa10toJsonArray("JCSBJCLX")%>;
	var jcsbylly = <%=SysmanageUtil.getAa10toJsonArray("JCSBYLLY")%>;
	var jcsbcsly = <%=SysmanageUtil.getAa10toJsonArray("JCSBCSLY")%>;
	var jcsbcyjly = <%=SysmanageUtil.getAa10toJsonArray("JCSBCYJLY")%>;
	var jcsbjccc = <%=SysmanageUtil.getAa10toJsonArray("JCSBJCCC")%>;
	var jcsbcslx = <%=SysmanageUtil.getAa10toJsonArray("JCSBCSLX")%>;
	var jcsbcdlx = <%=SysmanageUtil.getAa10toJsonArray("JCSBCDLX")%>;
	var csxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
	var cswhcd = <%=SysmanageUtil.getAa10toJsonArray("AAC011")%>;
	var cscynx = <%=SysmanageUtil.getAa10toJsonArray("CYNX")%>;
	var csjkzm = <%=SysmanageUtil.getAa10toJsonArray("JKZM")%>;
	var cspxqk = <%=SysmanageUtil.getAa10toJsonArray("PXQK")%>;
	var cb_jcsbjcgm;
	var cb_jcsbjclx;
	var cb_jcsbylly;
	var cb_jcsbcsly;
	var cb_jcsbcyjly;
	var grid;
	var jcsbcs_grid;
	var jcsbcd_grid;
	var jcsbpswp_grid;
	
	$(function() {
		cb_jcsbjcgm = $('#jcsbjcgm').combobox({
	    	data : jcsbjcgm,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
		cb_jcsbjclx = $('#jcsbjclx').combobox({
	    	data : jcsbjclx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_jcsbylly = $('#jcsbylly').combobox({
	    	data : jcsbylly,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_jcsbcsly = $('#jcsbcsly').combobox({
	    	data : jcsbcsly,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_jcsbcyjly = $('#jcsbcyjly').combobox({
	    	data : jcsbcyjly,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    
		grid = $('#grid').datagrid({
			//title : '聚餐列表',
			//iconCcs : 'icon-tip',
			//collapsible : true,
			toolbar : '#toolbar',
			url : basePath + '/ncjtjc/jcgl/queryJcsb',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcsbid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '150',
				title : '聚餐申报ID',
				field : 'jcsbid',
				hidden : false
			},{
				width : '150',
				title : '聚餐申报编号',
				field : 'jcsbbh',
				hidden : false
			},{
				width : '100',
				title : '举办人姓名',
				field : 'jcsbjbrxm',
				hidden : false
			}]],				
			columns : [ [ {
				width : '100',
				title : '举办人手机号',
				field : 'jcsbjbrsjh',
				hidden : false
			},{
				width : '100',
				title : '聚餐类型',
				field : 'jcsbjclx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(jcsbjclx,value);
				}
			},{
				width : '200',
				title : '聚餐地点',
				field : 'aab301',
				hidden : false
			},{
				width : '120',
				title : '聚餐地点经度坐标',
				field : 'jcsbjdzb',
				hidden : true
			},{
				width : '120',
				title : '聚餐地点纬度坐标',
				field : 'jcsbwdzb',
				hidden : true
			},{
				width : '100',
				title : '聚餐人数',
				field : 'jcsbjcrs',
				hidden : false
			},{
				width : '150',
				title : '聚餐规模',
				field : 'jcsbjcgm',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(jcsbjcgm,value);
				}
			},{
				width : '100',
				title : '聚餐时间1',
				field : 'jcsbjcsj1',
				hidden : false
			},{
				width : '100',
				title : '聚餐餐次1',
				field : 'jcsbjccc1',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(jcsbjccc,value);
				}
			},{
				width : '100',
				title : '聚餐时间2',
				field : 'jcsbjcsj2',
				hidden : false
			},{
				width : '100',
				title : '聚餐餐次2',
				field : 'jcsbjccc2',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(jcsbjccc,value);
				}
			},{
				width : '100',
				title : '聚餐时间3',
				field : 'jcsbjcsj3',
				hidden : false
			},{
				width : '100',
				title : '聚餐餐次3',
				field : 'jcsbjccc3',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(jcsbjccc,value);
				}
			},{
				width : '100',
				title : '原料来源',
				field : 'jcsbylly',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(jcsbylly,value);
				}
			},{
				width : '100',
				title : '厨师来源',
				field : 'jcsbcsly',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(jcsbcsly,value);
				}
			},{
				width : '150',
				title : '餐饮具来源',
				field : 'jcsbcyjly',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(jcsbcyjly,value);
				}
			},{
				width : '100',
				title : '经办人',
				field : 'aae011',
				hidden : false
			},{
				width : '150',
				title : '经办时间',
				field : 'aae036',
				hidden : false
			},{
				width : '200',
				title : '备注',
				field : 'aae013',
				hidden : false
			} ] ],
			onClickRow : function(rowIndex, rowData){			
				var jcsbid = rowData.jcsbid;
				jcsbcs_grid.datagrid({
					url : basePath + '/ncjtjc/jcgl/queryJcsbcs',			
					queryParams : { 'jcsbid':jcsbid }
				});
				jcsbcd_grid.datagrid({
					url : basePath + '/ncjtjc/jcgl/queryJcsbcd',			
					queryParams : { 'jcsbid':jcsbid }
				});
				jcsbpswp_grid.datagrid({
					url : basePath + '/ncjtjc/jcgl/queryJcsbpswp',			
					queryParams : { 'jcsbid':jcsbid }
				});
			}
		});

		jcsbcs_grid = $('#jcsbcs_grid').datagrid({
			//title : '聚餐申报厨师',
			//iconCcs : 'icon-tip',
			//collapsible : true,
			//toolbar : '#toolbar1',
			//url : basePath + '/ncjtjc/jcgl/queryJcsb',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcsbcsid', // 该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '150',
				title : '聚餐申报厨师ID',
				field : 'jcsbcsid',
				hidden : true
			},{
				width : '100',
				title : '聚餐申报ID',
				field : 'jcsbid',
				hidden : true
			},{
				width : '100',
				title : '厨师ID',
				field : 'csid',
				hidden : false
			}]],				
			columns : [ [ {
				width : '150',
				title : '厨师姓名',
				field : 'csxm',
				hidden : false
			},{
				width : '100',
				title : '性别',
				field : 'csxb',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(csxb,value);
				}
			},{
				width : '100',
				title : '从业年限',
				field : 'cscynx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(cscynx,value);
				}
			},{
				width : '100',
				title : '健康证明',
				field : 'csjkzm',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(csjkzm,value);
				}
			},{
				width : '100',
				title : '培训情况',
				field : 'cspxqk',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(cspxqk,value);
				}
			} ] ]
		});

		jcsbcd_grid = $('#jcsbcd_grid').datagrid({
			//title : '聚餐申报菜单',
			//iconCcs : 'icon-tip',
			//collapsible : true,
			//toolbar : '#toolbar2',
			//url : basePath + '/ncjtjc/jcgl/queryJcsbcd',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcsbcdid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '150',
				title : '聚餐申报菜单ID',
				field : 'jcsbcdid',
				hidden : true
			},{
				width : '100',
				title : '聚餐申报ID',
				field : 'jcsbid',
				hidden : true
			}]],				
			columns : [ [ {
				width : '150',
				title : '菜单类型',
				field : 'jcsbcdlx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(jcsbcdlx,value);
				}
			},{
				width : '300',
				title : '菜单名称',
				field : 'jcsbcdmc',
				hidden : false
			} ] ]
		});

		jcsbpswp_grid = $('#jcsbpswp_grid').datagrid({
			//title : '聚餐申报配送物品',
			//iconCcs : 'icon-tip',
			//collapsible : true,
			//toolbar : '#toolbar2',
			//url : basePath + '/ncjtjc/jcgl/queryJcsbcd',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcsbpswpid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '150',
				title : '聚餐申报配送物品ID',
				field : 'jcsbpswpid',
				hidden : true
			},{
				width : '100',
				title : '聚餐申报ID',
				field : 'jcsbid',
				hidden : true
			}]],				
			columns : [ [ {
				width : '200',
				title : '配送物品名称',
				field : 'jcsbpswpmc',
				hidden : false
			},{
				width : '200',
				title : '配送物品品牌',
				field : 'jcsbpswppp',
				hidden : false
			},{
				width : '200',
				title : '配送物品数量',
				field : 'jcsbpswpsl',
				hidden : false
			} ] ]
		});
	});

	// 查询
	function query() {
		var aaa027 = $('#aaa027').val();
		var jcsbbh = $('#jcsbbh').val();
		var jcsbjbrxm = $('#jcsbjbrxm').val();
		var jcsbjbrsjh = $('#jcsbjbrsjh').val();
		var jcsbjcgm = $('#jcsbjcgm').combobox('getValue');
		var param = {
			'aaa027': aaa027,	
			'jcsbbh': jcsbbh,
			'jcsbjbrxm': jcsbjbrxm,
			'jcsbjbrsjh': jcsbjbrsjh,
			'jcsbjcgm': jcsbjcgm
		};
		$('#grid').datagrid('reload', param);
		grid.datagrid('clearSelections');
	}

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	var addJcsb = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增聚餐申报',
			width : 900,
			height : 600,
			maximizable : true,
			url : basePath + '/ncjtjc/jcgl/jcsbFormIndex',
			buttons : [ {
				text : '关闭',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					$("#grid").datagrid("reload");
				}
			} ]
		});
	};

	// 编辑
	var updateJcsb = function() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '修改聚餐申报',
				width : 900,
				height : 600,
				maximizable : true,
				url : basePath + '/ncjtjc/jcgl/jcsbFormIndex?jcsbid=' + row.jcsbid,
				buttons : [ {
					text : '关闭',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
						$("#grid").datagrid("reload");
					}
				} ]
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的记录！', 'info');
		}
	};

	// 查看
	var showJcsb = function() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看聚餐申报',
				width : 900,
				height : 600,
				maximizable : true,
				url : basePath + '/ncjtjc/jcgl/jcsbFormIndex?op=view&jcsbid=' + row.jcsbid,
				buttons : [ {
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}else{
			$.messager.alert('提示', '请先选择要查看的记录！', 'info');
		}
	};
	
	// 删除
	var delJcsb = function() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗，这将删除对应的聚餐申报相关信息，且不可恢复！',function(r) {
				if (r) {
					$.post(basePath + '/ncjtjc/jcgl/delJcsb', {
						jcsbid: row.jcsbid,csbh: row.csbh
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
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	}; 
	
	// 上传附件
	function uploadFj(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			<%-- var obj = new Object(); 
			var retVal = popwindow("<%=contextPath %>/ncjtjc/jcgl/uploadFjIndex?jcsbid="+row.jcsbid,obj,800,600); --%>
			var url = basePath + "/ncjtjc/jcgl/uploadFjIndex";
			var dialog = parent.sy.modalDialog({ 
				width : 800,
				height : 500,
				param : {
					jcsbid : row.jcsbid
				}, 
				url : url
			} ,function (dialogID){
				var obj = sy.getWinRet(dialogID); 
				if(retVal != null){
					if(retVal.type == 'ok'){
						//grid.datagrid('load');
					}
				}
				sy.removeWinRet(dialogID);
			});
				
		}else{
			$.messager.alert('提示', '请先选择要上传附件的记录！', 'info');
		}
	}
	// 删除附件
	function delFj(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url =basePath + "/ncjtjc/jcgl/delFjIndex";
			var dialog = parent.sy.modalDialog({  
				width : 800,
				height : 600,
				param : {
					jcsbid : row.jcsbid
				}, 
				url : url
			},function(dialogID){
				var obj = sy.getWinRet(dialogID); 
					if(retVal != null){
						if(retVal.type == 'ok'){
							//grid.datagrid('load');
						}
					}
				sy.removeWinRet(dialogID);
			});
			<%-- var obj = new Object(); 
			var retVal = popwindow("<%=contextPath %>/ncjtjc/jcgl/delFjIndex?jcsbid="+row.jcsbid,obj,800,600); --%>
		}else{
			$.messager.alert('提示', '请先选择要删除附件的记录！', 'info');
		}
	}

	//附件管理
	function uploadFuJian(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			/* var obj = new Object(); */
			var v_ajdjid = row.jcsbid;		    
		    var v_fjcsdlbh = "NCJTJCFJ";//附件参数大类编号：农村集体聚餐附件
		    var v_dmlb = "JCSBDJBAFJ";//附件参数小类编号：聚餐申报备案登记附件
		    var url = basePath + 'pub/pub/pubUploadFjListIndex'; 
			/* var k = popwindow(url,obj,900,500);  
			 */ 
			var dialog = parent.sy.modalDialog({
				width : 900,
				height : 500,
				param : {
					ajdjid : v_ajdjid,
					dmlb : v_dmlb,
					fjcsdlbh : v_fjcsdlbh
				}, 
				url : url
			});
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}	 	
	}

	function printJcsbbadj(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var params = "jcsbid=" + row.jcsbid;
			sy.doPrint('ncjtjc/jcsbbadj.cpt',params);
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}
	}

	function showMenu_aaa027() {
		var url = basePath + 'jsp/pub/pub/selectAaa027.jsp'; 
		/* var obj = new Object();
		var k = popwindow(url,obj,300,400); */
		var dialog = parent.sy.modalDialog({
				width : 300,
				height : 400,
				url : url
			} ,function (dialogID){
					var obj = sy.getWinRet(dialogID); 
						if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
							$('#aaa027').val(k.aaa027);
							$('#aaa027name').val(k.aaa027name);
						}
						sy.removeWinRet(dialogID);
				});
				
	}	
	
	
	
	// 报表
	function printJcsbRecord(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + '/ncjtjc/jcgl/printJcsbbadj'; 
				var dialog = parent.sy.modalDialog({
					title : '打印',
					param : {
						jcsbid : row.jcsbid 
					},
					width : 900,
					height : 500,
					url : url ,
					buttons : [ {
						text : '取消',
						handler : function() {						
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
					}
				} ]
			} ); 
			/* var obj = new Object();
		    var url = basePath + '/ncjtjc/jcgl/printJcsbbadj?jcsbid='+row.jcsbid;
			var k = popwindow(url,obj,900,500); */  
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}	 	
	}
	
	// 报表
	var printJcsbRecord1 = function() {
	var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '打印《农村流动厨师备案登记表》',
				width : 870,
				height : 570,
				url : basePath + '/ncjtjc/jcgl/printJcsbbadj?jcsbid='+row.jcsbid,
				buttons : [ {
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}else{
			$.messager.alert('提示', '请先选择要查看的记录！', 'info');
		}
	};
	
	
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>											
						<td style="text-align:right;"><nobr>所属统筹区:</nobr></td>
						<td>
							<input name="aaa027name" id="aaa027name"  style="width: 200px " onclick="showMenu_aaa027();" 
							   readonly="readonly" class="easyui-validatebox" data-options="required:false" />
							<input name="aaa027" id="aaa027"  type="hidden"/>
							<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
								<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:150px;height:450px;"></ul>
							</div>							
						</td>
						<td style="text-align:right;"><nobr>聚餐申报编号:</nobr></td>
						<td><input id="jcsbbh" name="jcsbbh" style="width: 200px" /></td>								
						<td style="text-align:right;"><nobr>举办人姓名:</nobr></td>
						<td><input id="jcsbjbrxm" name="jcsbjbrxm" style="width: 200px" /></td>			
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>举办人电话:</nobr></td>
						<td><input id="jcsbjbrsjh" name="jcsbjbrsjh" style="width: 200px" /></td>									
						<td style="text-align:right;"><nobr>聚餐规模:</nobr></td>
						<td><input id="jcsbjcgm" name="jcsbjcgm" style="width: 200px" /></td>	
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
        	<sicp3:groupbox title="聚餐申报列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addJcsb"
								iconCls="icon-add" plain="true" onclick="addJcsb()">聚餐申报</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateJcsb"
								iconCls="icon-edit" plain="true" onclick="updateJcsb()">修改</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_jcsbFormIndex"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showJcsb()">查看</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>    
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delJcsb"
								iconCls="icon-remove" plain="true" onclick="delJcsb()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_uploadFj"
								iconCls="icon-upload" plain="true" onclick="uploadFuJian()()">附件管理</a>
							</td>   
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" 
								iconCls="icon-print" plain="true" onclick="printJcsbRecord()">打印《农村集体聚餐备案登记表》</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>   
						</tr>
					</table>
				</div>
				<div id="grid" ></div>
	        </sicp3:groupbox>
	        <sicp3:groupbox title="厨师申报信息">				
		        <div id="jcsbcs_grid" ></div>
		    </sicp3:groupbox> 
  			<sicp3:groupbox title="菜单申报信息">				
		        <div id="jcsbcd_grid" ></div>				  
		    </sicp3:groupbox> 
  			<sicp3:groupbox title="配送物品申报信息">				
		        <div id="jcsbpswp_grid" ></div>				  
		    </sicp3:groupbox> 
        </div>        
    </div>    
</body>
</html>