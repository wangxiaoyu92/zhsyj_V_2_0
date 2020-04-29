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
<title>厨师星级考评</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var cssfzjlx = <%=SysmanageUtil.getAa10toJsonArray("AAC058")%>;
	var csxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
	var cswhcd = <%=SysmanageUtil.getAa10toJsonArray("AAC011")%>;
	var cscynx = <%=SysmanageUtil.getAa10toJsonArray("CYNX")%>;
	var csjkzm = <%=SysmanageUtil.getAa10toJsonArray("JKZM")%>;
	var cspxqk = <%=SysmanageUtil.getAa10toJsonArray("PXQK")%>;
	var cb_cssfzjlx;
	var cb_csxb;
	var cb_cswhcd;
	var cb_cscynx;
	var cb_csjkzm;
	var cb_cspxqk;
	var grid;
	
	$(function() {
		cb_cssfzjlx = $('#cssfzjlx').combobox({
	    	data : cssfzjlx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
		cb_csxb = $('#csxb').combobox({
	    	data : csxb,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_cswhcd = $('#cswhcd').combobox({
	    	data : cswhcd,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : '200' 
	    });
		cb_cscynx = $('#cscynx').combobox({
	    	data : cscynx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_csjkzm = $('#csjkzm').combobox({
	    	data : csjkzm,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_cspxqk = $('#cspxqk').combobox({
	    	data : cspxqk,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    
		grid = $('#grid').datagrid({
			//title : '厨师列表',
			//iconCcs : 'icon-tip',
			//collapsible : true,
			toolbar : '#toolbar',
			url : basePath + '/ncjtjc/csgl/queryCs',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'csid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '50',
				title : '厨师ID',
				field : 'csid',
				hidden : false
			},{
				width : '100',
				title : '厨师编号',
				field : 'csbh',
				hidden : false
			},{
				width : '100',
				title : '姓名',
				field : 'csxm',
				hidden : false
			}]],				
			columns : [ [ {
				width : '100',
				title : '手机号',
				field : 'cssjh',
				hidden : false
			},{
				width : '50',
				title : '年度',
				field : 'khnd',
				hidden : false,
				formatter : function(value, row) {
					return '2016';										
				}
			},{
				width : '50',
				title : '1月',
				field : 'khy1',
				hidden : false,
				formatter : function(value, row) {
					return '<img src="<%=contextPath%>/images/frame/award_star_gold_1.png" />';										
				}
			},{
				width : '50',
				title : '2月',
				field : 'khy2',
				hidden : false,
				formatter : function(value, row) {
					return '<img src="<%=contextPath%>/images/frame/award_star_gold_1.png" />';										
				}
			},{
				width : '50',
				title : '3月',
				field : 'khy3',
				hidden : false,
				formatter : function(value, row) {
					return '<img src="<%=contextPath%>/images/frame/award_star_gold_1.png" />';										
				}
			},{
				width : '50',
				title : '4月',
				field : 'khy4',
				hidden : false,
				formatter : function(value, row) {
					return '<img src="<%=contextPath%>/images/frame/award_star_gold_1.png" />';										
				}
			},{
				width : '50',
				title : '5月',
				field : 'khy5',
				hidden : false,
				formatter : function(value, row) {
					return '<img src="<%=contextPath%>/images/frame/award_star_gold_1.png" />';										
				}
			},{
				width : '50',
				title : '6月',
				field : 'khy6',
				hidden : false,
				formatter : function(value, row) {
					return '<img src="<%=contextPath%>/images/frame/award_star_gold_1.png" />';										
				}
			},{
				width : '50',
				title : '7月',
				field : 'khy7',
				hidden : false,
				formatter : function(value, row) {
					return '<img src="<%=contextPath%>/images/frame/award_star_gold_1.png" />';										
				}
			},{
				width : '50',
				title : '8月',
				field : 'khy8',
				hidden : false,
				formatter : function(value, row) {
					return '<img src="<%=contextPath%>/images/frame/award_star_gold_1.png" />';										
				}
			},{
				width : '50',
				title : '9月',
				field : 'khy9',
				hidden : false,
				formatter : function(value, row) {
					return '<img src="<%=contextPath%>/images/frame/award_star_gold_1.png" />';										
				}
			},{
				width : '50',
				title : '10月',
				field : 'khy10',
				hidden : false,
				formatter : function(value, row) {
					return '<img src="<%=contextPath%>/images/frame/award_star_gold_1.png" />';										
				}
			},{
				width : '50',
				title : '11月',
				field : 'khy11',
				hidden : false
			},{
				width : '50',
				title : '12月',
				field : 'khy12',
				hidden : false
			},{
				width : '150',
				title : '备注',
				field : 'aae013',
				hidden : false
			} ] ]
		});
	});

	// 查询
	function query() {
		var csxm = $('#csxm').val();
		var cspym = $('#cspym').val();
		var cssfzjhm = $('#cssfzjhm').val();
		var param = {
			'csxm': csxm,
			'cspym': cspym,
			'cssfzjhm': cssfzjhm
		};
		$('#grid').datagrid('reload', param);
		grid.datagrid('clearSelections');
	}

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 

	// 厨师量化考核
	function addCslhkh() {
		$.messager.alert('提示', '月底自动星级考评，请勿操作!', 'warning');
	} 
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>											
						<td style="text-align:right;"><nobr>厨师姓名:</nobr></td>
						<td><input id="csxm" name="csxm" style="width: 200px" /></td>			
						<td style="text-align:right;"><nobr>姓名拼音码:</nobr></td>
						<td><input id="cspym" name="cspym" style="width: 200px" /></td>									
						<td style="text-align:right;"><nobr>身份证号:</nobr></td>
						<td><input id="cssfzjhm" name="cssfzjhm" style="width: 200px" /></td>								
					</tr>
					<tr>
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
        	<sicp3:groupbox title="星级考评列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addCs"
								iconCls="ext-icon-award_star_bronze_1" plain="true" onclick="addCslhkh()">星级考评</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
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