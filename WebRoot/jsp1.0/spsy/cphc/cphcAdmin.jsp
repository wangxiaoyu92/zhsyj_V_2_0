<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();	
	String v_procomid = sysuser.getAaz001();
%>
<!DOCTYPE html>
<html>
<head>
<title>企业产品耗材管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
// 生产单位代码
var v_CPPCSCDWDM = <%=SysmanageUtil.getAa10toJsonArray("CPPCSCDWDM")%>;
// 溯源码生成标志
var v_CPPCSYMSCBZ = <%=SysmanageUtil.getAa10toJsonArray("CPPCSYMSCBZ")%>;

	$(function() { 
		$('#tabcppc').datagrid({
		    title:'产品批次',
		    iconCls:'icon-ok',
		    width:900,
		    height:260,
		    pageSize:10,
		    pageList:[10,20,30],
		    nowrap:true,//True 就会把数据显示在一行里
		    striped:true,//奇偶行使用不同背景色
		    collapsible:true,
		    singleSelect:true,//True 就会只允许选中一行
		    fitColumns: true,
		    fit:false,//让DATAGRID自适应其父容器
		    fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
		    pagination:true,//底部显示分页栏
		    rownumbers:true,//是否显示行号
		    url:'<%=basePath%>spsy/cphc/queryCppc',
		    queryParams:{
		    	procomid:'<%=v_procomid%>'
		    },
		    loadMsg:'数据加载中,请稍后...',   
		    //sortName:'code',
		    sortOrder:'desc',
		    remoteSort:false,
		    onClickRow:function(rowIndex,rowData){
		    	queryCphc(rowData);
		    },
		    columns:[[
		    
		        {title:'产品批次id',field:'cppcid',align:'center',width:100,hidden:'true'},
                {title:'产品id',field:'procomid',align:'center',width:100,hidden:'true'},
				{title:'产品id',field:'proid',align:'center',width:100,hidden:'true'},
				{title:'产品名称',field:'proname',align:'center',width:100},	
				{title:'批次号',field:'cppcpch',align:'left',width:120},
				{title:'生产日期',field:'cppcscrq',align:'left',width:120},
				{title:'生产数量',field:'cppcscsl',align:'left',width:80},
				{title:'生产单位',field:'cppcscdwdm',align:'left',
					formatter : function(value, row) {
						return sy.formatGridCode(v_CPPCSCDWDM,value);
					}					
				},
				{title:'溯源码生成标志',field:'cppcsymscbz',align:'left',
					formatter : function(value, row) {
						return sy.formatGridCode(v_CPPCSYMSCBZ,value);
					}					
				}
			]]
		   }); 
		
		$('#tabcppchc').datagrid({
		    title:'产品批次耗材列表',
		    iconCls:'icon-ok',
		    width:900,
		    height:300,
		    pageSize:10,
		    pageList:[10,20,30],
		    nowrap:true,//True 就会把数据显示在一行里
		    striped:true,//奇偶行使用不同背景色
		    collapsible:true,
		    singleSelect:true,//True 就会只允许选中一行
		    fitColumns: true,
		    fit:false,//让DATAGRID自适应其父容器
		    fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
		    pagination:true,//底部显示分页栏
		    rownumbers:true,//是否显示行号
		    url:'',
		    loadMsg:'数据加载中,请稍后...',   
		    //sortName:'code',
		    sortOrder:'desc',
		    remoteSort:false,
		    columns:[[
                {title:'产品材料使用记录表ID',field:'qproductclsyjlbid',align:'center',width:100,hidden:'true'},      
				{title:'产品材料id',field:'cpclid',align:'center',width:100,hidden:'true'},
				{title:'产品材料名称',field:'cpclname',align:'center',width:150},	
				{title:'产品材料进货台账ID',field:'qledgerstockid',align:'left',width:200},
				{title:'产品材料消耗数量',field:'cpclsysl',align:'left',width:150},
				{title:'产品材料单位',field:'cpcldw',align:'left',width:90},
				{field:'opt',title:'操作',align:'center',width:150,
		              formatter:function(value,rec){ 
						  var v_ret = '<a href="javascript:deleteCphc(\''+rec.qproductclsyjlbid+'\')" mce_href="#">'
						  	+'<img src="<%=basePath%>images/pub/delete.gif" align="absmiddle">删除</a> </span>';
		                  return  v_ret; 
		             }   
		        } 				
			]],
		     //工具栏
		     toolbar:[{
		          id:'btnadd',
		          text:'添加',
		          iconCls:'icon-add',
		          handler:function(){
		             addData();
		           }}
		        ]
		   });		
		
	});/////////////////////////////////////// 
	
	//删除附件
	function deleteCphc(v_qproductclsyjlbid){
		if ((v_qproductclsyjlbid==null) || (v_qproductclsyjlbid=="") || (v_qproductclsyjlbid.length==0)){
	    	alert("请选择要删除的记录");
	    	return false;
	  	}
	  
		var cfmMsg= "确定删除此条记录吗?";
	 	$.messager.confirm('确认', cfmMsg, function (r) {
	    	if(r){
				$.ajax({
		    		url: basePath+'/spsy/cphc/delCphc',
		    		type: 'post',
		    		async: true,
		    		cache: false,
		    		timeout: 100000,
		    		data: 'qproductclsyjlbid=' + v_qproductclsyjlbid,
		    		dataType: 'json',
		    		error: function() {
		    			$.messager.alert('提示','服务器繁忙，请稍后再试！','info');				
		    		},
		    		success: function(result){
		    			if (result.code=='0'){	
			        		$.messager.alert('提示','删除成功','info',function(){
			        			$("#tabcppchc").datagrid("reload");
			                }); 	                        
		              	} else {
		              		$.messager.alert('提示','删除失败:'+result.msg,'error');
		                }
			        }  
				});
	    	}
		 });
	}	
	
	function queryCphc(v_rowdata) {
		if (v_rowdata.procomid==null){
			$.messager.alert('提示', '请先选择产品批次信息！', 'info');
			return;
		};

		var param = {
			'procomid': v_rowdata.procomid,
			'proid': v_rowdata.proid,
			'cppcid':v_rowdata.cppcid
		};
		$('#tabcppchc').datagrid({
			url:basePath +'/spsy/cphc/queryCphc',			
			queryParams : param
		});
		$('#tabcppchc').datagrid('clearSelections');  			
	}
	
	// 新增
	var addData = function() {		
		var row = $('#tabcppc').datagrid('getSelected');
		if (row) {
			var url = basePath + 'spsy/cphc/cphcAddIndex';
			var dialog = parent.sy.modalDialog({
					title : '添加',
					param : {
						procomid : row.procomid,
						proid : row.proid,
						cppcid : row.cppcid
					},
					width : 950,
					height : 580,
					url : url
			}, closeModalDialogCallback); 
		} else {
			$.messager.alert('提示', '请先选择产品批次记录！', 'info');
			return;
		}
	};
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		$("#tabcppchc").datagrid("reload");
		sy.removeWinRet(dialogID);//不可缺少		
	}
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
           <table id="tabcppc" style="width:90%;height:100%;" ></table>
           <table id="tabcppchc" style="width:90%;height:100%;" ></table>
        </div>           
	</div> 
</body>
</html>