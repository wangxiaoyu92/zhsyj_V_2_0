<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>企业人员信息管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	//证件类型
	var ryzjlx = <%=SysmanageUtil.getAa10toJsonArray("RYZJLX")%>;
	//人员性别
	var ryxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
	//人员民族
	var rymz = <%=SysmanageUtil.getAa10toJsonArray("AAC005")%>;
	//人员学历
	var ryxueli = <%=SysmanageUtil.getAa10toJsonArray("RYXUELI")%>;

	var cb_ryzjlx;
	var cb_ryxb;
	var cb_ryxueli;
	var cb_rymz;
	var grid;
	$(function() {
		//证件类型
		cb_ryzjlx = $('#ryzjlx').combobox({
			data:ryzjlx,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight:'auto'
		});
		//人员性别
		cb_ryxb = $('#ryxb').combobox({
			data:ryxb,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight:'auto'
		});
		//人员学历
		cb_ryxueli = $('#ryxueli').combobox({
			data:ryxueli,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight:'auto'
		});
		//人员民族
	cb_rymz = $('#rymz').combobox({
			data:rymz,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight:'auto'
		});
		grid = $('#grid').datagrid({
			//title: '企业人员信息列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + 'pcomry/queryPcomry',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'ryid', //该列是一个唯一列
		    sortOrder: 'asc',
		    columns :[[ {
				width : '100',
				title : '人员ID',
				field : 'ryid',
				hidden : true
			},{
				width : '150',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '100',
				title : '人员姓名',
				field : 'ryxm',
				hidden : false
			},{
				width : '100',
				title : '人员登录系统账号',
				field : 'comryusername',
				hidden : false
			},{
				width : '150',
				title : '证件类型',
				field : 'ryzjlx',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(ryzjlx,value);
				}
			},{
				width : '100',
				title : '职务岗位',
				field : 'ryzwgwinfo',
				hidden : false
			},{
				width : '150',
				title : '证件号码',
				field : 'ryzjh',
				hidden : false
			},{
				width : '100',
				title : '联系电话',
				field : 'rylxdh',
				hidden : false
			},{
				width : '100',
				title : '人员民族',
				field : 'rymz',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(rymz,value);
				}
			}] ]
		});
	});
	
	function query() {
		var param = {
			'ryxm': $('#ryxm').val(),  
			'ryzjh': $('#ryzjh').val(),
			'commc':$('#commc').val()
		};
		grid.datagrid({
			url : basePath + '/pcomry/queryPcomry',			
			queryParams : param
		}); 
		grid.datagrid('clearSelections');
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增人员信息
	var addPcomry = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增人员信息',
			width : 930,
			height : 630,
			url : basePath + '/pcomry/pcomryFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.savePcomry(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};

	//编辑人员信息
	var updatePcomry = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title:'编辑人员信息',
				width:900,
				height:600,
				url:basePath + 'pcomry/pcomryFormIndex?ryid='+row.ryid,
				buttons:[{
					text : '确定',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.savePcomry(dialog,grid,parent.$);
					}
				},{
					text : '取消',
					handler : function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要修改的人员信息！','info');
		}
	}
	
	// 删除
	function delPcomry() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var ryid = row.ryid;
			$.messager.confirm('警告', '您确定要删除该用户吗?',function(r) {
				if (r) {
					$.post(basePath + 'pcomry/delPcomry', {
						ryid: row.ryid
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
			$.messager.alert('提示', '请先选择要删除的用户！', 'info');
		}
	}  	
	
	//查看人员信息
	var showPcomry = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看人员信息',
				width :900,
				height :600,
				url : basePath +'/pcomry/pcomryFormIndex?op=view&ryid='+row.ryid,
				buttons : [{
					text : '关闭',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要查看的企业！','info');
		}
	}
	//选择企业名称
	function myselectcom(){
		var style = "help:no;status:no;scroll:no;dialogWidth:800px;dialogHeight:500px;dialogTop:100px;" +
		"dialogLeft:400px;resizable:no;center:no";   
		 
		var obj = new Object();
		obj.singleSelect="true";	//

	    var v_retStr=window.showModalDialog("<%=basePath%>/pub/pub/selectcomIndex?a="+new Date().getMilliseconds(),obj,
	        style);

		var dialog = parent.sy.modalDialog({
			title : '上传人员照片',
			param : obj,
			width : 800,
			height : 500,
			url : url
		},function (dialogID){
			var v_retStr = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

			if (v_retStr!=null && v_retStr.length>0){
				for (var k=0;k<=v_retStr.length-1;k++){
					var myrow=v_retStr[k];
					$("#commc").val(myrow.commc); //公司名称
					$("#comdm").val(myrow.comdm); //公司代码
				}
			}

		});


	}
/*
	//打印
	function print(){	 
		sy.doPrint('siweb/sysuser.cpt','')
	} 	*/
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="comdm" name="comdm" style="width: 200px" type="hidden"/>
							<input id="commc" name="commc" style="width: 200px"/>
							<a id="btnselectcom" href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-search"
							onclick="myselectcom()">选择企业 </a>
						</td>	
						<td style="text-align:right;"><nobr>人员姓名</nobr></td>
						<td><input id="ryxm" name="ryxm" style="width: 200px"/></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>证件号码</nobr></td>
						<td><input id="ryzjh" name="ryzjh" style="width: 200px" /></td>				
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
        	<sicp3:groupbox title="企业人员列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_savePcomry"
								iconCls="icon-add" plain="true" onclick="addPcomry()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_savePcomry"
								iconCls="icon-edit" plain="true" onclick="updatePcomry()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delPcomry"
								iconCls="icon-remove" plain="true" onclick="delPcomry()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_pcomryFormIndex"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showPcomry()">查看</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
<%--							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-print" plain="true" onclick="print()">打印</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> --%>
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>