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
	//qykind 企业类型 因为进货 生产企业和其他企业可能不一样
	String v_qykind = StringHelper.showNull2Empty(request.getParameter("qykind"));  //
	if (null==v_qykind || "".equals(v_qykind)){
		v_qykind="no";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>进货管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">

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
			columns : [[
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
				width : '75',
				title : '索证索票标志',
				field : 'jhszspbz',
				hidden : false,
				formatter:function(value,row){
					if (value=null || value=="" || value=="0"){
						return '<span style="color:red">否</span>';
					}else{
						return '<span style="color:blue">是</span>';
					}
				}					
			},
			{
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
	function addJinhuo() {
		var dialog = parent.sy.modalDialog({
			title : '新增进货',
			width : 900,
			height : 530,
			url : basePath + 'tmsyjhtgl/jinhuoFormIndex?op=add&qykind=<%=v_qykind%>',
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
	} 
	
	// 编辑
	function editJinhuo() {
		var row = $('#mygrid').datagrid('getSelected');
		if(row){
			var v_hjhbid=row.hjhbid;
			var dialog = parent.sy.modalDialog({
				title : '编辑',
				width : 900,
				height : 530,
				url : basePath + 'tmsyjhtgl/jinhuoFormIndex?op=edit&qykind=<%=v_qykind%>&hjhbid='+v_hjhbid,
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
			$.messager.alert('提示','请先选择要修改的进货信息！','info');
		}
	} 
	
	// 查看
	function viewJinhuo() {
		var row = $('#mygrid').datagrid('getSelected');
		if(row){
			var v_hjhbid=row.hjhbid;
			var dialog = parent.sy.modalDialog({
				title : '查看',
				width : 900,
				height : 530,
				url : basePath + 'tmsyjhtgl/jinhuoFormIndex?op=view&hjhbid='+v_hjhbid,
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
	function delJinhuo() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var v_hjhbid = row.hjhbid;
			$.messager.confirm('警告', '您确定要删除该条记录吗?',function(r) {
				if (r) {
					$.post(basePath + 'tmsyjhtgl/delJinhuo', 
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
			url : basePath + '/tmsyjhtgl/queryJinhuo',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections');
	}	
	
	// 索证索票
	function uploadJinhuopiao() {
		var row = mygrid.datagrid('getSelected');
		if (row) {	
		    var dialog = parent.sy.modalDialog({
				title : '检测图片上传',
				width : 900,
				height : 700,
				url : basePath + "/pub/pub/uploadFjViewIndex?folderName=jinhuopiao&fjtype=12&fjwid="+row.hjhbid
			},function(dialogID){
				var obj = sy.getWinRet(dialogID);
				if(obj.type == 'ok'){
					$('#mygrid').datagrid('reload'); 
				};	
				sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要上传检测图片的记录！', 'info');
		}    
	};	
	
	// 检测图片上传
	function uploadJiancepic(prm_jgztlx) {
		var row = mygrid.datagrid('getSelected');
		if (row) {	
		    var dialog = parent.sy.modalDialog({
				title : '检测图片上传',
				width : 900,
				height : 700,
				url : basePath + "/pub/pub/uploadFjViewIndex?folderName=jchhgzm&fjtype=9&fjwid="+row.hjhbid
			},function(dialogID){
				var obj = sy.getWinRet(dialogID);
				if(obj.type == 'ok'){
					$('#mygrid').datagrid('reload'); 
				};	
				sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要上传检测图片的记录！', 'info');
		}    
	};
	function addjldw(){
		var obj = new Object();
		obj.singleSelect="true";	//
		var url = "<%=basePath%>jsp/sysmanager/aa10.jsp"; 
	    var dialog = parent.sy.modalDialog({ 
				title : ' ',
				width : 860,
				height : 460,
				param : {
					aaa100 : 'SPJLDW'
				},  
				url : url
			},function(dialogID){
				var obj = sy.getWinRet(dialogID); 
				if (!shiFouWeiKong(v_ret) && v_ret){
					if (prm_aaa100=='SZDW'){
						g_getAa10FromAaa100ByPost('SZDW');
					}else if (prm_aaa100=='XLBZ'){
						g_getAa10FromAaa100ByPost('XLBZ');
					};			
				};	 
				sy.removeWinRet(dialogID);
			}); 
	};
	// 查看溯源码
	function showSym(){
		var row = mygrid.datagrid('getSelected');
		if (row) {
			var url = basePath + "jsp/tmsyj/tmsyj/htgl/showSymQRcode.jsp";
			var dialog = parent.sy.modalDialog({
				title : '溯源码',
				width : 400,
				height : 400,
				url : url,
				param : {
					hjhbid : row.hjhbid, //  进货表id
					comid : row.hviewjgztid, //  监管主体id
					eptbh : row.eptbh // e票通编号
				},
				buttons : [{
					text : '关闭',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			}, function(dialogID){
				sy.removeWinRet(dialogID);
			});
		}else{
			$.messager.alert('提示', '请先选择要上传检测图片的记录！', 'info');
		}
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
								iconCls="icon-add" plain="true" onclick="addJinhuo()">新增</a> 
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-edit" plain="true" onclick="editJinhuo()">编辑</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="ext-icon-report_magnify" plain="true" onclick="viewJinhuo()">查看</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td>			
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-remove" plain="true" onclick="delJinhuo()">删除</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="ext-icon-rss_go" plain="true" onclick="uploadJinhuopiao()">索证索票</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 	
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="ext-icon-photo" plain="true" onclick="uploadJiancepic()">检测图片上传</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 													
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-modify" plain="true" onclick="addjldw()">计量单位添加</a>
							</td>	
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-modify" plain="true" onclick="showSym()">查看溯源码</a>
							</td>
							<td name="btntd">
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