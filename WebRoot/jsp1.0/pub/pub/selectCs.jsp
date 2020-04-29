<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String csxm = StringHelper.showNull2Empty(request.getParameter("csxm"));
	String jcsbid = StringHelper.showNull2Empty(request.getParameter("jcsbid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>选择厨师--通用查询</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var singleSelect = sy.getUrlParam("singleSelect");
	var v_singleSelect = (singleSelect=="true");
	//下拉框列表
	var cssfzjlx = <%=SysmanageUtil.getAa10toJsonArray("AAC058")%>;
	var csxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
	var cswhcd = <%=SysmanageUtil.getAa10toJsonArray("AAC011")%>;
	var cscynx = <%=SysmanageUtil.getAa10toJsonArray("CYNX")%>;
	var csjkzm = <%=SysmanageUtil.getAa10toJsonArray("JKZM")%>;
	var cspxqk = <%=SysmanageUtil.getAa10toJsonArray("PXQK")%>;	
	var grid;
	
	$(function() {		
		grid = $('#grid').datagrid({
			//title : '厨师列表',
			//iconCcs : 'icon-tip',
			//collapsible : true,
			//toolbar : '#toolbar',
			url : basePath + '/ncjtjc/csgl/queryCs?jcsbid='+<%=jcsbid%>,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : v_singleSelect,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'csid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				field : "ck",
				checkbox : true
			},{
				width : '100',
				title : '厨师ID',
				field : 'csid',
				hidden : false			
			},{
				width : '150',
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
				title : '姓名拼音码',
				field : 'cspym',
				hidden : true
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
				title : '出生日期',
				field : 'cscsrq',
				hidden : false
			},{
				width : '200',
				title : '身份证件类型',
				field : 'cssfzjlx',
				hidden : true,
				formatter : function(value, row) {
					return sy.formatGridCode(cssfzjlx,value);
				}
			},{
				width : '150',
				title : '身份证号',
				field : 'cssfzjhm',
				hidden : false
			},{
				width : '100',
				title : '手机号',
				field : 'cssjh',
				hidden : false
			},{
				width : '100',
				title : '文化程度',
				field : 'cswhcd',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(cswhcd,value);
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
				width : '150',
				title : '健康证有效期',
				field : 'csjkzyxq',
				hidden : false
			},{
				width : '100',
				title : '培训情况',
				field : 'cspxqk',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(cspxqk,value);
				}
			},{
				width : '150',
				title : '培训合格证有效期',
				field : 'cspxhgzyxq',
				hidden : false
			},{
				width : '150',
				title : '服务区域',
				field : 'csfwqy',
				hidden : false
			},{
				width : '150',
				title : '邮箱',
				field : 'csyx',
				hidden : false
			},{
				width : '150',
				title : 'QQ号',
				field : 'csqq',
				hidden : false
			},{
				width : '150',
				title : '微信号',
				field : 'cswx',
				hidden : false
			},{
				width : '200',
				title : '备注',
				field : 'aae013',
				hidden : false
			} ] ]
		});
	});

	// 查询
	function query() {
		var csxm = $('#csxm').val();
		var jcsbid = "<%=jcsbid%>";
		var param = {
			'csxm': csxm,
			'jcsbid':jcsbid
		};
		grid.datagrid({
			url : basePath + '/ncjtjc/csgl/queryCs',
			queryParams : param
		});
		grid.datagrid('clearSelections'); 
	}	

	//重置
	var reset2 = function() {
		$('#fm').form('clear');
		grid.datagrid('loadData',{total:0,rows:[]}); 			
	};

	//选择数据返回
	var getDataInfo = function(){
		var row = grid.datagrid('getSelections');   
	    if(row){
			sy.setWinRet(rows);
			parent.$("#"+sy.getDialogId()).dialog("close");
	    }else{
	        $.messager.alert('提示','请先选择数据!','info');
	    }
	}; 

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
        	<form id="fm"  method="post" >
	        	<sicp3:groupbox title="查询条件">
	        		<table class="table" style="width: 99%;">
						<tr>
							<td style="text-align:right;"><nobr>厨师姓名：</nobr></td>
							<td><input id="csxm" name="csxm" style="width: 200px"/></td>						
							<td style="text-align:right;"><nobr>所属机构：</nobr></td>
							<td><input id="orgid" name="orgid" style="width: 200px"/></td>			
						</tr>
						<tr>				
							<td colspan="4" style="text-align:right;">
								<a href="javascript:void(0)" class="easyui-linkbutton"
									iconCls="icon-search" onclick="query()"> 查 询 </a>
									&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="javascript:void(0)" class="easyui-linkbutton"
									iconCls="icon-reload" onclick="reset2()"> 重 置 </a>
									&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="javascript:void(0)" class="easyui-linkbutton" 
									iconCls="icon-ok" onclick="getDataInfo()">确 定</a>
							</td>
						</tr>
					</table>
		        </sicp3:groupbox>
	        	<sicp3:groupbox title="厨师列表">	        	
					<div id="grid"></div>
		        </sicp3:groupbox>	
			</form>
        </div>        
    </div>    
</body>
</html>