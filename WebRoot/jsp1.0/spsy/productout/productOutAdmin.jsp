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
	String v_comtree = (null == request.getAttribute("comtree") ? "" : request.getAttribute("comtree").toString());
%>
<!DOCTYPE html>
<html>
<head>
<title>范围外企业产品管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
var setting = {
		view: {
			showLine: true
		},
		data: {
			simpleData: {
				enable: true,
				idKey: "comid",
				pIdKey: "parentid",
				rootPId: 0
			},
			key:{
				name:"commc"
			}
		},
		callback: {
			onClick: onClick
		}
	};

	var zNodes=<%=v_comtree%>;
	
	$(function() { 
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		
		$('#mytab').datagrid({
		    title:'范围外企业产品管理',
		    iconCls:'icon-ok',
		    width:900,
		    height:450,
		    pageSize:20,
		    pageList:[10,15,20],
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
				{title:'产品id',field:'proid',align:'center',width:100,hidden:'true'},
				{title:'产品id',field:'procomid',align:'center',width:100,hidden:'true'},	
				{title:'产品名称',field:'proname',align:'left',width:200},
				{title:'商品条码',field:'prosptm',align:'left',width:110},
				{title:'品名',field:'propm',align:'left',width:100},
				{title:'规格型号',field:'progg',align:'left',width:80},
				{title:'保质期单位代码',field:'probzqdwCode',align:'left',hidden:'true'},
				{title:'保质期单位名称',field:'probzqdwMc',align:'left',hidden:'true'},
				{title:'保质期',field:'probzq',align:'left',width:100,
						formatter:function(value,rec){
					       if(rec.probzqdwmc=='月'){
						  		return value+'个'+rec.probzqdwmc;
					       }else{
					       		return value+rec.probzqdwmc;
						   }
					}
				},
				{title:'产地/基地名称',field:'procdjd',align:'left',width:150},
				{title:'配料信息',field:'proplxx',align:'left',width:100},
				{title:'包装规格',field:'probzgg',align:'left',width:80},
				{title:'生产厂家',field:'prosccj',align:'left',width:150},
				{title:'厂家地址',field:'procjdz',align:'left',width:80},
				{title:'厂家电话',field:'procjdh',align:'left',width:80},
				{title:'商品所属公司',field:'comid',align:'left',width:80,hidden:'true'}
			]],
		     onDblClickRow:function(){//双击事件 查看、修改等操作
		        var selected = $('#mytab').datagrid('getSelected');
					if(selected){
					  editData();
					}
		     },
		     //工具栏
		     toolbar:[{
		          id:'btnadd',
		          text:'添加新产品',
		          iconCls:'icon-add',
		          handler:function(){
		             addData();
		           }}, {id:'btnedit',
			          text:'编辑新产品',
			          iconCls:'icon-edit',
			          handler:function(){
			             editData();
			           }}
		           , {id:'btndelete',
				          text:'删除产品',
				          iconCls:'icon-delete',
				          handler:function(){
				             deleteData();
				           }}		           
		        ]
		   }); 
		
	}); 
	

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.ComoutData);//获取后台传递的数据
	    return zNodes;
	}
	
	//单击节点事件
	function onClick(event, treeId, treeNode) { 
		$("#procomid").val(treeNode.comid);
		$("#mytab").datagrid({
			url:'<%=basePath%>spsy/productout/queryQproductout',			
			queryParams : {'procomid':treeNode.comid}
		});
		$("#mytab").datagrid('unselectAll'); 		  
	}
	
	//添加
	function addData(){
		var v_procomid=$("#procomid").val();
		if(v_procomid.length==0){
			alert('请从左边范围外企业列表中选择一个企业！');
			return false;
		}else{
			var url = basePath + 'jsp/spsy/productout/productOutAdd.jsp';
			var dialog = parent.sy.modalDialog({
					title : '添加',
					param : {
						procomid : v_procomid
					},
					width : 800,
					height : 555,
					url : url
			},closeModalDialogCallback); 
		}
	}
	
	//添加
	function editData(){
		var row = $('#mytab').datagrid('getSelected');
		if (row) {
			var url = basePath + 'jsp/spsy/productout/productOutAdd.jsp';
			var dialog = parent.sy.modalDialog({
					title : '修改',
					param : {
						procomid : row.procomid,
						proid : row.proid
					},
					width : 800,
					height : 550,
					url : url
			},closeModalDialogCallback); 
		}else{
			$.messager.alert('提示', '请先选择要修改的信息！', 'info');
		}
	}	
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		if(obj.type=='ok'){
			$('#mytab').datagrid('reload'); 
		}
		sy.removeWinRet(dialogID);//不可缺少		
	}
	//删除
	function deleteData(){
		var row = $('#mytab').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除吗?',function(r) {
				if (r) {
					$.post('<%=basePath%>spsy/productout/delProductout', {
						proid: row.proid,
						procomid:row.procomid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#mytab').datagrid('reload'); 
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
	
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">
	    <input type="hidden" name="procomid" id="procomid">
	    
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>
        <div region="center" style="overflow: true;" border="false">
           <table id="mytab" style="width:90%;height:100%;" ></table>
        </div>           

	
		<div id="dlg3" class="easyui-dialog" style="width:400px;height:300px;padding:10px 10px;"
			closed="true" closeable="true" buttons="#dlg3-buttons" modal="true">
		   <div id="dlg3-buttons">
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveLockSysuser();">确定</a>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg3').dialog('close')">取消</a>
			</div>
		</div>
	</div> 
</body>
</html>