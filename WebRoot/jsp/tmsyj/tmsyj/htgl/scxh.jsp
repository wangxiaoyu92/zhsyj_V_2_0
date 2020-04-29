<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>
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
<title>生产销货管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
//食品计量单位
var v_spjldw = <%=SysmanageUtil.getAa10toJsonArray("SPJLDW")%>;
//食品生产检验结论
var v_cpscjyjl = <%=SysmanageUtil.getAa10toJsonArray("CPSCJYJL")%>;
	var mygrid;
	$(function() {
		   mygrid = $('#mygrid').datagrid({
			//title: '进货主表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url : basePath + '/tmsyjhtgl/queryScxh',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'hscxhbid', //该列是一个唯一列
		    nowrap:false,	
		    onLoadSuccess:function(data){
		    	mygrid.datagrid("unselectAll"); 
		    },
			columns : [ [
	        {
				width : '100',
				title : '生产销货表id',
				field : 'hscxhbid',
				hidden : true
			},{
				width : '100',
				title : '生产批次表id',
				field : 'hscpcbid',
				hidden : true
			},{
				width : '100',
				title : '监管主体表id',
				field : 'hviewjgztid',
				hidden : true
			},{
				width : '200',
				title : '经销商',
				field : 'jgztmc',
				hidden : false
			},{
				width : '120',
				title : '产品id',
				field : 'jcypid',
				hidden : true
			},{
				width : '150',
				title : '产品名称',
				field : 'jcypmc'
			},{
				width : '100',
				title : '经销商id',
				field : 'jxsid',
				hidden : true
			},{
				width : '100',
				title : '销售时间',
				field : 'xssj'
			},{
				width : '100',
				title : '销售数量',
				field : 'xssl'
			},{
				width : '70',
				title : '计量单位',
				field : 'xhspjldw',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_spjldw,value);
				}				
			},{
				width : '120',
				title : '操作员',
				field : 'aae011',
				hidden : false				
			},{
				width : '130',
				title : '操作时间',
				field : 'aae036',
				hidden : false				
			}					
			]],
			toolbar: '#toolbar'
		});
	});/////////////////////////////////////////
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	// 新增
	function addScxh() {
		var dialog = parent.sy.modalDialog({
			title : '新增生产销货',
			width : 800,
			height : 550,
			url : basePath + 'tmsyjhtgl/scxhFormIndex?op=add',
			buttons : [{
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mygrid, parent.$);
				}
			},{
				text : '关闭',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	} 
	
	// 编辑
	function editScxh() {
		var row = $('#mygrid').datagrid('getSelected');
		if(row){
			var v_hscxhbid=row.hscxhbid;
			var dialog = parent.sy.modalDialog({
				title : '编辑生产销货',
				width : 800,
				height : 550,
				url : basePath + 'tmsyjhtgl/scxhFormIndex?op=edit&hscxhbid='+v_hscxhbid,
				buttons : [{
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mygrid, parent.$);
					}
				},{
					text : '关闭',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
			
		}else{
			$.messager.alert('提示','请先选择要修改的进货信息！','info');
		}
	} 
	
	// 查看
	function viewScxh() {
		var row = $('#mygrid').datagrid('getSelected');
		if(row){
			var v_hscxhbid=row.hscxhbid;
			var dialog = parent.sy.modalDialog({
				title : '查看生产销货',
				width : 800,
				height : 550,
				url : basePath + 'tmsyjhtgl/scxhFormIndex?op=view&hscxhbid='+v_hscxhbid,
				buttons : [{
					text : '关闭',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
			
		}else{
			$.messager.alert('提示','请先选择要查看的进货信息！','info');
		}
	} 	
	
	// 删除
	function delScxh() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var v_hscxhbid = row.hscxhbid;
			$.messager.confirm('警告', '您确定要删除该条记录吗?',function(r) {
				if (r) {
					$.post(basePath + 'tmsyjhtgl/delScxh', 
					{hscxhbid: v_hscxhbid},
					function(result){
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
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	} 	
	
	// 查询企业信息
	function myquery() {
		var param = {
			'aae036start': $('#aae036start').datebox('getValue'),
			'aae036end': $('#aae036end').datebox('getValue')
		};
		mygrid.datagrid({
			url : basePath + '/tmsyjhtgl/queryScxh',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections');
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
						<td style="text-align:right;"><nobr>入库起始时间</nobr></td>
						<td><input id="aae036start" name="aae036start" style="width: 200px" 
						   class="easyui-datebox"/></td>	
						<td style="text-align:right;"><nobr>入库结束时间</nobr></td>
						<td><input id="aae036end" name="aae036end" style="width: 200px" 
						   class="easyui-datebox"/></td>		
						
						<td colspan="2" style="text-align: right">						  
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myquery()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>						   	
						</td>						
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="进货列表">
	        <div id="toolbar">
	        		<table>
						<tr>
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" 
							    data=""
								iconCls="icon-add" plain="true" onclick="addScxh()">新增</a> 
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-edit" plain="true" onclick="editScxh()">编辑</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="ext-icon-report_magnify" plain="true" onclick="viewScxh()">查看</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td>			
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-remove" plain="true" onclick="delScxh()">删除</a>
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