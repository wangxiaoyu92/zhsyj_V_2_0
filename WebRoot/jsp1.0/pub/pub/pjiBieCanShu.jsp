<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	String v_aaa100=StringHelper.showNull2Empty(request.getParameter("aaa100"));
%>
<!DOCTYPE html>
<html>
<head>
<title>新闻分类管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
var treeObj;
var cbt_parent;
var v_SFYX = <%=SysmanageUtil.getAa10toJsonArray("SFYX")%>;

	var setting = {
		view: {
			showLine: true
		},	
		data: {
			simpleData: {						
				enable: true,
				idKey: "aaa102",
				pIdKey: "aaa104",
				rootPId: 0		
			},
			key: {
				name: "aaa103"
			}
		},
		callback: {
			onClick: onClick
		}
		
	};

	$(function() { 
		refreshZTree();	
	   $('#aaa104').combotree({
		   url: basePath + '/pub/pub/queryJiBieCanShuTree?aaa100=<%=v_aaa100%>', 
		    required: true
		});
	   
	    $('#aaa105').combobox({
	    	data : v_SFYX,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    
	}); 
	
	//初始化zTree树
	function refreshZTree(){
		//初始化机构树
		$.post(basePath + '/pub/pub/queryJiBieCanShuZTree?aaa100=<%=v_aaa100%>', {}, function(result) {
			if (result.code == '0') {
				//准备zTree数据
				var zNodes = eval(result.mydata);
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
				
				treeObj = $.fn.zTree.getZTreeObj("treeDemo"); 
				//treeObj.expandAll(true); 				
				//addNewsCate();//  	
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
	function addCate() {
		$('#fm').form('clear');
/* 		$('#aaz093').val('');
		$('#aaa102').val('');
		$('#aaa103').val('');
		$('#aaa104').combotree('setValue',''); */
		$('#aaa105').combobox('setValue','1');
		$('#aaa100').val('<%=v_aaa100%>');
	} 

	// 删除
	function delCate() {
		var v_aaz093 = $('#aaz093').val();
		if (v_aaz093==null || v_aaz093=="") {
			alert('请选择要删除的分类');
			return false;
		}
		$.messager.confirm('警告', '您确定要删除该分类吗！',function(r) {
			if (r) {
				$.post(basePath + '/pub/pub/delJiBieCanShu', {
					aaz093 : v_aaz093,
					aaa100 :'<%=v_aaa100%>'
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
	function saveCate() {
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: basePath + '/pub/pub/saveJiBieCanShu',
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
        	<sicp3:groupbox title="分类信息"> 
	        <form id="fm" name="fm" method="post">	
	           <input type="hidden" id="aaa101" name="aaa101">
	           <input type="hidden" id="aaz094" name="aaz094">
	           <input type="hidden" id="aaa106" name="aaa106">
	           <input type="hidden" id="aaa107" name="aaa107">
	           <input type="hidden" id="aae011" name="aae011">
	           <input type="hidden" id="aae036" name="aae036">
	           
	           <input type="hidden" id="aaa100" name="aaa100" value="<%=v_aaa100%>">
        		<table class="table" style="width: 80%;">
					<tr>
						<td style="text-align:right;"><nobr>级别参数表id:</nobr></td>
						<td><input id="aaz093" name="aaz093" style="width: 200px;" readonly="readonly" class="input_readonly" /></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>级别参数编码:</nobr></td>
						<td><input id="aaa102" name="aaa102" style="width: 200px;" class="easyui-validatebox" data-options="required:true" /></td>						
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr>级别参数名称:</nobr></td>
						<td><input id="aaa103" name="aaa103" style="width: 200px;" class="easyui-validatebox" data-options="required:true" /></td>		
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>父级分类</nobr></td>
						<td><input class="easyui-combotree" id="aaa104" name="aaa104" style="width: 200px;"/></td>					
					</tr>							
					<tr>
						<td style="text-align:right;"><nobr>是否启用</nobr></td>
						<td><input id="aaa105" name="aaa105" style="width: 200px;" /></td>
					</tr>					
				</table>
			</form>
			<br/>
	        <div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveNewsCate"
					iconCls="icon-add" onclick="addCate()">新增</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delNewsCate"
					iconCls="icon-cancel" onclick="delCate()">删除</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveNewsCate"
					iconCls="icon-save" onclick="saveCate()">保存 </a>
	        </div>
	        </sicp3:groupbox>
        </div>        
    </div>		
</body>
</html>