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
<title>两员管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var lysfzjlx = <%=SysmanageUtil.getAa10toJsonArray("AAC058")%>;
	var lyxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
	var lywhcd = <%=SysmanageUtil.getAa10toJsonArray("AAC011")%>;
	var lylx = <%=SysmanageUtil.getAa10toJsonArray("LYLX")%>;
	var zzmm = <%=SysmanageUtil.getAa10toJsonArray("ZZMM")%>;
	var lyjkzm = <%=SysmanageUtil.getAa10toJsonArray("JKZM")%>;
	var lypxqk = <%=SysmanageUtil.getAa10toJsonArray("PXQK")%>;
	var grid;
	
	$(function() {
		cb_lysfzjlx = $('#lysfzjlx').combobox({
	    	data : lysfzjlx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
		cb_lyxb = $('#lyxb').combobox({
	    	data : lyxb,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_lywhcd = $('#lywhcd').combobox({
	    	data : lywhcd,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : '200' 
	    });
		cb_lyjkzm = $('#lyjkzm').combobox({
	    	data : lyjkzm,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_lypxqk = $('#lypxqk').combobox({
	    	data : lypxqk,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    
		grid = $('#grid').datagrid({
			//title : '两员列表',
			//iconCly : 'icon-tip',
			//collapsible : true,
			toolbar : '#toolbar',
			url : basePath + '/ncjtjc/lygl/queryLy',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'lyid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '100',
				title : '姓名',
				field : 'lyxm',
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
				width : '150',
				title : '两员类型',
				field : 'lyjktjdd',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lylx,value);
				}
			}]],
			columns : [ [ {
				width : '100',
				title : '姓名拼音码',
				field : 'lypym',
				hidden : true
			},{
				width : '200',
				title : '政治面貌',
				field : 'aae013',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(zzmm,value);
				}
			},{
				width : '200',
				title : '家庭住址',
				field : 'lyjtzz',
				hidden : false
			},{
				width : '150',
				title : '服务区域',
				field : 'lyfwqy',
				hidden : false
			},{
				width : '150',
				title : '所属地区',
				field : 'aaa027name',
				hidden : false
			},{
				width : '100',
				title : '出生日期',
				field : 'lylyrq',
				hidden : false
			},{
				width : '100',
				title : '手机号',
				field : 'lysjh',
				hidden : false
			},{
				width : '200',
				title : '身份证件类型',
				field : 'lysfzjlx',
				hidden : true,
				formatter : function(value, row) {
					return sy.formatGridCode(lysfzjlx,value);
				}
			},{
				width : '150',
				title : '身份证号',
				field : 'lysfzjhm',
				hidden : false
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
				title : '年龄',
				field : 'lycynx',
				hidden : false
			},{
				width : '100',
				title : '职务',
				field : 'lyjkzm',
				hidden : false
			},{
				width : '100',
				title : '培训情况',
				field : 'lypxqk',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lypxqk,value);
				}
			},{
				width : '150',
				title : '邮箱',
				field : 'lyyx',
				hidden : false
			},{
				width : '150',
				title : 'QQ号',
				field : 'lyqq',
				hidden : false
			},{
				width : '150',
				title : '微信号',
				field : 'lywx',
				hidden : false
			},{
				width : '200',
				title : '两员ID',
				field : 'lyid',
				hidden : false
			},{
				width : '150',
				title : '两员编号',
				field : 'lybh',
				hidden : false
			} ] ]
		});
	});

	// 查询
	function query() {
		var aaa027 = $('#aaa027').val();
		var lyxm = $('#lyxm').val();
		var lypym = $('#lypym').val();
		var lysfzjhm = $('#lysfzjhm').val();
		var param = {
			'aaa027': aaa027,
			'lyxm': lyxm,
			'lypym': lypym,
			'lysfzjhm': lysfzjhm
		};
		$('#grid').datagrid('reload', param);
		grid.datagrid('clearSelections');
	}

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	var addLy = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增两员',
			width : 870,
			height : 570,
			url : basePath + '/ncjtjc/lygl/lyglFormIndex',
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
	};

	// 编辑
	var updateLy = function() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑两员',
				width : 870,
				height : 570,
				url : basePath + '/ncjtjc/lygl/lyglFormIndex?lyid=' + row.lyid,
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
			$.messager.alert('提示', '请先选择要修改的记录！', 'info');
		}
	};

	// 查看
	var showLy = function() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看两员',
				width : 870,
				height : 570,
				url : basePath + '/ncjtjc/lygl/lyglFormIndex?op=view&lyid=' + row.lyid,
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
	var delLy = function() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗，这将删除对应的两员相关信息，且不可恢复！',function(r) {
				if (r) {
					$.post(basePath + '/ncjtjc/lygl/delLy', {
						lyid: row.lyid,lybh: row.lybh
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
	} 
	
	// 报表
	function printLyRecord(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url =basePath + '/ncjtjc/lygl/printLybadj';
			var dialog = parent.sy.modalDialog({ 
				width : 800,
				height : 600,
				param : {
					lyid : row.lyid
				}, 
				url : url
			});
			/* var obj = new Object();
		    var url = basePath + '/ncjtjc/lygl/printLybadj?lyid='+row.lyid;
			var k = popwindow(url,obj,900,500);   */
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}	 	
	}
	
	
	
// 报表
	var printLyRecord1 = function() {
	var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '打印《农村流动两员备案登记表》',
				width : 870,
				height : 570,
				url : basePath + '/ncjtjc/lygl/printLybadj?lyid='+row.lyid,
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



	// 导入
	var lydrIndex = function(){		
		var dialog = parent.sy.modalDialog({
			title : '导入两员',
			iconCly : 'ext-icon-monitor',
			width : 870,
			height : 522,
			url : basePath + '/ncjtjc/lygl/lydrIndex',
			buttons : [ {
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, grid, parent.$);
				}
			} ]
		});
	} 
	
	// 上传附件
	function uploadFj(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			<%-- var obj = new Object(); 
			var retVal = popwindow("<%=contextPath %>/ncjtjc/lygl/uploadFjIndex?lyid="+row.lyid,obj,800,600); --%>
			var url = basePath+"/ncjtjc/lygl/uploadFjIndex";
			var dialog = parent.sy.modalDialog({  
				width : 800,
				height : 600,
				param : {
					lyid : row.lyid
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
		}else{
			$.messager.alert('提示', '请先选择要上传附件的记录！', 'info');
		}
	}
	// 删除附件
	function delFj(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			<%-- var obj = new Object(); 
			var retVal = popwindow("<%=contextPath %>/ncjtjc/lygl/delFjIndex?lyid="+row.lyid,obj,800,600); --%>
			var url = basePath + "/ncjtjc/lygl/delFjIndex";
			var dialog = parent.sy.modalDialog({  
				width : 800,
				height : 600,
				param : {
					lyid : row.lyid
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
		}else{
			$.messager.alert('提示', '请先选择要删除附件的记录！', 'info');
		}
	}


	//附件管理
	function uploadFuJian(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var obj = new Object();
			var v_ajdjid = row.lyid;		    
		    var v_fjlydlbh = "NCJTJCFJ";//附件参数大类编号：农村集体聚餐附件
		    var v_dmlb = "CSDJBAFJ";//附件参数小类编号：两员登记备案附件
		     var url = basePath + 
				var dialog = parent.sy.modalDialog({ 
					width : 980,
					height : 500,
					param : {
						ajdjid : v_ajdjid,
						dmlb : v_dmlb,
						fjlydlbh : v_fjlydlbh
					}, 
					url : url
				});
		   /*  var url = basePath + 'pub/pub/pubUploadFjListIndex?ajdjid='+v_ajdjid+'&dmlb='+v_dmlb+'&fjlydlbh='+v_fjlydlbh+'&time='+new Date().getMilliseconds(); 
			var k = popwindow(url,obj,900,500);  */ 
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}	 	
	}

	function printLybadj(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			getPersonPhoto(row.lyid);//zjf
			var params = "lyid=" + row.lyid;
			sy.doPrint('ncjtjc/lybadj.cpt',params);
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}
	}

	// 从数据库获取照片
	function getPersonPhoto(lyid){		
		if (lyid != null && lyid != "") {
			$.post(basePath + '/ncjtjc/lygl/getLyzp', {
				'lyid':lyid
			},
			function(result) {
				$('#lyzp').attr('src',result.fileCtxPath + "?" + Math.random());
				if(result.code=='-1'){					
					$.messager.alert('提示', result.msg, 'error');	
				}				
			},
			'json');
		}	
	}
	
	function showMenu_aaa027() {
		var url = basePath + 'jsp/pub/pub/selectAaa027.jsp'; 
		/* var obj = new Object();
		var k = popwindow(url,obj,300,400); */ 
			var dialog = parent.sy.modalDialog({  
				width : 800,
				height : 600, 
				url : url
			},function(dialogID){
				var obj = sy.getWinRet(dialogID); 
					if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
						$('#aaa027').val(k.aaa027);
						$('#aaa027name').val(k.aaa027name);
					}
				sy.removeWinRet(dialogID);
			});
	}
	
	
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
						<td style="text-align:right;"><nobr>两员姓名:</nobr></td>
						<td><input id="lyxm" name="lyxm" style="width: 200px" /></td>			
						<td style="text-align:right;"><nobr>姓名拼音码:</nobr></td>
						<td><input id="lypym" name="lypym" style="width: 200px" /></td>									
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>身份证号:</nobr></td>
						<td><input id="lysfzjhm" name="lysfzjhm" style="width: 200px" /></td>								
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
        	<sicp3:groupbox title="两员列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addLy"
								iconCls="icon-add" plain="true" onclick="addLy()">增加</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateLy"
								iconCls="icon-edit" plain="true" onclick="updateLy()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_lyglFormIndex"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showLy()">查看</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>    
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delLy"
								iconCls="icon-remove" plain="true" onclick="delLy()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_lydrIndex"
								iconCls="ext-icon-report_go" plain="true" onclick="lydrIndex()">导入两员</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<%--<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_uploadFj"--%>
								<%--iconCls="icon-upload" plain="true" onclick="uploadFuJian()()">附件管理</a>--%>
							<%--</td>   --%>
							<%--<td>--%>
								<%--<div class="datagrid-btn-separator"></div>--%>
							<%--</td>--%>
							<%--<td><a href="javascript:void(0)" class="easyui-linkbutton" --%>
								<%--iconCls="icon-print" plain="true" onclick="printLyRecord()">打印《农村流动两员备案登记表》</a>--%>
							<%--</td>--%>
							<%--<td>  --%>
								<%--<div class="datagrid-btn-separator"></div>--%>
							<%--</td>   --%>
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>