<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser"%>

<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	//商品数据类型aaa100=spsjlx0商品1生产企业产品2生产企业原材料*/
	String v_spsjlx = StringHelper.showNull2Empty(request.getParameter("spsjlx"));//商品数据类型
	if (v_spsjlx==null || "".equals(v_spsjlx)){
		v_spsjlx="0";
	}
	String v_spsjlxmc="商品";
	if ("1".equals(v_spsjlx)){
		v_spsjlxmc="产品";
	}else if ("2".equals(v_spsjlx)){
		v_spsjlxmc="原材料";
	}
	Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
	String v_userid = vSysUser.getUserid();	
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//检测样品类别
	var jcyplb= <%=SysmanageUtil.getAa10toJsonArray("JCYPLB")%>;
	var jcypgl= <%=SysmanageUtil.getAa10toJsonArray("JCYPGL")%>;
	
	var grid;
	var v_jcyplb;
	$(function(){
		//检测样品类别
		v_jcyplb = $('#jcyplb').combobox({
	    	data : jcyplb,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 180,
	        panelWidth:180  
	    });
		grid=$("#grid").datagrid({
			//title: '检验检测样品',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + 'jyjc/queryJyjcyp?spsjlx=<%=v_spsjlx%>',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 40 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcypid', //该列是一个唯一列
		    sortOrder: 'asc',
		    columns :[[ {
				width : '100',
				title : '检测样品ID',
				field : 'jcypid',
				hidden : true
			},{
				width : '110',
				title : '类别',
				field : 'jcyplb',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(jcyplb,value);
				}
			},{
				width : '40',
				title : '操作员id',
				field : 'userid',
				hidden : true
			},{
				width : '150',
				title : '名称',
				field : 'jcypmc',
				hidden : false
			},{
				width : '100',
				title : '归类',
				field : 'jcypgl',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(jcypgl,value);
				}				
			},{
				width : '90',
				title : '所属品牌',
				field : 'jcypsspp',
				hidden : false
			},{
				width : '60',
				title : '规格',
				field : 'impcpgg',
				hidden : false
			},{
				width : '100',
				title : '商标',
				field : 'spsb',
				hidden : false
			},{
				width : '100',
				title : '规格型号',
				field : 'spggxh',
				hidden : false
			},{
				width : '100',
				title : '计量单位',
				field : 'spjldw',
				hidden : false
			},{
				width : '150',
				title : '执行标准号',
				field : 'spzxbzh',
				hidden : false
			},{
				width : '100',
				title : '保质期',
				field : 'spbzq',
				hidden : false
			},{
				width : '100',
				title : '操作员',
				field : 'jcypczy',
				hidden : false
			},{
				width : '100',
				title : '操作时间',
				field : 'jcypczsj',
				hidden : false
			}
			] ]
		});
	});///////////////////////////////////
	
	//查询检验检测样品
	function query() {
		var param = {
			'jcyplb': $('#jcyplb').combobox('getValue'),
			'jcypmc':$('#jcypmc').val(),
			'jcypczy': $('#jcypczy').val(),
			'spsjlx':'<%=v_spsjlx%>'
		};
		grid.datagrid({
			url : basePath + 'jyjc/queryJyjcyp',			
			queryParams : param
		});
		grid.datagrid('clearSelections'); 
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	//新增检验检测样品
	var addJyjcyp = function() {
		var dialog = parent.sy.modalDialog({
			title : '窗体',
			width : 600,
			height : 450,
			url : basePath + 'jyjc/jyjcypFormIndexEasyui?op=add&spsjlx=<%=v_spsjlx%>',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.saveJyjcyp(dialog, grid, parent.$);
					//grid.datagrid('reload');
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};

	//编辑检验检测样品
	var updateJyjcyp = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
<%-- 			if (row.userid!='<%=v_userid%>'){
				alert('不是自己添加的商品不能编辑，商品信息是公用的');
				return false;
			} --%>
			var dialog = parent.sy.modalDialog({
				title:'',
				width:600,
				height:450,
				url:basePath + 'jyjc/jyjcypFormIndexEasyui?op=edit&spsjlx=<%=v_spsjlx%>&jcypid='+row.jcypid,
				buttons:[{
					text : '确定',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.saveJyjcyp(dialog,grid,parent.$);
					}
				},{
					text : '取消',
					handler : function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要修改的检验检测样品信息！','info');
		}
	}
	
	// 删除检验检测样品信息
	function delJyjcyp() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			if (row.userid!='<%=v_userid%>'){
				alert('不是自己添加的商品不能删除，商品信息是公用的');
				return false;
			}			
			var jcypid = row.jcypid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?该操作将不可恢复',function(r) {
				if (r) {
					$.post(basePath + 'jyjc/delJyjcyp', {
						jcypid: jcypid
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
			$.messager.alert('提示', '请先选择要删除的检验检测样品信息！', 'info');
		}
	}  	
	
	//查看检验检测样品
	var showJyjcyp = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '',
				width :600,
				height :450,
				url : basePath +'jyjc/jyjcypFormIndexEasyui?op=view&jcypid='+row.jcypid,
				buttons : [{
					text : '关闭',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要查看的信息！','info');
		}
	}
	
/* 	//打印
	function print(){	 
		sy.doPrint('siweb/sysuser.cpt','')
	}  */	
	
	// 关闭窗口
	var closeWindow = function($dialog){
    	$dialog.dialog('close');
	};
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr><%=v_spsjlxmc%>类别</nobr></td>
						<td><input id="jcyplb" name="jcyplb" style="width: 200px"/>
						</td>						
						<td style="text-align:right;"><nobr><%=v_spsjlxmc%>名称</nobr></td>
						<td><input id="jcypmc" name="jcypmc" style="width: 200px" />
						</td>								
					</tr>
					<tr><td style="text-align:right;"><nobr>操作员</nobr></td>
						<td><input id="jcypczy" name="jcypczy" style="width: 200px"/></td>					
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
        	<sicp3:groupbox title="<%=v_spsjlxmc%>">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveJyjcyp"
								iconCls="icon-add" plain="true" onclick="addJyjcyp()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveJyjcyp"
								iconCls="icon-edit" plain="true" onclick="updateJyjcyp()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delJyjcyp"
								iconCls="icon-remove" plain="true" onclick="delJyjcyp()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_jyjcypFormIndex"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showJyjcyp()">查看</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<!-- <td><a href="javascript:void(0)" class="easyui-linkbutton" 
								iconCls="icon-print" plain="true" onclick="print()">打印</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>    -->
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>