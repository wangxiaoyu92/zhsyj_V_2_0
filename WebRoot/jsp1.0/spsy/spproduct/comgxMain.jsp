<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	Sysuser user = SysmanageUtil.getSysuser();
	//gu20170507 String userid = user.getUserid();
	String userid = user.getAaz001();
%>
<!DOCTYPE html>
<html>
<head>
<title>客户关系</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
var mygrid;
var A_comdalei; // 企业大类
var A_prozl; // 产品种类
var A_comgxlx; // 公司供销类型
// 企业大类
var v_comdalei = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
// 产品种类
var v_prozl = <%=SysmanageUtil.getAa10toJsonArray("PROZL")%>;
// 公司供销类型
var v_comgxlx = <%=SysmanageUtil.getAa10toJsonArray("COMGXLX")%>;

$(function() {
		// 企业大类
	    A_comdalei = $('#comdalei').combobox({
	    	data : v_comdalei,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    // 产品种类
	    A_prozl = $('#prozl').combobox({
	    	data : v_prozl,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });	
	    // 公司供销类型
	    A_comgxlx = $('#comgxlx').combobox({
	    	data : v_comgxlx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
		mygrid = $('#mygrid').datagrid({
			toolbar: '#toolbar',
			url: basePath + '/spsy/spproduct/queryComList',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'gxid', //该列是一个唯一列
		    sortOrder: 'asc',	
			columns : [ [
	        {
				width : '100',
				title : '客户关系ID',
				field : 'gxid',
				hidden : true
			},{
				width : '100',
				title : '用户id',
				field : 'comid',
				hidden : true
			},{
				width : '150',
				title : '本企业名称',
				field : 'dqcommc',
				hidden : false
			},{
				width : '100',
				title : '本企业商品或原材料',
				field : 'dqproname',
				hidden : false
			},{
				width : '80',
				title : '类型',
				field : 'dqcphyclbz',
				hidden : false,
				formatter: function(value,row,index){
	  				if (value=="1"){
	  					return "产品"; 
	  				} else if(value=="2"){
	  					return "材料";
	  				}
	  			}
			},{
				width : '100',
				title : '客户id',
				field : 'csid',
				hidden : true
			},{
				width : '150',
				title : '客户企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '100',
				title : '客户商品或原材料',
				field : 'proname',
				hidden : false
			},{
				width : '80',
				title : '客户供销类型',
				field : 'comgxlx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_comgxlx,value);
				}
			},{
				width : '80',
				title : '包装规格',
				field : 'probzgg',
				hidden : false
			},{
				width : '80',
				title : '规格型号',
				field : 'progg',
				hidden : false
			},{
				width : '120',
				title : '客户企业类型',
				field : 'comdalei',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_comdalei, value);
				}
			},{
				width : '200',
				title : '客户企业地址',
				field : 'comdz',
				hidden : false
			},{
				width : '80',
				title : '客户企业法人',
				field : 'comfrhyz',
				hidden : false
			},{
				width : '80',
				title : '联系电话',
				field : 'comyddh',
				hidden : false
			} ,{
				width : '120',
				title : '客户关系建立时间',
				field : 'comgxtime',
				hidden : false
			},{
				width : '100',
				title : '产品种类',
				field : 'prozl',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_prozl,value);
				}
			}
			] ]
		});
});

	// 新增客户关系
	var addComgx = function() {		
		var v_comid = '<%=userid%>';	
		var url = basePath + 'jsp/spsy/spproduct/addcomgx.jsp';
		var dialog = parent.sy.modalDialog({
				title : '添加',
				param : {
					comid : v_comid
				},
				width : 950,
				height : 500,
				url : url
		}, closeModalDialogCallback);
	};
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
			$('#mygrid').datagrid('reload'); 
		}
		sy.removeWinRet(dialogID);//不可缺少		
	}
	
	// 查看
	function showComProducts() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var url = basePath + 'spsy/spproduct/showComProductsIndex';
			var dialog = parent.sy.modalDialog({
					title : '查看',
					param : {
						comid : row.csid,
						gxid : row.gxid
					},
					width : 900,
					height : 400,
					url : url
			}); 
		}else{
			$.messager.alert('提示', '请先选择要查看的客户关系信息！', 'info');
		}
	};
	
	// 删除
	function delComgx() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除该客户关系吗?',function(r) {
				if (r) {
					$.post(basePath + '/spsy/spproduct/delComgx', {
						gxid: row.gxid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#mygrid').datagrid('reload'); 
			        		});    	
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的案件登记记录！', 'info');
		}
	} 
	// 查询客户关系信息
	function query() {
		var param = {
			'commc': $('#commc').val(),
			'proname':$('#proname').val(),
			'comgxlx':$('#comgxlx').combobox('getValue'),
			'comdalei':$('#comdalei').combobox('getValue')
		};
		mygrid.datagrid({
			url : basePath + '/spsy/spproduct/queryComList',			
			queryParams : param
		}); 
		mygrid.datagrid('clearSelections'); 
	}
	
	function refresh(){
		parent.window.refresh();	
	} 
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>客户名称</nobr></td>
						<td><input id="commc" name="commc" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>供销类型</nobr></td>
						<td><input id="comgxlx" name="comgxlx" style="width:200px" /></td>	
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>产品名称</nobr></td>
						<td><input id="proname" name="proname" style="width: 200px" /></td>
						<td style="text-align:right;"><nobr>企业类型</nobr></td>
						<td><input id="comdalei" name="comdalei" style="width: 200px" /></td>
					</tr>
					<tr>
						<td style="text-align:center;" colspan="4">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="客户信息列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addComgx"
								iconCls="icon-add" plain="true" onclick="addComgx()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showComProducts"
								iconCls="ext-icon-application_form_magnify" plain="true" onclick="showComProducts()">查看</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delComgx"
								iconCls="icon-remove" plain="true" onclick="delComgx()">删除</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 																																													
						</tr>
					</table>
				</div>
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>
        </form>         
    </div>   
</body>
</html>