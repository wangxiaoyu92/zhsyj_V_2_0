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
<%
	String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));  //企业id
	String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
%>
<!DOCTYPE html>
<html>
<head>
<title>企业信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">

	// 资质证明
	var comzzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;
	var v_spjldw= <%=SysmanageUtil.getAa10toJsonArray("SPJLDW")%>;
	var v_jcfs= <%=SysmanageUtil.getAa10toJsonArray("JCFS")%>;
	var v_jchhgzmlx=<%=SysmanageUtil.getAa10toJsonArray("JCHHGZMLX")%>;
	var v_jchscjyjl=<%=SysmanageUtil.getAa10toJsonArray("JCHSCJYJL")%>;
	var v_jchqycyjl=<%=SysmanageUtil.getAa10toJsonArray("JCHQYCYJL")%>;
	

	var cb_comzzzm; // 资质证明
	var mygrid;
	$(function() {
		   mygrid = $('#mygrid').datagrid({
			//title: '进货主表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			//url: basePath + '/lhfj/queryLhfjcx',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'hjchzid', //该列是一个唯一列
		    nowrap:false,	
		    onLoadSuccess:function(data){
		    	mygrid.datagrid("unselectAll"); 
		    },
			columns : [ [
	        {
				width : '100',
				title : '进出货主表id',
				field : 'hjchzid',
				hidden : true
			},{
				width : '100',
				title : '商品id',
				field : 'jcypid',
				hidden : true
			},{
				width : '130',
				title : '商品名称',
				field : 'jcypmc',
				hidden : false
			},{
				width : '80',
				title : '进出货数量',
				field : 'jchsl',
				hidden : false
			},{
				width : '120',
				title : '进出货计量单位',
				field : 'spjldw',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_spjldw,value);
				}				
			},{
				width : '100',
				title : '生产地',
				field : 'jchscd',
				hidden : false
			},{
				width : '100',
				title : '上级分销id',
				field : 'jchsjfxid',
				hidden : true
			},{
				width : '70',
				title : '检测方式',
				field : 'jcfs',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jcfs,value);
				}					
			},{
				width : '60',
				title : '单价',
				field : 'jcypprice',
				hidden : false
			},{
				width : '100',
				title : '生产日期',
				field : 'jchscrq',
				hidden : false
			},{
				width : '100',
				title : '生产批次码',
				field : 'jchscpcm',
				hidden : false
			},{
				width : '100',
				title : '生产批次码',
				field : 'jchscpcm',
				hidden : false
			},{
				width : '100',
				title : '合格证明类型',
				field : 'jchhgzmlx',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jchhgzmlx,value);
				}					
			},{
				width : '100',
				title : '生产检验结论',
				field : 'jchscjyjl',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jchscjyjl,value);
				}						
			},{
				width : '100',
				title : '企业查验结论',
				field : 'jchqycyjl',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jchqycyjl,value);
				}					
			},{
				width : '100',
				title : '供应商id',
				field : 'jchgysid',
				hidden : true
			},{
				width : '100',
				title : '供应商',
				field : 'jchgysmc',
				hidden : false
			},{
				width : '100',
				title : '生产商id',
				field : 'jchscsid',
				hidden : true
			},{
				width : '100',
				title : '生产商',
				field : 'jchscsmc',
				hidden : false
			},{
				width : '100',
				title : '商品条码',
				field : 'jchsptm',
				hidden : false
			},{
				width : '100',
				title : '监管主体表id',
				field : 'hviewjgztid',
				hidden : true
			},{
				width : '100',
				title : '进出货类型',
				field : 'jchlx',
				hidden : true
			},{
				width : '100',
				title : 'e票通编号',
				field : 'eptbh',
				hidden : false
			},{
				width : '60',
				title : '操作员',
				field : 'aae011',
				hidden : false
			},{
				width : '100',
				title : '操作时间',
				field : 'aae036',
				hidden : false
			}						
			]],
			toolbar: '#toolbar'
		});
		
		if('<%=op%>' == 'view'){	
			$("#mytab tr td[name='btntd']").hide();
		}	
		
	});/////////////////////////////////////////
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	// 新增
	function addJinhuo() {
		var dialog = parent.sy.modalDialog({
			title : '新增进货',
			width : 900,
			height : 500,
			url : basePath + 'tmsyjhtgl/jinhuoFormIndex?op=add',
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
	function editJinhuo() {
		var row = $('#mygrid').datagrid('getSelected');
		if(row){
			var v_hjchid=row.hjchid;
			var dialog = parent.sy.modalDialog({
				title : '编辑',
				width : 900,
				height : 500,
				url : basePath + 'tmsyjhtgl/jinhuoFormIndex?op=edit&hjchid='+v_hjchid,
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
	function viewJinhuo() {
		var row = $('#mygrid').datagrid('getSelected');
		if(row){
			var v_hjchid=row.hjchid;
			var dialog = parent.sy.modalDialog({
				title : '查看',
				width : 900,
				height : 500,
				url : basePath + 'tmsyjhtgl/jinhuoFormIndex?op=view&hjchid='+v_hjchid,
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
			$.messager.alert('提示','请先选择要查看的进货信息！','info');
		}
	} 	
	
	// 删除
	function delJinhuo() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var v_hjchid = row.hjchid;
			$.messager.confirm('警告', '您确定要删除该条记录吗?',function(r) {
				if (r) {
					$.post(basePath + 'tmsyjhtgl/delJinchuhuo', 
					{hjchid: v_hjchid},
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
			'jchlx':1,	
			'aae036start': $('#aae036start').datebox('getValue'),
			'aae036end': $('#aae036end').datebox('getValue')
		};
		mygrid.datagrid({
			url : basePath + '/tmsyjhtgl/queryJinchuhuo',			
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
							    data="btn_savePcompany"
								iconCls="icon-add" plain="true" onclick="addJinhuo()">新增</a> 
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateSysuser"
								iconCls="icon-edit" plain="true" onclick="editJinhuo()">编辑</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateSysuser"
								iconCls="ext-icon-report_magnify" plain="true" onclick="viewJinhuo()">查看</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td>			
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delSysuser"
								iconCls="icon-remove" plain="true" onclick="delJinhuo()">删除</a>
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