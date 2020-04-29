<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig, com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	Sysuser user = SysmanageUtil.getSysuser();
	String comid = user.getAaz001();
%>
<!DOCTYPE html>
<html>
<head>
<title>供销商管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
var mygrid;
// 企业大类
var v_comdalei = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;

$(function() {
		mygrid = $('#mygrid').datagrid({
			toolbar: '#toolbar',
			url: basePath + '/spsy/pesticide/queryPestComGxList',
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
				title : '采购物品',
				field : 'dqproname',
				hidden : false
			},{
				width : '100',
				title : '客户id',
				field : 'csid',
				hidden : true
			},{
				width : '150',
				title : '供销商名称',
				field : 'commc',
				hidden : false
			},{
				width : '80',
				title : '客户系统内外类型',
				field : 'cominoutlx',
				hidden : false,
				formatter: function(value,row,index){
					if (value=="0"){
						return "系统内";
					} else if(value=="2"){
						return "系统外";
					}
				}
			},{
				width : '120',
				title : '客户企业类别',
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
			}
			] ]
		});
});

	// 新增客户关系
	var addComgx = function() {		
		var v_comid = '<%=comid%>';
		var url = basePath + 'jsp/spsy/pesticide/addPestComGx.jsp';
		parent.sy.modalDialog({
				title : '添加',
				param : {
					comid : v_comid
				},
				width : 750,
				height : 600,
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
			var url = basePath + 'spsy/pesticide/pesticideComGxForm';
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
			$.messager.alert('提示', '请先选择要查看的供销商信息！', 'info');
		}
	}
	
	// 删除
	function delComgx() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除该供销商吗?',function(r) {
				if (r) {
					$.post(basePath + '/spsy/pesticide/delPestComgx', {
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
			$.messager.alert('提示', '请先选择要删除的供销商！', 'info');
		}
	} 
	// 查询客户关系信息
	function query() {
		var param = {
			'commc': $('#commc').val(),
			'proname':$('#proname').val()
		};
		mygrid.datagrid({
			url : basePath + '/spsy/pesticide/queryPestComGxList',
			queryParams : param
		}); 
		mygrid.datagrid('clearSelections'); 
	}
	
	function refresh(){
		window.location.href = window.location.href;
	} 
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: scroll;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>供货商名称</nobr></td>
						<td><input id="commc" name="commc" style="width: 200px"/></td>
						<td style="text-align:right;"><nobr>产品名称</nobr></td>
						<td><input id="proname" name="proname" style="width: 200px" /></td>
						<td style="text-align:center;" colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton"
							   iconCls="icon-search" onclick="query()"> 查 询 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
							   iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="供货商列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addComgx"
								iconCls="icon-add" plain="true" onclick="addComgx()">增加</a> 
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