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
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
<title>doc模板导入</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var grid;
	$(function() {
		
	});
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 保存检查项目内容信息 
	var saveContent = function($dialog, $grid, $pjq) {
		var url = basePath + '/supervision/checkinfo/saveImportDoc';
		//提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$pjq.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}	
				return isValid;
	        },
	        success: function(result){
	        	$pjq.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$pjq.messager.alert('提示','保存成功！','info',function(){
	        			$grid.datagrid('load');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	};

	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	
</script>
<script type="text/javascript">
	var setting2 = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/supervision/checkinfo/queryItemZTreeAsync',  //调用后台的方法		     
		    autoParam: ["itemid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {						
				enable: true,
				idKey: "itemid",
				pIdKey: "itempid",
				rootPId: 0		
			},
			key: {
				name: "itemname"
			}
		},
		callback: {
			onClick: onClick2
		}
	};

	//单击节点事件
	function onClick2(event, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
		var nodes = zTree.getSelectedNodes();		
		$("#itemid").val(nodes[0].itemid);
		$("#itemname").val(nodes[0].itemname);
		hideMenu();		  
	}

	function showMenu() {
		var cityObj = $("#itemname");
		var cityOffset = $("#itemname").offset();
		$("#menuContent").css({
			left: cityOffset.left + "px",
			top: cityOffset.top + cityObj.outerHeight() + "px"
		}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
		queryItemCombotree();
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (! (event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
			hideMenu();
		}
	}

	function queryItemCombotree() { //初始化项目树下拉框
		$.fn.zTree.init($("#treeDemo2"), setting2);
	}

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.orgData);//获取后台传递的数据
	    if (!responseData) {
	    	for(var i =0; i < responseData.length; i++) {
	    		//将后台传过来的参数拼接成json格式，并放在数组中，如果有必要需要对其是否为父节点做处理
	    		array[i] = {
					id: responseData[i].itemid,
					name: responseData[i].itemname,
					isParent: false,
					itemdesc:itemdesc
				}; 
	      	}
	    }
	    return zNodes;
	}
	
	
	
</script>
</head>

<body>
	<form id="fm"   target="hideWin" enctype="multipart/form-data" method="post">
        	<sicp3:groupbox title="计划和类别关联">	
        		<table class="table" style="width: 99%;">
						<tr>
						<td style="text-align:right;"><nobr>检查表</nobr></td>										
						<td>
							<input name="itemname" id="itemname"  style="width: 260px; " onclick="showMenu();" 
							   readonly="readonly" class="input_readonly"/>
							<input name="itemid" id="itemid" hidden="true" style="width: 200px; " />							
						</td>
					</tr>	
					<tr>
						<td style="text-align:right;"><nobr>明细附件上传</nobr></td>
						<td><input   type="file"  name="file"  />
						
						</td>		
						
				</tr>	
				
				<tr>
						<td style="text-align:right;"><nobr>明细上传模板</nobr></td>
						<td><a href="<%=basePath %>jsp/supervision/importDoc/明细上传模板.doc"> 明细上传模板 </a> </td>		
						
				</tr>				
				</table>
				       </sicp3:groupbox>
	   </form>
	    <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
			<ul id="treeDemo2" class="ztree" style="margin-top:0px;width:205px;height:230px;"></ul>
		</div>      
</body>
</html>