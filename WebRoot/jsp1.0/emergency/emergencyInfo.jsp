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
<title>应急预案信息管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	// 下拉框列表
	var newscate = <%=SysmanageUtil.getNewsCateOfYjyaToJsonArray()%>;	
	var grid;
	$(function() {
		$('#cateid').combobox({
	    	data:newscate,      
	        valueField:'id',   
	        textField:'text',
	        required:false,
	        editable:false,
	        panelHeight:'auto' 
	    });

		grid = $('#grid').datagrid({
			url : basePath + '/emergency/queryEmergencysList',
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
				title: '预案编号',
				field: 'newsid',
				width : '100',
				hidden : false
			},{
				title: '预案标题',
				field: 'newstitle',
				width : '300',
				hidden : false,
				formatter: function(value,row,index) {
					if (value.length >= 20) {
						return '<a href="<%=contextPath %>/news/queryNewsDetail?newsid=' + row.newsid + '" title="' + value + '" target="_blank">' + value.substr(0, 20) + '...</a>';
					}else{
						return '<a href="<%=contextPath %>/news/queryNewsDetail?newsid=' + row.newsid + '" title="' + value + '" target="_blank">' + value + '</a>';
					}
				}
			}]],			
			columns : [ [ {
				title: '预案内容',
				field: 'newscontent',
				width: '400',
				hidden: true
			},{
				title: '预案来源',
				field: 'newsfrom',
				width: '150',
				hidden : false
			},{
				title: '是否图片预案',
				field: 'newsispicture',
				width: '100',
				hidden : false,
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
					return  sy.formatGridCode(newscate,value);
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
	// 查询预案信息
	function query() {
		var cateid = $('#cateid').combobox('getValue');
		var newstitle = $('#newstitle').val();
		var param = {
			'cateid': cateid,
			'newstitle': newstitle
		};
		$('#grid').datagrid('load', param);
		$('#grid').datagrid('clearSelections');  
	}
	// 刷新表格信息
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	function addNews() {
		<%-- var obj = new Object();
		var retVal = popwindow("<%=contextPath %>/emergency/addemergency",obj,850,650); --%>
		var url ="<%=contextPath %>/emergency/addemergency";
		var dialog = parent.sy.modalDialog({ 
				title : '添加',
				width : 850,
				height : 600, 
				url : url
			},function(dialogID){
				var retVal = sy.getWinRet(dialogID); 
					if(retVal != null){
						if(retVal.type == 'ok'){
							grid.datagrid('load');
						}
					}
				sy.removeWinRet(dialogID);
		});
	} 

	// 编辑
	function editNews(newsid) {		
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			<%-- var obj = new Object();
			var retVal = popwindow("<%=contextPath %>/emergency/editEmergency?newsid=" + row.newsid,obj,850,650); --%>
			var url = '<%=contextPath %>/emergency/editEmergency';
			var dialog = parent.sy.modalDialog({ 
				title : '编辑',
				width : 980,
				height : 600,
				param : {
					newsid : row.newsid
				},  
				url : url
			},function(dialogID){
				var retVal = sy.getWinRet(dialogID); 
					if(retVal != null){
						if(retVal.type == 'ok'){
							grid.datagrid('load');
						}
					}
				sy.removeWinRet(dialogID);
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
				$.messager.alert('警告', '该预案当前处于有效状态，不可删除！', 'warning');
				return;
			}
			$.messager.confirm('警告', '您确定要删除这条预案信息吗，这将删除对应的预案、附件，且不可恢复！',function(r) {
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
	// 附件管理
	function fjManager(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var obj = new Object();
			var v_newsid = row.newsid;	// 新闻id	    
		    var v_fjcsdlbh = "YJZHFJ"; // 附件参数大类编号：应急指挥附件
		    var v_dmlb = "YJZHFJ"; // 附件参数小类编号：应急指挥附件
		    /* var url = basePath + 'pub/pub/pubUploadFjListIndex?ajdjid='
		    	+v_newsid+'&dmlb='+v_dmlb+'&fjcsdlbh='+v_fjcsdlbh+'&time='+new Date().getMilliseconds(); 
			var k = popwindow(url,obj,900,600); */
			var url = basePath + 'pub/pub/pubUploadFjListIndex';
			var dialog = parent.sy.modalDialog({
				title : '附件管理',
				width : 900,
				height : 600,
				param : {
					ajdjid : row.newsid,
					dmlb : v_dmlb,
					fjcsdlbh : v_fjcsdlbh
				}, 
				url : url
			});
		}else{
			$.messager.alert('提示', '请先选择要上传附件的记录！', 'info');
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
						<td style="text-align:right;"><nobr>预案分类</nobr></td>
						<td><input id="cateid" name="cateid" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>预案标题</nobr></td>
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
        	<sicp3:groupbox title="预案信息列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addNews"
								iconCls="icon-add" plain="true" onclick="addNews()">增加</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_editNews"
								iconCls="icon-edit" plain="true" onclick="editNews()">编辑</a>
							</td>  
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delNews"
								iconCls="icon-remove" plain="true" onclick="delNews()">删除</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_fjManager"
								iconCls="icon-upload" plain="true" onclick="fjManager()">附件管理</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
						</tr>
					</table>
				</div>
				<div id="grid"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
		
</body>
</html>