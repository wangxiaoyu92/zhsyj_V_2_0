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
<title>法律法规类别管理</title>
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
				idKey: "flfglbid",
				pIdKey: "parentnode",
				rootPId: 0		
			},
			key: {
				name: "flfglbmc"
			}
		},
		callback: {
			onClick: onClick
		}
		
	};

	//单击节点事件
	function onClick(event, treeId, treeNode) {          
	    $('#fm').form('load',treeNode);//用节点数据填充form 		  
	}

	//刷新zTree
	function refreshZTree(){
		//初始化机构树
		$.post(basePath + '/flfg/queryPflfglbZTree', {}, function(result) {
			if (result.code == '0') {
				//准备zTree数据
				var zNodes = eval(result.flfglbData);
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
				
				cbt_parentnode = $('#parentnode').combotree({
					 url: basePath + '/flfg/queryPflfglbTree',   
					 required: true,
			         editable: false,
			         panelHeight: 250,
			         panelWidth: 280  
				});
				addPflfglb();//  	
			} else {
				$.messager.alert('提示', result.msg, 'error');
			}			
		}, 'json');		
	}	
</script>
<script type="text/javascript">
	//法律法规类别级别
	var flfglbjb = <%=SysmanageUtil.getAa10toJsonArray("FLFGLBJB")%>;
	var cb_flfglbjb;
	var cbt_parentnode;
	$(function() {
		refreshZTree();
	});
		
	function refresh(){
		parent.window.refresh();	
	} 
	//初始化下拉框、
	$(function(){
		//初始化下拉框
		cb_flfglbjb = $('#flfglbjb').combobox({
			data : flfglbjb,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight : 180,
			panelWidth : 280
	   });
	});
	
	//新增
	var addPflfglb = function() { 
	    $('#fm').form('clear');
	    $('#orderno').val('1'); 
	};

	//删除
	var delPflfglb = function() {		
		var flfglbid = $('#flfglbid').val();
		if(flfglbid != null && flfglbid != ''){
			var childnum = $('#childnum').val();
			var msg;
			if(childnum > 0){
				msg = "此类别为父级类别,如果删除，其所属的子类别也将全部被删除，确定要删除此类别吗？";
			}else{
				msg = "确定要删除此类别吗？";
			} 
			$.messager.confirm('警告',msg,function(r){
				 if (r) {
						$.post(basePath + '/flfg/delPflfglb', {flfglbid : flfglbid}, 
							function(result){
							 	if (result.code=='0'){
							 		$.messager.alert('提示','删除成功！','info',function(){
							 			//刷新左侧的树
							 			refreshZTree();   
					        		});    
		                      	} else {
		                      		$.messager.alert('提示','删除失败：'+result.msg,'error');
		                        }
		                   }, 'json');
				}
			 });
		}else{
			$.messager.alert('提示','没有选择法律类别数据，无法删除！','info');
		}
	};

	//保存
	var savePflfglb = function(){ 
	    $('#fm').form('submit',{  
	    	url : basePath + '/flfg/savePflfglb',  
	        onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				return isValid;	
	        },  
	        success: function(result){ 
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
	        		$.messager.alert('提示','保存成功！','info',function(){
	                	//刷新左侧的树
		                refreshZTree();   
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败！'+result.msg,'error');
                }
	        }  
	    });  
	};
	
</script>
</head>
<body>
<div class="easyui-layout" fit="true">   
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>    
        <div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="法律法规类别信息">    
	        <form id="fm" name="fm" method="post">		
				<table class="table" style="width: 80%;">
					<tr>
						<td style="text-align:right;"><nobr>法律法规类别ID</nobr></td>
						<td><input id="flfglbid" name="flfglbid" style="width: 200px;" readonly="readonly" class="input_readonly" /></td>	
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>法律类别级别</nobr></td>
						<td><input name="flfglbjb" id="flfglbjb"  style="width: 200px;" class="easyui-combobox" data-options="validType:'comboboxNoEmpty'" /></td>					
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>法律类别编码</nobr></td>
						<td><input name="flfglbbm" id="flfglbbm" style="width: 200px;" type="text" style="width: 200px;" class="easyui-validatebox" data-options="required:true"/></td>					
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>法律类别名称</nobr></td>
						<td><input name="flfglbmc" id="flfglbmc" style="width: 200px;" style="width: 200px;" class="easyui-validatebox" data-options="required:true"/></td>					
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>父类别ID</nobr></td>
						<td><input id="parentnode" name="parentnode" style="width: 200px;" style="width: 200px;"/></td>					
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>子类别个数</nobr></td>
						<td><input name="childnum" id="childnum" type="text" style="width: 200px;" readonly="readonly" class="input_readonly"/></td>
					</tr>
					<input id="orderno" name="orderno" type="hidden" style="width: 200px;" value="1"/>
				</table>
			</form>
			<br/>
	        <div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_savePflfglb"
					iconCls="icon-add" onclick="addPflfglb()">新增</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delPflfglb"
					iconCls="icon-cancel" onclick="delPflfglb()">删除</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_savePflfglb"
					iconCls="icon-save" onclick="savePflfglb()">保存 </a>
	        </div>
	        </sicp3:groupbox>
        </div>        
    </div>    

</body>
</html>