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

<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
var mygrid;

$(function() {
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/zdhd/queryZdhddj',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			btn_shoulihuitui
		    idField: 'ajdjid', //该列是一个唯一列
		    sortOrder: 'asc',	
			columns : [ [
	        {
				width : '100',
				title : '重大活动登记表ID',
				field : 'zdhddjid',
				hidden : true
			},{
				width : '100',
				title : '企业id',
				field : 'comid',
				hidden : true
			},{
				width : '200',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '90',
				title : '企业联系人',
				field : 'zdhdlxr',
				hidden : false
			},{
				width : '80',
				title : '企业联系电话',
				field : 'zdhdlxdh',
				hidden : false
			},{
				width : '200',
				title : '重大活动名称',
				field : 'zdhdmc',
				hidden : false
			} ,{
				width : '130',
				title : '承接重大活动开始时间',
				field : 'zdhdkssj',
				hidden : false
			} ,{
				width : '130',
				title : '承接重大活动结束时间',
				field : 'zdhdjssj',
				hidden : false
			},{
				width : '130',
				title : '重大活动检查开始时间',
				field : 'zdhdjckssj',
				hidden : false
			},{
				width : '120',
				title : '重大活动检查人员表',
				field : 'zdhdjcryidliststr',
				hidden : false
			},{
				width : '150',
				title : '重大活动地点',
				field : 'zdhddd',
				hidden : false
			},{
				width : '80',
				title : '重大活动备注',
				field : 'zdhdbeizhu',
				hidden : false
			},{
				width : '90',
				title : '操作员',
				field : 'aae011',
				hidden : false
			},{
				width : '130',
				title : '操作时间',
				field : 'aae036',
				hidden : false
			},{
				width : '60',
				title : '地区编码',
				field : 'aaa027',
				hidden : true
			}  
			] ]
		});
});

// 新增
var addZdhddj = function() {	
	var url='<%=basePath%>zdhd/zdhddjFormIndex';	
	var dialog = parent.sy.modalDialog({
		title : '新增页面',
		width : 900,
		height :380,
		url : url
	},function (dialogID){
		var obj = sy.getWinRet(dialogID);//不可缺少
		if (obj!=null && "ok"==obj){
		$("#mygrid").datagrid("reload");
	}
	sy.removeWinRet(dialogID);//不可缺少	
	});	
};

//从单位信息表中读取
function myselectcom(){
	var url = "<%=basePath%>pub/pub/selectcomIndex";
		var dialog = parent.sy.modalDialog({
		title : '选择企业',
		param : {
		a : new Date().getMilliseconds(),
		singleSelect:"true",
		},
		width : 800,
		height : 600,
		url : url
		},function (dialogID){
		var obj = sy.getWinRet(dialogID);//不可缺少
		if (obj!=null && obj.length>0){
		 for (var k=0;k<=obj.length-1;k++){
		 var myrow=obj[k];
	      $("#commc").val(myrow.commc); //公司名称   
	      $("#comid").val(myrow.comid); //公司代码 
	 }
	}
	sy.removeWinRet(dialogID);//不可缺少	
	})
}

function query() {
	var param = {
		'comid': $('#comid').val(),
		'commc': $('#commc').val(),
		'aae036start':$('#aae036start').datetimebox('getValue'),
		'aae036end':$('#aae036end').datetimebox('getValue')
	};
	mygrid.datagrid({
		url : basePath + '/zdhd/queryZdhddj',			
		queryParams : param
	});
	mygrid.datagrid('clearSelections'); 
}

function refresh(){
	parent.window.refresh();	
} 

// 编辑
function updateZdhddj() {
	var row = $('#mygrid').datagrid('getSelected');
	var url='<%=basePath%>zdhd/zdhddjFormIndex';
	if (row) {
		var dialog = parent.sy.modalDialog({
		title : '编辑',
		param : {
		a : new Date().getMilliseconds(),
		zdhddjid : row.zdhddjid
		},
		width : 900,
		height : 380,
		url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			if (obj!=null && "ok"==obj){
			$("#mygrid").datagrid("reload");
		}
		sy.removeWinRet(dialogID);//不可缺少	
		})
	}else{
		$.messager.alert('提示', '请先选择要修改的登记信息！', 'info');
	}
};

// 查看
function showZdhddj() {
	var row = $('#mygrid').datagrid('getSelected');
	var url='<%=basePath%>zdhd/zdhddjFormIndex';
	if (row) {
		var dialog = parent.sy.modalDialog({
		title : '查看',
		param : {
		zdhddjid : row.zdhddjid,
		op:"view",
		},
		width : 900,
		height : 380,
		url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			if (obj!=null && "ok"==obj){
			//$("#mygrid").datagrid("reload");
		}
		sy.removeWinRet(dialogID);//不可缺少	
		})
	}else{
		$.messager.alert('提示', '请先选择要查看的登记信息！', 'info');
	}
};

// 删除
function delZdhddj() {
	var row = $('#mygrid').datagrid('getSelected');
	if (row) {
		$.messager.confirm('警告', '您确定要删除该用户吗?',function(r) {
			if (r) {
				$.post(basePath + '/zdhd/delZdhddj', {
					zdhddjid: row.zdhddjid
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
		$.messager.alert('提示', '请先选择要删除的重大活动登记记录！', 'info');
	}
}; 

//执行检查
var checkhis=function(){
   var row = $('#mygrid').datagrid('getSelected'); 
   if(row){
     var dialog =  parent.sy.modalDialog({
		title : '现场检查',
		width : 870,
		height : 460,
		url : basePath + 'aqgl/jclsIndex?planid='+row.planid+'&comid='+row.comid+'&aaa027='+row.aaa027+'&qtbwid='+row.zdhddjid+'&checkdatakind=3',
		buttons : [ {
			text : '取消',
			handler : function() {
				dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
			}
		} ]
	});
	}else{
		$.messager.alert('提示', '请先选择要检查的信息！', 'info');
	}
};

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>企业编号</nobr></td>
						<td><input id="comid" name="comid" style="width: 200px"/>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectcom()">选择企业 </a>						
						</td>						
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="commc" name="commc" style="width:200px" /></td>	
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>登记开始时间:</nobr></td>
						<td><input id="aae036start" name="aae036start" style="width: 200px" class="easyui-datetimebox"  data-options="required:true"/></td>
						<td style="text-align:right;"><nobr>登记结束时间:</nobr></td>
						<td><input id="aae036end" name="aae036end" style="width: 200px" class="easyui-datetimebox"  data-options="required:true"/></td>
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
        	<sicp3:groupbox title="重大活动登记列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addZdhddj"
								iconCls="icon-add" plain="true" onclick="checkhis()">执行检查</a> 
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