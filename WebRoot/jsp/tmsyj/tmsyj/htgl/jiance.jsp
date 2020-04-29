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
<title>检查信息管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var comzzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;
	var v_spjldw= <%=SysmanageUtil.getAa10toJsonArray("SPJLDW")%>;
	var v_jcfs= <%=SysmanageUtil.getAa10toJsonArray("JCFS")%>;
	var v_jhhgzmlx=<%=SysmanageUtil.getAa10toJsonArray("JHHGZMLX")%>;
	var v_jhscjyjl=<%=SysmanageUtil.getAa10toJsonArray("JHSCJYJL")%>;
	var v_jhqycyjl=<%=SysmanageUtil.getAa10toJsonArray("JHQYCYJL")%>;
	var v_jhqrbz=<%=SysmanageUtil.getAa10toJsonArray("JHQRBZ")%>;
	var v_jhjcqk=<%=SysmanageUtil.getAa10toJsonArray("JHJCQK")%>;

	var mygrid;
	$(function() {
		   mygrid = $('#mygrid').datagrid({
			//title: '进货主表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url : basePath + '/tmsyjhtgl/queryJinhuo',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'hjhbid', //该列是一个唯一列
		    nowrap:false,	
		    onLoadSuccess:function(data){
		    	mygrid.datagrid("unselectAll"); 
		    },
			columns : [ [
	        {
				width : '100',
				title : '进货表id',
				field : 'hjhbid',
				hidden : true
			},{
				width : '90',
				title : '进货确认标志',
				field : 'jhqrbz',
				hidden : false,
				formatter:function(value,row){
					if (row.jhqrbz=null || row.jhqrbz=="" || row.jhqrbz=="0"){
						return '<span style="color:red">'+sy.formatGridCode(v_jhqrbz,value);+'</span>';
					}else{
						return '<span style="color:blue">'+sy.formatGridCode(v_jhqrbz,value);+'</span>';
					}
				}					
			},{
				width : '100',
				title : '进货检测情况',
				field : 'jhjcqk',
				hidden : false,
				formatter:function(value,row){
					if (value==null || value=="" || value=="0"){
						return '<span style="color:red">'+sy.formatGridCode(v_jhjcqk,value);+'</span>';
					}else if (value=="1"){
						return '<span style="color:blue">'+sy.formatGridCode(v_jhjcqk,value);+'</span>';
					}else if (value=="2"){
						return '<span style="color:green">'+sy.formatGridCode(v_jhjcqk,value);+'</span>';
					}else if (value=="3"){
						return '<span style="color:#5A5AAD">'+sy.formatGridCode(v_jhjcqk,value);+'</span>';
					}
				}					
			},{
				width : '150',
				title : '监管主体名称',
				field : 'jgztmc',
				hidden : false
			},{
				width : '100',
				title : '商品id',
				field : 'jcypid',
				hidden : true
			},{
				width : '100',
				title : '操作时间',
				field : 'aae036',
				hidden : false
			},{
				width : '130',
				title : '商品名称',
				field : 'jcypmc',
				hidden : false
			},{
				width : '90',
				title : '进货库存量',
				field : 'jhkcl',
				hidden : false
			},{
				width : '80',
				title : '进货数量',
				field : 'jhsl',
				hidden : false
			},{
				width : '120',
				title : '进货计量单位',
				field : 'jhspjldw',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_spjldw,value);
				}				
			},{
				width : '100',
				title : '生产地',
				field : 'jhscd',
				hidden : false
			},{
				width : '100',
				title : '上级分销id',
				field : 'jhsjfxid',
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
				field : 'jhprice',
				hidden : false
			},{
				width : '100',
				title : '生产日期',
				field : 'jhscrq',
				hidden : false
			},{
				width : '100',
				title : '生产批次码',
				field : 'jhscpcm',
				hidden : false
			},{
				width : '100',
				title : '生产批次码',
				field : 'jhscpcm',
				hidden : false
			},{
				width : '100',
				title : '合格证明类型',
				field : 'jhhgzmlx',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jhhgzmlx,value);
				}					
			},{
				width : '100',
				title : '生产检验结论',
				field : 'jhscjyjl',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jhscjyjl,value);
				}						
			},{
				width : '100',
				title : '企业查验结论',
				field : 'jhqycyjl',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jhqycyjl,value);
				}					
			},{
				width : '100',
				title : '供应商id',
				field : 'jhgysid',
				hidden : true
			},{
				width : '100',
				title : '供应商',
				field : 'jhgysmc',
				hidden : false
			},{
				width : '100',
				title : '生产商id',
				field : 'jhscsid',
				hidden : true
			},{
				width : '100',
				title : '生产商',
				field : 'jhscsmc',
				hidden : false
			},{
				width : '100',
				title : '商品条码',
				field : 'jhsptm',
				hidden : false
			},{
				width : '100',
				title : '监管主体表id',
				field : 'hviewjgztid',
				hidden : true
			},{
				width : '170',
				title : 'e票通编号',
				field : 'eptbh',
				hidden : false
			},{
				width : '120',
				title : '操作员',
				field : 'aae011',
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
	function addJiance() {

		var row = $('#mygrid').datagrid('getSelected');
		if(row){
			if(row.jhjcqk==='1'||row.jhjcqk==='3'){
				alert('检测数据已存在,请修改！');
				return false;
			}
			var v_hjhbid=row.hjhbid;		
			var dialog = parent.sy.modalDialog({
				title : '新增检测信息',
				width : 900,
				height : 530,
				url : basePath + 'tmsyjhtgl/jianceFormIndex?op=add&hjhbid='+v_hjhbid,
				buttons : [{
					text : '保存',
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
			$.messager.alert('提示','请先选择要新增检测信息的进货信息！','info');
		}		
	} 
	
	// 编辑
	function editJiance() {
		var row = $('#mygrid').datagrid('getSelected');
		if(row){
			//返回值说明0无检测数据无检测图片1有检测数据2有检测图片3有检测数据有检测图片 aaa100=jhjcqk
			var v_jhjcqk=row.jhjcqk;
			if (v_jhjcqk==null || v_jhjcqk==""||"0"==v_jhjcqk||"2"==v_jhjcqk){
				alert("无检测数据，不能编辑");
				return false;
			};
			
			var v_hjhbid=row.hjhbid;
			var dialog = parent.sy.modalDialog({
				title : '编辑',
				width : 900,
				height : 530,
				url : basePath + 'tmsyjhtgl/jianceFormIndex?op=edit&hjhbid='+v_hjhbid,
				buttons : [{
					text : '保存',
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
			$.messager.alert('提示','请先选择要修改的检测进货信息！','info');
		}
	} 
	
	// 查看
	function viewJiance() {
		var row = $('#mygrid').datagrid('getSelected');
		if(row){
			//返回值说明0无检测数据无检测图片1有检测数据2有检测图片3有检测数据有检测图片 aaa100=jhjcqk
			var v_jhjcqk=row.jhjcqk;
			if (v_jhjcqk==null || v_jhjcqk==""||"0"==v_jhjcqk||"2"==v_jhjcqk){
				alert("无检测数据，不能查看");
				return false;
			};
			
			var v_hjhbid=row.hjhbid;
			var dialog = parent.sy.modalDialog({
				title : '查看',
				width : 900,
				height : 530,
				url : basePath + 'tmsyjhtgl/jianceFormIndex?op=view&hjhbid='+v_hjhbid,
				buttons : [{
					text : '关闭',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
			
		}else{
			$.messager.alert('提示','请先选择要查看的进货检测信息！','info');
		}
	} 	
	
	// 删除
	function delJiance() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			//返回值说明0无检测数据无检测图片1有检测数据2有检测图片3有检测数据有检测图片 aaa100=jhjcqk
			var v_jhjcqk=row.jhjcqk;
			if (v_jhjcqk==null || v_jhjcqk==""||"0"==v_jhjcqk||"2"==v_jhjcqk){
				alert("无检测数据，不能编辑");
				return false;
			};
			
			var v_hjhbid = row.hjhbid;
			$.messager.confirm('警告', '您确定要删除该条进货信息的检测记录吗?',function(r) {
				if (r) {
					$.post(basePath + 'tmsyjhtgl/delJiance', 
					{hjhbid: v_hjhbid},
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
			$.messager.alert('提示', '请先选择要删除的检测进货记录！', 'info');
		}
	} 	
	
	// 查询企业信息
	function myquery() {
		var param = {
			'aae036start': $('#aae036start').datebox('getValue'),
			'aae036end': $('#aae036end').datebox('getValue')
		};
		mygrid.datagrid({
			url : basePath + '/tmsyjhtgl/queryJinhuo',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections');
	}	
	
/* 	//进货抽检报告
	function uploadChoujianbaogao(){
		var row = mygrid.datagrid('getSelected');
		if (row) {
			var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=jhcjbg&fjtype=13&fjwid="+row.hjhbid; 
			var obj = new Object();
			var retVal = popwindow(url,obj,900,700); 
			if(retVal != null){
				if(retVal.type == 'ok'){
				$('#mygrid').datagrid('reload'); 
				}
			}
		}else{
			$.messager.alert('提示', '请先选择要上传抽验报告的记录！', 'info');
		}
	} */
	
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
								iconCls="icon-add" plain="true" onclick="addJiance()">新增检测信息</a> 
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-edit" plain="true" onclick="editJiance()">编辑检测信息</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="ext-icon-report_magnify" plain="true" onclick="viewJiance()">查看检测信息</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td>			
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-remove" plain="true" onclick="delJiance()">删除检测信息</a>
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