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
<title>进货管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var mygrid;
	$(function() {
		   mygrid = $('#mygrid').datagrid({
			//title: '进货主表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url : basePath + '/tmsyjhtgl/queryChouyangbaogao',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'hjdjccybgid', //该列是一个唯一列
		    nowrap:false,	
		    onLoadSuccess:function(data){
		    	mygrid.datagrid("unselectAll"); 
		    },
			columns : [ [
	        {
				width : '160',
				title : '监督检查抽样报告id',
				field : 'hjdjccybgid',
				hidden : true
			},{
				width : '90',
				title : '监管主体表主键',
				field : 'hviewjgztid',
				hidden : true					
			},{
				width : '140',
				title : '是否已上传抽样报告图片',
				field : 'cybgtpscbz',
				hidden : false,
				formatter:function(value,row){
					if (value=null || value=="" || value=="0"){
						return '<span style="color:red">否</span>';
					}else{
						return '<span style="color:blue">是</span>';
					}
				}					
			},{
				width : '160',
				title : '监管主体名称',
				field : 'jgztmc',
				hidden : false					
			},{
				width : '75',
				title : '商品id',
				field : 'jcypid',
				hidden : true					
			},{
				width : '120',
				title : '商品名称',
				field : 'jcypmc',
				hidden : false					
			},{
				width : '150',
				title : '任务来源',
				field : 'rwly',
				hidden : false
			},{
				width : '100',
				title : '监督抽检时间',
				field : 'jdcysj',
				hidden : false
			},{
				width : '100',
				title : '抽样人',
				field : 'cyr',
				hidden : false
			},{
				width : '130',
				title : '抽样单位',
				field : 'cydw',
				hidden : false
			},{
				width : '130',
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
	function addChouyang() {
		var dialog = parent.sy.modalDialog({
			title : '新增抽样报告',
			width : 600,
			height : 390,
			url : basePath + 'tmsyjhtgl/chouyangbaogaoFormIndex?op=add',
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
	function editChouyang() {
		var row = $('#mygrid').datagrid('getSelected');
		if(row){
			var v_hjdjccybgid=row.hjdjccybgid;
			var dialog = parent.sy.modalDialog({
				title : '编辑',
				width : 600,
				height : 390,
				url : basePath + 'tmsyjhtgl/chouyangbaogaoFormIndex?op=edit&hjdjccybgid='+v_hjdjccybgid,
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
			$.messager.alert('提示','请先选择要修改的抽样报告信息！','info');
		}
	} 
	
	// 查看
	function viewChouyang() {
		var row = $('#mygrid').datagrid('getSelected');
		if(row){
			var v_hjdjccybgid=row.hjdjccybgid;
			var dialog = parent.sy.modalDialog({
				title : '查看',
				width : 600,
				height : 390,
				url : basePath + 'tmsyjhtgl/chouyangbaogaoFormIndex?op=view&hjdjccybgid='+v_hjdjccybgid,
				buttons : [{
					text : '关闭',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
			
		}else{
			$.messager.alert('提示','请先选择要查看的抽样报告信息！','info');
		}
	} 	
	
	// 删除
	function delChouyang() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var v_hjdjccybgid=row.hjdjccybgid;
			$.messager.confirm('警告', '您确定要删除该条记录吗?',function(r) {
				if (r) {
					$.post(basePath + 'tmsyjhtgl/delChouyangbaogao', 
					{hjdjccybgid: v_hjdjccybgid},
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
			'aae036end': $('#aae036end').datebox('getValue'),
			'jgztmc': $('#jgztmc').val()
		};
		mygrid.datagrid({
			url : basePath + '/tmsyjhtgl/queryChouyangbaogao',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections');
	}	
	
	// 抽样报告
	function uploadChouyangpic(){
		var row = mygrid.datagrid('getSelected');
		if (row) {
			var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=chouyang&fjtype=13&fjwid="+row.hjdjccybgid; 
			var obj = new Object();
			var retVal = paopwindow(url,obj,900,700); 
			if(retVal != null){
				if(retVal.type == 'ok'){
				$('#mygrid').datagrid('reload'); 
				}
			}
		}else{
			$.messager.alert('提示', '请先选择要上传抽样报告图片的记录！', 'info');
		}
	}
	
	function uploadChouyangpicBase(prm_jgztlx) {
		var row = mygrid.datagrid('getSelected');
		if (row) {		
			var v_singleSelect="true";
		    var dialog = parent.sy.modalDialog({
				title : '上传抽样报告图片',
				width : 900,
				height : 700,
				url : basePath + "/pub/pub/uploadFjViewIndexEasyui?folderName=chouyang&fjtype=13&fjwid="+row.hjdjccybgid,
			},function(dialogID){
				var obj = sy.getWinRet(dialogID);
				if(obj.type == 'ok'){
					$('#mygrid').datagrid('reload'); 
				};	
				sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要上传抽样报告图片的记录！', 'info');
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
						<td style="text-align:right;"><nobr>抽样单位名称</nobr></td>
						<td><input id="jgztmc" name="jgztmc" style="width: 200px" /></td>						
						<td style="text-align:right;"><nobr>操作起始时间</nobr></td>
						<td><input id="aae036start" name="aae036start" style="width: 200px" 
						   class="easyui-datebox"/></td>	
						<td style="text-align:right;"><nobr>操作结束时间</nobr></td>
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
        	<sicp3:groupbox title="抽样报告列表">
	        <div id="toolbar">
	        		<table>
						<tr>
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" 
							    data=""
								iconCls="icon-add" plain="true" onclick="addChouyang()">新增</a> 
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-edit" plain="true" onclick="editChouyang()">编辑</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="ext-icon-report_magnify" plain="true" onclick="viewChouyang()">查看</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td>			
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-remove" plain="true" onclick="delChouyang()">删除</a>
							</td>
							<td name="btntd">  
								<div class="datagrid-btn-separator"></div>
							</td>			
							<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="ext-icon-photo" plain="true" onclick="uploadChouyangpicBase()">上传抽样报告图片</a>
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