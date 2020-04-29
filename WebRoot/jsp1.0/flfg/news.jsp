<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
			+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String catejc = StringHelper.showNull2Empty(request.getParameter("catejc"));
%>
<!DOCTYPE html>
<html>
<head>
<title>法律法规管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var catejc = '<%=catejc%>';
	//下拉框列表
	var newscate = <%=SysmanageUtil.getNewsCatetoJsonArray()%>;	
	var cbt_newcate;
	var grid;
	
	$(function() {
		cbt_newcate = $('#cateid').combotree({
			 url: basePath + '/newscate/queryNewscateTree',   
			 required: false,
	         editable: false,
	         panelHeight: 250,
	         panelWidth: 280  
		});

		grid = $('#grid').datagrid({
			//title: '法律列表',
			//iconCls: 'icon-tip',			
			url : basePath + '/news/queryNews?catejc=' + catejc,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'newsid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				title: '法律编号',
				field: 'newsid',
				width : '150',
				hidden : false
			},{
				title: '法律标题',
				field: 'newstitle',
				width : '300',
				hidden : false,
				formatter: function(value,row,index) {
					if (value.length >= 20) {
						return '<a href="<%=contextPath %>/news/queryNewsDetail?newsid=' 
							+ row.newsid + '" title="' + value + '" target="_blank">' 
							+ value.substr(0, 20) + '...</a>';
					}else{
						return '<a href="<%=contextPath %>/news/queryNewsDetail?newsid=' 
							+ row.newsid + '" title="' + value + '" target="_blank">' + value + '</a>';
					}
				}
			}]],			
			columns : [ [ {
				title: '法律内容',
				field: 'newscontent',
				width: '400',
				hidden: true
			},{
				title: '法律来源',
				field: 'newsfrom',
				width: '150',
				hidden : false
			},{
				title: '是否图片',
				field: 'newsispicture',
				width: '100',
				hidden : true,
				formatter: function(value,row,index) {
					if (value == "0") {
						return '<span style="color:red">否</span>';
					}else{
						return '<span style="color:blue">是</span>';
					}
				}
			},{
				title: '所属分类',
				field: 'cateid',
				width: '120',
				hidden : false,
				formatter : function(value,row,index){
					return '【<a href="<%=contextPath %>/news/queryNewsList?retPageStr=fl&pageSize=20&page=1&cateid=' 
						+ row.cateid + '" title="' + sy.formatGridCode(newscate,value) + '" target="_blank">' 
						+ sy.formatGridCode(newscate,value) + '</a>】';
				}
			},{
				title: '添加人',
				field: 'newsauthor',
				width: '100',
				hidden : true
			},{
				title: '添加时间',
				field: 'newstjsj',
				width: '150',
				hidden : false
			},{
				title: '是否有效',
				field: 'sfyx',
				width: '100',
				hidden : false,
				formatter: function(value,row,index) {
					if (value == "0") {
						return '<span style="color:red">无效</span>';
					}else{
						return '<span style="color:blue">有效</span>';
					}
				}
			},{
				title:'操作',
				field:'opt',
				align:'center',
				width:250,
	            formatter:function(value,row,index){
					var str = '';									
	                str += '<span style="color:blue">';
	                str += '<a href="javascript:editflfg(' 
	                	+ row.newsid + ')"><img src="<%=contextPath %>/jslib/jquery-easyui-1.3.4/themes/icons/modify.gif" align="absmiddle">修改</a>&nbsp;&nbsp;'; 
	                str += '<a href="javascript:delNews(' + row.newsid + 
	                	')"><img src="<%=contextPath %>/jslib/jquery-easyui-1.3.4/themes/icons/delete.gif" align="absmiddle">删除</a>&nbsp;&nbsp;';
	                str += '</span>';
	                return str;  
	            }   
	      	}] ],
			toolbar: '#toolbar',
			onDblClickRow: function(){//双击事件 查看、修改等操作
				var row = $('#grid').datagrid('getSelected');
				if(row){
					editNews();	
				}
			}
		});
	});
	
	function query() {
		var cateid = $('#cateid').combobox('getValue');
		var newstitle = $('#newstitle').val();
		var param = {
			'cateid': cateid,
			'newstitle': newstitle
		};
		$('#grid').datagrid('load', param);
		grid.datagrid('clearSelections'); 
	}
	
	function refresh(){
		parent.window.refresh();	
	} 
	
	// 新增
	function addflfg() {
		var url = "<%=contextPath %>/news/addFlfg";
		var dialog = parent.sy.modalDialog({
			title : '新增',
			width : 900,
			height : 720,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少
			if(obj.type == 'ok'){
				grid.datagrid('load');
			}
		});
	} 		

	// 编辑
	function editflfg(newsid) {		
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var obj = new Object();
			var url = "<%=contextPath %>/news/editflfg?newsid=" + row.newsid;
			var dialog = parent.sy.modalDialog({
				title : '编辑',
				width : 900,
				height : 720,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少
				if(obj.type == 'ok'){
					grid.datagrid('load');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的记录！', 'info');
		}
	} 

	// 删除
	function delNews(newsid) {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var sfyx = row.sfyx;
			if (sfyx == '1') {
				$.messager.alert('警告', '该法律当前处于有效状态，不可删除！', 'warning');
				return;
			}
			$.messager.confirm('警告', '您确定要删除这条记录吗，这将删除对应的法律、附件，且不可恢复！',function(r) {
				if (r) {
					$.post(basePath + '/news/delNews', {
						newsid: row.newsid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','删除成功！','info',function(){
								$('#grid').datagrid('load'); 
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

	function uploadFj(newsid){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var obj = new Object();
			var url = "<%=contextPath %>/news/uploadFjIndex?newsid="+row.newsid;
			var dialog = parent.sy.modalDialog({
				title : '上传附件',
				width : 800,
				height : 600,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少
				if(obj.type == 'ok'){
//					grid.datagrid('load');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要上传附件的记录！', 'info');
		}
	}

	function delFj(newsid){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = "<%=contextPath %>/news/delFjIndex?newsid="+row.newsid;
			var dialog = parent.sy.modalDialog({
				title : '删除附件',
				width : 800,
				height : 600,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少
				if(obj.type == 'ok'){
//					grid.datagrid('load');
				}
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
			var v_ajdjid = row.newsid;		    
		    var v_fjcsdlbh = "GGFWFJ";//附件参数大类编号：公共服务系统附件
		    var v_dmlb = "NEWSFJ";//附件参数小类编号：法律附件
		    var url = basePath + 'pub/pub/pubUploadFjListIndex?ajdjid='
		    	+v_ajdjid+'&dmlb='+v_dmlb+'&fjcsdlbh='+v_fjcsdlbh+'&time='+new Date().getMilliseconds();
			var dialog = parent.sy.modalDialog({
				title : '上传附件',
				width : 800,
				height : 600,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少
				if(obj.type == 'ok'){
//					grid.datagrid('load');
				}
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
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>法律分类</nobr></td>
						<td><input id="cateid" name="cateid" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>法律标题</nobr></td>
						<td><input id="newstitle" name="newstitle" style="width: 200px" /></td>							
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
        	<sicp3:groupbox title="法律列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-add" plain="true" onclick="addflfg()">增加</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-edit" plain="true" onclick="editflfg()">编辑</a>
							</td>  
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-remove" plain="true" onclick="delNews()">删除</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-upload" plain="true" onclick="uploadFuJian()">附件管理</a>
							</td>   
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
						</tr>
					</table>
				</div>
				<div id="grid"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
		
</body>
</html>