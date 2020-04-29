<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() 
		 	+ ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>市场管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree2.jsp"></jsp:include>
<script type="text/javascript">
	var url = basePath + '/tmcsc/scfqHsh/queryScfq';
	var ztree;
	var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: url,  //调用后台的方法		     
		    autoParam: ["pscfqid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {						
				enable: true,
				idKey: "pscfqid",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "scfqmc"
			}
		},
		callback: {
			onClick: onClick
		}
	};
	
	$(function() { 
		refreshZTree();	
	}); 
	
	//初始化zTree树
	function refreshZTree(){
		ztree = $.fn.zTree.init($("#myTree"), setting);
	}

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var zNodes = eval(responseData.orgData);//获取后台传递的数据
	    return zNodes;
	}
		
	function onClick(e, treeId, treeNode) {
		//if(treeNode.childnum == 0){
			grid.datagrid({
				url : basePath + '/tmcsc/scfqHsh/querySh',			
				queryParams : {'pscfqid':treeNode.pscfqid}
			});
			grid.datagrid('unselectAll');
			/* $('#fm').form('load',treeNode);//用节点数据填充form
			var zTree = $.fn.zTree.getZTreeObj("myTree");
			var nodes = zTree.getSelectedNodes();		
			$("#parent").val(nodes[0].parent);
			$("#parentname").val(nodes[0].parentname); */ 	
		//}//alert(treeNode.childnum)
	}
</script> 
<script type="text/javascript">
	 /*  function refresh(){
		parent.window.refresh();	
	}   */
	 var grid;
	 $(function  (){  	
  		grid=$("#grid").datagrid({
	   	// title:'采集信息查询',
	    //url: basePath +"/tmcsc/cdgl/QueryCd", 
    	iconCls:'icon-ok',
    	height:560,
    	pageSize:10,
    	pageList:[10,20,30],
    	nowrap:true,//True 就会把数据显示在一行里
    	striped:true,//奇偶行使用不同背景色
    	collapsible:true,
    	singleSelect:true,//True 就会只允许选中一行
    	fit:false,//让DATAGRID自适应其父容器
    	fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
    	pagination:true,//底部显示分页栏
    	rownumbers:true,//是否显示行号
    	idField: 'pshid', //该列是一个唯一列
    	loadMsg:'数据加载中,请稍后...',
        columns:[[
        {
          title:'市场分区id',
          field:'pscfqid',
          align:'left',
          width:100,
          hidden : true
          },{
          title:'商户id',
          field:'pshid',
          align:'left',
          width:100,
          hidden : true 
          },{ 
          title:'企业id',
          field:'comid',
          align:'left',
          width:100,
          hidden : true 
          },{
              title:'商户系统登录账号',
              field:'shusername',
              align:'left',
              width:100,
              hidden : false 
          },{
          title:'企业名称',
          field:'commc',
          align:'left',
          width:100  
          },{ 
          title:'市场名称',
          field:'parentname',
          align:'left',
          width:100 
          },{
          title:'商户摊位号',
          field:'shtwh',
          align:'left',
          width:100  
          },{
          title:'商户名称',
          field:'shmc',
          align:'left',
          width:100 
          },{
          title:'商户简称',
          field:'shjc',
          align:'left',
          width:100 
          },{
          title:'商户联系人',
          field:'shlxr',
          align:'left',
          width:100
          },{
          title:'商户移动电话',
          field:'shyddh',
          align:'left',
          width:100 
          },{
          title:'商户固定电话',
          field:'shgddh',
          align:'left',
          width:100  
          },{
          title:'商户通讯地址',
          field:'shtxdz',
          align:'left',
          width:100
          },{
          title:'商户身份证号',
          field:'shsfzh',
          align:'left',
          width:100  
          },{
          title:'商户资质证明',
          field:'shzzzmmcinfo',
          align:'left',
          width:100  
          },{
          title:'商户资质证明编号',
          field:'shzzzmbh',
          align:'left',
          width:100   
          }  
        ]]
     }); 
   })
	var addSh = function(){
   		var dialog =  parent.sy.modalDialog({
			title : '添加商户',
			width : 780,
			height : 560,
			url : basePath + '/tmcsc/scfqHsh/shFromIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};
	//编辑商户
	 var editSh=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '编辑洗消记录',
			width : 780,
			height : 560,
			url : basePath + '/tmcsc/scfqHsh/shFromIndex?pshid='+row.pshid,
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
		}else{
			$.messager.alert('提示', '请先选择要查看的信息！', 'info');
		}
	};
	//查看商户
	 var showSh=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '编辑洗消记录',
			width : 780,
			height : 560,
			url : basePath + '/tmcsc/scfqHsh/shFromIndex?op=show&pshid='+row.pshid,
			buttons : [ {
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
		}else{
			$.messager.alert('提示', '请先选择要查看的信息！', 'info');
		}
	};
	//删除商户
    var delSh=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	   // var id = row.hcyjxxjlid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'tmcsc/scfqHsh/delSh', {
						 pshid: row.pshid
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
			$.messager.alert('提示', '请先选择要检查的企业！', 'info');
		}
	};
</script>
</head>
<body>
<div class="easyui-layout" fit="true">   
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="myTree" class="ztree" ></ul>       
        </div>   
        <div region="center" style="overflow: true;" id="toolbar">
		<sicp3:groupbox title="商户列表">
			<table> 
				<tr>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_shMainIndex" iconCls="icon-add" plain="true"
						onclick="addSh()">增加</a></td>
					<td>
					<div class="datagrid-btn-separator"></div></td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_archiveFormIndex" iconCls="icon-edit" plain="true"
						onclick="editSh()" id="btn_shMainIndex">编辑</a></td>
					<td>
					<div class="datagrid-btn-separator"></div></td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						id="btn_archiveFormIndex" name="btn_archiveFormIndex" data="btn_shMainIndex"
						iconCls="ext-icon-application_form_magnify" plain="true" onclick="showSh()">查看</a>
					</td>
					<td>
					<div class="datagrid-btn-separator"></div> 
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						id="btn_delArchive" name="btn_delArchive" data="btn_shMainIndex"
						iconCls="icon-remove" plain="true" onclick="delSh()">删除</a></td>
					<td>
					<div class="datagrid-btn-separator"></div>
					</td>  
				</tr>
			</table>
	        <div id="grid"></div>
		</sicp3:groupbox>
	</div> 
    </div>    	
</body>
</html>