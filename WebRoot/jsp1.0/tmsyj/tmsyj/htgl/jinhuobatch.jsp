<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.DateUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>

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
<script type="text/javascript">
<%-- var basePath="<%=basePath%>";
var sy = sy || {}; --%>
</script>
<%-- 
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery.json-2.4.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery-1.7.2.min.js"></script>


<script type="text/javascript" src="<%=contextPath%>/jslib/Globals.js"></script>
<script type="text/javascript" src="<%=contextPath%>/jslib/common.js"></script>
<script type="text/javascript" src="<%=contextPath%>/jslib/quanju.js"></script>
<script type="text/javascript" src="<%=contextPath%>/jslib/storage.js"></script>

<script type="text/javascript" src="<%=basePath%>/jslib/jquery-easyui-1.5.3/jquery.min.js"></script>  
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery-easyui-1.5.3/jquery.easyui.min.js"></script>  
<link rel="stylesheet" href="<%=contextPath%>/jslib/jquery-easyui-1.5.3/themes/default/easyui.css" type="text/css"></link>  
<link rel="stylesheet" href="<%=contextPath%>/jslib/jquery-easyui-1.5.3/themes/icon.css" type="text/css"></link>  
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js"></script> 



<script type="text/javascript" src="<%=basePath%>/jslib/syExtJquery.js"></script>
<script type="text/javascript" src="<%=basePath%>/jslib/syExtEasyUI.js"></script>
<script type="text/javascript" src="<%=basePath%>/jslib/syExtJavascript.js"></script>
<script type="text/javascript" src="<%=basePath%>/jslib/jquery.jdirk.min.js"></script>

 --%>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">


    var editIndex = undefined;
	var v_spjldw= <%=SysmanageUtil.getAa10toJsonArray("SPJLDW")%>;
	var v_jcfs= <%=SysmanageUtil.getAa10toJsonArray("JCFS")%>;
	var v_jhhgzmlx=<%=SysmanageUtil.getAa10toJsonArray("JHHGZMLX")%>;
	var v_jhscjyjl=<%=SysmanageUtil.getAa10toJsonArray("JHSCJYJL")%>;
	var v_jhqycyjl=<%=SysmanageUtil.getAa10toJsonArray("JHQYCYJL")%>;
	var v_jhqrbz=<%=SysmanageUtil.getAa10toJsonArray("JHQRBZ")%>;
	var v_jhjcqk=<%=SysmanageUtil.getAa10toJsonArray("JHJCQK")%>;
	var v_xuanzepic='<%=basePath%>/images/pub/updatelink.png';

	var mygridbatchdetail;
	var mygridbatchmain;
	
	$(function() {
		$('#aae036start').datebox('setValue', g_GetDateStr(-7));
		$('#aae036end').datebox('setValue', g_GetDateStr(1));
		
		mygridbatchmain = $('#mygridbatchmain').datagrid({
			//title: '进货主表',
			//iconCls: 'icon-tip',
			url : basePath + '/tmsyjhtgl/queryJinhuoBatchMain',
			queryParams:{
				aae036start:$("#aae036start").datebox("getValue"),
				aae036end:$("#aae036end").datebox("getValue")
			},
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [10,20,30],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jhplh', //该列是一个唯一列
		    nowrap:false,	
		    onLoadSuccess:function(data){
		    	mygridbatchdetail.datagrid("unselectAll"); 
		    },
		    onDblClickRow:function (index,row){
		    	myonDbClickRow(row.jhplh);
		    },
			columns : [[
	        {
				width : '190',
				title : '批量进货号',
				field : 'jhplh',
				hidden : false
			},{
				width : '200',
				title : '经办人',
				field : 'aae011'	
			},{
				width : '160',
				title : '经办时间',
				field : 'aae036'					
			}
			]],
			toolbar: '#toolbarmain'
		});//
		
		
		mygridbatchdetail = $('#mygridbatchdetail').datagrid({
			//title: '进货主表',
			//iconCls: 'icon-tip',
			//url : basePath + '/tmsyjhtgl/queryJinhuo',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 1000,
			pageList : [1000,2000,3000],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'hjhbid', //该列是一个唯一列
		    nowrap:false,	
		    onLoadSuccess:function(data){
		    	mygridbatchdetail.datagrid("unselectAll"); 
		    },
		    onClickRow:function (rowIndex, rowData){
		    	myonClickRow(rowIndex);
		    },
			columns : [[
	        {
				width : '100',
				title : '进货表id',
				field : 'hjhbid',
				hidden : true
			},{
				width : '100',
				title : '商品id',
				field : 'jcypid',
				hidden : true,
				editor:{
					type:'validatebox',
					options:{
						disabled:true
					}					
				}						
			},{
				width : '90',
				title : '进货确认标志',
				field : 'jhqrbz',
				hidden : true,
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
				title : '商品名称',
				field : 'jcypmc',
				hidden : false,
				editor:{
					type:'validatebox',
					options:{
						disabled:true
					}					
				},					
				formatter:function(value,row){
					if (value!=null){
				       return '<span style="color:LightSeaGreen">'+value+'</span>';
					}
				}				
			},{
				width : '50',
				title : '',
				field : 'btnxzsp',
				hidden : false,
				formatter:function(value,row){
				       return "<input type='button' value='选择' onclick='myselectShangpinBase();'/>";
				}				
			},{
				width : '80',
				title : '进货数量',
				field : 'jhsl',
				hidden : false,
				editor:{
					type:'numberbox'
				},
				formatter:function(value,row){
					if (value!=null){
					  return '<span style="color:Magenta">'+value+'</span>';
					}
			  }					
			},{
				width : '120',
				title : '计量单位',
				field : 'jhspjldw',
				hidden : false,
				editor:{
					type:'combobox',
					options:{
						valueField:'id',
						textField:'text',
						data:v_spjldw,
						required:true
					}
				},				
				formatter:function(value,row){
					if (value!=null){
					   return '<span style="color:LightSeaGreen">'+sy.formatGridCode(v_spjldw,value)+'</span>';
					}
				}				
			},{
				width : '140',
				title : '生产日期',
				field : 'jhscrq',
				hidden : false,
				editor:'datebox',				
				formatter:function(value,row){
					if (value!=null){
						return '<span style="color:LightSeaGreen">'+value+'</span>';
					}
			   }					
			},{
				width : '100',
				title : '供应商id',
				field : 'jhgysid',
				hidden : true,
				editor:{
					type:'validatebox',
					options:{
						disabled:true
					}					
				}					
			},{
				width : '220',
				title : '供应商',
				field : 'jhgysmc',
				hidden : false,
				editor:{
					type:'validatebox',
					options:{
						disabled:true
					}					
				},					
				formatter:function(value,row){
					if (value!=null){
						return '<span style="color:LightSeaGreen">'+value+'</span>';
					}
			   }					
			},{
				width : '50',
				title : '',
				field : 'btnxzgys',
				hidden : false,
				formatter:function(value,row){
				       return "<input type='button' value='选择' onclick='myselectJianGuanZhuTiBase(3);'/>";
				}				
			},{
				width : '20',
				title : '生产商id',
				field : 'jhscsid',
				hidden : true,
				editor:{
					type:'validatebox',
					options:{
						disabled:true
					}					
				}					
			},{
				width : '220',
				title : '生产商',
				field : 'jhscsmc',
				hidden : false,
				editor:{
					type:'validatebox',
					options:{
						disabled:true
					}					
				},					
				formatter:function(value,row){
					if (value!=null){
						return '<span style="color:LightSeaGreen">'+value+'</span>';
					}
			   }					
			},{
				width : '50',
				title : '',
				field : 'btnxzscs',
				hidden : false,
				formatter:function(value,row){
				       return "<input type='button' value='选择' onclick='myselectJianGuanZhuTiBase(4);'/>";
				}				
			},{
				width : '130',
				title : '生产地',
				field : 'jhscd',
				hidden : false,
				editor:{
					type:'textarea'
				}				
			},{
				width : '100',
				title : '生产批次码',
				field : 'jhscpcm',
				hidden : false,
				editor:{
					type:'textarea'
				}					
			},{
				width : '90',
				title : '单价',
				field : 'jhprice',
				hidden : false,
				editor:{type:'numberbox',
					options:{
						precision:2
					}
			   }				
			},{
				width : '120',
				title : '商品条码',
				field : 'jhsptm',
				hidden : false,
				editor:{
					type:'textarea'
				}					
			},{
				width : '100',
				title : '生产批次码',
				field : 'jhscpcm',
				hidden : false,
				editor:{
					type:'textarea'
				}					
			},{
				width : '100',
				title : '检测方式',
				field : 'jcfs',
				hidden : false,
				editor:{
					type:'combobox',
					options:{
						valueField:'id',
						textField:'text',
						data:v_jcfs,
						required:false
					}
				},					
				formatter:function(value,row){
					return sy.formatGridCode(v_jcfs,value);
				}					
			},{
				width : '100',
				title : '合格证明类型',
				field : 'jhhgzmlx',
				hidden : false,
				editor:{
					type:'combobox',
					options:{
						valueField:'id',
						textField:'text',
						data:v_jhhgzmlx,
						required:false
					}
				},					
				formatter:function(value,row){
					return sy.formatGridCode(v_jhhgzmlx,value);
				}					
			},{
				width : '100',
				title : '生产检验结论',
				field : 'jhscjyjl',
				hidden : false,
				editor:{
					type:'combobox',
					options:{
						valueField:'id',
						textField:'text',
						data:v_jhscjyjl,
						required:false
					}
				},					
				formatter:function(value,row){
					return sy.formatGridCode(v_jhscjyjl,value);
				}						
			},{
				width : '100',
				title : '企业查验结论',
				field : 'jhqycyjl',
				hidden : false,
				editor:{
					type:'combobox',
					options:{
						valueField:'id',
						textField:'text',
						data:v_jhqycyjl,
						required:false
					}
				},					
				formatter:function(value,row){
					return sy.formatGridCode(v_jhqycyjl,value);
				}					
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
			},
			{
				width : '150',
				title : '监管主体名称',
				field : 'jgztmc',
				hidden : true
			},{
				width : '100',
				title : '上级分销id',
				field : 'jhsjfxid',
				hidden : true
			},{
				width : '120',
				title : '操作员',
				field : 'aae011',
				hidden : true
			},{
				width : '100',
				title : '操作时间',
				field : 'aae036',
				hidden : true
			},{
				width : '90',
				title : '进货库存量',
				field : 'jhkcl',
				hidden : false
			},{
				width : '150',
				title : '进货批量号',
				field : 'jhplh',
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
		 $("#jhplh").val("");
		var v_jhhisdays=$("#jhhisdays").val();
		var param = {
				'querybatchjinhuo':'1',
				'querybatchhisdays': v_jhhisdays
			};
		    mygridbatchdetail.datagrid({
				url :'<%=basePath%>tmsyjhtgl/queryJinhuo',			
				queryParams : param
			});
		    mygridbatchdetail.datagrid('clearSelections');
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
				url :'<%=basePath%>tmsyjhtgl/jinhuoFormIndex?op=edit&qykind=<%=v_qykind%>&hjhbid='+v_hjhbid,
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
				url :'<%=basePath%>tmsyjhtgl/jinhuoFormIndex?op=view&hjhbid='+v_hjhbid,
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
					$.post('<%=basePath%>tmsyjhtgl/delJinhuo', 
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
		mygridbatchmain.datagrid({
			url :  '<%=basePath%>/tmsyjhtgl/queryJinhuoBatchMain',			
			queryParams : param
		});
		mygridbatchmain.datagrid('clearSelections');
	}	
	
	// 索证索票
	function uploadJinhuopiao() {
		var row = mygridbatchdetail.datagrid('getSelected');
		if (row) {	
			if (row.hjhbid!=null && row.hjhbid!=""){
			    var dialog = parent.sy.modalDialog({
					title : '检测图片上传',
					width : 900,
					height : 700,
					url :"<%=basePath%>pub/pub/uploadFjViewIndex?folderName=jinhuopiao&fjtype=12&fjwid="+row.hjhbid
				},function(dialogID){
					var obj = sy.getWinRet(dialogID);
					if(obj.type == 'ok'){
						mygridbatchdetail.datagrid('reload'); 
					};	
					sy.removeWinRet(dialogID);//不可缺少
				});				
			}else{
				$.messager.alert('提示', '保存成功后才能操作！', 'info');
			}

		}else{
			$.messager.alert('提示', '请先选择要上传检测图片的记录！', 'info');
		}    
	};	
	
	// 检测图片上传
	function uploadJiancepic(prm_jgztlx) {
		var row = mygridbatchdetail.datagrid('getSelected');
		if (row) {	
			if (row.hjhbid!=null && row.hjhbid!=""){
			    var dialog = parent.sy.modalDialog({
					title : '检测图片上传',
					width : 900,
					height : 700,
					url :"<%=basePath%>pub/pub/uploadFjViewIndex?folderName=jchhgzm&fjtype=9&fjwid="+row.hjhbid
				},function(dialogID){
					var obj = sy.getWinRet(dialogID);
					if(obj.type == 'ok'){
						mygridbatchdetail.datagrid('reload'); 
					};	
					sy.removeWinRet(dialogID);//不可缺少
				});
			
			}else{
				$.messager.alert('提示', '保存成功后才能操作！', 'info');
			}
			
		}else{
			$.messager.alert('提示', '请先选择要上传检测图片的记录！', 'info');
		}    
	};
	
	function endEditing(){
		if (editIndex == undefined){return true}
		if (mygridbatchdetail.datagrid('validateRow', editIndex)){
			//var ed = $('#dg').datagrid('getEditor', {index:editIndex,field:'productid'});
			///var productname = $(ed.target).combobox('getText');
			//$('#dg').datagrid('getRows')[editIndex]['productname'] = productname;
			mygridbatchdetail.datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	};
	
	function myonDbClickRow(prm_jhplh){
		var param = {
				'jhplh': prm_jhplh
			};
		    mygridbatchdetail.datagrid({
				url :  '<%=basePath%>/tmsyjhtgl/queryJinhuo',			
				queryParams : param
			});
			mygridbatchdetail.datagrid('clearSelections');
			$("#jhplh").val(prm_jhplh);
	};
	
	function myonClickRow(rowIndex){
		if (editIndex != rowIndex){
			if (endEditing()){
				mygridbatchdetail.datagrid('selectRow', rowIndex)
						.datagrid('beginEdit', rowIndex);
				editIndex = rowIndex;
			} else {
				mygridbatchdetail.datagrid('selectRow', editIndex);
			}
		}else{
			mygridbatchdetail.datagrid('selectRow', rowIndex)
			.datagrid('beginEdit', rowIndex);			
		}
	};
	
	// 选择商品
	var myselectShangpinBase = function() {
		var v_singleSelect="true";
	    var dialog = parent.sy.modalDialog({
			title : '选择商品',
			width : 860,
			height : 460,
			url :'<%=basePath%>pub/pub/selectShangpinIndex?singleSelect='+v_singleSelect+'&a='+new Date().getMilliseconds(),
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.queding(dialog);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
				}
			} ]
		},closeModalDialogCallback);
	};
	
	function closeModalDialogCallback(dialogID){
		var v_retValue = sy.getWinRet(dialogID);
	    if (v_retValue != null && v_retValue.length > 0) {
		    for (var k=0;k<=v_retValue.length-1;k++){
		      var myrow = v_retValue[k];
		      var v_editIndex = mygridbatchdetail.datagrid('getRowIndex', mygridbatchdetail.datagrid('getSelected'));
		      
				if (myrow.jcypid.length > 0) {
					parent.$.messager.progress({
						text : '数据加载中....'
					});
					$.post('<%=basePath%>tmsyjhtgl/queryJinhuoDTO', {
						jcypid : myrow.jcypid,
						querymaxjhjl : '1'
					}, 
					function(result) {
						if (result.code=='0') {
							var mydata = result.data;	
						      var v_jhspjldw = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhspjldw'});//进货计量单位
						      var v_jhscrq = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhscrq'});
						      var v_jhgysid = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhgysid'});//进货计量单位
						      var v_jhgysmc = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhgysmc'});
						      var v_jhscsid = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhscsid'});//进货计量单位
						      var v_jhscsmc = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhscsmc'});
						      
						      var v_jhscd = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhscd'});//进货计量单位
						      var v_jhscpcm = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhscpcm'});
						      var v_jhprice = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhprice'});//进货计量单位
						      var v_jhsptm = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhsptm'});
						      var v_jhscpcm = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhscpcm'});//进货计量单位
						      var v_jcfs = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jcfs'});
						      
						      var v_jhhgzmlx = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhhgzmlx'});//进货计量单位
						      var v_jhscjyjl = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhscjyjl'});
						      var v_jhqycyjl = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhqycyjl'});//进货计量单位
							  /////////////////
							  $(v_jhspjldw.target).combobox('setValue',mydata.jhspjldw);
							  $(v_jhscrq.target).datebox('setValue',mydata.jhscrq);	
							  $(v_jhgysid.target).val(mydata.jhgysid);
							  $(v_jhgysmc.target).val(mydata.jhgysmc);	
							  $(v_jhscsid.target).val(mydata.jhscsid);
							  $(v_jhscsmc.target).val(mydata.jhscsmc);	
							  
							  $(v_jhscd.target).val(mydata.jhscd);
							  $(v_jhscpcm.target).val(mydata.jhscpcm);
							  $(v_jhprice.target).numberbox('setValue',mydata.jhprice);	
							  $(v_jhsptm.target).val(mydata.jhsptm);
							  $(v_jhscpcm.target).val(mydata.jhscpcm);	
							  $(v_jcfs.target).combobox('setValue',mydata.jcfs);
							  $(v_jhhgzmlx.target).combobox('setValue',mydata.jhhgzmlx);
							  $(v_jhscjyjl.target).combobox('setValue',mydata.jhscjyjl);	
							  $(v_jhqycyjl.target).combobox('setValue',mydata.jhqycyjl);
							  
						      
						} else {
							parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
			            }	
						parent.$.messager.progress('close');
					}, 'json');
				};			      
		      
			      var edjcypmc = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jcypmc'});
			      var edjcypid = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jcypid'});
			      
				  $(edjcypmc.target).val(myrow.jcypmc);
				  $(edjcypid.target).val(myrow.jcypid);		
				  
		      //$("#jcypid").val(myrow.jcypid); //公司名称   
		      //$("#jcypmc").val(myrow.jcypmc); //公司代码 	

				//var productname = $(ed.target).combobox('getText');
			 // mygridbatchdetail.datagrid('getRows')[v_editIndex]['jcypid'] = myrow.jcypid;
			  //mygridbatchdetail.datagrid('getRows')[v_editIndex]['jcypmc'] = myrow.jcypmc;
			  //mygridbatchdetail.datagrid('endEdit', v_editIndex);
			  //mygridbatchdetail.datagrid('updateRow',{index:v_editIndex,row:{jcypid:myrow.jcypid,jcypmc:myrow.jcypmc}});

			  //mygridbatchdetail.rows[v_editIndex].jcypmc=myrow.jcypmc;
			 // myonClickRow(v_editIndex);			 			  
		    }      
	    }
	    sy.removeWinRet(dialogID);//不可缺少							
	};	
	
	//监管主体 prm_jgztlx监管主体类型 1企业2商户3供应商4生产商5经销商
	function myselectJianGuanZhuTiBase(prm_jgztlx) {
		var v_singleSelect="true";
		var v_title='企业';
		if (prm_jgztlx=='2'){
			v_title='商户';
		}else if (prm_jgztlx=='3'){
			v_title='供应商';
		}else if (prm_jgztlx=='4'){
			v_title='生产商';
		}else if (prm_jgztlx=='5'){
			v_title='经销商';
		};
		
	    var dialog = parent.sy.modalDialog({
			title : v_title,
			width : 1060,
			height : 460,
			url :'<%=basePath%>pub/pub/selectJianGuanZhuTiIndex?singleSelect='+v_singleSelect+'&selfwnfww=1&qykind=no&jgztlx='+prm_jgztlx+'&a='+new Date().getMilliseconds(),
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.queding(dialog);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
				}
			} ]
		},closeModalDialogCallbackZhuti);
	};
	
	function closeModalDialogCallbackZhuti(dialogID){
		var obj = sy.getWinRet(dialogID);
		var v_jgztlx = obj.jgztlx;
		var v_retValue = obj.retValue;
		//var v_retValue = sy.getWinRetObj("retValue");
		//var v_jgztlx = sy.getWinRet("jgztlx");
	    if (v_retValue != null && v_retValue.length > 0) {
		    for (var k=0;k<=v_retValue.length-1;k++){
			      var myrow=v_retValue[k];//监管主体表3供应商4生产商5经销商
			      
			      var v_editIndex = mygridbatchdetail.datagrid('getRowIndex', mygridbatchdetail.datagrid('getSelected'));				  
			      if (v_jgztlx=='3'){//供应商
				      var ed_jhgysid = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhgysid'});
				      var ed_jhgysmc = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhgysmc'});
					  $(ed_jhgysid.target).val(myrow.hviewjgztid);
					  $(ed_jhgysmc.target).val(myrow.jgztmc);			    	  
			      }else if (v_jgztlx=='4'){//生产商
				      var ed_jhscsid = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhscsid'});
				      var ed_jhscsmc = mygridbatchdetail.datagrid('getEditor', {index:v_editIndex,field:'jhscsmc'});
					  $(ed_jhscsid.target).val(myrow.hviewjgztid);
					  $(ed_jhscsmc.target).val(myrow.jgztmc);	
			      };
			      //myonClickRow(v_editIndex);
		    }      
	    }
	    //sy.removeWinRet("retValue");	
	    //sy.removeWinRet("jgztlx");
	    sy.removeWinRet(dialogID);//不可缺少	
	};
	
	function appendDetailRow(){
		if (endEditing()){
			mygridbatchdetail.datagrid('appendRow',{jhszspbz:'0','jhqrbz':'0','jhjcqk':'0'});
			editIndex = mygridbatchdetail.datagrid('getRows').length-1;
			mygridbatchdetail.datagrid('selectRow', editIndex)
					.datagrid('beginEdit', editIndex);
		}
	};
	
	//function acceptRow(){
	  //mygridbatchdetail.datagrid('acceptChanges');
	//};	
	
	function mybatchAddSave(){
		var url= basePath+'/tmsyjhtgl/saveBatchjinhuo';

	     parent.$.messager.progress({
			text : '正在提交....'
		});	// 显示进度条
		
         mydatagrid_endEditing($('#mygridbatchdetail'));
		
         var v_batchjinhuoinsertrows = $('#mygridbatchdetail').datagrid('getChanges',"inserted");
         var v_batchjinhuoupdaterows = $('#mygridbatchdetail').datagrid('getChanges',"updated");
         
         $('#batchjinhuoinsertrows').val($.toJSON(v_batchjinhuoinsertrows));
         $('#batchjinhuoupdaterows').val($.toJSON(v_batchjinhuoupdaterows));
		
		$('#myqueryfm').form('submit',{
			url: url,
			onSubmit: function(){ 
				// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
				var isValid = $(this).form('validate'); 
				if(!isValid){
					// 如果表单是无效的则隐藏进度条
					parent.$.messager.progress('close');	 
				}					
				return isValid;
	        },
	        success: function(result){
	        	parent.$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		//$("#saveBtn").linkbutton('disable');			 		
                    //mygridbatchdetail.datagrid('acceptChanges');
                    alert("批量保存成功！");
                    mygridbatchmain.datagrid('reload');
                    mygridbatchdetail.datagrid('loadData',{});			 		
             	} else {
             		alert("批量保存失败：" + result.msg);
               }
	        }    
		});		
	};
	
	function mydeleterow(){
		var row = mygridbatchdetail.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除该记录吗?',function(r) {
				if (r){
					if (row.hjhbid!=null && row.hjhbid!=""){
						$.post(basePath + 'tmsyjhtgl/delJinhuo', 
								{hjhbid: row.hjhbid},						
							function(result) {
								if (result.code == '0') {
									$.messager.alert('提示','删除成功！','info',function(){
										var indexdelete = mygridbatchdetail.datagrid('getRowIndex',mygridbatchdetail.datagrid('getSelected'));
										if(indexdelete == -1){
											alert("请先选择要删除的行！");
											return false;
										}
										mygridbatchdetail.datagrid('cancelEdit',indexdelete)
												.datagrid('deleteRow',indexdelete);
					        		});    	
								} else {
									$.messager.alert('提示', "删除失败：" + result.msg, 'error');
								}
							},
						'json');
					}else{
						var indexdelete = mygridbatchdetail.datagrid('getRowIndex',mygridbatchdetail.datagrid('getSelected'));
						if(indexdelete == -1){
							alert("请先选择要删除的行！");
							return false;
						}
						$.messager.alert('提示','删除成功！','info',function(){
							mygridbatchdetail.datagrid('cancelEdit',indexdelete)
									.datagrid('deleteRow',indexdelete);
		        		}); 
						//if(indexdelete-1>=0){
						//	v_datagrid.datagrid('selectRow',index-1);
						//}				
					}					
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}		
	};
	</script>
</head>

<body>
	<div class="easyui-layout" style="width: 98%;height:600px;">      
	    <form id="myqueryfm" method="post" >
	    <input type="hidden" id="batchjinhuoinsertrows" name="batchjinhuoinsertrows">
	    <input type="hidden" id="batchjinhuoupdaterows" name="batchjinhuoupdaterows">
	    <input type="hidden" id="jhplh" name="jhplh">
	    
        <div region="center" style="overflow: true;">
       		<div id="toolbarmain">
       		  <table style="width: 99%;height: 20px;">
       		    <tr>
       		       <td style="text-align: center;">
       		           <strong>批量进货批次信息【双击显示明细】</strong> 
       		       </td>
       		    </tr>
				<tr>
				  <td >
				   <nobr>操作开始时间</nobr>
				   <input id="aae036start" name="aae036start" style="width: 200px" 
				   class="easyui-datebox"/>
				   <nobr>操作结束时间</nobr>
					<input id="aae036end" name="aae036end" style="width: 200px" 
					   class="easyui-datebox"/>							   
					<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="myquery()"> 查 询 </a>							   					  
				  </td>
				</tr>
       		  </table>
       		</div>
       		<div id="mygridbatchmain" style="height:200px;overflow:auto;"></div>
	        <div id="toolbar">
	        		<table style="width: 99%;height: 40px;">
						<tr>
							<td colspan="3">
							<a href="javascript:void(0)" class="easyui-linkbutton" 
							    data=""
								iconCls="icon-add"  onclick="addJinhuo()">批量新增【根据历史进货】</a> 
							&nbsp;&nbsp;&nbsp;	
                               <a href="javascript:void(0)" class="easyui-linkbutton" 
							    data=""
								iconCls="icon-save"  onclick="mybatchAddSave()">批量新增保存</a>
								&nbsp;&nbsp;&nbsp;																	
								<a href="javascript:void(0)" class="easyui-linkbutton" 
								    data=""
									iconCls="icon-add"  onclick="appendDetailRow()">增加一行
								</a> 
								&nbsp;&nbsp;&nbsp;
                                <a href="javascript:void(0)" class="easyui-linkbutton" 
							    data=""
								iconCls="icon-ok"  onclick="endEditing()">行提交</a>
								&nbsp;&nbsp;&nbsp;	
                                <a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="icon-remove"  onclick="mydeleterow()">单行删除</a>
								&nbsp;&nbsp;&nbsp;
 						
							  <a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="ext-icon-rss_go" onclick="uploadJinhuopiao()">单行索证索票</a>
								&nbsp;&nbsp;&nbsp;
                              <a href="javascript:void(0)" class="easyui-linkbutton" data=""
								iconCls="ext-icon-photo"  onclick="uploadJiancepic()">单行检测图片上传</a>								
							</td>	
					    </tr>
					    <tr>
							<td style="color: blue;">
								根据前
								<input id="jhhisdays" name="jhhisdays" type="text" 
								class="easyui-numberbox" value="7" style="width: 30px;text-align: center;" 
								data-options="min:1,precision:0">
								天进货记录生成							  
							</td>									    
					      <td colspan="2" style="color: red;">
					        <strong>说明：(1)进货数量为空或0，保存时不处理。(2)【行提交】是提交到表格，真正提交需要点 【批量新增保存】</strong> 
					      </td>
							
					    </tr>
				</table>
			</div>	 
			<div id="mygridbatchdetail" style="height:350px;overflow:auto;"></div>	      						
        </div>
        </form>         
    </div>  
</body>
</html>