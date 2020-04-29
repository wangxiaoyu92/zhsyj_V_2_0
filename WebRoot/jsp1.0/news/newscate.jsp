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
<title>新闻分类管理</title>
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
				idKey: "cateid",
				pIdKey: "cateparentid",
				rootPId: 0		
			},
			key: {
				name: "catename"
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
		//初始化机构树
		$.post(basePath + '/newscate/queryNewcateZTree', {}, function(result) {
			if (result.code == '0') {
				//准备zTree数据
				var zNodes = eval(result.mydata);
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);

				cbt_parent = $('#cateparentid').combotree({
					 url: basePath + '/newscate/queryNewscateTree',   
					 required: fasle,
			         editable: false,
			         panelHeight: 250,
			         panelWidth: 280  
				});
				addNewsCate();//  	
			} else {
				$.messager.alert('提示', result.msg, 'error');
			}			
		}, 'json');		
	}

	//单击节点事件
	function onClick(event, treeId, treeNode) {          
	    $('#fm').form('load',treeNode);//用节点数据填充form 		  
	}
		
</script>
<script type="text/javascript">
	var cbt_parent;

	function refresh(){
		parent.window.refresh();	
	} 

	 // 新增
	function addNewsCate() {
		$('#fm').form('clear');
	} 

	// 删除
	function delNewsCate() {
		var cateid = $('#cateid').val();
		$.messager.confirm('警告', '您确定要删除该新闻分类吗，这将删除对应所属的新闻，且不可恢复！',function(r) {
			if (r) {
				$.post(basePath + '/newscate/delNewsCate', {
					cateid : cateid
				},
				function(result) {
					if (result.code == '0') {	
						$.messager.alert('提示','删除成功！','info',function(){
							//刷新左侧的树
				 			refreshZTree();   
		        		}); 
					} else {
						$.messager.alert('提示', "删除失败：" + result.msg, 'error');
					}
				},
				'json');
			}
		});
	}  

	// 保存
	function saveNewsCate() {
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: basePath + '/newscate/saveNewsCate',
			onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
		    	if(!isValid){
					$.messager.progress('close');
				}
				return isValid;	
	        },
	        success: function(result){ 
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$.messager.progress('close');
	        		$.messager.alert('提示','保存成功！','info',function(){	
	        			//刷新左侧的树
		                refreshZTree();
	        		}); 	                        	                     
              	} else {
              		$.messager.progress('close');
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	} 

</script>
</head>
<body>
<div class="easyui-layout" fit="true">   
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>    
        <div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="新闻分类信息"> 
	        <form id="fm" name="fm" method="post">	
        		<table class="table" style="width: 80%;">
					<tr>
						<td style="text-align:right;"><nobr>新闻分类ID:</nobr></td>
						<td><input id="cateid" name="cateid" style="width: 200px;" readonly="readonly" class="input_readonly" /></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>新闻分类名称:</nobr></td>
						<td><input id="catename" name="catename" style="width: 200px;" class="easyui-validatebox" data-options="required:true" /></td>						
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr>新闻分类简称:</nobr></td>
						<td><input id="catejc" name="catejc" style="width: 200px;" class="easyui-validatebox" data-options="required:true" /></td>		
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>父级分类</nobr></td>
						<td><input id="cateparentid" name="cateparentid" style="width: 200px;"/></td>					
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>新闻分类级别</nobr></td>
						<td><input id="catelevel" name="catelevel" style="width: 200px;"/></td>					
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>是否允许添加新闻</nobr></td>
						<td><input id="catesfyxtjxw" name="catesfyxtjxw" style="width: 200px;" /></td>
					</tr>					
				</table>
			</form>
			<br/>
	        <div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveNewsCate"
					iconCls="icon-add" onclick="addNewsCate()">新增</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delNewsCate"
					iconCls="icon-cancel" onclick="delNewsCate()">删除</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveNewsCate"
					iconCls="icon-save" onclick="saveNewsCate()">保存 </a>
	        </div>
	        </sicp3:groupbox>
        </div>        
    </div>		
</body>
</html>